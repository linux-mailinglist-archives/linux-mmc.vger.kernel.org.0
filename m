Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770B341F00
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfFLI0P (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 04:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfFLI0O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 04:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB652063F;
        Wed, 12 Jun 2019 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560327974;
        bh=pDnZFBrM5WkaAmxPS8ViAMooGYdIvAxuTw/J7okGn6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AyXQpQWKH3mqProSJix12FLYaraW4hDGdBWhvcuTH+GqJEtHW1RB6MRHlUo4w0B3
         Q1mbenZ01rv7hT1SxM2pjoABaV6Zy8pVMmyQ4QCU3T1514nDPWs7zxpRrQtOBgpLjs
         3mlSUw0Mh0EY9bISxMHWyZTuOSGA539xHPn/XaLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/4] mmc: host: atmel-mci: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 10:25:29 +0200
Message-Id: <20190612082531.2652-2-gregkh@linuxfoundation.org>
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

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/atmel-mci.c | 38 +++++++-----------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 735aa5871358..e1f10c3fa144 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -579,42 +579,18 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 	struct mmc_host		*mmc = slot->mmc;
 	struct atmel_mci	*host = slot->host;
 	struct dentry		*root;
-	struct dentry		*node;
 
 	root = mmc->debugfs_root;
 	if (!root)
 		return;
 
-	node = debugfs_create_file("regs", S_IRUSR, root, host,
-				   &atmci_regs_fops);
-	if (IS_ERR(node))
-		return;
-	if (!node)
-		goto err;
-
-	node = debugfs_create_file("req", S_IRUSR, root, slot,
-				   &atmci_req_fops);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_x32("pending_events", S_IRUSR, root,
-				     (u32 *)&host->pending_events);
-	if (!node)
-		goto err;
-
-	node = debugfs_create_x32("completed_events", S_IRUSR, root,
-				     (u32 *)&host->completed_events);
-	if (!node)
-		goto err;
-
-	return;
-
-err:
-	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
+	debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
+	debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
+	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
+	debugfs_create_x32("pending_events", S_IRUSR, root,
+			   (u32 *)&host->pending_events);
+	debugfs_create_x32("completed_events", S_IRUSR, root,
+			   (u32 *)&host->completed_events);
 }
 
 #if defined(CONFIG_OF)
-- 
2.22.0

