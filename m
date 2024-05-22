Return-Path: <linux-mmc+bounces-2127-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C58CBD87
	for <lists+linux-mmc@lfdr.de>; Wed, 22 May 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3FA1C22217
	for <lists+linux-mmc@lfdr.de>; Wed, 22 May 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD97FBBD;
	Wed, 22 May 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYBt1bVJ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371318EB1;
	Wed, 22 May 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369092; cv=none; b=BQd23sja3TD4REU19WlgklGbu4zT067x02ghvGgh9QraUFCAUSVplWxFHt5VYQ8osjVe0gZmqvqLnHFXXYUb0tdtD+hSAWH4dBD8cqyvWnShIJjvCZn7B01kUpb5uRmdWr+Qfj128hVIGzPbV4HSFDEx6Z9N/FdCKH7Oz82P4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369092; c=relaxed/simple;
	bh=SLLuwYwvNBy5QaCb4uCS/BgjjRjgOsdjjo0nfu0lW9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDGzzlaJi9Q83qgKN8TUo9qkZsM5SPiJnMHgdcSyJW5nTmvkC7XDVSKfKvfHHt/rvNYPPAZxe2pC8/RIzRoqe+cbiQfjfqNw19GA4l7tD3mmZbLLWmX61ioXVwsz9o0pN6ub56lmS/RfD1DFw8oxg0ZNROnifU1bfoZc1TMci/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYBt1bVJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716369091; x=1747905091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SLLuwYwvNBy5QaCb4uCS/BgjjRjgOsdjjo0nfu0lW9I=;
  b=fYBt1bVJEsjIJsgWOFl0Ck09cRXJaNqyq365t+jgwsx53vOom8R3LRSD
   K/iHb+I4vKMqf+d8V/pX443Swxv6PQPVWLJ6XKjfjQcXg9MIhgGOMtPZZ
   MlTGk3S2cRNR6jhmd8cbiZHU31mfs1/ONemcgfbNbiexlAyzT9b2rJDTt
   VOI5FYc2F7/sfqUDL5IcZb9COkE78q8Pv6JUAP0u19X22cJd/J0rKQ4MZ
   KQu91+BadNqM9AJoYOf+qn94P6JUv/2e4t9fC3dyiMnvPDvUx3lcNpoRd
   PKOjqGVmLxeB0i+WIHISBx3wbPtbevQMUwpCbAjKkG49jxjb/LpJ2y9ip
   w==;
X-CSE-ConnectionGUID: TpBt5+rqQPiOgQz69SpLOQ==
X-CSE-MsgGUID: RErODnXPQcaF5+vY9iwExw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23179957"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="23179957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:11:30 -0700
X-CSE-ConnectionGUID: zYN3389EQgyClTNc9a6S/w==
X-CSE-MsgGUID: YnfOgyyaTkyH+/qTQDPQ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33223532"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:11:27 -0700
Message-ID: <822f7274-5f34-4186-b859-938e0401caa8@intel.com>
Date: Wed, 22 May 2024 12:11:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 07/21] mmc: core: Support UHS-II card control and
 access
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 takahiro.akashi@linaro.org, dlunev@chromium.org,
 Jason Lai <jason.lai@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
 <20240123062827.8525-8-victorshihgli@gmail.com>
 <CAK00qKBf24CMFygfutpfxQwaKEQEo+FKv2XU4X_oxv38un-YEg@mail.gmail.com>
 <a81d0f82-ec9b-4ccf-b31b-9ef9d403ec6b@intel.com>
 <CAK00qKDzY7gSALrKLqdQg-JdwXDP6NDt17oAX2aoj4P-yfDkPA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKDzY7gSALrKLqdQg-JdwXDP6NDt17oAX2aoj4P-yfDkPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/05/24 12:04, Victor Shih wrote:
