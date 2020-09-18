Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD0A270896
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Sep 2020 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIRVyy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Sep 2020 17:54:54 -0400
Received: from www.zeus03.de ([194.117.254.33]:60666 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIRVyy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Sep 2020 17:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=jk7fPuKY5hSB9cDfqkG3ZcdckkV
        xhJDEcEH1RscvAls=; b=uplJwOavBBXplR90PTRYq8rgVytPXGWVaO4ycTNU6X8
        NVJOjQcUtARavfaU/Ccp1J3rspVw0Prr4a0GW55lwvqSOTFL9AYXUMAhl2sElTFi
        yriGLDiqbf9jb3wIM8EGfB1NPFkLMl+3yB/J6eagErU8cSOfxqDxJYAd6sWY/lo8
        =
Received: (qmail 3465932 invoked from network); 18 Sep 2020 23:54:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Sep 2020 23:54:51 +0200
X-UD-Smtp-Session: l3s3148p1@k97TjJ2vSIdQT+F6
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] mmc: core: document mmc_hw_reset()
Date:   Fri, 18 Sep 2020 23:54:46 +0200
Message-Id: <20200918215446.65654-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for mmc_hw_reset to make sure the intended use case is
clear.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v1:
* make clear it is a full reset
* don't say "remote card"

 drivers/mmc/core/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ccae6452b9c..d42037f0f10d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2063,6 +2063,16 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	host->ops->hw_reset(host);
 }
 
+/**
+ * mmc_hw_reset - reset the card in hardware
+ * @host: MMC host to which the card is attached
+ *
+ * Hard reset the card. This function is only for upper layers, like the
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

