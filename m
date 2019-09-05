Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4DAAF3D
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 01:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfIEXr4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 19:47:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41531 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfIEXrz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 19:47:55 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so8693792ioh.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YQSedfXLXEpj/wO3cheOzhbBeyMukSxgMj72uksRTQ=;
        b=AdkRix71lOZOvU5GPlFZkUqukXgi6ZPZ7sg9sRA5klKNTxLEwDfUaW5EVBvb0VrQSg
         JNwMZ2Z8zLRS9Q8ndCfnRfOkO55ZQN782dzPK6rj0Y+mCCW8TRBQc4fO8VPTp0iq5O+V
         cioCIeUzXFFUFyMdqEx72ONQhD5Ngxu30jaYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YQSedfXLXEpj/wO3cheOzhbBeyMukSxgMj72uksRTQ=;
        b=HGqrFeqQjpyY4690QwF0azwn46QrvWzgD8pT2KLF+aSFmopSab/wzkqDNaRxPuR/b5
         48XpN8+kXdhqY5Dbf00xWBq0ToiL6laU9FCd/XGiAWqCwoY5EWy+JJkf01SZorDFncNR
         h3gmOwTMUvdCAxbAAOXxJeh0jXWwZrQwH0l7Tk554dQdpl6ptvf40uydRIgiY/mFgmjQ
         EC4oPwzUhNf2UzIokk+L/D+BKWdCVfS4F6szP3fmAF/Rn7vcxJSr6Tbdho6NnVQQ8bD/
         qyyW7hE4MHa0DQbL2xAqy+RG9lVFavQX6LXc+ODRo0PrKjYf903b6Yq+WvyCz1GpxWaO
         iqwQ==
X-Gm-Message-State: APjAAAVDmytZ8vlQYVc+ZAkjixQmix5hV54vCJdkjvrmAuVZL39ig6fg
        wOf1X01TiD1OAI3kss9St3MtFvAjA0o=
X-Google-Smtp-Source: APXvYqx5e0VwMh62B5mibJgBnWGGh28fZUt+e7DoqsM7SFvebYIyaZMfIfAe31s7XN/bzkPgovBAdQ==
X-Received: by 2002:a05:6602:24c7:: with SMTP id h7mr7346029ioe.74.1567727274221;
        Thu, 05 Sep 2019 16:47:54 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id p20sm6482304iod.43.2019.09.05.16.47.53
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:47:53 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n197so8696423iod.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:47:53 -0700 (PDT)
X-Received: by 2002:a6b:b213:: with SMTP id b19mr7104966iof.58.1567727272933;
 Thu, 05 Sep 2019 16:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
In-Reply-To: <20190903142207.5825-6-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Sep 2019 16:47:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
Message-ID: <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> SDIO func's >irq_handler() callback.
>
> To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> let's set the flag from inside sdio_signal_irq(), rather from
> sdio_run_irqs().

I'm having a hard time parsing the above statement...  Can you reword
and maybe I'll understand?


> Moreover, let's also reset the flag when the SDIO IRQ have
> been properly processed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Nice!  This looks like it addresses some of the things that came up in
the previous discussion [1] and should be a nice improvement.  From
re-reading that discussion that will probably change the behvaior
slightly (hopefully for the better) in the single-function case where
we might actually poll CCCR_INTx sometimes now.


> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index f75043266984..0962a4357d54 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
>         int i, ret, count;
> +       bool sdio_irq_pending = host->sdio_irq_pending;
>         unsigned char pending;
>         struct sdio_func *func;
>
> @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>         if (mmc_card_suspended(card))
>                 return 0;
>
> +       /* Clear the flag to indicate that we have processed the IRQ. */
> +       host->sdio_irq_pending = false;
> +
>         /*
>          * Optimization, if there is only 1 function interrupt registered
>          * and we know an IRQ was signaled then call irq handler directly.
>          * Otherwise do the full probe.
>          */
>         func = card->sdio_single_irq;
> -       if (func && host->sdio_irq_pending) {
> +       if (func && sdio_irq_pending) {
>                 func->irq_handler(func);
>                 return 1;
>         }
> @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
>  {
>         mmc_claim_host(host);
>         if (host->sdio_irqs) {
> -               host->sdio_irq_pending = true;
>                 process_sdio_pending_irqs(host);
>                 if (host->ops->ack_sdio_irq)
>                         host->ops->ack_sdio_irq(host);
> @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
>
>  void sdio_signal_irq(struct mmc_host *host)
>  {
> +       host->sdio_irq_pending = true;

Is this safe to do without claiming the host or any other type of
locking?  sdio_signal_irq() is called directly from the interrupt
handler on dw_mmc with no locks held at all.  Could we have races /
problems with weakly ordered memory?

Maybe I'm not understanding why this has to move.  It seems like it
would have been fine to leave this part in sdio_run_irqs() where it
was...


[1] https://lore.kernel.org/r/CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com

-Doug

>         queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
>                 if (ret)
>                         break;
>                 ret = process_sdio_pending_irqs(host);
> -               host->sdio_irq_pending = false;
>                 mmc_release_host(host);
>
>                 /*
> --
> 2.17.1
>
