Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE45B7543
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfISIiZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 04:38:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42820 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbfISIiY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 04:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H470QmtT42YmIjogAwKAdDemx0o9SL04xgAco7MNweY=; b=DfrqAszCvhsjOsgJvZ9j9xxjX
        AARD6swyFsDNGpCPjU3mdvKkqbvFaMXefBKb+4lQES+rogEvEI1V7mLSSXLDOmQ0r28fBrhNDWUcI
        5qv3zcqOCrQAfUKcnID82ARLrxVHlAwTRt0v8VxnBtLiHs1OsEcO647VmDi956lXEUOJp1wNIvea6
        sLfsbiyDbSiS4yZOkJglXZ0guNIPASN5NA3cPdUrYQnlAWGHYEZgDhBe89wbEAwkutkTCRFlvmiIW
        UUXYPyR4sRzFpFya9gkoweWfQArknihihblvK4jVuRX3uCk6mQxWN4kq8VmqJeI2dTVRgUY+AoPoQ
        43Yjp4SfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45518)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iArx2-0004zu-I6; Thu, 19 Sep 2019 09:38:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iArwy-00036m-1n; Thu, 19 Sep 2019 09:38:04 +0100
Date:   Thu, 19 Sep 2019 09:38:04 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190919083803.GG25745@shell.armlinux.org.uk>
References: <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
 <20190917133317.GQ25745@shell.armlinux.org.uk>
 <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
 <20190917135157.GT25745@shell.armlinux.org.uk>
 <CAOMZO5BDirX0Fwo716v1ddYaaO+OL8Woht63mw8OEhDuMBTb8Q@mail.gmail.com>
 <CADRPPNQ-WTY0QC7_bX=N0QeueKve=k0SaMvbjOrByyvzFojz2g@mail.gmail.com>
 <VI1PR0401MB22376A0EA85123B2AEB72EDEF8890@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <20190919070435.GF25745@shell.armlinux.org.uk>
 <VI1PR0401MB2237E1B46D540B4362417AEEF8890@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0401MB2237E1B46D540B4362417AEEF8890@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Thanks for the reply.

I see that this bit is marked "reserved" in the LX2160A reference
manual.

This brings up some further questions.

The DT property "dma-coherent" is used to tell the OS whether the
device is DMA coherent or not.  If this property is missing, but the
device is set as DMA coherent, and the OS uses "normal, non-cacheable"
memory for the ADMA table, then errors can occur if there are stale
cache lines corresponding to the memory used.  The eSDHC controller
will see the stale cache lines, but the CPU will not.

Adding "dma-coherent" to the DT declarations alone does not seem to
be the right solution - if we have an OS that does not set the
ESDHC_DMA_SNOOP bit, then we have a similar issue.

Shouldn't ESDHC_DMA_SNOOP be set depending on whether the device is
DMA coherent or not?

Note that the device is _not_ marked as "dma-coherent" in either
mainline nor in the LSDK-19.06-V4.19 branch of
https://source.codeaurora.org/external/qoriq/qoriq-components/linux
to avoid ADMA descriptor fetch errors, which leads to this error that
has now been observed with v5.3 kernels - caused precisely as I
describe above.

Thanks.

