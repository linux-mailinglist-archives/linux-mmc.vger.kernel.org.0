Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47375DA383
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395269AbfJQCQ0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 22:16:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:45506 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfJQCQ0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Oct 2019 22:16:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9H2Fdnw003104;
        Wed, 16 Oct 2019 21:15:41 -0500
Message-ID: <a67f38b59eeb579136b248240d409af6f5a57bb8.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Date:   Thu, 17 Oct 2019 13:15:39 +1100
In-Reply-To: <20191015131750.GV25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
         <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
         <20191015125105.GU25745@shell.armlinux.org.uk>
         <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
         <20191015131750.GV25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2019-10-15 at 14:17 +0100, Russell King - ARM Linux admin
wrote:
> On Tue, Oct 15, 2019 at 03:12:49PM +0200, Christian Zigotzky wrote:
> > Hello Russell,
> > 
> > You asked me about "dma-coherent" in the Cyrus device tree.
> > Unfortunately I
> > don't find the property "dma-coherent" in the dtb source files.
> > 
> > Output of "fdtdump cyrus_p5020_eth_poweroff.dtb | grep dma":
> > 
> > dma0 = "/soc@ffe000000/dma@100300";
> >         dma1 = "/soc@ffe000000/dma@101300";
> >         dma@100300 {
> >             compatible = "fsl,eloplus-dma";
> >             dma-channel@0 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@80 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@100 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@180 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >         dma@101300 {
> >             compatible = "fsl,eloplus-dma";
> >             dma-channel@0 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@80 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@100 {
> >                 compatible = "fsl,eloplus-dma-channel";
> >             dma-channel@180 {
> >                 compatible = "fsl,eloplus-dma-channel";
> 
> Hmm, so it looks like PowerPC doesn't mark devices that are dma
> coherent with a property that describes them as such.
> 
> I think this opens a wider question - what should
> of_dma_is_coherent()
> return for PowerPC?  It seems right now that it returns false for
> devices that are DMA coherent, which seems to me to be a recipe for
> future mistakes.
> 
> Any ideas from the PPC maintainers?

The historical powerpc OF machines were all coherent. OF didn't define
such attributes iirc.

We could add some kind of arch/platform override for that, all the
native OF platforms are coherent at this point afaik, only embedded
with fdt aren't always.

Our *code* knows whether DMA is coherent, but it's not exposed in the
DT for those historical reasons.

Cheers,
Ben.

> > 
> > Thanks,
> > Christian
> > 
> > 
> > On 15 October 2019 at 2:51 pm, Russell King - ARM Linux admin
> > wrote:
> > > The patch which you are reverting fixes exactly the same error on
> > > ARM64 boards.
> > > 
> > > I had tried to get some additional information from you, but I
> > > never
> > > received a response to my query.
> > > 
> > > While it is regrettable that fixing that has caused a regression
> > > for yours (which we need to fix) we really need to find a way to
> > > solve this for both situations.
> > > 
> > > Merely reverting the patch and then sitting on our hands with no
> > > possible solution for ARM64 isn't really an acceptable way
> > > forward.
> > > 
> > > The only solution I can see at the moment to this is to #ifdef in
> > > the driver based on whether we are building for ARM64 or PowerPC.
> > > 
> > > Maybe someone else can come up with a better idea?
> > > 
> > > On Tue, Oct 15, 2019 at 02:27:44PM +0200, Christian Zigotzky
> > > wrote:
> > > > Hello,
> > > > 
> > > > We have patched the RC2 [1] and RC3 [2] of kernel 5.4 with the
> > > > mmc3 patch
> > > > [3] and after that the onboard SD card works without any
> > > > problems with them.
> > > > 
> > > > Could you please add this patch or do you have another
> > > > solution?
> > > > 
> > > > Thanks,
> > > > Christian
> > > > 
> > > > [1] 
> > > > http://www.xenosoft.de/linux-image-5.4-rc2-X1000_X5000_A1222.tar.gz
> > > > [2] 
> > > > http://www.xenosoft.de/linux-image-5.4-rc3-X1000_X5000_A1222.tar.gz
> > > > [3] http://www.xenosoft.de/mmc3.patch
> > > > 
> > > > 
> > > > On 05 October 2019 at 00:45 am, Christian Zigotzky wrote:
> > > > > Hello,
> > > > > 
> > > > > The onboard SD card of the Cyrus+ PowerPC board (A-EON
> > > > > AmigaOne X5000)
> > > > > [1] doesn't work anymore after the 'mmc-v5.4-2' updates [2].
> > > > > 
> > > > > Error messages:
> > > > > 
> > > > > [   12.118148] mmc0: SDHCI controller on ffe114000.sdhc
> > > > > [ffe114000.sdhc]
> > > > > using ADMA
> > > > > [   12.232869] mmc0: ADMA error: 0x02000000
> > > > > [   12.237977] mmc0: sdhci: ============ SDHCI REGISTER DUMP
> > > > > ===========
> > > > > [   12.243137] mmc0: sdhci: Sys addr:  0x00000000 | Version:
> > > > > 0x00001301
> > > > > [   12.248307] mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:
> > > > > 0x00000001
> > > > > [   12.253448] mmc0: sdhci: Argument:  0x00000000 | Trn mode:
> > > > > 0x00000013
> > > > > [   12.258530] mmc0: sdhci: Present:   0x01fd020a | Host ctl:
> > > > > 0x00000030
> > > > > [   12.263572] mmc0: sdhci: Power:     0x00000002 | Blk gap:
> > > > > 0x00000000
> > > > > [   12.268574] mmc0: sdhci: Wake-up:   0x00000000 | Clock:
> > > > > 0x000020f8
> > > > > [   12.273535] mmc0: sdhci: Timeout:   0x00000003 | Int stat:
> > > > > 0x00000001
> > > > > [   12.278461] mmc0: sdhci: Int enab:  0x037f008f | Sig enab:
> > > > > 0x037f008b
> > > > > [   12.283339] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int:
> > > > > 0x00001301
> > > > > [   12.288198] mmc0: sdhci: Caps:      0x05fa0000 | Caps_1:
> > > > > 0x00000000
> > > > > [   12.293032] mmc0: sdhci: Cmd:       0x0000333a | Max curr:
> > > > > 0x00000000
> > > > > [   12.297861] mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:
> > > > > 0x001dd533
> > > > > [   12.302615] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:
> > > > > 0x3f400e00
> > > > > [   12.307312] mmc0: sdhci: Host ctl2: 0x00000000
> > > > > [   12.311940] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr:
> > > > > 0x7e04f208
> > > > > [   12.316573] mmc0: sdhci:
> > > > > ============================================
> > > > > [   12.321204] mmc0: sdhci: 7e04f200: DMA 0xfc000000, LEN
> > > > > 0x0008,
> > > > > Attr=0x23
> > > > > [   12.326022] mmc0: error -5 whilst initialising SD card
> > > > > [   12.507466] mmc0: invalid bus width
> > > > > [   12.512154] mmc0: error -22 whilst initialising SD card
> > > > > [   12.683457] mmc0: invalid bus width
> > > > > [   12.688968] mmc0: error -22 whilst initialising SD card
> > > > > [   12.774281] mmc0: invalid bus width
> > > > > [   12.779910] mmc0: error -22 whilst initialising SD card
> > > > > 
> > > > > -------------------------
> > > > > 
> > > > > I have found the issue in the DMA changes of the 'mmc-v5.4-2' 
> > > > > updates.
> > > > > It's the commit "121bd08b029e03404c451bb237729cdff76eafed
> > > > > (mmc:
> > > > > sdhci-of-esdhc: set DMA snooping based on DMA coherence)"
> > > > > [3].
> > > > > 
> > > > > Please find attached a patch. This patch solves the issue.
> > > > > 
> > > > > dmesg output after compiling with the attached patch:
> > > > > 
> > > > > [   12.117149] mmc0: SDHCI controller on ffe114000.sdhc
> > > > > [ffe114000.sdhc]
> > > > > using ADMA
> > > > > [   12.208646] mmc0: new high speed SDHC card at address 59b4
> > > > > [   12.230808] mmcblk0: mmc0:59b4 USD   3.73 GiB
> > > > > 
> > > > > -------------------------
> > > > > 
> > > > > Please check the commit
> > > > > "121bd08b029e03404c451bb237729cdff76eafed" [3].
> > > > > 
> > > > > Thanks,
> > > > > Christian
> > > > > 
> > > > > 
> > > > > [1] https://www.amigaos.net/hardware/133/amigaone-x5000 and
> > > > > http://wiki.amiga.org/index.php?title=X5000
> > > > > [2] 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.4-rc1&id=c710364f78afdef8c2ed07556d0743c5a30ed429
> > > > > [3] 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=121bd08b029e03404c451bb237729cdff76eafed
> > > > > 
> > 
> > 
> 
> 

