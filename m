Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F37723858
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Jun 2023 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjFFHFe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 6 Jun 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFFHFd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jun 2023 03:05:33 -0400
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 00:05:32 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B97E42
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jun 2023 00:05:32 -0700 (PDT)
Received: from xps.geanix.com (unknown [87.54.11.140])
        by first.geanix.com (Postfix) with ESMTPSA id D467D4E2838;
        Tue,  6 Jun 2023 06:59:49 +0000 (UTC)
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=martin@geanix.com smtp.mailfrom=martin@geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1686034790; bh=PWNQ09ijoe1DVvYJBNyrmhSiGQflwUabh55Y0/h4L1c=;
        h=From:To:Cc:Subject:Date;
        b=f8lJ5bAdZwyI7auhIQ7ItkEZ4qysN5Dl+emu2B7RywGiKcr3FFMQWPvER1ZA6ScK7
         2tnmbKnDC4/vRbcWkRmz6ShT3zFghuRUp/vVvrlQieZz53HFdVO/U5IodZsBQHxaeS
         QMdeEw4GhEDmKcLejFIS3OK7LVxg/Ktc/i/6uqiMK7J4eSK+Eucv8TVLBuKuOyhGLW
         XhI/n7LDvTcC0xsV/OGLZfJE6gAd3BZ+g0Q6oSJEyo9yDsSaaxmxzQWvv5BVHb3u2A
         qMKeQEPbvZaUoXKmzN1nWqrbZQqztvBhga7Z+jgyaTuKRbIDVMUJkMOi6sw+V2ctXI
         6DUSHPVs5Naeg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@rtx.dk>,
        stable@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: meson: move mmc_request_done() call to irq thread
Date:   Tue,  6 Jun 2023 08:59:17 +0200
Message-Id: <20230606065918.460866-1-martin@geanix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Martin Hundebøll <mhu@rtx.dk>

The call to mmc_request_done() can schedule, so it cannot be called from
irq context. Wake the irq thread if it needs to be called, and call it
from there instead.

Fixes the following kernel bug, which appears when running an RT patched
kernel on the AmLogic Meson AXG A113X SoC:
[   11.111407] BUG: scheduling while atomic: kworker/0:1H/75/0x00010001
[   11.111438] Modules linked in:
[   11.111451] CPU: 0 PID: 75 Comm: kworker/0:1H Not tainted 6.4.0-rc3-rt2-rtx-00081-gfd07f41ed6b4-dirty #1
[   11.111461] Hardware name: RTX AXG A113X Linux Platform Board (DT)
[   11.111469] Workqueue: kblockd blk_mq_run_work_fn
[   11.111492] Call trace:
[   11.111497]  dump_backtrace+0xac/0xe8
[   11.111510]  show_stack+0x18/0x28
[   11.111518]  dump_stack_lvl+0x48/0x60
[   11.111530]  dump_stack+0x18/0x24
[   11.111537]  __schedule_bug+0x4c/0x68
[   11.111548]  __schedule+0x80/0x574
[   11.111558]  schedule_loop+0x2c/0x50
[   11.111567]  schedule_rtlock+0x14/0x20
[   11.111576]  rtlock_slowlock_locked+0x468/0x730
[   11.111587]  rt_spin_lock+0x40/0x64
[   11.111596]  __wake_up_common_lock+0x5c/0xc4
[   11.111610]  __wake_up+0x18/0x24
[   11.111620]  mmc_blk_mq_req_done+0x68/0x138
[   11.111633]  mmc_request_done+0x104/0x118
[   11.111644]  meson_mmc_request_done+0x38/0x48
[   11.111654]  meson_mmc_irq+0x128/0x1f0
[   11.111663]  __handle_irq_event_percpu+0x70/0x114
[   11.111674]  handle_irq_event_percpu+0x18/0x4c
[   11.111683]  handle_irq_event+0x80/0xb8
[   11.111691]  handle_fasteoi_irq+0xa4/0x120
[   11.111704]  handle_irq_desc+0x20/0x38
[   11.111712]  generic_handle_domain_irq+0x1c/0x28
[   11.111721]  gic_handle_irq+0x8c/0xa8
[   11.111735]  call_on_irq_stack+0x24/0x4c
[   11.111746]  do_interrupt_handler+0x88/0x94
[   11.111757]  el1_interrupt+0x34/0x64
[   11.111769]  el1h_64_irq_handler+0x18/0x24
[   11.111779]  el1h_64_irq+0x64/0x68
[   11.111786]  __add_wait_queue+0x0/0x4c
[   11.111795]  mmc_blk_rw_wait+0x84/0x118
[   11.111804]  mmc_blk_mq_issue_rq+0x5c4/0x654
[   11.111814]  mmc_mq_queue_rq+0x194/0x214
[   11.111822]  blk_mq_dispatch_rq_list+0x3ac/0x528
[   11.111834]  __blk_mq_sched_dispatch_requests+0x340/0x4d0
[   11.111847]  blk_mq_sched_dispatch_requests+0x38/0x70
[   11.111858]  blk_mq_run_work_fn+0x3c/0x70
[   11.111865]  process_one_work+0x17c/0x1f0
[   11.111876]  worker_thread+0x1d4/0x26c
[   11.111885]  kthread+0xe4/0xf4
[   11.111894]  ret_from_fork+0x10/0x20

Fixes: 51c5d8447bd71b ("MMC: meson: initial support for GX platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8514d9d5e736..77b2c23084566 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -991,11 +991,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		ret = IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -1007,9 +1004,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
 	return ret;
 }
 
@@ -1040,6 +1034,13 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
+	if (!meson_mmc_bounce_buf_read(cmd->data) &&
+	    !meson_mmc_get_next_command(cmd)) {
+		meson_mmc_request_done(host->mmc, cmd->mrq);
+
+		return IRQ_HANDLED;
+	}
+
 	if (cmd->error) {
 		meson_mmc_wait_desc_stop(host);
 		meson_mmc_request_done(host->mmc, cmd->mrq);
-- 
2.40.1

