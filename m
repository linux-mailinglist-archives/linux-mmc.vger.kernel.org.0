Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E741938BB2C
	for <lists+linux-mmc@lfdr.de>; Fri, 21 May 2021 03:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhEUBEM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 May 2021 21:04:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5706 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhEUBEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 21:04:12 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmStF2257zqVWP;
        Fri, 21 May 2021 08:59:17 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 09:02:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 09:02:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <kishon@ti.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] mmc: sdhci-omap: Use pm_runtime_resume_and_get() to replace open coding
Date:   Fri, 21 May 2021 09:02:45 +0800
Message-ID: <1621558965-34077-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. this change is just to simplify the code, no
actual functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mmc/host/sdhci-omap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 7893fd3..8f4d1f0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1173,10 +1173,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	 * as part of pm_runtime_get_sync.
 	 */
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
 		dev_err(dev, "pm_runtime_get_sync failed\n");
-		pm_runtime_put_noidle(dev);
 		goto err_rpm_disable;
 	}
 
-- 
2.7.4

