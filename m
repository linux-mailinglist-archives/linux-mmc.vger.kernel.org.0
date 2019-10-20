Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B4DDE5C
	for <lists+linux-mmc@lfdr.de>; Sun, 20 Oct 2019 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJTMFH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 20 Oct 2019 08:05:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36825 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfJTMFH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2019 08:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571573105;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8H+CMpEwzqYy5LHk3gxhK8iI3SNbeVS1cPtd7OzwDBQ=;
        b=JT/gesQ+O71ngkB/T45Al5hnmqLrO1Qhq1dOvAPUXwVCzcNuQBwe6YvSeHgq/4jNYD
        sCVv9g+M6FjNALD18t/iQuNI69OMDenV1QJ/U8mAQJYLQ2jSpaEnOu/aid+VFa289ld6
        m3/dGu7GRbgny5YPA1cREDsSZDc5xfK1rNAoKbcyQTsXI9z1bB0DV/6eW35PnPXIWUaC
        9zp5w11rMyAc9bldlTJQKpImpmVZe6gsMmL9FtxgzqVmT21AhRyfx54ZeCtaYuUsoB0F
        eSaz+oRdjfisv8CuaWC7f081GhdtSf33qYDLdTuo/nE9+km5rjDLGrh07efOCETRLw49
        j/0g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhVcvwk8rOJw/tJt+5KIQkGUZkZOA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:6de1:f93e:bc61:ac15]
        by smtp.strato.de (RZmta 44.28.1 AUTH)
        with ESMTPSA id 60869dv9KC4eNCM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 20 Oct 2019 14:04:40 +0200 (CEST)
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
 <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
 <20191018101323.GG25745@shell.armlinux.org.uk>
 <499d70835d5f3e3cc191e5b5444475cd5a8c4604.camel@kernel.crashing.org>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <8d7fd474-a1ad-e33f-f2ba-ec47f4bcc995@xenosoft.de>
Date:   Sun, 20 Oct 2019 14:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <499d70835d5f3e3cc191e5b5444475cd5a8c4604.camel@kernel.crashing.org>
Content-Type: multipart/mixed;
 boundary="------------89D2DA97C68DD4C8D11137DB"
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------89D2DA97C68DD4C8D11137DB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19 October 2019 at 01:40 am, Benjamin Herrenschmidt wrote:
> Anywhere is fine but I think it's easy. Coherent DMA is for historical
> reasons a function of the processor generation, and as such a CONFIG
> option.
>
> So setting it according to CONFIG_NOT_COHERENT_CACHE will probably work
> just fine.
>
> Well at least I think so ... unless I'm missing some broken HW
> somewhere I am not aware of.
>
> Cheers,
> Ben.
Hi Ben,

Thanks a lot for your suggestion!

I had to create a patch because I wasn't able to select 
"CONFIG_NOT_COHERENT_CACHE" in the kernel configuration (patch attached).

After patching I was able to select "CONFIG_NOT_COHERENT_CACHE" in the 
kernel config. I compiled a new RC3 of kernel 5.4 with this kernel 
config option yesterday.

The good news is, that the onboard SD card works! We successfully tested 
it on two AmigaOnes (X5000/20 and X5000/40) yesterday but we need a new 
patch
because of the possibility to select "CONFIG_NOT_COHERENT_CACHE" in the 
kernel config.

Cheers,
Christian

--------------89D2DA97C68DD4C8D11137DB
Content-Type: text/x-patch;
 name="not_coherent_cache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="not_coherent_cache.patch"

--- a/arch/powerpc/platforms/Kconfig.cputype	2019-10-14 01:37:36.000000000 +0200
+++ b/arch/powerpc/platforms/Kconfig.cputype	2019-10-19 15:20:07.884007876 +0200
@@ -152,6 +152,7 @@ config POWER9_CPU
 config E5500_CPU
 	bool "Freescale e5500"
 	depends on E500
+	select NOT_COHERENT_CACHE
 
 config E6500_CPU
 	bool "Freescale e6500"
@@ -458,7 +459,7 @@ config NR_CPUS
 config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
-		GAMECUBE_COMMON || AMIGAONE
+		GAMECUBE_COMMON || AMIGAONE || E5500_CPU
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE

--------------89D2DA97C68DD4C8D11137DB--
