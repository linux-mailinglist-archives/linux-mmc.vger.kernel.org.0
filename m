Return-Path: <linux-mmc+bounces-4117-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3A98E727
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2024 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E7E1C20AE8
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Oct 2024 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACB19F403;
	Wed,  2 Oct 2024 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjXT/8eO"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55B1A01DD
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912226; cv=none; b=F0T1A3jITuUpNY13Emvj+36MHjTRzd3coQtbuZZMLJ10xvCRQnYaBfiDNhxZWnuoW94I6NeSMh+tz24cyvu9iObRlD9BRZky8ks17hIvR9R2Un7FqfcOrhVEQp8uXJriMwYbL/3d7tP8dIq7SS9K+uN8t/wywwBEUqHpTLxmmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912226; c=relaxed/simple;
	bh=6fBlAMFEKhxGK3r0v8y64PHPVN08ohFUOOST0JJr4GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdP+kK47/OWm3y3pYyj2+yX1y4+t+BzO/vlWbb9Z0vKpJE20EkQc7W1JnkN7kQkzM7AtbEfhzIZu3b8HJE1yUEY5rrRAuDzPKoinLNpJJ+Wk/JoWHfRJn51IV97eJzjDFvoz6p61cxw+KSicuOP1Q/1/3u9f1O403EjRGVkO0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjXT/8eO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25ccdffcc5so343549276.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912223; x=1728517023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XpW2maBc9C4PN45ovturZwmpY79iIqkHJKEZutWv5kA=;
        b=jjXT/8eOptbVOg0ev92f7q7togfq6uP18HkacRnxfV8MfuHxEPKwljixGSd0vEvuza
         c5NX6fuClDAZqyia4Nc+7PdjgIHQwToNFLHW2vJvdj3HRNpBdxoJuNIBw6epBXJXghXY
         xECcwuE+stbaC7NMEmsE3NBHbR74qoCxiPIOt3ZOj8VcwUS/o8JKQldWIbKaBg//TizA
         Qad+lUsahfrSCyH7cGzvQ5fz0DrFh+0C8RU+zCK1UV6iFowmoHJC9Ly58YXRKwQPx65e
         fSlY5sriVLF3cOlhDXqSn/RWKvyFn0oxMrIXG4UMI2ewcBn5G3DCxst6rj95rC03/aeK
         EP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912223; x=1728517023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpW2maBc9C4PN45ovturZwmpY79iIqkHJKEZutWv5kA=;
        b=HJP1LSZH4f+kBXKUeDsob8jU8Iwwub0KhFq/gTurQBNpQgGtK1Ne8ywBQo/cjnsA7n
         LHI4KAIjZJB/OBmaAR6yMxhpRHsg1O8o3cQ3t2+ZR30BwgkGWklf+RmHRNx7pVeNwpdO
         xTzRH5hu2y3oVPAc3S2V+FRPx5s3DPjLmg1SSaTQPykqt1RujbToRVEr0rbe7fv9YBie
         lM/93BnY3MDxMBC+O4Xs743nng+akLeSBWAU0dJocmZ8I3y+SmXMwGi4IE6UPRO0+7eP
         WyRz3+8KlccREeTYOhYLVCxWzBSfPsTgam+qFssvhq537PC8m9CLAccaTER84sRF9pJA
         t4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhg6sgFLL/aJKLk5jYU3wMvHRmXeka5alHO00p2AQ3A239reePEbSRQLO1HCIol3UsWGhEor9VoGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7644aArsKeFxoCmNvgP9pA2spu2L0sjM8y76U8uROMpRAaXOC
	vZGa14IYS1/MuxnkPhX/8TYrAzbZ5fQ9eH9Q6SY31Qg/oOTvHwIsMHv7H9uEr9yBG91C3ijsVQ6
	uW960SlfjKK14GvqOxn4x4lPviKCN2pqtYRITUA==
X-Google-Smtp-Source: AGHT+IHh0aSm/7ycu2f1zDWMNPdXAZPASeT9f+3jaxSr3JSk78V2HMaR7/mz3Evj35KMPugNObQWt9eio3n5o71ayd4=
X-Received: by 2002:a05:6902:2102:b0:e22:515e:7e7e with SMTP id
 3f1490d57ef6-e263843ade6mr3439045276.55.1727912223022; Wed, 02 Oct 2024
 16:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-kirkwood-mmc-regression-v1-1-2e55bbbb7b19@linaro.org>
