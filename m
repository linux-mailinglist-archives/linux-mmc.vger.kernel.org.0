Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98575D04
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 04:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGZCcc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 22:32:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38289 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfGZCcc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 22:32:32 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so26497865ioa.5
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvMJli8NHSKDAHifvd4mqwlXmA4+W/QcIYCVNp+7iZE=;
        b=sZ/58jVkrV0CvSSAhltl5f5tc/eNj9HEXngbCN8X49SS2GPj/eJGReSD7ifujhA2ap
         iYV/ebGtfYbsi8FhipvYWsAR8/F3aun+zkXfLJTOsKf2BuzXrazISTHaUMTLpv5MiSll
         o0/ua6V53pGxhhsYTRm5heE0hPcK2qyqgkvuszgXIxon6K17wjWVgbdyJCmoB2plEjXC
         57w/LDk1yNoALVw5szPFroOKDGhSSNKo/3kYRAIEuCjEpYKvAUBiFeNKhIMtCwOjPYCf
         SvxGnsIvd6Cdun+P6ERM7c0Gl8ih9DZU9c6CbS2TYUJXjP7n/2mZgmcDvQvXLw3EN93J
         UlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvMJli8NHSKDAHifvd4mqwlXmA4+W/QcIYCVNp+7iZE=;
        b=s1odf6qgOiVp1kAaK9K0WBBLVVWVWxey4yEURkDaNHxzYNlK5pIge2Ajy7n+sXoRgH
         sGaySOnVOde4BqeDKeismWQZUTOJqZb3suQKVb937WZk1W6aajYpMza5f5+SxieSyXTS
         OSsjrUU96bPu1/ya5B8a4tVOWVNL25QzPK8HoVqpDxKHJZCWgUXEJtmoyHU/UGAoNkaJ
         FezcwsFDl3eznwdSOBa/9o7BR+vsHWyOqr0Y1N0tQnUIjvfYFfsLxWY6GjWSHv1OCf5b
         GBsi1Ud1EXt/JhlCKIcDIoKLLYJwd9+7Rtnxwt2FlxQTt1LsNp3FJUbx7sVP1UgM1vC6
         0Vnw==
X-Gm-Message-State: APjAAAVz9Ig/FS7houGNamw24743bVJ/g3dKDs4pmRW3GdumH7gsQkap
        dj4Kzhy+XylmqelLkfs8JAt2e0ZeClg=
X-Google-Smtp-Source: APXvYqx2H4Zdz5Rw3uFzXwmB45mIB/3xxQwBuj/m2DcoVP8Esxe8+c33Nb4oCeReeuIJyZxf+GkD/w==
X-Received: by 2002:a02:340d:: with SMTP id x13mr95638956jae.125.1564108350840;
        Thu, 25 Jul 2019 19:32:30 -0700 (PDT)
Received: from pek-lpggp6.wrs.com ([60.247.85.82])
        by smtp.gmail.com with ESMTPSA id c81sm79643973iof.28.2019.07.25.19.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 19:32:30 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: cavium: Set the correct dma max segment size for mmc_host
Date:   Fri, 26 Jul 2019 10:30:48 +0800
Message-Id: <20190726023049.27055-2-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190726023049.27055-1-haokexin@gmail.com>
References: <20190726023049.27055-1-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We have set the mmc_host.max_seg_size to 8M, but the dma max segment
size of PCI device is set to 64K by default in function pci_device_add().
The mmc_host.max_seg_size is used to set the max segment size of
the blk queue. Then this mismatch will trigger a calltrace like below
when a bigger than 64K segment request arrives at mmc dev. So we should
consider the limitation of the cvm_mmc_host when setting the
mmc_host.max_seg_size.
  DMA-API: thunderx_mmc 0000:01:01.4: mapping sg segment longer than device claims to support [len=131072] [max=65536]
  WARNING: CPU: 6 PID: 238 at kernel/dma/debug.c:1221 debug_dma_map_sg+0x2b8/0x350
  Modules linked in:
  CPU: 6 PID: 238 Comm: kworker/6:1H Not tainted 5.3.0-rc1-next-20190724-yocto-standard+ #62
  Hardware name: Marvell OcteonTX CN96XX board (DT)
  Workqueue: kblockd blk_mq_run_work_fn
  pstate: 80c00009 (Nzcv daif +PAN +UAO)
  pc : debug_dma_map_sg+0x2b8/0x350
  lr : debug_dma_map_sg+0x2b8/0x350
  sp : ffff00001770f9e0
  x29: ffff00001770f9e0 x28: ffffffff00000000
  x27: 00000000ffffffff x26: ffff800bc2c73180
  x25: ffff000010e83700 x24: 0000000000000002
  x23: 0000000000000001 x22: 0000000000000001
  x21: 0000000000000000 x20: ffff800bc48ba0b0
  x19: ffff800bc97e8c00 x18: ffffffffffffffff
  x17: 0000000000000000 x16: 0000000000000000
  x15: ffff000010e835c8 x14: 6874207265676e6f
  x13: 6c20746e656d6765 x12: 7320677320676e69
  x11: 7070616d203a342e x10: 31303a31303a3030
  x9 : 303020636d6d5f78 x8 : 35363d78616d5b20
  x7 : 00000000000002fd x6 : ffff000010fd57dc
  x5 : 0000000000000000 x4 : ffff0000106c61f0
  x3 : 00000000ffffffff x2 : 0000800bee060000
  x1 : 7010678df3041a00 x0 : 0000000000000000
  Call trace:
   debug_dma_map_sg+0x2b8/0x350
   cvm_mmc_request+0x3c4/0x988
   __mmc_start_request+0x9c/0x1f8
   mmc_start_request+0x7c/0xb0
   mmc_blk_mq_issue_rq+0x5c4/0x7b8
   mmc_mq_queue_rq+0x11c/0x278
   blk_mq_dispatch_rq_list+0xb0/0x568
   blk_mq_do_dispatch_sched+0x6c/0x108
   blk_mq_sched_dispatch_requests+0x110/0x1b8
   __blk_mq_run_hw_queue+0xb0/0x118
   blk_mq_run_work_fn+0x28/0x38
   process_one_work+0x210/0x490
   worker_thread+0x48/0x458
   kthread+0x130/0x138
   ret_from_fork+0x10/0x1c

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/cavium.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index ed5cefb83768..c956813bc6bd 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -1046,7 +1046,8 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 		mmc->max_segs = 1;
 
 	/* DMA size field can address up to 8 MB */
-	mmc->max_seg_size = 8 * 1024 * 1024;
+	mmc->max_seg_size = min_t(unsigned int, 8 * 1024 * 1024,
+				  dma_get_max_seg_size(host->dev));
 	mmc->max_req_size = mmc->max_seg_size;
 	/* External DMA is in 512 byte blocks */
 	mmc->max_blk_size = 512;
-- 
2.14.4

