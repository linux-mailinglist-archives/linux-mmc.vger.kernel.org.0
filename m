Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D153DFDC28
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKOLUe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:20:34 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33568 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfKOLUe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:20:34 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F66F200049;
        Fri, 15 Nov 2019 12:20:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CB9D200094;
        Fri, 15 Nov 2019 12:20:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B8537402FB;
        Fri, 15 Nov 2019 19:20:22 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 11/14] mmc: sdhci-esdhc-imx: optimize the strobe dll setting
Date:   Fri, 15 Nov 2019 19:18:30 +0800
Message-Id: <1573816712-26841-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After set the STROBE SLV delay target value, it need to wait some
time to let the usdhc lock the REF and SLV clock. In normal case,
1~2us is enough for imx8/imx6 and imx7d, and 4~5us is enough for
imx7ulp, but when do reboot stress test or do the bind/unbind stress
test, sometimes need to wait about 10us to get the status lock.

This patch optimize delay handle method, only print the warning
message if the status is still not lock after 1ms delay.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0667b6903708..80a148f8009e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1021,6 +1021,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 strobe_delay;
 	u32 v;
+	int ret;
 
 	/* disable clock before enabling strobe dll */
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
@@ -1046,15 +1047,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
 		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
 	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
-	/* wait 5us to make sure strobe dll status register stable */
-	udelay(5);
-	v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
-	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
-		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status REF not lock!\n");
-	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
+
+	/* wait max 50us to get the REF/SLV lock */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_STROBE_DLL_STATUS, v,
+		((v & ESDHC_STROBE_DLL_STS_REF_LOCK) && (v & ESDHC_STROBE_DLL_STS_SLV_LOCK)), 1, 50);
+	if (ret == -ETIMEDOUT)
 		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status SLV not lock!\n");
+		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
 }
 
 static void esdhc_reset_tuning(struct sdhci_host *host)
-- 
2.17.1

