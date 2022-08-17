Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC059750A
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Aug 2022 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiHQRXN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Aug 2022 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiHQRXM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2022 13:23:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73B382980C;
        Wed, 17 Aug 2022 10:23:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53801063;
        Wed, 17 Aug 2022 10:23:10 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B1863F66F;
        Wed, 17 Aug 2022 10:23:08 -0700 (PDT)
Message-ID: <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
Date:   Wed, 17 Aug 2022 18:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-GB
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
References: <20220727164532.GA19351@plvision.eu>
 <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220817160730.GA17202@plvision.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-08-17 17:07, Vadym Kochan wrote:
> Hi Robin, Adrian,
> 
> On Wed, Aug 17, 2022 at 02:43:46PM +0100, Robin Murphy wrote:
>> On 2022-08-16 21:51, Vadym Kochan wrote:
>> [...]
>>>> The one thing to watch out for is that SWIOTLB doesn't necessarily interact
>>>> very well with DMA offsets. Given the intent of
>>>> of_dma_get_max_cpu_address(), I think it ought to work out OK now for
>>>> current kernels on DT systems if everything is described correctly, but
>>>> otherwise it's likely that you end up with ZONE_DMA either being empty or
>>>> containing all memory, so the SWIOTLB buffer ends up being allocated
>>>> anywhere such that it might not actually work as expected.
>>>>
>>>> Robin.
>>>
>>> Hi Robin,
>>>
>>> Thank you for the reply.
>>>
>>> My understanding is that swiotlb is allocated (in case of arm64)
>>> in the following cases:
>>>
>>>      #1 when it is forced from the kernel cmdline
>>>
>>>      #2 when max_pfn is greater than arm64_dma_phys_limit (and this is used
>>>         as the end from which to allocate the swiotlb pool in the
>>>         top-botom direction via memblock API).
>>>
>>>      #3 using restricted dma-pool
>>>
>>> Of course option #3 works fine because swiotlb is kind of forced to use
>>> particulary this range of memory.
>>>
>>> Both options #1 & #2 causes to use full memory mask even if to specify
>>> dma-ranges in the DT:
>>>
>>>       dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
>>>
>>> or if to specify the opposite:
>>>
>>>       dma-ranges = <0x2 0x0 0x0 0x0 0x0 0x80000000>;
>>>
>>>       just to make it lower than U32 to pass
>>>
>>>           zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits)
>>>
>>>       condition, but then it will be re-set in max_zone_phys() by:
>>>
>>> 	if (phys_start > U32_MAX)
>>> 		zone_mask = PHYS_ADDR_MAX;
>>> 	else if (phys_start > zone_mask)
>>> 		zone_mask = U32_MAX;
>>
>> Ah, indeed I missed that, sorry. It seems that that change to stop assuming
>> an offset kind of crossed over with the introduction of
>> *_dma_get_max_cpu_address(), but now that that firmware property parsing
>> *is* implemented, in principle it should be equally possible to evaluate the
>> actual offsets as well, and decide whether an offset ZONE_DMA is appropriate
>> or not. Either way, this is definitely the area which needs work if we want
>> to to able to support topologies like this properly.
>>
>>> So, currently I dont see how to pin swiotlb (I see it as a main problem) to some specific range of physical
>>> memory (particulary to the first 2G of RAM).
>>
>> Indeed, if ZONE_DMA and/or ZONE_DMA32 can't be set appropriately, then
>> there's no way to guarantee correct allocation of any DMA buffers, short of
>> hacking it with explicitly placed reserved-memory carveouts.
>>
> 
> I have sent some time ago a solution which binds restricted-dma pool to
> the eMMC device, so Adrian, Robin do you think this can be acceptable as
> a temporary solution (at least conceptually) ?
> 
> I was also thinking would it be OK to introduce something like
> bounced-dma pool (similar to the restricted one) which will reserve
> memory for the bounced buffers only ? It should not be hard as looks
> like it will re-use existing interface between dma and swiotlb ? In that
> case it would allow to map first 2G of memory to eMMC controller.

TBH I'd prefer to fix it (or at least work around it) more generally.
Putting made-up things in devicetree to work around shortcomings in
kernel code tends to be a hole that's hard to dig yourself back out of.
As a bodge that would be just about justifiable in its own terms, does
the diff below help at all?

Thanks,
Robin.

----->8-----
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b9af30be813e..88f7b26f49db 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -451,7 +451,14 @@ void __init bootmem_init(void)
   */
  void __init mem_init(void)
  {
+	/*
+	 * Some platforms still manage to elude our attempt to calculate
+	 * ZONE_DMA appropriately, so encourage the SWIOTLB allocation to go
+	 * as low as it can anyway for the best chance of being usable.
+	 */
+	memblock_set_bottom_up(true);
  	swiotlb_init(max_pfn > PFN_DOWN(arm64_dma_phys_limit), SWIOTLB_VERBOSE);
+	memblock_set_bottom_up(false);
  
  	/* this will put all unused low memory onto the freelists */
  	memblock_free_all();
