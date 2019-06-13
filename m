Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F2443CD
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Jun 2019 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfFMQc1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 13 Jun 2019 12:32:27 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:38356
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfFMIP7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Jun 2019 04:15:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 4D2913FE8D;
        Thu, 13 Jun 2019 10:15:54 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q0WbTytQ45hS; Thu, 13 Jun 2019 10:15:54 +0200 (CEST)
Received: from jerusalem (unknown [95.233.239.237])
        by sysam.it (Postfix) with ESMTPSA id B22A03ED34;
        Thu, 13 Jun 2019 10:15:53 +0200 (CEST)
Date:   Thu, 13 Jun 2019 10:15:52 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: add Coldfire esdhc support
Message-ID: <20190613081552.GA3388@jerusalem>
References: <20190512194125.7091-1-angelo@sysam.it>
 <afc5505e-c0dd-fb93-c29c-167f68bf114c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc5505e-c0dd-fb93-c29c-167f68bf114c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

many thanks for the feedbacks,

On Wed, Jun 12, 2019 at 09:30:46AM +0300, Adrian Hunter wrote:
> On 12/05/19 10:41 PM, Angelo Dureghello wrote:
> > This driver has been developed as a separate module starting
> > from the similar sdhci-esdhc-fls.c.
> 
> Which is not in the mainline kernel?
> 
Sorry, my fsl/imx mistake, it is drivers/mmc/host/sdhci-esdhc-imx.c

> > Separation has been mainly driven from change in endianness.
> > 
> > Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-mcf.c          | 432 ++++++++++++++++++++
> >  include/linux/platform_data/mmc-esdhc-mcf.h |  17 +
> >  2 files changed, 449 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-esdhc-mcf.c
> >  create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> > new file mode 100644
> > index 000000000000..1ba6e0431813
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> > @@ -0,0 +1,432 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Freescale eSDHC ColdFire family controller driver, platform bus.
> > + *
> > + * Copyright (c) 2019 Sysam, Italy
> > + *   Author: Angelo Dureghello <angelo@sysam.it>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_data/mmc-esdhc-mcf.h>
> > +#include <linux/platform_device.h>
> > +#include <asm/m5441xsim.h>
> > +#include "sdhci-pltfm.h"
> > +#include "sdhci-esdhc.h"
> > +
> > +#define	ESDHC_PROCTL_D3CD		0x08
> > +#define ESDHC_PROCTL_AI			0x20
> > +#define ESDHC_PROCTL_DTW_MASK		(0x3 << 1)
> > +#define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
> > +#define ESDHC_DEFAULT_HOST_CONTROL	0x28
> > +
> > +/*
> > + * Freescale eSDHC has DMA ERR omn bit 28, not as std spec says, bit 25.
> 
> omn -> own ?
>
ack, will fix
 
> > + */
> > +#define ESDHC_INT_VENDOR_SPEC_DMA_ERR	(1 << 28)
> > +
> > +struct pltfm_mcf_data {
> > +	struct mcf_esdhc_platform_data plat_data;
> > +	struct clk *clk_ipg;
> > +	struct clk *clk_ahb;
> > +	struct clk *clk_per;
> > +	int aside;
> > +	int current_bus_width;
> > +};
> > +
> > +static inline void esdhc_clrset_be(struct sdhci_host *host,
> > +				   u32 mask, u32 val, int reg)
> > +{
> > +	void __iomem *base = host->ioaddr + (reg & ~3);
> > +	u8 shift = (reg & 3) << 3;
> > +
> > +	mask <<= shift;
> > +	val <<= shift;
> > +
> > +	if (reg == SDHCI_HOST_CONTROL)
> > +		val |= ESDHC_PROCTL_D3CD;
> > +
> > +	writel((readl(base) & ~mask) | val, base);
> > +}
> > +
> > +/*
> > + * Note: mcf is big-endian, single bytes need to be accessed at big endian
> > + * offsets.
> > + */
> > +static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
> > +{
> > +	void __iomem *base = host->ioaddr + (reg & ~3);
> > +	u8 shift = (reg & 3) << 3;
> > +	u32 mask = ~(0xff << shift);
> > +
> > +	switch (reg) {
> > +	case SDHCI_HOST_CONTROL:
> > +		/*
> > +		 * Recomposition needed, restore always endianness and
> > +		 * keep D3CD and AI, just setting bus width.
> > +		 */
> > +		writel(ESDHC_DEFAULT_HOST_CONTROL | (val & 0x6),
> > +		       host->ioaddr + SDHCI_HOST_CONTROL);
> > +		return;
> > +	}
> > +
> > +	writel((readl(base) & mask) | (val << shift), base);
> > +}
> > +
> > +static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +	void __iomem *base = host->ioaddr + (reg & ~3);
> > +	u8 shift = (reg & 3) << 3;
> > +	u32 mask = ~(0xffff << shift);
> > +
> > +	switch (reg) {
> > +	case SDHCI_TRANSFER_MODE:
> > +		mcf_data->aside = val;
> > +		return;
> > +	case SDHCI_COMMAND:
> > +		/*
> > +		 * As for the fsl driver,
> > +		 * we have to set the mode in a single write here.
> > +		 */
> > +		writel(val << 16 | mcf_data->aside,
> > +			       host->ioaddr + SDHCI_TRANSFER_MODE);
> > +		return;
> > +	}
> > +
> > +	writel((readl(base) & mask) | (val << shift), base);
> > +}
> > +
> > +static void esdhc_mcf_writel(struct sdhci_host *host, u32 val, int reg)
> 
> All other accessors have _be suffix except this one?
> 
ack, will fix


