Return-Path: <linux-mmc+bounces-473-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5E812B6B
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Dec 2023 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D642827B2
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Dec 2023 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B182D046;
	Thu, 14 Dec 2023 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+gDbesD"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D01A6;
	Thu, 14 Dec 2023 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702545333; x=1734081333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=95pMn6/FPLqknYmtJDr/SID5bH9Fjq3Kis48L3I4fEs=;
  b=a+gDbesDrnx5RVQc1bk+59NblrU29yO77s/MnSNRP6hS1XIPM1IPZjF7
   LmMgSTMQ1XSaMfGWhOU9FkIibBvwYL9FK1NTdTJ9zNJcRGNSDHhD2CPXP
   U/dBJ96Eai7WXDZW2rEJeuAQQ2iCbdF/vsKw5kvwT7HYka5r/GjXSHELQ
   faGUqbxv5Nxez3L4MqX2bxLkriS4BTo2JiyG9JSz8DXhFfNQsEfjYeEM9
   q+W8kublPCtQSxg80XFaAgpzUxJoJPXQnz4jDrLLvOVPhYk1nSJ0XK3Uj
   nysMy3U4bOoI5jVNlxTib1ghDE1FXUrRXo2sn0tdRoJjEIFZN38gbMYkn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1942499"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1942499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="22322797"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:15:28 -0800
Message-ID: <bceac981-6174-414b-810b-5354e01830a3@intel.com>
Date: Thu, 14 Dec 2023 11:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Avri Altman <Avri.Altman@wdc.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "christian.loehle@arm.com" <christian.loehle@arm.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
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
 <ZXBGTxS7sUSILtLs@trax> <ZXbBhjZIn5sj6EYO@trax>
 <7443a730-411a-4dd3-b911-241356493516@intel.com> <ZXbtS9KKQY+vk7Mq@trax>
 <a0eb3547-9bdc-40e0-8861-1d8beec50a78@intel.com> <ZXclVpvpx0sV2Hcn@trax>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZXclVpvpx0sV2Hcn@trax>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/23 17:05, Jorge Ramirez-Ortiz, Foundries wrote:
