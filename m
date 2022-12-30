Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9C659581
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Dec 2022 07:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiL3Gna (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Dec 2022 01:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3Gn1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2022 01:43:27 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9192186A7
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 22:43:25 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 09B47851C7;
        Fri, 30 Dec 2022 07:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672382603;
        bh=rNOFhMwxUmywZCTp7LuVEHGSGhrwS33+RwXuYgvQzuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ltDj5muFSDSS45KvR6lKc7xZyeyDMbhrJH8AHATw7qOz8TH/pHQeNkyCgByEAJKtu
         NrvtVNhJ9Wm8hwi0ux7WP5QWzM9K51sXIEa0tTkneJqPcd0QTAEcGEIkrPmV1sk24a
         dP1yRn8VkM2MyaRCD9AZGBALv4JJ3LmihOoN7sXR9QipW06muDTqsKdiFRJ7x0HnbU
         nxS4K5uF2Stl2TukWGbnJG/kcmM6kX04hTVmNsVFrKvYBdUtk2HYl6C5Q/6IxFfDCu
         /oLZejzqpPLI4XKxkU2mfePhmDYLobNUJBn+dYH/ef18K/JN1EETbq4Gb8RM1RB/bm
         wmzPcOKs5OEDQ==
Message-ID: <8958eb65-e873-a760-5ca4-a51b36f5e23d@denx.de>
Date:   Fri, 30 Dec 2022 07:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
To:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <ebf570a1-3d2f-85d7-3a29-540caf9f576d@intel.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ebf570a1-3d2f-85d7-3a29-540caf9f576d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/29/22 13:51, Adrian Hunter wrote:
> On 26/10/22 12:20, Marek Vasut wrote:
>> On 10/26/22 08:07, Adrian Hunter wrote:
>>> On 25/10/22 22:15, Marek Vasut wrote:
>>>> On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>
>>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>> Absolute Address  0x00FF160040 (SD0)
>>>> Reset Value       0x280737EC6481
>>>>
>>>> really reads 0x200737EC6481 . The interesting part is the
>>>> top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>> missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>> makes the SDHCI core disable retuning timer.
>>>>
>>>> Fix this up here by explicitly setting tuning_count to 8
>>>> as it should be, otherwise an eMMC might fail in various
>>>> thermal conditions
>>>>
>>>> Note that the diff is best shown with -w option, this makes it
>>>> visible what happened with !sdhci_arasan->has_cqe conditional,
>>>> which is placed between sdhci_setup_host() and __sdhci_add_host()
>>>> calls. Since sdhci_add_host() is also a sequence of these two
>>>> calls and host->tuning_count must be overriden before calling
>>>
>>> overriden -> overridden
>>
>> Fixed
>>
>>>> __sdhci_add_host(), call the two calls separately and do all
>>>> the adjustments between them in either case.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> To: linux-mmc@vger.kernel.org
>>>> ---
>>>>    drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
>>>>    1 file changed, 38 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>>> index 3997cad1f793d..465498f2a7c0f 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>>>>        return 0;
>>>>    }
>>>>    -static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
>>>> +                 struct device *dev)
>>>>    {
>>>>        struct sdhci_host *host = sdhci_arasan->host;
>>>>        struct cqhci_host *cq_host;
>>>>        bool dma64;
>>>>        int ret;
>>>>    -    if (!sdhci_arasan->has_cqe)
>>>> -        return sdhci_add_host(host);
>>>> -
>>>>        ret = sdhci_setup_host(host);
>>>>        if (ret)
>>>>            return ret;
>>>>    -    cq_host = devm_kzalloc(host->mmc->parent,
>>>> -                   sizeof(*cq_host), GFP_KERNEL);
>>>> -    if (!cq_host) {
>>>> -        ret = -ENOMEM;
>>>> -        goto cleanup;
>>>> -    }
>>>> +    /*
>>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>> +     *
>>>> +     * https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>> +     * Absolute Address  0x00FF160040 (SD0)
>>>> +     * Reset Value         0x280737EC6481
>>>> +     *
>>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>> +     * makes the SDHCI core disable retuning timer.
>>>
>>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>>> "sdhci-caps-mask" ?
>>
>> No, I wasn't aware of those.
>>
>> Is that the preferred approach to this fix, over handling it in the driver ?
> 
> I guess ideally.  Mainline does not really need the driver
> fix because it seems it can be done by DT.  Older kernels
> are a separate issue really.
> 
>>
>> I think the driver-side fix would be preferable, because it also fixes systems which use legacy DTs without the sdhci-caps properties, which would be all ZynqMP systems thus far.
> 
> You could backport support of the properties "sdhci-caps"
> and "sdhci-caps-mask".

This won't help. Vivado (the xilinx FPGA design tool) is capable of 
generating DTs, so you can end up with a combination of new Linux kernel 
and old generated DT, which is still missing the 
sdhci-caps/sdhci-caps-mask .
