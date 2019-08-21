Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C704E9795C
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfHUMas (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 08:30:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:29665 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUMas (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Aug 2019 08:30:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="181015723"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2019 05:30:41 -0700
Subject: Re: [PATCH V5 4/4] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
References: <20190820020739.8396-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <825b02a1-143b-c078-2dbf-26746f1bf160@intel.com>
Date:   Wed, 21 Aug 2019 15:29:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820020739.8396-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/19 5:07 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add support for the GL9750 and GL9755 chipsets.
> 
> The patches enable v4 mode and wait 5ms after set 1.8V signal enable for
> GL9750/GL9755. It fixed the value of SDHCI_MAX_CURRENT register and uses
> the vendor tuning flow for GL9750.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> ---
>  drivers/mmc/host/Makefile         |   2 +-
>  drivers/mmc/host/sdhci-pci-core.c |   2 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 381 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   5 +
>  4 files changed, 389 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-gli.c
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..661445415090 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> -				   sdhci-pci-dwc-mshc.o
> +				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4154ee11b47d..e5835fbf73bc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1682,6 +1682,8 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>  	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
> +	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
> +	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> new file mode 100644
> index 000000000000..99abb7830e62
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Genesys Logic, Inc.
> + *
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Version: v0.9.0 (2019-08-08)
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +/*  Genesys Logic extra registers */
> +#define SDHCI_GLI_9750_WT         0x800
> +#define SDHCI_GLI_9750_DRIVING    0x860
> +#define SDHCI_GLI_9750_PLL        0x864
> +#define SDHCI_GLI_9750_SW_CTRL    0x874
> +#define SDHCI_GLI_9750_MISC       0x878
> +
> +#define SDHCI_GLI_9750_TUNING_CONTROL		0x540
> +#define SDHCI_GLI_9750_TUNING_PARAMETERS	0x544
> +
> +#define GLI_MAX_TUNING_LOOP 40
> +
> +/* Genesys Logic chipset */
> +static void gli_set_9750(struct sdhci_host *host)
> +{
> +	u32 wt_value = 0;
> +	u32 driving_value = 0;
> +	u32 pll_value = 0;
> +	u32 sw_ctrl_value = 0;
> +	u32 misc_value = 0;
> +	u32 parameter_value = 0;
> +	u32 control_value = 0;
> +
> +	u16 ctrl2 = 0;
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	if ((wt_value & 0x1) == 0) {
> +		wt_value |= 0x1;
> +		sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +	}
> +
> +	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
> +	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +	control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	driving_value &= ~(0x0C000FFF);
> +	driving_value |= 0x0C000FFF;
> +	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
> +
> +	sw_ctrl_value |= 0xc0;
> +	sdhci_writel(host, sw_ctrl_value, SDHCI_GLI_9750_SW_CTRL);
> +
> +	// reset the tuning flow after reinit and before starting tuning

For consistent style, please use C-style comments /* */ rather than //

> +	pll_value |= 0x800000; // bit23-1

Please define bit fields and look at using GENMASK(), BIT(), FIELD_GET(),
FIELD_PREP()

> +	pll_value &= ~(0x00700000); // bit22:20-0
> +
> +	misc_value &= ~(0x8); // bit3-0
> +	misc_value &= ~(0x4); // bit2-0
> +
> +	misc_value &= ~(0x70); // bit6:4-0
> +	misc_value |= 0x50; // bit6:4-5
> +
> +	parameter_value &= ~(0x7); // bit2:0-0
> +	parameter_value |= 0x1; // bit2:0-1
> +
> +	control_value &= ~(0x190000); // bit20:19-0, bit16-0
> +	control_value |=   0x110000; // bit20:19-b10, bit16-1
> +
> +	sdhci_writel(host, pll_value, SDHCI_GLI_9750_PLL);
> +	sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +
> +	// disable tuned clk
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	// 540 enable tuning parameters control
> +	control_value |= 0x10;
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	// write 544 tuning parameters
> +	sdhci_writel(host, parameter_value, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +
> +	// 540 disable tuning parameters control
> +	control_value &= ~0x10;
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	// clear tuned clk
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	udelay(1);
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_value &= ~0x1;
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static void sdhci_gli_do_reset(struct sdhci_host *host, u8 mask)
> +{
> +	host->ops->reset(host, mask);
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> +			if (host->ops->enable_dma)
> +				host->ops->enable_dma(host);
> +		}
> +
> +		/* Resetting the controller clears many */
> +		host->preset_enabled = false;
> +	}
> +}
> +
> +static void sdhci_gli_abort_tuning(struct sdhci_host *host, u32 opcode)

Pleased export sdhci_abort_tuning() instead.

> +{
> +	sdhci_reset_tuning(host);
> +
> +	sdhci_gli_do_reset(host, SDHCI_RESET_CMD);
> +	sdhci_gli_do_reset(host, SDHCI_RESET_DATA);
> +
> +	sdhci_end_tuning(host);
> +
> +	mmc_abort_tuning(host->mmc, opcode);
> +}
> +
> +static void gli_set_9750_rx_inv(struct sdhci_host *host, bool b)
> +{
> +	u32 wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	u32 misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +
> +	if ((wt_value & 0x1) == 0) {
> +		wt_value |= 0x1;
> +		sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +	}
> +
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	if (b) {
> +		misc_value |= 0x8;
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +	} else {
> +		misc_value &= ~0x8;
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +	}
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_value &= ~0x1;
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
> +{
> +	int i;
> +	int rx_inv = 0;
> +
> +	for (rx_inv = 0; rx_inv < 2; rx_inv++) {
> +		if (rx_inv & 0x1)
> +			gli_set_9750_rx_inv(host, true);
> +		else
> +			gli_set_9750_rx_inv(host, false);
> +
> +		sdhci_start_tuning(host);
> +
> +		for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
> +			u16 ctrl;
> +
> +			sdhci_send_tuning(host, opcode);
> +
> +			if (!host->tuning_done) {
> +				if (rx_inv == 1) {
> +					pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +						mmc_hostname(host->mmc));
> +					sdhci_gli_abort_tuning(host, opcode);
> +					return -ETIMEDOUT;
> +				}
> +				pr_info("%s: Tuning timeout, try next tuning\n",
> +					mmc_hostname(host->mmc));
> +				sdhci_gli_abort_tuning(host, opcode);
> +				break;
> +			}
> +
> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +				if (ctrl & SDHCI_CTRL_TUNED_CLK)
> +					return 0; /* Success! */
> +				break;
> +			}
> +		}
> +	}
> +
> +	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +		mmc_hostname(host->mmc));
> +	sdhci_reset_tuning(host);
> +	return -EAGAIN;
> +}
> +
> +static int gl9750_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int err = 0;
> +	unsigned int tuning_count = 0;
> +	bool hs400_tuning;
> +
> +	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
> +
> +	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> +		tuning_count = host->tuning_count;
> +
> +	/*
> +	 * The Host Controller needs tuning in case of SDR104 and DDR50
> +	 * mode, and for SDR50 mode when Use Tuning for SDR50 is set in
> +	 * the Capabilities register.
> +	 * If the Host Controller supports the HS200 mode then the
> +	 * tuning function has to be executed.
> +	 */
> +	switch (host->timing) {
> +	/* HS400 tuning is done in HS200 mode */
> +	case MMC_TIMING_MMC_HS400:
> +		err = -EINVAL;
> +		goto out;
> +
> +	case MMC_TIMING_MMC_HS200:
> +		/*
> +		 * Periodic re-tuning for HS400 is not expected to be needed, so
> +		 * disable it here.
> +		 */
> +		if (hs400_tuning)
> +			tuning_count = 0;
> +		break;
> +
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_UHS_DDR50:
> +		break;
> +	case MMC_TIMING_UHS_SDR50:
> +		if (host->flags & SDHCI_SDR50_NEEDS_TUNING)
> +			break;
> +		/* FALLTHROUGH */
> +
> +	default:
> +		goto out;
> +	}
> +
> +	if (host->ops->platform_execute_tuning) {
> +		err = host->ops->platform_execute_tuning(host, opcode);
> +		goto out;
> +	}
> +
> +	host->mmc->retune_period = tuning_count;
> +
> +	if (host->tuning_delay < 0)
> +		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
> +
> +	gli_set_9750(host);
> +	host->tuning_err = __sdhci_execute_tuning_9750(host, opcode);
> +
> +	sdhci_end_tuning(host);
> +out:
> +	host->flags &= ~SDHCI_HS400_TUNING;
> +
> +	return err;
> +}
> +
> +static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +	struct mmc_host_ops *ops = &host->mmc_host_ops;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	ops->execute_tuning = gl9750_execute_tuning;

