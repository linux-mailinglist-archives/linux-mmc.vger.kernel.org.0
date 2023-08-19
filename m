Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87207817A3
	for <lists+linux-mmc@lfdr.de>; Sat, 19 Aug 2023 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbjHSGSC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 19 Aug 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbjHSGR3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Aug 2023 02:17:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514132133
        for <linux-mmc@vger.kernel.org>; Fri, 18 Aug 2023 23:17:26 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RST4K6PVDzVjP4;
        Sat, 19 Aug 2023 14:15:13 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 14:17:23 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>
Subject: [PATCH -next] mmc: sdhci-of-dwcmshc: Use helper function devm_clk_get_enabled()
Date:   Sat, 19 Aug 2023 14:16:59 +0800
Message-ID: <20230819061659.74716-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
can now be replaced by devm_clk_get_enabled() when the driver enables
(and possibly prepares) the clocks for the whole lifetime of the device.
Moreover, it is no longer necessary to unprepare and disable the clocks
explicitly.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 31c1892f4ecd..144ca5bc427c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -495,19 +495,19 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	priv = sdhci_pltfm_priv(pltfm_host);
 
 	if (dev->of_node) {
-		pltfm_host->clk = devm_clk_get(dev, "core");
+		pltfm_host->clk = devm_clk_get_enabled(dev, "core");
 		if (IS_ERR(pltfm_host->clk)) {
 			err = PTR_ERR(pltfm_host->clk);
-			dev_err(dev, "failed to get core clk: %d\n", err);
+			dev_err(dev, "failed to get or enable core clk: %d\n", err);
 			goto free_pltfm;
 		}
-		err = clk_prepare_enable(pltfm_host->clk);
-		if (err)
-			goto free_pltfm;
 
-		priv->bus_clk = devm_clk_get(dev, "bus");
-		if (!IS_ERR(priv->bus_clk))
-			clk_prepare_enable(priv->bus_clk);
+		priv->bus_clk = devm_clk_get_enabled(dev, "bus");
+		if (!IS_ERR(priv->bus_clk)) {
+			err = PTR_ERR(priv->bus_clk);
+			dev_err(dev, "failed to get or enable bus clk: %d\n", err);
+			goto free_pltfm;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
@@ -564,8 +564,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_setup_host:
 	sdhci_cleanup_host(host);
 err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
-- 
2.17.1

