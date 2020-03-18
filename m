Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2718A755
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Mar 2020 22:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRVtU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Mar 2020 17:49:20 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:54994
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRVtU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2020 17:49:20 -0400
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id 0EE5927672;
        Wed, 18 Mar 2020 22:49:18 +0100 (CET)
Date:   Wed, 18 Mar 2020 22:49:17 +0100
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: PROBLEM: mmc_select_hs400es failed, error -110
Message-ID: <20200318214917.GA9112@arya.arvanta.net>
References: <20200301220242.GA8276@arya.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200301220242.GA8276@arya.arvanta.net>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

Sorry to annoy again, but could you tell me if I sent this bug report
to right mail address or I should send it somewhere else.

Also, did I sent bug report correctly or I did some mistakes which
caused it to be ignored.

-- 
TIA

On Sun, 2020-03-01 at 23:02, Milan P. Stanić wrote:
> Hello,
> 
> I'm not native English speaker and I'm self taught in English so sorry
> if do not write or express correctly. And sorry if I posted bug report
> to wrong address.
> 
> I'm running linux 5.6.0-rc3 without any patches on Samsung chromebook
> one plus, Arm64 rockchip rk3399 based model name:
> Machine model: Google Kevin
> 
> I build kernels from upstream git.kernel.org for this machine for some
> time (iirc, from 5.2.1 and up) but I'm getting error messages in kernel
> after machine resumes from suspend-to-ram.
> 
> excerpt from dmesg output:
> -----------------------------------------------------------------------
> Restarting tasks ... done.
> PM: suspend exit
> mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> mmc1: mmc_select_hs400es failed, error -110
> mmc1: error -110 doing runtime resume
> mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
> mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
> mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
> mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
> mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
> mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
> mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
> mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
> mmc1: sdhci: Host ctl2: 0x00000000
> mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
> -----------------------------------------------------------------------
> 
> I invoke suspend-to-ram by `echo mem > /sys/power/state` from ACPI power
> and LID button handlers.
> 
> This only happens when I boot and use internal emmc card and never when
> boot and use external mmc card.
> 
> If suspend-to-ram is not invoked (machine is always in normal state)
> this problem never happen (or I missed it somehow).
> 
> I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf) which
> use to build kernel, output of the `awk -f scripts/ver_linux` as file
> ver_linux.txt and  output of dmesg as file mmc-err.txt (from which I
> deleted wifi connection logs).
> 
> Sorry if I did something bad or wrong with this bug report, I don't have
> much experience with bug reporting, especially for kernel.
> 
> I'm ready to send you more data, and investigate this more, apply
> patches and rebuild kernel or whatever you ask me (of course if my
> understanding and knowledge is enough for this job).
> 
> Thank in advance
> 
> --
> Kind regards
> 
[...]
