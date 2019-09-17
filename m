Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD44B4C20
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfIQKmK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 06:42:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39284 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQKmJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 06:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FKnpqZlmKbJkCrYppKuTmglpJGaid7sr4Eb7U+NXfM0=; b=uFGDQs+hQ9T4wr6CCW03S6azZ
        ozRNZRNT5AXVILSJbvKOpwhe/6ztgTnHi8gEJy4/YHuzr5Q+jJ3/T0udreDGsEpZoKDkc0p/eHBrk
        B9pE0pW66gQbXf1p/1YeYeuryJNWL4LmQtPs2rG4ZepjlltxmUkTUMCQmffuSSJNSHHXjEcP+lA/T
        xaqfLfSFoTUmGbP9NeLeUv8JW+iYKuIlNlxB7NGwsYJMwas4fKnHpY6D2TIVuP6M1WzkxMv4QF4Av
        5kN/0wFrXml5vg9YhEn17eSk0ykaRlTAGP4crGDgHASMW0CajFN9iYyjwx4PzwBZ2dTke8Va+KeKw
        tO8HQEZdg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33066)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAAvq-0001AJ-Br; Tue, 17 Sep 2019 11:42:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAAvo-0001DN-D5; Tue, 17 Sep 2019 11:42:00 +0100
Date:   Tue, 17 Sep 2019 11:42:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190917104200.GJ25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917081931.GI25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 09:19:31AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 10:06:12AM +0200, Marc Gonzalez wrote:
> > On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:
> > 
> > > The platform has an iommu, which is in pass-through mode, via
> > > arm_smmu.disable_bypass=0.
> > 
> > Could be 954a03be033c7cef80ddc232e7cbdb17df735663
> > "iommu/arm-smmu: Break insecure users by disabling bypass by default"
> > 
> > Although it had already landed in v5.2
> 
> It is not - and the two lines that you quoted above are sufficient
> to negate that as a cause.  (Please read the help for the option that
> the commit referrs to.)
> 
> In fact, with bypass disabled, the SoC fails due to other masters.
> That's already been discussed privately between myself and Will
> Deacon.
> 
> arm_smmu.disable_bypass=0 re-enables bypass mode irrespective of
> the default setting in the Kconfig.

Adding some further debugging, and fixing the existing ADMA debugging
shows:

mmc0: ADMA error: 0x02000000

So this is an ADMA error without the transfer having completed.

mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001

The block size is 8, with one block.

mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236df1d20c

The ADMA error is a descriptor error at address 0x000000236df1d20c.
The descriptor table contains (including the following entry):

mmc0: sdhci: 236df1d200: DMA 0x000000236d40e980, LEN 0x0008, Attr=0x23
mmc0: sdhci: 236df1d20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x00

The descriptor table contains one descriptor of 8 bytes, is marked
as the last (END bit set) and is at DMA address 0x236df1d200.  The
following descriptor is empty, with VALID=0.

One may be tempted to blame it on the following descriptor, but having
had another example on eMMC while userspace was booting (rootfs on
eMMC):

mmc1: ADMA error: 0x02000000
mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000099
mmc1: sdhci: ADMA Err:  0x00000006 | ADMA Ptr: 0x000000236dbfa26c
mmc1: sdhci: 236dbfa200: DMA 0x000000236c25c000, LEN 0x2000, Attr=0x21
mmc1: sdhci: 236dbfa20c: DMA 0x000000236938c000, LEN 0x0000, Attr=0x21
mmc1: sdhci: 236dbfa218: DMA 0x000000236939c000, LEN 0x5000, Attr=0x21
mmc1: sdhci: 236dbfa224: DMA 0x0000002368545000, LEN 0x1000, Attr=0x21
mmc1: sdhci: 236dbfa230: DMA 0x00000023684f1000, LEN 0x1000, Attr=0x21
mmc1: sdhci: 236dbfa23c: DMA 0x0000002368504000, LEN 0x2000, Attr=0x21
mmc1: sdhci: 236dbfa248: DMA 0x0000002368546000, LEN 0x2000, Attr=0x21
mmc1: sdhci: 236dbfa254: DMA 0x00000023684f2000, LEN 0x2000, Attr=0x21
mmc1: sdhci: 236dbfa260: DMA 0x0000002368500000, LEN 0x1000, Attr=0x23
mmc1: sdhci: 236dbfa26c: DMA 0x000000236b55d000, LEN 0x1000, Attr=0x21

... which is interesting for several reasons:
- The ADMA error register indicates a length mismatch error.  The
  transfer was for 0x99 blocks of 0x200, which is 0x13200 bytes.
  Summing the ADMA lengths up to the last descriptor (length=0 is
  0x10000 bytes) gives 0x20000 bytes.  So the DMA table contains more
  bytes than the requested transfer.

- The ADMA error register indicates ST_CADR, which is described as
  "This state is never set because do not generate ADMA error in this
  state."

- The error descriptor is again after the descriptor with END=1, but
  this time has VALID=1.

This _feels_ like a coherency issue, where the SDHCI engine is not
correctly seeing the descriptor table, but then I would have expected
userspace (which is basically debian stable) to fail to boot every
time given that its rootfs is on eMMC.

The other weird thing is if I wind the core MMC code back via:

$ git diff -u 7559d612dff0..v5.3 drivers/mmc/core | patch -p1 -R

and fix the lack of dma_max_pfn(), then SDHCI is more stable - not
completely stable, but way better than plain v5.3.  I don't see
much in that diff which would be responsible for this - although it
does seem that hch's DMA changes do make the problem more likely.
(going from 1 in 3 boots with a problem to being not able to boot.)

Note, with v5.2, I _never_ saw any ADMA errors, except if I disabled
bypass mode on the IOMMU (but then I saw global smmu errors right
from when the IOMMU had bypass disabled before MMC was probed - the
reason being is the SoC is not currently setup to have the MMU
bypass mode disabled.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
