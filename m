Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C998BE4EBD
	for <lists+linux-mmc@lfdr.de>; Fri, 25 Oct 2019 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfJYORP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 25 Oct 2019 10:17:15 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37043 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfJYORP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Oct 2019 10:17:15 -0400
Received: by mail-ua1-f68.google.com with SMTP id l38so646994uad.4
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2019 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CAVWEuC0Wr/mgCNhsciXMq3IOIcM2OeEJA1ru10OHU=;
        b=BrEeBRwZDH9LZLeKgrqHeOgCWaKAmVmTI7cMNQIKEaYEOK53dhkfxvTEKUGua8pEYn
         KKNJzY8SmgtZ+dw3qe1Agc2vGppEXIG1RGP5HC2P1kKZXPTbKtIpQR2SQKACoXr5lq0C
         TScshIyi3sg7b5Hy25a2fSckkchRRsFhi9RlnSQvUaIw1Nf3d0C7L32mPGonpNC9s3ad
         f4mEbkmZNu+GPe98/k+KnUyrpi8nNMWjrct9aw2hMFaPKKo5NTYPbfK68XGpHZn2x6Xn
         HuYO8WGSuebDL5haCxBpBYPspmBzdf7z9PY+tx2jmxlCfYCe1cwL6ZN1dZnJqBMUa0Dz
         hUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CAVWEuC0Wr/mgCNhsciXMq3IOIcM2OeEJA1ru10OHU=;
        b=tOl+Tj/18QJEY0S6h+tjhZapTbfKnV+k4DqpHuwvZvqTnn3+c9tDZCh7Y4izfQKvUw
         /dW/If3rrfZg098VTNVEp+tLReMC1GMzw560rdPbBBKo4viP4Zz66LT4Y9+4rtrX/ApW
         zQaCwwkqED/hkMtOqnhhMgFyukV7JJ+XoGcP4KnYnAmKOCSMYgpHh7Qrmz9jlABI5BAr
         C+B+wbgiYj5q86iySmTyc31YJqSAGtpGut+Fwi2HHdSrBouiYwGjSZ7070Ad6ptTK3Y+
         d0naYXRUmRwkR/7saU/i7ioUhbXj0uo6EkxFdIdLYKhvwDb6ND+yP41zZz40y3co63F0
         WO2A==
X-Gm-Message-State: APjAAAWOr2golT9vtfbA9abm9yigdXSAF2pWH2rQ6wZHzTjd4XEsRgFR
        tw5mMd8Ag4QBxgC24O4uJLFuZa6WKYwbFVJigayW7g==
X-Google-Smtp-Source: APXvYqyZno3A9J1kXU5Ta+j5fFJXc9VmiZWw3ERbPW0XjhEwv684O2MnRYorcI0NUgB1j37apIhbef6Vu3yrO3CrrDc=
X-Received: by 2002:ab0:5a97:: with SMTP id w23mr1758543uae.129.1572013032335;
 Fri, 25 Oct 2019 07:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
 <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
 <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com> <CAPDyKFoumdj9u1B4fQh8ws2PqvtYtVekDyq+M4nLs=hriqD-VA@mail.gmail.com>
In-Reply-To: <CAPDyKFoumdj9u1B4fQh8ws2PqvtYtVekDyq+M4nLs=hriqD-VA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Oct 2019 16:16:36 +0200
Message-ID: <CAPDyKFrR7O-Jkmor7=OcRduNS9MMjTH6d0ij1ToYp_=h_viZSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Oct 2019 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Oct 2019 at 16:47, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Oct 21, 2019 at 11:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > > The problem I see here is that callers of this reset function aren't
> > > > expecting it to work this way.  Look specifically at
> > > > mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> > > > things like shutdown / reinit.  Now it's true that the old
> > > > mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> > > > also had SDIO bluetooth, but presumably it worked OK on systems
> > > > without SDIO Bluetooth.  I don't think it'll work so well now.
> > >
> > > Good point!
> > >
> > > I guess I was hoping that running through ->remove() and then
> > > ->probe() for the SDIO func drivers should simply take care of
> > > whatever that may be needed. In some way this makes the driver broken
> > > already in regards to this path, but never mind.
> >
> > Yeah, probably true.  I guess if anyone actually expected to use one
> > of these cards as a removable SDIO card (I have seen such dev boards
> > long ago) then it would always have been possible for someone to
> > remove the card at just the wrong time and break things.
>
> Well, this isn't solely about card removal but driver removal as well.
> And the latter can be managed from user space at any point in time.
>
> >
> >
> > > > Testing shows that indeed your patch breaks mwifiex reset worse than
> > > > it was before (AKA WiFi totally fails instead of it just killing
> > > > Bluetooth).
> > > >
> > > > I think it may be better to add a new API call rather than trying to
> > > > co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> > > > make people move away from it, or something?
> > >
> > > Thanks again for testing and for valuable feedback! Clearly this needs
> > > a little more thinking.
> > >
> > > An additional concern I see with the "hotplug approach" implemented in
> > > $subject patch, is that it becomes unnecessary heavy when there is
> > > only one SDIO func driver bound.
> > >
> > > In one way I am tempted to try to address that situation, as it seems
> > > a bit silly to do full hotplug dance when it isn't needed.
> >
> > True, though I kinda like the heavy solution here.  At least in the
> > mwifiex case this isn't a part of the normal flow.  AKA: we don't call
> > this function during normal bootup nor during any normal operations.
> > It's much more of an "oh crap, something's not working and we don't
> > know what to do" type solution.  I mean, I guess it's still not
> > uncommon that we end up in this code path due to the number of bugs in
> > Marvell firmware, but I'm just trying to say that it's an error code
> > path and not a normal one.  In my mind that means the more things we
> > can re-init the better.
>
> You have a point, but...
>
> >
> > If this was, on the other hand, a reset that we were supposed to
> > always assert when doing a normal operation (like it wants us to reset
> > it when we switch modes, or something) then a lighter operation would
> > make more sense.
>
> This is indeed the tricky part, as it depends on the level of bugs,
> but also under what specific circumstances the reset is getting
> called.
>
> In the TI case (drivers/net/wireless/ti/wlcore/sdio.c) the reset is
> executed at the "power on" case, which for example is at system
> resume. And we want system resume to be as fast as possible...
>
> I am exploring a few options to deal with both cases, let's see what I
> can come up with in a day or two.

FYI, still exploring and trying a few slightly different options. I
should be able to post something early next week, stay tuned. :-)

Kind regards
Uffe
