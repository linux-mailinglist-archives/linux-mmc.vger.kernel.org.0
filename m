Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7346F835
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 06:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfGVED1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 00:03:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44332 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfGVED0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 00:03:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so18512749plr.11
        for <linux-mmc@vger.kernel.org>; Sun, 21 Jul 2019 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/UT6nFBGLiemyPh9j5mmyVUlus+QEaMqM90W+87124g=;
        b=Isx8xz74JHbAdIF+Y7s1+QSB6Hj5JldQugx/3gN7CebE/bu/q8rKyoxB5ZpcucvF9c
         Ar+zlcuZoJ5hlXngVShTO16Iw6lBHk2eASNKgYaDmiSz4V5u/eQ+Fczylu+3UOFg9p0s
         1gGE9esEmo/SAOXtlz6m+wd8HNdeHEFpr1F6sGQno7rAsXQTC23aEqSss6aN5fuHML57
         rTiEYZRayydJUoY9Ns0abuUVRSOuzUD3mJqUONZ4PbrzEMzDYmWUvcvadXo3Hlp4zaND
         PCU2Fgp72Lq3uxK3kdFln/lKga0w54wf2wJjMiA+tziGaXbJ1jZ5SY3fsy0H7gTNakld
         Sg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/UT6nFBGLiemyPh9j5mmyVUlus+QEaMqM90W+87124g=;
        b=Sakn9UD5IoZDfw6GsAnfYIzTO9WBBuu7PZu2eP5UYFM+7ORywx3Twaskpmv3jHutgG
         0SpWR+AhQFqCW6CGHjDv3ORJQw0iR1BwNpisQzor/PIa+qdyJ/hjN+Xmakn5etj21Jk/
         y6LtpsCKjXI2aLNa7esy5LyyTCxQwUoefC3gRhXdzPhURxW2U4Z/XPTFoWoYhodmc4n8
         UTojAY8DRj7xtClhhan6yqpfIl9Jo1fBg9M54Sh9cigRQgsCha/c2+7spwZZ1m/Quo38
         JqQP6UqaMlgCl9MsadVwsh1+QoCYyxoFX5L8neMWSN9XFHuprcwHNN7fkG1z+Gwwy6Oh
         oorw==
X-Gm-Message-State: APjAAAXMQJvFEBqSXLdu9cddyVlsDIPxNkqf80qbSOeY2yuObUkzmpFj
        WVaQTm29KERLpuGfZPYKKV5vVA==
X-Google-Smtp-Source: APXvYqwgGA2yL3SesDy81OfOm5ZNdAky2hxxUtCqql6KfPU9WL3Qnq1Qzk+KsafZaO9R4XzVslzOHg==
X-Received: by 2002:a17:902:f213:: with SMTP id gn19mr75127027plb.35.1563768206161;
        Sun, 21 Jul 2019 21:03:26 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z20sm60280346pfk.72.2019.07.21.21.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 21:03:25 -0700 (PDT)
From:   shihpo.hung@sifive.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     ShihPo Hung <shihpo.hung@sifive.com>,
        Andreas Koop <andreas.koop@zf.com>, linux-mmc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2] mmc: mmc_spi: Enable stable writes
Date:   Mon, 22 Jul 2019 12:03:06 +0800
Message-Id: <1563768186-22161-1-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ShihPo Hung <shihpo.hung@sifive.com>

From: Andreas Koop <andreas.koop@zf.com>

Hello,

  While using the mmc_spi driver occasionally errors like this popped up:

  mmcblk0: error -84 transferring data
  end_request: I/O error, dev mmcblk0, sector 581756

  I looked on the Internet for occurences of the same problem and came
  across a helpful post [1]. It includes source code to reproduce the bug.
  There is also an analysis about the cause. During transmission data in
  the supplied buffer is being modified. Thus the previously calculated
  checksum is not correct anymore.

  After some digging I found out that device drivers are supposed to
  report they need stable writes.  To fix this I set the appropriate flag
  at queue initialization if CRC checksumming is enabled for that SPI host.

  [1]
  https://groups.google.com/forum/#!msg/sim1/gLlzWeXGFr8/KevXinUXfc8J

Signed-off-by: Andreas Koop <andreas.koop@zf.com>
[shihpo: rebase this on v5.3-rc1]
Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>

Cc: Andreas Koop <andreas.koop@zf.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/mmc/core/queue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index e327f80..7102e2e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
+#include <linux/backing-dev.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -427,6 +428,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 		goto free_tag_set;
 	}
 
+	if (mmc_host_is_spi(host) && host->use_spi_crc)
+		mq->queue->backing_dev_info->capabilities |=
+			BDI_CAP_STABLE_WRITES;
+
 	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
-- 
2.7.4

