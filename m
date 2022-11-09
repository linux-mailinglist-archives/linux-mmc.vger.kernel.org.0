Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DFA622241
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Nov 2022 03:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKICxE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Nov 2022 21:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKICxD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 21:53:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1A20352
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 18:53:02 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6Tz83hwLzHvj8;
        Wed,  9 Nov 2022 10:52:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:53:01 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 10:53:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v3 0/3] mmc: sdio: fixes some leaks
Date:   Wed, 9 Nov 2022 10:51:39 +0800
Message-ID: <20221109025142.1565445-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch a refcount leak and two memory leaks about
SDIO function.

v2 -> v3:
 Change to call of_node_put() in remove() function to
 fix node refcount leak.

v1 -> v2:
  Fix compile error in patch #2.

Yang Yingliang (3):
  mmc: sdio: fix possible memory leak in sdio_init_func()
  mmc: sdio: fix of node refcount leak in sdio_add_func()
  mmc: sdio: fix possible memory leak in mmc_attach_sdio()

 drivers/mmc/core/sdio.c     | 7 ++-----
 drivers/mmc/core/sdio_bus.c | 6 +++---
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.25.1

