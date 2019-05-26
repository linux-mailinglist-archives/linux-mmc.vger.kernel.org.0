Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28252A93A
	for <lists+linux-mmc@lfdr.de>; Sun, 26 May 2019 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfEZKGp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 26 May 2019 06:06:45 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:59920 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfEZKGp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 26 May 2019 06:06:45 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 06:06:44 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45BbCV0Tr1z7y;
        Sun, 26 May 2019 11:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1558864710; bh=xFhD3PrYcISDNA5a1ZSfg5VvH6tzP5FPsK/gd/AMyBE=;
        h=Date:From:Subject:To:Cc:From;
        b=P2grKcZOi8I5w2cXyjbePYF7zG0iNIxC450cYBMNQh6sl3seSyjtpXqIVD/x7Yz1k
         T1Ea7/hRAaq7blTCd9tISoXhXQerNbLFkYsKjRYyAHE36Hnqvv5RTgWIfAKJ2ZU3ii
         6CK3uSf24XAOUS09wIXZ22G0ADLpyq5Az5C9BWKfeqF9lX/mpoGqElW/YfXquGTMtq
         letYja5U9Z7jPSIits+hODMRea14jFjCwtruLY8fAS2p5IWNm5Bjw50aPaf7NnhHix
         hq8OyrqM93VyU7/ttDHCz1qZ4ovuF3hDggzrjhoXgD3sGLFfXYAZT48iohDbn97hEL
         vpiQwTcDnbQ3A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sun, 26 May 2019 11:59:59 +0200
Message-Id: <dac73f0ed3a3ed5416dcecd3ac5fdcff3d4232fd.1558864586.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: Allow setting slot index via devicetree alias
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As with gpio, uart and others, allow specifying the name_idx via the
aliases-node in the devicetree.

Since commit 9aaf3437aa72 mmcblkX nodes are fixed against mmcX host.
This extension allows embedded devices to keep the same rootfs device
index between board versions using different MMC controllers.

Rewritten for current kernel version from original patch by Sascha Hauer.
> https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg26472.html

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
against v5.1.5
---
 drivers/mmc/core/host.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a79904..0ffab498b66f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -411,7 +411,17 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 
-	err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	err = of_alias_get_id(dev->of_node, "mmc");
+	if (err >= 0)
+		err = ida_alloc_range(&mmc_host_ida, err, err, GFP_KERNEL);
+	if (err < 0) {
+		err = of_alias_get_highest_id("mmc");
+		if (err < 0)
+			err = 0;
+		else
+			++err;
+		err = ida_alloc_min(&mmc_host_ida, err, GFP_KERNEL);
+	}
 	if (err < 0) {
 		kfree(host);
 		return NULL;
-- 
2.20.1

