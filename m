Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC7B1AE0
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfIMJc4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 05:32:56 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32785 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfIMJc4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 05:32:56 -0400
Received: by mail-vs1-f68.google.com with SMTP id s18so18206432vsa.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOGLWITyzRdiMnYJPk3QROLMpfZjm8cL1Jr52Cc0QFY=;
        b=ON7L9R9dAFdLm/XwXOl6JD+RvXmcfdjyTM+xAlF3nvHSjuQ4CHTDxQi5OHd32mum2X
         6nHgxbBRfbAUpUyr0jL+WsgSfIpRVIwpLKqAY241EvxRQN3v2FQEUBGIzqO+PMdbM4Lo
         JG+DOGLb36S5SdcLEBHPUOtC/+/amp0zmctKfgH9FdHZkufTNWh//H1o0le0KSbPgdVx
         IVWLgeNAa5oi4QXPvyQg+CboQ8u4y7FxzNgPvxoKeLlRlfsW7Zy7rHKv65oFRvpi/zci
         p+UQklg2mUff9ZiHSenqNR0Z7Xbj3HQny03OvgiBqxX1+PgPuO1vWO64GTUp9NuzZ8/z
         NpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOGLWITyzRdiMnYJPk3QROLMpfZjm8cL1Jr52Cc0QFY=;
        b=Fk8774661jzaCUrA7pFAyQgr6eI0LKAbhDL0x3nRpbsyf9D8YSRkYy++PxxudpoSCF
         k13diwIys6hiZ4OK9rngu0RIq1Tsu2YyMjgYPhiI2NydbJ/6r5LOWtiE7DdXG4zEYpmr
         yOImhd2myeLSyHKZwl5Wkpplz9T8h+al97dQtotm6mPabkhVIAk13oRNAPwsrNunHr1s
         C+QT/ocRLi1iO0rL7v7ZD4iSHSJUbpcqoPixZ9pmxGADrJ9pgDGF5ihahMOdSFoQqDB8
         4Ifhd8cOOlQtU/NUQwKVI7CLVV8+ZKM3kSe6A2Vxk+CFsuKgu2EcKzoD38fiCN1MXthk
         52sw==
X-Gm-Message-State: APjAAAX/xdi3OVvzvebQETRyy9UjCgfBFkKUYo2knPbJBmqwRoYtfYK8
        Amv5H2WTo1xKLKL8aI/yip/O/LYevVb5qoyzic+24A==
X-Google-Smtp-Source: APXvYqx1VsUMyXHh7H1hlUp0hltAlBCaVvieax960rnPqO7USywaJzQPegvccZmm5+Pq4BS0h2O0J8ODkYTzZ5uUJgE=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr25590863vsm.165.1568367174960;
 Fri, 13 Sep 2019 02:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
 <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
 <CAPDyKFrD_YsKubH=aOSxSv-h83Q1vh4+evPHVTN5pciXSSQLnQ@mail.gmail.com> <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
In-Reply-To: <CAMuHMdWL7Wcq17abiPuC7mQuSJU8MyfAbJBcAMjB1nKStXTGDw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Sep 2019 11:32:18 +0200
Message-ID: <CAPDyKFqPeW6ExFTvyxwHepVMKAuur88=cRLkvZ=__v=ZgTQz6A@mail.gmail.com>
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

On Fri, 13 Sep 2019 at 09:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Sep 13, 2019 at 9:41 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 13 Sep 2019 at 08:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
> > > <niklas.soderlund@ragnatech.se> wrote:
> > > > On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > > > > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > > > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > > > > >
> > > > > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > > > > To avoid the device from being runtime suspended during the probe phase,
> > > > > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > > > > >
> > > > > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > > > > >
> > > > > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > >
> > > > > > So I decided to apply this for my fixes branch, as to get it tested
> > > > > > for a few days.
> > > > > >
> > > > > > If you have any objections, please tell.
> > > > >
> > > > > Sadly, I can't test until next week because I am still on the road. Yet,
> > > > > I recall Niklas said at LPC that the patch looks good to him, at least.
> > > > >
> > > >
> > > > Yes I think it looks good and was planing to test it. Unfortunately I'm
> > > > also on the road until the end of next week ;-(
> > >
> > > So I decided to give it a try on my boards.  Note that apart from eMMC,
> > > I do not have any SD cards inserted.
> >
> > Thanks for testing!
>
> [...]
>
> > Let's have a look at that in the next steps though and fix the probe
> > problems first. I can post a patch or two in an hour or so, have you
> > the possibility to test this today?
>
> Probably I can. Else it'll happen on Monday.

Currently compile testing, posting three patch in few minutes.

If we can't make it today, we will probably don't make it for 5.3. On
the other hand, the problem has been there for a while anyway.

Kind regards
Uffe
