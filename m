Return-Path: <linux-mmc+bounces-396-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BDA80A2A5
	for <lists+linux-mmc@lfdr.de>; Fri,  8 Dec 2023 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EC5281897
	for <lists+linux-mmc@lfdr.de>; Fri,  8 Dec 2023 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962A1BDDB;
	Fri,  8 Dec 2023 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibOSUrKE"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEEC171F;
	Fri,  8 Dec 2023 03:52:24 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-425430fe8d1so12125771cf.1;
        Fri, 08 Dec 2023 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702036343; x=1702641143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWwkDICaANTCLBkKNyjRtb2b7p1OpvE2Uyw4u3EGEOc=;
        b=ibOSUrKEPX0W3RLnoVT7TR4db3EOkFiiq8lg8K+55BQXjaicPZLxoAk+m1iGNc9mfQ
         l0RN5Tl5HaJ2k7Nd5yPS/JH52zOUEe358JaaWR0HHHPBuADB0y0QWkdjOK+Y+4IsdLGg
         GR50Gp/HMxfoP07OcrZvth4BePhg/ZNqGm814k0GijkLIJhxHNsuD+kP/X2VMUFOlzt6
         oE1Omf1X5P6Y23AnX3MPzUMvo8pBRvf5sZfM40iI1Ib23H9Ixdk7cpCgVMrEo8H+js3k
         H3TXIvG5qGyGaofDPCotrz0L8aMgdXfG4HGWUDjvDkI0/mBhPIt1oRq/tinmVjsNSb3t
         17eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702036343; x=1702641143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWwkDICaANTCLBkKNyjRtb2b7p1OpvE2Uyw4u3EGEOc=;
        b=WxeTuPSg5Kf9f0IpWtG51huz0eUu9uqaMHH2ndWfFogqwbxRN3Kcmn+qKOPw9OTyEg
         ABrV3GNuHjww60+yaDDGtBG1g3fHjUxf+GS18sWtbDhXf936nDdbwRx8SAxJkq/avy51
         ZGK822PIRt/y6Axmd9eH7+T1HWaroZeCnUP1DMTQa8AB0ZS8TiwUaNCf+V1SHbFxmfAr
         mUhc2KDGBaBhIa6Q0Rety0zTCv5M4So0cHQ5+w46HScG5KDqo4PhhaaVSh6f8S8M6Duc
         bIQbcO/6dUki6qSI4n1G/jgxe0WnbZRhTltlqheO/rwpKGrLiRXlF/TJfx5ilQnO/0ij
         XoDw==
X-Gm-Message-State: AOJu0YwQE7rTJwU8OZxO87YKhbENE8CE3ooiQwUAUJxO1TpNHARN/vLp
	A6I3nt9whA0oOScXwJqzKaFaq0czPnnQNS4SHV4=
X-Google-Smtp-Source: AGHT+IFvzSllLQfPV5Ta3QUEkfcC0/yZFxXlw1MHSdHhbpAAcNaDB42ZLxb2BVvXPfNRTGMyUQE4P95id9DbuiAG13U=
X-Received: by 2002:a05:6214:92:b0:67a:a721:782f with SMTP id
 n18-20020a056214009200b0067aa721782fmr3493346qvr.84.1702036343619; Fri, 08
 Dec 2023 03:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204064934.21236-1-wenchao.chen@unisoc.com> <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
In-Reply-To: <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
From: Wenchao Chen <wenchao.chen666@gmail.com>
Date: Fri, 8 Dec 2023 19:52:12 +0800
Message-ID: <CA+Da2qyB2tQjq5wxoqNwjb5HXhdPHMsWN08Ot7nMEkZzOgQ9LA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sprd: Fix eMMC init failure after hw reset
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wenchao Chen <wenchao.chen@unisoc.com>, zhang.lyra@gmail.com, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com, 
	yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Dec 2023 at 21:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 4 Dec 2023 at 07:50, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> >
> > Some eMMC devices that do not close the auto clk gate
> > after hw reset will cause eMMC initialization to fail.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>
> I assume we want this tagged for stable kernels too, but do we have a
> corresponding fixes commit that we can point out?
>
> Kind regards
> Uffe
>

Hi Uffe
Sorry, I forgot to add fixes commit.

Fixes: ff874dbc4f86 ("mmc: sdhci-sprd: Disable CLK_AUTO when the clock
is less than 400K")

Thanks

> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 6b8a57e2d20f..bed57a1c64b5 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
> >         div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
> >         sdhci_enable_clk(host, div);
> >
> > +       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> > +       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> >         /* Enable CLK_AUTO when the clock is greater than 400K. */
> >         if (clk > 400000) {
> > -               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> > -               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> > -                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> >                 if (mask != (val & mask)) {
> >                         val |= mask;
> >                         sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> >                 }
> > +       } else {
> > +               if (val & mask) {
> > +                       val &= ~mask;
> > +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> > +               }
> >         }
> >  }
> >
> > --
> > 2.17.1
> >

