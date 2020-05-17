Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9781D6803
	for <lists+linux-mmc@lfdr.de>; Sun, 17 May 2020 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEQM6B (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 17 May 2020 08:58:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:3598 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQM6B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 17 May 2020 08:58:01 -0400
IronPort-SDR: ppRho+OKgccOrxInLYAR9/emLKik7dmlPtnrbhhxhBhVRGkjuycjwWY34U2CUYlwY1I/PROPBP
 /OPVANB2pZOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 05:57:52 -0700
IronPort-SDR: Hh+8uW/Xtg1qIc8VxBUfgZuttHkGbq2gVU78iYZSt0kv6ZvyqhbatEdOW9zbROwIa1iked29Eo
 HgUxHSRTa7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263685094"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 05:57:49 -0700
Subject: Re: [PATCH 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, SoC Team <soc@kernel.org>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20200513133122.25121-1-lars.povlsen@microchip.com>
 <20200513133122.25121-3-lars.povlsen@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6398c7a6-ce5e-1df6-d5a6-08664a7fc123@intel.com>
Date:   Sun, 17 May 2020 15:58:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133122.25121-3-lars.povlsen@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/05/20 4:31 pm, Lars Povlsen wrote:
> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
> designware IP, but requires some extra initialization and quirks.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/mmc/host/Kconfig           |  13 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-sparx5.c | 348 +++++++++++++++++++++++++++++
>  3 files changed, 362 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 462b5352fea75..1e8396d09df75 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -213,6 +213,19 @@ config MMC_SDHCI_OF_DWCMSHC
>  	  If you have a controller with this interface, say Y or M here.
>  	  If unsure, say N.
> 
> +config MMC_SDHCI_OF_SPARX5
> +	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on ARCH_SPARX5
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found in the MCHP Sparx5 SoC.
> +
> +	  If you have a Sparx5 SoC with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
>  	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index b929ef9412083..9f09b7ffaaa16 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
> +obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> new file mode 100644
> index 0000000000000..8253bf80e175a
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * drivers/mmc/host/sdhci-of-sparx5.c
> + *
> + * MCHP Sparx5 SoC Secure Digital Host Controller Interface.
> + *
> + * Copyright (c) 2019 Microchip Inc.
> + *
> + * Author: Lars Povlsen <lars.povlsen@microchip.com>
> + */
> +
> +//#define DEBUG
> +//#define TRACE_REGISTER

No commented out code please.

> +
> +#include <linux/sizes.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +#define CPU_REGS_GENERAL_CTRL	(0x22 * 4)
> +#define  MSHC_DLY_CC_MASK	GENMASK(16, 13)
> +#define  MSHC_DLY_CC_SHIFT	13
> +#define  MSHC_DLY_CC_MAX	15
> +
> +#define CPU_REGS_PROC_CTRL	(0x2C * 4)
> +#define  ACP_CACHE_FORCE_ENA	BIT(4)
> +#define  ACP_AWCACHE		BIT(3)
> +#define  ACP_ARCACHE		BIT(2)
> +#define  ACP_CACHE_MASK		(ACP_CACHE_FORCE_ENA|ACP_AWCACHE|ACP_ARCACHE)
> +
> +#define MSHC2_VERSION			0x500	/* Off 0x140, reg 0x0 */
> +#define MSHC2_TYPE			0x504	/* Off 0x140, reg 0x1 */
> +#define MSHC2_EMMC_CTRL			0x52c	/* Off 0x140, reg 0xB */
> +#define  MSHC2_EMMC_CTRL_EMMC_RST_N	BIT(2)
> +#define  MSHC2_EMMC_CTRL_IS_EMMC	BIT(0)
> +
> +struct sdhci_sparx5_data {
> +	struct sdhci_host *host;
> +	struct regmap *cpu_ctrl;
> +	int delay_clock;
> +	struct device_attribute dev_delay_clock;
> +};
> +
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> +
> +#if defined(TRACE_REGISTER)

If you want this then add a Kconfig entry for it

> +static void sdhci_sparx5_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	pr_debug("$$$ writel(0x%08x, 0x%02x)\n", val, reg);
> +	writel(val, host->ioaddr + reg);
> +}
> +
> +static void sdhci_sparx5_writew(struct sdhci_host *host, u16 val, int reg)
> +{
> +	pr_debug("$$$ writew(0x%04x, 0x%02x)\n", val, reg);
> +	writew(val, host->ioaddr + reg);
> +}
> +
> +static void sdhci_sparx5_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	pr_debug("$$$ writeb(0x%02x, 0x%02x)\n", val, reg);
> +	writeb(val, host->ioaddr + reg);
> +}
> +#endif
> +
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +static void sdhci_sparx5_adma_write_desc(struct sdhci_host *host, void **desc,
> +					  dma_addr_t addr, int len,
> +					  unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	pr_debug("write_desc: cmd %02x: len %d, offset 0x%0llx\n",
> +		 cmd, len, addr);

Please prefix all kernel messages by either the mmc or device e.g.

	pr_debug("%s: write_desc: cmd %02x: len %d, offset 0x%0llx\n",
		 mmc_hostname(host->mmc), cmd, len, addr);
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +		return;
> +	}
> +
> +	pr_debug("write_desc: splitting dma len %d, offset 0x%0llx\n",
> +		 len, addr);
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +}
> +
> +static void sparx5_set_cacheable(struct sdhci_host *host, u32 value)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> +
> +	pr_debug("%s: Set Cacheable = 0x%x\n", mmc_hostname(host->mmc), value);
> +
> +	/* Update ACP caching attributes in HW */
> +	regmap_update_bits(sdhci_sparx5->cpu_ctrl,
> +			   CPU_REGS_PROC_CTRL, ACP_CACHE_MASK, value);
> +}
> +
> +static void sparx5_set_delay(struct sdhci_host *host, u8 value)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> +
> +	pr_debug("%s: Set DLY_CC = %u\n", mmc_hostname(host->mmc), value);
> +
> +	/* Update DLY_CC in HW */
> +	regmap_update_bits(sdhci_sparx5->cpu_ctrl,
> +			   CPU_REGS_GENERAL_CTRL,
> +			   MSHC_DLY_CC_MASK,
> +			   (value << MSHC_DLY_CC_SHIFT));
> +}
> +
> +static void sdhci_sparx5_set_emmc(struct sdhci_host *host)
> +{
> +	if (!mmc_card_is_removable(host->mmc)) {
> +		u8 value;
> +
> +		value = sdhci_readb(host, MSHC2_EMMC_CTRL);
> +		if (!(value & MSHC2_EMMC_CTRL_IS_EMMC)) {
> +			pr_debug("Get EMMC_CTRL: 0x%08x\n", value);
> +			value |= MSHC2_EMMC_CTRL_IS_EMMC;
> +			pr_debug("Set EMMC_CTRL: 0x%08x\n", value);
> +			sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
> +		}
> +	}
> +}
> +
> +static void sdhci_sparx5_reset_emmc(struct sdhci_host *host)
> +{
> +	u8 value;
> +
> +	pr_debug("Toggle EMMC_CTRL.EMMC_RST_N\n");
> +	value = sdhci_readb(host, MSHC2_EMMC_CTRL) &
> +		~MSHC2_EMMC_CTRL_EMMC_RST_N;
> +	sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
> +	/* For eMMC, minimum is 1us but give it 10us for good measure */
> +	udelay(10);
> +	sdhci_writeb(host, value | MSHC2_EMMC_CTRL_EMMC_RST_N,
> +		     MSHC2_EMMC_CTRL);
> +	/* For eMMC, minimum is 200us but give it 300us for good measure */
> +	udelay(300);

usleep_range() is better here

> +}
> +
> +static void sdhci_sparx5_reset(struct sdhci_host *host, u8 mask)
> +{
> +	pr_debug("*** RESET: mask %d\n", mask);
> +
> +	sdhci_reset(host, mask);
> +
> +	/* Be sure CARD_IS_EMMC stays set */
> +	sdhci_sparx5_set_emmc(host);
> +}
> +
> +static const struct sdhci_ops sdhci_sparx5_ops = {
> +#if defined(TRACE_REGISTER)
> +	.write_l		= sdhci_sparx5_writel,
> +	.write_w		= sdhci_sparx5_writew,
> +	.write_b		= sdhci_sparx5_writeb,
> +#endif
> +	.set_clock		= sdhci_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.reset			= sdhci_sparx5_reset,
> +	.adma_write_desc	= sdhci_sparx5_adma_write_desc,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
> +	.quirks  = 0,
> +	.quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Card quirk */

If this is a card quirk then it should be in drivers/mmc/core/quirks.h not here.

> +		   SDHCI_QUIRK2_NO_1_8_V, /* No sdr104, ddr50, etc */
> +	.ops = &sdhci_sparx5_ops,
> +};
> +
> +static ssize_t sparx5_delay_clock_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct sdhci_sparx5_data *sdhci_sparx5;
> +
> +	sdhci_sparx5 = container_of(attr, struct sdhci_sparx5_data,
> +				     dev_delay_clock);
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", sdhci_sparx5->delay_clock);
> +}
> +
> +static ssize_t sparx5_delay_clock_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	unsigned int delay_clock;
> +	struct sdhci_sparx5_data *sdhci_sparx5;
> +
> +	sdhci_sparx5 = container_of(attr, struct sdhci_sparx5_data,
> +				     dev_delay_clock);
> +
> +	if (kstrtoint(buf, 10, &delay_clock) ||
> +	    delay_clock > MSHC_DLY_CC_MAX) {
> +		dev_err(dev, "sdhci-of-sparx5: wrong parameter format.\n");
> +		return -EINVAL;
> +	}
> +
> +	sdhci_sparx5->delay_clock = delay_clock;
> +	sparx5_set_delay(sdhci_sparx5->host, sdhci_sparx5->delay_clock);
> +
> +	return strlen(buf);
> +}
> +
> +int sdhci_sparx5_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	const char *syscon = "microchip,sparx5-cpu-syscon";
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_sparx5_data *sdhci_sparx5;
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 value;
> +	u32 extra;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_sparx5_pdata,
> +				sizeof(*sdhci_sparx5));
> +
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/*
> +	 * extra adma table cnt for cross 128M boundary handling.
> +	 */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_cnt += extra;
> +
> +	pltfm_host = sdhci_priv(host);
> +	sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
> +	sdhci_sparx5->host = host;
> +
> +	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(pltfm_host->clk)) {
> +		ret = PTR_ERR(pltfm_host->clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
> +		goto free_pltfm;
> +	}
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret)
> +		goto free_pltfm;
> +
> +	if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
> +	    value <= MSHC_DLY_CC_MAX)
> +		sdhci_sparx5->delay_clock = value;
> +	else
> +		sdhci_sparx5->delay_clock = -1; /* Autotune */
> +
> +	/* Sysfs delay_clock interface */
> +	sdhci_sparx5->dev_delay_clock.show = sparx5_delay_clock_show;
> +	sdhci_sparx5->dev_delay_clock.store = sparx5_delay_clock_store;
> +	sysfs_attr_init(&sdhci_sparx5->dev_delay_clock.attr);
> +	sdhci_sparx5->dev_delay_clock.attr.name = "delay_clock";
> +	sdhci_sparx5->dev_delay_clock.attr.mode = 0644;
> +	ret = device_create_file(&pdev->dev, &sdhci_sparx5->dev_delay_clock);

