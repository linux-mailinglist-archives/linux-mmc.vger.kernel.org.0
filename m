Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627632CB65F
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Dec 2020 09:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgLBIGw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Dec 2020 03:06:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:27462 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387883AbgLBIGv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 03:06:51 -0500
IronPort-SDR: JjT7EGNQlojeh0EzlZRkJLAa+nzkuZdE4lpB9hhSIOL1i/8ZImlsAwUHBA6XkYHxFjT1ip2b4G
 dDgRT/hlq5oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="237100286"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="237100286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:06:02 -0800
IronPort-SDR: gQ6xsm5XZCF2JDWyLnFLAtP6zeOiawd6stkaMSlmZcSM75066Li3p0rU1MLLxICqZcZl2FSe2/
 MjtmvW2byTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481449645"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2020 00:05:57 -0800
Subject: Re: [BUG] cqe unable to handle buggy cards
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        nuumiofi@gmail.com, Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <fa7f3fc5-c37a-ac49-e14a-45a1d2e0a942@gmail.com>
 <CAPDyKFq9vKOODDQEEE2W+Gsx69_R3XV_Hb-owMU-=qAMbv39kg@mail.gmail.com>
 <2ebdcb5c-1c52-08af-9233-16366c20820e@intel.com>
 <CAMdYzYoFCfVkz7zwbfQ=ZoirNTymRrRyg8FCabVVEQSKRnoOEA@mail.gmail.com>
 <CAMdYzYqEhgO6q3iXNzzuZ3snW_Y1bYP8BOBkNC5=fCPc310BUA@mail.gmail.com>
 <80572b62-2601-ff53-05ef-4d231f7450fa@intel.com>
 <CAMdYzYrMJBs3=cwK404jQauN1OhntsVq3Ppcu=9-TwW_dsmqmw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2fd27057-1991-fd04-2004-0981e5cef4ce@intel.com>
Date:   Wed, 2 Dec 2020 10:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYrMJBs3=cwK404jQauN1OhntsVq3Ppcu=9-TwW_dsmqmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/11/20 8:30 pm, Peter Geis wrote:
> On Mon, Nov 16, 2020 at 3:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/11/20 10:54 pm, Peter Geis wrote:
>>> On Wed, Nov 4, 2020 at 7:39 PM Peter Geis <pgwipeout@gmail.com> wrote:
>>>>
>>>> On Mon, Nov 2, 2020 at 11:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> On 2/11/20 4:54 pm, Ulf Hansson wrote:
>>>>>> + cqhci maintainers
>>>>>>
>>>>>> On Sat, 31 Oct 2020 at 13:54, Peter Geis <pgwipeout@gmail.com> wrote:
>>>>>>>
>>>>>>> Good Morning,
>>>>>>>
>>>>>>> We are seeing an issue on the rk3399 with certain Foresee emmc modules
>>>>>>> where the module reports it supports command queuing but fails in actual
>>>>>>> implementation.
>>>>>>>
>>>>>>> Unfortunately there doesn't seem to be any method for the mmc core code
>>>>>>> to detect this situation and disable command queue automatically.
>>>>>>> There also appears to be no way to disable it at runtime.
>>>>>
>>>>> Since v5.5, if you know how to use SDHCI debug quirks there is
>>>>> SDHCI_QUIRK_BROKEN_CQE
>>>>> e.g. kernel command line option sdhci.debug_quirks=0x0x2020000
>>>>
>>>> Thank you, we will test this.
>>>
>>> This does resolve the issue of disabling cqe entirely for debugging, thanks!
>>>
>>>>
>>>>>
>>>>>>>
>>>>>>> Certain modified kernels have added a patch to enable runtime disable of
>>>>>>> command queue entirely, but this will affect mmc core as a whole and not
>>>>>>> just the buggy card.
>>>>>>>
>>>>>>> Does anyone have any insight into this issue?
>>>>>>> Thank you for your time.
>>>>>>
>>>>>> Unfortunate, not me personally. I assume the issue is either be card
>>>>>> specific or host specific. Before looking at a disable option, we need
>>>>>> to know more about what goes wrong, I think.
>>>>>>
>>>>>> Kind regards
>>>>>> Uffe
>>>>>>
>>>>>>>
>>>>>>> Very Respectfully,
>>>>>>> Peter Geis
>>>>>>>
>>>>>>> [   64.472882] mmc2: cqhci: timeout for tag 2
>>>>>>> [   64.473349] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
>>>>>>> [   64.474057] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
>>>>>>> [   64.474763] mmc2: cqhci: Config:    0x00000000 | Control:  0x00000000
>>>>>>> [   64.475468] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
>>>>>>> [   64.476172] mmc2: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
>>>>>>> [   64.476875] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
>>>>>
>>>>> TDL base cannot be zero, so the register values have been lost.
>>>>> Could be a reset issue like this one but for sdhci-of-arasan.c :
>>>>>
>>>>> https://lore.kernel.org/linux-mmc/20200819121848.16967-1-adrian.hunter@intel.com/
>>>>
>>>> Excellent, we will see if a similar implementation makes a difference
>>>> here for us as well.
>>>
>>> I wrote a patch to implement this in the arasan driver.
>>> https://paste.ee/p/cl5SX
>>> Nuumiofi tested it with the buggy card.
>>>
>>> The good news, it solves the register clearing issue.
>>> The bad news, the card still is broken, here is the kernel log:
>>> https://paste.ubuntu.com/p/sF2yMwxpcV/
>>
>> You will need to enable dynamic debug to get more messages e.g.
>>         kernel config: CONFIG_DYNAMIC_DEBUG=y
>>         kernel command line:
>> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>>
>> If it can't be made to work, you can set SDHCI_QUIRK_BROKEN_CQE in the
>> driver as needed.
> 
> nuumiofi has collected logs with dynamic debug enabled.
> He currently has four logs in a google drive folder:
> cqe disabled
> cqe enabled
> cqe disabled with reset patch applied
> cqe enabled with reset patch applied
> 
> https://drive.google.com/drive/folders/1m1DqzisxHH-6BiMkqR_ExLg9kgH1BDTy

