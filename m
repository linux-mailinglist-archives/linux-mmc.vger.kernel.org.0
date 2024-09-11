Return-Path: <linux-mmc+bounces-3848-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03151975590
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C5B28B0F4
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48D1A3054;
	Wed, 11 Sep 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJc0332n"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94271A302C;
	Wed, 11 Sep 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065264; cv=none; b=iokmq8FW0GYwPHR6uWFWjDC2Gv1R+qsl/CR3dT1QMBFtRBLM9QZ3pfqxZ4989AU1HWHxIPL7R6R1i+F4rRmVEf2lKs1OP4rjWEAuYHmYB7fIIMjNYy6qMN04gv1/adCIJHLL9m76cGYI6pVErVEvdrqE1i+clsyynAJWS1dw460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065264; c=relaxed/simple;
	bh=kGMNMbsdtI/Td/R/etzIT6Mtsyt0uxPTgnh5Weutbqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NY/OYUw0HaSF/SDQxCvn9uSjb9RYFjXM4iGdSGUN5CYdP42JesrnsORxM9iVD92rHlZRnwMbgJ2j3GtnapnEeAYLV1B8DA+laBoRr6dRYkh/MuX5N4D7tz3YHvk31xLTRJdSItpHEf+HitHNSq+Wk4QIJ4StPUG7UbXEmdiG1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cJc0332n; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48BEYCjh127054;
	Wed, 11 Sep 2024 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726065252;
	bh=GheB2vtmOOF3bRfgJtOuX0KHFhkymAURM8K2SnfqvzM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cJc0332nQibh/bKf+ifGu8Rxe4Bo7v+WOhwvRFeIkqqSQkurAhd4RLRvgqdDnV5LD
	 riIew3NhuLe9pUpAesi0d9/JWLcV6mo5jd2U7/sF4Th4HnSl0dz40RhOBlM4ynp/ua
	 7v74iTgLVpRqvLEtPTKqoyfoi6thGyRZijo8XBC4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48BEYCIa001968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Sep 2024 09:34:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 09:34:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 09:34:11 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48BEYBxa083039;
	Wed, 11 Sep 2024 09:34:11 -0500
Message-ID: <9c5e5c33-9fac-4240-8e30-de401e781324@ti.com>
Date: Wed, 11 Sep 2024 09:34:11 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240906175032.1580281-1-jm@ti.com>
 <068093ed-1ab5-40d6-b709-cd6810825ba3@intel.com>
 <cce6ec2f-3293-4f08-a965-76dece0ddfab@ti.com>
 <b154b9b3-cb74-4a51-953c-d4328f992898@intel.com>
 <091d7920-e197-4e14-af0c-8932af92a9dd@ti.com>
 <a1370ddf-febd-40fd-8f17-bc70e7fa850c@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <a1370ddf-febd-40fd-8f17-bc70e7fa850c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 9/11/24 12:17 AM, Adrian Hunter wrote:
