Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0BD77A0
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Oct 2019 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfJONpk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Oct 2019 09:45:40 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:39440 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJONpj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2019 09:45:39 -0400
Received: by mail-vs1-f50.google.com with SMTP id y129so13170531vsc.6
        for <linux-mmc@vger.kernel.org>; Tue, 15 Oct 2019 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNIRNpWHhrAEU2DhpeQQE3CUwHvDswnXJX1PES/Zr3o=;
        b=ijoZ8Qmbt/4hKeJk14h1phh0mFVDk9G8L/V+dLCKtUrsbX46zJvPjaisS0WX3WSm6L
         bT/hGJ4VERtuiQ2n2StvgTeN20s6y255T2pbjturEsYekxjgK9U2BQJ3JQC6zv8s84L+
         h1t3H9PG7d9x9mp159bu+ZUuxUSScDp96unxc16FJGLjwZCXwc6ghw+DkorcT4H0HwsI
         Uh/83JHxS7eHoHA0UQovkzBobvzvh9r+UZ0SncLbWUB5u4FLNNfrliYg60ikCBPlcDn4
         xHP5Lyt4SsxwsqOFk4ujJXk/kiZbQB7wcMJE+1gdIBDC5xdK3dKAo0JTxO16cm8szoIh
         8H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNIRNpWHhrAEU2DhpeQQE3CUwHvDswnXJX1PES/Zr3o=;
        b=PUAb2sVIiF4WBj+rdqwlEqH7qgT2idQr+wPG85WwKerevFIoCjTRd+SADKV8A+Up4e
         RrUVGwFMnHAVzzv1FZf6usK+zaqA6Q68jVPgOefVNHN+ThaG6Exh+Narbt2Ybv/HPkD/
         eABGQolQcEkHF9o2U0X4k9L4/fwUjyz74kMsAhYd2kht7a7iqdgzhfkhrc6w7/KD7TUf
         3AsmmoBfvhRMrDeVJYD3w38oZyI0pNUJaco4b330AySYM0trowgNX6e7P7PQjLlZE76t
         5dVe9XplzZ1nqJdtNW1bwur1XquDj9sbJLaSgon+bHu+wIKCx0e5brfFx/4gZmdTOjoY
         u3FQ==
X-Gm-Message-State: APjAAAUQKmhL4/bz1saZfkZoznIj9j6u64neSUidgkvMRBozqbCzrRPL
        8PCSu4HsjMQkI67YqvulEv7cuGvNFp4FuHtZY40hGw==
X-Google-Smtp-Source: APXvYqwIeOSlyIOeyBFqIHaICHFb8043ocQ/l1HHEEYHSwdSNR1n7bntsrKuJmnH+Jd7eaZ5PD+HOP4R2FZzWlUOKWI=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr20325093vsl.34.1571147135304;
 Tue, 15 Oct 2019 06:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de> <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de> <20191015131750.GV25745@shell.armlinux.org.uk>
In-Reply-To: <20191015131750.GV25745@shell.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Oct 2019 15:44:59 +0200
Message-ID: <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Oct 2019 at 15:18, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 15, 2019 at 03:12:49PM +0200, Christian Zigotzky wrote:
> > Hello Russell,
> >
> > You asked me about "dma-coherent" in the Cyrus device tree. Unfortunately I
> > don't find the property "dma-coherent" in the dtb source files.
> >
> > Output of "fdtdump cyrus_p5020_eth_poweroff.dtb | grep dma":
> >
> > dma0 = "/soc@ffe000000/dma@100300";
> >         dma1 = "/soc@ffe000000/dma@101300";
> >         dma@100300 {
> >             compatible = "fsl,eloplus-dma";
> >             dma-channel@0 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@80 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@100 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@180 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >         dma@101300 {
> >             compatible = "fsl,eloplus-dma";
> >             dma-channel@0 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@80 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@100 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@180 {
> >                 compatible = "fsl,eloplus-dma-channel";
>
> Hmm, so it looks like PowerPC doesn't mark devices that are dma
> coherent with a property that describes them as such.
>
> I think this opens a wider question - what should of_dma_is_coherent()
> return for PowerPC?  It seems right now that it returns false for
> devices that are DMA coherent, which seems to me to be a recipe for
> future mistakes.

Perhaps implement the arch_setup_dma_ops() for PPC, that set
"dev->dma_coherent = true" could work?

[...]

Kind regards
Uffe
