Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9353EE1DD3
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJWONZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Oct 2019 10:13:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60484 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbfJWONZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2019 10:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bhqjKEpn+qSsmpYYqb68xE5kHQPzkJYmaZ3ItnhlEJ4=; b=rquAbX5FtWs9a2HbwGSCDNwhH
        2Fj9nfopSQqUlAxZvkpBSDl3ry8n7liQXfxKHBSNbV26P3Jcz2FJ/OP495R+dU+SySTJDxgaPMDrX
        VMHeaKIexYy7444dDwgVOCR/nUQ7d6kflR9ZjfHlMtH2iQ3kCQt2VL+J51Iv1fGvnzoNz0A/Ya3Qf
        41WpS+I+KrSqFpPr8x2+LU3weIJrKaix+1TvU+68w+oHse04tc3Y/6XyHSKKiuLHD9WNYf/1R9Ck8
        rVPUM/xVkMpU7p3aN7SKpT6lL386/Cp/YSn770AbK3+QKDLE+2P4DbXUALV7QubuppeSdpfu4T5AJ
        sJMamXOxw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:53958)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iNHNp-0005MT-MW; Wed, 23 Oct 2019 15:13:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iNHNh-0005br-85; Wed, 23 Oct 2019 15:12:57 +0100
Date:   Wed, 23 Oct 2019 15:12:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Message-ID: <20191023141257.GA25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> On Wed, Oct 23, 2019 at 1:41 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > On Wed, 2019-10-23 at 16:42 +1100, Michael Ellerman wrote:
> > >
> > > Right, it seems of_dma_is_coherent() has baked in the assumption that
> > > devices are non-coherent unless explicitly marked as coherent.
> > >
> > > Which is wrong on all or at least most existing powerpc systems
> > > according to Ben.
> >
> > This is probably broken on sparc(64) as well and whatever else uses
> > DT and is an intrinsicly coherent architecture (did we ever have
> > DT enabled x86s ? Wasn't OLPC such a beast ?).
> 
> Only if those platforms use one of the 5 drivers that call this function:
> 
> drivers/ata/ahci_qoriq.c:       qoriq_priv->is_dmacoherent =
> of_dma_is_coherent(np);
> drivers/crypto/ccree/cc_driver.c:       new_drvdata->coherent =
> of_dma_is_coherent(np);
> drivers/iommu/arm-smmu-v3.c:    if (of_dma_is_coherent(dev->of_node))
> drivers/iommu/arm-smmu.c:       if (of_dma_is_coherent(dev->of_node))
> drivers/mmc/host/sdhci-of-esdhc.c:      if (of_dma_is_coherent(dev->of_node))
> 
> Curious that a PPC specific driver (ahci_qoriq) calls it...

Maybe because it is not PPC specific:

arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";

drivers/ata/ahci_qoriq.c:       { .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