It looks like there would be less duplicated code if you implemented
host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning

> +
> +	return 0;
> +}
> +
> +static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
> +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> +{
> +	usleep_range(5000, 5500);
> +}
> +
> +static void sdhci_gli_pci_hw_reset(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +
> +	if (slot->hw_reset)
> +		slot->hw_reset(host);
> +}
> +
> +static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
> +{
> +	ktime_t timeout;
> +
> +	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +
> +	if (mask & SDHCI_RESET_ALL)
> +		host->clock = 0;
> +
> +	/* Wait max 100 ms */
> +	timeout = ktime_add_ms(ktime_get(), 100);
> +
> +	/* hw clears the bit when it's done */
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Reset 0x%x never completed.\n",
> +				mmc_hostname(host->mmc), (int)mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}

Please call sdhci_reset() instead of duplicating the code above.

> +	gli_set_9750(host);
> +}
> +
> +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> +{
> +	u32 value;
> +
> +	value = readl(host->ioaddr + reg);
> +	if (unlikely(reg == SDHCI_MAX_CURRENT)) {
> +		if (!(value & 0xff))
> +			value |= 0xc8;
> +	}
> +	return value;
> +}
> +
> +static const struct sdhci_ops sdhci_gl9755_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.hw_reset		= sdhci_gli_pci_hw_reset,

You never set slot->hw_reset so it doesn't look like .hw_reset is needed

> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9755 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9755,
> +	.ops            = &sdhci_gl9755_ops,
> +};
> +
> +static const struct sdhci_ops sdhci_gl9750_ops = {
> +	.read_l                 = sdhci_gl9750_readl,

You need CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l i.e.

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a108edd..c3bd967d8a1a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
 	select IOSF_MBI if X86
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.

> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_gl9750_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.hw_reset		= sdhci_gli_pci_hw_reset,
> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9750 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9750,
> +	.ops            = &sdhci_gl9750_ops,
> +};
> +
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e5dc6e44c7a4..738ba5afcc20 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -65,6 +65,9 @@
>  
>  #define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
>  
> +#define PCI_DEVICE_ID_GLI_9755		0x9755
> +#define PCI_DEVICE_ID_GLI_9750		0x9750
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -185,5 +188,7 @@ int sdhci_pci_enable_dma(struct sdhci_host *host);
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  extern const struct sdhci_pci_fixes sdhci_snps;
>  extern const struct sdhci_pci_fixes sdhci_o2;
> +extern const struct sdhci_pci_fixes sdhci_gl9750;
> +extern const struct sdhci_pci_fixes sdhci_gl9755;
>  
>  #endif /* __SDHCI_PCI_H */
> 

