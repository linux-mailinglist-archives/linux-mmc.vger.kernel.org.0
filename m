Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB3B7B73
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfISOCo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 10:02:44 -0400
Received: from foss.arm.com ([217.140.110.172]:58948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732385AbfISOCm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Sep 2019 10:02:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 765EA337;
        Thu, 19 Sep 2019 07:02:42 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55E443F59C;
        Thu, 19 Sep 2019 07:02:41 -0700 (PDT)
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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
 <20190919091601.GH25745@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <20fe58a0-f0ed-733b-87fb-47d667094491@arm.com>
Date:   Thu, 19 Sep 2019 15:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190919091601.GH25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/09/2019 10:16, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 03:03:29PM +0100, Robin Murphy wrote:
>> On 17/09/2019 14:49, Russell King - ARM Linux admin wrote:
>>> As already replied, v4 mode is not documented as being available on
>>> the LX2160A - the bit in the control register is marked as "reserved".
>>> This is as expected as it is documented that it is using a v3.00 of
>>> the SDHCI standard, rather than v4.00.
>>>
>>> So, sorry, enabling "v4 mode" isn't a workaround in this scenario.
>>>
>>> Given that v4 mode is not mandatory, this shouldn't be a work-around.
>>>
>>> Given that it _does_ work some of the time with the table >4GB, then
>>> this is not an addressing limitation.
>>
>> Yes, that's what "something totally different" usually means.
>>
>>>> However, the other difference between getting a single page directly from
>>>> the page allocator vs. the CMA area is that accesses to the linear mapping
>>>> of the CMA area are probably pretty rare, whereas for the single-page case
>>>> it's much more likely that kernel tasks using adjacent pages could lead to
>>>> prefetching of the descriptor page's cacheable alias. That could certainly
>>>> explain how reverting that commit manages to hide an apparent coherency
>>>> issue.
>>>
>>> Right, so how do we fix this?
>>
>> By describing the hardware correctly in the DT.
> 
> It would appear that it _is_ correctly described given the default
> hardware configuration, but the driver sets a bit in a control
> register that enables cache snooping.

Oh, fun. FWIW, the more general form of that statement would be "by 
ensuring that the device behaviour and the DT description are 
consistent", it's just rare to have both degrees of freedom.

Even in these cases, though, it tends to be ultimately necessary to 
defer to what the DT says, because there can be situations where the IP 
believes itself capable of enabling snoops, but the integration failed 
to wire things up correctly for them to actually work. I know we have to 
deal with that in arm-smmu, for one example.

> Adding "dma-coherent" to the DT description does not seem to be the
> correct solution, as we are reliant on the DT description and driver
> implementation both agreeing, which is fragile.
> 
>  From what I can see, there isn't a way for a driver to say "I've made
> this device is coherent now" and I suspect making the driver set the
> DMA snoop bit depending on whether "dma-coherent" is present in DT or
> not will cause data-corrupting regressions for other people.
> 
> So, we're back to where we started - what is the right solution to
> this problem?
> 
> The only thing I can think is that the driver needs to do something
> like:
> 
> 	WARN_ON(!dev_is_dma_coherent(dev));
> 
> in esdhc_of_enable_dma() as a first step, and ensuring that the snoop
> bit matches the state of dev_is_dma_coherent(dev)?  Is it permitted to
> use dev_is_dma_coherent() in drivers - it doesn't seem to be part of
> the normal DMA API?

The safest option would be to query the firmware property layer via 
device_get_dma_attr() - or potentially short-cut to of_dma_is_coherent() 
for a pure DT driver. Even disregarding API purity, I don't think the 
DMA API internals are really generic enough yet to reliably poke at 
(although FWIW, *certain* cases like dma_direct_ops would now actually 
work as expected if one did the unspeakable and flipped 
dev->dma_coherent from a driver, but that would definitely not win any 
friends).

Robin.