> On 11/09/24 02:22, Judith Mendez wrote:
>> Hi Adrian,
>>
>> On 9/10/24 12:10 PM, Adrian Hunter wrote:
>>> On 10/09/24 17:30, Judith Mendez wrote:
>>>> Hi Adrian,
>>>>
>>>> On 9/9/24 1:26 AM, Adrian Hunter wrote:
>>>>> On 6/09/24 20:50, Judith Mendez wrote:
>>>>>> The sdhci_start_signal_voltage_switch function sets
>>>>>> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
>>>>>> V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
>>>>>> edge or pos edge of clock.
>>>>>>
>>>>>> Due to some eMMC and SD failures seen across am62x platform,
>>>>>> do not set V1P8_SIGNAL_ENA by default, only enable the bit
>>>>>> for devices that require this bit in order to switch to 1v8
>>>>>> voltage for uhs modes.
>>>>>>
>>>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>>>> ---
>>>>>>     drivers/mmc/host/sdhci_am654.c | 86 ++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 86 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>>>> index 0aa3c40ea6ed8..fb6232e56606b 100644
>>>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>>>> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>>>>>>         u32 tuning_loop;
>>>>>>       #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>>>>> +#define SDHCI_AM654_QUIRK_SET_V1P8_ENA BIT(1)
>>>>>
>>>>> It would be better for the quirk to represent the deviation
>>>>> from normal i.e.
>>>>>
>>>>> #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>>>>>
>>>>>>     };
>>>>>>       struct window {
>>>>>> @@ -356,6 +357,79 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>>>>>         sdhci_set_clock(host, clock);
>>>>>>     }
>>>>>>     +int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
>>>>>> +                        struct mmc_ios *ios)
>>>>>
>>>>> Simpler to call sdhci_start_signal_voltage_switch() for the normal
>>>>> case e.g.
>>>>
>>>> This is simpler, so sure will use thanks.
>>>>
>>>>>
>>>>> static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>> {
>>>>>       struct sdhci_host *host = mmc_priv(mmc);
>>>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>>
>>>>>
>>>>>       if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
>>>>>           ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
>>>>>           ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>>>           if (ret < 0) {
>>>>>               pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>>>>                   mmc_hostname(mmc));
>>>>>               return -EIO;
>>>>>           }
>>>>>           return 0;
>>>>>       }
>>>>>
>>>>>       return sdhci_start_signal_voltage_switch(mmc, ios);
>>>>> }
>>>>>
>>>>>> +{
>>>>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +    struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>>> +    u16 ctrl;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    if (host->version < SDHCI_SPEC_300)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    switch (ios->signal_voltage) {
>>>>>> +    case MMC_SIGNAL_VOLTAGE_330:
>>>>>> +        if (!(host->flags & SDHCI_SIGNALING_330))
>>>>>> +            return -EINVAL;
>>>>>> +
>>>>>> +        ctrl &= ~SDHCI_CTRL_VDD_180;
>>>>>> +        sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>>>> +
>>>>>> +        if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> +            ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>>>> +            if (ret < 0) {
>>>>>> +                pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>>>>>> +                    mmc_hostname(mmc));
>>>>>> +                return -EIO;
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +        usleep_range(5000, 5500);
>>>>>> +
>>>>>> +        ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> +        if (!(ctrl & SDHCI_CTRL_VDD_180))
>>>>>> +            return 0;
>>>>>> +
>>>>>> +        pr_warn("%s: 3.3V regulator output did not become stable\n",
>>>>>> +            mmc_hostname(mmc));
>>>>>> +
>>>>>> +        return -EAGAIN;
>>>>>> +
>>>>>> +    case MMC_SIGNAL_VOLTAGE_180:
>>>>>> +        if (!(host->flags & SDHCI_SIGNALING_180))
>>>>>> +            return -EINVAL;
>>>>>> +
>>>>>> +        if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>>> +            ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>>>> +            if (ret < 0) {
>>>>>> +                pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>>>>> +                    mmc_hostname(mmc));
>>>>>> +                return -EIO;
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +        if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_SET_V1P8_ENA) {
>>>>>> +            ctrl |= SDHCI_CTRL_VDD_180;
>>>>>> +            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>>>> +
>>>>>> +            ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> +            if (ctrl & SDHCI_CTRL_VDD_180)
>>>>>> +                return 0;
>>>>>> +
>>>>>> +            pr_warn("%s: 1.8V regulator output did not become stable\n",
>>>>>> +                mmc_hostname(mmc));
>>>>>> +
>>>>>> +            return -EAGAIN;
>>>>>> +        }
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    default:
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>     static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>>>>>>     {
>>>>>>         writeb(val, host->ioaddr + reg);
>>>>>> @@ -801,6 +875,8 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>>>>>                         struct sdhci_am654_data *sdhci_am654)
>>>>>>     {
>>>>>>         struct device *dev = &pdev->dev;
>>>>>> +    struct device_node *np = dev->of_node;
>>>>>> +    struct device_node *node;
>>>>>>         int drv_strength;
>>>>>>         int ret;
>>>>>>     @@ -844,6 +920,15 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>>>>>         if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>>>>>>             sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>>>>>>     +    node = of_parse_phandle(np, "vmmc-supply", 0);
>>>>>> +
>>>>>> +    if (node) {
>>>>>> +        node = of_parse_phandle(np, "vqmmc-supply", 0);
>>>>>> +
>>>>>> +        if (!node)
>>>>>> +            sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SET_V1P8_ENA;
>>>>>> +    }
>>>>>
>>>>> It would be simpler without 'np' and 'node'.  Not sure
>>>>> what the rule is meant to be, but it could be something like:
>>>>>
>>>>>       if (of_parse_phandle(dev->of_node, "vmmc-supply", 0) &&
>>>>>           of_parse_phandle(dev->of_node, "vqmmc-supply", 0)
>>>>>           sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
>>>>
>>>> My issue with this is that I also need the quirk (SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) for eMMC. DT node for eMMC does
>>>> not include vmmc and vqmmc supplies. That is why I had the quirk logic
>>>> inverted.
>>>
>>> Ideally there would be a more direct way to distinguish eMMC, but
>>> otherwise, having both supplies or neither would be:
>>>
>>>      if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
>>>          !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
>>>          sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
>>
>>
>> Not sure I love the double NOT, but ok, I can use this, will fix for v2.
> 
> It could use a comment, including about the eMMC thing.


Sure, will add. Thanks.

> 
>>
>> Thanks for your suggestion!
>>
>> ~ Judith
>>
>>>
>>>
>>>>
>>>> This patch fixes timing issues with both eMMC and SD. (:
>>>>
>>>> ~ Judith
>>>>
>>>>
>>>>>
>>>>>> +
>>>>>>         sdhci_get_of_property(pdev);
>>>>>>           return 0;
>>>>>> @@ -940,6 +1025,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>>>>>             goto err_pltfm_free;
>>>>>>         }
>>>>>>     +    host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>>>>>>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>>>>>           pm_runtime_get_noresume(dev);
>>>>>>
>>>>>> base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
>>>>>
>>>>>
>>>>
>>>
>>
> 


