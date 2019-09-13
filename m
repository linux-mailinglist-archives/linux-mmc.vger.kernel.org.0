Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07DB1B0A
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfIMJoG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 05:44:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43821 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfIMJoG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 05:44:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id u21so18154197vsl.10
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80RvEwYyuB+u/98u+eWvtmDgBVcfY4scsu9DHWzqZxs=;
        b=L0dZYTvEqgBLimoKJx2lzzayIj8+os5aC6aMMzwAVz3T17Jel/0H4c/875PR82tmVc
         9C55oIfP/BiKkVGjS3Kf16pUAx+NLZOjPyBfTwVZILMUncs0ALeljrCAPxqj9OfEH3gn
         E5M+Lh2lgRzEQzm9olZA+c8r1yr+pgRJOyhRrywHfAV4dmEeff6YdaZEjx0S5kGkdrYa
         jqNSxeJc/+sio8eZ7DW2UbnbQkBwnDcUbfRcKA0WGlokKRTGHOy7vpXXpprqlOFlYh77
         zQv0zLZygRsYUTWfvFdmcwSUASs6qCsnvSVFuv6C0NMuPFO6W+NquX7ZPcODD/ROz2ev
         WRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80RvEwYyuB+u/98u+eWvtmDgBVcfY4scsu9DHWzqZxs=;
        b=fLIqidrhJAYlchcmtoyrBpLgJksGTSerm1xgqsWOKYlmTQyNn1mWi+OhTMxhQqI7P4
         FUtDoN0sWiw1d7HzUUtu4fHYDQ6xLRaZjVZkChSM1bRmSJg7UKqOZSgwPvcz9MWS3KTe
         fOZbmnmtoRpzaT+eVbDKOtT/+HedQUzi22so1mknwYbQaNLe03FwCGjZa8Qnqy9+G/I/
         7VJZECxDIpE9IrRJbRP1vK5lirXdlTxzjjtlO245rM0tded1bomAzGoCWO4cf1Ku9CfH
         2cA4AsgtSGn+PCd2+hMIpMRlsCBJxOc7Iauhj+eCaIsNvB+LiY4iMg3MmUz8xDNY7knI
         kOcQ==
X-Gm-Message-State: APjAAAWV6JvUSnsYIe9vZiZmSepKrnaEsSmN7EQSC2grPxW91K6JcwH5
        gMYKn4QGkkfZVy/fiFwKHXdpE/OIzUsV3zMkN0SACg==
X-Google-Smtp-Source: APXvYqxXGEmHtPVfonl0/l/TtQ9KmOUzjVuNfLkqltHh0O5+83iSzBtoYR8HzHWsa7WQNQUS/oq9EDShQeaeX0coy6M=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr25614558vsm.165.1568367845002;
 Fri, 13 Sep 2019 02:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
 <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com>
 <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
 <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com> <CAMuHMdV8SXKUXjV57W2X_kCKQgmWH91KyLEFsHW1zHPK1G5e-A@mail.gmail.com>
In-Reply-To: <CAMuHMdV8SXKUXjV57W2X_kCKQgmWH91KyLEFsHW1zHPK1G5e-A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Sep 2019 11:43:29 +0200
Message-ID: <CAPDyKFoCC4m_EDmgU2qc7UCsnuUfFg_b9tG_QuojsWYxiG3_QQ@mail.gmail.com>
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

On Fri, 13 Sep 2019 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Sep 13, 2019 at 11:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 13 Sep 2019 at 09:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > > > > <niklas.soderlund@ragnatech.se> wrote:
> > > > > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > > > > >
> > > > > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > > > > >
> > > > > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > > > > >
> > > > > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > >
> > > > > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > > > > for a few days.
> > > > > > > >
> > > > > > > > If you have any objections, please tell.
> > > > > > >
> > > > > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > > > > >
> > > > > >
> > > > > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > > > > also on the road until the end of next week ;-(
> > > > >
> > > > > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > > > > I do not have any SD cards inserted.
> > > >
> > > > Thanks for testing!
> > >
> > > [...]
> > >
> > > > Let's have a look at that in the next steps though and fix the probe
> > > > problems first. I can post a patch or two in an hour or so, have you
> > > > the possibility to test this today?
> > >
> > > Probably I can. Else it'll happen on Monday.
> >
> > Currently compile testing, posting three patch in few minutes.
> >
> > If we can't make it today, we will probably don't make it for 5.3. On
> > the other hand, the problem has been there for a while anyway.
>
> Oh, I thought you were aiming for v5.4...
>
> Including it in v5.3 may be a stretch, as Wolfram and Niklas can't test it
> before the release of v5.3.

The point is, v5.3 is broken anyway and older kernels as well.

Anyway, the patches is out, let's see what you find out.

Kind regards
Uffe
