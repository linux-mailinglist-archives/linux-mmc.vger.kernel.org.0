Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39175D05
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 04:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfGZCcg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 22:32:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42610 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfGZCcg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 22:32:36 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so71258703iob.9
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdyj65YQgBjaBehS8F0vX2SgYkh8IMkkx5aYQz3VAn8=;
        b=BddszUn20fKov99la0ADZoKBBfUqJyhZ9mi7NFMD4Z1MI0ld3uGar4HDEwqt7dEKOh
         IBVRoEWqeDjMWXSi2aq1Ca3a9kt/bnzrzV3G+BpDiud9/q5A+JHhOZ+YKotKeMZZ4Zkz
         JYdCfImWze68mrQmKWKT5Yaq8/9QycTa/Xm6l/KHeH7FYVgqmeU2onUcZ/8D9QwJfNDU
         qqBuT2jZOH/h/n0tJGrFw96sY9DxqSYP/lnFflwCRIfMAriml3UrviRAvNeq4ODmveuw
         yz5Sc0/+uPTTES0faQpIkCh9wcZfS2XCxIEqEwACF+PPXicp68tYhXOQhiY6yIXOTTh+
         wMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdyj65YQgBjaBehS8F0vX2SgYkh8IMkkx5aYQz3VAn8=;
        b=mfhmpggPdcneABR9ri0glo7ZE3XOQcoLmZavxWpWmc+b8ZOcET0C+DNrq3mPBZ7s1Q
         Ay/WB5TSImM/WViXi7fTq5ZVxnolUjgcsX6tKT3RMQpI2W0kPICcdxq8lJ5uvgN/IDlM
         u1tpKxJOBoBPletWT+2cChHcqu+6MG4tG3sr3JwUgAQUvne/qMv34sx/fLSW68xE3+A2
         MWfSb51cfSxyzfh946/ZiPL6MzPtbp/qAhV0sTvmG7GUoAuUmFrZWdTjOmFMySGBD85p
         Y6RGG6+ngci2SJQdoqU8+nXv8lN3tR42/Umcs9AZVIbmnwaxNUl4yNT/bYK+1eFpOnfs
         gZsw==
X-Gm-Message-State: APjAAAUmeLe88vtHaQa6jVSucItXjI/q0Uz2DO/pFjBK5EIZeD98Y4wU
        e926GCYgdYj3oO0O21s3r2UNbYokh/c=
X-Google-Smtp-Source: APXvYqzecYfMvRqeWWXYbIuYdoKNpESMVqTO+O4+Ucq7Ok2QmuDWYNwlJ+jGCZqGjvhP4wuZUZVoUA==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr37645121ioo.274.1564108355013;
        Thu, 25 Jul 2019 19:32:35 -0700 (PDT)
Received: from pek-lpggp6.wrs.com ([60.247.85.82])
        by smtp.gmail.com with ESMTPSA id c81sm79643973iof.28.2019.07.25.19.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 19:32:33 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: cavium: Add the missing dma unmap when the dma has finished.
Date:   Fri, 26 Jul 2019 10:30:49 +0800
Message-Id: <20190726023049.27055-3-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190726023049.27055-1-haokexin@gmail.com>
References: <20190726023049.27055-1-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This fixes the below calltrace when the CONFIG_DMA_API_DEBUG is enabled.
  DMA-API: thunderx_mmc 0000:01:01.4: cpu touching an active dma mapped cacheline [cln=0x000000002fdf9800]
  WARNING: CPU: 21 PID: 1 at kernel/dma/debug.c:596 debug_dma_assert_idle+0x1f8/0x270
  Modules linked in:
  CPU: 21 PID: 1 Comm: init Not tainted 5.3.0-rc1-next-20190725-yocto-standard+ #64
  Hardware name: Marvell OcteonTX CN96XX board (DT)
  pstate: 80400009 (Nzcv daif +PAN -UAO)
  pc : debug_dma_assert_idle+0x1f8/0x270
  lr : debug_dma_assert_idle+0x1f8/0x270
  sp : ffff0000113cfc10
  x29: ffff0000113cfc10 x28: 0000ffff8c880000
  x27: ffff800bc72a0000 x26: ffff000010ff8000
  x25: ffff000010ff8940 x24: ffff000010ff8968
  x23: 0000000000000000 x22: ffff000010e83700
  x21: ffff000010ea2000 x20: ffff000010e835c8
  x19: ffff800bc2c73300 x18: ffffffffffffffff
  x17: 0000000000000000 x16: 0000000000000000
  x15: ffff000010e835c8 x14: 6d20616d64206576
  x13: 69746361206e6120 x12: 676e696863756f74
  x11: 20757063203a342e x10: 31303a31303a3030
  x9 : 303020636d6d5f78 x8 : 3230303030303030
  x7 : 00000000000002fd x6 : ffff000010fd57d0
  x5 : 0000000000000000 x4 : ffff0000106c5210
  x3 : 00000000ffffffff x2 : 0000800bee9c0000
  x1 : 57d5843f4aa62800 x0 : 0000000000000000
  Call trace:
   debug_dma_assert_idle+0x1f8/0x270
   wp_page_copy+0xb0/0x688
   do_wp_page+0xa8/0x5b8
   __handle_mm_fault+0x600/0xd00
   handle_mm_fault+0x118/0x1e8
   do_page_fault+0x200/0x500
   do_mem_abort+0x50/0xb0
   el0_da+0x20/0x24
  ---[ end trace a005534bd23e109f ]---
  DMA-API: Mapped at:
   debug_dma_map_sg+0x94/0x350
   cvm_mmc_request+0x3c4/0x988
   __mmc_start_request+0x9c/0x1f8
   mmc_start_request+0x7c/0xb0
   mmc_blk_mq_issue_rq+0x5c4/0x7b8

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/cavium.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index c956813bc6bd..89deb451e0ac 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -374,6 +374,7 @@ static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 {
 	data->bytes_xfered = data->blocks * data->blksz;
 	data->error = 0;
+	dma_unmap_sg(host->dev, data->sg, data->sg_len, get_dma_dir(data));
 	return 1;
 }
 
-- 
2.14.4

