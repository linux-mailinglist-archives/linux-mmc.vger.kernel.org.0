Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EE1AF7B
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfEME3T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 00:29:19 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:43198
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfEME3T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 00:29:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AbAADL79hc/zXSMGcNVxkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgWWCeoEshBGDe5B1LZpOCQEBAQEBAQEBASMUAQEBhD8?=
 =?us-ascii?q?CgjA4EwEDAQEBBAEBAQEDAYEJhVcBAQEDIxVBEAsNCwICJgICVwYBDAYCAQG?=
 =?us-ascii?q?DHgGBaQGqB3GBLxqFLYMcgUaBCyiBYIoGgUA/gREngms+h06CWASTHZQ4CYE?=
 =?us-ascii?q?bcFmRfSGMQQOJKIwyizCLZIF4Mxofg0AJij+GG2CQRAEB?=
X-IPAS-Result: =?us-ascii?q?A2AbAADL79hc/zXSMGcNVxkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgWWCeoEshBGDe5B1LZpOCQEBAQEBAQEBASMUAQEBhD8CgjA4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAYEJhVcBAQEDIxVBEAsNCwICJgICVwYBDAYCAQGDHgGBaQGqB3GBL?=
 =?us-ascii?q?xqFLYMcgUaBCyiBYIoGgUA/gREngms+h06CWASTHZQ4CYEbcFmRfSGMQQOJK?=
 =?us-ascii?q?IwyizCLZIF4Mxofg0AJij+GG2CQRAEB?=
X-IronPort-AV: E=Sophos;i="5.60,464,1549900800"; 
   d="scan'208";a="218534099"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 13 May 2019 12:19:58 +0800
Subject: Re: [PATCH 3/3] mmc: enabling ColdFire esdhc controller support
To:     Angelo Dureghello <angelo@sysam.it>, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20190512194125.7091-1-angelo@sysam.it>
 <20190512194125.7091-3-angelo@sysam.it>
From:   Greg Ungerer <gregungerer@westnet.com.au>
Message-ID: <29ee5453-0df4-67dc-ed25-bc1eb3e8c8e6@westnet.com.au>
Date:   Mon, 13 May 2019 14:19:57 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512194125.7091-3-angelo@sysam.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Angelo,

On 13/5/19 5:41 am, Angelo Dureghello wrote:
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
>   drivers/mmc/host/Kconfig  | 13 +++++++++++++
>   drivers/mmc/host/Makefile |  3 +++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0e86340536b6..91007572a097 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -220,6 +220,19 @@ config MMC_SDHCI_CNS3XXX
>   
>   	  If unsure, say N.
>   
> +config MMC_SDHCI_ESDHC_MCF
> +	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
> +	depends on M5441x
> +	depends on MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Freescale eSDHC/uSDHC controller support
> +	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.

So you copied/pasted this from the entry for the MMC_SDHCI_ESDHC_IMX driver?

I have not looked at the hardware module of the SHDC controller in
the ColdFire parts, but is it in any way similar or the same as
Freescale uses in the iMX families?

Regards
Greg



> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>   config MMC_SDHCI_ESDHC_IMX
>   	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
>   	depends on ARCH_MXC
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..17c3826dfe81 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
>   obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
>   obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
>   obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
> +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
>   obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
>   obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>   obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> @@ -104,3 +105,5 @@ endif
>   
>   obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
>   sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
> +
> +CFLAGS_sdhci-esdhc-mcf.o := -DDEBUG
> 
