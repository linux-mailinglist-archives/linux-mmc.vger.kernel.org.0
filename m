Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC09D320
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfHZPkK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 11:40:10 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46287 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfHZPkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2019 11:40:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id y19so5847615ual.13
        for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2019 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plT/n27037I8QlKS8S1GKgyu4KFjFp7fxizTWChkqOg=;
        b=nxE/VrZFtW+kte1eTm/tlxwpCyyo145xQF26q+bGLWE/pMIH9HRSBpU8SgXv27Lqow
         BgEKF7dLjd5zR5YFiAZE07wJyvLz6kQf/RXsv+Qexy8TRuK0+VypKR5QoFruvgdhiEKs
         NKZW+n+43llRPGbSPLEdE+ASUPmWt5NqTSdh5EqLqHOYsT96OBkc+zbhSFQV5MRJgS9m
         cICf9MWRpliytqmGj7OKu7kyELWrd/rljzH/CNyYxKWkw3wfqvMWE/idqjsuntNfjwPa
         3ngxaqfOV4Z3caLAcg2PBVRqXA2SgrQbSEjsaR9dGiKJv7Pz3VLsmIhEJxtswtz+erSt
         xxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plT/n27037I8QlKS8S1GKgyu4KFjFp7fxizTWChkqOg=;
        b=uhgRITPN3DiqdXA5ds8f2FQVZz/UeJ1fXFqU/qsNUvb+HtwnwQ5Q5jQ8BwhGJnANsn
         8gVzk3BWoqOzJz02Cn+8LX7ctCmydjDcACQGIwJ3E1atX4dL0DS99MT06M+r+cIk/ssv
         PTCCeuwWtyIk3sjInWphZH7kXnlopAXwXKGPdIUWri/RSFIZ1nNr+1JdVE4lNTgYfALe
         bwUEIzDOva377M1W34Ges+q39Ru6SjeUaqQBsM567tx78nV9tCS3iNTE+V4JNoHC7H91
         3uZm80iyE5re80DkIxAUN8pYpF+Mdx9U1FMx/u1925PBi4wn4rfnsTH/45WrFvgdZMkM
         Lv8Q==
X-Gm-Message-State: APjAAAXEahIP8snGcZLNRxyEUAeqTFj9ZnI6AzqMBKdZUEd/on1D9sL4
        4l2BZmLk2Rl8PBPzz19vZwY6V+A67YBV87CHnPSyIdcO
X-Google-Smtp-Source: APXvYqwh4K9A04GmItQmmMhxPNdRSGLyHEYXZeyAj7saIpouT0dw/+6lDx8uEfTFz/fS+2cds9uiBzbR6fAybjyYno8=
X-Received: by 2002:ab0:70b1:: with SMTP id q17mr8885348ual.100.1566834007914;
 Mon, 26 Aug 2019 08:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190811021917.29736-1-philipl@overt.org> <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
 <41d073f646b1f94adcf41b2cf0f798d8@overt.org> <20190824152530.432fe9a2@fido6>
In-Reply-To: <20190824152530.432fe9a2@fido6>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Aug 2019 17:39:30 +0200
Message-ID: <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
To:     Philip Langdale <philipl@overt.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 25 Aug 2019 at 00:25, Philip Langdale <philipl@overt.org> wrote:
>
> On Thu, 22 Aug 2019 16:05:22 -0700
> Philip Langdale <philipl@overt.org> wrote:
>
> > So, what's actually wrong? Well, either the controller doesn't really
> > support the
> > low voltage range, or the card doesn't. As my machine here only has a
> > microsd slot,
> > I can't test with an MMCplus card to see if low voltage MMC would
> > work. Without that
> > I can't say whether we should remove the host flag or somehow
> > blacklist low voltage
> > range on these cards (or any SD card?)
> >
> > Would love to get your thoughts.
>
> I did more reading and thinking. In the MMC spec, a low-voltage (1.8V)
> supporting card can run at 1.8V directly from start up (and this is
> what the existing core logic does). But for SD cards, i think this is
> not true. I read the Low-Voltage-Signaling announcement which says
> there is a new negotiation mechanism but I can't find it documented in
> the SD 6.0 spec (despite the announcement saying it's part of the SD
> 6.0 spec). That implies that direct bring up at low voltage doesn't
> work like it does for an MMC card.

Thanks a lot for analyzing the problem more deeply!

As far as I can understand, the the OCR register for SD card
represents the voltage range for VDD (and VDD1 for UHS-II cards),
which is represented by the vmmc regulator in the mmc core.

The OCR is isn't about the I/O signaling voltage, at least to my
understanding. When in comes to "dual voltage" SD cards, I think we
can simply forget about those, at least until someone come and says we
need to support then. Moreover, reading the spec doesn't really
mention much about "dual voltage" SD cards.

>
> Also, again without seeing an actual spec, I'd guess this means that
> having bit 7 set in OCR cannot be interpreted the same way for an SD
> card as for an MMC card. Perhaps it should be read to mean that the LVS
> negotiation process should be executed, but even that might be silly,
> because the whole point of LVS is to support scenarios where only 1.8V
> is usable - that means negotiation must be done with no prior
> knowledge. So you can't read OCR until you already know that 1.8V is
> supported.

Again, OCR is probably not about LVS. Becuase LVS is about supporting
to initialize the SD card in 1.8V signal voltage.

>
> So maybe the punchline here is that shared logic that will try and
> bring up a card at 1.8V should be MMC only and for SD cards, the LVS
> negotiation should be implemented instead.
>
> Finally, this Sandisk A2 card doesn't have the LV logo on it, so I
> don't know whether it would support 1.8V operation if the LVS
> negotiation was done directly or not - and I don't know whether setting
> bit 7 in OCR is correct for an LV compliant card.

Yeah.

I think we can agree on that having bit7 set in OCR is not really
useful for SD card. In principle I think we should just just ignore it
for all SD cards.

Do you want to send a patch, or if you prefer, I can do it!?

Kind regards
Uffe
