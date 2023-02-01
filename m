Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8821167D550
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Jan 2023 20:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAZTZr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Jan 2023 14:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjAZTZq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2023 14:25:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578959269
        for <linux-mmc@vger.kernel.org>; Thu, 26 Jan 2023 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674761144; x=1706297144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WrDRtX83+sACXgpw/WVh1Zb/ieKxI3kvqUe9a7bISKE=;
  b=bV3FPSKLZj14eLDjRniookJ9gOPzQwHWykEpwP996roZax5AMyTiE9VA
   B7VRGYkZG6OXswvSLsWJpQG5P2/izhkAdn/q03PKT2arqNaMNRyP3abSd
   cu8rALYdIuVKx64TAS6dwexFpx/Mf15oANsE0jd2RpARMFPix3c8lWEnh
   wOBaNERYQasU2jNEPPW9dYU+w13ujHC+JOavEk2kcUXvMeZfxx2psuESl
   V1z2NCkwrV/Ebrcqx1ckda2lHoaJewyD8coCpFileGGw1PbnNLtHsow7s
   yoErjsdkuRYBQsmCFhiQYiSqTq26ZiDpqEsArZVnFCcVinrF0DXWgx2t2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329021064"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329021064"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:25:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="640433126"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="640433126"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.29])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:25:42 -0800
Message-ID: <8782dba5-fd75-2967-7631-1c1869c5be24@intel.com>
Date:   Thu, 26 Jan 2023 21:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: Regression 5.14.21 vs 5.15.1: mmc blocked: mmc0: cqhci: timeout
 for tag #
To:     sebastian.kloska@snafu.de
Cc:     linux-mmc@vger.kernel.org
References: <c1214ad81df49a314bd4863751de1a45@snafu.de>
 <05add7ba-f2f8-7cbe-3449-4a3128c096b5@intel.com>
 <2ae56408f156f4f728cd1e94863c0795@snafu.de>
 <c6f162c3-367f-d357-8eb0-27b7aa70ecd5@intel.com>
 <08bd329f23b8fac7a2249034804ac3c7@snafu.de>
 <f31a5b1cc0ae7182199b89730891770d@snafu.de>
 <a935177e-739a-abd3-c926-62028a94e913@intel.com>
 <2faae5dfb4999fba2da80ae7d18af899@snafu.de>
 <ec7a19a6-b0b9-37a3-074b-8c301a1dfcd5@intel.com>
 <ad859904968bc2152df474ae03c1b8e4@snafu.de>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ad859904968bc2152df474ae03c1b8e4@snafu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/01/23 19:25, sebastian.kloska@snafu.de wrote:
> Am 23.01.2023 11:46, schrieb Adrian Hunter:
>> On 21/01/23 15:37, sebastian.kloska@snafu.de wrote:
>>> Am 20.01.2023 13:08, schrieb Adrian Hunter:
>>>> On 20/01/23 13:14, sebastian.kloska@snafu.de wrote:
>>>>> So no mail with attachment on linux-mmc@vger.kernel.org
>>>>> but I linked the dmesgs on https://bugzilla.kernel.org/show_bug.cgi?id=216255 <https://bugzilla.kernel.org/show_bug.cgi?id=216255>
>>>>
>>>> I did receive the logs but it is good to attach them to the bug anyway.
>>>>
>>>>>  
>>>>> Am 19.01.2023 11:28, schrieb Adrian Hunter:
>>>>>> On 19/01/23 11:46, sebastian.kloska@snafu.de <mailto:sebastian.kloska@snafu.de> wrote:
>>>>>>> Am 19.01.2023 10:15, schrieb Adrian Hunter:
>>>>>>>> On 18/01/23 23:24, sebastian.kloska@snafu.de <mailto:sebastian.kloska@snafu.de> wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Hardware: Acer Swift-1 SF114-34-P6U1
>>>>>>>>> SD Host controller: Intel Corporation Device 4dc4 (rev 01) 8086:4dc4
>>>>>>>>> eMMC: Kingston A29128
>>>>>>>>>
>>>>>>>>> * A couple of seconds after boot access to the eMMC is completely
>>>>>>>>>   blocked. Can be triggered by extensive I/O (e.g, with badblocks -w)
>>>>>>>>>
>>>>>>>>> * Tested with stable branch linux-5.14.21 vs. linux-5.15.1
>>>>>>>>>   Latest highest version including the bug is a fedora 6.1.6
>>>>>>>>
>>>>>>>> There is very little difference in drivers/mmc between 5.14.21
>>>>>>>> and 5.15.1. Are you sure the same issue is not present in
>>>>>>>> 5.14.21?
>>>>>>>
>>>>>>> Pretty sure. Using 5.14.21 day in day out 5.15.1 fails on me after ~10min
>>>>>>> The "slowed down by pr_debug" version sometimes lives for >2h (without stress
>>>>>>> via badblocks etc)
>>>>>>>
>>>>> So all of the following is now done on the latest stable, Which currently
>>>>> is 6.2.0-rc4+
>>>>
>>>> That is a release candidate (rc).  The latest stable kernel
>>>> is 6.1.7.
>>>>
>>>
>>> I know -just thought I should pull master/HEAD from the latest stable
>>>
>>>>>>>>
>>>>>>>> You could try disabling runtime PM to see if that helps:
>>>>>>>>
>>>>>>>>     echo on > /sys/class/mmc_host/mmc0/device/power/control
>>>>>>>>
>>>>> Didn't help
>>>>>
>>>>>>> Will try
>>>>>>>> Also it should be possible to disable cqhci by adding to the kernel
>>>>>>>> command line:
>>>>>>>>
>>>>>>>>     sdhci.debug_quirks=0x40a0000
>>>>>>>>
>>>>>
>>>>> Weird behavior: Seems to make it worse. System often freezes
>>>>> during early boot-up.
>>>>>
>>>>> HOWEVER: If I slow down the driver via dynamic debugging it seems to be stable
>>>>> Failed to crash it over a couple of hours. You can say it fixes the issue if you
>>>>> are willing to accept that 80% of one CPU core is busy with logging ;-)
>>>>
>>>> That is interesting.  Logging can have more side effects than you might expect.
>>>> For example the logs might be written back to storage by syslog, which causes
>>>> more logging, and more writing etc etc.  That in turn is bumping up the CPU
>>>> load.
>>>>
>>>> Increasing the CPU load will decrease the chance of the CPU entering a low-power
>>>> state (C-state).
>>>>
>>>> And there was an issue with C-state transitions affecting Intel SDHCI
>>>> controllers,
>>>> so we need to check that possibility.  You could try kernel command line option:
>>>>
>>>>     intel_idle.max_cstate=1
>>>>
>>>
>>> This -- Sir -- works just wonderfully !!
>>>
>>> Don't see any changes in /sys/devices/system/cpu/cpu*/cpuidle/state*/disable,but
>>> may be that's expected. Kernel runs just fine. works for stable/6.1.7 and fedora/6.1.6
>>> So for me personally this workaround is fine. Guess it will hurt my
>>> power consumption/battery live though but that's acceptable for me.
>>>
>>> Don't hesitate to contact if I should test patches for you. The source
>>> is checked out and ccache is filled.
>>
>> It is probably possible to make a kernel patch to prevent
>> low-power C-States only when eMMC is in use.  I will check
>> on that.
>>
>> In the meantime, could you send an acpidump e.g.
>>
>>     sudo apt-get install acpica-tools
>>     sudo acpidump -o /tmp/acpidump.txt
>>
>> Also do you know if you have an up to date BIOS?
> 
> So this is pretty embarrassing. Finally found the means to update my
> BIOS and turned out to fix the problem.
> Should have been the first on my list to solve the issue.
> THX for the effort

That's cool, no worries.  I would also be interested to get
an acpidump from the updated machine.

