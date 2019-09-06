Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC508AB512
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392958AbfIFJnD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 05:43:03 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37487 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392945AbfIFJnC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 05:43:02 -0400
Received: by mail-ua1-f68.google.com with SMTP id f9so1849599uaj.4
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R38QwJRDDtxieDfNJJcxGNZ/wA4BpQhs/ThTqx6ON3E=;
        b=wGB/lSQRuv+WEWnp8pInqrefO3rA6K08hHFuIa7+RI3L1SbahglRzPRYKBHgn3v8We
         t16jocpe1ui7QDUF7Fv5y1uryLnDi0dV5jPkL3fUiqcchi+jHsEiZHVz6Due2t+HtZC7
         AJhvD3Q/G17X67OlvpAsE0baTIBWYL7QazmiTeYvzvD0GkTgxpOw3GJMGTWlXz2UApY7
         H5Vid+JsPwKM/uwvjtvlj34qBTZAbXmEnHvEr4TtsJnpwgB+vSlSfrYMtZ6gmSMSXrJb
         L6wSCkU8Kfmdyxlvt6v6CzEd+ctJA6igA/VMhsABL5vcbBNpZb9P6vTYBWRcDsAfLFuq
         jHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R38QwJRDDtxieDfNJJcxGNZ/wA4BpQhs/ThTqx6ON3E=;
        b=VV/rG75lEIp81J7ZSPNsdi3og4WkOmDd60ca/JmC2Mp2h46g4jx5gLkuZV8tluoMxw
         kZcsXi1q31TIhTaEOdN5LQlY0DefQLfwIazdudix6N/YTUTNuQqdNoWuG/RS1V56KGyy
         LLXXvJ2bdcGT6Ubd2afwfq/mJAwexGefdZQYsiz2s/7FCKdH4SK9lmkJY++DhiCTwwex
         tuL/cNDnpfyA9RSpgNgjfsnFa69Ydbsg7Ul5a7b7gbdXLreBoRMsjCwCVhua1OXICoA7
         upxP73gRj3zV2bjrgTmrAwCTItovHsXHPY1o1qv+mMZp9OmCCyQJicj33IcH93DOY2sl
         0McA==
X-Gm-Message-State: APjAAAU6Zihi5m6hyPnJD9P0pEMVhdGGc5YPri8ohCdFeFxycPhXbh7h
        1WAad8qZG64mvY+Uq1ptMzIJ89qlPBNCT89nxE9sow==
X-Google-Smtp-Source: APXvYqyGI6SsPqpEbbDCT8Ryeuwx2k9MJlewX3O+7qe6csw2dm/4l3P/AFie5Gl8NoFZfDeO42q3zsCkto5+vzm2ok4=
X-Received: by 2002:ab0:15e9:: with SMTP id j38mr3943851uae.19.1567762981472;
 Fri, 06 Sep 2019 02:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-9-ulf.hansson@linaro.org>
 <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
In-Reply-To: <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 11:42:25 +0200
Message-ID: <CAPDyKFrTUgkxdwuFHy=2zDyrNnoi6UVnXEUL-cfrtUigvBunNQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 01:48, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> > MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> > behaviour. Some problems have been taken care of so far, but more issues
> > remains.
> >
> > For example, calling the ->ack_sdio_irq() callback to let host drivers
> > re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> > which may not be the case during system suspend/resume. This may lead to
> > that a host driver re-signals the same SDIO IRQ over and over again,
> > causing a storm of IRQs and gives a ping-pong effect towards the
> > sdio_irq_work().
> >
> > Moreover, calling the ->enable_sdio_irq() callback at system resume to
> > re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> > count for some host drivers to become in-balanced. This then leads to the
> > host to remain runtime resumed, no matter if it's needed or not.
> >
> > To fix these problems, let's check if process_sdio_pending_irqs() actually
> > consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> > ->ack_sdio_irq() callback.
> >
> > Additionally, there should be no need to re-enable SDIO IRQs as the host
> > driver already knows if they were enabled at system suspend, thus also
> > whether it needs to re-enable them at system resume. For this reason, drop
> > the call to ->enable_sdio_irq() during system resume.
> >
> > In regards to these changes there is yet another issue, which is when there
> > is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> > has been system suspended. Currently these IRQs are just thrown away, while
> > we should at least make sure to try to consume them when the SDIO card has
> > been system resumed. Fix this by calling sdio_signal_irq() after system
> > resumed the SDIO card.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sdio.c     | 2 +-
> >  drivers/mmc/core/sdio_irq.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index c557f1519b77..3114d496495a 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
> >                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
> >                         wake_up_process(host->sdio_irq_thread);
> >                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> > -                       host->ops->enable_sdio_irq(host, 1);
> > +                       sdio_signal_irq(host);
>
> Is this always safe?  On 1-function cards you won't poll CCCR_INTx so
> you'll always signal an interrupt at resume time, won't you?

Good point!

What we really want to do is to just schedule the work and not include
to set the sdio_irq_pending flag. Actually, the flag may have been
set, in case a host driver have called sdio_signal_irq() when the SDIO
card was suspended - but that is the intention.

Thanks for pointing out the issue, I will re-spin and fix it!

Kind regards
Uffe
