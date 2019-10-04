Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2ECC625
	for <lists+linux-mmc@lfdr.de>; Sat,  5 Oct 2019 00:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJDW5i (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 18:57:38 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:14329 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDW5i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2019 18:57:38 -0400
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 18:57:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570229854;
        s=strato-dkim-0002; d=xenosoft.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Hhdd0snFmPNMm6d0eeE73MsxRfES69rZGvUTRlud/xs=;
        b=KWgTfQxBhBB1VVuZYC379ynFQUWSC70R649NOKKKtibzGPNwPm6lQ7U12yDBIZXUbb
        q5wK+jfizG1J+EiktdXb2lgfEeI0x08cuS8r/ShCiRM7nWNOU6Pp6+AI/RBQMVnAo693
        vki7gsuzkFXzkr4b0VacHwLPbd4/x3lSkuA/Z4ENd4YMBKtGip3Qrt8OOYTo0P86u/hv
        72tM3GeJ8IeShPgsrvcBYFCBTRn6OWvqyIuCkf3xf+B7k+EQ5DRi8oLhof04neQFluY5
        Mcti7AnJI1DF4ypgjBe95f4oyeZcE0NACV7muVuCYjVJAttmkFbkbO8aYKGISvL5XZlj
        m/Ug==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWLruUDw4lbugEXqTsP2OdwP6HOA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:5860:ec51:d806:5a6c]
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id g03e8av94MjU3Tr
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 5 Oct 2019 00:45:30 +0200 (CEST)
To:     rmk+kernel@armlinux.org.uk, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
Message-ID: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
Date:   Sat, 5 Oct 2019 00:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E79FBCC9D1F182D461155210"
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------E79FBCC9D1F182D461155210
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

The onboard SD card of the Cyrus+ PowerPC board (A-EON AmigaOne X5000) 
[1] doesn't work anymore after the 'mmc-v5.4-2' updates [2].

Error messages:

[   12.118148] mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc] 
using ADMA
[   12.232869] mmc0: ADMA error: 0x02000000
[   12.237977] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   12.243137] mmc0: sdhci: Sys addr:  0x00000000 | Version: 0x00001301
[   12.248307] mmc0: sdhci: Blk size:  0x00000008 | Blk cnt: 0x00000001
[   12.253448] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[   12.258530] mmc0: sdhci: Present:   0x01fd020a | Host ctl: 0x00000030
[   12.263572] mmc0: sdhci: Power:     0x00000002 | Blk gap: 0x00000000
[   12.268574] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x000020f8
[   12.273535] mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
[   12.278461] mmc0: sdhci: Int enab:  0x037f008f | Sig enab: 0x037f008b
[   12.283339] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00001301
[   12.288198] mmc0: sdhci: Caps:      0x05fa0000 | Caps_1: 0x00000000
[   12.293032] mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
[   12.297861] mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]: 0x001dd533
[   12.302615] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]: 0x3f400e00
[   12.307312] mmc0: sdhci: Host ctl2: 0x00000000
[   12.311940] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x7e04f208
[   12.316573] mmc0: sdhci: ============================================
[   12.321204] mmc0: sdhci: 7e04f200: DMA 0xfc000000, LEN 0x0008, Attr=0x23
[   12.326022] mmc0: error -5 whilst initialising SD card
[   12.507466] mmc0: invalid bus width
[   12.512154] mmc0: error -22 whilst initialising SD card
[   12.683457] mmc0: invalid bus width
[   12.688968] mmc0: error -22 whilst initialising SD card
[   12.774281] mmc0: invalid bus width
[   12.779910] mmc0: error -22 whilst initialising SD card

-------------------------

I have found the issue in the DMA changes of the 'mmc-v5.4-2' updates. 
It's the commit "121bd08b029e03404c451bb237729cdff76eafed (mmc: 
sdhci-of-esdhc: set DMA snooping based on DMA coherence)" [3].

Please find attached a patch. This patch solves the issue.

dmesg output after compiling with the attached patch:

[   12.117149] mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc] 
using ADMA
[   12.208646] mmc0: new high speed SDHC card at address 59b4
[   12.230808] mmcblk0: mmc0:59b4 USD   3.73 GiB

-------------------------

Please check the commit "121bd08b029e03404c451bb237729cdff76eafed" [3].

Thanks,
Christian


[1] https://www.amigaos.net/hardware/133/amigaone-x5000 and 
http://wiki.amiga.org/index.php?title=X5000
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.4-rc1&id=c710364f78afdef8c2ed07556d0743c5a30ed429
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=121bd08b029e03404c451bb237729cdff76eafed


--------------E79FBCC9D1F182D461155210
Content-Type: text/x-patch;
 name="mmc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmc3.patch"

diff -rupN a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
--- a/drivers/mmc/host/sdhci-of-esdhc.c	2019-10-04 12:40:23.736729250 +0200
+++ b/drivers/mmc/host/sdhci-of-esdhc.c	2019-10-04 12:40:46.476869118 +0200
@@ -495,12 +495,7 @@ static int esdhc_of_enable_dma(struct sd
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
-
-	if (of_dma_is_coherent(dev->of_node))
-		value |= ESDHC_DMA_SNOOP;
-	else
-		value &= ~ESDHC_DMA_SNOOP;
-
+	value |= ESDHC_DMA_SNOOP;
 	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
 	return 0;
 }


--------------E79FBCC9D1F182D461155210--
