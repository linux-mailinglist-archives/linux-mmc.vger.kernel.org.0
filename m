Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA741EFF
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfFLI0I (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 04:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfFLI0I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 04:26:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7802063F;
        Wed, 12 Jun 2019 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560327967;
        bh=uPVtC1LZDDJLu0sBMe/2IAnDDrVsrULOv8bXR4Vf6Ic=;
        h=From:To:Cc:Subject:Date:From;
        b=hnHayDh2qWSdmOhUZqcWfCeRhoDLQWN7swylkn8EdPf3PhB3KG6Iy7iJiTL6s/6VQ
         fSye3h8P66eP/bRQC5hOX+/hcTRe6T2YkBg2qyAIIcua4ohPou1aq83dMdL1CucJ9o
         jECrnmLuxqr6673u3okWZXcnVMEL/7AwbeD5ZxLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/4] mmc: core: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 10:25:28 +0200
Message-Id: <20190612082531.2652-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/debugfs.c  | 56 ++++++-------------------------------
 drivers/mmc/core/mmc_test.c | 10 +------
 2 files changed, 9 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index d2275c5a2311..cc3be259bc42 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -230,45 +230,21 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	struct dentry *root;
 
 	root = debugfs_create_dir(mmc_hostname(host), NULL);
-	if (IS_ERR(root))
-		/* Don't complain -- debugfs just isn't enabled */
-		return;
-	if (!root)
-		/* Complain -- debugfs is enabled, but it failed to
-		 * create the directory. */
-		goto err_root;
-
 	host->debugfs_root = root;
 
-	if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
-		goto err_node;
-
-	if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
-		goto err_node;
-
-	if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
-		goto err_node;
-
-	if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
-			&mmc_clock_fops))
-		goto err_node;
+	debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
+	debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
+	debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
+	debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
+			    &mmc_clock_fops);
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
 	host->fail_mmc_request = fail_default_attr;
-	if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
-					     root,
-					     &host->fail_mmc_request)))
-		goto err_node;
+	fault_create_debugfs_attr("fail_mmc_request", root,
+				  &host->fail_mmc_request);
 #endif
-	return;
-
-err_node:
-	debugfs_remove_recursive(root);
-	host->debugfs_root = NULL;
-err_root:
-	dev_err(&host->class_dev, "failed to initialize debugfs\n");
 }
 
 void mmc_remove_host_debugfs(struct mmc_host *host)
@@ -285,25 +261,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 		return;
 
 	root = debugfs_create_dir(mmc_card_id(card), host->debugfs_root);
-	if (IS_ERR(root))
-		/* Don't complain -- debugfs just isn't enabled */
-		return;
-	if (!root)
-		/* Complain -- debugfs is enabled, but it failed to
-		 * create the directory. */
-		goto err;
-
 	card->debugfs_root = root;
 
-	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
-		goto err;
-
-	return;
-
-err:
-	debugfs_remove_recursive(root);
-	card->debugfs_root = NULL;
-	dev_err(&card->dev, "failed to initialize debugfs\n");
+	debugfs_create_x32("state", S_IRUSR, root, &card->state);
 }
 
 void mmc_remove_card_debugfs(struct mmc_card *card)
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index b27df2d2b5ae..492dd4596314 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3167,15 +3167,7 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
 	struct mmc_test_dbgfs_file *df;
 
 	if (card->debugfs_root)
-		file = debugfs_create_file(name, mode, card->debugfs_root,
-			card, fops);
-
-	if (IS_ERR_OR_NULL(file)) {
-		dev_err(&card->dev,
-			"Can't create %s. Perhaps debugfs is disabled.\n",
-			name);
-		return -ENODEV;
-	}
+		debugfs_create_file(name, mode, card->debugfs_root, card, fops);
 
 	df = kmalloc(sizeof(*df), GFP_KERNEL);
 	if (!df) {
-- 
2.22.0

