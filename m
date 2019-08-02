Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE207FB86
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfHBNtw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 09:49:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:40683 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfHBNtv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Aug 2019 09:49:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 06:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175587486"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 06:49:49 -0700
Subject: Re: Possible bug in sdhci_set_power_reg
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Phil Elwell <phil@raspberrypi.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
 <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com>
 <54d45628-14f4-514b-f5cb-18bf4f7baf63@raspberrypi.org>
 <CAPDyKFpKAaeLtppQAv5O1CW2FcF5Pa=-k+PEr4ppO-Mc6RN3-w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <517ff814-07ce-bda5-ac13-d10fae195c25@intel.com>
Date:   Fri, 2 Aug 2019 16:48:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpKAaeLtppQAv5O1CW2FcF5Pa=-k+PEr4ppO-Mc6RN3-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/08/19 4:28 PM, Ulf Hansson wrote:
> + Adrian
> 
> On Fri, 2 Aug 2019 at 15:23, Phil Elwell <phil@raspberrypi.org> wrote:
>>
>> Hi Uffe,
>>
>> On 02/08/2019 14:15, Ulf Hansson wrote:
>>> On Tue, 30 Jul 2019 at 15:17, Phil Elwell <phil@raspberrypi.org> wrote:
>>>>
>>>> Hi MMC team,
>>>>
>>>> I've spent some time trying to add a regulator to control power to an SD card
>>>> (vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
>>>> I found that powering up the regulator during the boot process was effectively disabling
>>>> the SDHCI controller. Note that this was despite having regulator-boot-on set in the
>>>> device tree.
>>>>
>>>> The problem seems to be in sdhci_set_power_reg:
>>>>
>>>>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>>>
>>>>         if (mode != MMC_POWER_OFF)
>>>>                 sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>>>>         else
>>>>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>>
>>>> This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
>>>> register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
>>>> Select bits to 0b000 (a reserved value).
>>>>
>>>> sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
>>>> select bits, so I found that (in my limited test cases) replacing the if/else above
>>>> with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.
>>>>
>>>> Can anyone tell me what I've been doing wrong, or suggest a better "fix"?
>>>
>>> There are other sdhci variants having the similar needs, hence we have
>>> the flexibility available via using the optional ->set_power()
>>> callback.
>>>
>>> Have a look at sdhci_arasan_set_power(), for example.
>>
>> I don't understand. Can you explain what writing 0x0001 to the SDHCI_POWER_CONTROL register
>> is supposed to do according to the specification? And why is the Arasan SDHCI implementation
>> not the default?
> 
> Good question, but unfortunate I don't know the SDHCI spec in that
> great detail. And in the end, it has turned out that variants seems to
> differs in regards to this register.
> 
> I looped in Adrian, to see if he has some comments.

Different hardware works differently.

People have already fought, won and lost over how the power
should be set with regulators, so now we have ->set_power()
so everyone can do what they want.  Please use that.
