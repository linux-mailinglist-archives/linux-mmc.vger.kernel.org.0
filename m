Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A75B73B0
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfISHE7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 03:04:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41718 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbfISHE7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 03:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CzzM8AvrkmEVXVXrnko+0JmV21yIkEG1rABUx/hxf8I=; b=kwOclrrxr/ZF75yoEZy3V+oCq
        hvN6n4dsS1IwsY0OHDE3Mp1U9fY91B1zSm8kBS5DfsoaCot4bn9anw9TP2G4Hcxc7D+VPpqZmXURq
        QPv76J4HmXjHp/SAbkaPsQ8JbBSZW6wu8oZRZvIRL+6d8dMfBYe2zI0NO797gqMHy1M8NZyf8Pp1K
        NNzPSYw7f+u5d+/hNitIHjC3M9lCrzl6nqIztM+hBQm+A5Ovos53p7Q8NIi6HBPLgOfnR6iD/xIHb
        tNFjn9+FTdanPvzaSDjbJALnh/aREyljiuOaY3nbXda5kFRe7EzMs5Iyr6/9sBUxS3b6kHPXbXu53
        mWA9apaqQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:41352)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAqUa-0004b0-Be; Thu, 19 Sep 2019 08:04:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAqUV-00033L-68; Thu, 19 Sep 2019 08:04:35 +0100
Date:   Thu, 19 Sep 2019 08:04:35 +0100
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
Message-ID: <20190919070435.GF25745@shell.armlinux.org.uk>
References: <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
 <20190917133317.GQ25745@shell.armlinux.org.uk>
 <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
 <20190917135157.GT25745@shell.armlinux.org.uk>
 <CAOMZO5BDirX0Fwo716v1ddYaaO+OL8Woht63mw8OEhDuMBTb8Q@mail.gmail.com>
 <CADRPPNQ-WTY0QC7_bX=N0QeueKve=k0SaMvbjOrByyvzFojz2g@mail.gmail.com>
 <VI1PR0401MB22376A0EA85123B2AEB72EDEF8890@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0401MB22376A0EA85123B2AEB72EDEF8890@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This is not the issue, since the problem has been observed with eMMC
too, and is sporadic in nature.

Please could you answer the question posed: are the eSDHC controllers
DMA coherent or are they not coherent?

Thanks.

On Thu, Sep 19, 2019 at 04:13:20AM +0000, Y.b. Lu wrote:
> Sorry. My email was rejected by mailing lists. Let me re-send.
> 
> Hi Russell,
> 
> I’m not sure what board you were using for LX2160A.
> We had an known issue for eSDHC controller and all NXP Layerscape RDB boards.
> eSDHC couldn’t provide power-cycle to SD card, and even worse, board reset couldn’t provide power-cycle to SD card either.
> But for UHS-I SD card, it’s required to have a power-cycle to reset card if it goes into UHS-I mode. Otherwise, we don’t know what will happen when kernel initializes SD card after a reboot/reset.
> 
> I could reproduce that issue with below steps on latest mainline kernel.
> 1. Power off board, and power on board.
> 2. Start up kernel, the SD card works fine in UHS-I mode.
> 3. Reboot/reset board. (This couldn’t provide power-cycle to SD card)
> 4. Start up kernel, the SD card gets that ADMA error issue.
> 
> So could you have a try to power off/power on the board, and then start up kernel. Don’t use reboot, or board reset button.
> Or you can remove SD card and start up kernel, and insert SD card when kernel has been started up.
> Thanks a lot.
> 
> Best regards,
> Yangbo Lu
> 
> 
> From: Li Yang <leoyang.li@nxp.com> 
> Sent: Wednesday, September 18, 2019 1:48 AM
> To: Fabio Estevam <festevam@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>; Christoph Hellwig <hch@lst.de>; Linux ARM <linux-arm-kernel@lists.infradead.org>; Nicolin Chen <nicoleotsuka@gmail.com>; Russell King - ARM Linux admin <linux@armlinux.org.uk>; Will Deacon <will.deacon@arm.com>; dann frazier <dann.frazier@canonical.com>; linux-mmc <linux-mmc@vger.kernel.org>
> Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
> 
> 
> 
> On Tue, Sep 17, 2019 at 6:31 PM Fabio Estevam <mailto:festevam@gmail.com> wrote:
> [Adding Li Yang]
> 
> On Tue, Sep 17, 2019 at 10:52 AM Russell King - ARM Linux admin
> <mailto:linux@armlinux.org.uk> wrote:
> 
> > The pressing question seems to be this:
> >
> > Are the eSDHC on the LX2160A DMA coherent or are they not?
> >
> > Any chances of finding out internally what the true answer to that,
> > rather than me poking about trying stuff experimentally?  Having a
> > definitive answer for a potentially data-corrupting change would
> > be really good...
> 
> Li Yang,
> 
> Could you please help to confirm Russell's question?
> Adding Yangbo who is working on SDHC.
> 
> Regards,
> Leo

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
