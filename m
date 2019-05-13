Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB41B0C9
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfEMHGK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 03:06:10 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:35174
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMHGK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 May 2019 03:06:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id BA7043FE8A;
        Mon, 13 May 2019 09:06:08 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E3rN5OihX1WU; Mon, 13 May 2019 09:06:08 +0200 (CEST)
Received: from jerusalem (host87-8-dynamic.4-87-r.retail.telecomitalia.it [87.4.8.87])
        by sysam.it (Postfix) with ESMTPSA id 4C5BF3FE89;
        Mon, 13 May 2019 09:06:08 +0200 (CEST)
Date:   Mon, 13 May 2019 09:06:07 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: enabling ColdFire esdhc controller support
Message-ID: <20190513070607.GA3787@jerusalem>
References: <20190512194125.7091-1-angelo@sysam.it>
 <20190512194125.7091-3-angelo@sysam.it>
 <29ee5453-0df4-67dc-ed25-bc1eb3e8c8e6@westnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ee5453-0df4-67dc-ed25-bc1eb3e8c8e6@westnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Greg,
On Mon, May 13, 2019 at 02:19:57PM +1000, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 13/5/19 5:41 am, Angelo Dureghello wrote:
> > Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> > ---
> >   drivers/mmc/host/Kconfig  | 13 +++++++++++++
> >   drivers/mmc/host/Makefile |  3 +++
> >   2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 0e86340536b6..91007572a097 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -220,6 +220,19 @@ config MMC_SDHCI_CNS3XXX
> >   	  If unsure, say N.
> > +config MMC_SDHCI_ESDHC_MCF
> > +	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
> > +	depends on M5441x
> > +	depends on MMC_SDHCI_PLTFM
> > +	select MMC_SDHCI_IO_ACCESSORS
> > +	help
> > +	  This selects the Freescale eSDHC/uSDHC controller support
> > +	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
> 
> So you copied/pasted this from the entry for the MMC_SDHCI_ESDHC_IMX driver?
> 
> I have not looked at the hardware module of the SHDC controller in
> the ColdFire parts, but is it in any way similar or the same as
> Freescale uses in the iMX families?
> 

Oh, i forgot those iMX references, need to fix it, thanks for 
catching it.

Initially i tried to use the existing imx driver, but mainly
the ColdFire controller needs all ops/accessors functions to be
big endian, and there are other minimal differecies in the
controllers. Finally the simpliest way was to create a separate
module. The base is still sdhci.c.

> Regards
> Greg
> 

Regards,
Angelo
> 
> 
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >   config MMC_SDHCI_ESDHC_IMX
> >   	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
> >   	depends on ARCH_MXC
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 73578718f119..17c3826dfe81 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
> >   obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
> >   obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
> >   obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
> > +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
> >   obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
> >   obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> >   obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> > @@ -104,3 +105,5 @@ endif
> >   obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
> >   sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
> > +
> > +CFLAGS_sdhci-esdhc-mcf.o := -DDEBUG
> > 
