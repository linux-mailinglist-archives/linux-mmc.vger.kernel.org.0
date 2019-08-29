Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0981A1CDF
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2Od4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 10:33:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33228 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2Odz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 10:33:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id m18so2576105vsr.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A23fasXWLwWGtZNLkF/Qw7NJX9iqROeXxg3LfRD4LSg=;
        b=MZt5LlcEm6Zd10jeevZWquQxYFwJvGI38ZVc8eGhT4fqHfTBj+XaDOZlgUeGsfjUHQ
         K8BcH2/JxwZ6FUBgnPBZjEStDRS1yUjM203s68nJZBGVeKYwfuVXFsp6N9n5R5lvZGC6
         9nRcYk//uyxLMr/b3o46ntLK9G95Pab9oJ3fqav8+KkMx1I0lkBT/E09kaoe6LEQKelv
         GkPKm0DIhdASuc2T/jQsvI/4C1V/cifIJ9/2OXKPDl3NUypwyVhqD1IBIiIN47cwLz88
         UMbglNdLkghsUG4L/aercFBhBmCLtTrFzZRhCIKPBUODbp/q8N8uUBA/17dPev29vyGG
         jlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A23fasXWLwWGtZNLkF/Qw7NJX9iqROeXxg3LfRD4LSg=;
        b=D7Nc9TW+Sm3vGkHAWflbkN1LiVTsmHlJt7T3rFZ904tzv66cDX597PkuUbZm2KjwfP
         sXaN3vpHtX0cI72Nv8eDcqXCDd2Aq3YbbuS4FlB9i7S1Btl83dlU6s2eww8wMUuajfx9
         V8ehyIWLdxCMYRPVUsODwiu/B0T884+9/yMfUKfdWxQMXLQDfQbjlfGK/e4SMnIn/k0P
         DsVs1e1sce4OTsjkBU8L3EV2s6RMvQPx2K7CRSxQeXJvpdJxJRRMYPGaNPiPcAlTQ5WX
         5NwTSBvys/VrpVWxSJN4Vl34Ym0qJr12SmY/Qh1eQmbuLRKPTQzX8NeVVqdQcDnTpu/f
         fI7g==
X-Gm-Message-State: APjAAAVtXAL5OTb7KvtY9rK/4+O6NgBK4WxIJt/gbpz/1Zk+JxY6O6AQ
        bIF8oBv5FnU281FNor7IjFsdV+i50d0fz1eeqJuXHg==
X-Google-Smtp-Source: APXvYqwU9et/rbZ6xY4KY5TtTISDcgN4NTBNVIO6lJCVOZgyN2/OqLGA92P8MocRADkWd5cyKzOd/qfIIYm8vVW1nV0=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr5663825vsb.165.1567089234815;
 Thu, 29 Aug 2019 07:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
 <CAPDyKFooFQgBgK3N1Ob9rsT_7-5kqC9i7PeMxkkeAbnDP+Fwnw@mail.gmail.com>
 <CAK7LNASDfJQrMq4jjwDjrQF-4E9A_BZtgh+K-duTAo8zRVZA0g@mail.gmail.com>
 <CAPDyKFpnRbtVpYkpM7CDYfxvdBjqybB4SVWyuSrS1jpYduTbCw@mail.gmail.com> <CAK7LNARC_Y968UtXE3v72Dw=69-6jutFTVy54K=iT5o52udXSg@mail.gmail.com>
In-Reply-To: <CAK7LNARC_Y968UtXE3v72Dw=69-6jutFTVy54K=iT5o52udXSg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 16:33:18 +0200
Message-ID: <CAPDyKFr2+eJKYcxeavLFtkCBOcGQzTgC9WN9nVJWxKKp8BaRAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "# 4.0+" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 16:04, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Ulf,
>
> On Thu, Aug 29, 2019 at 10:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 29 Aug 2019 at 14:05, Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Thu, Aug 29, 2019 at 8:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > The IP datasheet says this controller is compatible with SD Host
> > > > > Specification Version v4.00.
> > > > >
> > > > > As it turned out, the ADMA of this IP does not work with 64-bit mode
> > > > > when it is in the Version 3.00 compatible mode; it understands the
> > > > > old 64-bit descriptor table (as defined in SDHCI v2), but the ADMA
> > > > > System Address Register (SDHCI_ADMA_ADDRESS) cannot point to the
> > > > > 64-bit address.
> > > > >
> > > > > I noticed this issue only after commit bd2e75633c80 ("dma-contiguous:
> > > > > use fallback alloc_pages for single pages"). Prior to that commit,
> > > > > dma_set_mask_and_coherent() returned the dma address that fits in
> > > > > 32-bit range, at least for the default arm64 configuration
> > > > > (arch/arm64/configs/defconfig). Now the host->adma_addr exceeds the
> > > > > 32-bit limit, causing the real problem for the Socionext SoCs.
> > > > > (As a side-note, I was also able to reproduce the issue for older
> > > > > kernels by turning off CONFIG_DMA_CMA.)
> > > > >
> > > > > Call sdhci_enable_v4_mode() to fix this.
> > > > >
> > > > > I think it is better to back-port this, but only possible for v4.20+.
> > > > >
> > > > > When this driver was merged (v4.10), the v4 mode support did not exist.
> > > > > It was added by commit b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")
> > > > > i.e. v4.20.
> > > > >
> > > > > Cc: <stable@vger.kernel.org> # v4.20+
> > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >
> > > > Applied for fixes, by adding below tag, thanks!
> > > >
> > > > Fixes: b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")
> > >
> > > This is not a bug commit.
> >
> > Right, but it can't be applied before this commit, hence why I added
> > it. Not sure that it matters, but I can remove the tag if you
> > insists!?
>
> I hesitate to add Fixes to the commit that
> did nothing wrong.
>
>
> I added "Cc: <stable@vger.kernel.org> # v4.20+"
> so this is enough for the stable kernel maintainers.

Yes, I drop the fixes tag. But as I said, I don't think it's a big deal.

Kind regards
Uffe
