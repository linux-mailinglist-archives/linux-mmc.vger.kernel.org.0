Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB8A13AB
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfH2IaE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 04:30:04 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34326 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfH2IaE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 04:30:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id b20so1888573vso.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8KVS3WjjGsX+VLjU/LkBwPrBnJsz/ospkY1CDEGnbc=;
        b=qoLCCti7tDQj75bRIJmpecZtyATOYvx/Ue50cSdRaYMgs4v23EfqkSYjxxd6BBT135
         NM/10JteU5kbTWj3VQ6ElY1xoXdKJg2Q6B0bxj96atbSLEnzBU7v21GNVJpZMFaXIOia
         oMzmWF4nAKv6tPlksPzyHKAfSdbnchYTsDaAjgaAplk7ysl6g14EFkQp0kmZakBimUiL
         H0lhFTX4mYt5owaq+lwQ8p1iclk3jrzVrbG44Uh2dmoENr5q8s3y4rasAnhtKHN17EK4
         YXTMPmK037cQ5B/dlEkxs5JonZerfCp6OPGk+qBvVN+seD0MB2VkMrSjauOiTGUfukx6
         XSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8KVS3WjjGsX+VLjU/LkBwPrBnJsz/ospkY1CDEGnbc=;
        b=FskX3wt1qYuC9tEohkXxySWSUollUuMrPhRtj2C9sJ+m12+KghIzmEZ3TOwmGTmuk6
         ydLqPpZqxD8GIK3A2yI+8bj4Emxil/WQKzbvAQ/iJieRbXkZRjsGRo3Z30kU9wcLYdQo
         5KQssMzye82x1NHhwM0iAvgqjumd+6zKuAZlluoiEYdYVWr0A+IAXUI8EM6EquDU9Ead
         /wTulq19ewafRVERvfUzPNisc3bJEZoLkJQOmkVvBq13ZOvPgwmnI5OFFKvsOh1lEmqp
         BFHedUyGsr+R+y68y6NkpRoJxvrOtRzChg70CZWeMRGxEIF5ypTKCc+KZb+6x6cijqOx
         yIGA==
X-Gm-Message-State: APjAAAWo5ylP6dM6KZiSgphwqXn8fHTBXddupUZIzLuKMpkB8e9L81ue
        YOtnKq8MWOfhrq6ulV719xk4Tdc8hqDFTh5cXsPu/g==
X-Google-Smtp-Source: APXvYqzd/d2jBHerpv45go4Rm2INhV3tAXjXFfOsLO6AiCuwGOpfkHaXG2cWN8z7oscoX8mrSVdQAS2jjjtEDqZ7B0w=
X-Received: by 2002:a67:e287:: with SMTP id g7mr4720453vsf.200.1567067402816;
 Thu, 29 Aug 2019 01:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org>
In-Reply-To: <20190828214620.66003-1-mka@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 10:29:26 +0200
Message-ID: <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a function
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Move the code to get pending SDIO interrupts from
> process_sdio_pending_irqs() to a dedicated function.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
>  include/linux/mmc/host.h    |  1 +
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 0bcc5e83bd1a..fedc49901efd 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -27,6 +27,35 @@
>  #include "core.h"
>  #include "card.h"
>
> +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
> +{
> +       struct mmc_card *card = host->card;
> +       int ret;
> +
> +       WARN_ON(!host->claimed);
> +
> +       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
> +       if (ret) {
> +               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> +                      mmc_card_id(card), ret);
> +               return ret;
> +       }
> +
> +       if (*pending && mmc_card_broken_irq_polling(card) &&
> +           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> +               unsigned char dummy;
> +
> +               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> +                * register with a Marvell SD8797 card. A dummy CMD52 read to
> +                * function 0 register 0xff can avoid this.
> +                */
> +               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);

I don't think you need export the sympol as this should be an internal
function for the core module.

> +
>  static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
> @@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>                 return 1;
>         }
>
> -       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
> -       if (ret) {
> -               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> -                      mmc_card_id(card), ret);
> +       ret = sdio_get_pending_irqs(host, &pending);
> +       if (ret)
>                 return ret;
> -       }
> -
> -       if (pending && mmc_card_broken_irq_polling(card) &&
> -           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> -               unsigned char dummy;
> -
> -               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> -                * register with a Marvell SD8797 card. A dummy CMD52 read to
> -                * function 0 register 0xff can avoid this.
> -                */
> -               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> -       }
>
>         count = 0;
>         for (i = 1; i <= 7; i++) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4a351cb7f20f..7ce0e98e3dbd 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>  }
>
>  void sdio_signal_irq(struct mmc_host *host);
> +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);

I want to avoid to sprinkle the public mmc headers, avoiding
interfaces to be abused outside mmc core.

That said, I think this should be internal to the mmc core, thus
please move this to drivers/mmc/core/sdio_ops.h.

>
>  #ifdef CONFIG_REGULATOR
>  int mmc_regulator_set_ocr(struct mmc_host *mmc,
> --
> 2.23.0.187.g17f5b7556c-goog
>

Kind regards
Uffe
