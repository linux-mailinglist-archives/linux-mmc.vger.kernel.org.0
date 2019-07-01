Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2143A01
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Jun 2019 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbfFMPSA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 13 Jun 2019 11:18:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43010 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbfFMNOX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2019 09:14:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so667648vsn.10
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2019 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR4I31iRpJNzMeDmL877t0ARvDi8UmH6xTDgLBUKOEU=;
        b=ELoOMPni1y0S2Eeu4CKg+k17whALIizetT7cvmiVzng2ASoWY/zEf4QCF5Q4OCkG4r
         lLSK1k41lMROJ+CxzlSyxs4V908CnVex3CA8jzK+NeJYcm9x2tEsn3yAQP+XWphKFejP
         JnPcJGVuzsD2hPED5Rx4zSlBDEMa4cgvvknreVnW5pBkqU20fs0btRzAemvxo5UuMhXw
         g5QinFv6WnqFTkUUnCvRl6n9kN9cK8l6xbWlCP4F+wdmQWWeftsL/0JGcradgEWeJSzp
         QWxvGdPrSOdP1tTXeg1zxynQFa/LfRm4TmZHofWD2iwya+qc8IzJc2B3hZq6Tq0/OBz1
         lEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR4I31iRpJNzMeDmL877t0ARvDi8UmH6xTDgLBUKOEU=;
        b=QQXBp6DGs0s9LhfSizNgsR2FvPxvUW+tFwxHNJA4AnbV8K3WXo6Q0hVoLFPcUtA5dP
         eBSPQ+UKEDSbue2UolSlWd/uFwehX1U2CreB2+K469TabMqbkf33QLo9BH4BpbEDUfAF
         diwRZMPVAfI1pTFy4nUS4oLsHe9dVeS+tTpjj1jdySxMHJlufkkVotHr+xmM+HZOlggv
         aS1/umnJ9RIsyk1WinNIMjuGGZ5YcrEDMhteJFhWh3O6pzMgE9WPnGa0BCrJL/fAs37A
         Yr/laewgseTtOYCkiJXd18oR+OXHUe/l5CsoQL66n9RKS+j65TlAvnl/pD3HFbJaW+b0
         VvEg==
X-Gm-Message-State: APjAAAUWk4C6Uaq+t7IuDuwUrzyJEiaySRZrKWwneNJtdH+ImOE6Y579
        y6roaxe7PXYaIhcXVMeXv1LpozGEHg4RiZomeMSd4g==
X-Google-Smtp-Source: APXvYqwbXxtKhJhPoMfm6hW9bmujkyqa7UqRJRkTixkWhWXjnp1ugr9ACSLRfaX8ICyv+pkIWZG5c6+bqjRTtP+mu6A=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr15041407vsp.165.1560431662796;
 Thu, 13 Jun 2019 06:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com> <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
In-Reply-To: <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jun 2019 15:13:46 +0200
Message-ID: <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
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

On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" about this series.
> I know you are busy, it's just to be sure you do not forget me :-)

Thanks! I started briefly to review, but got distracted again. I will
come to it, but it just seems to take more time than it should, my
apologies.

Br
Uffe

>
> Regards
> Ludo
>
> On 6/3/19 5:55 PM, Ludovic Barre wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > This patch series adds busy detect for stm32 sdmmc variant.
> > Some adaptations are required:
> > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> >   different.
> > -Add hardware busy timeout with MMCIDATATIMER register.
> >
> > V3:
> > -rebase on latest mmc next
> > -replace re-read by status parameter.
> >
> > V2:
> > -mmci_cmd_irq cleanup in separate patch.
> > -simplify the busy_detect_flag exclude
> > -replace sdmmc specific comment in
> > "mmc: mmci: avoid fake busy polling in mmci_irq"
> > to focus on common behavior
> >
> > Ludovic Barre (3):
> >    mmc: mmci: fix read status for busy detect
> >    mmc: mmci: add hardware busy timeout feature
> >    mmc: mmci: add busy detect for stm32 sdmmc variant
> >
> >   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
> >   drivers/mmc/host/mmci.h |  3 +++
> >   2 files changed, 44 insertions(+), 8 deletions(-)
> >
