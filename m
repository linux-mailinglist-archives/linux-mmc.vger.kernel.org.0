Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F4B191C
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfIMHoE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 03:44:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40525 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfIMHoE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 03:44:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so28624388ota.7
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 00:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mnk/Cy6U8Y2sczBwGjedNcvTisEeHKxttvyyxOvc/A=;
        b=DAYNB9iFPuy6IF5A/nICraxFQZciuMXJST716JADQ4TAJnXSKmbgwwZpkLOSofpUvJ
         5V8ooBPBEB65k2Re/V7+bogDb0IMDS81whDPaDoTi+2LQQ2UDRkps2n18B3GETlamHet
         vrEdabp3gxxl/4YHZHp3Ex55cIXl5UjyQMSHAWMygNRH8D1T+QEyXFwEtXJaI52qQhlX
         XbdvO6YvHKRP7F6iwKuew294btGzQ4ABB6PTy50kbnQ3ByzMX+G5JkdwQp81gyj56W2s
         a/uEDKFs6JwEpxAMbWAVX2ibKS7dzuA7K7ksJPpffGGgGCh3Qw9AWukOuCPslKF99/ht
         LoQw==
X-Gm-Message-State: APjAAAXXeupfUuer8PXVIXUJPPJ+SM8CkjeP3emVf0Ly5svjJNeSqFFR
        4DlyznC4ZPIvyp+gzIYady2HUwANeByyfnZ4c04=
X-Google-Smtp-Source: APXvYqxMyKtDE9+Ndcv/pAJmJmFJHQTFznjW1mJFi2GxIyY0edHsBGgggENw2bXYb9howH1h4y3W84B02UtpMKKtsN4=
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr15084257otq.39.1568360641897;
 Fri, 13 Sep 2019 00:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com> <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Sep 2019 09:43:50 +0200
Message-ID: <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
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

On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > >
> > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > >
> > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > >
> > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > >
> > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > for a few days.
> > > > >
> > > > > If you have any objections, please tell.
> > > >
> > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > >
> > >
> > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > also on the road until the end of next week ;-(
> >
> > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > I do not have any SD cards inserted.
>
> Thanks for testing!

[...]

> Let's have a look at that in the next steps though and fix the probe
> problems first. I can post a patch or two in an hour or so, have you
> the possibility to test this today?

Probably I can. Else it'll happen on Monday.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
