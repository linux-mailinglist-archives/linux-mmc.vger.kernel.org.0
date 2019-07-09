Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E563DAE
	for <lists+linux-mmc@lfdr.de>; Wed, 10 Jul 2019 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGIWC2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Jul 2019 18:02:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42369 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIWC2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2019 18:02:28 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so278894ior.9
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sE4NKAsAUCBrOoJJlQGFGONnI25LZ8VJyW5bZdMAldA=;
        b=csEtg0QR+7h5Gms4ZYWjqF1SrCZe0wKysQfyLsB5y2lFOJxjevCLZfeRa9DK5bpmpD
         siDpAUzlzE7pPEuUM9r1j2bufy9VDkW5gxslxUPS4Rr+7buWtm59AWt9VzJD4SA6ehz3
         ZcNR1AM/nPga438L7EN2nlmhgUyNIts8v+NYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sE4NKAsAUCBrOoJJlQGFGONnI25LZ8VJyW5bZdMAldA=;
        b=OE/tr6Q3J6P7S0MwkugX2yaXtZM29Ne2E2eYMeCPj9I6++rOhUTP9Nq+rxFDN7mzOx
         7qwc22R3ZyfWEcsITogoi0cKr00DwCOmhMI/vB/ZKUCoL4dgf2gTWFSvsqjTrLAiAKbK
         uqvNyim7TtJR8HUvRzweiRfjn61xjOqdrT2IOKOexvO2HH5+nDJcCbCaR9X543Ldew59
         tLPmY6Xt+gLY15XFydDF31MPEOe/nxkH5pal/nF552zgReOwxf+nBR9MLt8NX2/DHdsf
         qEqllctQAi0SDrVmVmbK20hLHj9uovCEzM008ca/oX0cYSEU//OJ+n6FpCG32/xyLVPI
         bHJA==
X-Gm-Message-State: APjAAAVKz40MFtcPxT12FmAMM4dfs2K9c1B5tBvXzrTAs+1txBtCfkJX
        JxxOjIEtoGJn/ejdZRimVvk527WHYEw=
X-Google-Smtp-Source: APXvYqxPee3uqUzmvNGDNBTZuY+stBueDFonJMiDKfq8lPgUMJ3Vwn5881UH7v7R1EjYRaTf/Ob1NA==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr1883212iod.254.1562709746647;
        Tue, 09 Jul 2019 15:02:26 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id 20sm18892iog.62.2019.07.09.15.02.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:02:25 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id o9so352494iom.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 15:02:25 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr2673410iok.52.1562709744643;
 Tue, 09 Jul 2019 15:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org>
 <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com> <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
In-Reply-To: <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 15:02:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
Message-ID: <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jul 9, 2019 at 9:38 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 9, 2019 at 2:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> > > response errors.") we fixed a tuning-induced hang that I saw when
> > > stress testing tuning on certain SD cards.  I won't re-hash that whole
> > > commit, but the summary is that as a normal part of tuning you need to
> > > deal with transfer errors and there were cases where these transfer
> > > errors was putting my system into a bad state causing all future
> > > transfers to fail.  That commit fixed handling of the transfer errors
> > > for me.
> > >
> > > In downstream Chrome OS my fix landed and had the same behavior for
> > > all SD/MMC commands.  However, it looks like when the commit landed
> > > upstream we limited it to only SD tuning commands.  Presumably this
> > > was to try to get around problems that Alim Akhtar reported on exynos
> > > [1].
> > >
> > > Unfortunately while stress testing reboots (and suspend/resume) on
> > > some rk3288-based Chromebooks I found the same problem on the eMMC on
> > > some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> > > tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> > > vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> > > same situation.
> > >
> > > I'm hoping that whatever problems exynos was having in the past are
> > > somehow magically fixed now and we can make the behavior the same for
> > > all commands.
> > >
> > > [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
> > >
> > > Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Alim Akhtar <alim.akhtar@gmail.com>
> > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > Marek (or anyone else using exynos): is it easy for you to test this
> > > and check if things are still broken when we land this patch?  If so,
> > > I guess we could have a quirk to have different behavior for just
> > > Rockchip SoCs but I'd rather avoid that if possible.
> > >
> > > NOTE: I'm not hoping totally in vain here.  It is possible that some
> > > of the CTO/DTO timers that landed could be the magic that would get
> > > exynos unstuck.
> >
> > I have eMMC module attached to Odroid U3 (Exynos4412,
> > samsung,exynos4412-dw-mshc). What is the testing procedure? With your
> > patch it boots fine:
> > [    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> > req 52000000Hz, actual 50000000HZ div = 0)
> > [    3.703900] mmc1: new DDR MMC card at address 0001
> > [    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB
>
> To really test it, it'd be nice to see some HS200 eMMC cards enumerate
> OK.  Specifically the patch adjusts the error handling and the place
> where that happens mostly is during tuning.
>
> I'll also try to find some time today to check a peach_pit or a
> peach_pi.  I think I saw one in the pile near my desk so if it isn't
> in too bad of a shape I can give mainline a shot on it.

OK, I managed to get an exynos5800-peach-pi up and running.  I put my
patch in place and am currently at 45 reboots and counting w/ no
problems.

NOTE: in my case I actually had to disable "hs400" mode on my peach-pi
but that's because the board I dug up was an early version of the
board that didn't have the strobe line connected.  However, Alim's
earlier reports of problems were with hs200 anyway and hs200 still
executes the tuning plenty of times.  His reports of problems also
said that he had problems after just a few boots.

So I'll assert that whatever problems were present 4 years ago have
indeed gone away.  I'll leave rebooting happening overnight just in
case, but otherwise I'll assert that this is fine.


-Doug
