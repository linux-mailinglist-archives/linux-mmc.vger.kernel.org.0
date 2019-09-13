Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EFB1B88
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfIMK0R (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 06:26:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34853 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMK0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 06:26:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so1739664oii.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 03:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D22Mmt9ry5OzybBfP/oMoP/FlgIJEpY9ClnkMxOn6iM=;
        b=fB7YWrd2e7OhCuFLYy9ZB27GWVFKnXI6LBC1h4CUbn/uPycwh0b04CZXHQB0fOvFpo
         05oDUPhAg8oMWKJerxJNgUDVJ5JTqyW5Hs/QS1mTrTrQ9qq/2adRYAIbUufrgXW0a8Zw
         famRUhue1vknqXxROAVcer/A7smPB8rlWQNT+88JBjqMr1ROGW7RM0JxrQfXESNcUggC
         2K3jgmd8GkkMXhbN0GjIMXHa6Akg/TeXisg9vsevxzEG278NaWkudORnLB2rp+OUmWMy
         pZ/qqFue9IzU40/WRxERcyLdTQiHRWm9hE4nUoPeDWAaI/FV3Wte8EPrvxXGB0+RRMOR
         lwjA==
X-Gm-Message-State: APjAAAVQeOdWHcM3uYbgU64zRqxiVOPTTd5RNuw61PF39XcoHj9byUpB
        YEKYnEGXpZ0LL30nvwRkAXaDxrBdcXK1vEhOHOfy7w==
X-Google-Smtp-Source: APXvYqyrVCY52WZWVvAgteBdbpn0UhWosk5145tHgxpmabnCl0WExkqcnP7WFWXYnMdG98wHYn3Pau54YyZvnYq3J5E=
X-Received: by 2002:aca:f305:: with SMTP id r5mr2400740oih.131.1568370375866;
 Fri, 13 Sep 2019 03:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
 <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
 <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
 <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com>
 <CAMuHMdV8SXKUXjV57W2X_kCKQgmWH91KyLEFsHW1zHPK1G5e-A@mail.gmail.com> <CAPDyKFoCC4m_EDmgU2qc7UCsnuUfFg_b9tG_QuojsWYxiG3_QQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoCC4m_EDmgU2qc7UCsnuUfFg_b9tG_QuojsWYxiG3_QQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Sep 2019 12:26:04 +0200
Message-ID: <CAMuHMdW=1By9J7Z4qXG8hwnjgBVg78oK94yCgad=AXJ0HZSmog@mail.gmail.com>
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

On Fri, Sep 13, 2019 at 11:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 13 Sep 2019 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Sep 13, 2019 at 11:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 13 Sep 2019 at 09:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > > > > > <niklas.soderlund@ragnatech.se> wrote:
> > > > > > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > > > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > > > > > >
> > > > > > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > > > > > >
> > > > > > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > > > > > >
> > > > > > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > >
> > > > > > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > > > > > for a few days.
> > > > > > > > >
> > > > > > > > > If you have any objections, please tell.
> > > > > > > >
> > > > > > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > > > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > > > > > >
> > > > > > >
> > > > > > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > > > > > also on the road until the end of next week ;-(
> > > > > >
> > > > > > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > > > > > I do not have any SD cards inserted.
> > > > >
> > > > > Thanks for testing!
> > > >
> > > > [...]
> > > >
> > > > > Let's have a look at that in the next steps though and fix the probe
> > > > > problems first. I can post a patch or two in an hour or so, have you
> > > > > the possibility to test this today?
> > > >
> > > > Probably I can. Else it'll happen on Monday.
> > >
> > > Currently compile testing, posting three patch in few minutes.
> > >
> > > If we can't make it today, we will probably don't make it for 5.3. On
> > > the other hand, the problem has been there for a while anyway.
> >
> > Oh, I thought you were aiming for v5.4...
> >
> > Including it in v5.3 may be a stretch, as Wolfram and Niklas can't test it
> > before the release of v5.3.
>
> The point is, v5.3 is broken anyway and older kernels as well.
>
> Anyway, the patches is out, let's see what you find out.

Thanks!

I've reverted this one, and applied:

[PATCH 1/3] Revert "mmc: tmio: move runtime PM enablement to the
[PATCH 2/3] mmc: tmio: Fixup runtime PM management during probe
[PATCH 3/3] mmc: tmio: Fixup runtime PM management during remove

All SDHI devices are properly started again.

After boot, clock use counts are now consistently at 2, for all boards,
i.e.:

-clk_summary:             sdhi0                    3        3        0
   97500000          0     0  50000
+clk_summary:             sdhi0                    2        2        0
   97500000          0     0  50000

After s2ram, clock use counts are the same as before s2ram, so no
imbalance detected. Good.

S2ram still cause regulator imbalances, but that's not genpd related.

-regulator_summary: fixed-1.8V                       2    1      0
unknown  1800mV     0mA  1800mV  1800mV
-regulator_summary:    ee140000.sd                   1
                0mA  1800mV  1950mV
-regulator_summary: fixed-3.3V                       2    1      0
unknown  3300mV     0mA  3300mV  3300mV
-regulator_summary:    ee140000.sd                   1
                0mA  3300mV  3400mV
+regulator_summary: fixed-1.8V                       1    1      0
unknown  1800mV     0mA  1800mV  1800mV
+regulator_summary:    ee140000.sd                   0
                0mA  1800mV  1950mV
+regulator_summary: fixed-3.3V                       1    1      0
unknown  3300mV     0mA  3300mV  3300mV
+regulator_summary:    ee140000.sd                   0
                0mA  3300mV  3400mV

No change in use counts after subsequent s2ram cycles.

And eMMC on Salvator-XS is still working.

A good state to enter the weekend ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
