Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D28FDC0A
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKOLOq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:14:46 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54958 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfKOLOq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:14:46 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 47E51200101;
        Fri, 15 Nov 2019 12:14:44 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 044C3200049;
        Fri, 15 Nov 2019 12:14:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D01D0402F1;
        Fri, 15 Nov 2019 19:14:34 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 05/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl available
Date:   Fri, 15 Nov 2019 19:12:39 +0800
Message-Id: <1573816361-26535-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When using jailhouse to support two Linux on i.MX8MQ EVK, we use the
1st Linux to configure pinctrl for the 2nd Linux. Then the 2nd Linux
could use the mmc without pinctrl driver.

So give a warning message when no pinctrl available, but no fail probe.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 25b01f059aca..bc743f82d8c3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1489,13 +1489,14 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
-		goto disable_ahb_clk;
-	}
-
-	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
+		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
+		imx_data->pins_default = ERR_PTR(-EINVAL);
+	} else {
+		imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
 						PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(imx_data->pins_default))
-		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
+		if (IS_ERR(imx_data->pins_default))
+			dev_warn(mmc_dev(host->mmc), "could not get default state\n");
+	}
 
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-- 
2.17.1

