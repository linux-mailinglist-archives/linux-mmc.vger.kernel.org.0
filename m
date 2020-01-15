Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A3313BA3E
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Jan 2020 08:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOHRw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Jan 2020 02:17:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:62547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgAOHRw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 02:17:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 23:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="225478126"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 23:17:47 -0800
Subject: Re: [PATCH] mmc: sdhci: fix minimum clock rate for v3 controller
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <3f3b2ac4634802af591a20b1b98dc8d0158aec45.1577962196.git.mirq-linux@rere.qmqm.pl>
 <4264051e-6126-83c3-e49e-3d9050ff35ce@intel.com>
 <20200114155333.GA29422@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6ebf8a7e-faf2-aca8-edc1-e64254043f5f@intel.com>
Date:   Wed, 15 Jan 2020 09:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114155333.GA29422@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/01/20 5:53 pm, Micha� Miros�aw wrote:
> On Tue, Jan 14, 2020 at 03:08:08PM +0200, Adrian Hunter wrote:
>> On 2/01/20 12:51 pm, Micha� Miros�aw wrote:
>>> For SDHCIv3+ with programmable clock mode, minimal clock frequency is
>>> still base clock / max(divider). Minimal programmable clock frequency is
>>> always greater than minimal divided clock frequency. Without this patch,
>>> SDHCI uses out-of-spec initial frequency when multiplier is big enough:
>>>
>>> mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
>>> [for 480 MHz source clock divided by 1024]
>>
>> The maximum divisor in programmable clock mode is 1024.  So I do not
>> understand what is wrong.  Can you explain some more?
> 
> This part of code misses the fact, that you can choose (switch) between
> base clock mode and programmable clock mode. The code in
> sdhci_calc_clk() already does the choosing part. This is actually
> required on high programmable clock base to get conformant frequency for
> the card initialization phase.

Ok, so please add that explanation to the commit message, and add a comment
in the code too.

> 
> Best Regards,
> Micha��Miros�aw
> 
> [...]
>>> index 275102c0a1bf..0036ddf85674 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3902,11 +3902,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>  	if (host->ops->get_min_clock)
>>>  		mmc->f_min = host->ops->get_min_clock(host);
>>>  	else if (host->version >= SDHCI_SPEC_300) {
>>> -		if (host->clk_mul) {
>>> -			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
>>> +		if (host->clk_mul)
>>>  			max_clk = host->max_clk * host->clk_mul;
>>> -		} else
>>> -			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>>> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>>>  	} else
>>>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;

