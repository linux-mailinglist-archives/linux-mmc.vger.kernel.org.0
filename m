Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7741C4C
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfFLGgR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 02:36:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:37028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFLGgR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 02:36:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 23:36:16 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2019 23:36:15 -0700
Subject: Re: [PATCH 3/3] mmc: enabling ColdFire esdhc controller support
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20190512194125.7091-1-angelo@sysam.it>
 <20190512194125.7091-3-angelo@sysam.it>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cb3d09a7-7e07-15da-b450-c12596d6af37@intel.com>
Date:   Wed, 12 Jun 2019 09:35:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190512194125.7091-3-angelo@sysam.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/05/19 10:41 PM, Angelo Dureghello wrote:
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
>  drivers/mmc/host/Kconfig  | 13 +++++++++++++
>  drivers/mmc/host/Makefile |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0e86340536b6..91007572a097 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -220,6 +220,19 @@ config MMC_SDHCI_CNS3XXX
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_ESDHC_MCF
> +	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
> +	depends on M5441x
> +	depends on MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Freescale eSDHC/uSDHC controller support
> +	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_ESDHC_IMX
>  	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
>  	depends on ARCH_MXC
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..17c3826dfe81 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
>  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
> +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> @@ -104,3 +105,5 @@ endif
>  
>  obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
>  sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
> +
> +CFLAGS_sdhci-esdhc-mcf.o := -DDEBUG

Leftover debugging?

> 


