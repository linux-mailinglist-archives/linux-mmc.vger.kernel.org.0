Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EDE1D5C
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406064AbfJWNwq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Oct 2019 09:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404484AbfJWNwq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Oct 2019 09:52:46 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A8A21BE5
        for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2019 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571838765;
        bh=L2YvqC4bmvGKE85dTFRNQdVbKDb1o3LV4h060+5yHLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tqi4iNym3c4aGq5lPmy/v5BRwv5D/mTCqGD1rpjHIfR21u0ajdU7UvlMKihQmwcQ3
         W+zrGy23JfPYVrFQLTAXd2mmVXIl5E9f1VT9IKcAcBsB1hKNZHb3SJEn0Pg1mPNO0f
         tDcT0mqvjtfEnfJ1v531vSPaclS4fgd1EjmBw/Dc=
Received: by mail-qk1-f172.google.com with SMTP id e66so19784465qkf.13
        for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2019 06:52:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXBmaJMBJs0zmMZUUCMSP7mMo5rSm42wxtRyrelMBfwO4qdJqxf
        Si8jglgK2SeIxYf3FivnOZ/nEbz2qbqqvIS32Q==
X-Google-Smtp-Source: APXvYqzGWo2+pYN2T0o4NXgTDtjFyejmifDo8RHY+pr1SSlX+84WLu8rymxxmRgumcm+7thQm16eVcW2Z1bEiLdMOgo=
X-Received: by 2002:a37:98c1:: with SMTP id a184mr7812012qke.119.1571838764568;
 Wed, 23 Oct 2019 06:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de> <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de> <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au> <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
In-Reply-To: <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Oct 2019 08:52:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
Message-ID: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Wed, Oct 23, 2019 at 1:41 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2019-10-23 at 16:42 +1100, Michael Ellerman wrote:
> >
> > Right, it seems of_dma_is_coherent() has baked in the assumption that
> > devices are non-coherent unless explicitly marked as coherent.
> >
> > Which is wrong on all or at least most existing powerpc systems
> > according to Ben.
>
> This is probably broken on sparc(64) as well and whatever else uses
> DT and is an intrinsicly coherent architecture (did we ever have
> DT enabled x86s ? Wasn't OLPC such a beast ?).

Only if those platforms use one of the 5 drivers that call this function:

drivers/ata/ahci_qoriq.c:       qoriq_priv->is_dmacoherent =
of_dma_is_coherent(np);
drivers/crypto/ccree/cc_driver.c:       new_drvdata->coherent =
of_dma_is_coherent(np);
drivers/iommu/arm-smmu-v3.c:    if (of_dma_is_coherent(dev->of_node))
drivers/iommu/arm-smmu.c:       if (of_dma_is_coherent(dev->of_node))
drivers/mmc/host/sdhci-of-esdhc.c:      if (of_dma_is_coherent(dev->of_node))

Curious that a PPC specific driver (ahci_qoriq) calls it...

Note that the value is also passed to arch_setup_dma_ops(), but only
arc, arm, arm64, and mips implement arch_setup_dma_ops.

> I think this should have been done the other way around and default to
> coherent since most traditional OF platforms are coherent, and you
> can't just require those DTs to change.

You can blame me. This was really only intended for cases where
coherency is configurable on a per peripheral basis and can't be
determined in other ways.

The simple solution here is simply to use the compatible string for
the device to determine coherent or not.

Rob
