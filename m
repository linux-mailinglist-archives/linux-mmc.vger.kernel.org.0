Return-Path: <linux-mmc+bounces-555-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A872821FC6
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jan 2024 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D638C283C52
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jan 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E5156E0;
	Tue,  2 Jan 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLeZ1SX3"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08B156CE
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5edfcba97e3so49089577b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2024 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214657; x=1704819457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq/GIKYp6XyA0sY1gaMAXPwVYQ+A/mfkTNNf7m8zGBI=;
        b=PLeZ1SX38NE6HAIWZ+Wn2jRRgM17HoCkmptoEIs3u26LE5Y6eZGm/HxCQ9pRNXGBUP
         fQP3KFCoTgQqRQa7fB58YJ+Pon4suEmlBLsNS4L5Xa/FvRH8HoubV4KhmIZje5XTqKiV
         pqWa/8WSW87vU3jUrK4CXP5LVNexM2v8Dk9FJaGN5ddT+2U1e4uOe9BLNCpmGp7/Mpm5
         8llf+YFDeTD3cakpVO9XN7WU+L0eNFmA4QU0UqJjCOEZjwjKA36wmSie/aDFiz64SXNe
         LozffNXHIQbEqcX2sTl2Bafuq+tVUeAZ0M/vM/3T7kabmcr6T5li/5N41S0j/EcGFTJg
         ZC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214657; x=1704819457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cq/GIKYp6XyA0sY1gaMAXPwVYQ+A/mfkTNNf7m8zGBI=;
        b=q9zQYKWAiQpkxQSlZZpaKeRZrKoIZRldtEMmVo9kpn79iB1Ipqhr+5mEQQx+iJ3u3B
         WKmuUIosmIabUMZaKbW19q7ERyXQ3P9S1WCVb5C1ARKqtbdftiW9TCk+zAfaniueihOh
         NOixZmNJJ4IHmkBaBI8uITNCnTOM+1gVu5hPcHYl7Ad60XiPyFYeyGOF7OzMYEWtaQ9/
         iirAIvjnaxW6qF0HDtRLg59F7bcVIk8+lt2bz6p/wgLHHORAhagFx2Xhl7JcSXUIHJcW
         FlmMCTyNwUR6fXe0bdA06xwx9ym1V7UgmuN0eQrgsPYkUeZ1Nc8qDLeYSVnNOp9yry8n
         NfAQ==
X-Gm-Message-State: AOJu0YzUKmylLvkyRiJdbQWLBo8XTbjOfu5UtWLpg5FzJlT0EJSNB7we
	NpRQ5MgHFkawt5UArP3qzWUprFtemWV/J0plNGo/tEejLG4j5w==
X-Google-Smtp-Source: AGHT+IGPeW52oAI6YhwXT0wWFBEQx+DqVdlPmaL4BURC1yeoZCSjcpznYVSaiE8dbuurkKLVAv2oGWxYOT28FOoMtQk=
X-Received: by 2002:a0d:eb15:0:b0:5e8:4f42:fe with SMTP id u21-20020a0deb15000000b005e84f4200femr10937979ywe.50.1704214657382;
 Tue, 02 Jan 2024 08:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207221901.3259962-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231207221901.3259962-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:57:01 +0100
