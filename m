Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1525C581A3F
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Jul 2022 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiGZTXT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Jul 2022 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZTXT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2022 15:23:19 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 12:23:18 PDT
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F2224F3C
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 12:23:18 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id GQ1woX8sPxFTAGQ1woT8pt; Tue, 26 Jul 2022 21:15:46 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 26 Jul 2022 21:15:46 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/2] mmc: pxamci: Fix an error handling path in pxamci_probe()
Date:   Tue, 26 Jul 2022 21:15:43 +0200
Message-Id: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit in Fixes: has moved some code around without updating gotos to
the error handling path.

Update it now and release some resources if pxamci_of_init() fails.

Fixes: fa3a5115469c ("mmc: pxamci: call mmc_of_parse()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 0db9490dc659..37bf362a0ed5 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -648,7 +648,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	ret = pxamci_of_init(pdev, mmc);
 	if (ret)
-		return ret;
+		goto out;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-- 
2.34.1

