Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FBEBB2A3
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392809AbfIWLKi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 07:10:38 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51250 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbfIWLKi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 07:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F6jj2JAZcKjgDi2qZal50WvLmuEupljKKCnH6rZaFpM=; b=YvtmfjYa+80mDuDhWaTGjep/k
        Olt0597MJd1IYKFdyXkyZRENMT7B1FzHIoaWzi5dMrTTIgU15+rn+W/S4JJd8uQ/zFJMWFdFStsYs
        OwAW8bZV5OIAEqy/bn2vJLN4e5vAJwe/kOcpJ+ryH4B0yCHwG3tzDGOlhV6BfcqpZEQLwkSo6R35b
        p613OM/MrqtQCXYMBk9vwAFEKUYYcO+mKMvyrDmJ/Pff7VpzL4nyeND62JdGX2f5N2UHiUVqPdIdt
        Io+KSnYvwrLT9PXz0Q4OYRA36tqbPaZ1ONEPXTq+VNGAzhEAN7brqP9CdJTLF6nWRo5qmqEQcjspA
        DtqBjSnDA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43080)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCMEY-0003zl-3t; Mon, 23 Sep 2019 12:10:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCMES-0000FU-Kz; Mon, 23 Sep 2019 12:10:16 +0100
Date:   Mon, 23 Sep 2019 12:10:16 +0100
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
Message-ID: <20190923111016.GC1344@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <VI1PR0401MB223771C40FEC48E770088CBDF8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <20190923084134.GT25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923084134.GT25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 23, 2019 at 09:41:34AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Sep 23, 2019 at 02:51:15AM +0000, Y.b. Lu wrote:
> > Hi Russell,
> > 
> > > -----Original Message-----
> > > From: Russell King <rmk@armlinux.org.uk> On Behalf Of Russell King
> > > Sent: Sunday, September 22, 2019 6:27 PM
> > > To: Robin Murphy <robin.murphy@arm.com>; dann frazier
> > > <dann.frazier@canonical.com>; Will Deacon <will.deacon@arm.com>; Nicolin
> > > Chen <nicoleotsuka@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>; Christoph
> > > Hellwig <hch@lst.de>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> > > <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > > Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
> > > coherence
> > > 
> > > We must not unconditionally set the DMA snoop bit; if the DMA API is
> > > assuming that the device is not DMA coherent, and the device snoops the CPU
> > > caches, the device can see stale cache lines brought in by speculative prefetch.
> > > 
> > > This leads to the device seeing stale data, potentially resulting in corrupted
> > > data transfers.  Commonly, this results in a descriptor fetch error such as:
> > > 
> > > mmc0: ADMA error
> > > mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> > > mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> > > mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> > > mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> > > mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> > > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> > > mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> > > mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> > > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> > > mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> > > mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> > > mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> > > mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> > > mmc0: sdhci: Host ctl2: 0x00000000
> > > mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> > > mmc0: sdhci: ============================================
> > > mmc0: error -5 whilst initialising SD card
> > > 
> > > but can lead to other errors, and potentially direct the SDHCI controller to
> > > read/write data to other memory locations (e.g. if a valid descriptor is visible
> > > to the device in a stale cache line.)
> > > 
> > > Fix this by ensuring that the DMA snoop bit corresponds with the behaviour of
> > > the DMA API.  Since the driver currently only supports DT, use
> > > of_dma_is_coherent().  Note that device_get_dma_attr() can not be used as
> > > that risks re-introducing this bug if/when the driver is converted to ACPI.
> > 
> > [Y.b. Lu] May I have your suggestion how to check this condition with ACPI?
> > Although we didn’t support APCI on upstream for this driver now, as I know we had already had ACPI used internally and would be upstreamed.
> > Thanks.
> 
> The short answer is, I don't believe there is an equivalent for ACPI.
> However, it's a question for ACPI people, not me, as I have little
> knowedge about ACPI.
> 
> From what I've looked at so far, for ACPI, the decision used for
> dev->dma_coherent() / dev_is_dma_coherent() (which controls the DMA
> API behaviour) is not available - this is a decision by the SMMU code.
> 
> See:
> 	drivers/acpi/arm64/iort.c:arm_smmu_dma_configure()
> 	drivers/acpi/scan.c:acpi_dma_configure()
> 	arch/arm64/mm/dma-mapping.c:arch_setup_dma_ops()
> 
> The decision is made whether the SMMU is in coherent walk mode.
> 
> The proposed interface to use is device_get_dma_attr().  For OF,
> this works as expected - it mirrors of_dma_is_coherent().  However,
> for ACPI it does not - under ACPI, it uses acpi_get_dma_attr().
> 
> See:
> 	drivers/acpi/scan.c:acpi_get_dma_attr()
> 
> This can return one of three states.  Let's concentrate on the
> coherent/non-coherent states.  This depends on
> adev->flags.coherent_dma.  This gets set by acpi_init_coherency(),
> which looks up the _CCA property in the device handle.
> 
> It looks to me like it is entirely possible for ACPI to say that, for
> example, the SMMU is coherent, which will cause dev->dma_coherent to
> be set, but the device (and it's parents) not to have _CCA indicating
> that the device is coherent.
> 
> It seems that the only way this could be guaranteed is if the ESDHC
> was a child of the SMMU - but I don't know whether that is the case
> or not.  If it isn't, using device_get_dma_attr() will result in a
> coherency disagreement between the DMA API and the device, which
> will lead to ADMA errors and potential data corruption.
> 
> There may be some subtle reason this can't happen, but from merely
> looking at the code, I'd say using device_get_dma_attr() here would
> be dangerous.

The best I can come up with is something like:

	enum dev_dma_attr attr, expected;

	attr = device_get_dma_attr(dev);
	expected = dev_is_dma_coherent(dev) ? DEV_DMA_COHERENT :
			DEV_DMA_NON_COHERENT;

	WARN_ON(attr != expected);

Maybe even aborting the probe if they don't agree.  However, it seems
dev_is_dma_coherent() is an IOMMU/DMA API implementation detail that
only IOMMU drivers and arch code are supposed to use.

What I'm hearing at the moment from Jon Nettleton is that the NXP ACPI
description does not include an IORT table and doesn't mention the
SMMU.  If I'm reading the code correctly, that means the Linux DMA API
will assume all devices are DMA non-coherent - and if we use
device_get_dma_attr() for this, and the ACPI device description has
_CCA=1, we'll end up with potentially data corrupting mismatched DMA
coherency expectations.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
