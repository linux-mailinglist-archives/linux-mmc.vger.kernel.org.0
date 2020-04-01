Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4119A6F8
	for <lists+linux-mmc@lfdr.de>; Wed,  1 Apr 2020 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDAIRH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 Apr 2020 04:17:07 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45286 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAIRG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 04:17:06 -0400
Received: by mail-ua1-f67.google.com with SMTP id 9so8717147uav.12
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2020 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ensGezno4nmhj/DQXTgSjB6W9s0hooLswX7hmYrhsYs=;
        b=TFRE9IalabaS54Co9qCRHXDAKQZ8dqfLecwCXI0i4qEvEy2pykDB6zTBWsk6Y3YSUT
         6HN2RX1XTv4HHTt/9kJdLsz6wV9ajV1ybvfw1QEKHVLpsKWfJ2+U0ZXsxwybV+3oaqTb
         Odq+0k1ojeQnFLJsBCyKj20zYQmmcXmK+e52TDBWXDftfip2IxyIxUg4r98xe/H/57Bk
         K5XYc3YJQIxgZNiqmsXgC5SOyLNsbV67NyF9CWYCvfXdVYaqkhf7OOd+edYTaKvMLXCZ
         /itut1tKZbfF8o+8jX9hnrws6V6ZK/nHF8ugr/knbrem2hfAdRS3IMyBFgxRwBgWvMvS
         2ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ensGezno4nmhj/DQXTgSjB6W9s0hooLswX7hmYrhsYs=;
        b=iU3tpC3URlVS/BKp+/sUz0ccG/PKNAIUfZ8HHrmdAXomybCYGwDTkTs+Tyq0r1DIO3
         H3VbQhRkIrIAjUElNXLLTC+3G+8sAb8sNuq1IucWxVFk+OMOuJWbOzKEH1EaUdOGLttw
         kbxY4WtZBem7Ew7t/YL2ZfOTphT1EiwK0FdorrGSWVycM581RsN2cjW5lFpSi/60B7SV
         hmmv2KB2EyEFhAlf5uWGmnkFshKCv39QKPGJh/CS9LpDU31kQy4qCY3zzmzsbQ42ZLcf
         EBjkB25o2z8hxNOBIP5ac+rVFkeee/B5fsBMmMM1g+uxAJxk1qWO5A27Xh/23zx0d3uH
         WWNQ==
X-Gm-Message-State: AGi0PubM1QohfjpM9L7p3CJuZQ4f8gzSaOuaCuRcBrKfBTes2nNAYH4h
        VaU0X2sXebgfZBn3gcDbjB1mepQOxIuFgidDni3hTQ==
X-Google-Smtp-Source: APiQypJE/rOrtpVM/N8R34J7/BlgBaqpmAWpSVysnxQZrIHkKr0+mYCUesLSD5y0GEwVgkHo/cfrF633iR9GGKoYL7Y=
X-Received: by 2002:ab0:6204:: with SMTP id m4mr15304673uao.15.1585729025357;
 Wed, 01 Apr 2020 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200331155254.100952-1-marex@denx.de> <CAPDyKFrypbDEuDaGWySjC6j_qKbXpVHoubhh8e9jS24JSzBg3Q@mail.gmail.com>
 <7a7c0180-0a11-17b2-7815-b18b1ca11120@denx.de>
In-Reply-To: <7a7c0180-0a11-17b2-7815-b18b1ca11120@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Apr 2020 10:16:29 +0200
Message-ID: <CAPDyKFoEFe=fru0=HCTzG2CikGA72hFWK0y6iL_EN6BDK3Vtkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Only call .post_sig_volt_switch if voltage
 switch happened
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Mar 2020 at 23:01, Marek Vasut <marex@denx.de> wrote:
>
> On 3/31/20 8:53 PM, Ulf Hansson wrote:
> > On Tue, 31 Mar 2020 at 17:53, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Call the post voltage switch handler only if the voltage switch actually
> >> happened. It is well possible that the regulator is already set correctly
> >> and no voltage switch happened, so there is no need to take any further
> >> action.
> >>
> >> This fixes a real issue on STM32MP1 where, if the eMMC is supplied with
> >> VccQ=1.8 V, the post voltage switch code will spin indefinitelly waiting
> >> for the voltage switch to complete, even though no voltage switch really
> >> happened.
> >
> > Whether this is a common problem or not, I think in a first step we
> > should manage this in the common mmc_regulator_set_vqmmc().
>
> I can pass in a variable which would be set if a voltage switch actually
> happened in mmc_regulator_set_vqmmc() OR I can return a code > 0 from
> there. Which one do you prefer?

Return a code > 0.

>
> Then I guess we can add something like
>
> if (regulator_get_voltage(...vqmmc) is already in voltage range)
>  return 1;
>
> ...
>
> and the MMCI driver would do something like
>
> if (mmc_regulator_set_vqmmc(...) > 0)
>  host->ops->post_sig_volt_switch(...);
>
> That looks OK I guess ?
>
> > Then on top of that, convert mmci into using the mmc_regulator_set_vqmmc() API.
> >
> > Can please try this approach instead?
> Sure. Does the above look sane ?

Yes, great!

Kind regards
Uffe
