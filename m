Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88508BD1AD
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Sep 2019 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfIXSQR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Sep 2019 14:16:17 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44278 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfIXSQQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2019 14:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1BjdITAnVf5pl8PFwwcoJuhXLRsHTnSaC3gW2GQ1LSU=; b=Uxsi0C7ajsoTQnkx3KwuVZnZd
        o+cG+QyTy0wCYnFg/JJ9mqfLJhEW69mCSHqKppYvD0ZKTWZePViyICdOpetTTRew4s8Ba09yAhGO8
        EbmHZhm4zIZfxtt606cY/X6yQeZ4ofPb8yyvplo23jRZ/38cN+rtnqchXoWJ6WZxmBQkY0fEXEP/z
        +vutL1+Jj3ysVoLDbD/yXsg4oWDdMWl5GpqUqZP+OZC5VtdAOVDuZsIFst5BVhLPs98dVW4Qvfush
        rEhy9JWRV3c8qkIs/U6LGZBnuThs+kvPpFQCxvJamJtCP4KR9eTwMB45ONN4Mk6WNJb5qu5ZdIswL
        zrr0vl2zQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47740)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCpLw-0003Mr-V4; Tue, 24 Sep 2019 19:15:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCpLr-0001TR-QQ; Tue, 24 Sep 2019 19:15:51 +0100
Date:   Tue, 24 Sep 2019 19:15:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Y.b. Lu" <yangbo.lu@nxp.com>,
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
Message-ID: <20190924181551.GA25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <VI1PR0401MB223771C40FEC48E770088CBDF8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <20190923084134.GT25745@shell.armlinux.org.uk>
 <20190923111016.GC1344@shell.armlinux.org.uk>
 <7f0b9a9a-54c3-e65d-c519-dec4daa96cf4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f0b9a9a-54c3-e65d-c519-dec4daa96cf4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 24, 2019 at 06:56:53PM +0100, Robin Murphy wrote:
> On 23/09/2019 12:10, Russell King - ARM Linux admin wrote:
> > On Mon, Sep 23, 2019 at 09:41:34AM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Sep 23, 2019 at 02:51:15AM +0000, Y.b. Lu wrote:
> > > > Hi Russell,
> > > > 
> > > > > -----Original Message-----
> > > > > From: Russell King <rmk@armlinux.org.uk> On Behalf Of Russell King
> > > > > Sent: Sunday, September 22, 2019 6:27 PM
> > > > > To: Robin Murphy <robin.murphy@arm.com>; dann frazier
> > > > > <dann.frazier@canonical.com>; Will Deacon <will.deacon@arm.com>; Nicolin
> > > > > Chen <nicoleotsuka@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>; Christoph
> > > > > Hellwig <hch@lst.de>
> > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> > > > > <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > > > > Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
> > > > > coherence
> > > > > 
> > > > > We must not unconditionally set the DMA snoop bit; if the DMA API is
> > > > > assuming that the device is not DMA coherent, and the device snoops the CPU
> > > > > caches, the device can see stale cache lines brought in by speculative prefetch.
> > > > > 
> > > > > This leads to the device seeing stale data, potentially resulting in corrupted
> > > > > data transfers.  Commonly, this results in a descriptor fetch error such as:
> > > > > 
> > > > > mmc0: ADMA error
> > > > > mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > > > > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> > > > > mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> > > > > mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> > > > > mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> > > > > mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> > > > > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> > > > > mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> > > > > mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> > > > > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> > > > > mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> > > > > mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> > > > > mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> > > > > mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> > > > > mmc0: sdhci: Host ctl2: 0x00000000
> > > > > mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> > > > > mmc0: sdhci: ============================================
> > > > > mmc0: error -5 whilst initialising SD card
> > > > > 
> > > > > but can lead to other errors, and potentially direct the SDHCI controller to
> > > > > read/write data to other memory locations (e.g. if a valid descriptor is visible
> > > > > to the device in a stale cache line.)
> > > > > 
> > > > > Fix this by ensuring that the DMA snoop bit corresponds with the behaviour of
> > > > > the DMA API.  Since the driver currently only supports DT, use
> > > > > of_dma_is_coherent().  Note that device_get_dma_attr() can not be used as
> > > > > that risks re-introducing this bug if/when the driver is converted to ACPI.
> > > > 
> > > > [Y.b. Lu] May I have your suggestion how to check this condition with ACPI?
> > > > Although we didn’t support APCI on upstream for this driver now, as I know we had already had ACPI used internally and would be upstreamed.
> > > > Thanks.
> > > 
> > > The short answer is, I don't believe there is an equivalent for ACPI.
> > > However, it's a question for ACPI people, not me, as I have little
> > > knowedge about ACPI.
> > > 
> > >  From what I've looked at so far, for ACPI, the decision used for
> > > dev->dma_coherent() / dev_is_dma_coherent() (which controls the DMA
> > > API behaviour) is not available - this is a decision by the SMMU code.
> > > 
> > > See:
> > > 	drivers/acpi/arm64/iort.c:arm_smmu_dma_configure()
> > > 	drivers/acpi/scan.c:acpi_dma_configure()
> > > 	arch/arm64/mm/dma-mapping.c:arch_setup_dma_ops()
> > > 
> > > The decision is made whether the SMMU is in coherent walk mode.
> > > 
> > > The proposed interface to use is device_get_dma_attr().  For OF,
> > > this works as expected - it mirrors of_dma_is_coherent().  However,
> > > for ACPI it does not - under ACPI, it uses acpi_get_dma_attr().
> 
> Which is more or less the direct equivalent of of_dma_is_coherent(), just
> with an extra state and rather different-looking inheritance logic.