In-Reply-To: <20240927-kirkwood-mmc-regression-v1-1-2e55bbbb7b19@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:27 +0200
Message-ID: <CAPDyKFpjrgcmmkwLxT3UWsZPxyvy4e1+q3wBNbiU4TNJ0Oytsw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: mvsdio: Use sg_miter for PIO"
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Charlie <g4sra@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 17:54, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This reverts commit 2761822c00e8c271f10a10affdbd4917d900d7ea.
>
> When testing on real hardware the patch does not work.
> Revert, try to acquire real hardware, and retry.
> These systems typically don't have highmem anyway so the
> impact is likely zero.
>
> Cc: stable@vger.kernel.org
> Reported-by: Charlie <g4sra@protonmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mvsdio.c | 71 ++++++++++++-----------------------------------
>  1 file changed, 18 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index af7f21888e27..ca01b7d204ba 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -38,9 +38,8 @@ struct mvsd_host {
>         unsigned int xfer_mode;
>         unsigned int intr_en;
>         unsigned int ctrl;
> -       bool use_pio;
> -       struct sg_mapping_iter sg_miter;
>         unsigned int pio_size;
> +       void *pio_ptr;
>         unsigned int sg_frags;
>         unsigned int ns_per_clk;
>         unsigned int clock;
> @@ -115,18 +114,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>                  * data when the buffer is not aligned on a 64 byte
>                  * boundary.
>                  */
> -               unsigned int miter_flags = SG_MITER_ATOMIC; /* Used from IRQ */
> -
> -               if (data->flags & MMC_DATA_READ)
> -                       miter_flags |= SG_MITER_TO_SG;
> -               else
> -                       miter_flags |= SG_MITER_FROM_SG;
> -
>                 host->pio_size = data->blocks * data->blksz;
> -               sg_miter_start(&host->sg_miter, data->sg, data->sg_len, miter_flags);
> +               host->pio_ptr = sg_virt(data->sg);
>                 if (!nodma)
> -                       dev_dbg(host->dev, "fallback to PIO for data\n");
> -               host->use_pio = true;
> +                       dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> +                               host->pio_ptr, host->pio_size);
>                 return 1;
>         } else {
>                 dma_addr_t phys_addr;
> @@ -137,7 +129,6 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>                 phys_addr = sg_dma_address(data->sg);
>                 mvsd_write(MVSD_SYS_ADDR_LOW, (u32)phys_addr & 0xffff);
>                 mvsd_write(MVSD_SYS_ADDR_HI,  (u32)phys_addr >> 16);
> -               host->use_pio = false;
>                 return 0;
>         }
>  }
> @@ -297,8 +288,8 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>         void __iomem *iobase = host->base;
>
> -       if (host->use_pio) {
> -               sg_miter_stop(&host->sg_miter);
> +       if (host->pio_ptr) {
> +               host->pio_ptr = NULL;
>                 host->pio_size = 0;
>         } else {
>                 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -353,12 +344,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  static irqreturn_t mvsd_irq(int irq, void *dev)
>  {
>         struct mvsd_host *host = dev;
> -       struct sg_mapping_iter *sgm = &host->sg_miter;
>         void __iomem *iobase = host->base;
>         u32 intr_status, intr_done_mask;
>         int irq_handled = 0;
> -       u16 *p;
> -       int s;
>
>         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>         dev_dbg(host->dev, "intr 0x%04x intr_en 0x%04x hw_state 0x%04x\n",
> @@ -382,36 +370,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>         spin_lock(&host->lock);
>
>         /* PIO handling, if needed. Messy business... */
> -       if (host->use_pio) {
> -               /*
> -                * As we set sgm->consumed this always gives a valid buffer
> -                * position.
> -                */
> -               if (!sg_miter_next(sgm)) {
> -                       /* This should not happen */
> -                       dev_err(host->dev, "ran out of scatter segments\n");
> -                       spin_unlock(&host->lock);
> -                       host->intr_en &=
> -                               ~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W |
> -                                 MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
> -                       mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
> -                       return IRQ_HANDLED;
> -               }
> -               p = sgm->addr;
> -               s = sgm->length;
> -               if (s > host->pio_size)
> -                       s = host->pio_size;
> -       }
> -
> -       if (host->use_pio &&
> +       if (host->pio_size &&
>             (intr_status & host->intr_en &
>              (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -
> +               u16 *p = host->pio_ptr;
> +               int s = host->pio_size;
>                 while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
>                         readsw(iobase + MVSD_FIFO, p, 16);
>                         p += 16;
>                         s -= 32;
> -                       sgm->consumed += 32;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
>                 /*
> @@ -424,7 +391,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                                 put_unaligned(mvsd_read(MVSD_FIFO), p++);
>                                 put_unaligned(mvsd_read(MVSD_FIFO), p++);
>                                 s -= 4;
> -                               sgm->consumed += 4;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
>                         if (s && s < 4 && (intr_status & MVSD_NOR_RX_READY)) {
> @@ -432,13 +398,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                                 val[0] = mvsd_read(MVSD_FIFO);
>                                 val[1] = mvsd_read(MVSD_FIFO);
>                                 memcpy(p, ((void *)&val) + 4 - s, s);
> -                               sgm->consumed += s;
>                                 s = 0;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> -                       /* PIO transfer done */
> -                       host->pio_size -= sgm->consumed;
> -                       if (host->pio_size == 0) {
> +                       if (s == 0) {
>                                 host->intr_en &=
>                                      ~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W);
>                                 mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
> @@ -450,10 +413,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> +               host->pio_ptr = p;
> +               host->pio_size = s;
>                 irq_handled = 1;
> -       } else if (host->use_pio &&
> +       } else if (host->pio_size &&
>                    (intr_status & host->intr_en &
>                     (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
> +               u16 *p = host->pio_ptr;
> +               int s = host->pio_size;
>                 /*
>                  * The TX_FIFO_8W bit is unreliable. When set, bursting
>                  * 16 halfwords all at once in the FIFO drops data. Actually
> @@ -464,7 +431,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                         mvsd_write(MVSD_FIFO, get_unaligned(p++));
>                         mvsd_write(MVSD_FIFO, get_unaligned(p++));
>                         s -= 4;
> -                       sgm->consumed += 4;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
>                 if (s < 4) {
> @@ -473,13 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                                 memcpy(((void *)&val) + 4 - s, p, s);
>                                 mvsd_write(MVSD_FIFO, val[0]);
>                                 mvsd_write(MVSD_FIFO, val[1]);
> -                               sgm->consumed += s;
>                                 s = 0;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> -                       /* PIO transfer done */
> -                       host->pio_size -= sgm->consumed;
> -                       if (host->pio_size == 0) {
> +                       if (s == 0) {
>                                 host->intr_en &=
>                                      ~(MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
>                                 mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
> @@ -487,6 +450,8 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> +               host->pio_ptr = p;
> +               host->pio_size = s;
>                 irq_handled = 1;
>         }
>
>
> ---
> base-commit: 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
> change-id: 20240927-kirkwood-mmc-regression-986c598d4c9e
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

