Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72251EB253
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jun 2020 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgFAXpJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jun 2020 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAXpJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 19:45:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15248C03E96B
        for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2020 16:45:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a4so4177887pfo.4
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2020 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vyPoEsv/I2eVK5hwqA65rBsDKDslWsx71fcvG+8KNzI=;
        b=KFDU8BIWZM2FNNx2CqO8lpaacvWwk2jR6xt4klFY9SPrk078rsBQO6vevOgBTREXeQ
         MPydLEn7j+War6lLMILSnmPqObBhbU5VNG1d6IMh3XqqhakAzexd1Yo+WgbZ/um792rF
         uD1UfurdQX7B0etPmjqaFGIlXrGVcbPPai3b1rhdjlx6JYFMB/d73sdaZ9BuekPJQxle
         AcHqUQakuLeNdBBfCuAHTcdHk1Fo9bz/zAxyT75bE9VHMWENBK6H58sSYH3/c3Bc4IPH
         uBk6M4kLgvkTnInP9uhgx62aqQY5G4DpW4ejrEOpJ5naN75F1lTLTi09arXpVM1815t1
         f01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vyPoEsv/I2eVK5hwqA65rBsDKDslWsx71fcvG+8KNzI=;
        b=nKA4/tu2sxpLQbCZFYwYQNxHHu6KG1vIAYe4n5fQbUxk3QiRn/4DJzFGYRFV9eixf7
         p04yUJznZPbzkgl7t2pfcccq5tqjV+W+nK7qe+YVQ05ZwBoQ/fT+UkbH1J3o/iz/utfd
         DRFwn9xhwcSZO0dqDY21Q2CVH4Qv3G1B+pptHfmBdUzkwRDDaitudo5hyEQVSPox1lIY
         +S2PA4+jHUx+aXnZcDEXEkT1UB/mY6OSITIfPmpQCRQD7IwrAuo6opF54IHjqUochi7h
         kbnEDpFUgfccOA980b98+41HVPybzsKHmFY5teC0cPReFbrZ1xdN5LHW9dpS2dBvL68l
         ku0w==
X-Gm-Message-State: AOAM530e6E+q9jJMVRwCw+rlePC4ePII5+wwdfKIpFwWQzLr5uD7s3I4
        ltNnGGLs8+O3cs+k7oGaHyR+wQ==
X-Google-Smtp-Source: ABdhPJzrJvPQVF0Gp8Rx9FtbrvnFWhyn3akXwf1d7cQZcylnZ/5ViHG1/YqXoOvQw8fykt0bg/4N7w==
X-Received: by 2002:a63:5d62:: with SMTP id o34mr21024673pgm.420.1591055106759;
        Mon, 01 Jun 2020 16:45:06 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z29sm439937pff.120.2020.06.01.16.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 16:45:06 -0700 (PDT)
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200528081003.238804-1-linus.walleij@linaro.org>
 <20200601074957.GE1181806@T590>
 <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
 <20200601115818.GB1190838@T590>
 <CAPDyKFq2paDu9ogEFh6VXWq8___FLeEaNyBWhkMSdpZYpEytQQ@mail.gmail.com>
 <7f9aaf69b24b794ca4c9c126eb2394862e276c73.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bda7563-fc47-e049-ed55-265f58ae522c@kernel.dk>
Date:   Mon, 1 Jun 2020 17:45:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7f9aaf69b24b794ca4c9c126eb2394862e276c73.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/1/20 5:37 PM, Damien Le Moal wrote:
> On Mon, 2020-06-01 at 14:53 +0200, Ulf Hansson wrote:
>> On Mon, 1 Jun 2020 at 13:58, Ming Lei <ming.lei@redhat.com> wrote:
>>> On Mon, Jun 01, 2020 at 01:36:54PM +0200, Linus Walleij wrote:
>>>> On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
>>>>> On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
>>>>>> The Kyber block scheduler is not suitable for single hardware
>>>>>> queue devices, so add a new flag for single hardware queue
>>>>>> devices and add that to the deadline and BFQ schedulers
>>>>>> so the Kyber scheduler will not be selected for single queue
>>>>>> devices.
>>>>>
>>>>> The above may not be true for some single hw queue high performance HBA(
>>>>> such as megasas), which can get better performance from none, so it is
>>>>> reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
>>>>> issue directly if hw queue isn't busy in case of 'none'"), and the
>>>>> following link:
>>>>>
>>>>> https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/
>>>>
>>>> I see, but isn't the case rather that none is preferred and kyber gives
>>>> the same characteristics because it's not standing in the way
>>>> as much?
>>>
>>> Kyber has its own characteristic, such as fair read & write, better
>>> IO merge. And the decision on scheduler isn't only related with device,
>>> but also with workloads.
>>>
>>>> It looks like if we should add a special flag for these devices with
>>>> very fast single queues so they can say "I prefer none", do you
>>>> agree?
>>>
>>> I am not sure if it is easy to add such flag, because it isn't only
>>> related with HBA, but also with the attached disks.
>>>
>>
>> In general I don't mind the idea of giving hints from lower layer
>> block devices, about what kind of scheduling algorithm that could make
>> sense (as long it's on a reasonable granularity).
>>
>> If I understand your point correctly, what you are saying is that it
>> isn't easy or even possible for some block devices HWs. However, that
>> should be fine, as it wouldn't be mandatory to set this kind of flags,
>> but
>> instead could help where we see it fit, right?
> 
> The elevator features flag was implemented not as a hint, but as hard
> requirements for elevators that are needed (mandatory) for a particular
> device type for correct operation. By correct operation, I mean "no IO
> errors or weird behavior resulting in errors such as timeouts". Until
> now, the only hard requirement we have is for zoned block devices which
> need mq-deadline to guarantee in-order dispatch of write commands (for
> sequential zones writing).
> 
> We definitely could add hint flags to better help the block layer
> decide on the default optimal elevator for a particular device type,
> but as is, the elevator features will completely prevent the use of any
> other elevator that does not have the feature set. Those elevators will
> not be seen in /sys/block/<dev>/queue/scheduler. This may be a little
> too much for hint level rather than hard requirement.
> 
> Furthermore, as Ming said, this depends on the HBA too rather than just
> the device itself. E.g. the smartpqi driver (Microsemi SAS HBAs)
> exposes single hard-disks as well as fast RAID arrays as multi-queue
> devices. While kyber may make sense for the latter, it probably does
> not make much sense for the former.
> 
> In kernel vs udev rules for setting the optimal elevator for a
> particular device type should also be considered.

Agree, the elevator flags are hard requirements, which doesn't match
what this patch is trying to do. There's absolutely nothing wrong with
using none or kyber on single queue devices, hence it should be possible
to configure it as such.

-- 
Jens Axboe