Having read the code, I remain to be convinced of that equivalence.
Are you sure it's not an expectation on your part, rather than a
true equivalence (see below.)

> > > See:
> > > 	drivers/acpi/scan.c:acpi_get_dma_attr()
> > > 
> > > This can return one of three states.  Let's concentrate on the
> > > coherent/non-coherent states.
> 
> (note that the third state is moot anyway because it will actively prevent
> the driver from doing DMA API operations - see dma_dummy_ops)
> 
> > >  This depends on
> > > adev->flags.coherent_dma.  This gets set by acpi_init_coherency(),
> > > which looks up the _CCA property in the device handle.
> > > 
> > > It looks to me like it is entirely possible for ACPI to say that, for
> > > example, the SMMU is coherent, which will cause dev->dma_coherent to
> > > be set, but the device (and it's parents) not to have _CCA indicating
> > > that the device is coherent.
> 
> It is indeed entirely possible to have an inherently non-coherent device
> translated by a coherent SMMU - see the USB controller in your Juno, for
> example - however in terms of these firmware properties those coherencies
> are orthogonal; the latter only describes the SMMU's pagetable walk
> interface, not the path(s) through its translation interface(s) which aren't
> even necessarily all equal.
> 
> > > It seems that the only way this could be guaranteed is if the ESDHC
> > > was a child of the SMMU - but I don't know whether that is the case
> > > or not.  If it isn't, using device_get_dma_attr() will result in a
> > > coherency disagreement between the DMA API and the device, which
> > > will lead to ADMA errors and potential data corruption.
> > > 
> > > There may be some subtle reason this can't happen, but from merely
> > > looking at the code, I'd say using device_get_dma_attr() here would
> > > be dangerous.
> 
> This can't ever happen because SMMUs aren't represented in the ACPI
> namespace at all. And even if they were, such a topology would still be as
> bogus as it would be in DT - physically, it's perfectly possible for a
> single "device" like a PCI host bridge to have different sets of requester
> IDs translated by different SMMUs, so treating the SMMU as a hierarchical
> "bus" just doesn't work.

My comment reflects my investigations into all possible routes to find
an answer to the issue at hand.  I can't find in the code any
correlation between the DMA API's idea of coherency and the _CCA
attribute for ACPI devices.  As far as I can see, it's entirely
possible for the two to disagree - to the extent that I believe that
the DMA API will default to assuming non-coherence whereas the ACPI
code defaults to assuming coherence - and there is no path in the ACPI
code that sets dev->dma_coherent for ACPI devices.

> 
> > The best I can come up with is something like:
> > 
> > 	enum dev_dma_attr attr, expected;
> > 
> > 	attr = device_get_dma_attr(dev);
> > 	expected = dev_is_dma_coherent(dev) ? DEV_DMA_COHERENT :
> > 			DEV_DMA_NON_COHERENT;
> > 
> > 	WARN_ON(attr != expected);
> 
> This would be a tautology given where dev->dma_coherent comes from in the
> first place - see {platform,pci}_dma_configure().

For platform and PCI devices, yes, I agree. But for ACPI devices, it
seems dev->dma_coherent is left uninitialised - or I could not locate
where it gets initialised.  My conclusion is that for ACPI devices,
setting _CCA=1 or allowing it to default to 1 results in a mismatch
between what the DMA API believes and what device_get_dma_attr() would
return.  Given what I understand, the above seems to be far from a
tautology.

If you feel differently, please reference the code so I can get a
better understanding of the ACPI code - but my position that there is
a mismatch between the DMA API and devices is based on grepping the
code and following the various paths.

> 
> > Maybe even aborting the probe if they don't agree.  However, it seems
> > dev_is_dma_coherent() is an IOMMU/DMA API implementation detail that
> > only IOMMU drivers and arch code are supposed to use.
> > 
> > What I'm hearing at the moment from Jon Nettleton is that the NXP ACPI
> > description does not include an IORT table and doesn't mention the
> > SMMU.  If I'm reading the code correctly, that means the Linux DMA API
> > will assume all devices are DMA non-coherent - and if we use
> > device_get_dma_attr() for this, and the ACPI device description has
> > _CCA=1, we'll end up with potentially data corrupting mismatched DMA
> > coherency expectations.
> 
> In terms of DMA API coherency, unless you're working on the SMMU drivers you
> can consider IORT entirely irrelevant and just treat _CCA for namespace
> devices as the first and last word. Yes, technically IORT can describe weird
> stuff with the CPM attribute, but I have every intention to keep ignoring
> that in Linux.
> 
> Robin.
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
