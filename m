Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB51EE2CB
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDOpV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 09:45:21 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:33881 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDOpU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 09:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572878714;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BB2ap7qMcOQPaAUjvQiQp65120KVs8wsApOjC50LPr8=;
        b=VLPrK6rHRvWdJAhAISsRkKXahALUUR4XN6VG7ugSRHHt2wHlhk1PHyorYrGmlbYBhY
        nmtOVTbx1hEVAUEQ+koMrE9u5/XqbgWL1i85l2+xHfScaqjlyWvHRNBpTJCiq5/vHj3J
        XW/W4Lc/8BXZVWRcNcMrYXGWz97959erBubSHlgv+Sy0sVYP1mQmYXFqSw+EZhy5MrR1
        UldEq26xenw+34r5vW5eYcJCLXx8cnb0IsN55mBXQ48G6QMWbv8gH4zhiukZ5VK+YoEP
        LNNYfjx6qcDO4JEOGxzhIYI0tD+pORpZMfpTjAL6yZPCjlSu5zPV+5ZNQw1pAvi37A25
        HdpA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhRLvD1C7gwmlA7f0DygmF7yo72KQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:2873:af5c:c097:9730]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vA4EiadWs
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 4 Nov 2019 15:44:36 +0100 (CET)
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <AD53973C-4491-4114-9CEE-81F516EF6249@xenosoft.de>
Message-ID: <668ae8d5-f9f9-6304-d389-a854da53c2d2@xenosoft.de>
Date:   Mon, 4 Nov 2019 15:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AD53973C-4491-4114-9CEE-81F516EF6249@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

FYI: The onboard SD card works also with the RC6 of kernel 5.4 with the 
patch below.

-- Christian

On 23 October 2019 at 4:20pm, Christian Zigotzky wrote:
> Hello,
>
> The patch below works. I compiled the RC4 of kernel 5.4 with this patch today and the onboard SD card works without any problems.
>
> Thanks!
>
> Christian
>
>> On 23. Oct 2019, at 07:42, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>>>> On Tue, Oct 15, 2019 at 03:12:49PM +0200, Christian Zigotzky wrote:
>>>> Hello Russell,
>>>>
>>>> You asked me about "dma-coherent" in the Cyrus device tree. Unfortunately I
>>>> don't find the property "dma-coherent" in the dtb source files.
>>>>
>>>> Output of "fdtdump cyrus_p5020_eth_poweroff.dtb | grep dma":
>>>>
>>>> dma0 = "/soc@ffe000000/dma@100300";
>>>>          dma1 = "/soc@ffe000000/dma@101300";
>>>>          dma@100300 {
>>>>              compatible = "fsl,eloplus-dma";
>>>>              dma-channel@0 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@80 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@100 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@180 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>          dma@101300 {
>>>>              compatible = "fsl,eloplus-dma";
>>>>              dma-channel@0 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@80 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@100 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>>>              dma-channel@180 {
>>>>                  compatible = "fsl,eloplus-dma-channel";
>>> Hmm, so it looks like PowerPC doesn't mark devices that are dma
>>> coherent with a property that describes them as such.
>>>
>>> I think this opens a wider question - what should of_dma_is_coherent()
>>> return for PowerPC?  It seems right now that it returns false for
>>> devices that are DMA coherent, which seems to me to be a recipe for
>>> future mistakes.
>> Right, it seems of_dma_is_coherent() has baked in the assumption that
>> devices are non-coherent unless explicitly marked as coherent.
>>
>> Which is wrong on all or at least most existing powerpc systems
>> according to Ben.
>>
>>> Any ideas from the PPC maintainers?
>> Fixing it at the source seems like the best option to prevent future
>> breakage.
>>
>> So I guess that would mean making of_dma_is_coherent() return true/false
>> based on CONFIG_NOT_COHERENT_CACHE on powerpc.
>>
>> We could do it like below, which would still allow the dma-coherent
>> property to work if it ever makes sense on a future powerpc platform.
>>
>> I don't really know any of this embedded stuff well, so happy to take
>> other suggestions on how to handle this mess.
>>
>> cheers
>>
>>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 25aaa3903000..b96c9010acb6 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -760,6 +760,22 @@ static int __init check_cache_coherency(void)
>> late_initcall(check_cache_coherency);
>> #endif /* CONFIG_CHECK_CACHE_COHERENCY */
>>
>> +#ifndef CONFIG_NOT_COHERENT_CACHE
>> +/*
>> + * For historical reasons powerpc kernels are built with hard wired knowledge of
>> + * whether or not DMA accesses are cache coherent. Additionally device trees on
>> + * powerpc do not typically support the dma-coherent property.
>> + *
>> + * So when we know that DMA is coherent, override arch_of_dma_is_coherent() to
>> + * tell the drivers/of code that all devices are coherent regardless of whether
>> + * they have a dma-coherent property.
>> + */
>> +bool arch_of_dma_is_coherent(struct device_node *np)
>> +{
>> +    return true;
>> +}
>> +#endif
>> +
>> #ifdef CONFIG_DEBUG_FS
>> struct dentry *powerpc_debugfs_root;
>> EXPORT_SYMBOL(powerpc_debugfs_root);
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 978427a9d5e6..3a4b2949a322 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -993,6 +993,14 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>> }
>> EXPORT_SYMBOL_GPL(of_dma_get_range);
>>
>> +/*
>> + * arch_of_dma_is_coherent - Arch hook to determine if device is coherent for DMA
>> + */
>> +bool __weak arch_of_dma_is_coherent(struct device_node *np)
>> +{
>> +    return false;
>> +}
>> +
>> /**
>>   * of_dma_is_coherent - Check if device is coherent
>>   * @np:    device node
>> @@ -1002,8 +1010,12 @@ EXPORT_SYMBOL_GPL(of_dma_get_range);
>>   */
>> bool of_dma_is_coherent(struct device_node *np)
>> {
>> -    struct device_node *node = of_node_get(np);
>> +    struct device_node *node;
>> +
>> +    if (arch_of_dma_is_coherent(np))
>> +        return true;
>>
>> +    np = of_node_get(np);
>>     while (node) {
>>         if (of_property_read_bool(node, "dma-coherent")) {
>>             of_node_put(node);