Why is this needed?  It seems doubtful that user space knows what value to
put here if neither the board information nor the driver have that information.

> +	if (ret)
> +		dev_err(&pdev->dev, "failure creating '%s' device file",
> +			sdhci_sparx5->dev_delay_clock.attr.name);
> +
> +	sdhci_get_of_property(pdev);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_clk;
> +
> +	sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
> +	if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
> +		dev_err(&pdev->dev, "No CPU syscon regmap !\n");
> +		ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
> +		goto err_clk;
> +	}
> +
> +	if (sdhci_sparx5->delay_clock >= 0)
> +		sparx5_set_delay(host, sdhci_sparx5->delay_clock);
> +
> +	if (!mmc_card_is_removable(host->mmc)) {
> +		/* Do a HW reset of eMMC card */
> +		sdhci_sparx5_reset_emmc(host);
> +		/* Update EMMC_CTRL */
> +		sdhci_sparx5_set_emmc(host);
> +		/* If eMMC, disable SD and SDIO */
> +		host->mmc->caps2 |= (MMC_CAP2_NO_SDIO|MMC_CAP2_NO_SD);
> +	}
> +
> +	/* Enable v4 mode */
> +	//sdhci_enable_v4_mode(host);

No commented out code please.

> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		dev_err(&pdev->dev, "sdhci_add_host() failed (%d)\n", ret);
> +
> +	/* Set AXI bus master to use un-cached access (for DMA) */
> +	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
> +	    IS_ENABLED(CONFIG_DMA_DECLARE_COHERENT))
> +		sparx5_set_cacheable(host, ACP_CACHE_FORCE_ENA);
> +
> +	pr_debug("SDHC version: 0x%08x\n", sdhci_readl(host, MSHC2_VERSION));
> +	pr_debug("SDHC type:    0x%08x\n", sdhci_readl(host, MSHC2_TYPE));
> +
> +	return ret;
> +
> +err_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +free_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static const struct of_device_id sdhci_sparx5_of_match[] = {
> +	{ .compatible = "microchip,dw-sparx5-sdhci" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
> +
> +static struct platform_driver sdhci_sparx5_driver = {
> +	.driver = {
> +		.name = "sdhci-sparx5",
> +		.of_match_table = sdhci_sparx5_of_match,
> +		.pm = &sdhci_pltfm_pmops,
> +	},
> +	.probe = sdhci_sparx5_probe,
> +	.remove = sdhci_pltfm_unregister,
> +};
> +
> +module_platform_driver(sdhci_sparx5_driver);
> +
> +MODULE_DESCRIPTION("Sparx5 SDHCI OF driver");
> +MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.26.2
> 

