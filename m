Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1DCC618
	for <lists+linux-mmc@lfdr.de>; Sat,  5 Oct 2019 00:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfJDWxh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 18:53:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38412 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDWxg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2019 18:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2iHPu4RmYJMaYcpA+iK/U0jkAvhp4C3OjDPLkyJEgv8=; b=WQ4Tp88IK0UmF21ZDykXnztuE
        3ebpu0OUpt8TTr5aQMwJEavrEz0i6A44HRvCz8YVdJKj9lMdaM8+p5PHE2dAVBXdJimnfjEdL3xPX
        5HLpUnEx4BZ+woIoRidc9o5bCkurirl5ieydyO4uph8Bw6VL8eb7I+lg0vyg/IbbeumBxXNrqMEAZ
        dupb1lOHX74Cddt4/RrGTSnB1XFuxbCb0GMtpA9cS8khgCwl7TzaVzNBL2USiSaMuZmeUie6Mpm01
        nUIC0ukWPPng7edMoJvOgDBP4RqNZGNsJWlNC28y70ora22cgijMTprFDOafGG6W/+pIAO3PfHhS4
        6XrDbb/kA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:47654)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iGWS1-0007Si-2h; Fri, 04 Oct 2019 23:53:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iGWRu-00037l-V9; Fri, 04 Oct 2019 23:53:22 +0100
Date:   Fri, 4 Oct 2019 23:53:22 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Message-ID: <20191004225322.GA25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Oct 05, 2019 at 12:45:29AM +0200, Christian Zigotzky wrote:
> Hello,
> 
> The onboard SD card of the Cyrus+ PowerPC board (A-EON AmigaOne X5000) [1]
> doesn't work anymore after the 'mmc-v5.4-2' updates [2].

Hi Christian,

Please can you help us understand what is going on with your setup.
Obviously, your board wants the SDHCI controller to be DMA coherent,
but I guess that DT on your platform does not specify the
"dma-coherent" property.  Can you confirm that?

If that's the case, the question is what we do about that - do we add
it (and wait for further reports?)

The only alternative I can see is that we split ARM usage from PowerPC
usage of this driver; it seems PowerPC can get away with being more
lenient wrt DT DMA coherency correctness than the ARM architecture.

Thanks.

> 
> Error messages:
> 
> [   12.118148] mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc]
> using ADMA
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
> [   12.321204] mmc0: sdhci: 7e04f200: DMA 0xfc000000, LEN 0x0008, Attr=0x23
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
> I have found the issue in the DMA changes of the 'mmc-v5.4-2' updates. It's
> the commit "121bd08b029e03404c451bb237729cdff76eafed (mmc: sdhci-of-esdhc:
> set DMA snooping based on DMA coherence)" [3].
> 
> Please find attached a patch. This patch solves the issue.
> 
> dmesg output after compiling with the attached patch:
> 
> [   12.117149] mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc]
> using ADMA
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
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.4-rc1&id=c710364f78afdef8c2ed07556d0743c5a30ed429
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=121bd08b029e03404c451bb237729cdff76eafed
> 

> diff -rupN a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> --- a/drivers/mmc/host/sdhci-of-esdhc.c	2019-10-04 12:40:23.736729250 +0200
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c	2019-10-04 12:40:46.476869118 +0200
> @@ -495,12 +495,7 @@ static int esdhc_of_enable_dma(struct sd
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>  
>  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> -
> -	if (of_dma_is_coherent(dev->of_node))
> -		value |= ESDHC_DMA_SNOOP;
> -	else
> -		value &= ~ESDHC_DMA_SNOOP;
> -
> +	value |= ESDHC_DMA_SNOOP;
>  	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
>  	return 0;
>  }
> 


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
