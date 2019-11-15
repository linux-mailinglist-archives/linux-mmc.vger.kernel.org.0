Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1AFDC29
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKOLUe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:20:34 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33548 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKOLUe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:20:34 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8DB5200066;
        Fri, 15 Nov 2019 12:20:31 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C695200049;
        Fri, 15 Nov 2019 12:20:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B353F402F8;
        Fri, 15 Nov 2019 19:20:21 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 10/14] mmc: sdhci-esdhc-imx: optimize the clock setting
Date:   Fri, 15 Nov 2019 19:18:29 +0800
Message-Id: <1573816712-26841-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When force clock off, check the SDOFF of register PRSSTAT to make sure
the clock is gate off. Before force clock on, check the SDSTB of register
PRSSTAT to make sure the clock is stable, this will eliminate the clock
glitch.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 24 +++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2ed945f5c259..0667b6903708 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -313,6 +314,17 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
 }
 
+static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
+{
+	u32 present_state;
+	int ret;
+
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, present_state,
+				(present_state & ESDHC_CLOCK_GATE_OFF), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us!.\n", __func__);
+}
+
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -526,6 +538,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		else
 			new_val &= ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (!(new_val & ESDHC_VENDOR_SPEC_FRC_SDCLK_ON))
+			esdhc_wait_for_card_clock_gate_off(host);
 		return;
 	case SDHCI_HOST_CONTROL2:
 		new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -754,12 +768,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
 	int pre_div = 1;
 	int div = 1;
+	int ret;
 	u32 temp, val;
 
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
+		esdhc_wait_for_card_clock_gate_off(host);
 	}
 
 	if (clock == 0) {
@@ -814,13 +830,18 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
+	/* need to wait the bit 3 of the PRSSTAT to be set, make sure card clock is stable */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, temp,
+				(temp & ESDHC_CLOCK_STABLE), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "card clock still not stable in 100us!.\n");
+
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
 
-	mdelay(1);
 }
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
@@ -1005,6 +1026,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
 		~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 		host->ioaddr + ESDHC_VENDOR_SPEC);
+	esdhc_wait_for_card_clock_gate_off(host);
 
 	/* force a reset on strobe dll */
 	writel(ESDHC_STROBE_DLL_CTRL_RESET,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 9289bb4d633e..947212f16bc6 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -31,6 +31,7 @@
 
 /* Present State Register */
 #define ESDHC_PRSSTAT			0x24
+#define ESDHC_CLOCK_GATE_OFF		0x00000080
 #define ESDHC_CLOCK_STABLE		0x00000008
 
 /* Protocol Control Register */
-- 
2.17.1

