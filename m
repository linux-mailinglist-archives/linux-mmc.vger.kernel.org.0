Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8335980D
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Apr 2021 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhDIIi3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 9 Apr 2021 04:38:29 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:32374 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhDIIi2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2021 04:38:28 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 04:38:28 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-07.nifty.com with ESMTP id 1398PTTi014997
        for <linux-mmc@vger.kernel.org>; Fri, 9 Apr 2021 17:25:29 +0900
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1398Ov2k013849;
        Fri, 9 Apr 2021 17:24:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1398Ov2k013849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617956698;
        bh=wbAmnPZPs2apqnxVLOQBa1KJzajzZF8WbEp2921gVN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blkxIy1fkBFUBAjj8BWYo9VUo+tSAaXDuL2oSHKNHOSxZC8neMkc0thzSyn5fNUui
         dRrZwLloG5qj+wmwv1/oOeUUDUENeT+/19U4+ECxPMYpPOtzFhvaH+wADfrsu8f9cF
         HMTj2z75tD8132unzgqb+dQM/AJNspdt0O4diw56thchgiC9OiF7hgrKjR0aByG1dZ
         V1gwvce5box1Jf9xdRwG9wZYc7SZOsqLjWwzDt6tmlNXe5v6vqEtGTqLPyfeqLlrkR
         wDSUKSe2B3DweoczB5lsLq9hWyVj2ElwzkdGzZSl/s1nuA3P4Wx1wE4MvUaitTwPuC
         9I8SSjS50TqOw==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id 7so2381644plb.7;
        Fri, 09 Apr 2021 01:24:58 -0700 (PDT)
X-Gm-Message-State: AOAM530jIvJtugIMsXja+zGC+FlwueqPKdUbCugOM2i48c9lbd5K4ak4
        vNzPI7E0jNySyDY8gu33nFFh6vcJM20jnwhp1DA=
X-Google-Smtp-Source: ABdhPJz3dg+dqieYJH0A6NMurR0kMcrY3BST9UeYFI7ekUyf2pS95861yTmGVzO8qBPplsHAFPEVOsOOUIJOS+ttdl8=
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id
 a9-20020a170902b589b02900e62875aa4cmr11881664pls.71.1617956697435; Fri, 09
 Apr 2021 01:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-6-brad@pensando.io>
 <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
In-Reply-To: <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Apr 2021 17:24:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYptL=wJ1ofauX41oV+bZRaSq1V5FabMz4eyZBzxDQaw@mail.gmail.com>
Message-ID: <CAK7LNAQYptL=wJ1ofauX41oV+bZRaSq1V5FabMz4eyZBzxDQaw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Brad Larson <brad@pensando.io>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 30, 2021 at 7:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Masahiro Yamada (main author of the driver)
>
> On Mon, 29 Mar 2021 at 03:59, Brad Larson <brad@pensando.io> wrote:
> >
> > Add support for Pensando Elba SoC which explicitly controls
> > byte-lane enables on writes.  Refactor to allow platform
> > specific write ops.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  drivers/mmc/host/Kconfig              |  15 +++
> >  drivers/mmc/host/Makefile             |   1 +
> >  drivers/mmc/host/sdhci-cadence-elba.c | 137 ++++++++++++++++++++++++++
>
> By looking at the amount of code changes that seem to be needed to
> support the Pensando Elba variant, I don't think it's necessary to
> split this into a separate file.
>
> Unless Yamada-san has a different opinion, I would rather just stick
> with using sdhci-cadence.c.


I agree with Ulf.


BTW, this patch cannot probe
"pensando,elba-emmc"
when CONFIG_MMC_SDHCI_CADENCE_ELBA=m.




