Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2EE0C6
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfD2Kpl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:45:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34962 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfD2Kpk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:45:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id d8so5619726vsp.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uSak32M+oPgeVMcmkR80Tf3+ZsvunD2ZjdB/YQdsgs=;
        b=LNl1nnj28T2Qe7Rx4gJzxUxTo8sUauvEl46TdaQLB3bz1dUy7B8zsUPLrhE3GiNCTW
         kFYTQiA1wfK9YvkQYDFOxRWzA25CzT8hlF1WptMeqBRXVidtq74qWsHOS9txvEMPjDUk
         wrkQDWZtLRmY9v0Tl5dG7NWpaAP6FpLn/qa/PEIpfjsL5dUHcovAYuJ8uqMgdB/aRX0U
         RUn/q+6APsKEzT3uIbMCZdKeLJ7c0lltRe8YPsRYvPZRI4ILWIbFocCrqKo/+ALJecQf
         SXlztOZBIl8xCGyZv08afxKUKtxazpAlRFxqh3SRNJVlN5kib6OjQL8H3Il2sIVGZoHX
         Kc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uSak32M+oPgeVMcmkR80Tf3+ZsvunD2ZjdB/YQdsgs=;
        b=DpEZNLLoO+ANjs9RX1pnxQjLZ/zs1ZXlayHOGhQbZZ94WlcMv4Fg5hZfTj/lKiqOzX
         LpEHtzxGvGWD1N505IyqA+G5ndJCR7cOmc04h47jDRsK/zv+Dprcv6VzCZ+K5nbKGYMx
         YcUdeWFRdDIOVM2AgBdMuoBK5KvUfBt7HHntWHwto1dX15PqFz75EKv9FwHdk0BcRwK9
         NK2Bu/sjFdYzE0XLfMLqWL9EZ/VnXs8JeVv+yG/ie2PLOzCO6nbs8A5w1yr/9e1+SK3C
         /4R9IkpZNdGtdxj7KL+NhWiY5hXG6uEsFt028n1oWYPDuL4Lf7wb0atTYshUo2V11TnA
         2b0g==
X-Gm-Message-State: APjAAAXmMZU0OJ6pvk0j7mfdpcaqYhHNo79xv8e8W+3ebiffoeg9VMUS
        LKh21YGGdvaiXvMEE+jeO1JliL+I+2+pYb0KUIHvcQ==
X-Google-Smtp-Source: APXvYqx3IMQfAKFuEmwChm6TloAUK1dQmiEv/jvvxMbBKZC4WIkPdmatwM+hIFu9QQGfSHWaysSlq2HkIAFkpWTDdCc=
X-Received: by 2002:a67:cb12:: with SMTP id b18mr464579vsl.191.1556534739407;
 Mon, 29 Apr 2019 03:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190429051426.7558-1-drake@endlessm.com>
