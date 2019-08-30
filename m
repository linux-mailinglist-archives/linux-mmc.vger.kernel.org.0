Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E575A325D
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfH3I3m (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 04:29:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33048 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3I3m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 04:29:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id m18so4281042vsr.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBe6XaZnp1DnbEiSR3tbPdbSTWUBiMGkZ5MQKY+Y/KY=;
        b=HSSx1i5MvIQIppnHZp5fqcZbrHRsEuE5YKsm/+pYHehWrBMRK+Fd6yYLM9RPceYWJd
         2KN6Ql6owRNffruGbdNcZSAqSso17tFIIcpLbRp0zC8kl60dO1JXkxCOZvRcyu1dIufG
         1hvgSKaVKD1JOa1eugdmJFPrx3JHFGraiG6Yc+aNazmxxyKhIeW0A1MPoue8sWBjkHg1
         2U/LjQQvHxtbyHKyKIvRHUSrnvL/0y4viuiAdHl86m6N5FXBwrgxRMsJfPfOTkX2P/xF
         bddVRikttGaleYOjqpQag/5g5JIML0+a/1FaVIA8U+xTCk8rUGlWv6r2EV2vQ8hSxIyC
         SbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBe6XaZnp1DnbEiSR3tbPdbSTWUBiMGkZ5MQKY+Y/KY=;
        b=k5TGWCelFuEgKUimTqFzfmL4mLZfgOoC9CMtf8j5bdzJvNsZng9gbGPGPTiz9uTl7v
         JlDAlKUAWf5SbV5LUY2yXhSxjS4nxg1eh+++STVuRk/2mT/R7KKMKAUAmuAlZhUQX1+v
         IJl2ZVyO+vrSdu57kHNU8o9/dyG8T0Vr8lSGjjcUL4+CUEDmnqB+YIP2OeTXImU1hc/u
         BkvQRGlAeXVJvUzC6w6MK055O0+cMDnFzknUV04m871T19vRyY1GwyGEcLEARgqBhjzB
         6Am1xFKlz1bj5vQ/YV472Q+6JWgT/cG22pAHyQkTsdhN9dxzTWASNCrISen/lueKYF4Z
         gsVA==
X-Gm-Message-State: APjAAAWRlyaUWLpfoWSV+LfQjjZfuKOrCyq7JNH0n98nz8mctCdrVNUd
        n9EtelqA/2VKHBYzBfdf40pXYayf+fji6acdS8pNcA==
X-Google-Smtp-Source: APXvYqwT1/od4MWptrO2+eo5tENQaNYQ7XxIzCOrNHxyh49sPnVWPm0JNv85t1DAPIYt12rpwJzChBk7AwrIozo1u18=
X-Received: by 2002:a67:e287:: with SMTP id g7mr7906924vsf.200.1567153781210;
 Fri, 30 Aug 2019 01:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074644.10936-1-andrew@aj.id.au> <20190830074644.10936-2-andrew@aj.id.au>
 <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com> <6feca359-34ce-445e-87bf-62fa063d785f@www.fastmail.com>
In-Reply-To: <6feca359-34ce-445e-87bf-62fa063d785f@www.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 10:29:04 +0200
Message-ID: <CAPDyKFpiftO194L2pf-_Yxu_BbizP6ss46YUZNO9ZxceeeWw4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition
 of set_clock()
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        openbmc@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Aug 2019 at 10:07, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 30 Aug 2019, at 17:31, Ulf Hansson wrote:
> > On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The early-exit didn't seem to matter on the AST2500, but on the AST2600
> > > the SD clock genuinely may not be running on entry to
> > > aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> > > sdhci_enable_clk().
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index d5acb5afc50f..a9175ca85696 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > >         int div;
> > >         u16 clk;
> > >
> > > -       if (clock == host->clock)
> > > -               return;
> > > -
> > >         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > >
> > >         if (clock == 0)
> > > --
> > > 2.20.1
> > >
> >
> > Further down in aspeed_sdhci_set_clock() you should probably also
> > remove the assignment of host->clock = clock, as that is already
> > managed by sdhci_set_ios().
>
> Ah, I'll fix that in a v2 once I have your thoughts on patch 2/2.

I leave this one to Adrian to comment on, as he knows this better than me.

[...]

Kind regards
Uffe
