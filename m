Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCF614B76
	for <lists+linux-mmc@lfdr.de>; Tue,  1 Nov 2022 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKANPx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 1 Nov 2022 09:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKANPw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 09:15:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B40F01F
        for <linux-mmc@vger.kernel.org>; Tue,  1 Nov 2022 06:15:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1r5q6GnwzpW3j;
        Tue,  1 Nov 2022 21:12:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 21:15:48 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 21:15:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>,
        Daniel Drake <drake@endlessos.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH 2/3] mmc: sdio: fix possible memory leak in sdio_init_func()
Date:   Tue, 1 Nov 2022 21:13:16 +0800
Message-ID: <20221101131317.866961-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101131317.866961-1-yangyingliang@huawei.com>
References: <20221101131317.866961-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If it fails in sdio_init_func(), sdio_remove_func() can not
free the memory that allocated in sdio_alloc_func(), because
sdio_add_func() is not called yet, the sdio function is not
presented and sdio_remove_func() will return directly.

In this error path, we can not call put_device() to free the
memory in sdio_release_func(), because sdio_read_func_cis()
may fail, then sdio_free_func_cis() is called in release()
funtion which could cause put the reference that has not
been got.

So fix these leaks with calling kfree() instead of sdio_remove_func()
in error path.

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Cc: Daniel Drake <drake@endlessos.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..f314224b362b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -133,11 +133,8 @@ static int sdio_init_func(struct mmc_card *card, unsigned int fn)
 	return 0;
 
 fail:
-	/*
-	 * It is okay to remove the function here even though we hold
-	 * the host lock as we haven't registered the device yet.
-	 */
-	sdio_remove_func(func);
+	kfree(func->tmpbuf)
+	kfree(func);
 	return ret;
 }
 
-- 
2.25.1

