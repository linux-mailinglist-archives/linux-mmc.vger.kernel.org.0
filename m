Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2615717E1B
	for <lists+linux-mmc@lfdr.de>; Wed, 31 May 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjEaLe0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 31 May 2023 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEaLeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 07:34:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308418C
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 04:34:09 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B49F58609E;
        Wed, 31 May 2023 13:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685532848;
        bh=ihcfNNJVi/mWMA5T7jcEcjm/Bn8EtGoR2ApPoI7Aobs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kOFSRHu2Qtwkrrcwt8SZpOjypnmqBF69t5mR1p2XCLQynIYqjiwiX5SZ4TxKeQnUz
         z5EzJaXbM4gwPBJfzMIU8GP3WEyV3wREa69IfqvCtxvz91IVvBqIFs+bRH2af9mYgO
         ACVLSM6n1L8BBaiBKLZc2d6AKPLv9kV0hmU9b/G8hg9eDVGURt6LSgR4DCM/FG+xFe
         +bdxUYa4CALjqXPcH2I8FWbaBsEQ2NTg5iaAO8lAK9bgyIDqY6y5vWM3AQeQZCAXJe
         5EPQ9fc0WF5qcRrWtK6aJvjSjpQDnUrvbih+jyS25pkiywVMlfNO3Jz5iIryhHYuAo
         Do2wSnLgz1sjA==
Message-ID: <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
Date:   Wed, 31 May 2023 13:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
To:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/31/23 07:46, Adrian Hunter wrote:
> On 31/05/23 03:27, Marek Vasut wrote:
>> This reverts commit 08ebf903af57cda6d773f3dd1671b64f73b432b8.
>>
>> On STM32MP153C DHCOR DRC Compact with microSD card
>> Kingston Canvas Go! Plus MicroSDXC I 64 GiB U3/V30/A2 SDCG3/64GB
>> it is no longer possible to mount ext4 filesystem.
>>
>> Git bisect points to this commit which is being reverted here. A bit of
>> investigation shows that for non-working microSD cards
>>    cache_enabled=TRUE fua_enabled=false
>> For working microSD card (Kingston Canvas React Plus, MicroSDXC II
>> 64 GiB U3/V90/A1 SDCR2/64GB)
>>    cache_enabled=FALSE fua_enabled=false
>>
>> It seems enabling the cache for SD cards causes the issue. Before the
>> reverted commit, the cache was not reported enabled for SD cards. I am
>> not sure whether such blunt revert is the correct solution however, any
>> ideas ?
> 
> This does not disable the cache, it disables the block layer from issuing
> cache flushes (by telling it there is no cache being used).
> 
> It would be good to know what commands are failing, which should be visible
> in the kernel messages if dynamic debug is enabled:
> 
> Dynamic debug for mmc
> ---------------------
> 
>      Kernel must be configured:
> 
>          CONFIG_DYNAMIC_DEBUG=y
> 
>      To enable mmc debug via sysfs:
> 
>          echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>          echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
> 
>      To enable mmc debug via kernel command line:
> 
>          dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
> 
>      To disable mmc debug:
> 
>          echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
>          echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control
> 
>      More general information in kernel documentation in kernel tree:
> 
>          Documentation/admin-guide/dynamic-debug-howto.rst

Log is below, I added newlines around the mount failure.
Do you see anything problematic there ?

