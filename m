Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48F19A37D
	for <lists+linux-mmc@lfdr.de>; Fri, 23 Aug 2019 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfHVXFY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 19:05:24 -0400
Received: from mail.overt.org ([157.230.92.47]:44301 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfHVXFY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 22 Aug 2019 19:05:24 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 995AC3F741;
        Thu, 22 Aug 2019 18:05:22 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566515122; bh=pM/+NbEcNC5gCPtvCkQZF0ZAThoAd9ldvZAY1L18sfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z/yrlBer5kHz2Y4zk9xXrbZmibDaAmREcqSIqt6OA6+nXmKAk/HwmfQP2vj71xBq2
         S1i8GFcF5OBSeLPm9AcbwfkAF7y1YV/5NWXf/gvQNxeRzScL2zopghpE+wzAqnc8ku
         mND5PGn3xVSQkCgj6xCOHyGQ350ZeB7qP7nROdWhZKGwrX+/1v24hWLCI8/FgyC9WX
         BlEacuOaNZay2ZGJz4pEWvSpCVQJcrqj6Np8cQIefdqWuxOheDE3wiwUl76iiwphdO
         36XAge/x6GYQ+zvjvHp/SNQYMngkL9DnAt0hlE63PEJJI2qLr/0k4wM4DtK/GDtxqg
         rZoEIw+h/NAPg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 22 Aug 2019 16:05:22 -0700
From:   Philip Langdale <philipl@overt.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
In-Reply-To: <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
References: <20190811021917.29736-1-philipl@overt.org>
 <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
Message-ID: <41d073f646b1f94adcf41b2cf0f798d8@overt.org>
X-Sender: philipl@overt.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019-08-21 07:55, Ulf Hansson wrote:
>> 
>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c 
>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> index bd50935dc37d..1d7c942fc7f3 100644
>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> @@ -1345,7 +1345,7 @@ static void realtek_init_host(struct 
>> realtek_pci_sdmmc *host)
>>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
>> -       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | 
>> MMC_CAP2_FULL_PWR_CYCLE;
>> +       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP;
>>         mmc->max_current_330 = 400;
>>         mmc->max_current_180 = 800;
>>         mmc->ops = &realtek_pci_sdmmc_ops;
>> --
>> 2.20.1
>> 
> 
> I am not convinced that the patch is correct, but I may be wrong. A
> few things that I wonder about.
> 
> 1.
> To support switch UHS-I SD cards into 1.8V I/O, the host should
> implement the ->card_busy() host ops. This isn't the case for
> rtsx_pci_sdmmc.c  (you should see a  warning printed to the log
> "cannot verify signal voltage switch" during the card initialization),
> but instead it internally tries to deal with the 1.8V I/O voltage
> switch inside its ->start_signal_voltage_switch() ops.
> 
> It looks fragile to me. No matter what, I think it's a good idea to
> convert into using the ->card_busy() ops.

Interestingly, the rtsx_usb_sdmmc driver implements card_busy, so this
was a conscious effort from the original author(s). However, it's not
relevant to the bug here, as things fall apart before we get to UHS-I
switching.

> 2.
> The mmc core expects hosts that supports 3.3V and 1.8V I/O, to be able
> to move from 1.8V back to 3.3V. Perhaps that path isn't so well tested
> for rtsx_pci_sdmmc.c and maybe it's a good idea to make sure this
> works as expected.

So, I did more debugging and I've narrowed down the problem. You are 
correct,
that this is not directly caused by FULL_PWR_CYCLE. What is actually 
happening
is that these Sandisk A2 cards (Is anyone else selling an A2 card? I 
haven't
seen one) claim to support the low voltage range in OCR (bit 7) for 
vmmc.

At least for me, that's unusual. I've never seen an SD card support the 
low
voltage range - It was introduced for MMC(plus) and I'd only ever seen 
it on
those cards.

This seems to be the key difference from the older UHS-1 cards (which 
I've now
been able to test and they work fine with the driver - so it really is 
specific
to these new A2 cards).

Anyway. So what is happening is that the mmc_select_voltage logic tries 
to switch
to the lowest supported voltage and then issues the pwr_cycle sequence 
if the
controller supports it. Then, the card comes up in some kind of broken 
state,
and everything fails past that point.

With that in mind, I removed the host flag that indicates support for 
the low
voltage range, and now the card works fine with FULL_PWR_CYCLE retained. 
Fun times.

So, what's actually wrong? Well, either the controller doesn't really 
support the
low voltage range, or the card doesn't. As my machine here only has a 
microsd slot,
I can't test with an MMCplus card to see if low voltage MMC would work. 
Without that
I can't say whether we should remove the host flag or somehow blacklist 
low voltage
range on these cards (or any SD card?)

Would love to get your thoughts.

--phil
