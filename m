Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2803A21F7
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfH2RQA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 13:16:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41567 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfH2RQA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 13:16:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so2491022pfz.8
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9QIC9uqWuh335lvbA5rrf8b+cViWD5hzPNIv1CMU/w=;
        b=e1+GxIGE2miaSf8ZW4+1g6xP5pAOGsKxYDXgwRImxxPExwzEjMUAgrYi/cqAbwasI1
         eKSIvq1Ch0ihNhgbm8lprYEZCdZQVAsCuy2/2byfzSHEuSU5dkLL9CFycxP7m3ofNddh
         0nX5TMYJS679JL2tNOdAO74fkerjaKmM1Sze8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9QIC9uqWuh335lvbA5rrf8b+cViWD5hzPNIv1CMU/w=;
        b=edx5CNtGrzjDxCksQViMO4FJ+TQxPj8YkYRYMWXCgiRwjwyZAg3M8oADGupZs7Tdl9
         dWXcElmMulS1WCuDFq8nSBfic/QXaSF9Qdd1lHbPZ9jjTCaCep0WjSNxdhC4l9ujd2th
         8JRoQvtfYByl8QB/a41nKxjZypSKAeKM9/eKEePs1tGtBJqjQKwWBL2hrKVRZm86zL3B
         BI22u9mUe1342mW6Zss6EbA3kkiHhOQM17aWK+w74cbT6MKmqt6orrATpYqD1TO009r3
         uydpmP2/oPWRyoBmaDddvfyriUfUUzyVbN4ZfAQ3neGujSw73mfe/uBc835w85D03FU2
         rEPA==
X-Gm-Message-State: APjAAAXnLdpELquLowyUtjrdB4Ujoy1S/00sVXNhJuEDUINClmGi5tbu
        4ES8RZjcSWY6wX3K+awkYo+mcw==
X-Google-Smtp-Source: APXvYqyffBBor/+6EeLCqrmL1gEoek3Q0TR8w35ZfJMYLUYqpXAFRGScFK2JXzJeUQrD8UOcC7Cp5g==
X-Received: by 2002:a65:5183:: with SMTP id h3mr9380839pgq.250.1567098959224;
        Thu, 29 Aug 2019 10:15:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y6sm2413295pjp.15.2019.08.29.10.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:15:58 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:15:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
Message-ID: <20190829171555.GD70797@google.com>
References: <20190828214620.66003-1-mka@chromium.org>
 <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Aug 29, 2019 at 10:48:58AM +0200, Ulf Hansson wrote:
> On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > With commit 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs
> > when the card is suspended") SDIO interrupts are dropped if they
> > occur while the card is suspended. Dropping the interrupts can cause
> > problems after resume with cards that remain powered during suspend
> > and preserve their state. These cards may end up in an inconsistent
> > state since the event that triggered the interrupt is never processed
> > and remains pending. One example is the Bluetooth function of the
> > Marvell 8997, SDIO is broken on resume (for both Bluetooth and WiFi)
> > when processing of a pending HCI event is skipped.
> >
> > For cards that remained powered during suspend check on resume if
> > SDIO interrupts are pending, and trigger interrupt processing if
> > needed.
> 
> Thanks for the detailed changelog, much appreciated!
> 
> >
> > Fixes: 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs when the card is suspended")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/mmc/core/sdio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index 8dd8fc32ecca..a6b4742a91c6 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -975,6 +975,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
> >  static int mmc_sdio_resume(struct mmc_host *host)
> >  {
> >         int err = 0;
> > +       u8 pending = 0;
> >
> >         /* Basic card reinitialization. */
> >         mmc_claim_host(host);
> > @@ -1009,6 +1010,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
> >         /* Allow SDIO IRQs to be processed again. */
> >         mmc_card_clr_suspended(host->card);
> >
> > +       if (!mmc_card_keep_power(host))
> > +               goto skip_pending_irqs;
> > +
> > +       if (!sdio_get_pending_irqs(host, &pending) &&
> > +           pending != 0)
> > +               sdio_signal_irq(host);
> 
> In one way, this change makes sense as it adopts the legacy behavior,
> signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> 
> However, there is at least one major concern I see with this approach.
> That is, in the execution path for sdio_signal_irq() (or calling
> wake_up_process() for the legacy path), we may end up invoking the
> SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> to consume the SDIO IRQ.
> 
> The problem with this is, that the corresponding SDIO func driver may
> not have been system resumed, when the ->irq_handler() callback is
> invoked.

While debugging the the problem with btmrvl I found that this is
already the case without the patch, just not during resume, but when
suspending. The func driver suspends before the SDIO bus and
interrupts can keep coming in. These are processed while the func
driver is suspended, until the SDIO core starts dropping the
interrupts.

And I think it is also already true at resume time: mmc_sdio_resume()
re-enables SDIO IRQs and disables dropping them.

> If the SDIO func driver would have configured the IRQ as a
> wakeup, then I would expect this to work, but not just by having a
> maintained power to the card.

Is the assumption that no IRQs are generated after SDIO func suspend
unless wakeup is enabled?

On the system I'm currently debugging OOB wakeup is not working,
which might be part of the problem.

> In the end, I think we need to deal with synchronizations for this,
> through the mmc/sdio core, in one way or the other - before we kick
> SDIO IRQs during system resume.
> 
> > +
> > +skip_pending_irqs:
> >         if (host->sdio_irqs) {
> >                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
> >                         wake_up_process(host->sdio_irq_thread);
