Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416B34CF96
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfFTNvE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Jun 2019 09:51:04 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42846 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTNvE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2019 09:51:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id a97so1639865uaa.9
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IFwlqbKib7dWbeVbv8X2YweFdeF4XDbaSTOpsTFt9E=;
        b=cnBfFGGl3pJdpKp1MmBsF47mWvkNWCygNpH36R5cENrnDyoojF55rqerYfDLfwbbTj
         RFNj58C5CUCULzDhnJhuuGUawX8GzXHIVIZhOz7jX/xVeIdC14e76z4ee9EhQzScRn3r
         yZyPrtDQwDjqyu6vqRuq4CLTKqp19vhLDP1kzyZlJral0qqZUmCvS5srHMy+sgfXo7OX
         8J3/HDJJtVqUJPoO9R3c2uQaBqDPo5Hb8yFlY4a3lZNrdJXrZ2uvs7wDiEP1uZSr6Jfu
         RATefM9/IOvINHrRt3pDF9AMIZimpQikwZUjdX3vOvvUC0JBvtUIxqFbJK3SbyUB77sX
         swNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IFwlqbKib7dWbeVbv8X2YweFdeF4XDbaSTOpsTFt9E=;
        b=j3dXFjuZ1t6fFzxUijFISLWYV1gOhZMK1qsgHU/N9B/6LNwjiS0O1A3Uwp+BlxBCfP
         KJZJsAKXw8NBNx+xIDj4g/fPTkyFH4+oq9U1rKSSb+YWmbJesjG4V7D/gooo92BbC6dd
         Hbt/LzatgP38JFG8CHvBmZN+szyfoGLDpsnn24JU6YAehk8tf3tordr4wwBqqOz3QpkU
         n0LxIQ16Hv0iHJcdyzA4C81cFaJ75vWqrM1k/Cm1X/8qmbnK59PV8q44PxPDns+bdyU4
         qs9k/67duzE3CgdYXFP6tbihtGX943dWNrtXH50Ofk6F6Q9OTHydjZzDXKNy+z8uH1Ut
         Ml0Q==
X-Gm-Message-State: APjAAAUUFR3rq9ycvjkrhSD6fPqv3Tc4xkkPWMpubFe8ZkqqXhTsU276
        eKYux4dI5mQoJg/ufuYPhvEptRewCLRU7Y5igs28lfSx
X-Google-Smtp-Source: APXvYqyZXCFrwLLbuKH87ntBoB1uPTcKE017Mrw8Z9+j3VOUxMLwq/g1pwfocngRvtK/nHu4TYQODtwzbAxVOv/4r8s=
X-Received: by 2002:a9f:242e:: with SMTP id 43mr8151929uaq.100.1561038663128;
 Thu, 20 Jun 2019 06:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com> <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
In-Reply-To: <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 15:50:26 +0200
Message-ID: <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ludovic,

On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:
> >
> > hi Ulf
> >
> > Just a "gentleman ping" about this series.
> > I know you are busy, it's just to be sure you do not forget me :-)
>
> Thanks! I started briefly to review, but got distracted again. I will
> come to it, but it just seems to take more time than it should, my
> apologies.

Alright, so I planned to review this this week - but failed. I have
been overwhelmed with work lately (as usual when vacation is getting
closer).

I need to gently request to come back to this as of week 28, when I
will give this the highest prio. Again apologize for the delays!

Kind regards
Uffe

>
> Br
> Uffe
>
> >
> > Regards
> > Ludo
> >
> > On 6/3/19 5:55 PM, Ludovic Barre wrote:
> > > From: Ludovic Barre <ludovic.barre@st.com>
> > >
> > > This patch series adds busy detect for stm32 sdmmc variant.
> > > Some adaptations are required:
> > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> > >   different.
> > > -Add hardware busy timeout with MMCIDATATIMER register.
> > >
> > > V3:
> > > -rebase on latest mmc next
> > > -replace re-read by status parameter.
> > >
> > > V2:
> > > -mmci_cmd_irq cleanup in separate patch.
> > > -simplify the busy_detect_flag exclude
> > > -replace sdmmc specific comment in
> > > "mmc: mmci: avoid fake busy polling in mmci_irq"
> > > to focus on common behavior
> > >
> > > Ludovic Barre (3):
> > >    mmc: mmci: fix read status for busy detect
> > >    mmc: mmci: add hardware busy timeout feature
> > >    mmc: mmci: add busy detect for stm32 sdmmc variant
> > >
> > >   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
> > >   drivers/mmc/host/mmci.h |  3 +++
> > >   2 files changed, 44 insertions(+), 8 deletions(-)
> > >