Message-ID: <CAPDyKFr1jG-mCg7Dys2iWd6e9PxBejyi76wsjFCwE9U8ATbODQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: remove custom DMA mapped buffers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Sperl <kernel@martin.sperl.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Dec 2023 at 23:19, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no need to duplicate what SPI core or individual controller
> drivers already do, i.e. mapping the buffers for DMA capable transfers.
>
> Note, that the code, besides its redundancy, was buggy: strictly speaking
> there is no guarantee, while it's true for those which can use this code
> (see below), that the SPI host controller _is_ the device which does DMA.
>
> Also see the Link tags below.
>
> Additional notes. Currently only two SPI host controller drivers may use
> premapped (by the user) DMA buffers:
>
>   - drivers/spi/spi-au1550.c
>
>   - drivers/spi/spi-fsl-spi.c
>
> Both of them have DMA mapping support code. I don't expect that SPI host
> controller code is worse than what has been done in mmc_spi. Hence I do
> not expect any regressions here. Otherwise, I'm pretty much sure these
> regressions have to be fixed in the respective drivers, and not here.
>
> That said, remove all related pieces of DMA mapping code from mmc_spi.
>
> Link: https://lore.kernel.org/linux-mmc/c73b9ba9-1699-2aff-e2fd-b4b4f292a3ca@raspberrypi.org/
> Link: https://stackoverflow.com/questions/67620728/mmc-spi-issue-not-able-to-setup-mmc-sd-card-in-linux
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 186 +------------------------------------
>  1 file changed, 5 insertions(+), 181 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index cc333ad67cac..2a99ffb61f8c 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -15,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/bio.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direction.h>
>  #include <linux/crc7.h>
>  #include <linux/crc-itu-t.h>
>  #include <linux/scatterlist.h>
> @@ -119,19 +119,14 @@ struct mmc_spi_host {
>         struct spi_transfer     status;
>         struct spi_message      readback;
>
> -       /* underlying DMA-aware controller, or null */
> -       struct device           *dma_dev;
> -
>         /* buffer used for commands and for message "overhead" */
>         struct scratch          *data;
> -       dma_addr_t              data_dma;
>
>         /* Specs say to write ones most of the time, even when the card
>          * has no need to read its input data; and many cards won't care.
>          * This is our source of those ones.
>          */
>         void                    *ones;
> -       dma_addr_t              ones_dma;
>  };
>
>
> @@ -147,11 +142,8 @@ static inline int mmc_cs_off(struct mmc_spi_host *host)
>         return spi_setup(host->spi);
>  }
>
> -static int
> -mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
> +static int mmc_spi_readbytes(struct mmc_spi_host *host, unsigned int len)
>  {
> -       int status;
> -
>         if (len > sizeof(*host->data)) {
>                 WARN_ON(1);
>                 return -EIO;
> @@ -159,19 +151,7 @@ mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
>
>         host->status.len = len;
>
> -       if (host->dma_dev)
> -               dma_sync_single_for_device(host->dma_dev,
> -                               host->data_dma, sizeof(*host->data),
> -                               DMA_FROM_DEVICE);
> -
> -       status = spi_sync_locked(host->spi, &host->readback);
> -
> -       if (host->dma_dev)
> -               dma_sync_single_for_cpu(host->dma_dev,
> -                               host->data_dma, sizeof(*host->data),
> -                               DMA_FROM_DEVICE);
> -
> -       return status;
> +       return spi_sync_locked(host->spi, &host->readback);
>  }
>
>  static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
> @@ -506,23 +486,11 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>         t = &host->t;
>         memset(t, 0, sizeof(*t));
>         t->tx_buf = t->rx_buf = data->status;
> -       t->tx_dma = t->rx_dma = host->data_dma;
>         t->len = cp - data->status;
>         t->cs_change = 1;
>         spi_message_add_tail(t, &host->m);
>
> -       if (host->dma_dev) {
> -               host->m.is_dma_mapped = 1;
> -               dma_sync_single_for_device(host->dma_dev,
> -                               host->data_dma, sizeof(*host->data),
> -                               DMA_BIDIRECTIONAL);
> -       }
>         status = spi_sync_locked(host->spi, &host->m);
> -
> -       if (host->dma_dev)
> -               dma_sync_single_for_cpu(host->dma_dev,
> -                               host->data_dma, sizeof(*host->data),
> -                               DMA_BIDIRECTIONAL);
>         if (status < 0) {
>                 dev_dbg(&host->spi->dev, "  ... write returned %d\n", status);
>                 cmd->error = status;
> @@ -540,9 +508,6 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>   * We always provide TX data for data and CRC.  The MMC/SD protocol
>   * requires us to write ones; but Linux defaults to writing zeroes;
>   * so we explicitly initialize it to all ones on RX paths.
> - *
> - * We also handle DMA mapping, so the underlying SPI controller does
> - * not need to (re)do it for each message.
>   */
>  static void
>  mmc_spi_setup_data_message(
> @@ -552,11 +517,8 @@ mmc_spi_setup_data_message(
>  {
>         struct spi_transfer     *t;
>         struct scratch          *scratch = host->data;
> -       dma_addr_t              dma = host->data_dma;
>
>         spi_message_init(&host->m);
> -       if (dma)
> -               host->m.is_dma_mapped = 1;
>
>         /* for reads, readblock() skips 0xff bytes before finding
>          * the token; for writes, this transfer issues that token.
> @@ -570,8 +532,6 @@ mmc_spi_setup_data_message(
>                 else
>                         scratch->data_token = SPI_TOKEN_SINGLE;
>                 t->tx_buf = &scratch->data_token;
> -               if (dma)
> -                       t->tx_dma = dma + offsetof(struct scratch, data_token);
>                 spi_message_add_tail(t, &host->m);
>         }
>
> @@ -581,7 +541,6 @@ mmc_spi_setup_data_message(
>         t = &host->t;
>         memset(t, 0, sizeof(*t));
>         t->tx_buf = host->ones;
> -       t->tx_dma = host->ones_dma;
>         /* length and actual buffer info are written later */
>         spi_message_add_tail(t, &host->m);
>
> @@ -591,14 +550,9 @@ mmc_spi_setup_data_message(
>         if (direction == DMA_TO_DEVICE) {
>                 /* the actual CRC may get written later */
>                 t->tx_buf = &scratch->crc_val;
> -               if (dma)
> -                       t->tx_dma = dma + offsetof(struct scratch, crc_val);
>         } else {
>                 t->tx_buf = host->ones;
> -               t->tx_dma = host->ones_dma;
>                 t->rx_buf = &scratch->crc_val;
> -               if (dma)
> -                       t->rx_dma = dma + offsetof(struct scratch, crc_val);
>         }
>         spi_message_add_tail(t, &host->m);
>
> @@ -621,10 +575,7 @@ mmc_spi_setup_data_message(
>                 memset(t, 0, sizeof(*t));
>                 t->len = (direction == DMA_TO_DEVICE) ? sizeof(scratch->status) : 1;
>                 t->tx_buf = host->ones;
> -               t->tx_dma = host->ones_dma;
>                 t->rx_buf = scratch->status;
> -               if (dma)
> -                       t->rx_dma = dma + offsetof(struct scratch, status);
>                 t->cs_change = 1;
>                 spi_message_add_tail(t, &host->m);
>         }
> @@ -653,23 +604,13 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
>
>         if (host->mmc->use_spi_crc)
>                 scratch->crc_val = cpu_to_be16(crc_itu_t(0, t->tx_buf, t->len));
> -       if (host->dma_dev)
> -               dma_sync_single_for_device(host->dma_dev,
> -                               host->data_dma, sizeof(*scratch),
> -                               DMA_BIDIRECTIONAL);
>
>         status = spi_sync_locked(spi, &host->m);
> -
>         if (status != 0) {
>                 dev_dbg(&spi->dev, "write error (%d)\n", status);
>                 return status;
>         }
>
> -       if (host->dma_dev)
> -               dma_sync_single_for_cpu(host->dma_dev,
> -                               host->data_dma, sizeof(*scratch),
> -                               DMA_BIDIRECTIONAL);
> -
>         /*
>          * Get the transmission data-response reply.  It must follow
>          * immediately after the data block we transferred.  This reply
> @@ -718,8 +659,6 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
>         }
>
>         t->tx_buf += t->len;
> -       if (host->dma_dev)
> -               t->tx_dma += t->len;
>
>         /* Return when not busy.  If we didn't collect that status yet,
>          * we'll need some more I/O.
> @@ -783,30 +722,12 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>         }
>         leftover = status << 1;
>
> -       if (host->dma_dev) {
> -               dma_sync_single_for_device(host->dma_dev,
> -                               host->data_dma, sizeof(*scratch),
> -                               DMA_BIDIRECTIONAL);
> -               dma_sync_single_for_device(host->dma_dev,
> -                               t->rx_dma, t->len,
> -                               DMA_FROM_DEVICE);
> -       }
> -
>         status = spi_sync_locked(spi, &host->m);
>         if (status < 0) {
>                 dev_dbg(&spi->dev, "read error %d\n", status);
>                 return status;
>         }
>
> -       if (host->dma_dev) {
> -               dma_sync_single_for_cpu(host->dma_dev,
> -                               host->data_dma, sizeof(*scratch),
> -                               DMA_BIDIRECTIONAL);
> -               dma_sync_single_for_cpu(host->dma_dev,
> -                               t->rx_dma, t->len,
> -                               DMA_FROM_DEVICE);
> -       }
> -
>         if (bitshift) {
>                 /* Walk through the data and the crc and do
>                  * all the magic to get byte-aligned data.
> @@ -841,8 +762,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>         }
>
>         t->rx_buf += t->len;
> -       if (host->dma_dev)
> -               t->rx_dma += t->len;
>
>         return 0;
>  }
> @@ -857,7 +776,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 struct mmc_data *data, u32 blk_size)
>  {
>         struct spi_device       *spi = host->spi;
> -       struct device           *dma_dev = host->dma_dev;
>         struct spi_transfer     *t;
>         enum dma_data_direction direction = mmc_get_dma_dir(data);
>         struct scatterlist      *sg;
> @@ -884,31 +802,8 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>          */
>         for_each_sg(data->sg, sg, data->sg_len, n_sg) {
>                 int                     status = 0;
> -               dma_addr_t              dma_addr = 0;
>                 void                    *kmap_addr;
>                 unsigned                length = sg->length;
> -               enum dma_data_direction dir = direction;
> -
> -               /* set up dma mapping for controller drivers that might
> -                * use DMA ... though they may fall back to PIO
> -                */
> -               if (dma_dev) {
> -                       /* never invalidate whole *shared* pages ... */
> -                       if ((sg->offset != 0 || length != PAGE_SIZE)
> -                                       && dir == DMA_FROM_DEVICE)
> -                               dir = DMA_BIDIRECTIONAL;
> -
> -                       dma_addr = dma_map_page(dma_dev, sg_page(sg), 0,
> -                                               PAGE_SIZE, dir);
> -                       if (dma_mapping_error(dma_dev, dma_addr)) {
> -                               data->error = -EFAULT;
> -                               break;
> -                       }
> -                       if (direction == DMA_TO_DEVICE)
> -                               t->tx_dma = dma_addr + sg->offset;
> -                       else
> -                               t->rx_dma = dma_addr + sg->offset;
> -               }
>
>                 /* allow pio too; we don't allow highmem */
>                 kmap_addr = kmap(sg_page(sg));
> @@ -941,8 +836,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 if (direction == DMA_FROM_DEVICE)
>                         flush_dcache_page(sg_page(sg));
>                 kunmap(sg_page(sg));
> -               if (dma_dev)
> -                       dma_unmap_page(dma_dev, dma_addr, PAGE_SIZE, dir);
>
>                 if (status < 0) {
>                         data->error = status;
> @@ -977,21 +870,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 scratch->status[0] = SPI_TOKEN_STOP_TRAN;
>
>                 host->early_status.tx_buf = host->early_status.rx_buf;
> -               host->early_status.tx_dma = host->early_status.rx_dma;
>                 host->early_status.len = statlen;
>
> -               if (host->dma_dev)
> -                       dma_sync_single_for_device(host->dma_dev,
> -                                       host->data_dma, sizeof(*scratch),
> -                                       DMA_BIDIRECTIONAL);
> -
>                 tmp = spi_sync_locked(spi, &host->m);
> -
> -               if (host->dma_dev)
> -                       dma_sync_single_for_cpu(host->dma_dev,
> -                                       host->data_dma, sizeof(*scratch),
> -                                       DMA_BIDIRECTIONAL);
> -
>                 if (tmp < 0) {
>                         if (!data->error)
>                                 data->error = tmp;
> @@ -1265,52 +1146,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
>         return IRQ_HANDLED;
>  }
>
> -#ifdef CONFIG_HAS_DMA
> -static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> -{
> -       struct spi_device *spi = host->spi;
> -       struct device *dev;
> -
> -       if (!spi->master->dev.parent->dma_mask)
> -               return 0;
> -
> -       dev = spi->master->dev.parent;
> -
> -       host->ones_dma = dma_map_single(dev, host->ones, MMC_SPI_BLOCKSIZE,
> -                                       DMA_TO_DEVICE);
> -       if (dma_mapping_error(dev, host->ones_dma))
> -               return -ENOMEM;
> -
> -       host->data_dma = dma_map_single(dev, host->data, sizeof(*host->data),
> -                                       DMA_BIDIRECTIONAL);
> -       if (dma_mapping_error(dev, host->data_dma)) {
> -               dma_unmap_single(dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
> -                                DMA_TO_DEVICE);
> -               return -ENOMEM;
> -       }
> -
> -       dma_sync_single_for_cpu(dev, host->data_dma, sizeof(*host->data),
> -                               DMA_BIDIRECTIONAL);
> -
> -       host->dma_dev = dev;
> -       return 0;
> -}
> -
> -static void mmc_spi_dma_free(struct mmc_spi_host *host)
> -{
> -       if (!host->dma_dev)
> -               return;
> -
> -       dma_unmap_single(host->dma_dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
> -                        DMA_TO_DEVICE);
> -       dma_unmap_single(host->dma_dev, host->data_dma, sizeof(*host->data),
> -                        DMA_BIDIRECTIONAL);
> -}
> -#else
> -static inline int mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
> -static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
> -#endif
> -
>  static int mmc_spi_probe(struct spi_device *spi)
>  {
>         void                    *ones;
> @@ -1402,24 +1237,17 @@ static int mmc_spi_probe(struct spi_device *spi)
>                         host->powerup_msecs = 250;
>         }
>
> -       /* preallocate dma buffers */
> +       /* Preallocate buffers */
>         host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
>         if (!host->data)
>                 goto fail_nobuf1;
>
> -       status = mmc_spi_dma_alloc(host);
> -       if (status)
> -               goto fail_dma;
> -
>         /* setup message for status/busy readback */
>         spi_message_init(&host->readback);
> -       host->readback.is_dma_mapped = (host->dma_dev != NULL);
>
>         spi_message_add_tail(&host->status, &host->readback);
>         host->status.tx_buf = host->ones;
> -       host->status.tx_dma = host->ones_dma;
>         host->status.rx_buf = &host->data->status;
> -       host->status.rx_dma = host->data_dma + offsetof(struct scratch, status);
>         host->status.cs_change = 1;
>
>         /* register card detect irq */
> @@ -1464,9 +1292,8 @@ static int mmc_spi_probe(struct spi_device *spi)
>         if (!status)
>                 has_ro = true;
>
> -       dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
> +       dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
>                         dev_name(&mmc->class_dev),
> -                       host->dma_dev ? "" : ", no DMA",
>                         has_ro ? "" : ", no WP",
>                         (host->pdata && host->pdata->setpower)
>                                 ? "" : ", no poweroff",
> @@ -1477,8 +1304,6 @@ static int mmc_spi_probe(struct spi_device *spi)
>  fail_gpiod_request:
>         mmc_remove_host(mmc);
>  fail_glue_init:
> -       mmc_spi_dma_free(host);
> -fail_dma:
>         kfree(host->data);
>  fail_nobuf1:
>         mmc_spi_put_pdata(spi);
> @@ -1500,7 +1325,6 @@ static void mmc_spi_remove(struct spi_device *spi)
>
>         mmc_remove_host(mmc);
>
> -       mmc_spi_dma_free(host);
>         kfree(host->data);
>         kfree(host->ones);
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

