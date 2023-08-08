Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF837743FB
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Aug 2023 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjHHSOe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Aug 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjHHSOC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:14:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5874AE3
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:19:42 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKvKw1pm6ztRrM;
        Tue,  8 Aug 2023 21:34:12 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:37:40 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <sugaya.taichi@socionext.com>, <orito.takao@socionext.com>,
        <vireshk@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 0/2] mmc: host: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:37:12 +0800
Message-ID: <20230808133714.214914-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove both CONFIG_OF and of_match_ptr() here.

Zhu Wang (2):
  mmc: sdhci-spear: remove redundant of_match_ptr()
  mmc: sdhci: milbeaut: remove redundant of_match_ptr()

 drivers/mmc/host/sdhci-milbeaut.c | 2 +-
 drivers/mmc/host/sdhci-spear.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.1

