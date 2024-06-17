Return-Path: <linux-mmc+bounces-2567-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3490A33C
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 07:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970BEB210F0
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434ED161321;
	Mon, 17 Jun 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD+pPBvi"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B05C136;
	Mon, 17 Jun 2024 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600696; cv=none; b=XRiCcYz9XczemBvJ26cCaVA7KN2AKLpoMiaGWzRCvYgc1MFR0wAWcdrV7zxIWXS406Pa9hRiCw2vmBxFfYOnaQLaGYFB0sNWWNczzSaCDeBLYd6SpQrYyR6T2y01sGZhyvI86i3tlGT65sK/p/6A60AQGrEKhK4W1ho6KiazmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600696; c=relaxed/simple;
	bh=043SXihIIX6H+AqpbLyxyTgfjUrL448mBFwonFlmR60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7kREsbA+Mzn+JUsYRiE+h4YX6ASMlsYm71dFBhY7hckgidY/u7jaf/W4vKnPAifj/ResvimY2hAGvI7sYuoWZScbtlN3uqHvC3NKbCvCSc/v8Xhtt57zmlVcQ/if7iJt+bT5/JzpATzmW4AIvX1E52reOB5HA44g/L8qnTqEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD+pPBvi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718600694; x=1750136694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=043SXihIIX6H+AqpbLyxyTgfjUrL448mBFwonFlmR60=;
  b=HD+pPBviSFSLbGTJb1SMjNfJquj1GX2GfZ2l/J/zEgSxEedf2nkBpukx
   vFY8NGlO4i7E0TaoLz0keg1IQnG+AHExGu37KzUtmAYJGk9P7Vo+VEfpa
   /f+Fsp13zY702MsZtpvJuRV03kpBvCA+JtmUO4B1ENKTrVucsQNnPyeCE
   bI4KJ1cpt7C18ve4oASRbQMxGtnUVKex1W8ULfRPnr7oMGj4f4ApNxiiK
   kuQ1tALFowy6AdxIpMjMB1AKE+psod6UWenNGIghliPH0nTqmp648RUao
   iaNQHVZa39dgjZLJlteBGAWEt7ADkztuBOWyhTmyDvXE6EHC2r0VkRDvR
   A==;
X-CSE-ConnectionGUID: id/nYOiiS468Y9nOQclYnA==
X-CSE-MsgGUID: 4t7/bEARQI6Cg0gJtLiskg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15287704"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15287704"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 22:04:53 -0700
X-CSE-ConnectionGUID: TG7t0N6oTtSLTQo8b2MdUg==
X-CSE-MsgGUID: i1KkS8STR8OTK+dGM7hafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46010531"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 22:04:50 -0700
Message-ID: <3020280e-5e00-48f2-ae67-2260129ead9c@intel.com>
Date: Mon, 17 Jun 2024 08:04:45 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error
 Recovery
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com>
 <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
 <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com>
 <84c57084-eb9d-4d11-9c2f-2a4ded6290c6@intel.com>
 <CAK00qKAHuLKGtcUnv=pKyQ4bKe+HqM1rFCQMRxPrGH9Aeat6Qw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKAHuLKGtcUnv=pKyQ4bKe+HqM1rFCQMRxPrGH9Aeat6Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/06/24 21:40, Victor Shih wrote:
