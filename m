Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB8163F38
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Feb 2020 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBSIby (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Feb 2020 03:31:54 -0500
Received: from inva021.nxp.com ([92.121.34.21]:38502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgBSIbx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5832B204785;
        Wed, 19 Feb 2020 09:31:50 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A60AC204781;
        Wed, 19 Feb 2020 09:31:46 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F0F6A402E6;
        Wed, 19 Feb 2020 16:31:40 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 09/14] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_BROKEN_AUTO_CMD23
Date:   Wed, 19 Feb 2020 16:25:52 +0800
Message-Id: <1582100757-20683-4-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq->sbc
when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD23 for
RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, the
RPMB write operation will return general fail.

According to the sdhci logic, SDMA mode will disable the ACMD23, and only in
ADMA mode, it will chose to use ACMD23 if the host support. But according to
debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
the ACMD23 feature completely. These SoCs only use the 16 bit block count of
the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
means it will ignore the upper 16 bit of the CMD23's argument. This will block
the reliable write operation in RPMB, because RPMB reliable write need to set
the bit31 of the CMD23's argument. This is the hardware limitation. So for
imx6qpdl/imx6sx/imx6sl/imx7d, it need to broke the ACMD23 for eMMC, SD card do
not has this limitation, because SD card do not support reliable write.

For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, it
change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADMA mode.

This patch add a new flag ESDHC_FLAG_BROKEN_AUTO_CMD23, and add this flag to
imx6q/imx6sx/imx6sl/imx7d, and due to the imx6sll share the same compatible string
with imx6sx before, and imx6sll do not has this limitation, so add a new compatible
string for imx6sll.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 34 ++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1ec35cc45fc5..98b91b6ff2a9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -166,6 +166,18 @@
 #define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
 /* The IP lost clock rate in PM_RUNTIME */
 #define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
+/*
+ * The IP do not support the ACMD23 feature completely when use ADMA mode.
+ * In ADMA mode, it only use the 16 bit block count of the register 0x4
+ * (BLOCK_ATT) as the CMD23's argument for ACMD23 mode, which means it will
+ * ignore the upper 16 bit of the CMD23's argument. This will block the reliable
+ * write operation in RPMB, because RPMB reliable write need to set the bit31
+ * of the CMD23's argument.
+ * imx6qpdl/imx6sx/imx6sl/imx7d has this limitation only for ADMA mode, SDMA
+ * do not has this limitation. so when these SoC use ADMA mode, it need to
+ * disable the ACMD23 feature.
+ */
+#define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -188,21 +200,30 @@ static const struct esdhc_soc_data esdhc_imx53_data = {
 };
 
 static const struct esdhc_soc_data usdhc_imx6q_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
 
 static const struct esdhc_soc_data usdhc_imx6sl_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
-			| ESDHC_FLAG_HS200,
+			| ESDHC_FLAG_HS200
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
 
-static const struct esdhc_soc_data usdhc_imx6sx_data = {
+static const struct esdhc_soc_data usdhc_imx6sll_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
+static const struct esdhc_soc_data usdhc_imx6sx_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+};
+
 static const struct esdhc_soc_data usdhc_imx6ull_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
@@ -214,7 +235,8 @@ static const struct esdhc_soc_data usdhc_imx7d_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400
-			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -276,6 +298,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
+	{ .compatible = "fsl,imx6sll-usdhc", .data = &usdhc_imx6sll_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
 	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
@@ -1560,6 +1583,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
+		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
-- 
2.17.1

