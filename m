Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBB4FF5BB
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Apr 2022 13:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiDMLeJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Apr 2022 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiDMLeI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2022 07:34:08 -0400
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E30D4FC4E
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 04:31:44 -0700 (PDT)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id IHT00136;
        Wed, 13 Apr 2022 19:31:36 +0800
Received: from [172.16.35.4] (172.16.35.4) by GCY-MBS-28.TCL.com (10.136.3.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 13 Apr
 2022 19:31:37 +0800
Message-ID: <fd1d9390-5b05-7f0c-3a50-9237382a8053@tcl.com>
Date:   Wed, 13 Apr 2022 19:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mmc: avoid livelock in mmc_sd_detect
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <tang.ding@tcl.com>,
        <mingbo.feng@tcl.com>
References: <4d7327802d17f84af9b03d89ef5b7726@sslemail.net>
 <CAPDyKFoODtEU6SACMX1WOtqYTUKssWN88Ge2PrLz4RDhez43sQ@mail.gmail.com>
From:   Wu Yan <wu-yan@tcl.com>
In-Reply-To: <CAPDyKFoODtEU6SACMX1WOtqYTUKssWN88Ge2PrLz4RDhez43sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.35.4]
X-ClientProxiedBy: GCY-EXS-01.TCL.com (10.74.128.151) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   2022413193136fdc33dfb791cdee1a8d1579b0811f3a2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/13/22 19:12, Ulf Hansson wrote:
> On Wed, 13 Apr 2022 at 10:07, Rokudo Yan <wu-yan@tcl.com> wrote:
>>
>> There is a potential livelock when mmc_sd_detect is invoked by
>> pm_suspend, as below:
>>
>> [thread do suspend]
>> state_store
>>   -pm_suspend
>>    -__pm_notifier_call_chain
>>     -mmc_pm_notify
>>      -cancel_delayed_work_sync(&host->detect)
>>       -__cancel_work_timer
>>        -__flush_work
>>         -wait_for_completion
>>         wait for detect work current running to complete
>>
>> [kworker run detect work]
>> process_one_work
>>   -mmc_rescan
>>    -mmc_sd_detect
>>     -mmc_get_card
>>      -__mmc_claim_host
>>       -schedule
>>       wait for current host claimer release
>>
>> [kworker dispatch io (current host claimer)]
>> process_one_work
>>   -blk_mq_run_work_fn
>>    -__blk_mq_run_hw_queue
>>     -blk_mq_sched_dispatch_requests
>>      -blk_mq_do_dispatch_sched
>>       -blk_mq_dispatch_rq_list
>>        -mmc_mq_queue_rq
>>         -mmc_get_card -- claim mmc host if inflight=1 (the first io)
>>                          and only release when all ios complete
>>         -mmc_blk_mq_issue_rq
>>
>> if there are continous io requests in the system to keep queue busy
>> (inflight !=0 all the time), the supsend process will blocked and
>> hang the system.
>>
>> This issue can reproduced by steps below:
>> 1. prepare 1 SD card
>> 2. run fio to keep the card io busy
>>    fio --size=1m --bs=32k --ioengine=libaio --iodepth=64 \
>>      --direct=1 --rw=read --time_based --runtime=60000 \
>>      --name=test --filename=<path under sd card>
>> 3. suspend the system (echo mem > /sys/power/state)
>> 4. resume the system
>> 5. suspend the system again & device hang
>>
>> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
> 
> I believe you are running some vendor/old kernel, because I think this
> problem has been fixed.
> 
> You may have a look at commit 17a17bf50612 ("mmc: core: Fix hanging on
> I/O during system suspend for removable cards")
> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/mmc/core/queue.c | 8 ++++++++
>>   drivers/mmc/core/sd.c    | 2 ++
>>   include/linux/mmc/host.h | 3 +++
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>> index c69b2d9df6f1..f00fc45a4fd5 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -241,6 +241,14 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>>                  return BLK_STS_IOERR;
>>          }
>>
>> +       /*
>> +        * requeue the io if sd detect is on-going to avoid livelock
>> +        * when mmc_sd_detect is invoked by pm_suspend and there are
>> +        * continous io requests simultaneously.
>> +        */
>> +       if (host->doing_sd_detect)
>> +               return BLK_STS_RESOURCE;
>> +
>>          issue_type = mmc_issue_type(mq, req);
>>
>>          spin_lock_irq(&mq->lock);
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 68df6b2f49cc..460ea6ab9aba 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1594,6 +1594,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>>   {
>>          int err;
>>
>> +       host->doing_sd_detect = true;
>>          mmc_get_card(host->card, NULL);
>>
>>          /*
>> @@ -1611,6 +1612,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>>                  mmc_power_off(host);
>>                  mmc_release_host(host);
>>          }
>> +       host->doing_sd_detect = false;
>>   }
>>
>>   static int sd_can_poweroff_notify(struct mmc_card *card)
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 7afb57cab00b..4abfc5d7ef20 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -501,6 +501,9 @@ struct mmc_host {
>>          /* Host Software Queue support */
>>          bool                    hsq_enabled;
>>
>> +       /* indicate SD detect on-going */
>> +       bool                    doing_sd_detect;
>> +
>>          unsigned long           private[] ____cacheline_aligned;
>>   };
>>
>> --
>> 2.25.1
>>

Hi, Uffe

Thanks for reply, the kernel version used in our device is kernel-4.19
And the patch you mentioned is not applied, I will try to apply the patch.

Thanks
yanwu
