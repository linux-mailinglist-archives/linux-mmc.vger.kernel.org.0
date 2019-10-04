Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE75CB771
	for <lists+linux-mmc@lfdr.de>; Fri,  4 Oct 2019 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfJDJhT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 05:37:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJDJhT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Oct 2019 05:37:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 11CEE289A82BC48F8BB8;
        Fri,  4 Oct 2019 17:37:16 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 17:37:08 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] mmc: sdhci-pci: Make function amd_sdhci_reset static
Date:   Fri, 4 Oct 2019 17:44:20 +0800
Message-ID: <1570182260-135818-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix sparse warnings:

drivers/mmc/host/sdhci-pci-core.c:1599:6: warning: symbol 'amd_sdhci_reset' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 659878a..de50e1d 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1596,7 +1596,7 @@ static u32 sdhci_read_present_state(struct sdhci_host *host)
 	return sdhci_readl(host, SDHCI_PRESENT_STATE);
 }

-void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
+static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev = slot->chip->pdev;
--
2.7.4

