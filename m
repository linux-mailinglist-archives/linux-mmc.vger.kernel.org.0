Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1860FB7601
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfISJQY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 05:16:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43316 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfISJQY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 05:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gcackV6/ntk25fLVDg+/3GMlkOdJHRaLK52EuisvhNw=; b=O7KxtSuypM80Sg1q+Y+IupZwf
        lJoPW423/CXcVb21ifRT1VV/t2uaPRoChymSJv935sEjHfmAbWS6UfX+pC/aAW/qM2KDLuN3Hr6mU
        mKNjO3YiUw9XxBHWz/yh+kmr2C+SuwNo0DkQ7CBYm2NtKU0aC9R+UFJaMyzo7IXjjeDg+uO5gBrE+
        Ep18aBBYayjQJLfvTkq5nF0CExRE/chQHOykryvtNBLgBTxGLQeW4YFozwe/MOvCIJQvDDTkStaE8
        PcK6wrkT5SycS95riJHP7EzH29vgu3SHjdN7GA/ZIqWNm3abgLjXmNA563nOTjlvedwq1y/0iyuiI
        pKwGdxH3A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33876)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAsXo-0005CO-JQ; Thu, 19 Sep 2019 10:16:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAsXh-00038v-Rk; Thu, 19 Sep 2019 10:16:01 +0100
Date:   Thu, 19 Sep 2019 10:16:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>, "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190919091601.GH25745@shell.armlinux.org.uk>
References: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <c12e21c3-6bef-38ed-3693-b958be17d555@arm.com>
 <20190917134947.GS25745@shell.armlinux.org.uk>
 <ab90e9a4-052d-5a7b-bfae-f2f02f17f1b7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab90e9a4-052d-5a7b-bfae-f2f02f17f1b7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 03:03:29PM +0100, Robin Murphy wrote:
> On 17/09/2019 14:49, Russell King - ARM Linux admin wrote:
> > As already replied, v4 mode is not documented as being available on
> > the LX2160A - the bit in the control register is marked as "reserved".
> > This is as expected as it is documented that it is using a v3.00 of
> > the SDHCI standard, rather than v4.00.
> > 
> > So, sorry, enabling "v4 mode" isn't a workaround in this scenario.
> > 
> > Given that v4 mode is not mandatory, this shouldn't be a work-around.
> > 
> > Given that it _does_ work some of the time with the table >4GB, then
> > this is not an addressing limitation.
> 
> Yes, that's what "something totally different" usually means.
> 
> > > However, the other difference between getting a single page directly from
> > > the page allocator vs. the CMA area is that accesses to the linear mapping
> > > of the CMA area are probably pretty rare, whereas for the single-page case
> > > it's much more likely that kernel tasks using adjacent pages could lead to
> > > prefetching of the descriptor page's cacheable alias. That could certainly
> > > explain how reverting that commit manages to hide an apparent coherency
> > > issue.
> > 
> > Right, so how do we fix this?
> 
> By describing the hardware correctly in the DT.

It would appear that it _is_ correctly described given the default
hardware configuration, but the driver sets a bit in a control
register that enables cache snooping.

Adding "dma-coherent" to the DT description does not seem to be the
correct solution, as we are reliant on the DT description and driver
implementation both agreeing, which is fragile.

From what I can see, there isn't a way for a driver to say "I've made
this device is coherent now" and I suspect making the driver set the
DMA snoop bit depending on whether "dma-coherent" is present in DT or
not will cause data-corrupting regressions for other people.

So, we're back to where we started - what is the right solution to
this problem?

The only thing I can think is that the driver needs to do something
like:

	WARN_ON(!dev_is_dma_coherent(dev));

in esdhc_of_enable_dma() as a first step, and ensuring that the snoop
bit matches the state of dev_is_dma_coherent(dev)?  Is it permitted to
use dev_is_dma_coherent() in drivers - it doesn't seem to be part of
the normal DMA API?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
