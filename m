Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D78FDC27
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKOLUd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:20:33 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33524 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLUd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:20:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86EAC200101;
        Fri, 15 Nov 2019 12:20:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 46E37200066;
        Fri, 15 Nov 2019 12:20:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AEAB7402F1;
        Fri, 15 Nov 2019 19:20:20 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 09/14] mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
Date:   Fri, 15 Nov 2019 19:18:28 +0800
Message-Id: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

strobe-dll-delay-target is the delay cell add on the strobe line.
Strobe line the the uSDHC loopback read clock which is use in HS400
mode. Different strobe-dll-delay-target may need to set for different
board/SoC. If this delay cell is not set to an appropriate value,
we may see some read operation meet CRC error after HS400 mode select
which already pass the tuning.

This patch add the strobe-dll-delay-target setting in driver, so that
user can easily config this delay cell in dts file.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 12 +++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 448b29b2da62..2ed945f5c259 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -73,6 +73,7 @@
 #define ESDHC_STROBE_DLL_CTRL		0x70
 #define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
 #define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
+#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT	0x7
 #define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
 #define ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT	(4 << 20)
 
@@ -995,6 +996,9 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
  */
 static void esdhc_set_strobe_dll(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 strobe_delay;
 	u32 v;
 
 	/* disable clock before enabling strobe dll */
@@ -1012,9 +1016,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	 * enable strobe dll ctrl and adjust the delay target
 	 * for the uSDHC loopback read clock
 	 */
+	if (imx_data->boarddata.strobe_dll_delay_target)
+		strobe_delay = imx_data->boarddata.strobe_dll_delay_target;
+	else
+		strobe_delay = ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT;
 	v = ESDHC_STROBE_DLL_CTRL_ENABLE |
 		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
-		(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
+		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
 	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
 	/* wait 5us to make sure strobe dll status register stable */
 	udelay(5);
@@ -1340,6 +1348,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	of_property_read_u32(np, "fsl,tuning-start-tap",
 			     &boarddata->tuning_start_tap);
 
+	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
+				&boarddata->strobe_dll_delay_target);
 	if (of_find_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 6c006078c8a1..0434f68eda86 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -37,5 +37,6 @@ struct esdhc_platform_data {
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
+	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
2.17.1

