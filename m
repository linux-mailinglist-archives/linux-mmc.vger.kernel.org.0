Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFD41F02
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436961AbfFLI0T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 04:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436841AbfFLI0T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 04:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0FF20874;
        Wed, 12 Jun 2019 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560327978;
        bh=YEqOazDan6/XsStPOtzyFr/4dMkerzuc1P5nOrQsrKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnD+DIyJdR58Yyrtgf/ePXw+NpXFDSCm6ijQhbwd25z2BZjxBKkokXPi2oaguiHQe
         6IHbN7Hy0Pq+cjfL+HstxyzzXLrhruwahbLXgxGQzzRjI3mT2sRJb01YmxgLaBu3Px
         Dx8uumOGpRhYRNW44q2QELc27xYHi4JSQOETM50E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/4] mmc: host: dw_mmc: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 10:25:30 +0200
Message-Id: <20190612082531.2652-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612082531.2652-1-gregkh@linuxfoundation.org>
References: <20190612082531.2652-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/dw_mmc.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b53b6b7d4dd4..faaaf52a46d2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -169,40 +169,18 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 	struct mmc_host	*mmc = slot->mmc;
 	struct dw_mci *host = slot->host;
 	struct dentry *root;
-	struct dentry *node;
 
 	root = mmc->debugfs_root;
 	if (!root)
 		return;
 
-	node = debugfs_create_file("regs", S_IRUSR, root, host,
-				   &dw_mci_regs_fops);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_file("req", S_IRUSR, root, slot,
-				   &dw_mci_req_fops);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_x32("pending_events", S_IRUSR, root,
-				  (u32 *)&host->pending_events);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_x32("completed_events", S_IRUSR, root,
-				  (u32 *)&host->completed_events);
-	if (!node)
-		goto err;
-
-	return;
-
-err:
-	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
+	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
+	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
+	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
+	debugfs_create_x32("pending_events", S_IRUSR, root,
+			   (u32 *)&host->pending_events);
+	debugfs_create_x32("completed_events", S_IRUSR, root,
+			   (u32 *)&host->completed_events);
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-- 
2.22.0

