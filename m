Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84C29E151
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Oct 2020 03:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ2CAE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Oct 2020 22:00:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34972 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgJ2B6d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2020 21:58:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09T1wOtV5003030, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09T1wOtV5003030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Oct 2020 09:58:25 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Thu, 29 Oct 2020
 09:58:24 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH v3 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Date:   Thu, 29 Oct 2020 09:58:23 +0800
Message-ID: <1603936703-3403-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
1.RTS5261 work in SD mode and set MMC_CAPS2_SD_EXP flag.
2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.
3.If the card has PCIe availability and WP is not set, init_sd_express() will be invoked,
RTS5261 switch to PCIe/NVMe mode.
4.Mmc driver handover it to NVMe driver.
5.If card is unplugged, RTS5261 will switch to SD mode.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
v2:
1.re-enable mmc caps in sd_power_on()
2.don't check write protect bit in init_sd_express()
v3:
1.add comment write protect switch is needed
2.add host->eject = true in the end of init_sd_express()
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 2763a376b054..3b6474cce703 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
 static int sd_power_on(struct realtek_pci_sdmmc *host)
 {
 	struct rtsx_pcr *pcr = host->pcr;
+	struct mmc_host *mmc = host->mmc;
 	int err;
+	u32 val;
 
 	if (host->power_state == SDMMC_POWER_ON)
 		return 0;
@@ -922,6 +924,21 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	if (err < 0)
 		return err;
 
+	if (PCI_PID(pcr) == PID_5261) {
+		if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+			mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
+		/*
+		 * HW read wp status when resuming from S3/S4,
+		 * and then picks SD legacy interface if it's set
+		 * in read-only mode.
+		 */
+		val = rtsx_pci_readl(pcr, RTSX_BIPR);
+		if (val & SD_WRITE_PROTECT) {
+			pcr->extra_caps &= ~EXTRA_CAPS_SD_EXPRESS;
+			mmc->caps2 &= ~(MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V);
+		}
+	}
+
 	host->power_state = SDMMC_POWER_ON;
 	return 0;
 }
@@ -1308,6 +1325,44 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
+static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	u32 relink_time;
+	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
+	struct rtsx_pcr *pcr = host->pcr;
+
+	/* Set relink_time for changing to PCIe card */
+	relink_time = 0x8FFF;
+
+	rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
+	rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
+	rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
+
+	rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
+	rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
+		RTS5261_LDO1_OCP_THD_MASK,
+		pcr->option.sd_800mA_ocp_thd);
+
+	if (pcr->ops->disable_auto_blink)
+		pcr->ops->disable_auto_blink(pcr);
+
+	/* For PCIe/NVMe mode can't enter delink issue */
+	pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
+	rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
+
+	rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
+		RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
+	rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
+		RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+	rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+		RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
+		| RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
+		RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
+		| RTS5261_DRIVER_ENABLE_FW);
+	host->eject = true;
+	return 0;
+}
+
 static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.pre_req = sdmmc_pre_req,
 	.post_req = sdmmc_post_req,
@@ -1317,6 +1372,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.get_cd = sdmmc_get_cd,
 	.start_signal_voltage_switch = sdmmc_switch_voltage,
 	.execute_tuning = sdmmc_execute_tuning,
+	.init_sd_express = sdmmc_init_sd_express,
 };
 
 static void init_extra_caps(struct realtek_pci_sdmmc *host)
@@ -1338,6 +1394,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
 	if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
 		mmc->caps2 |= MMC_CAP2_NO_MMC;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
-- 
2.17.1

