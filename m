Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF79B3B939
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 18:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfFJQSJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 12:18:09 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46511 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbfFJQSJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 12:18:09 -0400
Received: by mail-vk1-f194.google.com with SMTP id c200so1109765vke.13
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Lexs7lCKdgDAEVjOBEFYA59MwxfKqXG6tvntQ8bHzw=;
        b=xcO2PnZkW+F4UU9MsXYaCbJVNKKZKzbZsGy53K1jMzN/9krqa851AqdXtroHI00o/Q
         DJghqhVRJTi7N3jmsJ9lTFnOvdWu589ajjUzM+kDqF/6lL5EhxTIca6T8crmqqnztfEp
         gxWYlVxzJTM4qT7biSfB1rjaHcsQc524jOhSVKpXQlSBtcfL8zLUpPjkPusXFCWua7GP
         5W7S7Gln4ougwWnQXyKbtEUY/uYR4lO+gRJJuLLt3uAr+jhoOdmCbnUWp31UWHdrMNDL
         QXS44Ylwhtk7/uqG1wR2Z7SbyjitwvdfmLvR92+/02pV14ncZoGsl7VmTGNwrPakBIXE
         FY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Lexs7lCKdgDAEVjOBEFYA59MwxfKqXG6tvntQ8bHzw=;
        b=VnWvNKSemdPkeT48ZlOYeWEzF9mtsCcc2m0jW4BjlnTLEnpcQ+DSXlKNmyhEMcNvqL
         409QlWqo6qVKSU/OPHuZVNtjHPb00quIsTQRew9Ij/7UNXHCk7FITvQEcaz1MjY+mPIv
         cJqnamT9QlH9IcQ9bA8xuUUJaORuxwa3kHIMmZUDr71typN7kz6rreYFa9W5ifsMVeHp
         0s+Ou2k/RKcLVKaI/N6RgHU54PaCEp1VgcXA7xaDCCRgAKX0F5ddk0pMRsubWrf9HYuI
         tiC3izns5VoCfKOlDhRpS1MOgiofLiiNJd9BGfDVXJ/1LDIB/EKW3QX8+uXwnGjeHCqA
         AE0w==
X-Gm-Message-State: APjAAAXhWExifCdlbH3qKs6lxbyELYvgAfiOxwQRvlwaV3XREH93bp4J
        29coENWVjuhGUfOP+oBPbfC9nKClyD7wVlc0B3KP5Q==
X-Google-Smtp-Source: APXvYqxXOc1rbvj07KJ9c3TSP8OsrNH8c+zeKh7yobG+clGIFT8mWGYzXYV4CzB3jyz+d2U30aZ1uM7tkgdDuw0Arqk=
X-Received: by 2002:a1f:23d6:: with SMTP id j205mr10128228vkj.52.1560183487698;
 Mon, 10 Jun 2019 09:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190501175457.195855-1-rrangel@chromium.org> <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
In-Reply-To: <20190607160553.GA185100@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 18:17:31 +0200
Message-ID: <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after reset
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Fri, 7 Jun 2019 at 18:05, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Tue, May 28, 2019 at 09:38:20AM +0200, Ulf Hansson wrote:
> > On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> First off, thanks for the review.
>
> > >
> > > There is a race condition between resetting the SDHCI controller and
> > > disconnecting the card.
> > >
> > > For example:
> > > 0) Card is connected and transferring data
> > > 1) mmc_sd_reset is called to reset the controller due to a data error
> >
> > I assume you refer to mmc_sd_hw_reset()? In that case, I think you
> > have interpreted the purpose of mmc_sd_hw_reset() slightly wrong. It's
> > responsibility is to reset the SD-card and not the host/controller.
> You are correct. I was looking at a 4.14 kernel where it's called
> mmc_sd_reset. 4.19 and above call it mmc_sd_hw_reset.
>
> All I was trying to convey here was that a block error will eventually
> call sdhci_set_ios with SOFT_RESET_ALL via:
> mmc_blk_reset
> mmc_hw_reset
> mmc_sd_hw_reset
> mmc_power_cycle
> mmc_power_off
> mmc_set_initial_state
> sdhci_set_ios
> sdhci_reinit
> sdhci_init
> sdhci_do_reset(host, SDHCI_RESET_ALL);
>
> >
> > Whether there some additional "reset" of the controller needed, that
> > is assumed by the core, to be managed via the ->set_ios() callback for
> > the host.
> >
> > > 2) sdhci_set_ios calls sdhci_do_reset
> > > 3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
> > > configured.
> > > 4) Wait for SOFT_RESET_ALL to clear
> > > 5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
> > >    IRQs are not configured a CARD_REMOVED interrupt is never raised.
> > > 6) IRQs are enabled again
> > > 7) mmc layer never notices the device is disconnected. The SDHCI layer
> > >    will keep returning -ENOMEDIUM. This results in a card that is always
> > >    present and not functional.
> >
> > This sounds like host specific problems, which most likely should be
> > fixed in host driver, solely. Unless I am missing something, of
> > course.
>
> So in sdhci_do_reset we call the reset callback which is typically
> sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
> controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
> controller will clear the IRQ mask. If during that 100ms the card is
> removed there is no notification to the MMC system that the card was
> removed. So it seems like the card is always present.

So you are saying that the problem occurs when the card is removed
during this 100ms period?

I assume there a way for sdhci to re-validate whether the card has
been removed during this period, right?

>
> > >  drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > index 265e1aeeb9d8..9206c4297d66 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
> > >
> > >  static int mmc_sd_hw_reset(struct mmc_host *host)
> > >  {
> > > +       int present;
> > >         mmc_power_cycle(host, host->card->ocr);
> > > +
> > > +       present = host->ops->get_cd(host);
> > > +
> > > +       /* The card status could have changed while resetting. */
> > > +       if ((mmc_card_removed(host->card) && present) ||
> > > +           (!mmc_card_removed(host->card) && !present)) {
> > > +               pr_info("%s: card status changed during reset\n",
> > > +                      mmc_hostname(host));
> > > +               host->ops->card_event(host);
> > > +               mmc_detect_change(host, 0);
> > > +       }
> > > +
> > > +       /* Don't perform unnecessary transactions if the card is missing. */
> > > +       if (!present) {
> > > +               pr_info("%s: card was removed during reset\n",
> > > +                       mmc_hostname(host));
> > > +               return -ENOMEDIUM;
> > > +       }
> > > +
> >
> > When doing a  mmc_hw_reset() (which ends up calling mmc_sd_hw_reset()
> > in case of SD cards), we are making a final attempt to make the card
> > functional again, via a power cycle and a re-init of it.
> >
> > In this path, we don't care whether the card is removed, as that
> > should have been detected already when the block layer calls
> > mmc_detect_card_removed().
>
> mmc_detect_card_removed has the guard `host->detect_change` to
> prevent it from checking the card status again. So maybe the fix to the
> missing interrupt/race condition is to set `host->detect_change = 1`
> from sdhci_do_reset after calling the reset handler. This way there will
> always be a single poll after a full reset so the correct card status can
> be detected?

It sounds like you should call mmc_detect_change(), after the reset to
let the core check for cards that may have been removed/inserted.

Would that work?

[...]

Kind regards
Uffe
