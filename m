Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166A2AAF1D
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Nov 2020 03:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgKICN0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Nov 2020 21:13:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7612 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKICN0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Nov 2020 21:13:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CTvff0YkVzLwFK;
        Mon,  9 Nov 2020 10:13:14 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 10:13:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <ulf.hansson@linaro.org>, <afaerber@suse.de>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mmc: owl-mmc: use true and false for bool variables
Date:   Mon, 9 Nov 2020 10:25:06 +0800
Message-ID: <1604888706-63429-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix coccicheck warnings:

./owl-mmc.c:524:2-18: WARNING: Assignment of 0/1 to bool variable
./owl-mmc.c:528:2-18: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mmc/host/owl-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 82d2bad..53b81582 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -521,11 +521,11 @@ static void owl_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* Enable DDR mode if requested */
 	if (ios->timing == MMC_TIMING_UHS_DDR50) {
-		owl_host->ddr_50 = 1;
+		owl_host->ddr_50 = true;
 		owl_mmc_update_reg(owl_host->base + OWL_REG_SD_EN,
 			       OWL_SD_EN_DDREN, true);
 	} else {
-		owl_host->ddr_50 = 0;
+		owl_host->ddr_50 = false;
 	}
 }
 
-- 
2.6.2

