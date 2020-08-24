Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7924FBF1
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Aug 2020 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHXKvF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Aug 2020 06:51:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59804 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHXKvD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 06:51:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 423FA201519;
        Mon, 24 Aug 2020 12:51:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80CDB200277;
        Mon, 24 Aug 2020 12:50:57 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 87CA1402DF;
        Mon, 24 Aug 2020 12:50:52 +0200 (CEST)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: remove unused code
Date:   Mon, 24 Aug 2020 18:45:14 +0800
Message-Id: <1598265914-23606-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Value assigned to a variable(err) is never used, so remove it

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3d6eaf490d4a..3d2615eb7d56 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1673,10 +1673,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto disable_ipg_clk;
 
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(imx_data->pinctrl)) {
-		err = PTR_ERR(imx_data->pinctrl);
+	if (IS_ERR(imx_data->pinctrl))
 		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
-	}
 
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-- 
2.17.1

