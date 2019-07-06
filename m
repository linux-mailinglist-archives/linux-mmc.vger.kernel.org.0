Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2956060FBA
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Jul 2019 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGFKCD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 6 Jul 2019 06:02:03 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:54986
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfGFKCD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 6 Jul 2019 06:02:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id B2D953FE9A;
        Sat,  6 Jul 2019 12:02:01 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UhgNcvVFUWmt; Sat,  6 Jul 2019 12:02:01 +0200 (CEST)
Received: from jerusalem (host105-54-dynamic.182-80-r.retail.telecomitalia.it [80.182.54.105])
        by sysam.it (Postfix) with ESMTPSA id 5572B3F114;
        Sat,  6 Jul 2019 12:02:01 +0200 (CEST)
Date:   Sat, 6 Jul 2019 12:02:00 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mmc: enabling ColdFire esdhc controller support
Message-ID: <20190706100200.GB6763@jerusalem>
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190616204823.32758-3-angelo@sysam.it>
 <fe023694-84f3-e751-8cc9-0e1353140969@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe023694-84f3-e751-8cc9-0e1353140969@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, Jul 02, 2019 at 12:11:02PM +0300, Adrian Hunter wrote:
> On 16/06/19 11:48 PM, Angelo Dureghello wrote:
> > Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> > ---
> >  drivers/mmc/host/Kconfig  | 13 +++++++++++++
> >  drivers/mmc/host/Makefile |  3 ++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 931770f17087..9b426094d10a 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -221,6 +221,19 @@ config MMC_SDHCI_CNS3XXX
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_ESDHC_MCF
> > +	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
> > +	depends on M5441x
> > +	depends on MMC_SDHCI_PLTFM
> > +	select MMC_SDHCI_IO_ACCESSORS
> > +	help
> > +	  This selects the Freescale eSDHC controller support for
> > +	  ColdFire mcf5441x devices.
> > +
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_ESDHC_IMX
> >  	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
> >  	depends on ARCH_MXC
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 73578718f119..b2127ee5e71e 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
> >  obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
> >  obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
> >  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
> > +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
> >  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
> >  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> > @@ -103,4 +104,4 @@ ifeq ($(CONFIG_CB710_DEBUG),y)
> >  endif
> >  
> >  obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
> > -sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
> > +sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.
> 
> Inadvertent change there

Aaargh, sorry, good cactch :) Will fix it.

Reagrds,
Angelo
