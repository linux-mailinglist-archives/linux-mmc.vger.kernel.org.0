Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492C2622C8A
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Nov 2022 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKINhG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Nov 2022 08:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKINhF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 08:37:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827D2B603
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 05:37:05 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6mGV0lWLzmVcg;
        Wed,  9 Nov 2022 21:36:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 21:37:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 21:37:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <p.zabel@pengutronix.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH] mmc: mmci: fix return value check of mmc_add_host()
Date:   Wed, 9 Nov 2022 21:35:39 +0800
Message-ID: <20221109133539.3275664-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_add_host() may return error, if we ignore its return value,
it will lead two issues:
1. The memory that allocated in mmc_alloc_host() is leaked.
2. In the remove() path, mmc_remove_host() will be called to
   delete device, but it's not added yet, it will lead a kernel
   crash because of null-ptr-deref in device_del().

So fix this by checking the return value and goto error path which
will call mmc_free_host().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/mmci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 012aa85489d8..b9e5dfe74e5c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2256,7 +2256,9 @@ static int mmci_probe(struct amba_device *dev,
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto clk_disable;
 
 	pm_runtime_put(&dev->dev);
 	return 0;
-- 
2.25.1

