Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4027A48CDC
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFQSrR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 14:47:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44926 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQSrR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 14:47:17 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so23489113iob.11
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N++lS1o+MDz9+i4mzKncc0qVpXXpsoR+Jo3R2g+KlCo=;
        b=SAnZ3X0db+ry3DfdGKhXmDVRB1ay1ZXQyzAHIfdFfY354qGzD+/MI11JpexYGS29uJ
         j/eWkJnZhvOuHS/+zRUH8o7WpVEbUQkgyLS8HmbtOP1YHy+H+Pbb/FMLh460HskPqysH
         pUl3dQYa5lFFHCpPM7xu1Tgu8PXg+wPzShMxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N++lS1o+MDz9+i4mzKncc0qVpXXpsoR+Jo3R2g+KlCo=;
        b=IsG8DQCrgixIdfNiPwvOXnHNwBhSrHVIhiFN5klmgsYMHH3DTXddncNEgLATUiBLvh
         MTDkbSMHNevmXzUBVLxLuTlUmV0hnTGMfCWG6MtlrCGLH9/WrZq66qWWij+cvo1O/Z7X
         3u0YbQ20/VSNEQko1Px3MdguXAYg/FFU2eZTXvDURHUXWOgT031HHjTU1oGPU3p2Zmj5
         /eu6bmu1RLtG6ACL9IVljwpNqZ/rlNE5yOpwnfXNP1T4KhQZsdgcKpN4GFGlOsMhBCjz
         ocIzzrgnohK3B1uqkLhpWbiA4q+jTKHGwmdgbFGn27xNe2+CyQLCG1m5tUOhvCwZrXIj
         UoFA==
X-Gm-Message-State: APjAAAWd+LewpA/e3Ptjfm4ej9zrH5l5Ur/8kylHz97zLc15Fi1aMXCL
        PltuBz+aDmaJBRvbfFoApbSTbY8+gYk=
X-Google-Smtp-Source: APXvYqxlXndEKeXPPDHXanoHcbTbuC0ZUXyxRYIHSrLt3gTEbKZlY4UZnue+2toBdk6NX52XyKBAAA==
X-Received: by 2002:a6b:f00c:: with SMTP id w12mr14408304ioc.280.1560797236035;
        Mon, 17 Jun 2019 11:47:16 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id v13sm13703748ioq.13.2019.06.17.11.47.13
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:47:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id w25so23501836ioc.8
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 11:47:13 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr77753iop.168.1560797232212;
 Mon, 17 Jun 2019 11:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190617175653.21756-1-dianders@chromium.org> <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw@mail.gmail.com>
In-Reply-To: <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Jun 2019 11:46:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5+j8V7qckLJf0N+xMeuaOqF+ThL3th98y63aTAVe57g@mail.gmail.com>
Message-ID: <CAD=FV=U5+j8V7qckLJf0N+xMeuaOqF+ThL3th98y63aTAVe57g@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] brcmfmac: sdio: Deal better w/ transmission errors
 related to idle
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Ondrej Jirman <megous@megous.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 17, 2019 at 11:39 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 17 Jun 2019 at 19:57, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > This series attempts to deal better with the expected transmission
> > errors related to the idle states (handled by the Always-On-Subsystem
> > or AOS) on the SDIO-based WiFi on rk3288-veyron-minnie,
> > rk3288-veyron-speedy, and rk3288-veyron-mickey.
> >
> > Some details about those errors can be found in
> > <https://crbug.com/960222>, but to summarize it here: if we try to
> > send the wakeup command to the WiFi card at the same time it has
> > decided to wake up itself then it will behave badly on the SDIO bus.
> > This can cause timeouts or CRC errors.
> >
> > When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
> > re-tuning.  Since I am currently developing on 4.19 this was the
> > original problem I attempted to solve.
> >
> > On mainline it turns out that you don't see the retuning errors but
> > you see tons of spam about timeouts trying to wakeup from sleep.  I
> > tracked down the commit that was causing that and have partially
> > reverted it here.  I have no real knowledge about Broadcom WiFi, but
> > the commit that was causing problems sounds (from the descriptioin) to
> > be a hack commit penalizing all Broadcom WiFi users because of a bug
> > in a Cypress SD controller.  I will let others comment if this is
> > truly the case and, if so, what the right solution should be.
> >
> > For v3 of this series I have added 2 patches to the end of the series
> > to address errors that would show up on systems with these same SDIO
> > WiFi cards when used on controllers that do periodic retuning.  These
> > systems need an extra fix to prevent the retuning from happening when
> > the card is asleep.
> >
> > I believe v5 of this series is all ready to go assuming Kalle Valo is
> > good with it.  I've added after-the-cut notes to patches awaiting his
> > Ack and have added other tags collected so far.
> >
> > Changes in v5:
> > - Add missing sdio_retune_crc_enable() in comments (Ulf).
> > - /s/reneable/re-enable (Ulf).
> > - Remove leftover prototypes: mmc_expect_errors_begin() / end() (Ulf).
> > - Rewording of "sleep command" in commit message (Arend).
> >
> > Changes in v4:
> > - Moved to SDIO API only (Adrian, Ulf).
> > - Renamed to make it less generic, now retune_crc_disable (Ulf).
> > - Function header makes it clear host must be claimed (Ulf).
> > - No more WARN_ON (Ulf).
> > - Adjust to API rename (Adrian, Ulf).
> > - Moved retune hold/release to SDIO API (Adrian).
> > - Adjust to API rename (Adrian).
> >
> > Changes in v3:
> > - Took out the spinlock since I believe this is all in one context.
> > - Expect errors for all of brcmf_sdio_kso_control() (Adrian).
> > - ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
> > - ("brcmfmac: sdio: Don't tune while the card is off") new for v3.
> >
> > Changes in v2:
> > - A full revert, not just a partial one (Arend).  ...with explicit Cc.
> > - Updated commit message to clarify based on discussion of v1.
> >
> > Douglas Anderson (5):
> >   Revert "brcmfmac: disable command decode in sdio_aos"
> >   mmc: core: API to temporarily disable retuning for SDIO CRC errors
> >   brcmfmac: sdio: Disable auto-tuning around commands expected to fail
> >   mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
> >   brcmfmac: sdio: Don't tune while the card is off
> >
> >  drivers/mmc/core/core.c                       |  5 +-
> >  drivers/mmc/core/sdio_io.c                    | 77 +++++++++++++++++++
> >  .../broadcom/brcm80211/brcmfmac/sdio.c        | 17 ++--
> >  include/linux/mmc/host.h                      |  1 +
> >  include/linux/mmc/sdio_func.h                 |  6 ++
> >  5 files changed, 99 insertions(+), 7 deletions(-)
> >
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
>
> Applied for fixes, thanks!
>
> Some minor changes:
> 1) Dropped the a few "commit notes", that was more related to version
> and practical information about the series.
> 2) Dropped fixes tags for patch 2->5, but instead put a stable tag
> targeted for v4.18+.

OK, sounds good.  Thanks!  :-)

I guess when I see the # v4.18+ in the commit message it makes me
believe that the problem only existed on 4.18+, but maybe that's just
me reading too much into it.  ;-)  In any case, presumably anyone who
had these problems on earlier kernels already has solved them with
local patches.


-Doug
