Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E967E163F0D
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Feb 2020 09:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSIaK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Feb 2020 03:30:10 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36436 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSIaK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:30:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 19DF5204785;
        Wed, 19 Feb 2020 09:30:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B07B20129F;
        Wed, 19 Feb 2020 09:30:04 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ECBA6402E1;
        Wed, 19 Feb 2020 16:29:59 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 03/14] mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
Date:   Wed, 19 Feb 2020 16:22:42 +0800
Message-Id: <1582100563-20555-4-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100563-20555-1-git-send-email-haibo.chen@nxp.com>
References: <1582100563-20555-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For Mega/Mix enabled SoCs like MX7D and MX6SX, uSDHC will lost power in
LP mode no matter whether the MMC_KEEP_POWER flag is set or not.
This may cause state misalign between kernel and HW, especially for
SDIO3.0 WiFi cards.
e.g. SDIO WiFi driver usually will keep power during system suspend.
And after resume, no card re-enumeration called.
But the tuning state is lost due to Mega/Mix.
Then CRC error may happen during next data transfer.

So we should always fire a mmc_retune_needed() for such type SoC
to tell MMC core retuning is needed for next data transfer.
mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8c802681ad2c..9b5afa2514c6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -160,6 +160,8 @@
 #define ESDHC_FLAG_CQHCI		BIT(12)
 /* need request pmqos during low power */
 #define ESDHC_FLAG_PMQOS		BIT(13)
+/* The IP state got lost in low power mode */
+#define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -193,32 +195,37 @@ static const struct esdhc_soc_data usdhc_imx6sl_data = {
 
 static const struct esdhc_soc_data usdhc_imx6sx_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static const struct esdhc_soc_data usdhc_imx6ull_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_ERR010450,
+			| ESDHC_FLAG_ERR010450
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static const struct esdhc_soc_data usdhc_imx7d_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_HS400,
+			| ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400,
+			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_CQHCI,
+			| ESDHC_FLAG_CQHCI
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 struct pltfm_imx_data {
@@ -1606,6 +1613,8 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1614,6 +1623,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
 			return ret;
 	}
 
+	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
+		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
+		mmc_retune_timer_stop(host->mmc);
+		mmc_retune_needed(host->mmc);
+	}
+
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-- 
2.17.1

