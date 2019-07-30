Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137997A2AD
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Jul 2019 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfG3IAD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 30 Jul 2019 04:00:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:44847 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG3IAC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Jul 2019 04:00:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 01:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="171846354"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2019 01:00:00 -0700
Subject: Re: Issue with sequence to switch to HS400
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
 <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
 <CAOGqxeVR3XzAQ-yTH35hyT3KpL11nTwMY1Ca96ZW=K=PiWMnHA@mail.gmail.com>
 <23ce5519-cb4b-4d85-4bfc-3e438212ec7f@intel.com>
 <CAOGqxeVjj9Leok-Oph-kNA92fKhdBHzwJZ643uND8GV_8VaHCw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bacb9b93-e7fa-453e-2b4f-8056c9ab34b8@intel.com>
Date:   Tue, 30 Jul 2019 10:58:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOGqxeVjj9Leok-Oph-kNA92fKhdBHzwJZ643uND8GV_8VaHCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/07/19 12:37 AM, Alan Cooper wrote:
> That's an even better solution and it gets my HS400 mode working.
> Will you add this change or should I?

You, if you wouldn't mind.

> 
> Thanks
> Al
> 
> On Thu, Jul 25, 2019 at 3:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 23/07/19 3:34 PM, Alan Cooper wrote:
>>> On Tue, Jul 23, 2019 at 1:21 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 23/07/19 1:31 AM, Alan Cooper wrote:
>>>>> I'm having a problem with a new SD/MMC controller and PHY in our
>>>>> latest SoC's. The issue I'm seeing is that I can't switch into HS400
>>>>> mode. This looks like something the driver is doing that doesn't meet
>>>>> the JEDEC spec. In the "HS400 timing mode selection" section of the
>>>>> JEDEC spec , in step 7 it states:
>>>>>
>>>>> 7) Set the “Timing Interface” parameter in the HS_TIMING [185] field
>>>>> of the Extended CSD register to 0x1 to switch to High Speed mode and
>>>>> then set the clock frequency to a value not greater than 52 MHz.
>>>>>
>>>>> In the function mmc_select_hs400() in mmc.c, I see that a switch
>>>>> command is done to set the eMMC device to HS mode and then
>>>>> mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
>>>>> controller to HS mode. The problem is that the "SD Host Controller
>>>>> Standard Specification" states that "UHS Mode Select" field of the
>>>>> "Host Control 2 Register" controls the mode when the "1.8V Signaling
>>>>> Enable" bit in the same register is set, so mmc_set_timing() is
>>>>> actually leaving the controller in SDR12 mode and mmc_select_hs400()
>>>>> will then set the clock to 52MHz. This causes our PHY to detect an
>>>>> illegal combination and return an error.
>>>>>
>>>>> I think the easiest fix would be to change mmc_set_timing(card->host,
>>>>> MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
>>>>> MMC_TIMING_UHS_SDR25). The other possibility would be to change
>>>>> mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
>>>>> I'll submit a patch based on the feedback I get.
>>>>
>>>> eMMC is governed by JEDEC specs not SD specs.
>>>
>>> My understanding is that JEDEC does not have a host controller spec so
>>> this driver uses the "SD Host Controller Standard Specification".
>>
>> There is no spec for using eMMC with SDHCI.
>>
>>>
>>>>
>>>> Please consider making a change in your driver instead.  For example, hook
>>>> ->set_ios() and if 1.8V is enabled and timing is set to MMC_TIMING_MMC_HS
>>>> then change it to MMC_TIMING_UHS_SDR25.
>>>
>>> That's an easy fix, but it still leaves all other drivers/systems
>>> temporarily using SDR12 at 52MHz during the switch to HS400.
>>
>> Yes, I changed my mind.  Does this work:
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 59acf8e3331e..f9d241458dcd 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1849,7 +1849,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>         else if (timing == MMC_TIMING_UHS_SDR12)
>>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>> -       else if (timing == MMC_TIMING_UHS_SDR25)
>> +       else if (timing == MMC_TIMING_SD_HS ||
>> +                timing == MMC_TIMING_MMC_HS ||
>> +                timing == MMC_TIMING_UHS_SDR25)
>>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>         else if (timing == MMC_TIMING_UHS_SDR50)
>>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> 

