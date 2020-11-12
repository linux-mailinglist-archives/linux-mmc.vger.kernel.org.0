Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8CA2B0132
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Nov 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLI17 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Nov 2020 03:27:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8070 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLI16 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 03:27:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWvqM32MvzLxTP;
        Thu, 12 Nov 2020 16:27:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 16:27:49 +0800
From:   Zheng Liang <zhengliang6@huawei.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>
CC:     <matthias.bgg@gmail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wangli74@huawei.com>,
        <fangwei1@huawei.com>
Subject: [PATCH] mmc: mediatek: fix mem leak in msdc_drv_probe
Date:   Thu, 12 Nov 2020 17:25:30 +0800
Message-ID: <20201112092530.32446-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It should use mmc_free_host to free mem in error patch of
msdc_drv_probe.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fc5ee5df91ad..eac7838e2dac 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2504,8 +2504,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								"hrst");
-	if (IS_ERR(host->reset))
-		return PTR_ERR(host->reset);
+	if (IS_ERR(host->reset)) {
+		ret = PTR_ERR(host->reset);
+		goto host_free;
+	}
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-- 
2.17.1

