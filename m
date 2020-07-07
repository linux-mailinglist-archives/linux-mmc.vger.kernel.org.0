Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA37E216E75
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Jul 2020 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGOP3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Jul 2020 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGOP2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2020 10:15:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D66C08C5E2
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2020 07:15:28 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e15so22601450vsc.7
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2020 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY085zBtw2pHr+bAZzUJfI7AThS/xpJ8o4s75hDOq4A=;
        b=dDzphevn2nyzKAWSoITp9wWqB3YF15C5q5ScDmerS0imJ1WiOBqRFUeNmotMLd9jzo
         Lrh7jtzDVG3TZmzcgvJ+rNk4aK3eSE85dwpr4QRsgKy6kaLPAUz9+Zu9jQXXuEgw1KvI
         qWjNtv/pmpkUoOz0WB5U+F+73rrE9gAAt4/vZ37cPWwrEWL/OlwtnsxFNLxXXIQ9z3/R
         spjh2qrmoS0/1mKgGwdLgbetzmMxGkknrCjQQe9EbC5ii/8WOO1ZPUZ/JuL5ZG59ukc6
         sP3aOSZ49TgNWaPwnXSALKvCdMCkjd8Qr3ftiE8TUMD9pqLMy7FJ/LdycduvdHnJ2KWy
         xbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY085zBtw2pHr+bAZzUJfI7AThS/xpJ8o4s75hDOq4A=;
        b=Duq94GopbaatTN7kEuE9D52F3TVlJi8gPtgZ53KADZWvlAsD3cM1qGSjYjEos/SUF9
         QGptueODbXCCAhToxB5GIJlPUB/r7BukkCwMiQweHRF28ZPGceCjPm53/K8c6OqW/DTK
         f+82DfCaEwRqvQ+XNTDIz+NjfbYJr44EA8wak8MX4ytjgZxdd6YptzP0QZfKtMwTjkS5
         eyovTR0RrsdqN4O63xtuW+eumwmUaK39X75wwepMkjTOqRcWTZuQECpXT2kykw7pyGhF
         TnWg2om9+g58jWj4HdIGbmoddNSKxOtAOL4t4HNm9mzt4Jpyt48a9t44aM6WrIDEnLHW
         QXlg==
X-Gm-Message-State: AOAM533tBgZeqF3H9x3OAYnlIK3uWca/chTUFyMoC11rTcNSEuqnq2KZ
        aq8YdrmLP8X9k4LnEjNHrUaLUw06FWZLZhk+V9gJnoHLXDA=
X-Google-Smtp-Source: ABdhPJxJdmPt/k+0X7cBgq2UD0h5HLptPNTtXBc6HARpzt6VPRKcR2Eo7FUJytJ0fWCWHoRjEC4+9XkoBr5brpazGkI=
X-Received: by 2002:a67:ca03:: with SMTP id z3mr32799304vsk.34.1594131327772;
 Tue, 07 Jul 2020 07:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
 <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com> <cfcec3df57e6dd5ef353ef3a5b4b9793c28eb401.camel@ew.tq-group.com>
In-Reply-To: <cfcec3df57e6dd5ef353ef3a5b4b9793c28eb401.camel@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 16:14:51 +0200
Message-ID: <CAPDyKFptySRTbWto9QYWZ-feL51JvPkZDGsETJ4svz0VbV31Bw@mail.gmail.com>
Subject: Re: (EXT) Re: Consistent block device references for root= cmdline
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Jun 2020 at 13:20, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> On Wed, 2020-06-10 at 16:52 +0200, Ulf Hansson wrote:
> > On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > >
> > > Hello all,
> > >
> > > there have been numerous attempts to make the numbering of mmcblk
> > > devices consistent, mostly by using aliases from the DTS ([1], [2],
> > > [3]), but all have been (rightfully) rejected. Unless I have
> > > overlooked
> > > a more recent development, no attempts for a different solution
> > > were
> > > made.
> >
> > According to aliases attempts, I think those have failed, mainly
> > because of two reasons.
> >
> > 1. Arguments stating that LABELs/UUIDs are variable alternatives.
> > This
> > isn't the case, which I think was also concluded from the several
> > earlier discussions.
> > 2. Patches that tried adding support for mmc aliases, were not
> > correctly coded. More precisely, what needs to be addressed is that
> > the mmc core also preserves the same ids to be set for the host class
> > as the block device, mmc[n] must correspond to mmcblk[n].
> >
> > >
> > > As far as I can tell, the core of the issue seems to be the
> > > following:
> > >
> > > The existing solutions like LABELs and UUIDs are viable
> > > alternatives in
> > > many cases, but in particular on embedded systems, this is not
> > > quite
> > > sufficient: In addition to the problem that more knowledge about
> > > the
> > > system to boot is required in the bootloader, this approach fails
> > > completely when the same firmware image exists on multiple devices,
> > > for
> > > example on an eMMC and an SD card - not an entirely uncommon
> > > situation
> > > during the development of embedded systems.
> > >
> > > With udev, I can refer to a specific partition using a path like
> > > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was
> > > proposed
> > > to add a way to refer to a device path/phandle from the kernel
> > > command
> > > line. Has there been any progress on this proposal?
> >
> > Lots of time during the years I have been approached, both publicly
> > and offlist, about whether it would be possible to add support for
> > "consistent" mmcblk devices. To me, I am fine with the aliases
> > approach, as long as it gets implemented correctly.
>
>
> It seems the principal technical problem is the one described here:
>
> https://www.spinics.net/lists/linux-mmc/msg26602.html
>
> I don't see any way to solve this completely, as there seem to be two
> fundamentally conflicting requirements:
>
> 1) If a mounted SD card is replaced, it must be assigned a new
> /dev/mmcblkN
> 2) /dev/mmcblkN should always match the configured alias IDs
>
> What is the reason we need 1) - is it possible to have multiple eMMCs
> or SD cards on a single bus, with detection at runtime?

Yes. The mmc_bus_type holds all cards - all discovered at runtime.

> Otherwise I'd
> expect this to be handled like other drives with removable media (CD,
> floppy), with static device assignment.
>
> If we can't give up on 1) for some reason, we'll have to accept that we
> can't guarantee 2) unconditionally. As far as I can tell, the patches
> provided by Sascha and others did that in a reasonable way: The aliases
> would work in most cases - in particular for the first assignment on
> boot, which is required to find the correct rootfs.

Well, if we would pre-parse the DTB to look for all "mmc block
aliases" and keep a mark of those ids as being reserved, then we
should be able to cope with both 1) and 2).

>
> >
> > >
> > > Kind regards,
> > > Matthias
> > >
> > >
> > > [1] https://patchwork.kernel.org/patch/8685711/
> > > [2] https://lore.kernel.org/patchwork/cover/674381/
> > > [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> > > [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
> > >
> >

Kind regards
Uffe
