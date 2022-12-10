Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98A649036
	for <lists+linux-mmc@lfdr.de>; Sat, 10 Dec 2022 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJSoV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 10 Dec 2022 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJSoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Dec 2022 13:44:20 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825391705F
        for <linux-mmc@vger.kernel.org>; Sat, 10 Dec 2022 10:44:19 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 44iJpNwaA1SdM44iNpAGvA; Sat, 10 Dec 2022 19:36:47 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 19:36:47 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] mmc: sunlpus: Fix a memory leak in case of error in spmmc_drv_probe()
Date:   Sat, 10 Dec 2022 19:36:38 +0100
Message-Id: <9c52251e1ba837ca204e253627679f1e42ebe9fa.1670697358.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
References: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If an error occurs after a successful mmc_alloc_host() call in the probe,
the error handling path should be executed in order to call
mmc_free_host().

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/sunplus-mmc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 3e8856a82188..ed789a9bdd23 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -875,26 +875,34 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	host->dma_int_threshold = 1024;
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(host->base))
-		return PTR_ERR(host->base);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
+		goto probe_free_host;
+	}
 
 	host->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(host->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+	if (IS_ERR(host->clk)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+		goto probe_free_host;
+	}
 
 	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(host->rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+	if (IS_ERR(host->rstc)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+		goto probe_free_host;
+	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return host->irq;
+	if (host->irq <= 0) {
+		ret = host->irq;
+		goto probe_free_host;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
 					spmmc_irq, spmmc_func_finish_req, IRQF_SHARED,
 			NULL, host);
 	if (ret)
-		return ret;
+		goto probe_free_host;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.34.1

