Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A176515B5
	for <lists+linux-mmc@lfdr.de>; Mon, 19 Dec 2022 23:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLSWxb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Dec 2022 17:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLSWxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 17:53:31 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C5A512D36
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 14:53:30 -0800 (PST)
Received: from thinkpadx1.corp.microsoft.com (S010600cb7a0d6c8b.vs.shawcable.net [96.55.249.129])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3402720C3325;
        Mon, 19 Dec 2022 14:53:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3402720C3325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1671490410;
        bh=iXc3F7khg/zcyToecA7B8GLPog8CVd8/PHEOuZqrMFw=;
        h=From:To:Cc:Subject:Date:From;
        b=lXCVotsyhbialahtDPGwFavoXzyTXBiS+9rtPe7w2cMhR1s8aGKFAy3MufApPk8bq
         tMJ9RdOccsEMas+TQHJqz/TP/ujJIMSC00RBrwE9Xpcj0RKStfkDmcWp5ZcFu9HSRQ
         wGKcmabYariiGxWVRRBscKZ0wXLfwlCb/uo7HK2U=
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Subject: [PATCH] mmc: core: host: fix mmc retuning
Date:   Mon, 19 Dec 2022 14:53:19 -0800
Message-Id: <20221219225319.24637-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As per the JEDEC spec, tuning(command CMD21) is not allowed in
RPMB partition.

To avoid retuning while switching to RPMB, hold_retune variable was
introduced but it is not taken into account while making the tuning
decision. As a consequence of this, mmc driver aborts while switching to
RPMB partition:
 mmc0: mmc_hs400_to_hs200 failed, error -84

To fix this, take hold_retune variable into account while making retune
decision in mmc_retune() function.

Fixes: 57da0c042f4a ("mmc: block: Pause re-tuning while switched to the RPMB partition")
Reported-by: Judy Wang <wangjudy@linux.microsoft.com>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/mmc/core/host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b89dca1f15e9..342c1f5c256b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -181,6 +181,9 @@ int mmc_retune(struct mmc_host *host)
 	bool return_to_hs400 = false;
 	int err;
 
+	if (host->hold_retune >= 1)
+		return 0;
+
 	if (host->retune_now)
 		host->retune_now = 0;
 	else
-- 
2.34.1

