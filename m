Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D7129E5E
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Dec 2019 08:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfLXHZF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Dec 2019 02:25:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfLXHZF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3FCAAFB2A10D1299249;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:56 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 4/6] mmc: omap_hsmmc: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:13 +0800
Message-ID: <1577172735-18869-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
References: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes coccicheck warning:

drivers/mmc/host/omap_hsmmc.c:294:3-22: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/omap_hsmmc.c:303:3-22: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/omap_hsmmc.c:1866:1-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/omap_hsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a379c45..ce2a929 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -291,7 +291,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on)
 				dev_err(host->dev, "pbias reg enable fail\n");
 				return ret;
 			}
-			host->pbias_enabled = 1;
+			host->pbias_enabled = true;
 		}
 	} else {
 		if (host->pbias_enabled == 1) {
@@ -300,7 +300,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on)
 				dev_err(host->dev, "pbias reg disable fail\n");
 				return ret;
 			}
-			host->pbias_enabled = 0;
+			host->pbias_enabled = false;
 		}
 	}

@@ -1863,7 +1863,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
-	host->pbias_enabled = 0;
+	host->pbias_enabled = false;
 	host->vqmmc_enabled = 0;

 	platform_set_drvdata(pdev, host);
--
2.7.4

