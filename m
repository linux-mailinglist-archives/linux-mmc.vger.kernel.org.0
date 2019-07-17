Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640526BCBB
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGQNGg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jul 2019 09:06:36 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36088 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQNGg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jul 2019 09:06:36 -0400
Received: by mail-vk1-f194.google.com with SMTP id b69so4940723vkb.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jul 2019 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPiT0KJAR0wwSuw4YnWnOYXBftP1qJ53XNQEG53sqDw=;
        b=drrAqwZ2b7NLp5QxBDU/OyG4Qcgo03l6c816eJi8Kh7KMEPGbxHZqOeNphBQbyjEQK
         4E5xrjum9CFL9zCEoEYlR0TTHeM9rhWkDybi2qask+9myH8Ao+yjj54vNVUHJT+Z0pi+
         FKrvLWaUPZ9mOOuRXYv8f9A5pSxMvNagaBu3ZVrIn6lzq2IyxFQxBf4ifH7es5brgQND
         oymOIqJyPovrB+vOzoWPg6raCVrxnw/8NXakdcREy804SV0tyh8LtUuAMRTrknAhysCR
         9qLqLZj7lfaj+Us2ehXj5l0VK908shptXll4klHL0SNwXy8J0vQjUU81lJ6pBBoI6uPI
         u+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPiT0KJAR0wwSuw4YnWnOYXBftP1qJ53XNQEG53sqDw=;
        b=H03NPb/bubnS2Zd2OwOdW0UOxot5aam3crXziFw+k77s6v8nLf09DgKxvZNmHhwLgF
         eZgI/o2BTrAe0Letl4ILg7qk7+6kVMaBpFQIG5Y0003OxGNr3dXvv8F96DrM/fhd9P1m
         DY2Gq/918v+/+0uY9dkP79aaE3YsNALkww1ruBZ1wMfHrg0trrzLjInd7/uxLdXIOGyn
         64FwsLaDbqjZPDYW/n3fRYDrbK2QCz4vCO8MFWqZbxavZkKFAtzF9eKcIR5ZqWu0LOg8
         bo1AhqK2QR4qVlfyKw/xJv7uLhClUjLo1bbgIjrpyRVQAV/dfSrcxdIEufGayZZvPtii
         ZF4g==
X-Gm-Message-State: APjAAAVlFPxf4Ie7nh3nrQvSdJkvKQ8VzjoAv+1hx/BUYo6BEIkwO7tE
        QCtXY6aEinFVAWd8LVzJlsXD4eqTsjs3528OU03sqw==
X-Google-Smtp-Source: APXvYqwF2fTV5Apuz4wMgImm6Sao4KDwjD4hnDeNbl4SAmj2MCtUAnY1haZDQfzeVT3g1C3+m6WmA0a3PujldZ/C6yk=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr15198516vkh.4.1563368795086;
 Wed, 17 Jul 2019 06:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164217.27297-1-ulf.hansson@linaro.org>
 <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com> <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
 <88dbabb8-a73e-e112-0fe3-33a831bb24ae@st.com>
In-Reply-To: <88dbabb8-a73e-e112-0fe3-33a831bb24ae@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Jul 2019 15:05:58 +0200
Message-ID: <CAPDyKFrQX9H3dbcnZEc6NOamgOzQX-kVwn9LCaDMeOBa5sGhRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Jean Nicolas GRAUX <jean-nicolas.graux@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 14:51, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf, JN
>
> IMHO you can't split my initial patch in two,
> this piece of code is needed (function: mmci_irq)
>
> -               status &= readl(host->base + MMCIMASK0);
> +               status &= readl(host->base + MMCIMASK0) |
> +                       host->variant->busy_detect_flag;

I am not buying that (at least yet), because it means that you tag on
the busy bit even if the card hasn't signaled busy, which to me seems
wrong.

I running some tests now, hopefully I will be able to complete them
before end today, else I will continue tomorrow mornings.

Kind regards
Uffe

>
> Regards,
> Ludo
>
> On 7/17/19 2:36 PM, Ulf Hansson wrote:
> > On Wed, 17 Jul 2019 at 12:16, Jean Nicolas GRAUX
> > <jean-nicolas.graux@st.com> wrote:
> >>
> >> Hello Ulf, all,
> >>
> >> For testing purpose, I cherry-picked your patch on top of a 4.19.30 basis.
> >> (I apologize as it's a bit old. I miss time to do a rebase on current
> >> linux-next right now.)
> >
> > No worries about the old kernel, for this change, I think it should be
> > suufient good as base.
> >
> >>
> >> Unfortunately, I got a kernel crash applying it :(
> >
> > Huh.
> >
> > Is it crashing because it fails to mount the rootfs on the SD/MMC card?
> >
> >>
> >> As you may know, ST sta1295/sta1385 SoC embeds the same pl08x variant
> >> than one in U8500.
> >> So It looks like double-checking again mmci status to make sure busy
> >> flag is still set
> >> just before proceeding for busy end is required in our case.
> >
> > Yeah, actually I have a u8500 on my desk now, so I will also test the
> > patch to see what goes on. Didn't have the time to do it earlier.
> >
> > My guess is that, at the point when we received the IRQ for a command
> > that has been sent, and then reading the MMCISTATUS register in
> > mmci_irq(), the card has not yet started to signal busy on DAT1 and
> > hence the busy status bit isn't set yet. This leads to that we will
> > never enable the busy end mask, but just completing the request
> > directly.
> >
> > Anyway, let me check and see if I can confirm it.
> >
> >>
> >> Regards.
> >> Jean-Nicolas.
> >
> > Thanks a lot for helping out testing and reporting the problem!
> >
> > [...]
> >
> > Kind regards
> > Uffe
> >
