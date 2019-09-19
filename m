Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929D2B7FF2
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfISRYL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 13:24:11 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49284 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfISRYL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 13:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sSibWnKXQWtqd/61TIWuX3iRn1c+XivvSzSlzh5qxTk=; b=ryFZK5KHpLurRzWIeNpifTJxC
        vwYfdOjMwzyXAymiRPCQbw8noMjKSvQvVyOaQGY26bGuOtIgnUjA6Wg26y1xFmqD55u6H5tR0iH29
        +7NLUgdHJy5vQlxDuAGBB1AAKEgAldHiG+iC3fwuYNYTA5HGt4BflSvKfX6XSpM33oFHB+m7pGmSi
        xYfhbzmIIAu+T6pQAWogLgVkDBjJ5f4yMPeBvm9nu8QkzmSDGaT+rmx5lFfROZO2SR7Q375g3zOoM
        y4DGtbpku6emW8I0w/1oNeBJAAfNYAbktrG8hKdu3s+lSHHjHpulFcyATuD8SnGERS1lbLGJtCPsL
        G3gTcRwtA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:34016)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iB09q-0007Tf-OS; Thu, 19 Sep 2019 18:23:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iB09l-0003Px-U8; Thu, 19 Sep 2019 18:23:49 +0100
Date:   Thu, 19 Sep 2019 18:23:49 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190919172349.GJ25745@shell.armlinux.org.uk>
References: <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <c12e21c3-6bef-38ed-3693-b958be17d555@arm.com>
 <20190917134947.GS25745@shell.armlinux.org.uk>
 <ab90e9a4-052d-5a7b-bfae-f2f02f17f1b7@arm.com>
 <20190919091601.GH25745@shell.armlinux.org.uk>
 <20fe58a0-f0ed-733b-87fb-47d667094491@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fe58a0-f0ed-733b-87fb-47d667094491@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 19, 2019 at 03:02:39PM +0100, Robin Murphy wrote:
> On 19/09/2019 10:16, Russell King - ARM Linux admin wrote:
> > On Tue, Sep 17, 2019 at 03:03:29PM +0100, Robin Murphy wrote:
> > > On 17/09/2019 14:49, Russell King - ARM Linux admin wrote:
> > > > As already replied, v4 mode is not documented as being available on
> > > > the LX2160A - the bit in the control register is marked as "reserved".
> > > > This is as expected as it is documented that it is using a v3.00 of
> > > > the SDHCI standard, rather than v4.00.
> > > > 
> > > > So, sorry, enabling "v4 mode" isn't a workaround in this scenario.
> > > > 
> > > > Given that v4 mode is not mandatory, this shouldn't be a work-around.
> > > > 
> > > > Given that it _does_ work some of the time with the table >4GB, then
> > > > this is not an addressing limitation.
> > > 
> > > Yes, that's what "something totally different" usually means.
> > > 
> > > > > However, the other difference between getting a single page directly from
> > > > > the page allocator vs. the CMA area is that accesses to the linear mapping
> > > > > of the CMA area are probably pretty rare, whereas for the single-page case
> > > > > it's much more likely that kernel tasks using adjacent pages could lead to
> > > > > prefetching of the descriptor page's cacheable alias. That could certainly
> > > > > explain how reverting that commit manages to hide an apparent coherency
> > > > > issue.
> > > > 
> > > > Right, so how do we fix this?
> > > 
> > > By describing the hardware correctly in the DT.
> > 
> > It would appear that it _is_ correctly described given the default
> > hardware configuration, but the driver sets a bit in a control
> > register that enables cache snooping.
> 
> Oh, fun. FWIW, the more general form of that statement would be "by ensuring
> that the device behaviour and the DT description are consistent", it's just
> rare to have both degrees of freedom.
> 
> Even in these cases, though, it tends to be ultimately necessary to defer to
> what the DT says, because there can be situations where the IP believes
> itself capable of enabling snoops, but the integration failed to wire things
> up correctly for them to actually work. I know we have to deal with that in
> arm-smmu, for one example.
> 
> > Adding "dma-coherent" to the DT description does not seem to be the
> > correct solution, as we are reliant on the DT description and driver
> > implementation both agreeing, which is fragile.
> > 
> >  From what I can see, there isn't a way for a driver to say "I've made
> > this device is coherent now" and I suspect making the driver set the
> > DMA snoop bit depending on whether "dma-coherent" is present in DT or
> > not will cause data-corrupting regressions for other people.
> > 
> > So, we're back to where we started - what is the right solution to
> > this problem?
> > 
> > The only thing I can think is that the driver needs to do something
> > like:
> > 
> > 	WARN_ON(!dev_is_dma_coherent(dev));
> > 
> > in esdhc_of_enable_dma() as a first step, and ensuring that the snoop
> > bit matches the state of dev_is_dma_coherent(dev)?  Is it permitted to
> > use dev_is_dma_coherent() in drivers - it doesn't seem to be part of
> > the normal DMA API?
> 
> The safest option would be to query the firmware property layer via
> device_get_dma_attr() - or potentially short-cut to of_dma_is_coherent() for
> a pure DT driver. Even disregarding API purity, I don't think the DMA API
> internals are really generic enough yet to reliably poke at (although FWIW,
> *certain* cases like dma_direct_ops would now actually work as expected if
> one did the unspeakable and flipped dev->dma_coherent from a driver, but
> that would definitely not win any friends).

So, I prepared a few options, and option 2 was:

 drivers/mmc/host/sdhci-of-esdhc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4dd43b1adf2c..8076a1322499 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/ktime.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include "sdhci-pltfm.h"
@@ -495,7 +496,12 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
-	value |= ESDHC_DMA_SNOOP;
+
+	if (dev_is_dma_coherent(dev))
+		value |= ESDHC_DMA_SNOOP;
+	else
+		value &= ~ESDHC_DMA_SNOOP;
+
 	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
 	return 0;
 }

The dev_is_dma_coherent() could be changed to something like
device_get_dma_attr() if that's the correct thing to base this
off of.  However, if it returns DEV_DMA_NOT_SUPPORTED, then what?
Assume non-coherent or assume coherent?  What will the DMA API
layer assume?

It seems to me that we want the DMA API layer and the driver to
both agree whether the device is to be coherent or not, and for
the sake of data integrity, we do not want any possibility for
them to deviate in that decision making process.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
