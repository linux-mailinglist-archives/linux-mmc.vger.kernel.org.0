Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7057C1035B8
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKTIAm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 03:00:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:61377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKTIAl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Nov 2019 03:00:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="204747685"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 00:00:39 -0800
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing
 Engine to J721E
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20191118073609.22921-1-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ea458eb9-f9a8-ab39-2df9-6284fef02105@intel.com>
Date:   Wed, 20 Nov 2019 09:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118073609.22921-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/11/19 9:36 AM, Faiz Abbas wrote:
> Add Support for CQHCI (Command Queuing Host Controller Interface)
> for each of the host controllers present in TI's J721E devices.
> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Reported-by: kbuild test robot <lkp@intel.com>

That "Reported-by" should not be there.

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v2: Dropped CONFIG_ prefix from select MMC_CQHCI which led to build
> failures. Successfully built with the .config provided by the kbuild test robot.
> 
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..7c1310ed26c6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
>  	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>  	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index bb90757ecace..b8e897e31e2e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -12,6 +12,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  
> +#include "cqhci.h"
>  #include "sdhci-pltfm.h"
>  
>  /* CTL_CFG Registers */
> @@ -68,6 +69,9 @@
>  
>  #define CLOCK_TOO_SLOW_HZ	400000
>  
> +/* Command Queue Host Controller Interface Base address */
> +#define SDHCI_AM654_CQE_BASE_ADDR 0x200
> +
>  static struct regmap_config sdhci_am654_regmap_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
> @@ -259,6 +263,19 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>  	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>  
> +static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
>  static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -267,6 +284,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  	.set_power = sdhci_am654_set_power,
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
> +	.irq = sdhci_am654_cqhci_irq,
>  	.reset = sdhci_reset,
>  };
>  
> @@ -290,6 +308,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>  	.set_power = sdhci_am654_set_power,
>  	.set_clock = sdhci_j721e_4bit_set_clock,
>  	.write_b = sdhci_am654_write_b,
> +	.irq = sdhci_am654_cqhci_irq,
>  	.reset = sdhci_reset,
>  };
>  
> @@ -304,6 +323,40 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>  	.pdata = &sdhci_j721e_4bit_pdata,
>  	.flags = IOMUX_PRESENT,
>  };
> +
> +static void sdhci_am654_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
> +	.enable		= sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +	.dumpregs	= sdhci_am654_dumpregs,
> +};
> +
> +static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
> +{
> +	struct cqhci_host *cq_host;
> +	int ret;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
> +			       GFP_KERNEL);
> +	if (!cq_host)
> +		return -ENOMEM;
> +
> +	cq_host->mmio = host->ioaddr + SDHCI_AM654_CQE_BASE_ADDR;
> +	cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
> +	cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +	cq_host->ops = &sdhci_am654_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +	ret = cqhci_init(cq_host, host->mmc, 1);
> +
> +	return ret;
> +}
> +
>  static int sdhci_am654_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -344,7 +397,23 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
>  			   ctl_cfg_2);
>  
> -	return sdhci_add_host(host);
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdhci_am654_cqe_add_host(host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
> +	return 0;
> +
> +err_cleanup_host:
> +	sdhci_cleanup_host(host);
> +	return ret;
>  }
>  
>  static int sdhci_am654_get_of_property(struct platform_device *pdev,
> 

