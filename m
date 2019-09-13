Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6002FB1AED
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbfIMJiv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 05:38:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38633 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfIMJiv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 05:38:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so1628483oip.5
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 02:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CeOEdCfqM+Yat/P1k/g/Et49SytqJEm7dLk8XzJ8jg=;
        b=LoHuD3k3aeFPUJPFHOsMVhV3oIYN6544gbCBTmRIPNlZPtV4uMJWU6nA+DuId6lsaP
         AbHyqHomKCDEgn7A3NXrKF+8uyswXFAjDEbPlbI1KXqJYSAKjk0KxjdxvFIOqSSyZvAc
         RQxkg1DsblWXk/ETVOE78BDDTs1Gf60RVFui1dSl0ZdvY/dyY4+Heg0Hpq9cWy3jtnFa
         cREQ+EBWu7uQDeGJjqMmXiPv5rNFGRwIVw1dqh87yzSIFYzzZQJo85nFVGJQZra+ngKx
         pWPBNzpEQDgDKeSrhGrTuyjy8HLFo8HbworAkczP47JeWOPiKJ0q6tQfgfX95oLcgr+n
         ThJQ==
X-Gm-Message-State: APjAAAXfYvhpCS2LNg7xfj3BsTJcER8o+aeAxxoABVf2H/3C0Rxm8x9f
        4r6Vpe2sbJPP/KZQ2YifcbGSxCQbN+GGpjclRSI=
X-Google-Smtp-Source: APXvYqxZgo7qi+WTmJy31KV5AeBUxHG+cuNcp+BzvWnIWG6jzce8L+q6Y7bT+B9sMRBJh9EBh20+bNwzi6eG/1hd7e0=
X-Received: by 2002:a05:6808:98a:: with SMTP id a10mr2466810oic.54.1568367530262;
 Fri, 13 Sep 2019 02:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
 <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
 <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com> <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com>
In-Reply-To: <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Sep 2019 11:38:39 +0200
Message-ID: <CAMuHMdV8SXKUXjV57W2X_kCKQgmWH91KyLEFsHW1zHPK1G5e-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: Fixup runtime PM management during probe and remove
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, Sep 13, 2019 at 11:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 13 Sep 2019 at 09:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > > > <niklas.soderlund@ragnatech.se> wrote:
> > > > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > >
> > > > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > > > >
> > > > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > > > >
> > > > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > > > >
> > > > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > >
> > > > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > > > for a few days.
> > > > > > >
> > > > > > > If you have any objections, please tell.
> > > > > >
> > > > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > > > >
> > > > >
> > > > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > > > also on the road until the end of next week ;-(
> > > >
> > > > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > > > I do not have any SD cards inserted.
> > >
> > > Thanks for testing!
> >
> > [...]
> >
> > > Let's have a look at that in the next steps though and fix the probe
> > > problems first. I can post a patch or two in an hour or so, have you
> > > the possibility to test this today?
> >
> > Probably I can. Else it'll happen on Monday.
>
> Currently compile testing, posting three patch in few minutes.
>
> If we can't make it today, we will probably don't make it for 5.3. On
> the other hand, the problem has been there for a while anyway.

Oh, I thought you were aiming for v5.4...

Including it in v5.3 may be a stretch, as Wolfram and Niklas can't test it
before the release of v5.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
