Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C3FAF0A
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMKzh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 05:55:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37707 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMKzh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 05:55:37 -0500
Received: by mail-vs1-f67.google.com with SMTP id u6so1049785vsp.4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G40XQcNmziLTSN7ULevk0N08ose+NHbscuxrg7NiGAM=;
        b=LWW6NXan1N9dv0lsYUxku/AwipOKrRyViHUDnMfibtH0HBGG0+LLyfur8WlYiBaikS
         y5lzhPURVoVUokxQMZTxnEqD5pjRFpi7+fxWdA1Eczo4PPT7o6VCCiMHuUZ1mJmnfcFl
         GuSBmUS6XTPs83baFIBbW1/xQjlxw9MoXW/MKCImAsbOVh7Xj801N68J0JzQI2+BfCNK
         wxXfHwnYSiTcj63f15GeRnz0hkXYm5dvdGQnkyRv4XPjbdrEN5kXd4OtUSgc/71vxnZ5
         Dw4ZcqTo3xVGDZ69Ngg9sVHYEb7B6T5PkywG+XfG5IDnTFxKryE0scmfdgbV4h6CtGdn
         siqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G40XQcNmziLTSN7ULevk0N08ose+NHbscuxrg7NiGAM=;
        b=ad9j0VzrD/EQak6UCzJgfsETnAFXMNJp/EYWG4SN4sYConSBAmC4l9LxoxObQHSj7G
         SXnwKKPHRJhPF8iFo5JMoZeb3Qd/3PzyVwRkFn38qQZcMEsYqPhKsfQGrn0QIyZXNyP7
         9dyZrFaPKFGaqRnBenLNARPoczrqT8WIiXAPPzirnKVUXfO4v6jNoaYp2fzrADQc4132
         Q1Js9WBFT9qUylc+ci0BGogYWnmMIRNE5GDmiOEJi6BS0MrBROC89HzrUqmpywOCRcnD
         l6dFbayx/VRpGjLolE0uzW5z5FEGbq/bIXzrQkE2m5x+5UNUAt2AX2VypgP5l9ZgEhLQ
         pg/g==
X-Gm-Message-State: APjAAAVr5sGMr1X/Irgr9mTs8O/8fVQqNq1XKFA2Wq6kboh62mH8NkZH
        Ys51llh7oFkSM8ZKok1Js+HDrBn3hC1DlKYwT966AQ==
X-Google-Smtp-Source: APXvYqwKhEL4oGI7K3qhlwwAkqdf25AwoPaAqgp9g27rrzTDM7niE1/AuNjfq9Ti9gnV/xpLSg1Cn8USXBYR+j343yQ=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr1453449vsr.165.1573642534997;
 Wed, 13 Nov 2019 02:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20191113075335.31775-1-linus.walleij@linaro.org> <20191113075335.31775-3-linus.walleij@linaro.org>
In-Reply-To: <20191113075335.31775-3-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Nov 2019 11:54:59 +0100
Message-ID: <CAPDyKFrU4DBS9v1T1EsTFENMAzqH0J9iP=6RbYqHOUOtZYtQKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: mmci: Bail out from odd DMA on Ux500
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Russell King <linux@arm.linux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 08:53, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The Ux500 (at least) can only deal with DMA transactions
> starting and ending on an even 4-byte aligned address.
>
> The problem isn't in the DMA engine of the system as such:
> the problem is in the state machine of the MMCI block that
> has some features to handle single bytes but it seems like
> it doesn't quite work.
>
> This problem is probably caused by most of the testing
> being done on mass storage, which will be 512-bytes aligned
> blocks placed neatly in pages and practically never run into
> this situation.
>
> On SDIO (for example in WiFi adapters) this situation is
> common.
>
> By avoiding any such transfers with a special vendor flag,
> we can bail out to PIO when an odd transfer is detected
> while keeping DMA for large transfers of evenly aligned
> packages also for SDIO.
>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v3:
> - New patch in v3 after discussion with Ulf
> ---
>  drivers/mmc/host/mmci.c | 21 +++++++++++++++++++++
>  drivers/mmc/host/mmci.h | 10 ++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3ffcdf78a428..a08cd845dddc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -185,6 +185,7 @@ static struct variant_data variant_ux500 = {
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_OD,
> +       .only_long_aligned_dma  = true,
>         .init                   = mmci_variant_init,
>  };
>
> @@ -219,6 +220,7 @@ static struct variant_data variant_ux500v2 = {
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_OD,
> +       .only_long_aligned_dma  = true,
>         .init                   = ux500v2_variant_init,
>  };
>
> @@ -829,6 +831,25 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>         if (data->blksz * data->blocks <= variant->fifosize)
>                 return -EINVAL;
>
> +       /*
> +        * Handle the variants with DMA that is broken such that start and
> +        * end address must be aligned on a long (32bit) boundary for the DMA
> +        * to work. If this occurs, fall back to PIO.
> +        */
> +       if (host->variant->only_long_aligned_dma) {
> +               struct scatterlist *sg;
> +               int tmp;
> +
> +               for_each_sg(data->sg, sg, data->sg_len, tmp) {
> +                       /* We start in some odd place, that doesn't work */
> +                       if (sg->offset & 3)
> +                               return -EINVAL;
> +                       /* We end in some odd place, that doesn't work */
> +                       if (sg->length & 3)
> +                               return -EINVAL;
> +               }

Assuming the data i allocated consecutive (is that a wrong assumption?)...

...then it should be sufficient to check only the first sg-element in
the list having a divisible address offset by 4 (sg->offset & 0x3) and
then check that the total request size is also divisible by 4
((data->blksz * data->blocks) & 0x3). That should give the same
result.

 In this way you don't need to iterate through the sg-list.

> +       }
> +
>         device = chan->device;
>         nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
>                            mmc_get_dma_dir(data));
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index c7f94726eaa1..e20af17bb313 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -307,6 +307,15 @@ struct mmci_host;
>   *            register.
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @dma_lli: true if variant has dma link list feature.
> + * @only_long_aligned_dma: it appears that the Ux500 has a broken DMA logic for
> + *            single bytes when either the transfer starts at an odd offset or
> + *            the final DMA burst is an odd (not divisible by 4) address.
> + *            Reading must start and end on an even 4-byte boundary, i.e. an
> + *            even 32bit word in memory. If this is not the case, we need to
> + *            fall back to PIO for that request. For bulk transfers to mass
> + *            storage we are almost exclusively dealing with 512-byte chunks
> + *            allocated at an even address so this is usually only manifesting
> + *            in SDIO.
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>   */
>  struct variant_data {
> @@ -350,6 +359,7 @@ struct variant_data {
>         u32                     start_err;
>         u32                     opendrain;
>         u8                      dma_lli:1;
> +       u8                      only_long_aligned_dma:1;
>         u32                     stm32_idmabsize_mask;
>         void (*init)(struct mmci_host *host);
>  };
> --
> 2.21.0
>

Kind regards
Uffe