Looks like some kind of issue with timeout settings:

[    1.728289] mmc2: sdhci: Too large timeout 0xf requested for CMD18!
[    1.736197] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.802390] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.810496] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.818562] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.826652] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.834470] mmc2: sdhci: Too large timeout 0xf requested for CMD25!
[    1.842256] mmc2: sdhci: Too large timeout 0xf requested for CMD25!

[    4.878368] mmc2: cqhci: error IRQ status: 0x00000000 cmd error -110 data error 0 TERRI: 0x0000822c
[    4.880436] mmc2: failed to start CQE transfer for tag 3, error -16
[    4.884075] mmc2: sdhci: Too large timeout 0xf requested for CMD12!
[    4.886398] mmc2: sdhci: Too large timeout 0xf requested for CMD48!
[    4.976803] mmc2: sdhci: Too large timeout 0xf requested for CMD8!
[    5.032979] mmc2: cqhci: error IRQ status: 0x00000000 cmd error -110 data error 0 TERRI: 0x0000862c
[    5.035910] mmc2: failed to start CQE transfer for tag 0, error -16
[    5.039436] mmc2: sdhci: Too large timeout 0xf requested for CMD12!
[    5.041640] mmc2: sdhci: Too large timeout 0xf requested for CMD48!
[    5.048557] mmc2: cqhci: error IRQ status: 0x00000000 cmd error -110 data error 0 TERRI: 0x0000822c
[    5.051405] mmc2: failed to start CQE transfer for tag 3, error -16
[    5.054861] mmc2: sdhci: Too large timeout 0xf requested for CMD12!
[    5.056984] mmc2: sdhci: Too large timeout 0xf requested for CMD48!

Note error -110 is a timeout error

> 
>>
>>>
>>>>
>>>>>
>>>>>
>>>>>>> [   64.477578] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
>>>>>>> [   64.478281] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
>>>>>>> [   64.478984] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
>>>>>>> [   64.479687] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
>>>>>>> [   64.489785] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
>>>>>>> [   64.499774] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
>>>>>>> [   64.509687] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>> [   64.519597] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>>>>>>> [   64.529521] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>>>>>>> [   64.539440] mmc2: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
>>>>>>> [   64.549352] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
>>>>>>> [   64.559277] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>> [   64.569214] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>> [   64.579061] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>> [   64.588842] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>>>>>> [   64.598671] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>> [   64.608446] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
>>>>>>> [   64.618161] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
>>>>>>> [   64.627801] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x642017d7
>>>>>>> [   64.637376] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
>>>>>>> [   64.646855] mmc2: sdhci: Host ctl2: 0x00000083
>>>>>>> [   64.656080] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
>>>>>>> [   64.665445] mmc2: sdhci: ============================================
>>>>>>> [   64.674998] mmc2: running CQE recovery
>>>>>>>
>>>>>>> [  125.912941] mmc2: cqhci: timeout for tag 3
>>>>>>> [  125.921978] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
>>>>>>> [  125.931200] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
>>>>>>> [  125.940389] mmc2: cqhci: Config:    0x00000001 | Control:  0x00000000
>>>>>>> [  125.949499] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
>>>>>>> [  125.958527] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
>>>>>>> [  125.967486] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
>>>>>>> [  125.976260] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
>>>>>>> [  125.985065] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
>>>>>>> [  125.993698] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
>>>>>>> [  126.002244] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
>>>>>>> [  126.010716] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
>>>>>>> [  126.019159] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
>>>>>>> [  126.027525] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>> [  126.035955] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>>>>>>> [  126.044258] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>>>>>>> [  126.052396] mmc2: sdhci: Argument:  0x00000001 | Trn mode: 0x00000010
>>>>>>> [  126.060370] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
>>>>>>> [  126.068241] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>> [  126.075978] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>> [  126.083552] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>> [  126.090937] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>>>>>> [  126.098219] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>> [  126.105403] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
>>>>>>> [  126.112649] mmc2: sdhci: Cmd:       0x00003013 | Max curr: 0x00000000
>>>>>>> [  126.119700] mmc2: sdhci: Resp[0]:   0x00400800 | Resp[1]:  0x642017d7
>>>>>>> [  126.126594] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
>>>>>>> [  126.133334] mmc2: sdhci: Host ctl2: 0x00000083
>>>>>>> [  126.139652] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
>>>>>>> [  126.146008] mmc2: sdhci: ============================================
>>>>>>> [  126.152361] mmc2: running CQE recovery
>>>>>>>
>>>>>>>
>>>>>
>>

