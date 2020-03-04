Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78476179728
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Mar 2020 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbgCDRvG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Mar 2020 12:51:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10610 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgCDRvF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 12:51:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5fea7a0000>; Wed, 04 Mar 2020 09:50:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Mar 2020 09:51:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Mar 2020 09:51:03 -0800
Received: from [10.2.174.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar
 2020 17:51:02 +0000
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
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
 <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
 <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
 <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com>
 <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com>
 <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com>
Message-ID: <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
Date:   Wed, 4 Mar 2020 09:51:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583344250; bh=6fUccq0Ld2O8KaugUtHUMh6LvAmael9nn1kD70QIB4g=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=oAFN7T1+IZ1PHfw5RX4ssjrRtrCoxqxjErrtGG5D7z/ZGqtHn8DZIdpekju2m8gWV
         vUxyhN0exwwn9Ce/uP1+l0VqCOSOmLW8eYKAY+KarN6bcl/bvIkgezdeEVw/l312zD
         bq/zNridxlsI6hNaIJ3FPj9YP0sRghm2yqZMpaXqePlncgAGNBq6lsQ6OGoLeJ3Hng
         mUu/uFmxJKX0kH6bHyGD2BpzCT6yTeDh9HdtotD3XQkrsZPLdiGJj5Zp3zIHMQF9CM
         lUincb/laGjGt0r2eX8Exmevw9XD+lVtMbbz79QwfsJm0DPcLDdRlfwGAA3a9R69fY
         ll1DwKdRI+ftA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 3/4/20 9:26 AM, Sowjanya Komatineni wrote:
>
> On 3/4/20 9:21 AM, Sowjanya Komatineni wrote:
>>
>> On 3/4/20 8:56 AM, Sowjanya Komatineni wrote:
>>>
>>> On 3/4/20 2:18 AM, Ulf Hansson wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> [...]
>>>>
>>>>> So, from my side, me and Anders Roxell, have been collaborating on
>>>>> testing the behaviour on a TI Beagleboard x15 (remotely with limited
>>>>> debug options), which is using the sdhci-omap variant. I am trying to
>>>>> get hold of an Nvidia jetson-TX2, but not found one yet. These are=20
>>>>> the
>>>>> conclusions from the observed behaviour on the Beagleboard for the
>>>>> CMD6 cache flush command.
>>>>>
>>>>> First, the reported host->max_busy_timeout is 2581 (ms) for the
>>>>> sdhci-omap driver in this configuration.
>>>>>
>>>>> 1. As we all know by now, the cache flush command (CMD6) fails with
>>>>> -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set to=20
>>>>> 30 *
>>>>> 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
>>>>> from the command.
>>>>>
>>>>> 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
>>>>> the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
>>>>> timeout_ms parameter is less than max_busy_timeout (2000 < 2581).
>>>>> Then everything works fine.
>>>>>
>>>>> 3. Updating the code to again use 30s as the
>>>>> MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY=20
>>>>> to be
>>>>> set, even when the timeout_ms becomes greater than max_busy_timeout.
>>>>> This also works fine.
>>>>>
>>>>> Clearly this indicates a problem that I think needs to be=20
>>>>> addressed in
>>>>> the sdhci driver. However, of course I can revert the three discussed
>>>>> patches to fix the problem, but that would only hide the issues and I
>>>>> am sure we would then get back to this issue, sooner or later.
>>>>>
>>>>> To fix the problem in the sdhci driver, I would appreciate if someone
>>>>> from TI and Nvidia can step in to help, as I don't have the HW on my
>>>>> desk.
>>>>>
>>>>> Comments or other ideas of how to move forward?
>>>> [...]
>>>>
>>>>> Hi Ulf,
>>>>>
>>>>> I could repro during suspend on Jetson TX1/TX2 as when it does mmc=20
>>>>> flush cache.
>>>> Okay, great.
>>>>
>>>>>
>>>>> Timeout I see is for switch status CMD13 after sending CMD6 as=20
>>>>> device side CMD6 is still inflight while host sends CMD13 as we=20
>>>>> are using R1 response type with timeout_ms changes to 30s.
>>>>>
>>>>>
>>>>>
>>>>> Earlier we used timeout_ms of 0 for CMD6 flush cache, and with it=20
>>>>> uses R1B response type and host will wait for busy state followed=20
>>>>> by response from device for CMD6 and then data lines go High.
>>>>>
>>>>>
>>>>>
>>>>> Now with timeout_ms changed to 30s, we use R1 response and SW=20
>>>>> waits for busy by checking for DAT0 line to go High.
>>>> If I understand correctly, because of the timeout now set to 30s,
>>>> MMC_RSP_BUSY becomes disabled in __mmc_switch() for your case in
>>>> sdhci-tegra as well?
>>> Yes
>>>>
>>>> In other words, mmc_poll_for_busy() is being called, which in your
>>>> case means the ->card_busy() host ops (set to sdhci_card_busy() in
>>>> your case) will be invoked to wait for the card to stop signal busy on
>>>> DAT0.
>>>>
>>>> This indicates to me, that the ->card_busy() ops returns zero to
>>>> inform that the card is *not* busy, even if the card actually signals
>>>> busy? Is that correct?
>>> Yes
>>>>
>>>>>
>>>>>
>>>>> With R1B type, host design after sending command at end of=20
>>>>> completion after end bit waits for 2 cycles for data line to go=20
>>>>> low (busy state from device) and waits for response cycles after=20
>>>>> which data lines will go back high and then we issue switch status=20
>>>>> CMD13.
>>>>>
>>>>>
>>>>>
>>>>> With R1 type, host after sending command and at end of completion=20
>>>>> after end bit, DATA lines will go high immediately as its R1 type=20
>>>>> and switch status CMD13 gets issued but by this time it looks like=20
>>>>> CMD6 on device side is still in flight for sending status and data.
>>>> So, yes, using R1 instead of R1B triggers a different behaviour, but
>>>> according to the eMMC spec it's perfectly allowed to issue a CMD13
>>>> even if the card signals busy on DAT0. The CMD13 is not using the DATA
>>>> lines, so this should work.
>>>>
>>>> If I understand correctly, your driver (and controller?) has issues
>>>> with coping with this scenario. Is it something that can be fixed?
>>>>
>>>>>
>>>>> 30s timeout is the wait time for data0 line to go high and=20
>>>>> mmc_busy_status will return success right away with R1 response=20
>>>>> type and SW sends switch status CMD13 but during that time on=20
>>>>> device side looks like still processing CMD6 as we are not waiting=20
>>>>> for enough time when we use R1 response type.
>>>> Right, as stated above, isn't sdhci_card_busy() working for your case?
>>>> Can we fix it?
>>>
>>> sdhci_card_busy() returned 0 indicating its not busy.
>>>
>>> Based on our host design, When CMD6 is issued with R1 type, we=20
>>> program it as NO_RESPONSE and with this command complete interrupt=20
>>> happens right at end bit of command and there will be no transfer=20
>>> complete interrupt.
>> *[Correction] Based on our host design, When CMD6 is issued with R1=20
>> type as we program it as NO_RESPONSE and with this command complete=20
>> interrupt happens right at end bit of command and there will be no=20
>> transfer complete interrupt.
>
> Sorry to correct wordings, I meant sdhci driver programs response type=20
> as NO_RESPONSE for CMD6.
>
> When CMD6 is issued with R1 type and as NO_RESPONSE, Based on our host=20
> design=C2=A0 command complete interrupt happens right at end bit of comma=
nd=20
> and there will be no transfer complete interrupt.
>
>
Sorry for confusion. Please ignore above on response. it is using SHORT=20
response for R1. So SW poll should be working.

Will get back on checking on host design side internally.

>>>
>>> When CMD6 is issued with R1B type, we program is as R1B RESP_SHORT=20
>>> and with this command complete is end bit of device resp and=20
>>> transfer complete interrupt will be when DAT0 LOW -> HIGH.
>>>
>>> Regardless of R1/R1B, device side CMD6 will always have busy state=20
>>> on D0 and response on CMD lines.
>>>
>>> There will be 2 clock cycles period after sending CMD6 for device to=20
>>> send busy state on data0.
>>>
>>> In case of R1 type, after sending command DAT will stay high and=20
>>> looks like we are polling for busy early before busy state has=20
>>> started and sending CMD13 while device is busy and sending response=20
>>> on CMD line is causing timeout.
>>>
>>> Probably with this specific case of CMD6 with R1 type, to wait for=20
>>> card busy we should poll for DAT0 to go Low first and then to go High??
>>>
>>>>

>>>>>
>>>>>
>>>>>
>>>>> Actually we always use R1B with CMD6 as per spec.
>>>> I fully agree that R1B is preferable, but it's not against the spec to
>>>> send CMD13 to poll for busy.
>>>>
>>>> Moreover, we need to cope with the scenario when the host has
>>>> specified a maximum timeout that isn't sufficiently long enough for
>>>> the requested operation. Do you have another proposal for how to
>>>> manage this, but disabling MMC_RSP_BUSY?
>>>>
>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
>>>> then what timeout would the driver be using if we would set
>>>> cmd.busy_timeout to 30ms?
>>>>
>>>> Kind regards
>>>> Uffe