> On Fri, May 31, 2024 at 7:23 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 31/05/24 13:31, Victor Shih wrote:
>>> On Fri, May 24, 2024 at 2:54 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 22/05/24 14:08, Victor Shih wrote:
>>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>>
>>>>> Add UHS-II Auto Command Error Recovery functionality
>>>>> into the MMC request processing flow.
>>>>
>>>> Not sure what "auto" means here, but the commit message
>>>> should outline what the spec. requires for error recovery.
>>>>
>>>
>>> Hi, Adrian
>>>
>>>      I will add instructions in the v17 version.
>>>
>>> Thanks, Victor Shih
>>>
>>>>>
>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>> ---
>>>>>
>>>>> Updates in V16:
>>>>>  - Separate the Error Recovery mechanism from patch#7 to patch#8.
>>>>>
>>>>> ---
>>>>>
>>>>>  drivers/mmc/core/core.c    |  4 ++
>>>>>  drivers/mmc/core/core.h    |  1 +
>>>>>  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++++
>>>>>  include/linux/mmc/host.h   |  6 +++
>>>>>  4 files changed, 91 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 68496c51a521..18642afc405f 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>>>>>       while (1) {
>>>>>               wait_for_completion(&mrq->completion);
>>>>>
>>>>> +             if (host->ops->get_cd(host))
>>>>> +                     if (mrq->cmd->error || (mrq->data && mrq->data->error))
>>>>> +                             mmc_sd_uhs2_error_recovery(host, mrq);
>>>>
>>>> There are several issues with this:
>>>>
>>>> 1. It is not OK to start a request from within the request path
>>>> because it is recursive:
>>>>
>>>>    mmc_wait_for_req_done()                      <--
>>>>       mmc_sd_uhs2_error_recovery()
>>>>          sd_uhs2_abort_trans()
>>>>             mmc_wait_for_cmd()
>>>>                mmc_wait_for_req()
>>>>                   mmc_wait_for_req_done()       <--
>>>>
>>>> 2. The mmc block driver does not use this path
>>>>
>>>> 3. No need to always call ->get_cd() if there is no error
>>>>
>>>> It is worth considering whether the host controller could
>>>> send the abort command as part of the original request, as
>>>> is done with the stop command.
>>>>
>>>
>>> Hi, Adrian
>>>
>>>      1. It looks like just issuing a command in
>>> mmc_wait_for_req_done() will cause a recursion.
>>>          I will drop sd_uhs2_abort_trans() and
>>> sd_uhs2_abort_status_read() in the v17 version.
>>>      2. I have no idea about this part, could you please give me some advice?
>>
>> The mmc block driver sets the ->done() callback and so
>> mmc_wait_for_req_done() is never called for data transfers.
>>
>> That won't matter if the host controller handles doing
>> the abort command, as was suggested elsewhere.
>>
>>>      3. I will try to modify this part in the v17 version.
>>>
>>> Thanks, Victor Shih
>>>
>>>>> +
>>>>>               cmd = mrq->cmd;
>>>>>
>>>>>               if (!cmd->error || !cmd->retries ||
>>>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>>>> index 920323faa834..259d47c8bb19 100644
>>>>> --- a/drivers/mmc/core/core.h
>>>>> +++ b/drivers/mmc/core/core.h
>>>>> @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
>>>>>  int mmc_attach_sd(struct mmc_host *host);
>>>>>  int mmc_attach_sdio(struct mmc_host *host);
>>>>>  int mmc_attach_sd_uhs2(struct mmc_host *host);
>>>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq);
>>>>>
>>>>>  /* Module parameters */
>>>>>  extern bool use_spi_crc;
>>>>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
>>>>> index 85939a2582dc..d5acb4e6ccac 100644
>>>>> --- a/drivers/mmc/core/sd_uhs2.c
>>>>> +++ b/drivers/mmc/core/sd_uhs2.c
>>>>> @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>>>>>
>>>>>       return err;
>>>>>  }
>>>>> +
>>>>> +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
>>>>> +{
>>>>> +     struct mmc_request mrq = {};
>>>>> +     struct mmc_command cmd = {0};
>>>>> +     struct uhs2_command uhs2_cmd = {};
>>>>> +     int err;
>>>>> +
>>>>> +     mrq.cmd = &cmd;
>>>>> +     mmc->ongoing_mrq = &mrq;
>>>>> +
>>>>> +     uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
>>>>> +                       mmc->card->uhs2_config.node_id;
>>>>> +     uhs2_cmd.arg = ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
>>>>> +                     UHS2_NATIVE_CMD_WRITE |
>>>>> +                     (UHS2_DEV_CMD_TRANS_ABORT >> 8);
>>>>> +
>>>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
>>>>> +     err = mmc_wait_for_cmd(mmc, &cmd, 0);
>>>>> +
>>>>> +     if (err)
>>>>> +             pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
>>>>> +                    mmc_hostname(mmc), __func__, err);
>>>>> +}
>>>>> +
>>>>> +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
>>>>> +{
>>>>> +     struct mmc_request mrq = {};
>>>>> +     struct mmc_command cmd = {0};
>>>>> +     struct uhs2_command uhs2_cmd = {};
>>>>> +     int err;
>>>>> +
>>>>> +     mrq.cmd = &cmd;
>>>>> +     mmc->ongoing_mrq = &mrq;
>>>>> +
>>>>> +     uhs2_cmd.header = UHS2_NATIVE_PACKET |
>>>>> +                       UHS2_PACKET_TYPE_CCMD |
>>>>> +                       mmc->card->uhs2_config.node_id;
>>>>> +     uhs2_cmd.arg = ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
>>>>> +                     UHS2_NATIVE_CMD_READ |
>>>>> +                     UHS2_NATIVE_CMD_PLEN_4B |
>>>>> +                     (UHS2_DEV_STATUS_REG >> 8);
>>>>> +
>>>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
>>>>> +     err = mmc_wait_for_cmd(mmc, &cmd, 0);
>>>>> +
>>>>> +     if (err)
>>>>> +             pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
>>>>> +                    mmc_hostname(mmc), __func__, err);
>>>>> +}
>>>>> +
>>>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq)
>>>>> +{
>>>>> +     mmc->ops->uhs2_reset_cmd_data(mmc);
>>>>
>>>> The host controller should already have done any resets needed.
>>>> sdhci already has support for doing that - see host->pending_reset
>>>>
>>>
>>> Hi, Adrian
>>>
>>>      I'm not sure what this means. Could you please give me more information?
>>
>> sdhci_uhs2_request_done() checks sdhci_needs_reset() and does
>> sdhci_uhs2_reset().
>>
>> sdhci_needs_reset() does not cater for data errors because
>> the reset for data errors is done directly in what becomes
>> __sdhci_finish_data_common().
>>
>> You may need to:
>>  1. add a parameter to __sdhci_finish_data_common() to
>>  skip doing the sdhci reset and instead set
>>  host->pending_reset
>>  2. amend sdhci_uhs2_request_done() to check for data error
>>  also to decide if a reset is needed
>>
> 
> Hi, Adrian
> 
> If there is any mistake in my understanding, please help me correct it.
> My understanding is as follows:
> 
> static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> {
>       ...
>       if (sdhci_needs_reset(host, mrq)) {
>             ...
>             if (mrq->cmd->error || (mrq->data && mrq->data->error))
>                   sdhci_uhs2_reset_cmd_data(host->mmc);
>             ...
>       }
>       ...
> }

Like this:

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 47180429448b..3cb5fe1d488c 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -581,7 +581,7 @@ static void sdhci_uhs2_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data = host->data;
 
-	__sdhci_finish_data_common(host);
+	__sdhci_finish_data_common(host, true);
 
 	__sdhci_finish_mrq(host, data->mrq);
 }
