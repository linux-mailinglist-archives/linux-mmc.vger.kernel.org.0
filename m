Return-Path: <linux-mmc+bounces-415-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CEC80C2A2
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Dec 2023 09:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB0F280D8C
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Dec 2023 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDB20B19;
	Mon, 11 Dec 2023 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZCtcjZw"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA9D5;
	Mon, 11 Dec 2023 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702281840; x=1733817840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K+OG1koP1ULrySQIRiy7xz7OlRKwcfL/LiW/qwKPQP0=;
  b=XZCtcjZwLBm2S+hLv2ptqK9bf400ZPH5VVfw76955EFbU2TTDRoYZzNL
   cLnWYkgRxWlXNHrXNt8s3AUuOKYZcaWa0/xIBTspSEGYluVVJdssqfIql
   97CJcYJXgAuFRx1JV39soMCjnHk4JbCMyJSw5dER+gkv1ZvonS35By0aJ
   b2yMt94nhGcsuSZ1Lk+OeVt9DzH4P0qFzN1EpDCgzJNHuqi3Z8zW3LbPS
   p/5q6BxesDQMyn+KZybiInxJ4B8hRlyC/oLjPRHU3OBqMWYRQdwXqjCEH
   faNIp6CU88sq5V1z7iRNMR85S2ntiC3b4/Y8zJzWprtokmvZvE+7hjAJG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1448392"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1448392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104376725"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104376725"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.23])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:03:54 -0800
Message-ID: <f8b848a2-ccdf-4a28-8b51-3d1e985be90d@intel.com>
Date: Mon, 11 Dec 2023 10:03:51 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
To: Avri Altman <Avri.Altman@wdc.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "christian.loehle@arm.com" <christian.loehle@arm.com>
Cc: "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "beanhuo@micron.com"
 <beanhuo@micron.com>, "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
 "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
 "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "yebin10@huawei.com" <yebin10@huawei.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/23 09:02, Avri Altman wrote:
>>
>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>>> Requesting a retune before switching to the RPMB partition has been
>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>>
>> There are still 2 concerns:
>> 1) We don't really know the root cause.  Have you determined if here are
>> CRC errors in the main partition also?
>> 2) Forcing this on everyone
>>
>> The original idea was that because re-tuning cannot be done in RPMB, the
>> need to re-rune in RPMB could be avoided by always re-tuning before
>> switching to RPMB and then switching straight back. IIRC re-tuning should
>> guarantee at least 4MB more I/O without issue.
> Performance is hardly an issue in the context of RPMB access - 
> For most cases it’s a single frame.

Not sure why you bring up performance.

SDHCI spec says:

"To enable inserting the re-tuning procedure during data transfers,
the data length per read/write command shall be limited up to 4MB."

Which implies re-tuning is needed at most every 4MB, so re-tuning
before RPMB switch and switching straight back, means re-tuning
should never be needed in RPMB.

> 
> Thanks,
> Avri
> 
>>
>> The alternative to dropping re-tuning in this case could be to add a retry loop
>> for MMC_DRV_OP_IOCTL_RPMB if the error is -EILSEQ
>>
>>
>>>
>>> Since RPMB reads can not be retried, the clients would be directly
>>> affected by the errors.
>>>
>>> This commit disables the request prior to RPMB switching while
>>> allowing the pause interface to still request a retune before the
>>> pause for other use cases.
>>>
>>> This was verified with the sdhci-of-arasan driver (ZynqMP) configured
>>> for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
>>> cases, the error was easy to reproduce triggering every few tenths of
>>> reads.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
>>> ---
>>>  drivers/mmc/core/block.c | 2 +-
>>>  drivers/mmc/core/host.c  | 7 ++++---
>>>  drivers/mmc/core/host.h  | 2 +-
>>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>>> f9a5cffa64b1..1d69078ad9b2 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct
>> mmc_card *card,
>>>                       if (ret)
>>>                               return ret;
>>>               }
>>> -             mmc_retune_pause(card->host);
>>> +             mmc_retune_pause(card->host, false);
>>>       }
>>>
>>>       return ret;
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
>>> 096093f7be00..a9b95aaa2235 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host
>> *host)
>>>
>>>  /*
>>>   * Pause re-tuning for a small set of operations.  The pause begins
>>> after the
>>> - * next command and after first doing re-tuning.
>>> + * next command and, if retune is set, after first doing re-tuning.
>>>   */
>>> -void mmc_retune_pause(struct mmc_host *host)
>>> +void mmc_retune_pause(struct mmc_host *host, bool retune)
>>>  {
>>>       if (!host->retune_paused) {
>>>               host->retune_paused = 1;
>>> -             mmc_retune_needed(host);
>>> +             if (retune)
>>> +                     mmc_retune_needed(host);
>>
>> Better to just drop mmc_retune_needed(host);
>>
>>>               mmc_retune_hold(host);
>>
>> There is still a small chance that re-tuning is needed anyway in which case it
>> will still be done.
>>
>>>       }
>>>  }
>>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h index
>>> 48c4952512a5..321776b52270 100644
>>> --- a/drivers/mmc/core/host.h
>>> +++ b/drivers/mmc/core/host.h
>>> @@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
>>> void mmc_retune_hold(struct mmc_host *host);  void
>>> mmc_retune_release(struct mmc_host *host);  int mmc_retune(struct
>>> mmc_host *host); -void mmc_retune_pause(struct mmc_host *host);
>>> +void mmc_retune_pause(struct mmc_host *host, bool retune);
>>>  void mmc_retune_unpause(struct mmc_host *host);
>>>
>>>  static inline void mmc_retune_clear(struct mmc_host *host)
> 


