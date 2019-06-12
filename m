Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1941F03
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436989AbfFLI0W (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 04:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436841AbfFLI0W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 04:26:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D233C2086A;
        Wed, 12 Jun 2019 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560327981;
        bh=e/8e/8Gzd//NDFDedJ/uuRg9TDsLNr2Z7h2IAkdkegA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nintNae3fY4I64ITCx2WHXAsOB73QxU1NznWAEhAl88YxjHYqmsWO9+J9FMnijeHn
         NqMfpJXJ9/fjkP/ip+4oYSqsgcwauf19hbOK66AzfhwMI8aNgZ+sckUEbhK5oIVyDT
         Il/B3nR9rztzuHi9/zbCygdPS7wZLbXWP/99y224=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH 4/4] mmc: host: s3cmci: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 10:25:31 +0200
Message-Id: <20190612082531.2652-4-gregkh@linuxfoundation.org>
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
never do something different based on this.

Also, because there is no need to save the file dentries, remove them
from the host-specific structure and just recursively delete the
directory that the driver created, when shutting down.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/s3cmci.c | 27 ++++++---------------------
 drivers/mmc/host/s3cmci.h |  2 --
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f31333e831a7..6a91db7ca5f1 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1452,33 +1452,18 @@ DEFINE_SHOW_ATTRIBUTE(s3cmci_regs);
 static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 {
 	struct device *dev = &host->pdev->dev;
+	struct dentry *root;
 
-	host->debug_root = debugfs_create_dir(dev_name(dev), NULL);
-	if (IS_ERR(host->debug_root)) {
-		dev_err(dev, "failed to create debugfs root\n");
-		return;
-	}
-
-	host->debug_state = debugfs_create_file("state", 0444,
-						host->debug_root, host,
-						&s3cmci_state_fops);
-
-	if (IS_ERR(host->debug_state))
-		dev_err(dev, "failed to create debug state file\n");
-
-	host->debug_regs = debugfs_create_file("regs", 0444,
-					       host->debug_root, host,
-					       &s3cmci_regs_fops);
+	root = debugfs_create_dir(dev_name(dev), NULL);
+	host->debug_root = root;
 
-	if (IS_ERR(host->debug_regs))
-		dev_err(dev, "failed to create debug regs file\n");
+	debugfs_create_file("state", 0444, root, host, &s3cmci_state_fops);
+	debugfs_create_file("regs", 0444, root, host, &s3cmci_regs_fops);
 }
 
 static void s3cmci_debugfs_remove(struct s3cmci_host *host)
 {
-	debugfs_remove(host->debug_regs);
-	debugfs_remove(host->debug_state);
-	debugfs_remove(host->debug_root);
+	debugfs_remove_recursive(host->debug_root);
 }
 
 #else
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..62cae53b4271 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -70,8 +70,6 @@ struct s3cmci_host {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*debug_root;
-	struct dentry		*debug_state;
-	struct dentry		*debug_regs;
 #endif
 
 #ifdef CONFIG_ARM_S3C24XX_CPUFREQ
-- 
2.22.0

