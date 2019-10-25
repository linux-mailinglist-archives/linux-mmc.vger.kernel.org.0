Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E397E567C
	for <lists+linux-mmc@lfdr.de>; Sat, 26 Oct 2019 00:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJYW27 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 25 Oct 2019 18:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfJYW27 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Oct 2019 18:28:59 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EBB0222C4
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2019 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572042537;
        bh=3evtaW0DllhNjB+6uE12Xtr767SicH4mL/3jr13JPnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y0xPYNWIhy+X9xuv5u4Wa/zCefNIPCanVXobNlhDKDX+Owz52aqUAH58jQ+mNPs63
         O3mMjAqP71Ir0UCSIrBSJIhnTx3HMFGLlfJAKFrZq2/utHjIKqYV0lRegpvqlNse6+
         htEoGVaqJTN39uF3gK96EmNCmnRhLEiw9Z3VeLDA=
Received: by mail-qt1-f175.google.com with SMTP id y39so262475qty.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2019 15:28:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWp0EMndOK0kSIlhOI+ksBxwxF0VNhTmK6SgvOZ5cu8fG7Z4JgL
        n4netamtSeITu2U0nPTJu/H/BybtbSm0L7t8Vw==
X-Google-Smtp-Source: APXvYqwUeo+87jGdwN8O2BI8pdyipeup5umEsuiEp7ShvmiozlvhXNWOXf+HdZp099/MAKe+FyPRmNOe/EwJehO/q28=
X-Received: by 2002:a0c:eed0:: with SMTP id h16mr5912628qvs.85.1572042536551;
 Fri, 25 Oct 2019 15:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de> <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de> <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au> <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com> <20191023143159.GB25745@shell.armlinux.org.uk>
In-Reply-To: <20191023143159.GB25745@shell.armlinux.org.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 25 Oct 2019 17:28:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
Message-ID: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 9:32 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> > > I think this should have been done the other way around and default to
> > > coherent since most traditional OF platforms are coherent, and you
> > > can't just require those DTs to change.
> >
> > You can blame me. This was really only intended for cases where
> > coherency is configurable on a per peripheral basis and can't be
> > determined in other ways.
> >
> > The simple solution here is simply to use the compatible string for
> > the device to determine coherent or not.
>
> It really isn't that simple.

This doesn't work?:

        if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev->of_node))
                value |= ESDHC_DMA_SNOOP;
        else
                value &= ~ESDHC_DMA_SNOOP;

While I said use the compatibles, using the kconfig symbol is easier
than sorting out which compatibles are PPC SoCs. Though if that's
already done elsewhere in the driver, you could set a flag and use
that here. I'd be surprised if this was the only difference between
ARM and PPC SoCs for this block.

> There are two aspects to coherency, both of which must match:
>
> 1) The configuration of the device
> 2) The configuration of the kernel's DMA API
>
> (1) is controlled by the driver, which can make the decision any way
> it pleases.
>
> (2) on ARM64 is controlled depending on whether or not "dma-coherent"
> is specified in the device tree, since ARM64 can have a mixture of
> DMA coherent and non-coherent devices.
>
> A mismatch between (1) and (2) results in data corruption, potentially
> eating your filesystem.  So, it's very important that the two match.
>
> These didn't match for the LX2160A, but, due to the way CMA was working,
> we sort of got away with it, but it was very dangerous as far as data
> safety went.
>
> Then, a change to CMA happened which moved where it was located, which
> caused a regression.  Reverting the CMA changes didn't seem to be an
> option, so another solution had to be found.
>
> I started a discussion on how best to solve this:
>
> https://archive.armlinux.org.uk/lurker/thread/20190919.041320.1e53541f.en.html
>
> and the solution that the discussion came out with was the one that has
> been merged - which we now know caused a regression on PPC.
>
> Using compatible strings doesn't solve the issue: there is no way to
> tell the DMA API from the driver that the device is coherent.  The
> only way to do that is via the "dma-coherent" property in DT on ARM64.
>
> To say that this is a mess is an under-statement, but we seem to have
> ended up here because of a series of piece-meal changes that don't seem
> to have been thought through enough.
>
> So, what's the right way to solve this, and ensure that the DMA API and
> device match as far as their coherency expectations go?  Revert all the
> changes for sdhci-of-esdhc and CMA back to 5.0 or 5.1 state?

The other option is similar to earlier in the thread and just add to
of_dma_is_coherent():

/* Powerpc is normally cache coherent DMA */
if (IS_ENABLED(CONFIG_PPC) && !IS_ENABLED(CONFIG_NOT_COHERENT_CACHE))
    return true;

We could do the all the weak arch hooks, but that seems like overkill
to me at this point.

Rob
