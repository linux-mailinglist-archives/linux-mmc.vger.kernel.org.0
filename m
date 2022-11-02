Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A116156F8
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Nov 2022 02:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKBB1F (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 1 Nov 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKBB1C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 21:27:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD931FCD4
        for <linux-mmc@vger.kernel.org>; Tue,  1 Nov 2022 18:26:52 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N28L50X0ZzJnP8;
        Wed,  2 Nov 2022 09:23:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:26:50 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:26:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v2 0/3] mmc: sdio: fixes some leaks
Date:   Wed, 2 Nov 2022 09:25:30 +0800
Message-ID: <20221102012533.1270876-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

v1 -> v2:
  Fix compile error in patch #2.

Yang Yingliang (3):
  mmc: sdio: fix of node refcount leak in sdio_add_func()
  mmc: sdio: fix possible memory leak in sdio_init_func()
  mmc: sdio: fix possible memory leak in mmc_attach_sdio()

 drivers/mmc/core/sdio.c     |  7 ++-----
 drivers/mmc/core/sdio_bus.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.25.1

