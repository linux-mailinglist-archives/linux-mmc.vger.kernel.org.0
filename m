Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422AA1ABA29
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Apr 2020 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439525AbgDPHln (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 16 Apr 2020 03:41:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:37066 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439413AbgDPHl0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Apr 2020 03:41:26 -0400
IronPort-SDR: z3C7Jh3oSXE2UbVzbF6hYFbOEhsbKHASqaZ2c3Zkywq8u29eG6ZyQGpOGhNrTXEXgOaNJnnDTI
 r73VasWlGW8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 00:41:26 -0700
IronPort-SDR: 9gMtqRjRYcECo8zZS2jw2o7HXakW8rbvZ1z1uJDT8Tl2nZQO8Ninm2iuy2YLkbGx9swTpe4d+6
 XBFg6izq0KTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363906708"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 00:41:22 -0700
Subject: Re: [PATCH 3/7] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <eb105eedaa387ced14bb687e38d3aa33d4fcf70a.1585827904.git.mirq-linux@rere.qmqm.pl>
 <67dc68ce-d8ec-4486-f4f9-3fb2580d2675@intel.com>
 <20200415160302.GB19897@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a49b6a25-14f5-ca1b-b493-e40ec4984b04@intel.com>
Date:   Thu, 16 Apr 2020 10:40:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415160302.GB19897@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/20 7:03 pm, Micha� Miros�aw wrote:
> On Wed, Apr 15, 2020 at 04:06:02PM +0300, Adrian Hunter wrote:
>> On 2/04/20 2:54 pm, Micha� Miros�aw wrote:
>>> Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.
>>
>> Does this change anything, because it looks the same to me?
> 
> The value of real_div is fixed this way. With previous code after
> applying the quirk you would have real_div = 1 instead of real_div = 2.

That kind of thing should be in the commit message.  Please also explain
what effect this has (the actual clock value will be too high, but also what
problems does that manifest) and what hardware is affected.

> 
> Best Regards,
> Micha� Miros�aw
> 
>>
>>>
>>> Signed-off-by: Micha� Miros�aw <mirq-linux@rere.qmqm.pl>
>>> Cc: stable@kernel.vger.org
>>> Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
>>> ---
>>>  drivers/mmc/host/sdhci.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index b2dc4f1cfa5c..a043bf5e3565 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1807,9 +1807,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>>  
>>>  		if (!host->clk_mul || switch_base_clk) {
>>>  			/* Version 3.00 divisors must be a multiple of 2. */
>>> -			if (host->max_clk <= clock)
>>> +			if (host->max_clk <= clock) {
>>>  				div = 1;
>>> -			else {
>>> +				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>>> +					&& host->max_clk <= 25000000)
>>> +					div = 2;
>>> +			} else {
>>>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
>>>  				     div += 2) {
>>>  					if ((host->max_clk / div) <= clock)
>>> @@ -1818,9 +1821,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>>  			}
>>>  			real_div = div;
>>>  			div >>= 1;
>>> -			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>>> -				&& !div && host->max_clk <= 25000000)
>>> -				div = 1;
>>>  		}
>>>  	} else {
>>>  		/* Version 2.00 divisors must be a power of 2. */
>>>
>>

