Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99C22C3A2
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Jul 2020 12:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGXKs0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 24 Jul 2020 06:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXKsZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 06:48:25 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C773C0619E4
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 03:48:25 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q15so4642553vso.9
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uebbm385n6+GwjfKCAttybMAX/ZVdrPgRRPrW4eng9Q=;
        b=RreIU0B4ux9dinVBJh0XQBZ8R7fEFIqswpGWjHtDORLSosI0HuN6PNkvZ/rQkUMVqu
         cJWhCZ2nsibkjrTHF5dQczFRsw3orB9wxIDionVMDa+uCs40XligEu4t2im8fAMqTMHY
         AYhIJ/S3vblseII2oMqfGXqjhleStzFcD8AGDv/mElSLqE8JcWOCIOm7FbFQHEWOhji+
         b5QEXbKJG0HNHE0i0Y1IRzRArDJ/LYBoINDEwEBlZnjrBW9rEy1ueZ45SdOoLvs76fjZ
         Zxhj7RpAmTI6DEGxYYq4hD5dKPsrkeeJR4mSbnEyxFpUoelC9xv/664/N0a8TQuDxmnK
         gipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uebbm385n6+GwjfKCAttybMAX/ZVdrPgRRPrW4eng9Q=;
        b=HeC3P5QP04bdyNKHEXVwPPbySxfVhvQzwYuulOXpM0Dw/x3tuL6YQIyzhFfm4jBIp/
         MSkZd1Rr8rWP3DH/OyiCJWDF/Xld3jap3K+N1JAbIWLElMZLLheTUiYjLvnLl4fL4EhZ
         Iv+AviZwa12Hz6CMVEJFXMXEhEu7/m/eVslNSI+3fJtvdMLaKax/11FinG/Qk0o0czI9
         R9h6dpyEtsPQ9L6w+Th1URFSJdO3ZVj1P4XDu9SFgjlzIp1MOziGxH15DEkds/8BSOU4
         gH81g9PBe6Bue26nyo3mcfxBLESpXNyLiC08JgCXmjj1Qe48RJYyXmsiqG3dD6zDRNQM
         fjbw==
X-Gm-Message-State: AOAM530h5XfK6F0Fz5AXpEYXpJlF3Gaglc9HlJn2OORKXdXQOZm/6pDT
        lY1eXq25Qjqzq2mCHxgubdXDo+wTIQFG3VBeoXvrNA==
X-Google-Smtp-Source: ABdhPJxotE1QmpB8yamTPriEJ03uykULbrVOXtITTHEXdNwgTxmmI4Lo6naE1nghYPpPbOSHRyw7jaIeRZNUeIH/k64=
X-Received: by 2002:a67:d01a:: with SMTP id r26mr7342652vsi.200.1595587704099;
 Fri, 24 Jul 2020 03:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200618141326.25723-1-lars.povlsen@microchip.com>
 <20200618141326.25723-3-lars.povlsen@microchip.com> <aee90bbf-f0ff-b0cb-b10a-9a2f3bb6acca@intel.com>
 <87wo2vkbns.fsf@soft-dev15.microsemi.net>
In-Reply-To: <87wo2vkbns.fsf@soft-dev15.microsemi.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 12:47:47 +0200
Message-ID: <CAPDyKFpozhFSzWEM6s8cdeG+8JGX00YyFSzeXZxCsY7Efn0aeQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Jul 2020 at 13:54, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
>
> Adrian Hunter writes:
>
> > On 18/06/20 5:13 pm, Lars Povlsen wrote:
> >> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
> >> designware IP, but requires some extra initialization and quirks.
> >>
> >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> Adrian,
>
> Thanks for the ack. I was expecting to see this in linux-next, anything
> holding it back?
>
> pinctrl and hwmon drivers have been merged.
>
> Thanks,

Hi Lars,

Looks like you got some feedback on the DT patch (patch1/3) from Rob.
I didn't find that you have addressed them and therefore I am holding
back on the $subject patch as well.

Please fix the DT patch and re-submit a new version of the series.

Kind regards
Uffe


