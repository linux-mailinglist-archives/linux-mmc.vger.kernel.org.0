Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56226C00A
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Sep 2020 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIPJBi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Sep 2020 05:01:38 -0400
Received: from www.zeus03.de ([194.117.254.33]:57938 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgIPJBh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Sep 2020 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=7kb+F2bvxmBG8X/Ty0ZF3ZbyH/Z
        6biJTdAu4JDoS9bw=; b=S9o15MDnmsIFZwubZq7mWq9aWAwHXQchVx8Uaj6rosC
        yxGIg5DOvygoySCw5EeSvPwH0RjPUHT3xvUs9nnzDMmbO7k7wSqxZGOD4sy4GDFZ
        89VsRde9xoA/UIhfQNTDeGFmtuAndi8BgwjwMxNsSmFdSy8soCwGbFw2xXZF2NDw
        =
Received: (qmail 2516260 invoked from network); 16 Sep 2020 11:01:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2020 11:01:34 +0200
X-UD-Smtp-Session: l3s3148p1@qSyug2qv+w8ut2cR
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: core: document mmc_hw_reset
Date:   Wed, 16 Sep 2020 11:01:21 +0200
Message-Id: <20200916090121.2350-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for mmc_hw_reset to make sure the intended use case is
clear.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

While working on this, I get the feeling this function should be renamed
to 'mmc_card_reset' or something similar. 'hw' is still confusing
because it could easily be the host controller, too. I volunteer to
prepare a patch if we can agree on a better name.

 drivers/mmc/core/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ccae6452b9c..a9ad72a18d1b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2063,6 +2063,16 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	host->ops->hw_reset(host);
 }
 
+/**
+ * mmc_hw_reset - reset the card
+ * @host: MMC host to which the card is attached
+ *
+ * Reset the remote card. This function is only for upper layers, like the
+ * block layer or card drivers. You cannot use it in host drivers (struct
+ * mmc_card might be gone then).
+ *
+ * Return: 0 on success, -errno on failure
+ */
 int mmc_hw_reset(struct mmc_host *host)
 {
 	int ret;
-- 
2.28.0

