Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D520BA213
	for <lists+linux-mmc@lfdr.de>; Sun, 22 Sep 2019 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfIVLrD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 07:47:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfIVLrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Sep 2019 07:47:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iC0KS-0006f3-Jy; Sun, 22 Sep 2019 11:47:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: jmb38x_ms: clean up indentation issue
Date:   Sun, 22 Sep 2019 13:47:00 +0200
Message-Id: <20190922114700.10563-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code that is indented one level too deep, fix
this by removing the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memstick/host/jmb38x_ms.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 32747425297d..3394164a7968 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -433,13 +433,13 @@ static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
 		writel(((1 << 16) & BLOCK_COUNT_MASK)
 		       | (data_len & BLOCK_SIZE_MASK),
 		       host->addr + BLOCK);
-			t_val = readl(host->addr + INT_STATUS_ENABLE);
-			t_val |= host->req->data_dir == READ
-				 ? INT_STATUS_FIFO_RRDY
-				 : INT_STATUS_FIFO_WRDY;
+		t_val = readl(host->addr + INT_STATUS_ENABLE);
+		t_val |= host->req->data_dir == READ
+			 ? INT_STATUS_FIFO_RRDY
+			 : INT_STATUS_FIFO_WRDY;
 
-			writel(t_val, host->addr + INT_STATUS_ENABLE);
-			writel(t_val, host->addr + INT_SIGNAL_ENABLE);
+		writel(t_val, host->addr + INT_STATUS_ENABLE);
+		writel(t_val, host->addr + INT_SIGNAL_ENABLE);
 	} else {
 		cmd &= ~(TPC_DATA_SEL | 0xf);
 		host->cmd_flags |= REG_DATA;
-- 
2.20.1