On Thu, Sep 19, 2019 at 08:15:00AM +0000, Y.b. Lu wrote:
> Hi Russell,
> 
> The ESDHC_DMA_SNOOP bit is always set in eSDHC driver for DMA.
> 
> 1b - DMA transactions are snooped by the CPU data cache.
> 0b - DMA transactions are not snooped by the CPU data cache.
> 
> Thanks a lot.
> 
> Best regards,
> Yangbo Lu
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> > Sent: Thursday, September 19, 2019 3:05 PM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: Leo Li <leoyang.li@nxp.com>; Fabio Estevam <festevam@gmail.com>;
> > Adrian Hunter <adrian.hunter@intel.com>; Christoph Hellwig <hch@lst.de>;
> > Linux ARM <linux-arm-kernel@lists.infradead.org>; Nicolin Chen
> > <nicoleotsuka@gmail.com>; Will Deacon <will.deacon@arm.com>; dann
> > frazier <dann.frazier@canonical.com>; linux-mmc
> > <linux-mmc@vger.kernel.org>
> > Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
> > 
> > Hi,
> > 
> > This is not the issue, since the problem has been observed with eMMC too,
> > and is sporadic in nature.
> > 
> > Please could you answer the question posed: are the eSDHC controllers DMA
> > coherent or are they not coherent?
> > 
> > Thanks.
> > 
> > On Thu, Sep 19, 2019 at 04:13:20AM +0000, Y.b. Lu wrote:
> > > Sorry. My email was rejected by mailing lists. Let me re-send.
> > >
> > > Hi Russell,
> > >
> > > I’m not sure what board you were using for LX2160A.
> > > We had an known issue for eSDHC controller and all NXP Layerscape RDB
> > boards.
> > > eSDHC couldn’t provide power-cycle to SD card, and even worse, board
> > reset couldn’t provide power-cycle to SD card either.
> > > But for UHS-I SD card, it’s required to have a power-cycle to reset card if it
> > goes into UHS-I mode. Otherwise, we don’t know what will happen when
> > kernel initializes SD card after a reboot/reset.
> > >
> > > I could reproduce that issue with below steps on latest mainline kernel.
> > > 1. Power off board, and power on board.
> > > 2. Start up kernel, the SD card works fine in UHS-I mode.
> > > 3. Reboot/reset board. (This couldn’t provide power-cycle to SD card)
> > > 4. Start up kernel, the SD card gets that ADMA error issue.
> > >
> > > So could you have a try to power off/power on the board, and then start up
> > kernel. Don’t use reboot, or board reset button.
> > > Or you can remove SD card and start up kernel, and insert SD card when
> > kernel has been started up.
> > > Thanks a lot.
> > >
> > > Best regards,
> > > Yangbo Lu
> > >
> > >
> > > From: Li Yang <leoyang.li@nxp.com>
> > > Sent: Wednesday, September 18, 2019 1:48 AM
> > > To: Fabio Estevam <festevam@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>; Christoph Hellwig
> > > <hch@lst.de>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> > > Nicolin Chen <nicoleotsuka@gmail.com>; Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk>; Will Deacon <will.deacon@arm.com>; dann
> > > frazier <dann.frazier@canonical.com>; linux-mmc
> > > <linux-mmc@vger.kernel.org>
> > > Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
> > >
> > >
> > >
> > > On Tue, Sep 17, 2019 at 6:31 PM Fabio Estevam
> > <mailto:festevam@gmail.com> wrote:
> > > [Adding Li Yang]
> > >
> > > On Tue, Sep 17, 2019 at 10:52 AM Russell King - ARM Linux admin
> > > <mailto:linux@armlinux.org.uk> wrote:
> > >
> > > > The pressing question seems to be this:
> > > >
> > > > Are the eSDHC on the LX2160A DMA coherent or are they not?
> > > >
> > > > Any chances of finding out internally what the true answer to that,
> > > > rather than me poking about trying stuff experimentally?  Having a
> > > > definitive answer for a potentially data-corrupting change would be
> > > > really good...
> > >
> > > Li Yang,
> > >
> > > Could you please help to confirm Russell's question?
> > > Adding Yangbo who is working on SDHC.
> > >
> > > Regards,
> > > Leo
> > 
> > --
> > RMK's Patch system:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.ar
> > mlinux.org.uk%2Fdeveloper%2Fpatches%2F&amp;data=02%7C01%7Cyangbo.l
> > u%40nxp.com%7C7eca2b9652104c95a52008d73ccfa99a%7C686ea1d3bc2b4
> > c6fa92cd99c5c301635%7C0%7C0%7C637044734911465102&amp;sdata=QB
> > SEzA9L2HC99gm65P965E3o%2FhNM18u2SouOZxTEs6s%3D&amp;reserved=0
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps
> > up According to speedtest.net: 11.9Mbps down 500kbps up

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
