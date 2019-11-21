Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C67105185
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Nov 2019 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKULg7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Nov 2019 06:36:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:19445 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKULg6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Nov 2019 06:36:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 03:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="205123654"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 03:36:57 -0800
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     "Y.b. Lu" <yangbo.lu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
 <CAPDyKFo16PZHd-0vAvBg6FCbGvrgsarPe5h=EcR3rCtRi27SWA@mail.gmail.com>
 <VI1PR0401MB22374449D6FEC683E08BDF99F84E0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9e692f0b-6bac-6be8-bc82-5d47930dd4e2@intel.com>
Date:   Thu, 21 Nov 2019 13:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB22374449D6FEC683E08BDF99F84E0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/11/19 4:21 AM, Y.b. Lu wrote:
> Hi, 
> 
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: Thursday, November 14, 2019 9:54 PM
>> To: Y.b. Lu <yangbo.lu@nxp.com>
>> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>
>> Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
>>
>> On Thu, 14 Nov 2019 at 12:18, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>>>
>>> The STOP command is disabled for multiple blocks r/w commands with
>>> auto CMD12, when start to send. However, if there is data error,
>>> software still needs to send CMD12 according to SD spec.
>>> This patch is to allow software CMD12 sending for this case.
>>>
>>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 17 +++--------------
>>>  1 file changed, 3 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>>> 09cdbe8..3041c39 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct
>>> sdhci_host *host)
>>>
>>>         /*
>>>          * Need to send CMD12 if -
>>> -        * a) open-ended multiblock transfer (no CMD23)
>>> +        * a) open-ended multiblock transfer not using auto CMD12 (no
>>> + CMD23)
>>>          * b) error in multiblock transfer
>>>          */
>>>         if (data->stop &&
>>> -           (data->error ||
>>> -            !data->mrq->sbc)) {
>>> +           ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
>>> +            data->error)) {
>>
>> Per your other reply to this thread, I don't think there is any harm in always
>> sending a CMD12 if there is an error, at least from the card's point of view.
>>
>> The worst thing that can happen is that there are two CMD12 sent to the card
>> and I don't think that is a problem for the error path.
>>
>> My only concern, is to understand if $subject patch causes other changes in
>> behaviours for the SDHCI driver. Let's see what Adrian thinks.
> 
> [Y.b. Lu] Yes. The purpose is to avoid no CMD12 sent if get data error. That will makes block driver failed at block r/w recovery when sending CMD13 to get status.
> Our platform on some boards at old kernel 4.14 seems to hit this case.
> 
> Hi Adrian,
> Could you help to review the changes?

I don't think the auto-cmd12 error handling was ever done properly, so it
will take we a while to review it.
