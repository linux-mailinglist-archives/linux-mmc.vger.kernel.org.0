Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14532A3B1D
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Nov 2020 04:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKCDsM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 2 Nov 2020 22:48:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7036 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKCDsM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 22:48:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQG2v6hGCzhfcD;
        Tue,  3 Nov 2020 11:48:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 11:48:08 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: meson-mx-sdio: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Tue, 3 Nov 2020 11:48:43 +0800
Message-ID: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 1c5299c..d4a4891 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -418,10 +418,9 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
 {
 	struct meson_mx_mmc_host *host = (void *) data;
 	u32 irqs, send;
-	unsigned long irqflags;
 	irqreturn_t ret;
 
-	spin_lock_irqsave(&host->irq_lock, irqflags);
+	spin_lock(&host->irq_lock);
 
 	irqs = readl(host->base + MESON_MX_SDIO_IRQS);
 	send = readl(host->base + MESON_MX_SDIO_SEND);
@@ -434,7 +433,7 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
 	/* finally ACK all pending interrupts */
 	writel(irqs, host->base + MESON_MX_SDIO_IRQS);
 
-	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+	spin_unlock(&host->irq_lock);
 
 	return ret;
 }
-- 
2.7.4

