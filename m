Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3D542B67
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Jun 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiFHJXS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Jun 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFHJWn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 05:22:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B231208BC;
        Wed,  8 Jun 2022 01:43:33 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJ1123MtPzgYlT;
        Wed,  8 Jun 2022 16:41:42 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 16:43:30 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Sayali Lokhande <quic_sayalil@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-mmc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mmc: debugfs: Fix file release memory leak
Date:   Wed, 8 Jun 2022 09:01:52 +0000
Message-ID: <20220608090152.179395-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When using single_open() for opening, single_release() should be
used instead of seq_release(), otherwise there is a memory leak.

Fixes: c835a6debf06 ("mmc: debugfs: Add debug fs entry for mmc driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/core/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 75e98ec88fb9..fe6808771bc7 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -295,6 +295,7 @@ static const struct file_operations mmc_err_stats_fops = {
 	.open	= mmc_err_stats_open,
 	.read	= seq_read,
 	.write	= mmc_err_stats_write,
+	.release = single_release,
 };
 
 void mmc_add_host_debugfs(struct mmc_host *host)

