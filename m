Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1242508
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438610AbfFLMI3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 08:08:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:63739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436551AbfFLMI2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 08:08:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 05:08:27 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 05:08:25 -0700
Subject: Re: [PATCH 2/4] mmc: sdhci_am654: Add Support for 8 bit IP on J721E
To:     Faiz Abbas <faiz_abbas@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, nm@ti.com,
        nsekhar@ti.com
References: <20190604060914.10886-1-faiz_abbas@ti.com>
 <20190604060914.10886-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9d5e0314-e466-62c0-b008-7f2de0ca65a0@intel.com>
Date:   Wed, 12 Jun 2019 15:07:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604060914.10886-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/06/19 9:09 AM, Faiz Abbas wrote:
> The 8 bit IP on the TI's J721E device departs from the AM654x IP in some
> ways which require special handling. Create a driver_data structure
> which holds the pltfm_data and a flags field which is used to indicate
> these differences. These are the following:
> 
> 1. The pins are not muxed with anything else inside the SoC and hence the
>    IOMUX_ENABLE field does not exist. Add a flag which is used to
>    indicate the presence of the field.
> 
> 2. The register field used to select DLL frequency is 3 bit wide as
>    compared to 2 bits in AM65x. Add another flag which differentiates
>    between 3 bit and 2 bit fields.
> 
> 3. The strobe select field is 8 bit wide as compared to 4 bits for
>    AM65x. Add yet another flag to indicate this difference. Strobe select
>    is used only for HS400 speed mode, support for which has not yet been
>    added in AM65x.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 135 +++++++++++++++++++++++++++------
>  1 file changed, 110 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index d0b20780dd0f..4575aeb435ec 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -6,6 +6,7 @@
>   *
>   */
>  #include <linux/clk.h>
> +#include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> @@ -36,11 +37,14 @@
>  #define OTAPDLYSEL_SHIFT	12
>  #define OTAPDLYSEL_MASK		GENMASK(15, 12)
>  #define STRBSEL_SHIFT		24
> -#define STRBSEL_MASK		GENMASK(27, 24)
> +#define STRBSEL_4BIT_MASK	GENMASK(27, 24)
> +#define STRBSEL_8BIT_MASK	GENMASK(31, 24)
>  #define SEL50_SHIFT		8
>  #define SEL50_MASK		BIT(SEL50_SHIFT)
>  #define SEL100_SHIFT		9
>  #define SEL100_MASK		BIT(SEL100_SHIFT)
> +#define FREQSEL_SHIFT		8
> +#define FREQSEL_MASK		GENMASK(10, 8)
>  #define DLL_TRIM_ICP_SHIFT	4
>  #define DLL_TRIM_ICP_MASK	GENMASK(7, 4)
>  #define DR_TY_SHIFT		20
> @@ -77,13 +81,23 @@ struct sdhci_am654_data {
>  	int trm_icp;
>  	int drv_strength;
>  	bool dll_on;
> +	int strb_sel;
> +	u32 flags;
> +};
> +
> +struct sdhci_am654_driver_data {
> +	const struct sdhci_pltfm_data *pdata;
> +	u32 flags;
> +#define IOMUX_PRESENT	(1 << 0)
> +#define FREQSEL_2_BIT	(1 << 1)
> +#define STRBSEL_4_BIT	(1 << 2)
>  };
>  
>  static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -	int sel50, sel100;
> +	int sel50, sel100, freqsel;
>  	u32 mask, val;
>  	int ret;
>  
> @@ -101,24 +115,52 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  		val = (1 << OTAPDLYENA_SHIFT) |
>  		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
>  		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
> -		switch (clock) {
> -		case 200000000:
> -			sel50 = 0;
> -			sel100 = 0;
> -			break;
> -		case 100000000:
> -			sel50 = 0;
> -			sel100 = 1;
> -			break;
> -		default:
> -			sel50 = 1;
> -			sel100 = 0;
> +		/* Write to STRBSEL for HS400 speed mode */
> +		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +			if (sdhci_am654->flags & STRBSEL_4_BIT)
> +				mask = STRBSEL_4BIT_MASK;
> +			else
> +				mask = STRBSEL_8BIT_MASK;
> +
> +			regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask,
> +					   sdhci_am654->strb_sel <<
> +					   STRBSEL_SHIFT);
> +		}
> +
> +		if (sdhci_am654->flags & FREQSEL_2_BIT) {
> +			switch (clock) {
> +			case 200000000:
> +				sel50 = 0;
> +				sel100 = 0;
> +				break;
> +			case 100000000:
> +				sel50 = 0;
> +				sel100 = 1;
> +				break;
> +			default:
> +				sel50 = 1;
> +				sel100 = 0;
> +			}
> +
> +			/* Configure PHY DLL frequency */
> +			mask = SEL50_MASK | SEL100_MASK;
> +			val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> +			regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask,
> +					   val);
> +		} else {
> +			switch (clock) {
> +			case 200000000:
> +				freqsel = 0x0;
> +				break;
> +			default:
> +				freqsel = 0x4;
> +			}
> +
> +			regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
> +					   FREQSEL_MASK,
> +					   freqsel << FREQSEL_SHIFT);
>  		}
>  
> -		/* Configure PHY DLL frequency */
> -		mask = SEL50_MASK | SEL100_MASK;
> -		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
>  		/* Configure DLL TRIM */
>  		mask = DLL_TRIM_ICP_MASK;
>  		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
> @@ -196,6 +238,33 @@ static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
> +	.pdata = &sdhci_am654_pdata,
> +	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT,
> +};
> +
> +struct sdhci_ops sdhci_j721e_8bit_ops = {
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.set_power = sdhci_am654_set_power,
> +	.set_clock = sdhci_am654_set_clock,
> +	.write_b = sdhci_am654_write_b,
> +	.reset = sdhci_reset,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
> +	.ops = &sdhci_j721e_8bit_ops,
> +	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
> +	.pdata = &sdhci_j721e_8bit_pdata,
> +};
> +
>  static int sdhci_am654_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -221,7 +290,9 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	}
>  
>  	/* Enable pins by setting IO mux to 0 */
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, IOMUX_ENABLE_MASK, 0);
> +	if (sdhci_am654->flags & IOMUX_PRESENT)
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
> +				   IOMUX_ENABLE_MASK, 0);
>  
>  	/* Set slot type based on SD or eMMC */
>  	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> @@ -276,15 +347,31 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> +	device_property_read_u32(dev, "ti,strobe-sel", &sdhci_am654->strb_sel);
> +
>  	sdhci_get_of_property(pdev);
>  
>  	return 0;
>  }
>  
> +static const struct of_device_id sdhci_am654_of_match[] = {
> +	{
> +		.compatible = "ti,am654-sdhci-5.1",
> +		.data = &sdhci_am654_drvdata,
> +	},
> +	{
> +		.compatible = "ti,j721e-sdhci-8bit",
> +		.data = &sdhci_j721e_8bit_drvdata,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static int sdhci_am654_probe(struct platform_device *pdev)
>  {
> +	const struct sdhci_am654_driver_data *drvdata;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_am654_data *sdhci_am654;
> +	const struct of_device_id *match;
>  	struct sdhci_host *host;
>  	struct resource *res;
>  	struct clk *clk_xin;
> @@ -292,12 +379,15 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int ret;
>  
> -	host = sdhci_pltfm_init(pdev, &sdhci_am654_pdata, sizeof(*sdhci_am654));
> +	match = of_match_node(sdhci_am654_of_match, pdev->dev.of_node);
> +	drvdata = match->data;
> +	host = sdhci_pltfm_init(pdev, drvdata->pdata, sizeof(*sdhci_am654));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
>  	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	sdhci_am654->flags = drvdata->flags;
>  
>  	clk_xin = devm_clk_get(dev, "clk_xin");
>  	if (IS_ERR(clk_xin)) {
> @@ -372,11 +462,6 @@ static int sdhci_am654_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id sdhci_am654_of_match[] = {
> -	{ .compatible = "ti,am654-sdhci-5.1" },
> -	{ /* sentinel */ }
> -};
> -
>  static struct platform_driver sdhci_am654_driver = {
>  	.driver = {
>  		.name = "sdhci-am654",
> 

