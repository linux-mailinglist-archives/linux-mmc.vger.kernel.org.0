Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A9E9CEBB
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfHZL4t (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 07:56:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfHZL4t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Aug 2019 07:56:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 038A03A17AC74FA5FB94;
        Mon, 26 Aug 2019 19:56:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 26 Aug 2019 19:56:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mmc: aspeed: Fix return value check in aspeed_sdc_probe()
Date:   Mon, 26 Aug 2019 12:00:13 +0000
Message-ID: <20190826120013.183435-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In case of error, the function of_platform_device_create() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8bb095ca2fa9..d5acb5afc50f 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -261,9 +261,9 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		struct platform_device *cpdev;
 
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
-		if (IS_ERR(cpdev)) {
+		if (!cpdev) {
 			of_node_put(child);
-			ret = PTR_ERR(cpdev);
+			ret = -ENODEV;
 			goto err_clk;
 		}
 	}



