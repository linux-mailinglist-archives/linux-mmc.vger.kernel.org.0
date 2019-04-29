Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684D8DB6A
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 07:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfD2FOg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 01:14:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33973 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfD2FOg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 01:14:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so3605185pgt.1
        for <linux-mmc@vger.kernel.org>; Sun, 28 Apr 2019 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p96NZ4ONUqFyS7S8iebfNLypxI36LNSXjjfLXXDPg3s=;
        b=fL3rVf/URkwaKof0dkWHZf8WAG0nnzcVH9yhGG15f7f0+Vbpq1vhHYOuKvhVCx4qb2
         WrE2JLtgr8OzzxqaT+CJFqpxiOnR35uN3QU7m/5jZ+rSZg+hPwwH+qOGuRXMT2GkqCaD
         kLoNKcRqLYMYWom6ORj6xomZ1FEViyIifUXYSk3anKHxuuDRkEuV4+RJ/JpAyHd+z/K4
         xW2nqZvP7Jw1/H7m9Q7vgkMFIXueOEn3I/0Uqy1+JP7Va6hLXh4aw+JSmdYLGcDXEbpt
         mw7NSTIOuH9Kr3hS/zpoNIMLly9s0IOZ7CeL1yoVlP4hzZbcIhWEfZJJ76iE8KyrFd03
         nWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p96NZ4ONUqFyS7S8iebfNLypxI36LNSXjjfLXXDPg3s=;
        b=TPnRveUbssKo/Mp/rHCT2WAqFU6NQNvsEHLFyEyUw6sjt9icInQ9mINHzxz4ss/dxN
         o9YuFdrLlxgL5JVi3PY4NoCkBm7VGa9OYk9zAygnj/HPm2hXe+yGpeqoSeGvcZvBC98e
         KAoH7+9jNytjm3DnvZDqkpqYdSgM7dsjmSbZnN3gx2zcyAjPx0BHz/nVGdM/rjCmmOCO
         URXFY9FC9dX5b/4UpRLuPSBPaEM4HwEo4chqeo7e3rZYjTkf121UrdQEiOOUFsmTOSyG
         UwaOexB/h62Je3MP9HZBjvcPvrqg+qWu46w5Fc+bETjucwzzCFMxmlreJ7nGJlHjzrc9
         kziA==
X-Gm-Message-State: APjAAAVGZWm/lpUWqFWuIXuotA/6VU4E7OhZw4+qRH2Vrwa1w6Q9N6Py
        g/YerAGCpQ2r91xXGPkz31Bhyj+pBFI=
X-Google-Smtp-Source: APXvYqyrGjC22W67PnDeVRtrwt466MZxboNYxQWmKJJIoCKfvZU1kkY79jvOA9J1CEC1LEg5CAIFXA==
X-Received: by 2002:aa7:8d8e:: with SMTP id i14mr13718247pfr.121.1556514875297;
        Sun, 28 Apr 2019 22:14:35 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id x5sm49727866pfi.91.2019.04.28.22.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:14:34 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux@endlessm.com,
        jin.tsai@alcorlink.com, linux@rempel-privat.de, arnd@arndb.de,
        jgg@mellanox.com
Subject: [PATCH 2/2] mmc: alcor: work with multiple-entry sglists
Date:   Mon, 29 Apr 2019 13:14:26 +0800
Message-Id: <20190429051426.7558-2-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429051426.7558-1-drake@endlessm.com>
References: <20190429051426.7558-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DMA on this hardware is limited to dealing with a 4096 bytes at a
time. Previously, the driver was set up accordingly to request single-page
DMA buffers, however that had the effect of generating a large number
of small MMC requests for data I/O.

Improve the driver to accept multi-entry scatter-gather lists. The size of
each entry is already capped to 4096 bytes (AU6601_MAX_DMA_BLOCK_SIZE),
matching the hardware requirements. Existing driver code already iterates
through remaining sglist entries after each DMA transfer is complete.

Also add some comments to help clarify the situation, and clear up
some of the confusion I had regarding DMA vs PIO.

Testing with dd, this increases write performance from 2mb/sec to
10mb/sec, and increases read performance from 4mb/sec to 14mb/sec.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: http://lkml.kernel.org/r/CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com
---
 drivers/mmc/host/alcor.c  | 54 ++++++++++++++++++++++++++-------------
 include/linux/alcor_pci.h |  2 +-
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index dccf68e36d9b..f3d7eabb79f7 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -117,6 +117,9 @@ static void alcor_reset(struct alcor_sdmmc_host *host, u8 val)
 	dev_err(host->dev, "%s: timeout\n", __func__);
 }
 
