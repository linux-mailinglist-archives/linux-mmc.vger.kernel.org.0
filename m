Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750B7FDC0B
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKOLOs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:14:48 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44650 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLOs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:14:48 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 777401A050C;
        Fri, 15 Nov 2019 12:14:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 04ED11A04EF;
        Fri, 15 Nov 2019 12:14:41 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D0E67402F8;
        Fri, 15 Nov 2019 19:14:35 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 06/14] mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
Date:   Fri, 15 Nov 2019 19:12:40 +0800
Message-Id: <1573816361-26535-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
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
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bc743f82d8c3..2c8a78218c8e 100644
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
@@ -1613,6 +1620,8 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1621,6 +1630,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
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

