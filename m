Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB651FC939
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKNOuA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 09:50:00 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34435 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfKNOt7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 09:49:59 -0500
Received: by mail-vs1-f66.google.com with SMTP id y23so4048025vso.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7wapv4EE4G+0Gc1i2jjis8KTbTPULbvSuyjxNMdOtM=;
        b=AVxDQJqsoylkSQmx08lzQrUBZCxelJXskce1tNwhtJqrv1m/adiDXhfzeb/LLtfBmP
         9J1MdAGXQYOU9lve3TdlhlSPCWYIik4z3gbcbniH/2ZP/ZXc2kJetKj4I6hyBbDXALnt
         iKgDNTMw7gO1UcDjUwYeFQTYgymS3hwkbr6BYeprE9le1g2rtD7363gMpJaobyJD2GCh
         gPfFepXZyZOTSZe8PbbwFXolc3mrqQPUCjmh109X07tuR9ew5b1b8Jf0XUoKppFBALdL
         lykqOOtEIukCrxxKeAwPCpErBEAHgDQIf7n8jAKX4QF8oNgh1YmEKac+5Hot/3WZQEHA
         V5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7wapv4EE4G+0Gc1i2jjis8KTbTPULbvSuyjxNMdOtM=;
        b=L9VWYWh0HONkiNdeNxWk8E1oujXoG1fIf9NHnVSuqqv+fnh0608HNy9sTHv+1S9ZxZ
         fjy/YftUSQUFqUwTbkD/yDebzJIKvJ6hCNivTMV+bVo8QOm1m07O36eGeNA1pyty/mqi
         wfpDHN2CdxhLFQfuNHgN7gSBsqW/ozhA5t2sz5MnDG9d5CvCU37DNMALH7W46gUaN2l7
         Hco3iLzeF4llQwSh7+R+D/27YAn6j6rwOtiv4jig54BhiAAVESdhQr4IG1MKHzVV2pO4
         vpSkWQvsOp96CbeAzvUMelRRVslSeDHSs+3e/kTb9D7Pl46c+2GWIinaRm4vsDLpRsNC
         Xi3g==
X-Gm-Message-State: APjAAAWXttSyjfpgtiIqaYOzMplrBT5zw62D+MkPTc7vSdt5i+JSugSX
        5ilNhwhsMgkHzO+h3df5Qi/M0RDKoZYbfj89a5Pvog==
X-Google-Smtp-Source: APXvYqzcyR0y7F+ha4XEbI+5EzDrdrJyK1AZpIJppA2pHa1tvpOnu8Gvhe0K17/wE+Byt8XJXfmdlVGMNecJ5wVu/x0=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr6134394vsa.34.1573742998082;
 Thu, 14 Nov 2019 06:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20191011131502.29579-1-ludovic.Barre@st.com> <20191011131502.29579-2-ludovic.Barre@st.com>
 <CAPDyKFqE09nqdev_qewwNzjjUuhm0UUC03tgvY=ZukYY4az7wg@mail.gmail.com> <d8d82f39-319b-c8f8-255a-a02a81980671@st.com>
In-Reply-To: <d8d82f39-319b-c8f8-255a-a02a81980671@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 15:49:21 +0100
Message-ID: <CAPDyKFpvOdwnwNa94ppF_Gum26ML52oeXDSeR1qKtSaH_wQU+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: add unstuck function if host is in deadlock state
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 17:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
>
> Le 10/21/19 =C3=A0 3:35 PM, Ulf Hansson a =C3=A9crit :
> > On Fri, 11 Oct 2019 at 15:15, Ludovic Barre <ludovic.Barre@st.com> wrot=
e:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> After a request a host may be in deadlock state, and wait
> >> a specific action to unstuck the hardware block before
> >> re-sending a new command.
> >
> > Rather than talking about "unstuck" and "deadlock", how about instead
> > describing that an MMC controller, may end up in an non-functional
> > state hanging on something. Then to allow it to serve new requests it
> > needs to be reset.
> >
>
> Ok, deadlock naming is perhaps too stronght and scary.
>
> >>
> >> This patch adds an optional callback mmc_hw_unstuck which
> >> allows the host to unstuck the controller. In order to avoid
> >> a critical context, this callback must be called when the
> >> request is completed. Depending the mmc request, the completion
> >> function is defined by mrq->done and could be in block.c or core.c.
> >
> > I think it's important to state exactly what is expected from the core
> > perspective, by the mmc host driver when it calls this new host ops.
> > We need to clarify that.
> >
> >>
> >> mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
> >> DEADLK error.
> >
> > To me, this approach seems a bit upside-down. Although, I have to
> > admit that I haven't thought through this completely yet.
> >
> > The thing is, to make this useful for host drivers in general, I
> > instead think we need to add timeout to each request that the core
> > sends to the host driver. In other words, rather than waiting forever
> > in the core for the completion variable to be set, via calling
> > wait_for_completion() we could call wait_for_completion_timeout(). The
> > tricky part is to figure out what timeout to use for each request.
> > Perhaps that is even why you picked the approach as implemented in
> > @subject patch instead?
>
> On STM32 SDMMC variant, If datatimeout occurs on R1B request the Data
> Path State Machine stays in busy and only the DPSM is non-functional.
> The hardware block waits a software action to abort the DPSM.
>
> Like the CPSM stay alive, the framework can sent some requests
> (without data, example cmd13:status) before to had this
> timeout issue.
>
> POV framework I understand the possibility to have a completion_timeout,
> for more safety. But for this specific sdmmc case, I'm not fan, because
> the completion timeout error will occur several requests after the real
> issue (which put the DPSM non-functional). when the completion timeout
> occurs we can't know if it's due to R1B timeout or an other issue.

Right, I see what you are saying. So let's drop the approach suggested
in $subject series.

>
> To resolve the SDMMC's specificity, I can proposed you to add a threaded
> irq in mmci drivers to abort the DPSM and terminate the request.

Okay, so the threaded IRQ handler is needed, because the reset
operation may sleep (can't be executed in atomic context). Right?

That should work, but... let's move the discussion to that patch instead.

>
> >
> > Anyway, the typical scenario I see, is that the host driver is
> > hanging, likely waiting for an IRQ that never get raised. So, unless
> > it implements it own variant of a "request timeout" mechanism, it
> > simple isn't able to call mmc_request_done() to inform the core about
> > that the request has failed.
> >
> > For comments to the code, I defer that to the next step, when we have
> > agreed on the way forward.
> >
> > Kind regards
> > Uffe
> >

Kind regards
Uffe
