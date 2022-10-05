Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647695F526E
	for <lists+linux-mmc@lfdr.de>; Wed,  5 Oct 2022 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJEKUa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 5 Oct 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJEKU2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF173917
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965224; x=1696501224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Jh13VvZzGFPhxWL+aCBqD8YhZrYTDwgou6rEZvcP2c=;
  b=ZWaYS/USyI8O/NQdpgiRfVj/rRqyo1sRcjAUKyGqnKdZu3L1WVb+kAkm
   GvYxL8V+miOFvYOQOgT81i4ZZkMl9/TdJYAJZkqDggL9AdxALYAckA8GL
   W8rNQp6wqOJKmJkBt8KgZE04N2xNdcNkLhoTFgACRPT3JsOMXDT+hOUTU
   0AW9ZMwf03hjZIjX8NrcG03agaP4WLSz00QksnVTYOxOidDmOL/upUJaB
   PM2C99zIRCbZ44NVEuoJFplTmaDltnXIRrZdFV0xYmT5j1wras6sDiFKP
   xN6Cot+PAeGY41vwXONaWsLvtoytrD3GaET1cSL3coQ7d9GoqUCWpmwd1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110426"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605943"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605943"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 05/14] mmc: bcm2835: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
Date:   Wed,  5 Oct 2022 13:19:42 +0300
Message-Id: <20221005101951.3165-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sg_miter_next() using an sg_mapping_iter with flag SG_MITER_ATOMIC uses
kmap_atomic() to map pages.

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

Remove local_irq_{save,restore}() around sg_miter_{next,stop}().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/bcm2835.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 49acbfa87ab8..440773e3ba55 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -327,7 +327,6 @@ static void bcm2835_dma_complete(void *param)
 
 static void bcm2835_transfer_block_pio(struct bcm2835_host *host, bool is_read)
 {
-	unsigned long flags;
 	size_t blksize;
 	unsigned long wait_max;
 
@@ -335,8 +334,6 @@ static void bcm2835_transfer_block_pio(struct bcm2835_host *host, bool is_read)
 
 	wait_max = jiffies + msecs_to_jiffies(500);
 
-	local_irq_save(flags);
-
 	while (blksize) {
 		int copy_words;
 		u32 hsts = 0;
@@ -421,8 +418,6 @@ static void bcm2835_transfer_block_pio(struct bcm2835_host *host, bool is_read)
 	}
 
 	sg_miter_stop(&host->sg_miter);
-
-	local_irq_restore(flags);
 }
 
 static void bcm2835_transfer_pio(struct bcm2835_host *host)
-- 
2.25.1