@@ -932,6 +932,12 @@ static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
  *                                                                           *
 \*****************************************************************************/
 
+static bool sdhci_uhs2_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	return sdhci_needs_reset(host, mrq) ||
+	       (!(host->flags & SDHCI_DEVICE_DEAD) && mrq->data && mrq->data->error);
+}
+
 static bool sdhci_uhs2_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
@@ -963,7 +969,7 @@ static bool sdhci_uhs2_request_done(struct sdhci_host *host)
 	 * The controller needs a reset of internal state machines
 	 * upon error conditions.
 	 */
-	if (sdhci_needs_reset(host, mrq)) {
+	if (sdhci_uhs2_needs_reset(host, mrq)) {
 		/*
 		 * Do not finish until command and data lines are available for
 		 * reset. Note there can only be one other mrq, so it cannot
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ed55aab24f92..55f0db0fc007 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1563,7 +1563,7 @@ void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
 
-void __sdhci_finish_data_common(struct sdhci_host *host)
+void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1576,7 +1576,9 @@ void __sdhci_finish_data_common(struct sdhci_host *host)
 	 * conditions.
 	 */
 	if (data->error) {
-		if (!host->cmd || host->cmd == data_cmd)
+		if (defer_reset)
+			host->pending_reset = true;
+		else if (!host->cmd || host->cmd == data_cmd)
 			sdhci_reset_for(host, REQUEST_ERROR);
 		else
 			sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
@@ -1604,7 +1606,7 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 {
 	struct mmc_data *data = host->data;
 
-	__sdhci_finish_data_common(host);
+	__sdhci_finish_data_common(host, false);
 
 	/*
 	 * Need to send CMD12 if -
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 576b8de2c04e..5ac5234fecf0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -840,7 +840,7 @@ void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
 bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
-void __sdhci_finish_data_common(struct sdhci_host *host);
+void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset);
 bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);


> 
> I have another question. the sdhci_uhs2_request_done() belongs to the patch#18.
> Can the above content be modified directly in the patch#18?
> Or does it need to be separated into another patch?

Please update the existing patches.

> 
> Thanks, Victor Shih
> 
>>>
>>> Thanks, Victor Shih
>>>
>>>>> +
>>>>> +     if (mrq->data) {
>>>>> +             if (mrq->data->error && mmc_card_uhs2(mmc)) {
>>>>> +                     if (mrq->cmd) {
>>>>> +                             switch (mrq->cmd->error) {
>>>>> +                             case ETIMEDOUT:
>>>>> +                             case EILSEQ:
>>>>> +                             case EIO:
>>>>> +                                     sd_uhs2_abort_trans(mmc);
>>>>> +                                     sd_uhs2_abort_status_read(mmc);
>>>>
>>>> What is the purpose of sd_uhs2_abort_status_read() here?
>>>> It is not obvious it does anything.
>>>>
>>>
>>> Hi, Adrian
>>>
>>>      sd_uhs2_abort_status_read() seems to only have read status,
>>>      I will drop this in the v17 version.
>>>
>>> Thanks, Victor Shih
>>>
>>>>> +                                     break;
>>>>> +                             default:
>>>>> +                                     break;
>>>>> +                             }
>>>>> +                     }
>>>>> +             }
>>>>> +     } else {
>>>>> +             if (mrq->cmd) {
>>>>> +                     switch (mrq->cmd->error) {
>>>>> +                     case ETIMEDOUT:
>>>>> +                             sd_uhs2_abort_trans(mmc);
>>>>> +                             break;
>>>>> +                     }
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>> index fc9520b3bfa4..c914a58f7e1e 100644
>>>>> --- a/include/linux/mmc/host.h
>>>>> +++ b/include/linux/mmc/host.h
>>>>> @@ -271,6 +271,12 @@ struct mmc_host_ops {
>>>>>        * negative errno in case of a failure or zero for success.
>>>>>        */
>>>>>       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
>>>>> +
>>>>> +     /*
>>>>> +      * The uhs2_reset_cmd_data callback is used to excute reset
>>>>> +      * when a auto command error occurs.
>>>>> +      */
>>>>> +     void    (*uhs2_reset_cmd_data)(struct mmc_host *host);
>>>>>  };
>>>>>
>>>>>  struct mmc_cqe_ops {
>>>>
>>