$ echo 'file drivers/mmc/core/* +p' > 
/sys/kernel/debug/dynamic_debug/control ; echo 'file drivers/mmc/host/* 
+p' > /sys/kernel/debug/dynamic_debug/control ; echo 8 > 
/proc/sys/kernel/printk ; mount /dev/mmcblk1p4 /mnt
[   61.061029] <mmc1: starting CMD23 arg 00000002 flags 00000015>
[   61.065637] mmc1: starting CMD18 arg 00002002 flags 000000b5
[   61.071144] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms 
nsac 0
[   61.078096] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.083302] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
[   61.090012] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
[   61.096531] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.102332] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
[   61.108836] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.114575] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.120371] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.127178] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.134084] mmc1:     1024 bytes transferred: 0
[   61.138658] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.145533] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.150946] mmc1: starting CMD18 arg 00002000 flags 000000b5
[   61.156609] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms 
nsac 0
[   61.163426] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.168759] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
[   61.175368] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.181985] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.187682] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
[   61.194185] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.199979] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.205769] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.212574] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.219478] mmc1:     4096 bytes transferred: 0
[   61.224050] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.231166] <mmc1: starting CMD23 arg 00000002 flags 00000015>
[   61.236378] mmc1: starting CMD18 arg 00002002 flags 000000b5
[   61.241983] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms 
nsac 0
[   61.248940] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.254169] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
[   61.260779] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
[   61.267405] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.273101] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
[   61.279603] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.285431] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.291125] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.298032] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.304937] mmc1:     1024 bytes transferred: 0
[   61.309409] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.316256] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.321768] mmc1: starting CMD18 arg 00002000 flags 000000b5
[   61.327459] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms 
nsac 0
[   61.334360] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.339459] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
[   61.346167] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.352782] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.358478] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
[   61.365082] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.370776] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.376565] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.383371] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.390275] mmc1:     4096 bytes transferred: 0
[   61.394848] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.401885] <mmc1: starting CMD23 arg 00000002 flags 00000015>
[   61.407193] mmc1: starting CMD18 arg 00002002 flags 000000b5
[   61.412794] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms 
nsac 0
[   61.419748] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.424973] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
[   61.431582] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
[   61.438204] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.443901] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
[   61.450404] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.456232] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.461927] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.468834] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.475739] mmc1:     1024 bytes transferred: 0
[   61.480210] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.487054] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.492462] mmc1: starting CMD18 arg 00002000 flags 000000b5
[   61.498251] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms 
nsac 0
[   61.505160] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.510260] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
[   61.516969] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.523592] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.529288] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
[   61.535789] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.541583] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.547271] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.554177] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.561082] mmc1:     4096 bytes transferred: 0
[   61.565654] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.572440] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.578017] mmc1: starting CMD18 arg 00002008 flags 000000b5
[   61.583653] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms 
nsac 0
[   61.590465] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.595686] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
[   61.602396] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.608915] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.614712] mmci-pl18x 58005000.mmc: op 12 arg 00002008 flags 000000b5
[   61.621215] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.627034] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.632727] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.639633] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.646437] mmc1:     4096 bytes transferred: 0
[   61.651010] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.658908] <mmc1: starting CMD23 arg 00000108 flags 00000015>
[   61.663421] mmc1: starting CMD18 arg 00003be8 flags 000000b5
[   61.669102] mmc1:     blksz 512 blocks 264 flags 00000200 tsac 100 ms 
nsac 0
[   61.676155] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.681355] mmci-pl18x 58005000.mmc: blksz 0200 blks 0108 flags 00000200
[   61.688064] mmci-pl18x 58005000.mmc: op 17 arg 00000108 flags 00000015
[   61.694589] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.700284] mmci-pl18x 58005000.mmc: op 12 arg 00003be8 flags 000000b5
[   61.706887] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.712581] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.718372] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
[   61.724060] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.730965] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.737870] mmc1:     135168 bytes transferred: 0
[   61.742544] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.749064] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.755336] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.760649] mmc1: starting CMD18 arg 00442000 flags 000000b5
[   61.766327] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms 
nsac 0
[   61.773144] mmc1:     CMD12 arg 00000000 flags 00000095
[   61.778489] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
[   61.785100] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.791616] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.797414] mmci-pl18x 58005000.mmc: op 12 arg 00442000 flags 000000b5
[   61.803916] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.809710] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.815399] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.822306] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   61.829211] mmc1:     4096 bytes transferred: 0
[   61.833683] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.833952] mmc0: starting CMD7 arg fffd0000 flags 00000015
[   61.840205] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.845820] mmci-pl18x 48004000.mmc: op 07 arg fffd0000 flags 00000015
[   61.853036] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[   61.858074] mmci-pl18x 48004000.mmc: irq0 (data+cmd) 00000040
[   61.858098] mmc0: req done (CMD7): 0: 00001ed7 00000000 00000000 00000000
[   61.876506] mmc1: starting CMD25 arg 00002000 flags 000000b5
[   61.882106] mmc1:     blksz 512 blocks 8 flags 00000100 tsac 3000 ms 
nsac 0
[   61.889107] mmc1:     CMD12 arg 00000000 flags 0000049d
[   61.894346] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000100
[   61.900957] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
[   61.907588] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.913283] mmci-pl18x 58005000.mmc: op 19 arg 00002000 flags 000000b5
[   61.919786] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.925612] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   61.931309] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   61.938219] mmc1: req done (CMD25): 0: 00000900 00000000 00000000 
00000000
[   61.945125] mmc1:     4096 bytes transferred: 0
[   61.949598] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   61.956107] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.961888] mmc1: starting CMD13 arg 50480000 flags 00000195
[   61.967581] mmci-pl18x 58005000.mmc: op 0d arg 50480000 flags 00000195
[   61.974026] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   61.979718] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 
00000000
[   61.986630] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   61.992588] mmc1: starting CMD49 arg 10020a00 flags 00000035
[   61.998152] mmc1:     blksz 512 blocks 1 flags 00000100 tsac 3000 ms 
nsac 0
[   62.005158] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000100
[   62.011778] mmci-pl18x 58005000.mmc: op 31 arg 10020a00 flags 00000035
[   62.018317] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   62.024011] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
[   62.029801] mmc1: req done (CMD49): 0: 00000900 00000000 00000000 
00000000
[   62.036708] mmc1:     512 bytes transferred: 0
[   62.041083] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   62.046988] mmc1: starting CMD48 arg 10020a00 flags 000000b5
[   62.052487] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[   62.059443] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000200
[   62.066154] mmci-pl18x 58005000.mmc: op 30 arg 10020a00 flags 000000b5
[   62.072688] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   62.078382] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
[   62.084173] mmc1: req done (CMD48): 0: 00000900 00000000 00000000 
00000000
[   62.091081] mmc1:     512 bytes transferred: 0
[   62.095455] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000


