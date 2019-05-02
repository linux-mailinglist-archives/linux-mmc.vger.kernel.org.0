Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CAF12254
	for <lists+linux-mmc@lfdr.de>; Thu,  2 May 2019 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfEBTHX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 2 May 2019 15:07:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33409 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEBTHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 May 2019 15:07:22 -0400
Received: by mail-it1-f193.google.com with SMTP id u16so1398372itc.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 May 2019 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSKRt3WKRfyEbWZKT2Q22cyuORb9Gh6Tvn4Sl4qmV0M=;
        b=Zl8iu0TP2UMpdP29UFkOjInL0C10Yr31yzOT9KYJaorbnymWcvJeNGINAwKzYrKSlp
         1+OSUZ1OAtb+Rx/IldzFFpkSlBqdOwf6DinD4+PGovjuRjmEURBxl4FQHvZoftOznXeM
         ZmH3sh5RjtInG4aRL1RED3+rowII2KaA7wfQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSKRt3WKRfyEbWZKT2Q22cyuORb9Gh6Tvn4Sl4qmV0M=;
        b=K7qFx/IMPvuD59HBL2NhEFCWEoRg82x5OiBLOwDCS24SITP+CFFD0OpSPlghGKOpP8
         ZD5rIFr5hAfsh3REktYscfNmBnZLrDtIB0GLIrhmOE5BXTbm8Poj8XVVy31s2h+ZOxkG
         QRxRmkShZ+R3sy0s5f8vCoFhBZTb/qUtjzp/SlLQGJN1sKsJdOxeodPBd4QWNmRqzWYh
         oB6Mvz1sjdbwNpoJOL1lCi2ylzvptfhCxP+Pob3DZqezuin3dP7e2nve34y5NJw/Pwcq
         q6pEHT2AI/AsfsTnsXTjHTS8u0q3PpnGqb6qFm4GAMTiqWyWqLKmaRGkRpK4kWHyrUxS
         70kA==
X-Gm-Message-State: APjAAAUXgXd18Ybfn5oLb8ijKGISFhTCSDF+ejOU7yz4/8vyjIFFvZaV
        PadEEVuCODhUYdW0sB19M2GQEaOZ6F6tkw==
X-Google-Smtp-Source: APXvYqzdK+GIbc9SB9LRwE/81P6E9I0LoEpNla1HajsEWBv7dWBdjOkuk4jwxW7KkyceTbI3CfEmoA==
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr3770654itb.70.1556824042042;
        Thu, 02 May 2019 12:07:22 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id g13sm2044503iom.46.2019.05.02.12.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:07:21 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     avri.altman@wdc.com, djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: Fix tag set memory leak
Date:   Thu,  2 May 2019 13:07:14 -0600
Message-Id: <20190502190714.181664-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The tag set is allocated in mmc_init_queue but never freed. This results
in a memory leak. This change makes sure we free the tag set when the
queue is also freed.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I found this using kmemleak and plugging and unplugging an SD card in a
few times.

Here is an example of the output of kmemleak:
unreferenced object 0xffff888125be4ce8 (size 8):
  comm "kworker/1:0", pid 17, jiffies 4294901575 (age 204.773s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<0000000061cb8887>] blk_mq_alloc_tag_set+0xe9/0x234
    [<00000000cf532a0f>] mmc_init_queue+0xa9/0x2f0
    [<000000001e085171>] mmc_blk_alloc_req+0x125/0x2f9
    [<00000000eae1bd01>] mmc_blk_probe+0x1e2/0x6c1
    [<00000000a0b4a87d>] really_probe+0x1bd/0x3b0
    [<00000000e58f3eb9>] driver_probe_device+0xe1/0x115
    [<00000000358f3b3c>] bus_for_each_drv+0x89/0xac
    [<00000000ef52ccbe>] __device_attach+0xb0/0x14a
    [<00000000c9daafa7>] bus_probe_device+0x33/0x9f
    [<0000000008ac5779>] device_add+0x34b/0x5e2
    [<00000000b42623cc>] mmc_add_card+0x1f5/0x20d
    [<00000000f114ebc3>] mmc_attach_sd+0xc5/0x14b
    [<000000006e915e0d>] mmc_rescan+0x261/0x2b6
    [<00000000e5b49c26>] process_one_work+0x1d3/0x31f
    [<0000000068c8cd3c>] worker_thread+0x1cd/0x2bf
    [<00000000326e2e22>] kthread+0x14f/0x157

Once I applied this patch the leak went away.

p.s., I included a small white space fix. Hope that's ok.

 drivers/mmc/core/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7c364a9c4eeb..176a08748cf1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -402,7 +402,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 
 	mq->card = card;
 	mq->use_cqe = host->cqe_enabled;
-	
+
 	spin_lock_init(&mq->lock);
 
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
@@ -472,6 +472,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 		blk_mq_unquiesce_queue(q);
 
 	blk_cleanup_queue(q);
+	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*
 	 * A request can be completed before the next request, potentially
-- 
2.21.0.593.g511ec345e18-goog

