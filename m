Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F81DB69
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 07:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfD2FOd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 01:14:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfD2FOd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 01:14:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so4558828pgg.13
        for <linux-mmc@vger.kernel.org>; Sun, 28 Apr 2019 22:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYyhLtHM+eiCpdYqHcABaA9HcjRLhQt4MRCsPWQ9DSE=;
        b=1/1tnI6/ywXfJkboj2WNvC/qFQxBX3LYmBKw5yvBYVxI12e1NF5RwaSkl5Wji9Ga2s
         ePpBmFGXt1661C9Y0i2xT9WyfTGzPxIUP8GCR4X6z0/djHWzF5ffdqpy4MJ2c9trlDk7
         VdEKNBR54WW7+n3VcrrT3fwcUTU9hqgLsEzcTTXzjVUmvjnH5PswY+7vhfyp6s37LsVO
         eSNQu7cD9RqBe7/GUbu8sKl6wieV1HTz4C5zLhVwLprLRXrp69td3v2qTl2VGXuWm+TI
         QBEdYR4Hj7vG10Q91HC7LBEvw3g7B+WGO6RnUsctAH0TwJvlthhNPx5NbZA4d8JAhP4A
         aviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYyhLtHM+eiCpdYqHcABaA9HcjRLhQt4MRCsPWQ9DSE=;
        b=aQK5XG4mf1TqZ2yYHyVF4mruGKqSHO77utbp7RBR5d6zeorT1LN9cBXi1ue2FFl66w
         BfxLDSeQaoVgaaG6V7fC6P8fKkDyqgus4iaLT2dGsaK8Jtmno+SqU4seekVoesk8Jqfx
         HxLPNCl3xg5bkB6fAul10XXgB82jCbjnMUKVLo/cJ7gxb9KytBEXzRRgfpbY5yvbGC6f
         Z4kaigy6uLwCgtV2aVxo8dLTgf1+q3fosRRS2mbmVgn5oIpne431T2bCHiVR0GCkWnxD
         nDM0QYwgCyEylof0h763W0x5eytdsPibIcvPzNiXrzvKV2yOVFk/JUXFdicqR4nSi2Ah
         vpqw==
X-Gm-Message-State: APjAAAUFRWX+IHCQwBFWX16kJGStI8/g5TdAobipB09kPdYQmrwofApy
        Pjws9IAJEM4KDct173m8aGEmKA==
X-Google-Smtp-Source: APXvYqxoPQ/35lIlLIozGdeGPeav8blC7bUJAuwJ1I78NVIkeEFIGBETue4cUFGgET7okc+Uh2oNBg==
X-Received: by 2002:a65:5089:: with SMTP id r9mr56643561pgp.14.1556514871778;
        Sun, 28 Apr 2019 22:14:31 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id x5sm49727866pfi.91.2019.04.28.22.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:14:30 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux@endlessm.com,
        jin.tsai@alcorlink.com, linux@rempel-privat.de, arnd@arndb.de,
        jgg@mellanox.com
Subject: [PATCH 1/2] Revert "mmc: alcor: enable DMA transfer of large buffers"
Date:   Mon, 29 Apr 2019 13:14:25 +0800
Message-Id: <20190429051426.7558-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This reverts commit 57ebb96c293da9f0ec56aba13c5541269a5c10b1.

Usage of the DMA page iterator was problematic here because
we were not considering offset & length of entries in the scatterlist.

Also, after further discussion, the suggested revised approach is much
more similar to the driver implementation before this commit was
applied, so revert it.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/mmc/host/alcor.c | 88 ++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index bb4291d50a5d..dccf68e36d9b 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -54,9 +54,9 @@ struct alcor_sdmmc_host {
 	struct delayed_work timeout_work;
 
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
-	struct sg_dma_page_iter sg_diter;	/* SG state for DMA */
 	struct scatterlist *sg;
 	unsigned int blocks;		/* remaining PIO blocks */
+	int sg_count;
 
 	u32			irq_status_sd;
 	unsigned char		cur_power_mode;
@@ -117,19 +117,30 @@ static void alcor_reset(struct alcor_sdmmc_host *host, u8 val)
 	dev_err(host->dev, "%s: timeout\n", __func__);
 }
 
-/*
- * Perform DMA I/O of a single page.
- */
 static void alcor_data_set_dma(struct alcor_sdmmc_host *host)
 {
 	struct alcor_pci_priv *priv = host->alcor_pci;
-	dma_addr_t addr;
+	u32 addr;
+
+	if (!host->sg_count)
+		return;
 
-	if (!__sg_page_iter_dma_next(&host->sg_diter))
+	if (!host->sg) {
+		dev_err(host->dev, "have blocks, but no SG\n");
 		return;
+	}
 
-	addr = sg_page_iter_dma_address(&host->sg_diter);
-	alcor_write32(priv, (u32) addr, AU6601_REG_SDMA_ADDR);
+	if (!sg_dma_len(host->sg)) {
+		dev_err(host->dev, "DMA SG len == 0\n");
+		return;
+	}
+
+
+	addr = (u32)sg_dma_address(host->sg);
+
+	alcor_write32(priv, addr, AU6601_REG_SDMA_ADDR);
+	host->sg = sg_next(host->sg);
+	host->sg_count--;
 }
 
 static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