> > +{
> > +	u32 data;
> > +
> > +	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE ||
> > +		reg == SDHCI_INT_STATUS)) {
> > +		if (val & SDHCI_INT_CARD_INT) {
> > +			/*
> > +			 * eSDHC issue, errata:
> > +			 * ECF218: Misses SDIO interrupt when CINT is disabled
> > +			 */
> > +			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> > +			data &= ~ESDHC_PROCTL_D3CD;
> > +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> > +			data |= ESDHC_PROCTL_D3CD;
> > +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> > +		}
> > +	}
> > +
> > +	writel(val, host->ioaddr + reg);
> > +}
> > +
> > +static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
> > +{
> > +	u8 __iomem *base = host->ioaddr + (reg & ~3);
> > +
> > +	return base[3 - (reg & 3)];
> 
> Elsewhere readl/writel are used.  Should this use readb() for consistency?
> 

ack, well ok.

> > +}
> > +
> > +static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> > +{
> > +	u16 __iomem *base = host->ioaddr + (reg & ~3);
> > +
> > +	return base[1 - ((reg >> 1) & 1)];
> 
> Ditto.
> 

ack, will fix

> > +}
> > +
> > +static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
> > +{
> > +	u32 val = readl(host->ioaddr + reg);
> > +
> > +	/*
> > +	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> > +	 * So forcing legacy mode at 25Mhz.
> > +	 */
> > +	if (unlikely(reg == SDHCI_CAPABILITIES))
> > +		val &= ~SDHCI_CAN_DO_HISPD;
> > +
> > +	if (unlikely(reg == SDHCI_INT_STATUS)) {
> > +		if (val & ESDHC_INT_VENDOR_SPEC_DMA_ERR) {
> > +			val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
> > +			val |= SDHCI_INT_ADMA_ERROR;
> > +		}
> > +		/*
> > +		 * On some commands, mcf controller gives false data CRC
> > +		 * erros, at least checking the received buffer.
> 
> erros -> errors
> 
ack, will fix

> > +		 * Workaround, clearing CRC error interrupt flag.
> 
> Begs the question, why allow SDHCI_INT_DATA_CRC to be set in the first place?
> 
Ok, will check how to do disable it.

> > +		 */
> > +		if (val & SDHCI_INT_DATA_CRC) {
> > +			val &= ~SDHCI_INT_DATA_CRC;
> > +			writel(SDHCI_INT_DATA_CRC,
> > +			       host->ioaddr + SDHCI_INT_STATUS);
> > +		}
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
> > +{
> > +	return 1 << 27;
> > +}
> > +
> > +static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> > +{
> > +	/* Use maximum timeout counter */
> > +	esdhc_clrset_be(host, ESDHC_SYS_CTRL_DTOCV_MASK, 0xE,
> > +				SDHCI_TIMEOUT_CONTROL);
> > +}
> > +
> > +static void esdhc_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	sdhci_reset(host, mask);
> > +
> > +	host->ier &= ~SDHCI_INT_DATA_CRC;
> 
> Why not just suppress the bit in esdhc_mcf_writel()?
>
ok, thanks
 
> > +
> > +	esdhc_clrset_be(host, ESDHC_CTRL_BUSWIDTH_MASK,
> > +			mcf_data->current_bus_width, SDHCI_HOST_CONTROL);
> > +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +}
> > +
> > +static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +	return pltfm_host->clock;
> > +}
> > +
> > +static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +	return pltfm_host->clock / 256 / 16;
> > +}
> > +
> > +static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
> 
> Callback can't be inline anyway.
> 