>
> >  drivers/mmc/host/sdhci-cadence.c      |  81 ++++++++-------
> >  drivers/mmc/host/sdhci-cadence.h      |  68 +++++++++++++
> >  5 files changed, 260 insertions(+), 42 deletions(-)
> >  create mode 100644 drivers/mmc/host/sdhci-cadence-elba.c
> >  create mode 100644 drivers/mmc/host/sdhci-cadence.h
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index b236dfe2e879..65ea323c06f2 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -250,6 +250,21 @@ config MMC_SDHCI_CADENCE
> >
> >           If unsure, say N.
> >
> > +config MMC_SDHCI_CADENCE_ELBA
> > +       tristate "SDHCI support for the Pensando/Cadence SD/SDIO/eMMC controller"
> > +       depends on ARCH_PENSANDO_ELBA_SOC
> > +       depends on MMC_SDHCI
> > +       depends on OF
> > +       depends on MMC_SDHCI_CADENCE
> > +       depends on MMC_SDHCI_PLTFM
> > +       select MMC_SDHCI_IO_ACCESSORS
>
> According to the comment above - then you should probably just extend
> the conditions for when building MMC_SDHCI_CADENCE, rather than having
> to add a new Kconfig for "*_ELBA".
>
> > +       help
> > +         This selects the Pensando/Cadence SD/SDIO/eMMC controller.
> > +
> > +         If you have a controller with this interface, say Y or M here.
> > +
> > +         If unsure, say N.
> > +
> >  config MMC_SDHCI_CNS3XXX
> >         tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
> >         depends on ARCH_CNS3XXX || COMPILE_TEST
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6df5c4774260..f2a6d50e64de 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB) += rtsx_usb_sdmmc.o
> >
> >  obj-$(CONFIG_MMC_SDHCI_PLTFM)          += sdhci-pltfm.o
> >  obj-$(CONFIG_MMC_SDHCI_CADENCE)                += sdhci-cadence.o
> > +obj-$(CONFIG_MMC_SDHCI_CADENCE_ELBA)   += sdhci-cadence-elba.o
> >  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)                += sdhci-cns3xxx.o
> >  obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
> >  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)      += sdhci-esdhc-imx.o
> > diff --git a/drivers/mmc/host/sdhci-cadence-elba.c b/drivers/mmc/host/sdhci-cadence-elba.c
> > new file mode 100644
> > index 000000000000..ec23f43de407
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-cadence-elba.c
> > @@ -0,0 +1,137 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Pensando Systems, Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +
> > +#include "sdhci-pltfm.h"
> > +#include "sdhci-cadence.h"
> > +
> > +// delay regs address
>
> Please don't use "//" when adding comments, but instead "/* ... */".
> This applies to several more places of the patch.
>
> > +#define SDIO_REG_HRS4          0x10

This is the same as SDHCI_CDNS_HRS04



> > +#define REG_DELAY_HS           0x00

This is the same as SDHCI_CDNS_PHY_DLY_SD_HS


> > +#define REG_DELAY_DEFAULT      0x01


This is the same as SDHCI_CDNS_PHY_DLY_SD_DEFAULT



> > +#define REG_DELAY_UHSI_SDR50   0x04

This is the same as SDHCI_CDNS_PHY_DLY_UHS_SDR50



> > +#define REG_DELAY_UHSI_DDR50   0x05


This is the same as SDHCI_CDNS_PHY_DLY_UHS_DDR50



