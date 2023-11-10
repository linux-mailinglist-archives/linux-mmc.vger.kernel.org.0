Return-Path: <linux-mmc+bounces-17-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F917E831D
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Nov 2023 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F074D1F20F23
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Nov 2023 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B13B2A1;
	Fri, 10 Nov 2023 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LsJxHE+5"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE63B291
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 19:57:37 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE154680;
	Fri, 10 Nov 2023 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699646255; x=1731182255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nkvcs2/H42c26doKnxH/D1cFh+z3QsIbk+lwK6e/USY=;
  b=LsJxHE+5EUXKDqnkk0ZDhCTzayuA//uT5ZxXZlzHxmH+vPLlfNZkGPv2
   oi53dUVkTO4xgiwNnY4BKbsso5CbNedTS2g8LqviJ8qbhppA1YVzYH3tH
   5aNrtnCMSojfdxU9wwRzx4c4Tx0Ml06hrqMVH9tzcDZB2ICOrIFx2Z7rD
   wzCtaho6zJkkz3sU/LB5Kst5d5RI//YA4XtoY/fkzGEaSmCGSWB66xDVH
   EGVeAnHPzrK0eIfISGs3uwvKE2VAKByLeycuBqwggZTGYlO+NMo9gIa39
   wGexhel5Qz5B6wCeoP3ESyYx/A3SJRdQ+5wdJojoMvG1PwJTu6ezG2o8e
   w==;
X-CSE-ConnectionGUID: ZV2abMu8TMOAGnGVzINlmw==
X-CSE-MsgGUID: iNCO9jdATGGE6EqYoA0jjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="178676488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2023 12:57:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Nov 2023 12:57:13 -0700
Received: from [10.171.248.20] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 10 Nov 2023 12:57:11 -0700
Message-ID: <c8178e61-31c1-4eb3-9d04-7aa70ed18634@microchip.com>
Date: Fri, 10 Nov 2023 20:57:10 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Fix force card detect in sdhci
To: Mathieu Moneyron <mathieu.moneyron@gmail.com>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Eugen Hristev <eugen.hristev@collabora.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
 <096e9122-23b8-5a36-7779-28994187c620@intel.com>
 <9a311ce3-0d29-af39-5533-c1cad6de1300@microchip.com>
 <CAKmtTBYquiYQ-=MVWCqH8=iiFONvt6B_==EZhWsQkSA8WNuYUQ@mail.gmail.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <CAKmtTBYquiYQ-=MVWCqH8=iiFONvt6B_==EZhWsQkSA8WNuYUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2023 16:23, Mathieu Moneyron wrote:
> Hi Aubin,
> 
> Thanks for your feedback.
> I'll try my best to give clear explanations.
> 
> On Sat, Sep 23, 2023 at 2:44 PM Aubin Constans
> <aubin.constans@microchip.com> wrote:
>>
>> On 04/09/2023 09:38, Adrian Hunter wrote:
>>> + Eugen Hristev
>>> On 30/08/23 12:23, mathieu wrote:
>>>> On the ATMEL at91 when using the non-removable flag in device tree and not
>>>> using the card-detect pin inside the device-tree pinctrl, the card detect
>>>> pin is physically still used which can cause unknown behaviour when this
>>>> pin is used for other purposes.
>> Hi Mathieu,
>>
>> On which SoC(s) exactly, has this behaviour been observed?
> 
> This has been observed on SAMA5D27.
>>
>>
>> Also, has this issue been discussed in any separate support request, in such
>> case we could retrieve some background from it?
>>
>> By "unknown behaviour", do you mean "the card insertion status would
>> follow whatever electrical level is seen on the card-detect pin"?
> 
> For instance our board design has the PA13 (card detect) pin wired to drive a
> 3v3 power supply.
> The fixed regulator driver configure this pin as output (described in the device
> tree).
> But what I observed is that the sdmmc driver still want to use PA13 as the card
> detect signal which is then configured as an input. This cause the 3v3 power to
> drop.

In the device tree, has PIN_PA13__SDMMC0_CD been removed from the 
pinctrl for sdmmc0?

In case the above behaviour was due to hardware, it would likely point 
out a flaw in the Parallel Input/Output Controller (PIO) rather than in 
the SDMMC Controller.

Would you read back the relevant PIO_CFGRx register, with only "PA13" 
set in PIO_MSKRx, and provide me with the value read?
Assuming PA13 is Non-Secure; if PA13 is configured as Secure, 
S_PIO_CFGRx and S_PIO_MSKRx should be accessed instead.

> By "unknown behavior" I mean the configuration of this pin as card detect sets
> unwanted electrical levels to what's connected to this pin.
>>
>>
>>>> From my interpretation this seems to be caused by a hardware design flaw
>>>> and the real hardware is not working as intended by the documentation. >>>>
>>>> Signed-off-by: Mathieu Moneyron <mathieu.moneyron@gmail.com>
>>>>
>>>> ---
>>>>   drivers/mmc/host/sdhci-of-at91.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-at91.c
>>>> b/drivers/mmc/host/sdhci-of-at91.c
>>>> index 69fef88e7..4fd6bfbf6 100644
>>>> --- a/drivers/mmc/host/sdhci-of-at91.c
>>>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>>>> @@ -51,10 +51,15 @@ struct sdhci_at91_priv {
>>>>   static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
>>>>   {
>>>>       u8 mc1r;
>>>> +    u8 ctrl;
>>>>
>>>>       mc1r = readb(host->ioaddr + SDMMC_MC1R);
>>>>       mc1r |= SDMMC_MC1R_FCD;
>>>>       writeb(mc1r, host->ioaddr + SDMMC_MC1R);
>>>> +
>>>> +    ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
>>>> +    ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
>>>> +    writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>>>   }
>>>>
>>>>   static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned
>>>> int clock)
>>
>> Kind regards,
>> Aubin
>>
> Kind regards,
> Mathieu

Thank you,
Aubin

