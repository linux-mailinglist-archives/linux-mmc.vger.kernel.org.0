Return-Path: <linux-mmc+bounces-4743-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3769D0DEE
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Nov 2024 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C97B1F22631
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Nov 2024 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5487194AD9;
	Mon, 18 Nov 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG4gOLhC"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780E193432
	for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924642; cv=none; b=D7bZI7N4yf0ZWnY888jz2GsbB3tZmx7xiv/WAXledOoZjy3GD7lESEohB8A3a4FNGO8z9u/mC/Fil5KhIJUDoURxYefqMY+oGsUhTkFIIw6bnzbaPibcb597Ci5eYdB/kCU9MsIpOZ2vOB0WMTcOS7DXCNEYWBROnspN1E6MnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924642; c=relaxed/simple;
	bh=ySVUejG1nfg+9Qtu56is4MtlDcLVk7wyDQ8dmU8s0Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYXwmH1b9FPpLkdTvBoAi/DNWrc9K/bJFFwFyf4Wgg2AZ5ARRCUUahkHUTKzrAvHTff/VmXZfRzmqNsLCXo098DT9iC4/1I5l79LqxqQEnMQTADYJC+1DeBK8ud+7u6fXdLcM+7Ak/922JWJGHhfNipYH7gEwoLMrmnc1zEyRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG4gOLhC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731924640; x=1763460640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ySVUejG1nfg+9Qtu56is4MtlDcLVk7wyDQ8dmU8s0Fo=;
  b=hG4gOLhCtzyQ1zAU7BKOzBaVOpnIumQ+D4B7/jJ8UUNxvy4MFNTJDBNY
   eaN9xh4oS6WZ2TFOWm1piHJxdiNHg4A9taOUVG6VCJz+b7qoAJUigFH+E
   +249Q5JBmTFRq5r2OjBPp4W9EoX0L3ff0cHSQ1TSou2PWlN5G5dR9e1bv
   xg3YqXehWdlNxVOwYYxCG9u8HrXCQHqEOdV1xV4j8Pd4gWmzaSRLwa0vV
   q6wY8NZFKgwSHbQGq+cWGiJFPsvQ3TAtnLGy0zC9Ng4FMMJl8PEumSIwS
   roB5gwhGaAomqqK5t5n0QRrMItrXUqKSZpO0E7N4C5CvLS3omZTwcZHnh
   Q==;
X-CSE-ConnectionGUID: iCa62xibRNCxTLyQ4xqZig==
X-CSE-MsgGUID: WV9SyxbrTTyF4X8grQFjSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42504489"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42504489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:10:38 -0800
X-CSE-ConnectionGUID: e0hT3NAmRRez5OLiCPQRvg==
X-CSE-MsgGUID: GfczdEnWS4GVZ4WhNnUSfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="94126929"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:10:37 -0800
Message-ID: <686a5c43-ac82-4506-ade8-e666a538abd5@intel.com>
Date: Mon, 18 Nov 2024 12:10:31 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241114155611.59577-1-hdegoede@redhat.com>
 <2008ebd5-b1d1-417e-bd88-9d4c0a381e7d@intel.com>
 <1196b26c-e5d3-4f2d-a97b-688e9825c98a@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1196b26c-e5d3-4f2d-a97b-688e9825c98a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/11/24 13:25, Hans de Goede wrote:
> Hi Adrian,
> 
> On 15-Nov-24 8:33 AM, Adrian Hunter wrote:
>> On 14/11/24 17:56, Hans de Goede wrote:
>>> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
>>> Andalucía region has no ACPI fwnode associated with the SDHCI controller
>>> for its microsd-slot and thus has no ACPI GPIO resource info.
>>>
>>> This causes the following error to be logged and the slot to not work:
>>> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>>>
>>> Add a DMI quirk table for providing gpiod_lookup_tables with manually
>>> provided CD GPIO info and use this DMI table to provide the CD GPIO info
>>> on this tablet. This fixes the microsd-slot not working.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v3:
>>> - Add a cd_gpio_override pointer to sdhci_pci_fixes
>>> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>>>   struct gpiod_lookup_table to avoid races when using async probing
>>>
>>> Changes in v2:
>>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 67 +++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-pci.h      |  1 +
>>>  2 files changed, 68 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index ed45ed0bdafd..a2ddbe3d8742 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/iopoll.h>
>>>  #include <linux/gpio.h>
>>> +#include <linux/gpio/machine.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/pm_qos.h>
>>>  #include <linux/debugfs.h>
>>> @@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>>  	.priv_size	= sizeof(struct intel_host),
>>>  };
>>>  
>>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>>> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>>> +	.dev_id = "0000:00:12.0",
>>> +	.table = {
>>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>>> +		{ }
>>> +	},
>>> +};
>>
>> This is good but I feel like we should make it more difficult
>> to get the size wrong.  Could introduce another struct to hold
>> the size:
>>
>> struct sdhci_pci_gpio_data {
>> 	const struct gpiod_lookup_table *gpios;
>> 	size_t size;
>> };
>>
>> static const struct sdhci_pci_gpio_data vexia_edu_atla10_cd_gpio_data = {
>> 	.gpios = &vexia_edu_atla10_cd_gpios,
>> 	.size  = sizeof(vexia_edu_atla10_cd_gpios),
>> };
>>
>> So:
>> 		.driver_data = (void *)&vexia_edu_atla10_cd_gpio_data,
>> and
>> 	struct sdhci_pci_gpio_data *data;
>> 	...
>> 	data = dmi_id->driver_data;
>>
>> 	cd_gpio_lookup_table = kmemdup(data->gpios, data->size, GFP_KERNEL);
> 
> Interesting idea. But I'm afraid that sizeof(variable-name) on a struct
> with a flexible array member returns the same as just sizeof(struct struct-name)
> I added the following debug print to verify this:
> 
>  static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>  {
> + pr_info("sizeof(vexia_edu_atla10_cd_gpios) %lu sizeof(struct gpiod_lookup_table) %lu\n",
> +         sizeof(vexia_edu_atla10_cd_gpios), sizeof(struct gpiod_lookup_table));
>         byt_probe_slot(slot);
>         slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
>                                  MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
> 
> And that prints:
> 
> [   10.459681] sizeof(vexia_edu_atla10_cd_gpios) 24 sizeof(struct gpiod_lookup_table) 24
> 
> So using sizeof(vexia_edu_atla10_cd_gpios) to get the size including the 2
> flexible array members does not work since sizeof() does not take into
> account the size of the flexible array members.

Thanks for spotting that!

Perhaps we should check the table size then?
e.g.
	struct gpiod_lookup_table *table;
	size_t count;

	...

	table = dmi_id->driver_data;
	for (count = 0; table->table[count].key; count++)
		;
	if (count != 1)
		return ERR_PTR(-EINVAL);

>>
>>> +
>>> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
>>> +	{
>>> +		/* Vexia Edu Atla 10 tablet 9V version */
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>>> +			/* Above strings are too generic, also match on BIOS date */
>>> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>>> +		},
>>> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>>> +	},
>>> +	{ }
>>> +};
>>> +
>>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>>  #ifdef CONFIG_PM_SLEEP
>>>  	.resume		= byt_resume,
>>> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>>  	.add_host	= byt_add_host,
>>>  	.remove_slot	= byt_remove_slot,
>>>  	.ops		= &sdhci_intel_byt_ops,
>>> +	.cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
>>>  	.priv_size	= sizeof(struct intel_host),
>>>  };
>>>  
>>> @@ -2054,6 +2079,37 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>>   *                                                                           *
>>>  \*****************************************************************************/
>>>  
>>> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
>>> +	struct sdhci_pci_chip *chip)
>>
>> Let's not line wrap until 100 columns
>>
>>> +{
>>> +	struct gpiod_lookup_table *cd_gpio_lookup_table;
>>> +	const struct dmi_system_id *dmi_id = NULL;
>>> +
>>> +	if (chip->fixes && chip->fixes->cd_gpio_override)
>>> +		dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
>>> +
>>> +	if (!dmi_id)
>>> +		return NULL;
>>> +
>>> +	cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
>>> +				       /* 1 GPIO lookup entry + 1 terminating entry */
>>> +				       struct_size(cd_gpio_lookup_table, table, 2),
>>> +				       GFP_KERNEL);
>>> +	if (!cd_gpio_lookup_table)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	gpiod_add_lookup_table(cd_gpio_lookup_table);
>>> +	return cd_gpio_lookup_table;
>>> +}
>>> +
>>> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
>>> +{
>>> +	if (lookup_table) {
>>> +		gpiod_remove_lookup_table(lookup_table);
>>> +		kfree(lookup_table);
>>> +	}
>>> +}
>>> +
>>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>>  	int slotno)
>>> @@ -2129,8 +2185,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>  		device_init_wakeup(&pdev->dev, true);
>>>  
>>>  	if (slot->cd_idx >= 0) {
>>> +		struct gpiod_lookup_table *cd_gpio_lookup_table;
>>> +
>>> +		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>>> +		if (IS_ERR(cd_gpio_lookup_table)) {
>>> +			ret = PTR_ERR(cd_gpio_lookup_table);
>>> +			goto remove;
>>> +		}
>>> +
>>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>>  					   slot->cd_override_level, 0);
>>> +
>>> +		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>>> +
>>>  		if (ret && ret != -EPROBE_DEFER)
>>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>>  						   slot->cd_idx,
>>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>>> index 153704f812ed..4973fa859217 100644
>>> --- a/drivers/mmc/host/sdhci-pci.h
>>> +++ b/drivers/mmc/host/sdhci-pci.h
>>> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>>>  #endif
>>>  
>>>  	const struct sdhci_ops	*ops;
>>> +	const struct dmi_system_id *cd_gpio_override;
>>>  	size_t			priv_size;
>>>  };
>>>  
>>
> 