> On 11/12/23 13:32:57, Adrian Hunter wrote:
>> On 11/12/23 13:06, Jorge Ramirez-Ortiz, Foundries wrote:
>>> On 11/12/23 12:25:19, Adrian Hunter wrote:
>>>> On 11/12/23 10:00, Jorge Ramirez-Ortiz, Foundries wrote:
>>>>> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
>>>>>> On 06/12/23 07:02:43, Avri Altman wrote:
>>>>>>>>
>>>>>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>>>>>>>>> Requesting a retune before switching to the RPMB partition has been
>>>>>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>>>>>>>>
>>>>>>>> There are still 2 concerns:
>>>>>>>> 1) We don't really know the root cause.  Have you determined if here are
>>>>>>>> CRC errors in the main partition also?
>>>>>>
>>>>>> right, and I don't disagree with that.
>>>>>>
>>>>>> As a test I created a 4GB file from /dev/random which I then copied
>>>>>> several times (dd if= ....)
>>>>>>
>>>>>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
>>>>>> # Command Timeout Occurred:      0
>>>>>> # Command CRC Errors Occurred:   0
>>>>>> # Data Timeout Occurred:         0
>>>>>> # Data CRC Errors Occurred:      0
>>>>>> # Auto-Cmd Error Occurred:       0
>>>>>> # ADMA Error Occurred:   0
>>>>>> # Tuning Error Occurred:         0
>>>>>> # CMDQ RED Errors:       0
>>>>>> # CMDQ GCE Errors:       0
>>>>>> # CMDQ ICCE Errors:      0
>>>>>> # Request Timedout:      0
>>>>>> # CMDQ Request Timedout:         0
>>>>>> # ICE Config Errors:     0
>>>>>> # Controller Timedout errors:    0
>>>>>> # Unexpected IRQ errors:         0
>>>>>>
>>>>>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
>>>>>>
>>>>>> I/TC: RPMB: Using generated key
>>>>>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>>>>>> E/TC:? 0
>>>>>> E/TC:? 0 TA panicked with code 0xffff0000
>>>>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>>>>>> E/LD:   arch: aarch64
>>>>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
>>>>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
>>>>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
>>>>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
>>>>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
>>>>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
>>>>>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
>>>>>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
>>>>>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
>>>>>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
>>>>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
>>>>>> E/LD:  Call stack:
>>>>>> E/LD:   0xc0051a14
>>>>>> E/LD:   0xc004f31c
>>>>>> E/LD:   0xc0052d40
>>>>>> E/LD:   0xc004f624
>>>>>>
>>>>>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
>>>>>> # Command Timeout Occurred:      0
>>>>>> # Command CRC Errors Occurred:   0
>>>>>> # Data Timeout Occurred:         0
>>>>>> # Data CRC Errors Occurred:      1
>>>>>> # Auto-Cmd Error Occurred:       0
>>>>>> # ADMA Error Occurred:   0
>>>>>> # Tuning Error Occurred:         0
>>>>>> # CMDQ RED Errors:       0
>>>>>> # CMDQ GCE Errors:       0
>>>>>> # CMDQ ICCE Errors:      0
>>>>>> # Request Timedout:      0
>>>>>> # CMDQ Request Timedout:         0
>>>>>> # ICE Config Errors:     0
>>>>>> # Controller Timedout errors:    0
>>>>>> # Unexpected IRQ errors:         0
>>>>>>
>>>>>>>> 2) Forcing this on everyone
>>>>>>>>
>>>>>>>> The original idea was that because re-tuning cannot be done in RPMB, the
>>>>>>>> need to re-rune in RPMB could be avoided by always re-tuning before
>>>>>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
>>>>>>>> guarantee at least 4MB more I/O without issue.
>>>>>>> Performance is hardly an issue in the context of RPMB access -
>>>>>>> For most cases it’s a single frame.
>>>>>>
>>>>>> Yes, the security use case typically stores hashes, variables
>>>>>> (bootcount, upgrade_available, versions, that sort of thing) and
>>>>>> certificates in RPMB.
>>>>>>
>>>>>> Since you mentioned, I am seeing that tuning before switching to RPMB
>>>>>> has an impact on performance. As a practical test, just reading a 6 byte
>>>>>> variable incurs in 50ms penalty in kernel space due to the need to
>>>>>> retune 5 times. Not great since the request is coming from a Trusted
>>>>>> Application via OP-TEE through the supplicant meaning this TEE thread
>>>>>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
>>>>>> quite a bit of time.
>>>>>>
>>>>>> Roughly:
>>>>>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
>>>>>
>>>>> To add more detail to the timing above, when using RPMB, OP-TEE stores
>>>>> the secure filesystem on RPMB as well, so accessing one of the variables
>>>>> stored in the filesystem consists on a number (~5) of individual RPMB
>>>>> requests (each one forcing a retune, each retune taking around 10ms).
>>>>>
>>>>> BTW, I also tried delaying the timing between those consecutive retunes
>>>>> (up to 1 second), but the issue still persisted.
>>>>>
>>>>>>
>>>>>> Adrian, I couldn't find the original performance justification for
>>>>>> enabling this feature globally. At which point do you think it becomes
>>>>>> beneficial to retune before accessing RPMB?
>>>>>
>>>>> How should we proceed with this patch then? can it be merged as I
>>>>> proposed? should I rewrite it differently? not sure what is next
>>>>
>>>> It would be good to try to determine if the error happens when the
>>>> switch command comes immediately after tuning.  For example, add
>>>> a delay after tuning and see if that makes any difference. e.g.
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index c79f73459915..6b168659282a 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2867,8 +2867,10 @@ int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>>>
>>>>  		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>  		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
>>>> -			if (ctrl & SDHCI_CTRL_TUNED_CLK)
>>>> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
>>>> +				msleep(10);
>>>>  				return 0; /* Success! */
>>>> +			}
>>>>  			break;
>>>>  		}
>>>>
>>>>
>>>
>>> Thanks Adrian.
>>>
>>> The issue sill triggers (in this case on the last but one access to
>>> retrieve the 6 byte variable).
>>>
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2781,6 +2781,7 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>>          * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
>>>          * of loops reaches tuning loop count.
>>>          */
>>> + printk(KERN_ERR "tune starts[loop %d]\n", host->tuning_loop_count);
>>>         for (i = 0; i < host->tuning_loop_count; i++) {
>>>                 u16 ctrl;
>>>
>>> @@ -2799,8 +2800,11 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>>
>>>                 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>                 if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
>>> -                   if (ctrl & SDHCI_CTRL_TUNED_CLK)
>>> -                           return 0; /* Success! */
>>> +                 if (ctrl & SDHCI_CTRL_TUNED_CLK) {
>>> +                         printk(KERN_ERR "tune success[%d]\n", i);
>>> +                         msleep(10);
>>> +                         return 0; /* Success! */
>>> +                 }
>>>                         break;
>>>                 }
>>>
>>>
>>> [  164.919090] tune starts[loop 40]
>>> [  164.923152] tune success[39]
>>> [  164.952106] tune starts[loop 40]
>>> [  164.956611] tune success[39]
>>> [  165.084402] tune starts[loop 40]
>>> [  165.089350] tune success[39]
>>> [  165.116491] tune starts[loop 40]
>>> [  165.120806] tune success[39]
>>> [  165.145016] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>>> E/TC:? 0
>>> E/TC:? 0 TA panicked with code 0xffff0000
>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>>> E/LD:   arch: aarch64
>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
>>> E/LD:  region  6: va 0xc0019000 pa 0x818ac38e8 size 0x001000 flags rw-- (param)
>>> E/LD:  region  7: va 0xc001a000 pa 0x818ac36e8 size 0x001000 flags rw-- (param)
>>> E/LD:  region  8: va 0xc0022000 pa 0x00001000 size 0x014000 flags r-xs [0]
>>> E/LD:  region  9: va 0xc0036000 pa 0x00015000 size 0x008000 flags rw-s [0]
>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc0022000
>>> E/LD:  Call stack:
>>> E/LD:   0xc0024e58
>>> E/LD:   0xc0022388
>>> E/LD:   0xc0025d40
>>> E/LD:   0xc0022624
>>> [  166.119598] tune starts[loop 40]
>>> [  166.125700] tune success[39]
>>
>> It might make a difference if there is another command before the
>> switch command, e.g. add a CMD13 (could keep the tune print to tell
>> that the CMD13 comes after re-tuning)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 892e74e611a0..3265049f4132 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -875,6 +875,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>>  				   unsigned int part_type)
>>  {
>>  	int ret = 0;
>> +	u32 status;
>>
>>  	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
>>  		if (card->ext_csd.cmdq_en) {
>> @@ -883,6 +884,9 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>>  				return ret;
>>  		}
>>  		mmc_retune_pause(card->host);
>> +		ret = mmc_send_status(card, &status);
>> +		pr_info("%s: %s: status %#x, ret %d\n", mmc_hostname(card->host), __func__, status, ret);
>> +		ret = 0;
>>  	}
>>
>>  	return ret;
>>
>>
>>
>> And another thing to try is SDHCI_QUIRK2_TUNING_WORK_AROUND
>>
> 
> I run it in a loop with all the proposed changes and after 6 or 7 seconds the error triggered:
> 
> $ while true; do if ! read_rpmb variable ;then exit 0; fi; done
> [....]
> 
> 
> [  146.686482] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
> [  146.699092] ldts: tune starts[loop 40]
> [  146.704032] ldts: tune success[39]
> [  146.726442] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
> [  146.745891] ldts: tune starts[loop 40]
> [  146.750858] ldts: tune success[39]
> [  146.774506] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
> [  146.787191] ldts: tune starts[loop 40]
> [  146.792087] ldts: tune success[39]
> [  146.814544] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
> [  146.826383] ldts: tune starts[loop 40]
> [  146.830942] ldts: tune success[39]
> [  146.854500] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
> [  146.863421] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> E/LD:  region  6: va 0xc0019000 pa 0x818c17b48 size 0x001000 flags rw-- (param)
> E/LD:  region  7: va 0xc001a000 pa 0x818c17d48 size 0x001000 flags rw-- (param)
> E/LD:  region  8: va 0xc003c000 pa 0x00001000 size 0x014000 flags r-xs [0]
> E/LD:  region  9: va 0xc0050000 pa 0x00015000 size 0x008000 flags rw-s [0]
> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc003c000
> E/LD:  Call stack:
> E/LD:   0xc003ea14
> E/LD:   0xc003c31c
> E/LD:   0xc003fd40


I sent a patch to add a re-tuning test to mmc_test.  It would be
interesting to try that too.

https://lore.kernel.org/linux-mmc/20231214090902.43628-1-adrian.hunter@intel.com/T/#u


