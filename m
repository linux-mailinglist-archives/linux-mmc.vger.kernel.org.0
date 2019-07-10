Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4863982
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Jul 2019 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGIQi1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Jul 2019 12:38:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35061 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfGIQi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2019 12:38:26 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so35070058ioo.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LyPt6s8cmj2YeHR2PAPborfu2KKdQ1FBhjJQUrozkY=;
        b=hymN+SGItF5+W/FKPKUNzfx+sYCF7lrclzLDP+3xCJsCsA/G5hsw8ipGmbWA8qhea3
         JrueQbJRyfnCm6/NX6XY0jIcPdXB4WZrc6nwZ/3c1SkLh5n8I5TUoI/qmMvlgvH0rjak
         y5Pjah8+2NX+xNjbWchfzo7D2AAB1Ce+3qtjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LyPt6s8cmj2YeHR2PAPborfu2KKdQ1FBhjJQUrozkY=;
        b=Oh/kBFp+Q9sAtAw1c/iasnw7GW7V+I/zSVZID6+wJ93omtR5gAF7IBcXRqdJC78ECF
         t33PNGtlwHtwLsmBHuFP/MNthZlAC/Txyq9h3+c2NX0o7gT/mJTyLq048AVpQKCI0I2a
         C+hcNqGv/ZqRj0IvONR7aKqT6Bxy4yQrN425/N5HpNbiPDc4F8sQdn0HtDUmA8e8F8WW
         GdQiljSP8sV76ua0qDTQ3ZFiKA5vPzOERW0Jr83l0SpOPVXgLAqnUN7yn35klAK+ucOV
         kUW+qQfCBYoR11RlnO8adKroIzSJn8rcy3FSgn/prlG2wA/yRGn246z8nWd4rnTdhDVb
         mghA==
X-Gm-Message-State: APjAAAXJFSAnL+ehEmyZVwMvkJnRykyiStsKLt+QIh2uMfeaVLbLvuoR
        b5lEx5BXRUIPf4ORm2iUoZoPudYdyCo=
X-Google-Smtp-Source: APXvYqyfELjHp6dMKkUf8ozq70X+EX67rPJ0iuE2P/JvIWhdZ1fWqQwkGBmqzzJWZLTgHMoEuzC/Nw==
X-Received: by 2002:a02:bca:: with SMTP id 193mr29472905jad.46.1562690305253;
        Tue, 09 Jul 2019 09:38:25 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id k5sm26140137ioj.47.2019.07.09.09.38.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:38:24 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id u19so44510994ior.9
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 09:38:22 -0700 (PDT)
X-Received: by 2002:a02:5b05:: with SMTP id g5mr27979726jab.114.1562690302600;
 Tue, 09 Jul 2019 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org> <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
In-Reply-To: <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 09:38:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
Message-ID: <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
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

On Tue, Jul 9, 2019 at 2:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> > response errors.") we fixed a tuning-induced hang that I saw when
> > stress testing tuning on certain SD cards.  I won't re-hash that whole
> > commit, but the summary is that as a normal part of tuning you need to
> > deal with transfer errors and there were cases where these transfer
> > errors was putting my system into a bad state causing all future
> > transfers to fail.  That commit fixed handling of the transfer errors
> > for me.
> >
> > In downstream Chrome OS my fix landed and had the same behavior for
> > all SD/MMC commands.  However, it looks like when the commit landed
> > upstream we limited it to only SD tuning commands.  Presumably this
> > was to try to get around problems that Alim Akhtar reported on exynos
> > [1].
> >
> > Unfortunately while stress testing reboots (and suspend/resume) on
> > some rk3288-based Chromebooks I found the same problem on the eMMC on
> > some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> > tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> > vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> > same situation.
> >
> > I'm hoping that whatever problems exynos was having in the past are
> > somehow magically fixed now and we can make the behavior the same for
> > all commands.
> >
> > [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
> >
> > Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Alim Akhtar <alim.akhtar@gmail.com>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Marek (or anyone else using exynos): is it easy for you to test this
> > and check if things are still broken when we land this patch?  If so,
> > I guess we could have a quirk to have different behavior for just
> > Rockchip SoCs but I'd rather avoid that if possible.
> >
> > NOTE: I'm not hoping totally in vain here.  It is possible that some
> > of the CTO/DTO timers that landed could be the magic that would get
> > exynos unstuck.
>
> I have eMMC module attached to Odroid U3 (Exynos4412,
> samsung,exynos4412-dw-mshc). What is the testing procedure? With your
> patch it boots fine:
> [    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> req 52000000Hz, actual 50000000HZ div = 0)
> [    3.703900] mmc1: new DDR MMC card at address 0001
> [    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB

To really test it, it'd be nice to see some HS200 eMMC cards enumerate
OK.  Specifically the patch adjusts the error handling and the place
where that happens mostly is during tuning.

I'll also try to find some time today to check a peach_pit or a
peach_pi.  I think I saw one in the pile near my desk so if it isn't
in too bad of a shape I can give mainline a shot on it.

-Doug
