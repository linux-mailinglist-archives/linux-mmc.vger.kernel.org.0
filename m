Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4727B7743EA
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Aug 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjHHSMb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Aug 2023 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjHHSL6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:11:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E6168B49
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:15:49 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKvLh1lmMz1hwG7;
        Tue,  8 Aug 2023 21:34:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:37:41 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <sugaya.taichi@socionext.com>, <orito.takao@socionext.com>,
        <vireshk@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 1/2] mmc: sdhci-spear: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:37:13 +0800
Message-ID: <20230808133714.214914-2-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808133714.214914-1-wangzhu9@huawei.com>
References: <20230808133714.214914-1-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove both CONFIG_OF and of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/mmc/host/sdhci-spear.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c79035727b20..73ca07cdfaa9 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -170,20 +170,18 @@ static int sdhci_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
 
-#ifdef CONFIG_OF
 static const struct of_device_id sdhci_spear_id_table[] = {
 	{ .compatible = "st,spear300-sdhci" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_spear_id_table);
-#endif
 
 static struct platform_driver sdhci_driver = {
 	.driver = {
 		.name	= "sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &sdhci_pm_ops,
-		.of_match_table = of_match_ptr(sdhci_spear_id_table),
+		.of_match_table = sdhci_spear_id_table,
 	},
 	.probe		= sdhci_probe,
 	.remove		= sdhci_remove,
-- 
2.17.1