> > +
> > +static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(0x78, priv->ctl_addr);
> > +       writel(val, host->ioaddr + reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > +}
> > +
> > +static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
> > +{
> > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > +       unsigned long flags;
> > +       u32 m = (reg & 0x3);
> > +       u32 msk = (0x3 << (m));
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(msk << 3, priv->ctl_addr);
> > +       writew(val, host->ioaddr + reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > +}
> > +
> > +static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
> > +{
> > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > +       unsigned long flags;
> > +       u32 m = (reg & 0x3);
> > +       u32 msk = (0x1 << (m));
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(msk << 3, priv->ctl_addr);
> > +       writeb(val, host->ioaddr + reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > +}
> > +
> > +static void elba_priv_write_l(struct sdhci_cdns_priv *priv,
> > +               u32 val, void __iomem *reg)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(0x78, priv->ctl_addr);
> > +       writel(val, reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > +}


Maybe, can this avoid code duplication?

static void elba_hrs_write_l(struct sdhci_cdns_priv *priv,
                              u32 val, int reg)
{
        unsigned long flags;

        spin_lock_irqsave(&priv->wrlock, flags);
        writel(0x78, priv->ctl_addr);
        writel(val, priv->hrs_addr + reg);
        spin_unlock_irqrestore(&priv->wrlock, flags);
}

static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
{
        elba_hrs_write_l(sdhci_cdns_priv(host), val, SDHCI_CDNS_SRS_BASE + reg);
}







> > +
> > +static const struct sdhci_ops sdhci_elba_ops = {
> > +       .write_l = elba_write_l,
> > +       .write_w = elba_write_w,
> > +       .write_b = elba_write_b,
> > +       .set_clock = sdhci_set_clock,
> > +       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> > +       .set_bus_width = sdhci_set_bus_width,
> > +       .reset = sdhci_reset,
> > +       .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> > +};
> > +
> > +static void sd4_set_dlyvr(struct sdhci_host *host,
> > +                         unsigned char addr, unsigned char data)
>
> Please, try to think of a better function name that's more
> descriptive. Moreover, please use a common prefix for functions that
> is used on elba.
>
> > +{
> > +       unsigned long dlyrv_reg;
> > +
> > +       dlyrv_reg = ((unsigned long)data << 8);
> > +       dlyrv_reg |= addr;
> > +
> > +       // set data and address
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg |= (1uL << 24uL);
> > +       // send write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg &= ~(1uL << 24);
> > +       // clear write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);


This seems to be equivalent to sdhci_cdns_write_phy_reg().




> > +}
> > +
> > +static void phy_config(struct sdhci_host *host)
>
> Ditto.
>
> > +{
> > +       sd4_set_dlyvr(host, REG_DELAY_DEFAULT, 0x04);
> > +       sd4_set_dlyvr(host, REG_DELAY_HS, 0x04);
> > +       sd4_set_dlyvr(host, REG_DELAY_UHSI_SDR50, 0x06);
> > +       sd4_set_dlyvr(host, REG_DELAY_UHSI_DDR50, 0x16);


Hard-code board (or chip) specific parameters to the driver?

This should go to DT properties.

See Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml





> > +}
> > +
> > +static int elba_drv_init(struct platform_device *pdev)
> > +{
> > +       struct sdhci_host *host = platform_get_drvdata(pdev);
> > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > +       struct resource *iomem;
> > +       void __iomem *ioaddr;
> > +
> > +       host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);
> > +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +       if (!iomem)
> > +               return -ENOMEM;
> > +       ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> > +       if (IS_ERR(ioaddr))
> > +               return PTR_ERR(ioaddr);



Use  devm_platform_ioremap_resource(pdev, 1)







> > +       priv->ctl_addr = ioaddr;
> > +       priv->priv_write_l = elba_priv_write_l;
> > +       spin_lock_init(&priv->wrlock);
> > +       writel(0x78, priv->ctl_addr);
> > +       phy_config(host);
> > +       return 0;
> > +}
> > +
> > +const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
> > +       .init = elba_drv_init,
> > +       .pltfm_data = {
> > +               .ops = &sdhci_elba_ops,
> > +       },
> > +};
> > diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> > index 6f2de54a5987..d1ae996c3824 100644
> > --- a/drivers/mmc/host/sdhci-cadence.c
> > +++ b/drivers/mmc/host/sdhci-cadence.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_device.h>
> >
> >  #include "sdhci-pltfm.h"
> > +#include "sdhci-cadence.h"
> >
> >  /* HRS - Host Register Set (specific to Cadence) */
> >  #define SDHCI_CDNS_HRS04               0x10            /* PHY access port */
> > @@ -59,23 +60,6 @@
> >   */
> >  #define SDHCI_CDNS_MAX_TUNING_LOOP     40
> >
> > -struct sdhci_cdns_phy_param {
> > -       u8 addr;
> > -       u8 data;
> > -};
> > -
> > -struct sdhci_cdns_priv {
> > -       void __iomem *hrs_addr;
> > -       bool enhanced_strobe;
> > -       unsigned int nr_phy_params;
> > -       struct sdhci_cdns_phy_param phy_params[];
> > -};
> > -
> > -struct sdhci_cdns_phy_cfg {
> > -       const char *property;
> > -       u8 addr;
> > -};
> > -
> >  static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> >         { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> >         { "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> > @@ -104,17 +88,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> >
> >         tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
> >               FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
> > -       writel(tmp, reg);
> > +       sdhci_cdns_priv_writel(priv, tmp, reg);
> >
> >         tmp |= SDHCI_CDNS_HRS04_WR;
> > -       writel(tmp, reg);
> > +       sdhci_cdns_priv_writel(priv, tmp, reg);
> >
> >         ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
> >         if (ret)
> >                 return ret;
> >
> >         tmp &= ~SDHCI_CDNS_HRS04_WR;
> > -       writel(tmp, reg);
> > +       sdhci_cdns_priv_writel(priv, tmp, reg);
> >
> >         ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> >                                  0, 10);
> > @@ -167,14 +151,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> >         return 0;
> >  }
> >
> > -static void *sdhci_cdns_priv(struct sdhci_host *host)
> > -{
> > -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -
> > -       return sdhci_pltfm_priv(pltfm_host);
> > -}
> > -
> > -static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
> > +unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
> >  {
> >         /*
> >          * Cadence's spec says the Timeout Clock Frequency is the same as the
> > @@ -191,7 +168,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
> >         tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> >         tmp &= ~SDHCI_CDNS_HRS06_MODE;
> >         tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
> > -       writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> > +       sdhci_cdns_priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> >  }
> >
> >  static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
> > @@ -223,7 +200,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
> >          */
> >         for (i = 0; i < 2; i++) {
> >                 tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> > -               writel(tmp, reg);
> > +               sdhci_cdns_priv_writel(priv, tmp, reg);
> >
> >                 ret = readl_poll_timeout(reg, tmp,
> >                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> > @@ -272,10 +249,13 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
> >                 return -EIO;
> >         }
> >
> > +       dev_info(mmc_dev(host->mmc), "tuning val %d streak end %d max %d\n",
> > +                end_of_streak - max_streak / 2, end_of_streak, max_streak);
> > +
> >         return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> >  }
> >
> > -static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> > +void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> >                                          unsigned int timing)
> >  {
> >         struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > @@ -318,13 +298,17 @@ static const struct sdhci_ops sdhci_cdns_ops = {
> >         .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> >  };
> >
> > -static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> > -       .ops = &sdhci_cdns_ops,
> > -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> > +static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> > +       .pltfm_data = {
> > +               .ops = &sdhci_cdns_ops,
> > +               .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> > +       },
> >  };
> >
> > -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> > -       .ops = &sdhci_cdns_ops,
> > +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> > +       .pltfm_data = {
> > +               .ops = &sdhci_cdns_ops,
> > +       },
> >  };
> >
> >  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> > @@ -350,7 +334,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> >  static int sdhci_cdns_probe(struct platform_device *pdev)
> >  {
> >         struct sdhci_host *host;
> > -       const struct sdhci_pltfm_data *data;
> > +       const struct sdhci_cdns_drv_data *data;
> >         struct sdhci_pltfm_host *pltfm_host;
> >         struct sdhci_cdns_priv *priv;
> >         struct clk *clk;
> > @@ -369,10 +353,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >
> >         data = of_device_get_match_data(dev);
> >         if (!data)
> > -               data = &sdhci_cdns_pltfm_data;
> > +               data = &sdhci_cdns_drv_data;
> >
> >         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> > -       host = sdhci_pltfm_init(pdev, data,
> > +       host = sdhci_pltfm_init(pdev, &data->pltfm_data,
> >                                 struct_size(priv, phy_params, nr_phy_params));
> >         if (IS_ERR(host)) {
> >                 ret = PTR_ERR(host);
> > @@ -389,11 +373,18 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >         host->ioaddr += SDHCI_CDNS_SRS_BASE;
> >         host->mmc_host_ops.hs400_enhanced_strobe =
> >                                 sdhci_cdns_hs400_enhanced_strobe;
> > -       sdhci_enable_v4_mode(host);
> > -       __sdhci_read_caps(host, &version, NULL, NULL);
> >
> >         sdhci_get_of_property(pdev);
> >
> > +       if (data->init) {
> > +               ret = data->init(pdev);
> > +               if (ret)
> > +                       goto free;
> > +       }
> > +
> > +       sdhci_enable_v4_mode(host);
> > +       __sdhci_read_caps(host, &version, NULL, NULL);
> > +
> >         ret = mmc_of_parse(host->mmc);
> >         if (ret)
> >                 goto free;
> > @@ -453,8 +444,14 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> >  static const struct of_device_id sdhci_cdns_match[] = {
> >         {
> >                 .compatible = "socionext,uniphier-sd4hc",
> > -               .data = &sdhci_cdns_uniphier_pltfm_data,
> > +               .data = &sdhci_cdns_uniphier_drv_data,
> >         },
> > +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
>
> No need to hide this minor piece of code behind ifdefs.
>
> > +       {
> > +               .compatible = "pensando,elba-emmc",
> > +               .data = &sdhci_elba_drv_data
> > +       },
> > +#endif
> >         { .compatible = "cdns,sd4hc" },
> >         { /* sentinel */ }
> >  };
> > diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
> > new file mode 100644
> > index 000000000000..bf48e8d13430
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-cadence.h
>
> This new header file can go away too, if you fold in all the code in
> the common c-file.
>
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2016 Socionext Inc.
> > + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > + */
> > +
> > +#ifndef _SDHCI_CADENCE_H_
> > +#define _SDHCI_CADENCE_H_
> > +
> > +struct sdhci_cdns_phy_param {
> > +       u8 addr;
> > +       u8 data;
> > +};
> > +
> > +struct sdhci_cdns_priv {
> > +       void __iomem *hrs_addr;
> > +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
> > +       void __iomem *ctl_addr; /* write control */
> > +       spinlock_t wrlock;      /* write lock */
> > +#endif
> > +       bool enhanced_strobe;
> > +       void (*priv_write_l)(struct sdhci_cdns_priv *priv, u32 val,
> > +                            void __iomem *reg); /* for cadence-elba.c */
> > +       unsigned int nr_phy_params;
> > +       struct sdhci_cdns_phy_param phy_params[];
> > +};
> > +
> > +struct sdhci_cdns_phy_cfg {
> > +       const char *property;
> > +       u8 addr;
> > +};
> > +
> > +struct sdhci_cdns_drv_data {
> > +       int (*init)(struct platform_device *pdev);
> > +       const struct sdhci_pltfm_data pltfm_data;
> > +};
> > +
> > +static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> > +{
> > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +       return sdhci_pltfm_priv(pltfm_host);
> > +}
> > +
> > +/*
> > + * The Pensando Elba SoC explicitly controls byte-lane enables on writes,
> > + * which includes writes to the HRS registers.
> > + * sdhci_cdns_priv_writel() is used in the common sdhci-cadence.c code
> > + * to write HRS registers, and this function dispatches to the specific
> > + * code.
> > + */
> > +static inline void sdhci_cdns_priv_writel(struct sdhci_cdns_priv *priv,
> > +               u32 val, void __iomem *reg)
> > +{
> > +       if (unlikely(priv->priv_write_l))
> > +               priv->priv_write_l(priv, val, reg);
> > +       else
> > +               writel(val, reg);
> > +}
> > +
> > +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
> > +extern const struct sdhci_cdns_drv_data sdhci_elba_drv_data;
> > +#endif
> > +
> > +unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host);
> > +void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host, unsigned int timing);
> > +
> > +#endif
>
> Kind regards
> Uffe



--
Best Regards
Masahiro Yamada