>
> ---Lars
>
> >> ---
> >>  drivers/mmc/host/Kconfig           |  13 ++
> >>  drivers/mmc/host/Makefile          |   1 +
> >>  drivers/mmc/host/sdhci-of-sparx5.c | 269 +++++++++++++++++++++++++++++
> >>  3 files changed, 283 insertions(+)
> >>  create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 3b706af35ec31..a3bad4b4ed7ea 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -213,6 +213,19 @@ config MMC_SDHCI_OF_DWCMSHC
> >>         If you have a controller with this interface, say Y or M here.
> >>         If unsure, say N.
> >>
> >> +config MMC_SDHCI_OF_SPARX5
> >> +     tristate "SDHCI OF support for the MCHP Sparx5 SoC"
> >> +     depends on MMC_SDHCI_PLTFM
> >> +     depends on ARCH_SPARX5
> >> +     select MMC_SDHCI_IO_ACCESSORS
> >> +     help
> >> +       This selects the Secure Digital Host Controller Interface (SDHCI)
> >> +       found in the MCHP Sparx5 SoC.
> >> +
> >> +       If you have a Sparx5 SoC with this interface, say Y or M here.
> >> +
> >> +       If unsure, say N.
> >> +
> >>  config MMC_SDHCI_CADENCE
> >>       tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
> >>       depends on MMC_SDHCI_PLTFM
> >> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> >> index 4d5bcb0144a0a..451c25fc2c692 100644
> >> --- a/drivers/mmc/host/Makefile
> >> +++ b/drivers/mmc/host/Makefile
> >> @@ -94,6 +94,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)             += sdhci-of-at91.o
> >>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)     += sdhci-of-esdhc.o
> >>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)              += sdhci-of-hlwd.o
> >>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)   += sdhci-of-dwcmshc.o
> >> +obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)    += sdhci-of-sparx5.o
> >>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)     += sdhci-bcm-kona.o
> >>  obj-$(CONFIG_MMC_SDHCI_IPROC)                += sdhci-iproc.o
> >>  obj-$(CONFIG_MMC_SDHCI_MSM)          += sdhci-msm.o
> >> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> >> new file mode 100644
> >> index 0000000000000..2b262c12e5530
> >> --- /dev/null
> >> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> >> @@ -0,0 +1,269 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * drivers/mmc/host/sdhci-of-sparx5.c
> >> + *
> >> + * MCHP Sparx5 SoC Secure Digital Host Controller Interface.
> >> + *
> >> + * Copyright (c) 2019 Microchip Inc.
> >> + *
> >> + * Author: Lars Povlsen <lars.povlsen@microchip.com>
> >> + */
> >> +
> >> +#include <linux/sizes.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/module.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/mfd/syscon.h>
> >> +#include <linux/dma-mapping.h>
> >> +
> >> +#include "sdhci-pltfm.h"
> >> +
> >> +#define CPU_REGS_GENERAL_CTRL        (0x22 * 4)
> >> +#define  MSHC_DLY_CC_MASK    GENMASK(16, 13)
> >> +#define  MSHC_DLY_CC_SHIFT   13
> >> +#define  MSHC_DLY_CC_MAX     15
> >> +
> >> +#define CPU_REGS_PROC_CTRL   (0x2C * 4)
> >> +#define  ACP_CACHE_FORCE_ENA BIT(4)
> >> +#define  ACP_AWCACHE         BIT(3)
> >> +#define  ACP_ARCACHE         BIT(2)
> >> +#define  ACP_CACHE_MASK              (ACP_CACHE_FORCE_ENA|ACP_AWCACHE|ACP_ARCACHE)
> >> +
> >> +#define MSHC2_VERSION                        0x500   /* Off 0x140, reg 0x0 */
> >> +#define MSHC2_TYPE                   0x504   /* Off 0x140, reg 0x1 */
> >> +#define MSHC2_EMMC_CTRL                      0x52c   /* Off 0x140, reg 0xB */
> >> +#define  MSHC2_EMMC_CTRL_EMMC_RST_N  BIT(2)
> >> +#define  MSHC2_EMMC_CTRL_IS_EMMC     BIT(0)
> >> +
> >> +struct sdhci_sparx5_data {
> >> +     struct sdhci_host *host;
> >> +     struct regmap *cpu_ctrl;
> >> +     int delay_clock;
> >> +};
> >> +
> >> +#define BOUNDARY_OK(addr, len) \
> >> +     ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> >> +
> >> +/*
> >> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> >> + * so that each DMA transfer doesn't exceed the boundary.
> >> + */
> >> +static void sdhci_sparx5_adma_write_desc(struct sdhci_host *host, void **desc,
> >> +                                       dma_addr_t addr, int len,
> >> +                                       unsigned int cmd)
> >> +{
> >> +     int tmplen, offset;
> >> +
> >> +     if (likely(!len || BOUNDARY_OK(addr, len))) {
> >> +             sdhci_adma_write_desc(host, desc, addr, len, cmd);
> >> +             return;
> >> +     }
> >> +
> >> +     pr_debug("%s: write_desc: splitting dma len %d, offset 0x%0llx\n",
> >> +              mmc_hostname(host->mmc), len, addr);
> >> +
> >> +     offset = addr & (SZ_128M - 1);
> >> +     tmplen = SZ_128M - offset;
> >> +     sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> >> +
> >> +     addr += tmplen;
> >> +     len -= tmplen;
> >> +     sdhci_adma_write_desc(host, desc, addr, len, cmd);
> >> +}
> >> +
> >> +static void sparx5_set_cacheable(struct sdhci_host *host, u32 value)
> >> +{
> >> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +     struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> >> +
> >> +     pr_debug("%s: Set Cacheable = 0x%x\n", mmc_hostname(host->mmc), value);
> >> +
> >> +     /* Update ACP caching attributes in HW */
> >> +     regmap_update_bits(sdhci_sparx5->cpu_ctrl,
> >> +                        CPU_REGS_PROC_CTRL, ACP_CACHE_MASK, value);
> >> +}
> >> +
> >> +static void sparx5_set_delay(struct sdhci_host *host, u8 value)
> >> +{
> >> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +     struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> >> +
> >> +     pr_debug("%s: Set DLY_CC = %u\n", mmc_hostname(host->mmc), value);
> >> +
> >> +     /* Update DLY_CC in HW */
> >> +     regmap_update_bits(sdhci_sparx5->cpu_ctrl,
> >> +                        CPU_REGS_GENERAL_CTRL,
> >> +                        MSHC_DLY_CC_MASK,
> >> +                        (value << MSHC_DLY_CC_SHIFT));
> >> +}
> >> +
> >> +static void sdhci_sparx5_set_emmc(struct sdhci_host *host)
> >> +{
> >> +     if (!mmc_card_is_removable(host->mmc)) {
> >> +             u8 value;
> >> +
> >> +             value = sdhci_readb(host, MSHC2_EMMC_CTRL);
> >> +             if (!(value & MSHC2_EMMC_CTRL_IS_EMMC)) {
> >> +                     value |= MSHC2_EMMC_CTRL_IS_EMMC;
> >> +                     pr_debug("%s: Set EMMC_CTRL: 0x%08x\n",
> >> +                              mmc_hostname(host->mmc), value);
> >> +                     sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
> >> +             }
> >> +     }
> >> +}
> >> +
> >> +static void sdhci_sparx5_reset_emmc(struct sdhci_host *host)
> >> +{
> >> +     u8 value;
> >> +
> >> +     pr_debug("%s: Toggle EMMC_CTRL.EMMC_RST_N\n", mmc_hostname(host->mmc));
> >> +     value = sdhci_readb(host, MSHC2_EMMC_CTRL) &
> >> +             ~MSHC2_EMMC_CTRL_EMMC_RST_N;
> >> +     sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
> >> +     /* For eMMC, minimum is 1us but give it 10us for good measure */
> >> +     usleep_range(10, 20);
> >> +     sdhci_writeb(host, value | MSHC2_EMMC_CTRL_EMMC_RST_N,
> >> +                  MSHC2_EMMC_CTRL);
> >> +     /* For eMMC, minimum is 200us but give it 300us for good measure */
> >> +     usleep_range(300, 400);
> >> +}
> >> +
> >> +static void sdhci_sparx5_reset(struct sdhci_host *host, u8 mask)
> >> +{
> >> +     pr_debug("%s: *** RESET: mask %d\n", mmc_hostname(host->mmc), mask);
> >> +
> >> +     sdhci_reset(host, mask);
> >> +
> >> +     /* Be sure CARD_IS_EMMC stays set */
> >> +     sdhci_sparx5_set_emmc(host);
> >> +}
> >> +
> >> +static const struct sdhci_ops sdhci_sparx5_ops = {
> >> +     .set_clock              = sdhci_set_clock,
> >> +     .set_bus_width          = sdhci_set_bus_width,
> >> +     .set_uhs_signaling      = sdhci_set_uhs_signaling,
> >> +     .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> >> +     .reset                  = sdhci_sparx5_reset,
> >> +     .adma_write_desc        = sdhci_sparx5_adma_write_desc,
> >> +};
> >> +
> >> +static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
> >> +     .quirks  = 0,
> >> +     .quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Controller issue */
> >> +                SDHCI_QUIRK2_NO_1_8_V, /* No sdr104, ddr50, etc */
> >> +     .ops = &sdhci_sparx5_ops,
> >> +};
> >> +
> >> +int sdhci_sparx5_probe(struct platform_device *pdev)
> >> +{
> >> +     int ret;
> >> +     const char *syscon = "microchip,sparx5-cpu-syscon";
> >> +     struct sdhci_host *host;
> >> +     struct sdhci_pltfm_host *pltfm_host;
> >> +     struct sdhci_sparx5_data *sdhci_sparx5;
> >> +     struct device_node *np = pdev->dev.of_node;
> >> +     u32 value;
> >> +     u32 extra;
> >> +
> >> +     host = sdhci_pltfm_init(pdev, &sdhci_sparx5_pdata,
> >> +                             sizeof(*sdhci_sparx5));
> >> +
> >> +     if (IS_ERR(host))
> >> +             return PTR_ERR(host);
> >> +
> >> +     /*
> >> +      * extra adma table cnt for cross 128M boundary handling.
> >> +      */
> >> +     extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> >> +     if (extra > SDHCI_MAX_SEGS)
> >> +             extra = SDHCI_MAX_SEGS;
> >> +     host->adma_table_cnt += extra;
> >> +
> >> +     pltfm_host = sdhci_priv(host);
> >> +     sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> >> +     sdhci_sparx5->host = host;
> >> +
> >> +     pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> >> +     if (IS_ERR(pltfm_host->clk)) {
> >> +             ret = PTR_ERR(pltfm_host->clk);
> >> +             dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
> >> +             goto free_pltfm;
> >> +     }
> >> +     ret = clk_prepare_enable(pltfm_host->clk);
> >> +     if (ret)
> >> +             goto free_pltfm;
> >> +
> >> +     if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
> >> +         (value > 0 && value <= MSHC_DLY_CC_MAX))
> >> +             sdhci_sparx5->delay_clock = value;
> >> +
> >> +     sdhci_get_of_property(pdev);
> >> +
> >> +     ret = mmc_of_parse(host->mmc);
> >> +     if (ret)
> >> +             goto err_clk;
> >> +
> >> +     sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
> >> +     if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
> >> +             dev_err(&pdev->dev, "No CPU syscon regmap !\n");
> >> +             ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
> >> +             goto err_clk;
> >> +     }
> >> +
> >> +     if (sdhci_sparx5->delay_clock >= 0)
> >> +             sparx5_set_delay(host, sdhci_sparx5->delay_clock);
> >> +
> >> +     if (!mmc_card_is_removable(host->mmc)) {
> >> +             /* Do a HW reset of eMMC card */
> >> +             sdhci_sparx5_reset_emmc(host);
> >> +             /* Update EMMC_CTRL */
> >> +             sdhci_sparx5_set_emmc(host);
> >> +             /* If eMMC, disable SD and SDIO */
> >> +             host->mmc->caps2 |= (MMC_CAP2_NO_SDIO|MMC_CAP2_NO_SD);
> >> +     }
> >> +
> >> +     ret = sdhci_add_host(host);
> >> +     if (ret)
> >> +             goto err_clk;
> >> +
> >> +     /* Set AXI bus master to use un-cached access (for DMA) */
> >> +     if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
> >> +         IS_ENABLED(CONFIG_DMA_DECLARE_COHERENT))
> >> +             sparx5_set_cacheable(host, ACP_CACHE_FORCE_ENA);
> >> +
> >> +     pr_debug("%s: SDHC version: 0x%08x\n",
> >> +              mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_VERSION));
> >> +     pr_debug("%s: SDHC type:    0x%08x\n",
> >> +              mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_TYPE));
> >> +
> >> +     return ret;
> >> +
> >> +err_clk:
> >> +     clk_disable_unprepare(pltfm_host->clk);
> >> +free_pltfm:
> >> +     sdhci_pltfm_free(pdev);
> >> +     return ret;
> >> +}
> >> +
> >> +static const struct of_device_id sdhci_sparx5_of_match[] = {
> >> +     { .compatible = "microchip,dw-sparx5-sdhci" },
> >> +     { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
> >> +
> >> +static struct platform_driver sdhci_sparx5_driver = {
> >> +     .driver = {
> >> +             .name = "sdhci-sparx5",
> >> +             .of_match_table = sdhci_sparx5_of_match,
> >> +             .pm = &sdhci_pltfm_pmops,
> >> +     },
> >> +     .probe = sdhci_sparx5_probe,
> >> +     .remove = sdhci_pltfm_unregister,
> >> +};
> >> +
> >> +module_platform_driver(sdhci_sparx5_driver);
> >> +
> >> +MODULE_DESCRIPTION("Sparx5 SDHCI OF driver");
> >> +MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
> >> +MODULE_LICENSE("GPL v2");
> >>
>
> --
> Lars Povlsen,
> Microchip
