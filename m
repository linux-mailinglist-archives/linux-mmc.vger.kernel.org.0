Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB084A9BC7
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIEHaZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 03:30:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35873 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfIEHaZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 03:30:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id r1so903666vsq.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqlpCiQgrYABLxRjyK/vekclwPN8hBbKAYqSPdbhfos=;
        b=KWsRVXSWIb/Nq4lY/Fl21maSn3Tg5fdY15DiNJnJzzmyc852jzZddRMeyMW7l6U9Z5
         E4zPQgJxVr/S/Q2/uT9ixyOEGa2lK/Da3a9qmRqxAgDE0a8ErLkWgFOPSIEEp/1cEv2e
         NU7nP13Ns743wTPdl46Q4e4WJZCC8Ib6XS/7HXNLQGmxrPk9/OjTqXXoOdA6WRuJv/hz
         CtpjJ28fhe/vd1JhFoDisb6A2RvBcUGttZjTHSjtgpsOMXmmjQLT16Y5C11fT350Denv
         6OvwZu3Eo7q5nAJdT9FfGnl6g6Gu5TgGOhODmdpC8WhmB5Rs0DR3H0AqefpEpSTrWoxp
         j+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqlpCiQgrYABLxRjyK/vekclwPN8hBbKAYqSPdbhfos=;
        b=rVGERi0kFBdwR1snsCq4BV+nHvwSjehVAri3q7yDNWABHRr+tgrh2zEvmQLhzowBd3
         yFwCCjMeel+ypJ28wRxSjo3596iN2Qo6LoVkqHuTXVZxKoNDpHOKH7nVvLVrWPQIwy44
         shwWtWNt3OjzsGn1M5t3yk0RaSl6HXLuee+iWBf6aVQzak2YB0qL4f+WPsOj/zXWNaej
         E6hcboLFVWXud5Ea8idgNO14zx/j+haPhYTq4PSAy7T2tC0uTdHIiehiqVIu7BC6YggP
         MTsp4PytlveGxKx0GmBJATc7g7X20e5O3IUBk7FP1gTJWCCItDpTZ0sDuU1bRNTCG47S
         Lmbw==
X-Gm-Message-State: APjAAAWjcQ3LRIGsxXInnBoxScjfwtx7zIdcBDW9EMUmnITVoVlJjRDi
        09rQZvegQCCx0GH0nuz3UeMb5Sg7FdkUEgYjrLDO1A==
X-Google-Smtp-Source: APXvYqwHS+FsT6InXxdyDcaq3t60ccML8W6xkwMcmX+45Y6pZD6dvPc6OR1sNXRWY82FkSDaC6FPjhpGsPYabIHAcdk=
X-Received: by 2002:a67:f6d9:: with SMTP id v25mr1020149vso.34.1567668624716;
 Thu, 05 Sep 2019 00:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
 <20190905003451.GI70797@google.com>
In-Reply-To: <20190905003451.GI70797@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:29:48 +0200
Message-ID: <CAPDyKFpAegE+7ySjnAPChHJY8L7yRQYSvvTMZq0=TDDnV1TD0Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 02:34, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Sep 03, 2019 at 04:22:01PM +0200, Ulf Hansson wrote:
> > In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> > avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> > SDIO func's >irq_handler() callback.
> >
> > To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> > let's set the flag from inside sdio_signal_irq(), rather from
> > sdio_run_irqs(). Moreover, let's also reset the flag when the SDIO IRQ have
> > been properly processed.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sdio_irq.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index f75043266984..0962a4357d54 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >  {
> >       struct mmc_card *card = host->card;
> >       int i, ret, count;
> > +     bool sdio_irq_pending = host->sdio_irq_pending;
> >       unsigned char pending;
> >       struct sdio_func *func;
> >
> > @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >       if (mmc_card_suspended(card))
> >               return 0;
> >
> > +     /* Clear the flag to indicate that we have processed the IRQ. */
> > +     host->sdio_irq_pending = false;
> > +
>
> It's not entirely true that we have processed the IRQ,
> the sdio_get_pending_irqs() below could fail and we'd return. However
> I guess if it comes to that we are in a pretty bad shape already and
> the value of the flag doesn't really matter.

Yes, that's my view as well.

>
> >       /*
> >        * Optimization, if there is only 1 function interrupt registered
> >        * and we know an IRQ was signaled then call irq handler directly.
> >        * Otherwise do the full probe.
> >        */
> >       func = card->sdio_single_irq;
> > -     if (func && host->sdio_irq_pending) {
> > +     if (func && sdio_irq_pending) {
> >               func->irq_handler(func);
> >               return 1;
> >       }
> > @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
> >  {
> >       mmc_claim_host(host);
> >       if (host->sdio_irqs) {
> > -             host->sdio_irq_pending = true;
> >               process_sdio_pending_irqs(host);
> >               if (host->ops->ack_sdio_irq)
> >                       host->ops->ack_sdio_irq(host);
> > @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
> >
> >  void sdio_signal_irq(struct mmc_host *host)
> >  {
> > +     host->sdio_irq_pending = true;
> >       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> > @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
> >               if (ret)
> >                       break;
> >               ret = process_sdio_pending_irqs(host);
> > -             host->sdio_irq_pending = false;
> >               mmc_release_host(host);
> >
> >               /*
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks!

Kind regards
Uffe
