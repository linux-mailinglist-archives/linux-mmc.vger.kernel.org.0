Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C70180CBC
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCKATR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 10 Mar 2020 20:19:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10359 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCKATR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 20:19:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e682e770000>; Tue, 10 Mar 2020 17:19:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 10 Mar 2020 17:19:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 10 Mar 2020 17:19:16 -0700
Received: from [10.2.175.232] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar
 2020 00:19:15 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com>
 <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com>
 <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com>
 <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com>
 <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
 <0301bbd5-8d4d-4a77-42c7-8a1391c2d60a@nvidia.com>
 <CAPDyKFp93H0=ttazofW9NMBtL5VnjB4PdkwN0FDCtWR0pMHrPA@mail.gmail.com>
 <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com>
 <CAPDyKFqJjsuHect-azQKO8cCoq5JJQrZ=eShsdLHq97NXgXnuQ@mail.gmail.com>
 <227d9f08-582e-fd79-e1dc-7695bddd162d@nvidia.com>
 <2456654f-2724-0b6d-8936-afa05f345344@nvidia.com>
 <df939962-2cb4-1c36-0baf-d82e3527d05a@nvidia.com>
Message-ID: <41348c8f-6bc7-a5a3-e1ed-9143f60cbdae@nvidia.com>
Date:   Tue, 10 Mar 2020 17:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <df939962-2cb4-1c36-0baf-d82e3527d05a@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583885943; bh=2e2I880Je2/5JSweQkCP1utti59vYA+9B+zzD06/JIA=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RZBtsU2uPCJump1bxE5UmlWFnvuZh519Sr3GUfYlfhlvE+nqWdXvpYlw7O8CiiOAW
         mxRN+v2d2szBj6yfQVdq0Gf9RyxqhshhGgi+5fxJIW/sI36Ix5gww02PiPh4XthPDY
         DwHJdOja8tXqtO9wgwwHrAnkBOuQhKDt4lzIeT20/FuKWTmukD/dmnNBxVeRqiFs94
         NC7u6horjZhr347QubXdSdZIOaiPHY91OgFNsu8SaP7jX314+HRAaZIwZ+uESIzaC7
         2dPsXwgkowc0SEo7gjFmq4mcR+VgXp8/6xH5g2b+ghmYERKAQOp0X1Hh8/v3tc49Io
         Bgw4GUC5/GkRA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 3/10/20 4:10 PM, Sowjanya Komatineni wrote:
>
> On 3/10/20 2:59 PM, Sowjanya Komatineni wrote:
>>
>> On 3/10/20 10:27 AM, Sowjanya Komatineni wrote:
>>>
>>> On 3/10/20 10:09 AM, Ulf Hansson wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> [...]
>>>>
>>>>>>>> I would like to get the regression fixed asap, but I also would 
>>>>>>>> like
>>>>>>>> to avoid reverting patches, unless really necessary. May I 
>>>>>>>> propose the
>>>>>>>> following two options.
>>>>>>>>
>>>>>>>> 1. Find out why polling with ->card_busy() or CMD13, for a CMD6 
>>>>>>>> with
>>>>>>>> an R1 response doesn't work - and then fix that behaviour.
>>>>>>>>
>>>>>>>> 2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which 
>>>>>>>> makes
>>>>>>>> the core to always use R1B for CMD6 (and erase). This also 
>>>>>>>> means that
>>>>>>>> when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra 
>>>>>>>> must
>>>>>>>> disable the HW busy timeout and just wait "forever".
>>>>>>>>
>>>>>>>> If you decide for 2, you can add the software timeout support 
>>>>>>>> on top,
>>>>>>>> but make that can be considered as a next step of an improvement,
>>>>>>>> rather than needed as fix. Note that, I believe there are some 
>>>>>>>> support
>>>>>>>> for software timeout already in the sdhci core, maybe you need to
>>>>>>>> tweak it a bit for your case, I don't know.
>>>>>>>>
>>>>>>>> Kind regards
>>>>>>>> Uffe
>>>>>>> Hi Uffe
>>>>>>>
>>>>>>> Will go with 2nd option and will send patches out when ready.
>>>>>> Okay, good.
>>>>>>
>>>>>>> BTW, Tegra host also supports 
>>>>>>> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for
>>>>>>> data timeout based on host clock when using finite mode (HW busy
>>>>>>> detection based on DATA TIMEOUT count value when cmd operation 
>>>>>>> timeout
>>>>>>> is < 11s for tegra host).
>>>>>>>
>>>>>>> So, looks like we cant set host max_busy_timeout to 0 for Tegra 
>>>>>>> host to
>>>>>>> force R1B during SWITCH and SLEEP_AWAKE.
>>>>>>>
>>>>>>> So, was thinking to introduce host capability 
>>>>>>> MMC_CAP2_LONG_WAIT_HW_BUSY
>>>>>>> which can be used for hosts supporting long or infinite HW busy 
>>>>>>> wait
>>>>>>> detection and will update mmc and mmc_ops drivers to not allow 
>>>>>>> convert
>>>>>>> R1B to R1B for hosts with this capability during SLEEP_AWAKE and 
>>>>>>> SWITCH.
>>>>>> That seems reasonable, it becomes probably both easier and 
>>>>>> clearer by
>>>>>> adding a new host cap.
>>>>>>
>>>>>> In any case, let me help out and cook a patch for this for the core
>>>>>> part (I leave the sdhci change to you). It may be a bit tricky,
>>>>>> especially since I have currently queued a bunch of new changes for
>>>>>> v5.7, that enables more users of mmc_poll_for_busy() in the core.
>>>>>> Maybe I need to temporarily drop them, so we can fix these problems
>>>>>> first. I will check.
>>>>>>
>>>>>> Probably, I would also name the cap MMC_CAP_HW_NEED_RSP_BUSY, as 
>>>>>> that
>>>>>> seems to be describing the common problem we have for sdhci
>>>>>> omap/tegra.
>>>>>>
>>>>>> Finally, it seems like MMC_CAP_WAIT_WHILE_BUSY should be set for
>>>>>> sdhci- tegra, so while at it, perhaps you can cook a patch for 
>>>>>> that as
>>>>>> well.
>>>>>>
>>>>>> Kind regards
>>>>>> Uffe
>>>>> OK, I sent v1 yesterday. Please ignore them then.
>>>> Oh, I haven't seen them. In any case, I am ignoring them.
>>>>
>>>>> Will send out patches only for HW busy wait modes program based on 
>>>>> cmd
>>>>> timeout and WAIT_WHILE_BUSY enabled.
>>>> Great, thanks!
>>>>
>>>> Please help test the series I just posted as well, if you have the
>>>> time ofcourse.
>>>>
>>>> Kind regards
>>>> Uffe
>>>
>>> Sure,
>>>
>>> Thanks
>>>
>>> Sowjanya
>>
>>
>> mmc_sleep() also needs update to force R1B when host sets capability 
>> MMC_CAP_NEED_RSP_BUSY
>>
>>
> Tested patches and they work good.
>
Sent sdhci-tegra v2 patches

- includes busy wait mode programming based on cmd busy_timeout

- enables MMC_CAP_WAIT_WHILE_BUSY

Thanks

Sowjanya