[   62.101381] I/O error, dev mmcblk1, sector 8192 op 0x1:(WRITE) flags 
0x800 phys_seg 1 prio class 2
[   62.110223] Buffer I/O error on dev mmcblk1p4, logical block 0, lost 
sync page write
[   62.117996] EXT4-fs (mmcblk1p4): I/O error while writing superblock
[   62.124320] EXT4-fs (mmcblk1p4): mount failed


[   62.129676] <mmc1: starting CMD23 arg 00000002 flags 00000015>
[   62.134452] mmc1: starting CMD18 arg 00002000 flags 000000b5
[   62.140055] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms 
nsac 0
[   62.147003] mmc1:     CMD12 arg 00000000 flags 00000095
[   62.152205] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
[   62.158915] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
[   62.165431] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   62.171229] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
[   62.177734] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   62.183566] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
[   62.189262] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 
00000000
[   62.196169] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[   62.202973] mmc1:     1024 bytes transferred: 0
[   62.207546] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   62.213966] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   62.220406] mmc1: starting CMD17 arg 00002000 flags 000000b5
[   62.225497] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[   62.232324] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000200
[   62.239033] mmci-pl18x 58005000.mmc: op 11 arg 00002000 flags 000000b5
[   62.245571] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   62.251267] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
[   62.257058] mmc1: req done (CMD17): 0: 00000900 00000000 00000000 
00000000
[   62.263966] mmc1:     512 bytes transferred: 0
[   62.268347] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
[   62.274791] mmc1: starting CMD17 arg 00002000 flags 000000b5
[   62.279800] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[   62.286783] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000200
[   62.293396] mmci-pl18x 58005000.mmc: op 11 arg 00002000 flags 000000b5
[   62.299912] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
[   62.305612] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
[   62.311403] mmc1: req done (CMD17): 0: 00000900 00000000 00000000 
00000000
[   62.318309] mmc1:     512 bytes transferred: 0
[   62.322801] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000

mount: mounting /dev/mmcblk1p4 on /mnt failed: Invalid argument
~ #

[   62.873917] mmc0: starting CMD7 arg fffd0000 flags 00000015
[   62.878152] mmci-pl18x 48004000.mmc: op 07 arg fffd0000 flags 00000015
[   62.884681] mmci-pl18x 48004000.mmc: irq0 (data+cmd) 00000040
[   62.890381] mmc0: req done (CMD7): 0: 00001ed7 00000000 00000000 00000000

