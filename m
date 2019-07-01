Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A193C901
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jun 2019 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfFKKcO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Jun 2019 06:32:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:31410 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbfFKKcN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Jun 2019 06:32:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 03:32:12 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2019 03:32:09 -0700
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
To:     Raul Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
Date:   Tue, 11 Jun 2019 13:30:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610163252.GA227032@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/06/19 7:32 PM, Raul Rangel wrote:
> On Mon, Jun 10, 2019 at 06:17:31PM +0200, Ulf Hansson wrote:
>> + Adrian
>>
>> On Fri, 7 Jun 2019 at 18:05, Raul Rangel <rrangel@chromium.org> wrote:
>>>
>>> On Tue, May 28, 2019 at 09:38:20AM +0200, Ulf Hansson wrote:
>>>> On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
>>>
>>> First off, thanks for the review.
>>>
>>>>>
>>>>> There is a race condition between resetting the SDHCI controller and
>>>>> disconnecting the card.
>>>>>
>>>>> For example:
>>>>> 0) Card is connected and transferring data
>>>>> 1) mmc_sd_reset is called to reset the controller due to a data error
>>>>
>>>> I assume you refer to mmc_sd_hw_reset()? In that case, I think you
>>>> have interpreted the purpose of mmc_sd_hw_reset() slightly wrong. It's
>>>> responsibility is to reset the SD-card and not the host/controller.
>>> You are correct. I was looking at a 4.14 kernel where it's called
>>> mmc_sd_reset. 4.19 and above call it mmc_sd_hw_reset.
>>>
>>> All I was trying to convey here was that a block error will eventually
>>> call sdhci_set_ios with SOFT_RESET_ALL via:
>>> mmc_blk_reset
>>> mmc_hw_reset
>>> mmc_sd_hw_reset
>>> mmc_power_cycle
>>> mmc_power_off
>>> mmc_set_initial_state
>>> sdhci_set_ios
>>> sdhci_reinit
>>> sdhci_init
>>> sdhci_do_reset(host, SDHCI_RESET_ALL);
>>>
>>>>
>>>> Whether there some additional "reset" of the controller needed, that
>>>> is assumed by the core, to be managed via the ->set_ios() callback for
>>>> the host.
>>>>
>>>>> 2) sdhci_set_ios calls sdhci_do_reset
>>>>> 3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
>>>>> configured.
>>>>> 4) Wait for SOFT_RESET_ALL to clear
>>>>> 5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
>>>>>    IRQs are not configured a CARD_REMOVED interrupt is never raised.
>>>>> 6) IRQs are enabled again
>>>>> 7) mmc layer never notices the device is disconnected. The SDHCI layer
>>>>>    will keep returning -ENOMEDIUM. This results in a card that is always
>>>>>    present and not functional.
>>>>
>>>> This sounds like host specific problems, which most likely should be
>>>> fixed in host driver, solely. Unless I am missing something, of
>>>> course.
>>>
>>> So in sdhci_do_reset we call the reset callback which is typically
>>> sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
>>> controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
>>> controller will clear the IRQ mask. If during that 100ms the card is
>>> removed there is no notification to the MMC system that the card was
>>> removed. So it seems like the card is always present.
>>
>> So you are saying that the problem occurs when the card is removed
>> during this 100ms period?
> Exactly. Thought I think most controllers reset fast enough to where
> that window is very small. But for this AMD controller we need to do a
> full reset which takes a while, so we can see the problem.
> 
>>
>> I assume there a way for sdhci to re-validate whether the card has
>> been removed during this period, right?
> I'll let Adrian chime in here.
> 
>>>
>>>>>  drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
>>>>>  1 file changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>> index 265e1aeeb9d8..9206c4297d66 100644
>>>>> --- a/drivers/mmc/core/sd.c
>>>>> +++ b/drivers/mmc/core/sd.c
>>>>> @@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>>>>>
>>>>>  static int mmc_sd_hw_reset(struct mmc_host *host)
>>>>>  {
>>>>> +       int present;
>>>>>         mmc_power_cycle(host, host->card->ocr);
>>>>> +
>>>>> +       present = host->ops->get_cd(host);
>>>>> +
>>>>> +       /* The card status could have changed while resetting. */
>>>>> +       if ((mmc_card_removed(host->card) && present) ||
>>>>> +           (!mmc_card_removed(host->card) && !present)) {
>>>>> +               pr_info("%s: card status changed during reset\n",
>>>>> +                      mmc_hostname(host));
>>>>> +               host->ops->card_event(host);
>>>>> +               mmc_detect_change(host, 0);
>>>>> +       }
>>>>> +
>>>>> +       /* Don't perform unnecessary transactions if the card is missing. */
>>>>> +       if (!present) {
>>>>> +               pr_info("%s: card was removed during reset\n",
>>>>> +                       mmc_hostname(host));
>>>>> +               return -ENOMEDIUM;
>>>>> +       }
>>>>> +
>>>>
>>>> When doing a  mmc_hw_reset() (which ends up calling mmc_sd_hw_reset()
>>>> in case of SD cards), we are making a final attempt to make the card
>>>> functional again, via a power cycle and a re-init of it.
>>>>
>>>> In this path, we don't care whether the card is removed, as that
>>>> should have been detected already when the block layer calls
>>>> mmc_detect_card_removed().
>>>
>>> mmc_detect_card_removed has the guard `host->detect_change` to
>>> prevent it from checking the card status again. So maybe the fix to the
>>> missing interrupt/race condition is to set `host->detect_change = 1`
>>> from sdhci_do_reset after calling the reset handler. This way there will
>>> always be a single poll after a full reset so the correct card status can
>>> be detected?
>>
>> It sounds like you should call mmc_detect_change(), after the reset to
>> let the core check for cards that may have been removed/inserted.
>>
>> Would that work?
> Yeah, I could add `mmc_detect_change()` to the AMD SDHCI patch. I just
> thought it would be better to fix the potential race condition at a
> higher level. Though I'm happy to move it to the AMD patch. Let me know.

Does the following work?


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0cd5f2ce98df..f672171246b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -341,8 +341,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
+	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+
 	sdhci_init(host, 0);
 	sdhci_enable_card_detection(host);
+
+	/*
+	 * A change to the card detect bits indicates a change in present state,
+	 * refer sdhci_set_card_detection(). A card detect interrupt might have
+	 * been missed while the host controller was being reset, so trigger a
+	 * rescan to check.
+	 */
+	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
+		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
 
 static void __sdhci_led_activate(struct sdhci_host *host)
