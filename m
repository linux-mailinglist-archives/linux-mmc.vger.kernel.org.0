Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA6B4F70
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfIQNiE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:38:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfIQNiE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 09:38:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A461928;
        Tue, 17 Sep 2019 06:38:02 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705893F575;
        Tue, 17 Sep 2019 06:38:01 -0700 (PDT)
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c12e21c3-6bef-38ed-3693-b958be17d555@arm.com>
Date:   Tue, 17 Sep 2019 14:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190917130759.GO25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/09/2019 14:07, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 01:33:26PM +0100, Russell King - ARM Linux admin wrote:
>> On Tue, Sep 17, 2019 at 12:42:10PM +0100, Russell King - ARM Linux admin wrote:
>>> On Tue, Sep 17, 2019 at 12:16:31PM +0100, Russell King - ARM Linux admin wrote:
>>>> On Tue, Sep 17, 2019 at 11:42:00AM +0100, Russell King - ARM Linux admin wrote:
>>>>> On Tue, Sep 17, 2019 at 09:19:31AM +0100, Russell King - ARM Linux admin wrote:
>>>>>> On Tue, Sep 17, 2019 at 10:06:12AM +0200, Marc Gonzalez wrote:
>>>>>>> On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:
>>>>>>>
>>>>>>>> The platform has an iommu, which is in pass-through mode, via
>>>>>>>> arm_smmu.disable_bypass=0.
>>>>>>>
>>>>>>> Could be 954a03be033c7cef80ddc232e7cbdb17df735663
>>>>>>> "iommu/arm-smmu: Break insecure users by disabling bypass by default"
>>>>>>>
>>>>>>> Although it had already landed in v5.2
>>>>>>
>>>>>> It is not - and the two lines that you quoted above are sufficient
>>>>>> to negate that as a cause.  (Please read the help for the option that
>>>>>> the commit referrs to.)
>>>>>>
>>>>>> In fact, with bypass disabled, the SoC fails due to other masters.
>>>>>> That's already been discussed privately between myself and Will
>>>>>> Deacon.
>>>>>>
>>>>>> arm_smmu.disable_bypass=0 re-enables bypass mode irrespective of
>>>>>> the default setting in the Kconfig.
>>>>>
>>>>> Adding some further debugging, and fixing the existing ADMA debugging
>>>>> shows:
>>>>>
>>>>> mmc0: ADMA error: 0x02000000
>>>>>
>>>>> So this is an ADMA error without the transfer having completed.
>>>>>
>>>>> mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
>>>>>
>>>>> The block size is 8, with one block.
>>>>>
>>>>> mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236df1d20c
>>>>>
>>>>> The ADMA error is a descriptor error at address 0x000000236df1d20c.
>>>>> The descriptor table contains (including the following entry):
>>>>>
>>>>> mmc0: sdhci: 236df1d200: DMA 0x000000236d40e980, LEN 0x0008, Attr=0x23
>>>>> mmc0: sdhci: 236df1d20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x00
>>>>>
>>>>> The descriptor table contains one descriptor of 8 bytes, is marked
>>>>> as the last (END bit set) and is at DMA address 0x236df1d200.  The
>>>>> following descriptor is empty, with VALID=0.
>>>>>
>>>>> One may be tempted to blame it on the following descriptor, but having
>>>>> had another example on eMMC while userspace was booting (rootfs on
>>>>> eMMC):
>>>>>
>>>>> mmc1: ADMA error: 0x02000000
>>>>> mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000099
>>>>> mmc1: sdhci: ADMA Err:  0x00000006 | ADMA Ptr: 0x000000236dbfa26c
>>>>> mmc1: sdhci: 236dbfa200: DMA 0x000000236c25c000, LEN 0x2000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa20c: DMA 0x000000236938c000, LEN 0x0000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa218: DMA 0x000000236939c000, LEN 0x5000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa224: DMA 0x0000002368545000, LEN 0x1000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa230: DMA 0x00000023684f1000, LEN 0x1000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa23c: DMA 0x0000002368504000, LEN 0x2000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa248: DMA 0x0000002368546000, LEN 0x2000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa254: DMA 0x00000023684f2000, LEN 0x2000, Attr=0x21
>>>>> mmc1: sdhci: 236dbfa260: DMA 0x0000002368500000, LEN 0x1000, Attr=0x23
>>>>> mmc1: sdhci: 236dbfa26c: DMA 0x000000236b55d000, LEN 0x1000, Attr=0x21
>>>>>
>>>>> ... which is interesting for several reasons:
>>>>> - The ADMA error register indicates a length mismatch error.  The
>>>>>    transfer was for 0x99 blocks of 0x200, which is 0x13200 bytes.
>>>>>    Summing the ADMA lengths up to the last descriptor (length=0 is
>>>>>    0x10000 bytes) gives 0x20000 bytes.  So the DMA table contains more
>>>>>    bytes than the requested transfer.
>>>>>
>>>>> - The ADMA error register indicates ST_CADR, which is described as
>>>>>    "This state is never set because do not generate ADMA error in this
>>>>>    state."
>>>>>
>>>>> - The error descriptor is again after the descriptor with END=1, but
>>>>>    this time has VALID=1.
>>>>>
>>>>> This _feels_ like a coherency issue, where the SDHCI engine is not
>>>>> correctly seeing the descriptor table, but then I would have expected
>>>>> userspace (which is basically debian stable) to fail to boot every
>>>>> time given that its rootfs is on eMMC.
>>>>>
>>>>> The other weird thing is if I wind the core MMC code back via:
>>>>>
>>>>> $ git diff -u 7559d612dff0..v5.3 drivers/mmc/core | patch -p1 -R
>>>>>
>>>>> and fix the lack of dma_max_pfn(), then SDHCI is more stable - not
>>>>> completely stable, but way better than plain v5.3.  I don't see
>>>>> much in that diff which would be responsible for this - although it
>>>>> does seem that hch's DMA changes do make the problem more likely.
>>>>> (going from 1 in 3 boots with a problem to being not able to boot.)
>>>>>
>>>>> Note, with v5.2, I _never_ saw any ADMA errors, except if I disabled
>>>>> bypass mode on the IOMMU (but then I saw global smmu errors right
>>>>> from when the IOMMU had bypass disabled before MMC was probed - the
>>>>> reason being is the SoC is not currently setup to have the MMU
>>>>> bypass mode disabled.)
>>>>
>>>> This looks like an ARM64 coherency issue.
>>>>
>>>> I first tried adding a dma_wmb() to the end of sdhci_adma_table_pre(),
>>>> which had no effect.  I then tried adding:
>>>>
>>>> +       __dma_flush_area(host->adma_table, desc - host->adma_table);
>>>> +       dma_wmb();
>>>>
>>>> and so far I haven't had any further ADMA errors.  Adding Will Deacon
>>>> to the thread.
>>>
>>> These are the changes to sdhci that I'm currently running.  I think
>>> some of the debugging related changes are probably worth adding to
>>> the driver, particularly printing the intmask on ADMA error (which
>>> is not printed by the register dump, as the value is lost) and printing
>>> the DMA addresses of the descriptor table entries which can be tied
>>> up with the DMA address error register.  Also, maybe printing the
>>> DMA descriptor table with the register dump, rather than having to
>>> resort to enabling debug would be a good idea?
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a5dc5aae973e..884dcaa9cad5 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -773,6 +773,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>>>   		/* Add a terminating entry - nop, end, valid */
>>>   		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
>>>   	}
>>> +	__dma_flush_area(host->adma_table, desc - host->adma_table);
>>> +	dma_wmb();
>>>   }
>>>   
>>>   static void sdhci_adma_table_post(struct sdhci_host *host,
>>> @@ -2855,6 +2857,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>>>   static void sdhci_adma_show_error(struct sdhci_host *host)
>>>   {
>>>   	void *desc = host->adma_table;
>>> +	dma_addr_t dma = host->adma_addr;
>>> +	bool end = false;
>>>   
>>>   	sdhci_dumpregs(host);
>>>   
>>> @@ -2862,21 +2866,26 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>>>   		struct sdhci_adma2_64_desc *dma_desc = desc;
>>>   
>>>   		if (host->flags & SDHCI_USE_64_BIT_DMA)
>>> -			DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
>>> -			    desc, le32_to_cpu(dma_desc->addr_hi),
>>> +			SDHCI_DUMP("%08llx: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
>>> +			    (unsigned long long)dma,
>>> +			    le32_to_cpu(dma_desc->addr_hi),
>>>   			    le32_to_cpu(dma_desc->addr_lo),
>>>   			    le16_to_cpu(dma_desc->len),
>>>   			    le16_to_cpu(dma_desc->cmd));
>>>   		else
>>> -			DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
>>> -			    desc, le32_to_cpu(dma_desc->addr_lo),
>>> +			SDHCI_DUMP("%08llx: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
>>> +			    (unsigned long long)dma,
>>> +			    le32_to_cpu(dma_desc->addr_lo),
>>>   			    le16_to_cpu(dma_desc->len),
>>>   			    le16_to_cpu(dma_desc->cmd));
>>>   
>>> +		if (end) break;
>>> +
>>>   		desc += host->desc_sz;
>>> +		dma += host->desc_sz;
>>>   
>>>   		if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
>>> -			break;
>>> +			end = true;
>>>   	}
>>>   }
>>>   
>>> @@ -2949,7 +2958,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>   			!= MMC_BUS_TEST_R)
>>>   		host->data->error = -EILSEQ;
>>>   	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>> -		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
>>> +		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc), intmask);
>>>   		sdhci_adma_show_error(host);
>>>   		host->data->error = -EIO;
>>>   		if (host->ops->adma_workaround)
>>
>> Further debug shows:
>>
>> coherent=0 - sdhci device is not cache coherent
>> swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000081cac000
>> [ffffff8010fd5200] pgd=000000237ffff003, pud=000000237ffff003,
>> pmd=000000237fffb003, pte=00e800236d62270f
>>
>> The mapping for the ADMA table seems to be using MAIR index 3, which is
>> MT_MEMORY_NC, so should be non-cacheable.
>>
>> vmallocinfo:
>> 0xffffff8010fd5000-0xffffff8010fd7000    8192 dma_direct_alloc+0x4c/0x54
>> user
>>
>> So this memory has been remapped.  Could there be an alias that has
>> cache lines still in the cache for the physical address, and could we
>> be hitting those cache lines while accessing through a non-cacheable
>> mapping?  (On 32-bit ARM, this is "unpredictable" and this problem
>> definitely _feels_ like it has unpredictable attributes!)
>>
>> Also, given that this memory is mapped NC, then surely
>> __dma_flush_area() should have no effect?  However, it _does_ have the
>> effect of reliably solving the problem, which to me implies that there
>> _are_ cache lines in this NC mapping.
> 
> Will suggested reverting bd2e75633c80 ("dma-contiguous: use fallback
> alloc_pages for single pages") which has been implicated in the same
> problem here:
> 
> https://www.spinics.net/lists/arm-kernel/msg750623.html
> 
> Although reverting the commit is not clean, this also fixes the issue
> for me.

Note that that one turned out to be something totally different, namely 
that the single-page allocations, in difference to CMA, came from 
physical addresses that the controller needed additional configuration 
to be able to access[1] - no amount of cache maintenance would affect that.

However, the other difference between getting a single page directly 
from the page allocator vs. the CMA area is that accesses to the linear 
mapping of the CMA area are probably pretty rare, whereas for the 
single-page case it's much more likely that kernel tasks using adjacent 
pages could lead to prefetching of the descriptor page's cacheable 
alias. That could certainly explain how reverting that commit manages to 
hide an apparent coherency issue.

Robin.

[1] https://lore.kernel.org/patchwork/patch/1121600/
