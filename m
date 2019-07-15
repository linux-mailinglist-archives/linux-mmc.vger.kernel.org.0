Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8813688FF
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfGOMjH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 08:39:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:6407 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfGOMjG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Jul 2019 08:39:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 05:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="190548014"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2019 05:39:03 -0700
Subject: Re: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation
 when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
 <c54077a4-3aae-c95c-8491-db5f05b0305c@intel.com>
 <CAMz4kuJVhNFUrDiwiRd-UJ_JnsbxQaV-dE_97m32B+5_53kteg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6006e00f-4591-6fd1-425f-5bfcc8790e36@intel.com>
Date:   Mon, 15 Jul 2019 15:37:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJVhNFUrDiwiRd-UJ_JnsbxQaV-dE_97m32B+5_53kteg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/07/19 2:37 PM, Baolin Wang wrote:
> Hi Adrian,
> 
> On Mon, 15 Jul 2019 at 19:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/07/19 1:58 PM, Baolin Wang wrote:
>>> In sdhci_runtime_resume_host() function, we will always do software reset
>>> for all, but according to the specification, we should issue reset command
>>> and reinitialize the SD/eMMC card.
>>
>> Where does it say that?
> 
> I checked the SD host controller simplified specification Ver4.20, and
> in Page 75, Software Reset For All bit, it says "if this bit is set
> to1, the host driver should issue reset command and  reinitialize the
> SD card". (I did not check other versions).

That might simply be assuming that the bus power also controls the card power.

> 
>>
>>>                                    However, we only do reinitialize the
>>> SD/eMMC card when the SD/eMMC card are power down during runtime suspend.
>>>
>>> Thus for those platforms that do not power down the SD/eMMC card during
>>> runtime suspend, we should not do software reset for all.
>>>                                                           To fix this
>>> issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
>>> to decide if we can do software reset for all or just reset command
>>> and data lines.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 9715834..470c5e0 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>>>                       host->ops->enable_dma(host);
>>>       }
>>>
>>> -     sdhci_init(host, 0);
>>> +     sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));
>>
>> We have done a full reset for a long time, so it would be surprising to need
>> to change it.
>>
>> What problem is it causing?
> 
> If we did not power down the SD card during runtime suspend, and we
> reset for all when runtime resume, our SD host controller can not work
> well, will meet some strange behavior, like:
> 
> [    6.525397] mmc0: Got data interrupt 0x00000002 even though no data
> operation was in progress.
> [    6.534189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    6.540797] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000004
> [    6.547413] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
> [    6.554029] mmc0: sdhci: Argument:  0x03200101 | Trn mode: 0x00000033
> [    6.560645] mmc0: sdhci: Present:   0x01f000f0 | Host ctl: 0x00000030
> [    6.567262] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
> [    6.573877] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [    6.580493] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [    6.587109] mmc0: sdhci: Int enab:  0x037f000b | Sig enab: 0x037f000b
> [    6.593726] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [    6.600342] mmc0: sdhci: Caps:      0x1c6d0080 | Caps_1:   0x08000007
> [    6.606959] mmc0: sdhci: Cmd:       0x0000061b | Max curr: 0x00ffffff
> [    6.613574] mmc0: sdhci: Resp[0]:   0x00001201 | Resp[1]:  0x00000000
> [    6.620190] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    6.626806] mmc0: sdhci: Host ctl2: 0x00003807
> [    6.631364] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000df062000
> [    6.638697] mmc0: sdhci: ============================================
> [    6.645379] mmc0: cache flush error -84
> 
> Got data interrupt but no data commands are processing now. With this
> patch, then our SD host controller can work well. Did I miss anything
> else? Thanks.

The response seems to show the card in state 9 bus-testing, which would
suggest the use of CMD19 for eMMC.  Perhaps the wrong command is used for
eMMC re-tuning?

The difficulty with changing long standing flow is that it might reveal
problems for other existing hardware.  Did you consider making a
driver-specific change?  The ->reset() callback could be used.