In-Reply-To: <20190429051426.7558-1-drake@endlessm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:45:03 +0200
Message-ID: <CAPDyKFpYo+DU5BU5YsidSh4ZxxQRCOjm+TfPYekgww+3ma2Z-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "mmc: alcor: enable DMA transfer of large buffers"
To:     Daniel Drake <drake@endlessm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux@endlessm.com, jin.tsai@alcorlink.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        Arnd Bergmann <arnd@arndb.de>, jgg@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 29 Apr 2019 at 07:14, Daniel Drake <drake@endlessm.com> wrote:
>
> This reverts commit 57ebb96c293da9f0ec56aba13c5541269a5c10b1.
>
> Usage of the DMA page iterator was problematic here because
> we were not considering offset & length of entries in the scatterlist.
>
> Also, after further discussion, the suggested revised approach is much
> more similar to the driver implementation before this commit was
> applied, so revert it.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c | 88 ++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index bb4291d50a5d..dccf68e36d9b 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -54,9 +54,9 @@ struct alcor_sdmmc_host {
>         struct delayed_work timeout_work;
>
>         struct sg_mapping_iter sg_miter;        /* SG state for PIO */
> -       struct sg_dma_page_iter sg_diter;       /* SG state for DMA */
>         struct scatterlist *sg;
>         unsigned int blocks;            /* remaining PIO blocks */
> +       int sg_count;
>
>         u32                     irq_status_sd;
>         unsigned char           cur_power_mode;
> @@ -117,19 +117,30 @@ static void alcor_reset(struct alcor_sdmmc_host *host, u8 val)
>         dev_err(host->dev, "%s: timeout\n", __func__);
>  }
>
> -/*
> - * Perform DMA I/O of a single page.
> - */
>  static void alcor_data_set_dma(struct alcor_sdmmc_host *host)
>  {
>         struct alcor_pci_priv *priv = host->alcor_pci;
> -       dma_addr_t addr;
> +       u32 addr;
> +
> +       if (!host->sg_count)
> +               return;
>
> -       if (!__sg_page_iter_dma_next(&host->sg_diter))
> +       if (!host->sg) {
> +               dev_err(host->dev, "have blocks, but no SG\n");
>                 return;
> +       }
>
> -       addr = sg_page_iter_dma_address(&host->sg_diter);
> -       alcor_write32(priv, (u32) addr, AU6601_REG_SDMA_ADDR);
> +       if (!sg_dma_len(host->sg)) {
> +               dev_err(host->dev, "DMA SG len == 0\n");
> +               return;
> +       }
> +
> +
> +       addr = (u32)sg_dma_address(host->sg);
> +
> +       alcor_write32(priv, addr, AU6601_REG_SDMA_ADDR);
> +       host->sg = sg_next(host->sg);
> +       host->sg_count--;
>  }
>
>  static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
> @@ -142,29 +153,12 @@ static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
>                 ctrl |= AU6601_DATA_WRITE;
>
>         if (data->host_cookie == COOKIE_MAPPED) {
> -               /*
> -                * For DMA transfers, this function is called just once,
> -                * at the start of the operation. The hardware can only
> -                * perform DMA I/O on a single page at a time, so here
> -                * we kick off the transfer with the first page, and expect
> -                * subsequent pages to be transferred upon IRQ events
> -                * indicating that the single-page DMA was completed.
> -                */
> -               __sg_page_iter_start(&host->sg_diter.base, data->sg,
> -                                    data->sg_len, 0);
> -
>                 alcor_data_set_dma(host);
>                 ctrl |= AU6601_DATA_DMA_MODE;
>                 host->dma_on = 1;
> -               alcor_write32(priv, data->blksz * data->blocks,
> +               alcor_write32(priv, data->sg_count * 0x1000,
>                                AU6601_REG_BLOCK_SIZE);
>         } else {
> -               /*
> -                * For PIO transfers, we break down each operation
> -                * into several sector-sized transfers. When one sector has
> -                * complete, the IRQ handler will call this function again
> -                * to kick off the transfer of the next sector.
> -                */
>                 alcor_write32(priv, data->blksz, AU6601_REG_BLOCK_SIZE);
>         }
>
> @@ -239,8 +233,9 @@ static void alcor_prepare_data(struct alcor_sdmmc_host *host,
>         host->data->bytes_xfered = 0;
>         host->blocks = data->blocks;
>         host->sg = data->sg;
> +       host->sg_count = data->sg_count;
>         dev_dbg(host->dev, "prepare DATA: sg %i, blocks: %i\n",
> -                       data->sg_count, host->blocks);
> +                       host->sg_count, host->blocks);
>
>         if (data->host_cookie != COOKIE_MAPPED)
>                 alcor_prepare_sg_miter(host);
> @@ -489,6 +484,9 @@ static int alcor_data_irq_done(struct alcor_sdmmc_host *host, u32 intmask)
>                 alcor_trf_block_pio(host, false);
>                 return 1;
>         case AU6601_INT_DMA_END:
> +               if (!host->sg_count)
> +                       break;
> +
>                 alcor_data_set_dma(host);
>                 break;
>         default:
> @@ -525,7 +523,8 @@ static void alcor_data_irq_thread(struct alcor_sdmmc_host *host, u32 intmask)
>         if (alcor_data_irq_done(host, intmask))
>                 return;
>
> -       if ((intmask & AU6601_INT_DATA_END) || !host->blocks || host->dma_on)
> +       if ((intmask & AU6601_INT_DATA_END) || !host->blocks ||
> +           (host->dma_on && !host->sg_count))
>                 alcor_finish_data(host);
>  }
>
> @@ -763,7 +762,8 @@ static void alcor_pre_req(struct mmc_host *mmc,
>         struct alcor_sdmmc_host *host = mmc_priv(mmc);
>         struct mmc_data *data = mrq->data;
>         struct mmc_command *cmd = mrq->cmd;
> -       unsigned int sg_len;
> +       struct scatterlist *sg;
> +       unsigned int i, sg_len;
>
>         if (!data || !cmd)
>                 return;
> @@ -785,6 +785,11 @@ static void alcor_pre_req(struct mmc_host *mmc,
>         if (data->blksz & 3)
>                 return;
>
> +       for_each_sg(data->sg, sg, data->sg_len, i) {
> +               if (sg->length != AU6601_MAX_DMA_BLOCK_SIZE)
> +                       return;
> +       }
> +
>         /* This data might be unmapped at this time */
>
>         sg_len = dma_map_sg(host->dev, data->sg, data->sg_len,
> @@ -1031,13 +1036,26 @@ static void alcor_init_mmc(struct alcor_sdmmc_host *host)
>         mmc->caps2 = MMC_CAP2_NO_SDIO;
>         mmc->ops = &alcor_sdc_ops;
>
> -       /*
> -        * Enable large requests through iteration of scatterlist pages.
> -        * Limit to 240 sectors per request like the original vendor driver.
> +       /* The hardware does DMA data transfer of 4096 bytes to/from a single
> +        * buffer address. Scatterlists are not supported, but upon DMA
> +        * completion (signalled via IRQ), the original vendor driver does
> +        * then immediately set up another DMA transfer of the next 4096
> +        * bytes.
> +        *
> +        * This means that we need to handle the I/O in 4096 byte chunks.
> +        * Lacking a way to limit the sglist entries to 4096 bytes, we instead
> +        * impose that only one segment is provided, with maximum size 4096,
> +        * which also happens to be the minimum size. This means that the
> +        * single-entry sglist handled by this driver can be handed directly
> +        * to the hardware, nice and simple.
> +        *
> +        * Unfortunately though, that means we only do 4096 bytes I/O per
> +        * MMC command. A future improvement would be to make the driver
> +        * accept sg lists and entries of any size, and simply iterate
> +        * through them 4096 bytes at a time.
>          */
> -       mmc->max_segs = 64;
> -       mmc->max_seg_size = 240 * 512;
> -       mmc->max_blk_count = 240;
> +       mmc->max_segs = AU6601_MAX_DMA_SEGMENTS;
> +       mmc->max_seg_size = AU6601_MAX_DMA_BLOCK_SIZE;
>         mmc->max_req_size = mmc->max_seg_size;
>  }
>
> --
> 2.20.1
>
