Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CA1E5A73
	for <lists+linux-mmc@lfdr.de>; Thu, 28 May 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgE1IMK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 28 May 2020 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgE1IMJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 04:12:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A1C05BD1E
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 01:12:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so16077211lfd.7
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQk00OdF5LpL5xlOXSrSDqS1InuSH/j3c3d+RMcDSME=;
        b=hYFrV6hnyOyM0TqXYVyo29Mpe9PYRzNEp8rLaIglftrYmaU+1sviJPkAq8BJWc6y/w
         yhY1Pk1ezuwKQRUlNTJu5vNwOoExi7sUy5E0WVr5C/E5gWVz3Z/4o/hfAXYgt35nHeuC
         SWR+WWvBvCn3CoQ2xvQkyWd7+dQ4Jo0vw+Y1bJMTH07IzG6E5b5HNh0umWhC0XM09eUV
         Q6BxXW2N0LtoPpjqx8yJP2DrA+XVGsjEho2ebLZJmUCz1oQuS7vw7/BqumbbtQ1PJMZH
         A81KtK5cZOOvqgdlm0Zzvjm6iSxyfZ1/wEGXgqe7waJEyfZG91NLA/B9SY6hsl34z0Wg
         8HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQk00OdF5LpL5xlOXSrSDqS1InuSH/j3c3d+RMcDSME=;
        b=B+TcWZD7fPZ0som4cUliuUTbImYPjRcr25VHQhNdM2JHrDdU36h+grpt6zXSz7ct7t
         ZPTiollSY388vmhdb6mFueZjZCGMEcPUJKhkoG86/PVAVnP8m6Kjn2HKdDrrDMp8p6QS
         NGTcIIO/ZYZdL+cTH/Ue4+K5JVvFAMEQECFXlGSzgb4lwBs4NtbYBzK2mkXJJhQ4XgC5
         aDG4GfpD0KaRve6P1N8xJvtbXpo/96DPI7jOCCo3B8eKxAOskMLtcRPRDuWOdKr4xRw1
         IHfNkyunp+2ztY9Qe5pfVYvlS9+jplYpGYwengDPlSmCQ2kRrkETdB3qX7U1TiAt1zfl
         czgA==
X-Gm-Message-State: AOAM532xohfmug+ZJgTWQItgYgi5rD5CEqjnzycgE+7wVLn5uf8vT2Ak
        MYf5+WrDRcQMdqaQTcAq58B78Q==
X-Google-Smtp-Source: ABdhPJyrtOTFzXqWYpVxK2jNQGKv40aIylKXBy4gz7zT5WSPDOADC9e2YRecvBb+8sPOeIrhFdhHPA==
X-Received: by 2002:a19:c616:: with SMTP id w22mr1020281lff.123.1590653527967;
        Thu, 28 May 2020 01:12:07 -0700 (PDT)
Received: from localhost.localdomain (c-8cdb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.219.140])
        by smtp.gmail.com with ESMTPSA id y11sm1289351lji.52.2020.05.28.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:12:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block: Flag elevators suitable for single queue
Date:   Thu, 28 May 2020 10:10:03 +0200
Message-Id: <20200528081003.238804-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Kyber block scheduler is not suitable for single hardware
queue devices, so add a new flag for single hardware queue
devices and add that to the deadline and BFQ schedulers
so the Kyber scheduler will not be selected for single queue
devices.

Deadline and BFQ are applicable to single HW queues so flag
each of these as single HW queue-friendly.

Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 block/bfq-iosched.c      | 1 +
 block/elevator.c         | 3 +++
 block/mq-deadline.c      | 3 ++-
 include/linux/elevator.h | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3d411716d7ee..7bf99fd83472 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6812,6 +6812,7 @@ static struct elevator_type iosched_bfq_mq = {
 	.icq_align =		__alignof__(struct bfq_io_cq),
 	.elevator_attrs =	bfq_attrs,
 	.elevator_name =	"bfq",
+	.elevator_features =	ELEVATOR_F_SINGLE_HW_QUEUE,
 	.elevator_owner =	THIS_MODULE,
 };
 MODULE_ALIAS("bfq-iosched");
diff --git a/block/elevator.c b/block/elevator.c
index 4eab3d70e880..ebb4fc875b86 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -678,6 +678,9 @@ void elevator_init_mq(struct request_queue *q)
 	if (unlikely(q->elevator))
 		return;
 
+	if (q->nr_hw_queues == 1)
+		q->required_elevator_features |= ELEVATOR_F_SINGLE_HW_QUEUE;
+
 	if (!q->required_elevator_features)
 		e = elevator_get_default(q);
 	else
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b490f47fd553..324047add271 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -794,7 +794,8 @@ static struct elevator_type mq_deadline = {
 	.elevator_attrs = deadline_attrs,
 	.elevator_name = "mq-deadline",
 	.elevator_alias = "deadline",
-	.elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
+	.elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE |
+	ELEVATOR_F_SINGLE_HW_QUEUE,
 	.elevator_owner = THIS_MODULE,
 };
 MODULE_ALIAS("mq-deadline-iosched");
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 901bda352dcb..03057fa2f569 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -172,6 +172,8 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 
 /* Supports zoned block devices sequential write constraint */
 #define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
+/* Elevator is suitable for single hardware queue devices */
+#define ELEVATOR_F_SINGLE_HW_QUEUE	(1U << 1)
 
 #endif /* CONFIG_BLOCK */
 #endif
-- 
2.25.4