> On Tue, Jan 30, 2024 at 5:36 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 27/01/24 10:28, Victor Shih wrote:
>>> On Tue, Jan 23, 2024 at 2:28 PM Victor Shih <victorshihgli@gmail.com> wrote:
>>>>
>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>
>>>> Embed UHS-II access/control functionality into the MMC request
>>>> processing flow.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>> ---
>>>>
>>>> Updates in V13:
>>>>  - Separate __mmc_go_idle() into one patch for re-factorring the code.
>>>>  - Move mmc_decode_scr declaration to sd.h.
>>>>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
>>>>  - Drop unnecessary comment.
>>>>
>>>> Updates in V12:
>>>>  - Use mmc_op_multi() to check DCMD which supports multi read/write
>>>>    in mmc_uhs2_prepare_cmd().
>>>>
>>>> Updates in V10:
>>>>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
>>>>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
>>>>  - Drop do_multi in the mmc_blk_rw_rq_prep().
>>>>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
>>>>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
>>>>
>>>> Updates in V8:
>>>>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>>>>  - Modify return value in sd_uhs2_attach().
>>>>
>>>> Updates in V7:
>>>>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
>>>>  - Drop uhs2_state in favor of ios->timing.
>>>>  - Remove unnecessary functions.
>>>>
>>>> ---
>>>>
>>>>  drivers/mmc/core/core.c    |   10 +-
>>>>  drivers/mmc/core/sd.c      |   10 +-
>>>>  drivers/mmc/core/sd.h      |    5 +
>>>>  drivers/mmc/core/sd_ops.c  |    9 +
>>>>  drivers/mmc/core/sd_ops.h  |   17 +
>>>>  drivers/mmc/core/sd_uhs2.c | 1115 ++++++++++++++++++++++++++++++++++--
>>>>  include/linux/mmc/core.h   |   13 +
>>>>  include/linux/mmc/host.h   |   15 +
>>>>  8 files changed, 1155 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 2edf31492a5d..be77cebe1fb8 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>>>>
>>>>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>>>  {
>>>> +       struct uhs2_command uhs2_cmd;
>>>> +       __be32 payload[4]; /* for maximum size */
>>>>         int err;
>>>>
>>>>         init_completion(&mrq->cmd_completion);
>>>> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>>>         if (err)
>>>>                 return err;
>>>>
>>>> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
>>>> +
>>>>         led_trigger_event(host->led, LED_FULL);
>>>>         __mmc_start_request(host, mrq);
>>>>
>>>
>>> Hi, Adrian
>>>
>>> I referenced your comments of the V9:
>>>
>>> Refer:
>>> https://patchwork.kernel.org/project/linux-mmc/patch/20230721101349.12387-7-victorshihgli@gmail.com/
>>>
>>> My understanding is as follows, please correct me if there are any mistakes.
>>> There is already "struct uhs2_command *uhs2_cmd" in struct mmc_command.
>>> If I also put "__be32 payload[4]" in struct mmc_command.
>>> The code will become:
>>> mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd, mrq->cmd->payload);
>>> But a null pointer problem occurs when sending commands like COM0(mmc_go_idle).
>>> In this case I just can only plan for the time being as follows:
>>>
>>> if (mrq->cmd->uhs2_cmd)
>>>      mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd,
>>> mrq->cmd->payload);
>>> else
>>>      mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
>>>
>>> Would you give me any other advice?
>>
>> struct uhs2_command uhs2_cmd should not be on the stack local to
>> mmc_start_request().  Probably moving it to struct mmc_request
>> is as good as any other option.  So starting like below and
>> then with whatever other changes are needed to make it work.
>>
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index be77cebe1fb8..68496c51a521 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -334,8 +334,6 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>>
>>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>  {
>> -       struct uhs2_command uhs2_cmd;
>> -       __be32 payload[4]; /* for maximum size */
>>         int err;
>>
>>         init_completion(&mrq->cmd_completion);
>> @@ -353,7 +351,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>         if (err)
>>                 return err;
>>
>> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
>> +       mmc_uhs2_card_prepare_cmd(host, mrq);
>>
>>         led_trigger_event(host->led, LED_FULL);
>>         __mmc_start_request(host, mrq);
>> @@ -434,8 +432,6 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>>   */
>>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>>  {
>> -       struct uhs2_command uhs2_cmd;
>> -       __be32 payload[4]; /* for maximum size */
>>         int err;
>>
>>         /*
>> @@ -456,7 +452,7 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>>         if (err)
>>                 goto out_err;
>>
>> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
>> +       mmc_uhs2_card_prepare_cmd(host, mrq);
>>
>>         err = host->cqe_ops->cqe_request(host, mrq);
>>         if (err)
>> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
>> index d3a3465c7669..e3af68a52de8 100644
>> --- a/drivers/mmc/core/sd_ops.h
>> +++ b/drivers/mmc/core/sd_ops.h
>> @@ -24,14 +24,10 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
>>  void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
>>
>> -static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq,
>> -                                            struct uhs2_command uhs2_cmd, __be32 payload[4])
>> +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
>>  {
>> -       if (host->uhs2_sd_tran) {
>> -               uhs2_cmd.payload = payload;
>> -               mrq->cmd->uhs2_cmd = &uhs2_cmd;
>> +       if (host->uhs2_sd_tran)
>>                 mmc_uhs2_prepare_cmd(host, mrq);
>> -       }
>>  }
>>
>>  static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
>> index c46729d85644..9cabb6937dc1 100644
>> --- a/drivers/mmc/core/sd_uhs2.c
>> +++ b/drivers/mmc/core/sd_uhs2.c
>> @@ -1194,6 +1194,7 @@ void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
>>         u8 plen;
>>
>>         cmd = mrq->cmd;
>> +       cmd->uhs2_cmd = &mrq->uhs2_cmd;
>>         header = host->card->uhs2_config.node_id;
>>         if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
>>                 header |= UHS2_PACKET_TYPE_DCMD;
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index f30f6be86f66..83c901794c17 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -23,13 +23,18 @@ enum mmc_blk_status {
>>         MMC_BLK_NEW_REQUEST,
>>  };
>>
>> +#define UHS2_MAX_PAYLOAD_LEN 2
>> +#define UHS2_MAX_RESP_LEN 20
>> +
>>  struct uhs2_command {
>>         u16     header;
>>         u16     arg;
>> -       __be32  *payload;
>> -       u32     payload_len;
>> -       u32     packet_len;
>> +       __be32  payload[UHS2_MAX_PAYLOAD_LEN];
>> +       u8      payload_len;
>> +       u8      packet_len;     // TODO: is this really needed?
>>         u8      tmode_half_duplex;
>> +       u8      uhs2_resp_len;  /* UHS2 native cmd resp len */
>> +       u8      uhs2_resp[UHS2_MAX_RESP_LEN];   /* UHS2 native cmd resp */
>>  };
>>
>>  struct mmc_command {
>> @@ -119,8 +124,6 @@ struct mmc_command {
>>         struct mmc_request      *mrq;           /* associated request */
>>
>>         struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
>> -       u8                      *uhs2_resp;     /* UHS2 native cmd resp */
>> -       u8                      uhs2_resp_len;  /* UHS2 native cmd resp len */
>>  };
>>
>>  struct mmc_data {
>> @@ -179,6 +182,7 @@ struct mmc_request {
>>         const struct bio_crypt_ctx *crypto_ctx;
>>         int                     crypto_key_slot;
>>  #endif
>> +       struct uhs2_command     uhs2_cmd;
>>  };
>>
>>  struct mmc_card;
>>
>>
>>
> 
> Hi, Adrian
> 
> I have modified the above into patch#7 and patch#16 in the patch series v15.
> But I will submit the patch series v16 later.
> Please help review the changes in patch series v16.
> 
> Thanks, Victor Shih

If you make a V16, please separate the Error Recovery mechanism added in V15
into a separate patch.


