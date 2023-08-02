Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910D76C99F
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Aug 2023 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjHBJlK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Aug 2023 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBJlJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2023 05:41:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3131FC6
        for <linux-mmc@vger.kernel.org>; Wed,  2 Aug 2023 02:41:00 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG6PZ0yLZzVk19;
        Wed,  2 Aug 2023 17:39:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:40:58 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <patrice.chotard@foss.st.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>
Subject: [PATCH -next] mmc: sdhci-st: Use devm_platform_ioremap_resource_byname()
Date:   Wed, 2 Aug 2023 17:40:28 +0800
Message-ID: <20230802094028.976612-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert platform_get_resource_byname() + devm_ioremap_resource() to a
single call to devm_platform_ioremap_resource_byname(), as this is
exactly what this function does.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/mmc/host/sdhci-st.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 6415916fbd91..97f350953c4b 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -348,7 +348,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	struct clk *clk, *icnclk;
 	int ret = 0;
 	u16 host_version;
-	struct resource *res;
 	struct reset_control *rstc;
 
 	clk =  devm_clk_get(&pdev->dev, "mmc");
@@ -397,9 +396,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	}
 
 	/* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "top-mmc-delay");
-	pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	pdata->top_ioaddr = devm_platform_ioremap_resource_byname(pdev, "top-mmc-delay");
 	if (IS_ERR(pdata->top_ioaddr))
 		pdata->top_ioaddr = NULL;
 
-- 
2.34.1

