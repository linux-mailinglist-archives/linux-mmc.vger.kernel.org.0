Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA219CEEE
	for <lists+linux-mmc@lfdr.de>; Fri,  3 Apr 2020 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbgDCDtC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 2 Apr 2020 23:49:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389857AbgDCDtC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 23:49:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 102DBFA39474E363522F;
        Fri,  3 Apr 2020 11:48:59 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 11:48:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <ulf.hansson@linaro.org>, <dianders@chromium.org>,
        <ludovic.barre@st.com>, <linux-mmc@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] mmc: core: make mmc_interrupt_hpi() static
Date:   Fri, 3 Apr 2020 11:47:27 +0800
Message-ID: <20200403034727.11879-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the following sparse warning:

drivers/mmc/core/mmc_ops.c:881:5: warning: symbol 'mmc_interrupt_hpi'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5bd0ab8b236a..baa6314f69b4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -878,7 +878,7 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
  *	Issued High Priority Interrupt, and check for card status
  *	until out-of prg-state.
  */
-int mmc_interrupt_hpi(struct mmc_card *card)
+static int mmc_interrupt_hpi(struct mmc_card *card)
 {
 	int err;
 	u32 status;
-- 
2.17.2

