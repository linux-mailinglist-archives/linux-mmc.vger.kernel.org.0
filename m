Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7481F976D
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 18:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLRnB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 12:43:01 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39511 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLRnB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 12:43:01 -0500
Received: by mail-il1-f193.google.com with SMTP id a7so15877468ild.6
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3UHqP3o5zZJEpYfrtVP0mD87+dZ1Bwo+ajrvoNwtlM=;
        b=X1PfXE8W6HzqybqIKAx4IeCMwl6LGXCAgVVjo3JYE7YJIE9ttLAVoCxypLJPp7Kbka
         IHKtZVHOuKbAT1dZ9BBY5MKiFr3O/r9Be9+plwm1n4oqjaiUdf9deCjnPmbn0NIvKB2l
         RBMRwAy3HhLBwzsaU4XDhGarkG1kT1lOCdOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3UHqP3o5zZJEpYfrtVP0mD87+dZ1Bwo+ajrvoNwtlM=;
        b=EuPEu9PgpRcihj3tUTbaE10S+uUJuo0abPUH64IW2Bf39+dUAmwrvRMl6nXXJzdC52
         xKUL0h58Jpb9lPPjB4ycX+j9hMdQ2Q6fC3i/Y7YpGLrCB0QWq8PaQ4n7k91yts0ALGf1
         TcDHXpA93ntoI6o93xON0CaiJdwgWAJRXZYKhWZEIx3vbv/T7yJ6K8bNU6Qu3Nhpinez
         24QFPUOVix3jYfk9b8TWFRcDM8Iz+tq00/4tNxVg3zmvablOhIsURU56IAZPWiiGE+XI
         B8yp+5S6EINwmZqT5O4eBBtxoZGtRCoUcOwqoBvQxCdEy7Acr8JPXiQZFXK3+t0nh2Y9
         ub7Q==
X-Gm-Message-State: APjAAAVYcVGTYVgTnbD/syf2qXWBaS5c58WfKNyyuQTWkq8DswNhNAHK
        Jn7IrGJH5+yTcb7l5x+GTpCXE/LT5h8=
X-Google-Smtp-Source: APXvYqzfbFMkwymHg4WHbPHzNYl2d8DApwu/9qCTlf1GvdhsWMYNrQOoUG+RHsoJ5Mgbf35zTY3icw==
X-Received: by 2002:a92:864f:: with SMTP id g76mr33719648ild.37.1573580579845;
        Tue, 12 Nov 2019 09:42:59 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id t7sm1594138iog.85.2019.11.12.09.42.58
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:42:59 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id z12so16348610ilp.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 09:42:58 -0800 (PST)
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr36050724ilo.58.1573580578448;
 Tue, 12 Nov 2019 09:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com> <CAPDyKFq5=B8u=9awGaXuhTmYK6Sbbe6EmF9EMhBQQyyrD1bKRw@mail.gmail.com>
In-Reply-To: <CAPDyKFq5=B8u=9awGaXuhTmYK6Sbbe6EmF9EMhBQQyyrD1bKRw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Nov 2019 09:42:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA@mail.gmail.com>
Message-ID: <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Nov 12, 2019 at 4:28 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Nov 2019 at 01:51, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v2:
> > >         - Add adaptations to the mwifiex driver.
> > >         - Keep existing syncronous reset behaviour if the SDIO card has a single
> > >         func driver.
> > >
> > > It has turned out that it's not a good idea to try to power cycle and to
> > > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > > because there may be multiple SDIO funcs attached to the same SDIO card and
> > > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > > simply experience an undefined behaviour.
> > >
> > > The following patches in this series attempts to address this problem, by
> > > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > > mwifiex driver to these changes.
> > >
> > > Note that, I don't have the HW at hand so the the code has only compile tested.
> > > Test on HW is greatly appreciated!
> > >
> > > Ulf Hansson (3):
> > >   mwifiex: Re-work support for SDIO HW reset
> > >   mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
> > >   mmc: core: Re-work HW reset for SDIO cards
> > >
> > >  drivers/mmc/core/core.c                     | 12 +++-----
> > >  drivers/mmc/core/core.h                     |  2 ++
> > >  drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
> > >  drivers/mmc/core/sdio_bus.c                 |  9 +++++-
> > >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> > >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> > >  include/linux/mmc/card.h                    |  1 +
> > >  8 files changed, 70 insertions(+), 22 deletions(-)
> >
> > I put this on rk3288-veyron-jerry atop v5.4-rc7 and I could run my
> > test case for a while, AKA I got over 50 cycles of:
> >
> > ---
> >
> > for i in $(seq 1000); do
> >   echo "LOOP $i --------"
> >   echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
> >
> >   while true; do
> >     if ! ping6 -w15 -c1 "${GW}" >/dev/null 2>&1; then
> >       fail=$(( fail + 1 ))
> >       echo "Fail WiFi ${fail}"
> >       if [[ ${fail} == 3 ]]; then
> >         exit 1
> >       fi
> >     else
> >       fail=0
> >       break
> >     fi
> >   done
> >
> >   hciconfig hci0 down
> >   sleep 1
> >   if ! hciconfig hci0 up; then
> >     echo "Fail BT"
> >     exit 1
> >   fi
> >
> > done
> >
> > ---
> >
> > NOTE: with no patches I couldn't even get my test case to pass w/out
> > the BT bits and I swear that used to work before.  ...but I didn't
> > debug since the end result (with full card hotplug) is happy-working
> > for me.  I'll still use it as further argument that (IMO) full unplug
> > / plug of the card is better it uses more standard code paths and is
> > less likely to break.  ;-)
> >
> > Tested-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks, I add this to the series and make a re-spin.
>
> What do you think about tagging the patches for stable?
>
> I guess there is a risk that we may "break" the other two users of
> mmc_hw_reset(). But, as I said, in that case those needs to be fixed
> anyways.

I'm not sure how to make that judgement call.  Certainly it would help
anyone using the Marvell case and the Marvell case was pretty broken
before.

How about this: if you can get a Tested-by from the other users then
I'd be good with a general CC: stable.  Otherwise, I'd be OK with a CC
to stable for 5.4, but I'd be a little hesitant to send it back to
older kernels (even though it certainly applies and fixes problems).
At least in the case of Chrome OS we already have a workable solution
for our 4.19 tree (my previous patches), and I'd guess anyone testing
on real hardware is either not seeing problems or has their own
private patches already.  If things have been sitting stable on 5.4
for a while and no problems were reported, then we could consider
going back further?

-Doug
