Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E92B1C7D
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfIMLrX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 07:47:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35285 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfIMLrX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 07:47:23 -0400
Received: by mail-vk1-f193.google.com with SMTP id d66so5865067vka.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgvhnq9VtqxDcnZFagc1uZ4NkHTr20zRtb+25U5Eqco=;
        b=qXv/UBmy9zQGO6DJepFcOKtegcyIeBiO56fhFon1V/5ueyCfymQXxVRasgGaqSXEJN
         wNlZeS7lHcS1J+FfidIX7ig1zc+ZAesRgFeq09fGnKqhVet5x9Gd17qSZYeupB+sVR9n
         TfUTTXTk+uYpj6KKwaqqOn5nEit/KxhTcJvugOqV5wWLMDIIAPqXgDnbW/UodR1Qmry1
         zNaNYfvcn5e9aGGYONFAqE7VnBm3Zrkz3n54+PtjBSj8mvAdqYRf7niUrVdyuT10YV6t
         X2uL0hWD2sryVmYnATAQQzq+ZE0POJIn5VYnyKGWVa73MBjdacLrM50yDPMFw3hXHJbS
         y8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgvhnq9VtqxDcnZFagc1uZ4NkHTr20zRtb+25U5Eqco=;
        b=e7XTreSte9pOttbdeWPJ3P2W+mzxLUiijEIscoMcxkHw+4Wz3pc6aPoYeR9gU4XikK
         6Q3VhANlEbfetB9qn5y3viBnKr8OyXd+JEm4BynvD3udNWlJlzAzWnE4wtr0CptHdT06
         HTyumafUoxJ9ujbDwxnTM8+xcLCMsu9Sm7slWYmBAoakmK98CQN10iev+SqCfULHP5oF
         nnQS3oz/PwmQBGSiatdyIHjXrtVadhwIBWz5/EgbTER/C1XbdepRWOzqJF8U0hKM/epd
         uawe0V0izsM7GdJL6TTdNatdYJUOC3wZl6RS9ZMHSfTahFZLCyoaI5+hc2J23As3wIGA
         ++TA==
X-Gm-Message-State: APjAAAXF609yOFe/ykeLMzBEYuX5kFeIy6pvuEtbhT9qFaLpA1kbcNyS
        Tix4HQZO/+32vBN5v0nJWcTGgP+RiugrH/ajZ/zv7g==
X-Google-Smtp-Source: APXvYqx3MhkDrlv4qP70LiXe+gT2RJ5jH0nMA1RFVhzJVxTU53S0tQohwun79VN1qSvkwu+6MLuWBipxZyrVPxfodrw=
X-Received: by 2002:a1f:3491:: with SMTP id b139mr9715173vka.40.1568375241927;
 Fri, 13 Sep 2019 04:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
 <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
 <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
 <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com>
 <CAMuHMdV8SXKUXjV57W2X_kCKQgmWH91KyLEFsHW1zHPK1G5e-A@mail.gmail.com>
 <CAPDyKFoCC4m_EDmgU2qc7UCsnuUfFg_b9tG_QuojsWYxiG3_QQ@mail.gmail.com> <CAMuHMdW=1By9J7Z4qXG8hwnjgBVg78oK94yCgad=AXJ0HZSmog@mail.gmail.com>
In-Reply-To: <CAMuHMdW=1By9J7Z4qXG8hwnjgBVg78oK94yCgad=AXJ0HZSmog@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Sep 2019 13:46:45 +0200
Message-ID: <CAPDyKFoiPOz+tphGSmn9kpy1bqzvXOoKtustbBhCqWX=DSNhZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: Fixup runtime PM management during probe and remove
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Fri, 13 Sep 2019 at 12:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Sep 13, 2019 at 11:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 13 Sep 2019 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 13, 2019 at 11:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Fri, 13 Sep 2019 at 09:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > > > > > > <niklas.soderlund@ragnatech.se> wrote:
> > > > > > > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > > > > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > > > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > > > > > > >
> > > > > > > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > > > > > > >
> > > > > > > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > > >
> > > > > > > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > > > > > > for a few days.
> > > > > > > > > >
> > > > > > > > > > If you have any objections, please tell.
> > > > > > > > >
> > > > > > > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > > > > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > > > > > > also on the road until the end of next week ;-(
> > > > > > >
> > > > > > > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > > > > > > I do not have any SD cards inserted.
> > > > > >
> > > > > > Thanks for testing!
> > > > >
> > > > > [...]
> > > > >
> > > > > > Let's have a look at that in the next steps though and fix the probe
> > > > > > problems first. I can post a patch or two in an hour or so, have you
> > > > > > the possibility to test this today?
> > > > >
> > > > > Probably I can. Else it'll happen on Monday.
> > > >
> > > > Currently compile testing, posting three patch in few minutes.
> > > >
> > > > If we can't make it today, we will probably don't make it for 5.3. On
> > > > the other hand, the problem has been there for a while anyway.
> > >
> > > Oh, I thought you were aiming for v5.4...
> > >
> > > Including it in v5.3 may be a stretch, as Wolfram and Niklas can't test it
> > > before the release of v5.3.
> >
> > The point is, v5.3 is broken anyway and older kernels as well.
> >
> > Anyway, the patches is out, let's see what you find out.
>
> Thanks!
>
> I've reverted this one, and applied:
>
> [PATCH 1/3] Revert "mmc: tmio: move runtime PM enablement to the
> [PATCH 2/3] mmc: tmio: Fixup runtime PM management during probe
> [PATCH 3/3] mmc: tmio: Fixup runtime PM management during remove
>
> All SDHI devices are properly started again.
>
> After boot, clock use counts are now consistently at 2, for all boards,
> i.e.:
>
> -clk_summary:             sdhi0                    3        3        0
>    97500000          0     0  50000
> +clk_summary:             sdhi0                    2        2        0
>    97500000          0     0  50000
>
> After s2ram, clock use counts are the same as before s2ram, so no
> imbalance detected. Good.

Great, thanks for testing!

>
> S2ram still cause regulator imbalances, but that's not genpd related.
>
> -regulator_summary: fixed-1.8V                       2    1      0
> unknown  1800mV     0mA  1800mV  1800mV
> -regulator_summary:    ee140000.sd                   1
>                 0mA  1800mV  1950mV
> -regulator_summary: fixed-3.3V                       2    1      0
> unknown  3300mV     0mA  3300mV  3300mV
> -regulator_summary:    ee140000.sd                   1
>                 0mA  3300mV  3400mV
> +regulator_summary: fixed-1.8V                       1    1      0
> unknown  1800mV     0mA  1800mV  1800mV
> +regulator_summary:    ee140000.sd                   0
>                 0mA  1800mV  1950mV
> +regulator_summary: fixed-3.3V                       1    1      0
> unknown  3300mV     0mA  3300mV  3300mV
> +regulator_summary:    ee140000.sd                   0
>                 0mA  3300mV  3400mV
>
> No change in use counts after subsequent s2ram cycles.
>
> And eMMC on Salvator-XS is still working.
>
> A good state to enter the weekend ;-)

Perfect!

I am queuing up the three patches for 5.3. Yes, it's a bit risky, but
I am quite confident that we have improved things.

Perhaps there are additional changes needed, at least we need to look
into the regulator imbalances at some point.

Thanks and have a nice weekend!

Kind regards
Uffe