+/*
+ * Perform DMA I/O of a single page.
+ */
 static void alcor_data_set_dma(struct alcor_sdmmc_host *host)
 {
 	struct alcor_pci_priv *priv = host->alcor_pci;
@@ -153,12 +156,26 @@ static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
 		ctrl |= AU6601_DATA_WRITE;
 
 	if (data->host_cookie == COOKIE_MAPPED) {
+		/*
+		 * For DMA transfers, this function is called just once,
+		 * at the start of the operation. The hardware can only
+		 * perform DMA I/O on a single page at a time, so here
+		 * we kick off the transfer with the first page, and expect
+		 * subsequent pages to be transferred upon IRQ events
+		 * indicating that the single-page DMA was completed.
+		 */
 		alcor_data_set_dma(host);
 		ctrl |= AU6601_DATA_DMA_MODE;
 		host->dma_on = 1;
 		alcor_write32(priv, data->sg_count * 0x1000,
 			       AU6601_REG_BLOCK_SIZE);
 	} else {
+		/*
+		 * For PIO transfers, we break down each operation
+		 * into several sector-sized transfers. When one sector has
+		 * complete, the IRQ handler will call this function again
+		 * to kick off the transfer of the next sector.
+		 */
 		alcor_write32(priv, data->blksz, AU6601_REG_BLOCK_SIZE);
 	}
 
@@ -776,8 +793,12 @@ static void alcor_pre_req(struct mmc_host *mmc,
 		return;
 	/*
 	 * We don't do DMA on "complex" transfers, i.e. with
-	 * non-word-aligned buffers or lengths. Also, we don't bother
-	 * with all the DMA setup overhead for short transfers.
+	 * non-word-aligned buffers or lengths. A future improvement
+	 * could be made to use temporary DMA bounce-buffers when these
+	 * requirements are not met.
+	 *
+	 * Also, we don't bother with all the DMA setup overhead for
+	 * short transfers.
 	 */
 	if (data->blocks * data->blksz < AU6601_MAX_DMA_BLOCK_SIZE)
 		return;
@@ -788,6 +809,8 @@ static void alcor_pre_req(struct mmc_host *mmc,
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		if (sg->length != AU6601_MAX_DMA_BLOCK_SIZE)
 			return;
+		if (sg->offset != 0)
+			return;
 	}
 
 	/* This data might be unmapped at this time */
@@ -1037,26 +1060,21 @@ static void alcor_init_mmc(struct alcor_sdmmc_host *host)
 	mmc->ops = &alcor_sdc_ops;
 
 	/* The hardware does DMA data transfer of 4096 bytes to/from a single
-	 * buffer address. Scatterlists are not supported, but upon DMA
-	 * completion (signalled via IRQ), the original vendor driver does
-	 * then immediately set up another DMA transfer of the next 4096
-	 * bytes.
-	 *
-	 * This means that we need to handle the I/O in 4096 byte chunks.
-	 * Lacking a way to limit the sglist entries to 4096 bytes, we instead
-	 * impose that only one segment is provided, with maximum size 4096,
-	 * which also happens to be the minimum size. This means that the
-	 * single-entry sglist handled by this driver can be handed directly
-	 * to the hardware, nice and simple.
+	 * buffer address. Scatterlists are not supported at the hardware
+	 * level, however we can work with them at the driver level,
+	 * provided that each segment is exactly 4096 bytes in size.
+	 * Upon DMA completion of a single segment (signalled via IRQ), we
+	 * immediately proceed to transfer the next segment from the
+	 * scatterlist.
 	 *
-	 * Unfortunately though, that means we only do 4096 bytes I/O per
-	 * MMC command. A future improvement would be to make the driver
-	 * accept sg lists and entries of any size, and simply iterate
-	 * through them 4096 bytes at a time.
+	 * The overall request is limited to 240 sectors, matching the
+	 * original vendor driver.
 	 */
 	mmc->max_segs = AU6601_MAX_DMA_SEGMENTS;
 	mmc->max_seg_size = AU6601_MAX_DMA_BLOCK_SIZE;
-	mmc->max_req_size = mmc->max_seg_size;
+	mmc->max_blk_count = 240;
+	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
+	dma_set_max_seg_size(host->dev, mmc->max_seg_size);
 }
 
 static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
diff --git a/include/linux/alcor_pci.h b/include/linux/alcor_pci.h
index da973e8a2da8..4416df597526 100644
--- a/include/linux/alcor_pci.h
+++ b/include/linux/alcor_pci.h
@@ -23,7 +23,7 @@
 #define AU6601_BASE_CLOCK			31000000
 #define AU6601_MIN_CLOCK			150000
 #define AU6601_MAX_CLOCK			208000000
-#define AU6601_MAX_DMA_SEGMENTS			1
+#define AU6601_MAX_DMA_SEGMENTS			64
 #define AU6601_MAX_PIO_SEGMENTS			1
 #define AU6601_MAX_DMA_BLOCK_SIZE		0x1000
 #define AU6601_MAX_PIO_BLOCK_SIZE		0x200
-- 
2.20.1