>>
>>>
>>>> You can see the C-states and whether they are disabled:
>>>>
>>>>     grep -H . /sys/devices/system/cpu/cpu*/cpuidle/state*/disable
>>>>
>>>> "disable" is writable by root, so you can disable them that way also.
>>>>
>>>> In the meantime I will take a look at the logs.
>>>>
>>>>>
>>>>>>> Will try
>>>>>>>>>
>>>>>>>>> * Spiked the code with a lot of pr_debug messages. As a side effect the driver
>>>>>>>>>   seems to be much more stable, so to me it appears like a timing issue where
>>>>>>>>>   the driver fails to wait for a specific state change which seems to appear
>>>>>>>>>   less often when  slowed down by logging
>>>>>>>>
>>>>>>>> Ideally it would be good to see a full log with dynamic
>>>>>>>> debugging enabled for the latest kernel.
>>>>>>>
>>>>>>> Latest torvalds/linux or stable/linux ?
>>>>>>
>>>>>> Stable would be fine.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>     To enable mmc debug via kernel command line:
>>>>>>>>
>>>>>>>>         dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>>>>>>>>
>>>>>
>>>>> This for whatever reason did not work for me on the kernel cmdline
>>>>> but I could trigger it via echo "..." ><debugfs>/dynamic_debug/control
>>>>> so the attached dmesgs are missing early logs.
>>>>>
>>>>>>>>     Kernel must be configured:
>>>>>>>>
>>>>>>>>         CONFIG_DYNAMIC_DEBUG=y
>>>>>>>>
>>>>>>>>>
>>>>>>>>> * Would love to have a decent reference documentation to the SD Controller
>>>>>>>>>   especially a detailed description of the behavior of the register map in
>>>>>>>>>  mmc/host/cqhci.h All intel documents I could find seem to describe
>>>>>>>>>  similar but not quite identical register maps
>>>>>>>>
>>>>>>>> The JEDEC eMMC specification describes the CQHCI registers.
>>>>>>>> It looks like you need to register to get access to them
>>>>>>>> at www.jedec.org.  <http://www.jedec.org. > AFAICT older specs, which would be just
>>>>>>>> fine, are free to download after registering.
>>>>>>>>
>>>>>
>>>>> Uhh -- but the price for registration is hefty. THX anyway
>>>>>
>>>>>>> THX
>>>>>>>> You can get SD Host Controller Simplified Specification
>>>>>>>> from www.sdcard.org <http://www.sdcard.org>.
>>>>>>>>
>>>>>
>>>>> I attach to dmesg logs
>>>>> * One with dynamic debugging and without sdhci.debug_quirks=0x40a0000
>>>>> * The other without dynamic debugging (as said I failed to crash the system) and sdhci.debug_quirks=0x40a0000
>>>>>
>>>>> Hope I filtered properly for the relevant stuff
>>>>> The second one contains what seems to me a ton of kernel Oops but
>>>>> that might be due to the preliminary status of 6.2.0-rc4
>>>>>
>>>>> THX
>>>>>
>>>>>>> THX
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>>
>>>>>>>>> Sebastian
>>>>>>>>>
>>>>>>>>> * dmesg
>>>>>>>>>
>>>>>>>>> [  347.583082] mmc0: cqhci: timeout for tag 3, qcnt
>>>>>>>>
>>>>>>>> The timeout is pretty long, so it seems like the controller
>>>>>>>> has gotten stuck.  It won't reset the command or data
>>>>>>>> circuits either, which is impossible if it is behaving
>>>>>>>> correctly.
>>>>>>>>
>>>>>>>>> [  347.583086] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
>>>>>>>>> [  347.583114] mmc0: cqhci: Caps:      0x000030c0 | Version:  0x00000510
>>>>>>>>> [  347.583117] mmc0: cqhci: Config:    0x00001101 | Control:  0x00000000
>>>>>>>>> [  347.583120] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000016
>>>>>>>>> [  347.583123] mmc0: cqhci: Int sig:   0x00000016 | Int Coal: 0x00000000
>>>>>>>>> [  347.583157] mmc0: cqhci: TDL base:  0x7c2b5000 | TDL up32: 0x00000001
>>>>>>>>> [  347.583160] mmc0: cqhci: Doorbell:  0x0000000f | TCN:      0x00000000
>>>>>>>>> [  347.583163] mmc0: cqhci: Dev queue: 0x00000008 | Dev Pend: 0x00000008
>>>>>>>>> [  347.583166] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00010008
>>>>>>>>> [  347.583169] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
>>>>>>>>> [  347.583172] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
>>>>>>>>> [  347.583175] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
>>>>>>>>> [  347.583176] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>>>> [  347.583182] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>>>>>>>> [  347.583185] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>>>>>>>> [  347.583188] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>>>>>>>> [  347.583191] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>>>>>>>> [  347.583194] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>>>> [  347.583197] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>>>> [  347.583200] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>>>> [  347.583203] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>>>>>>>> [  347.583206] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>>>> [  347.583209] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>>>>>>>> [  347.583212] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>>>>>>>> [  347.583214] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>>>>>>>> [  347.583217] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>>>>>>>> [  347.583219] mmc0: sdhci: Host ctl2: 0x0000000d
>>>>>>>>> [  347.583223] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>>>>>>>> [  347.583224] mmc0: sdhci: ============================================
>>>>>>>>> [  347.583229] mmc0: running CQE recovery
>>>>>>>>> [  347.690108] mmc0: Reset 0x2 never completed.
>>>>>>>>> [  347.690109] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>>>> [  347.690115] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>>>>>>>> [  347.690118] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>>>>>>>> [  347.690121] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>>>>>>>> [  347.690124] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>>>>>>>> [  347.690127] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>>>> [  347.690130] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>>>> [  347.690133] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>>>> [  347.690136] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>>>>>>>> [  347.690139] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>>>> [  347.690141] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>>>>>>>> [  347.690144] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>>>>>>>> [  347.690147] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>>>>>>>> [  347.690150] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>>>>>>>> [  347.690152] mmc0: sdhci: Host ctl2: 0x0000000d
>>>>>>>>> [  347.690156] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>>>>>>>> [  347.690157] mmc0: sdhci: ============================================
>>>>>>>>> [  347.790190] mmc0: Reset 0x4 never completed.
>>>>>>>>> [  347.790191] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>>>> [  347.790193] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>>>>>>>> [  347.790196] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>>>>>>>> [  347.790199] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>>>>>>>> [  347.790202] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>>>>>>>> [  347.790205] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>>>> [  347.790208] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>>>> [  347.790211] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>>>> [  347.790213] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>>>>>>>> [  347.790216] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>>>> [  347.790219] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>>>>>>>> [  347.790222] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>>>>>>>> [  347.790225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>>>>>>>> [  347.790228] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>>>>>>>> [  347.790230] mmc0: sdhci: Host ctl2: 0x0000000d
>>>>>>>>> [  347.790234] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>>>>>>>> [  347.790234] mmc0: sdhci: ============================================
>>>>>>>>> [  347.803056] mmc0: Controller never released inhibit bit(s).
>>>>>>>>> [  347.803058] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>>>>> [  347.803077] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>>>>>>>> [  347.803080] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>>>>>>>> [  347.803083] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>>>>>>>> [  347.803086] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>>>>>>>> [  347.803089] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>>>>>>>> [  347.803092] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>>>>>>>> [  347.803095] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>>>>>>>> [  347.803098] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>>>>>>>> [  347.803101] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>>>>>> [  347.803103] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>>>>>>>> [  347.803106] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>>>>>>>> [  347.803109] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>>>>>>>> [  347.803112] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>>>>>>>> [  347.803114] mmc0: sdhci: Host ctl2: 0x0000000d
>>>>>>>>> [  347.803118] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>>>>>>>> [  347.803119] mmc0: sdhci: ============================================
>>>>>>>>>  --
>>>>>>>>>
>>>>> -- 
>>>>>
>>>
> 

