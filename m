Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4947FBB15F
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407115AbfIWJ00 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 05:26:26 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50120 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407083AbfIWJ00 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 05:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O3T2RYAPS4nlvKE9znP0mHuoxdYaRkHcJ/V23EO7AQ0=; b=Awm7yXqP81zKpudd4NfnEMzUo
        VdV00K80QF7Sw0ooCCaiasCqX52UKeqSgoKY43z8j0gF9xwByFAsmF+mRUs75dDJoehC8ijrO/oEW
        4KMzgVB6rn4Q7LaAdDanL2hJfovP5D8WZ05WxHygzSESiqVvyW1xmnsTmnT3rxQ9CfUKDrTiuWdfZ
        2D1BZAANOjx0mV2ao8zTY0VdUBOfbypBu4gMxcSoHX8pl8TzrA9txMXvkvXnyUal9T0z1Rz6j72iB
        9QmDLvpplJRLlOMAP6W5cOn12zaUTgOIMjN+UAgRMdMi+3qEqh3n7hvlV57OAaB9tQlpKOf4EXUyf
        oNt5zRRyg==;
Received: from shell.armlinux.org.uk ([192.168.0.251]:55756)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCKbr-0003Zo-Bq
        for linux-mmc@vger.kernel.org; Mon, 23 Sep 2019 10:26:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCJuY-00009V-BD; Mon, 23 Sep 2019 09:41:34 +0100
Date:   Mon, 23 Sep 2019 09:41:34 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Message-ID: <20190923084134.GT25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <VI1PR0401MB223771C40FEC48E770088CBDF8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0401MB223771C40FEC48E770088CBDF8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 23, 2019 at 02:51:15AM +0000, Y.b. Lu wrote:
> Hi Russell,
> 
> > -----Original Message-----
> > From: Russell King <rmk@armlinux.org.uk> On Behalf Of Russell King
> > Sent: Sunday, September 22, 2019 6:27 PM
> > To: Robin Murphy <robin.murphy@arm.com>; dann frazier
> > <dann.frazier@canonical.com>; Will Deacon <will.deacon@arm.com>; Nicolin
> > Chen <nicoleotsuka@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>; Christoph
> > Hellwig <hch@lst.de>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> > <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
> > coherence
> > 
> > We must not unconditionally set the DMA snoop bit; if the DMA API is
> > assuming that the device is not DMA coherent, and the device snoops the CPU
> > caches, the device can see stale cache lines brought in by speculative prefetch.
> > 
> > This leads to the device seeing stale data, potentially resulting in corrupted
> > data transfers.  Commonly, this results in a descriptor fetch error such as:
> > 
> > mmc0: ADMA error
> > mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> > mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> > mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> > mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> > mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> > mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> > mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> > mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> > mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> > mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> > mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> > mmc0: sdhci: Host ctl2: 0x00000000
> > mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> > mmc0: sdhci: ============================================
> > mmc0: error -5 whilst initialising SD card
> > 
> > but can lead to other errors, and potentially direct the SDHCI controller to
> > read/write data to other memory locations (e.g. if a valid descriptor is visible
> > to the device in a stale cache line.)
> > 
> > Fix this by ensuring that the DMA snoop bit corresponds with the behaviour of
> > the DMA API.  Since the driver currently only supports DT, use
> > of_dma_is_coherent().  Note that device_get_dma_attr() can not be used as
> > that risks re-introducing this bug if/when the driver is converted to ACPI.
> 
> [Y.b. Lu] May I have your suggestion how to check this condition with ACPI?
> Although we didn’t support APCI on upstream for this driver now, as I know we had already had ACPI used internally and would be upstreamed.
> Thanks.

The short answer is, I don't believe there is an equivalent for ACPI.
However, it's a question for ACPI people, not me, as I have little
knowedge about ACPI.

From what I've looked at so far, for ACPI, the decision used for
dev->dma_coherent() / dev_is_dma_coherent() (which controls the DMA
API behaviour) is not available - this is a decision by the SMMU code.

See:
	drivers/acpi/arm64/iort.c:arm_smmu_dma_configure()
	drivers/acpi/scan.c:acpi_dma_configure()
	arch/arm64/mm/dma-mapping.c:arch_setup_dma_ops()

The decision is made whether the SMMU is in coherent walk mode.

The proposed interface to use is device_get_dma_attr().  For OF,
this works as expected - it mirrors of_dma_is_coherent().  However,
for ACPI it does not - under ACPI, it uses acpi_get_dma_attr().

See:
	drivers/acpi/scan.c:acpi_get_dma_attr()

This can return one of three states.  Let's concentrate on the
coherent/non-coherent states.  This depends on
adev->flags.coherent_dma.  This gets set by acpi_init_coherency(),
which looks up the _CCA property in the device handle.

It looks to me like it is entirely possible for ACPI to say that, for
example, the SMMU is coherent, which will cause dev->dma_coherent to
be set, but the device (and it's parents) not to have _CCA indicating
that the device is coherent.

It seems that the only way this could be guaranteed is if the ESDHC
was a child of the SMMU - but I don't know whether that is the case
or not.  If it isn't, using device_get_dma_attr() will result in a
coherency disagreement between the DMA API and the device, which
will lead to ADMA errors and potential data corruption.

There may be some subtle reason this can't happen, but from merely
looking at the code, I'd say using device_get_dma_attr() here would
be dangerous.

> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 4dd43b1adf2c..74de5e8c45c8 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -495,7 +495,12 @@ static int esdhc_of_enable_dma(struct sdhci_host
> > *host)
> >  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> > 
> >  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> > -	value |= ESDHC_DMA_SNOOP;
> > +
> > +	if (of_dma_is_coherent(dev->of_node))
> > +		value |= ESDHC_DMA_SNOOP;
> > +	else
> > +		value &= ~ESDHC_DMA_SNOOP;
> > +
> >  	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
> >  	return 0;
> >  }
> > --
> > 2.7.4
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