@@ -142,29 +153,12 @@ static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
 		ctrl |= AU6601_DATA_WRITE;
 
 	if (data->host_cookie == COOKIE_MAPPED) {
-		/*
-		 * For DMA transfers, this function is called just once,
-		 * at the start of the operation. The hardware can only
-		 * perform DMA I/O on a single page at a time, so here
-		 * we kick off the transfer with the first page, and expect
-		 * subsequent pages to be transferred upon IRQ events
-		 * indicating that the single-page DMA was completed.
-		 */
-		__sg_page_iter_start(&host->sg_diter.base, data->sg,
-				     data->sg_len, 0);
-
 		alcor_data_set_dma(host);
 		ctrl |= AU6601_DATA_DMA_MODE;
 		host->dma_on = 1;
-		alcor_write32(priv, data->blksz * data->blocks,
+		alcor_write32(priv, data->sg_count * 0x1000,
 			       AU6601_REG_BLOCK_SIZE);
 	} else {
-		/*
-		 * For PIO transfers, we break down each operation
-		 * into several sector-sized transfers. When one sector has
-		 * complete, the IRQ handler will call this function again
-		 * to kick off the transfer of the next sector.
-		 */
 		alcor_write32(priv, data->blksz, AU6601_REG_BLOCK_SIZE);
 	}
 
@@ -239,8 +233,9 @@ static void alcor_prepare_data(struct alcor_sdmmc_host *host,
 	host->data->bytes_xfered = 0;
 	host->blocks = data->blocks;
 	host->sg = data->sg;
+	host->sg_count = data->sg_count;
 	dev_dbg(host->dev, "prepare DATA: sg %i, blocks: %i\n",
-			data->sg_count, host->blocks);
+			host->sg_count, host->blocks);
 
 	if (data->host_cookie != COOKIE_MAPPED)
 		alcor_prepare_sg_miter(host);
@@ -489,6 +484,9 @@ static int alcor_data_irq_done(struct alcor_sdmmc_host *host, u32 intmask)
 		alcor_trf_block_pio(host, false);
 		return 1;
 	case AU6601_INT_DMA_END:
+		if (!host->sg_count)
+			break;
+
 		alcor_data_set_dma(host);
 		break;
 	default:
@@ -525,7 +523,8 @@ static void alcor_data_irq_thread(struct alcor_sdmmc_host *host, u32 intmask)
 	if (alcor_data_irq_done(host, intmask))
 		return;
 
-	if ((intmask & AU6601_INT_DATA_END) || !host->blocks || host->dma_on)
+	if ((intmask & AU6601_INT_DATA_END) || !host->blocks ||
+	    (host->dma_on && !host->sg_count))
 		alcor_finish_data(host);
 }
 
@@ -763,7 +762,8 @@ static void alcor_pre_req(struct mmc_host *mmc,
 	struct alcor_sdmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 	struct mmc_command *cmd = mrq->cmd;
-	unsigned int sg_len;
+	struct scatterlist *sg;
+	unsigned int i, sg_len;
 
 	if (!data || !cmd)
 		return;
@@ -785,6 +785,11 @@ static void alcor_pre_req(struct mmc_host *mmc,
 	if (data->blksz & 3)
 		return;
 
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		if (sg->length != AU6601_MAX_DMA_BLOCK_SIZE)
+			return;
+	}
+
 	/* This data might be unmapped at this time */
 
 	sg_len = dma_map_sg(host->dev, data->sg, data->sg_len,
@@ -1031,13 +1036,26 @@ static void alcor_init_mmc(struct alcor_sdmmc_host *host)
 	mmc->caps2 = MMC_CAP2_NO_SDIO;
 	mmc->ops = &alcor_sdc_ops;
 
-	/*
-	 * Enable large requests through iteration of scatterlist pages.
-	 * Limit to 240 sectors per request like the original vendor driver.
+	/* The hardware does DMA data transfer of 4096 bytes to/from a single
+	 * buffer address. Scatterlists are not supported, but upon DMA
+	 * completion (signalled via IRQ), the original vendor driver does
+	 * then immediately set up another DMA transfer of the next 4096
+	 * bytes.
+	 *
+	 * This means that we need to handle the I/O in 4096 byte chunks.
+	 * Lacking a way to limit the sglist entries to 4096 bytes, we instead
+	 * impose that only one segment is provided, with maximum size 4096,
+	 * which also happens to be the minimum size. This means that the
+	 * single-entry sglist handled by this driver can be handed directly
+	 * to the hardware, nice and simple.
+	 *
+	 * Unfortunately though, that means we only do 4096 bytes I/O per
+	 * MMC command. A future improvement would be to make the driver
+	 * accept sg lists and entries of any size, and simply iterate
+	 * through them 4096 bytes at a time.
 	 */
-	mmc->max_segs = 64;
-	mmc->max_seg_size = 240 * 512;
-	mmc->max_blk_count = 240;
+	mmc->max_segs = AU6601_MAX_DMA_SEGMENTS;
+	mmc->max_seg_size = AU6601_MAX_DMA_BLOCK_SIZE;
 	mmc->max_req_size = mmc->max_seg_size;
 }
 
-- 
2.20.1