ok, will fix

> > +					 unsigned int clock)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	unsigned long *pll_dr = (unsigned long *)MCF_PLL_DR;
> > +	u32 fvco, fsys, fesdhc, temp;
> > +	const int sdclkfs[] = {2, 4, 8, 16, 32, 64, 128, 256};
> > +	int delta, old_delta = clock;
> > +	int i, q, ri, rq;
> > +
> > +	if (clock == 0) {
> > +		host->mmc->actual_clock = 0;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * ColdFire eSDHC clock.s
> > +	 *
> > +	 * pll -+-> / outdiv1 --> fsys
> > +	 *      +-> / outdiv3 --> eSDHC clock ---> / SDCCLKFS / DVS
> > +	 *
> > +	 * mcf5441x datasheet says:
> > +	 * (8.1.2) eSDHC should be 40 MHz max
> > +	 * (25.3.9) eSDHC input is, as example, 96 Mhz ...
> > +	 * (25.3.9) sd pin clock must never exceed 25Mhz
> > +	 *
> > +	 * fvco = fsys * outdvi1 + 1
> > +	 * fshdc = fvco / outdiv3 + 1
> > +	 */
> > +	temp = readl(pll_dr);
> > +	fsys = pltfm_host->clock;
> > +	fvco = fsys * ((temp & 0x1f) + 1);
> > +	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> > +
> > +	for (i = 0; i < 8; ++i) {
> > +		int result = fesdhc / sdclkfs[i];
> 
> Missing a blank line after declarations
> 
ok, i think i forgot checkpatch, sorry.

> > +		for (q = 1; q < 17; ++q) {
> > +			int finale = result / q;
> 
> Missing a blank line after declarations
> 
ok

> > +			delta = abs(clock - finale);
> > +
> > +			if (delta < old_delta) {
> > +				old_delta = delta;
> > +				ri = i;
> > +				rq = q;
> > +			}
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Apply divisors and re-enable all the clocks
> > +	 */
> > +	temp = ((sdclkfs[ri] >> 1) << 8) | ((rq - 1) << 4) |
> > +		(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN);
> > +	esdhc_clrset_be(host, 0x0000fff7, temp, SDHCI_CLOCK_CONTROL);
> > +
> > +	host->mmc->actual_clock = clock;
> > +
> > +	mdelay(1);
> > +}
> > +
> > +static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	switch (width) {
> > +	case MMC_BUS_WIDTH_4:
> > +		mcf_data->current_bus_width = ESDHC_CTRL_4BITBUS;
> > +		break;
> > +	default:
> > +		mcf_data->current_bus_width = 0;
> > +		break;
> > +	}
> > +
> > +	esdhc_clrset_be(host, ESDHC_CTRL_BUSWIDTH_MASK,
> > +			mcf_data->current_bus_width, SDHCI_HOST_CONTROL);
> > +}
> > +
> > +static struct sdhci_ops sdhci_esdhc_ops = {
> > +	.reset = esdhc_reset,
> > +	.set_clock = esdhc_pltfm_set_clock,
> > +	.get_max_clock = esdhc_pltfm_get_max_clock,
> > +	.get_min_clock = esdhc_pltfm_get_min_clock,
> > +	.set_bus_width = esdhc_pltfm_set_bus_width,
> > +	.get_max_timeout_count = esdhc_get_max_timeout_count,
> > +	.set_timeout = esdhc_set_timeout,
> > +	.write_b = esdhc_mcf_writeb_be,
> > +	.write_w = esdhc_mcf_writew_be,
> > +	.write_l = esdhc_mcf_writel,
> > +	.read_b = esdhc_mcf_readb_be,
> > +	.read_w = esdhc_mcf_readw_be,
> > +	.read_l = esdhc_mcf_readl_be,
> > +};
> > +
> > +static const struct sdhci_pltfm_data sdhci_esdhc_mcf_pdata = {
> > +	.ops = &sdhci_esdhc_ops,
> > +	.quirks = ESDHC_DEFAULT_QUIRKS,
> > +	.quirks2 = SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP,
> > +};
> > +
> > +static int sdhci_esdhc_mcf_plat_init(struct sdhci_host *host,
> > +				     struct pltfm_mcf_data *mcf_data)
> > +{
> > +	struct mcf_esdhc_platform_data *plat_data;
> > +
> > +	plat_data = &mcf_data->plat_data;
> > +
> > +	if (!host->mmc->parent->platform_data) {
> > +		dev_err(mmc_dev(host->mmc), "no platform data!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mcf_data->plat_data = *((struct mcf_esdhc_platform_data *)
> > +			host->mmc->parent->platform_data);
> 
> plat_data is never used outside this function, so why make a copy of it?
> 

Probably copied the approach from similar imx driver. Will fix it.

> > +
> > +	/* Card_detect */
> > +	switch (plat_data->cd_type) {
> > +	default:
> > +	case ESDHC_CD_CONTROLLER:
> > +		/* We have a working card_detect back */
> > +		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > +		break;
> > +	case ESDHC_CD_PERMANENT:
> > +		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> > +		break;
> > +	case ESDHC_CD_NONE:
> > +		break;
> > +	}
> > +
> > +	switch (plat_data->max_bus_width) {
> > +	case 4:
> > +		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> > +		break;
> > +	case 1:
> > +	default:
> > +		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host;
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct pltfm_mcf_data *mcf_data;
> > +	int err;
> > +
> > +	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_mcf_pdata,
> > +				sizeof(*mcf_data));
> > +
> > +	if (IS_ERR(host))
> > +		return PTR_ERR(host);
> > +
> > +	pltfm_host = sdhci_priv(host);
> > +	mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	mcf_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > +	if (IS_ERR(mcf_data->clk_ipg))
> > +		return PTR_ERR(mcf_data->clk_ipg);
> 
> Need to call sdhci_pltfm_free() on the error paths to pair with
> sdhci_pltfm_init().
> 
Ok, thanks,

> > +
> > +	mcf_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> > +	if (IS_ERR(mcf_data->clk_ahb))
> > +		return PTR_ERR(mcf_data->clk_ahb);
> > +
> > +	mcf_data->clk_per = devm_clk_get(&pdev->dev, "per");
> > +	if (IS_ERR(mcf_data->clk_per))
> > +		return PTR_ERR(mcf_data->clk_per);
> > +
> > +	pltfm_host->clk = mcf_data->clk_per;
> > +	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
> > +	err = clk_prepare_enable(mcf_data->clk_per);
> > +	if (err)
> > +		return err;
> > +	err = clk_prepare_enable(mcf_data->clk_ipg);
> > +	if (err) {
> > +		clk_disable_unprepare(mcf_data->clk_per);
> > +		return err;
> > +	}
> > +	err = clk_prepare_enable(mcf_data->clk_ahb);
> > +	if (err) {
> > +		clk_disable_unprepare(mcf_data->clk_per);
> > +		clk_disable_unprepare(mcf_data->clk_ipg);
> > +		return err;
> > +	}
> > +
> > +	err = sdhci_esdhc_mcf_plat_init(host, mcf_data);
> > +	if (err)
> > +		return err;
> > +
> > +	err = sdhci_add_host(host);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host = platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> 
> Missing:
> 	sdhci_remove_host(host, 0);
> 
> 
Thanks, forgot it.

> > +	clk_disable_unprepare(mcf_data->clk_ipg);
> > +	clk_disable_unprepare(mcf_data->clk_ahb);
> > +	clk_disable_unprepare(mcf_data->clk_per);
> 
> Missing:
> 	sdhci_pltfm_free(pdev);

Thanks, forgot it.
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver sdhci_esdhc_mcf_driver = {
> > +	.driver	= {
> > +		.name = "sdhci-esdhc-mcf",
> > +	},
> > +	.probe = sdhci_esdhc_mcf_probe,
> > +	.remove = sdhci_esdhc_mcf_remove,
> > +};
> > +
> > +module_platform_driver(sdhci_esdhc_mcf_driver);
> > +
> > +MODULE_DESCRIPTION("SDHCI driver for Freescale ColdFire eSDHC");
> > +MODULE_AUTHOR("Angelo Dureghello <angelo@sysam.it>");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
> > new file mode 100644
> > index 000000000000..85cb786a62fe
> > --- /dev/null
> > +++ b/include/linux/platform_data/mmc-esdhc-mcf.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> > +#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> > +
> > +enum cd_types {
> > +	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
> > +	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
> > +	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
> > +};
> > +
> > +struct mcf_esdhc_platform_data {
> > +	int max_bus_width;
> > +	int cd_type;
> > +};
> > +
> > +#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
> > 
> 

Many thanks, will fix all in the weekend, v2 coming.

Regards,
Angelo Dureghello
