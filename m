Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2AD7682
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Oct 2019 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfJOM2E (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Oct 2019 08:28:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:34188 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJOM2E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2019 08:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571142477;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B3Bj6Z21zo2quGlbGzYPqHCYxWZk4ZtpjCp6eZsfB/U=;
        b=gkFGrFbebUNGobPrDTWHeT0CjeL2+4Euox6m2kbYJkdipwWpROKbJdhxmXCWIs8Xqs
        4Qv7fgAdIa+aOZaa8rhlztpfcrGqH1W2XfdsJnpYdOoVTNN3Dgt0bxjBJU+EwnA7jEXL
        l9dEbfrhH5hLx1OL/1wnlUmhsfI+7VTedHPG5+/S/OMzDQr4KgUlMnfWid8faqbkj+Zz
        ieJWeR7M5T/NS7krz9UNnQCLxMDnOxNtuZ3HDR4nBckMP6ni/LmSexZcS/ZskVsslTPb
        DQ+59Tdig3InYnTF54K2MPilN2ItsK2yZXHmkrI+obnxfkeaf8sBUPV/T+icbkLAHrtp
        IODQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhadQKCJpnw2FQSt80agYGq9E2zRw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:9c34:7af6:1b0f:ed1a]
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id g03e8av9FCRj8sc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 15 Oct 2019 14:27:45 +0200 (CEST)
Subject: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     rmk+kernel@armlinux.org.uk, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
Message-ID: <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
Date:   Tue, 15 Oct 2019 14:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

We have patched the RC2 [1] and RC3 [2] of kernel 5.4 with the mmc3 
patch [3] and after that the onboard SD card works without any problems 
with them.

Could you please add this patch or do you have another solution?

Thanks,
Christian

[1] http://www.xenosoft.de/linux-image-5.4-rc2-X1000_X5000_A1222.tar.gz
[2] http://www.xenosoft.de/linux-image-5.4-rc3-X1000_X5000_A1222.tar.gz
[3] http://www.xenosoft.de/mmc3.patch


On 05 October 2019 at 00:45 am, Christian Zigotzky wrote:
> Hello,
>
> The onboard SD card of the Cyrus+ PowerPC board (A-EON AmigaOne X5000) 
> [1] doesn't work anymore after the 'mmc-v5.4-2' updates [2].
>
> Error messages:
>
> [   12.118148] mmc0: SDHCI controller on ffe114000.sdhc 
> [ffe114000.sdhc] using ADMA
> [   12.232869] mmc0: ADMA error: 0x02000000
> [   12.237977] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   12.243137] mmc0: sdhci: Sys addr:  0x00000000 | Version: 0x00001301
> [   12.248307] mmc0: sdhci: Blk size:  0x00000008 | Blk cnt: 0x00000001
> [   12.253448] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [   12.258530] mmc0: sdhci: Present:   0x01fd020a | Host ctl: 0x00000030
> [   12.263572] mmc0: sdhci: Power:     0x00000002 | Blk gap: 0x00000000
> [   12.268574] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x000020f8
> [   12.273535] mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> [   12.278461] mmc0: sdhci: Int enab:  0x037f008f | Sig enab: 0x037f008b
> [   12.283339] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00001301
> [   12.288198] mmc0: sdhci: Caps:      0x05fa0000 | Caps_1: 0x00000000
> [   12.293032] mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> [   12.297861] mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]: 0x001dd533
> [   12.302615] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]: 0x3f400e00
> [   12.307312] mmc0: sdhci: Host ctl2: 0x00000000
> [   12.311940] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x7e04f208
> [   12.316573] mmc0: sdhci: ============================================
> [   12.321204] mmc0: sdhci: 7e04f200: DMA 0xfc000000, LEN 0x0008, 
> Attr=0x23
> [   12.326022] mmc0: error -5 whilst initialising SD card
> [   12.507466] mmc0: invalid bus width
> [   12.512154] mmc0: error -22 whilst initialising SD card
> [   12.683457] mmc0: invalid bus width
> [   12.688968] mmc0: error -22 whilst initialising SD card
> [   12.774281] mmc0: invalid bus width
> [   12.779910] mmc0: error -22 whilst initialising SD card
>
> -------------------------
>
> I have found the issue in the DMA changes of the 'mmc-v5.4-2' updates. 
> It's the commit "121bd08b029e03404c451bb237729cdff76eafed (mmc: 
> sdhci-of-esdhc: set DMA snooping based on DMA coherence)" [3].
>
> Please find attached a patch. This patch solves the issue.
>
> dmesg output after compiling with the attached patch:
>
> [   12.117149] mmc0: SDHCI controller on ffe114000.sdhc 
> [ffe114000.sdhc] using ADMA
> [   12.208646] mmc0: new high speed SDHC card at address 59b4
> [   12.230808] mmcblk0: mmc0:59b4 USD   3.73 GiB
>
> -------------------------
>
> Please check the commit "121bd08b029e03404c451bb237729cdff76eafed" [3].
>
> Thanks,
> Christian
>
>
> [1] https://www.amigaos.net/hardware/133/amigaone-x5000 and 
> http://wiki.amiga.org/index.php?title=X5000
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.4-rc1&id=c710364f78afdef8c2ed07556d0743c5a30ed429
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=121bd08b029e03404c451bb237729cdff76eafed
>

