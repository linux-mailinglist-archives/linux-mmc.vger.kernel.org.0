Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF433074
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFCNDP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 09:03:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:50872 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfFCNDO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Jun 2019 09:03:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 06:03:14 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2019 06:03:09 -0700
Subject: Re: [PATCH 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
Date:   Mon, 3 Jun 2019 16:01:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/05/19 1:12 PM, Baolin Wang wrote:
> Set the PHY DLL delay for each timing mode, which is used to sample the clock
> accurately and make the clock more stable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

One comment, nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index e6eda13..911a09b 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -29,6 +29,8 @@
>  #define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
>  #define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
>  
> +#define SDHCI_SPRD_REG_32_DLL_DLY	0x204
> +
>  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
>  #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
>  #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
> @@ -72,6 +74,24 @@ struct sdhci_sprd_host {
>  	struct clk *clk_2x_enable;
>  	u32 base_rate;
>  	int flags; /* backup of host attribute */
> +	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> +};
> +
> +struct sdhci_sprd_phy_cfg {
> +	const char *property;
> +	u8 timing;
> +};
> +
> +static const struct sdhci_sprd_phy_cfg sdhci_sprd_phy_cfgs[] = {
> +	{ "sprd,phy-delay-legacy", MMC_TIMING_LEGACY, },
> +	{ "sprd,phy-delay-sd-highspeed", MMC_TIMING_MMC_HS, },

Did you mean MMC_TIMING_SD_HS

> +	{ "sprd,phy-delay-sd-uhs-sdr50", MMC_TIMING_UHS_SDR50, },
> +	{ "sprd,phy-delay-sd-uhs-sdr104", MMC_TIMING_UHS_SDR104, },
> +	{ "sprd,phy-delay-mmc-highspeed", MMC_TIMING_MMC_HS, },
> +	{ "sprd,phy-delay-mmc-ddr52", MMC_TIMING_MMC_DDR52, },
> +	{ "sprd,phy-delay-mmc-hs200", MMC_TIMING_MMC_HS200, },
> +	{ "sprd,phy-delay-mmc-hs400", MMC_TIMING_MMC_HS400, },
> +	{ "sprd,phy-delay-mmc-hs400es", MMC_TIMING_MMC_HS400 + 1, },
>  };
>  
>  #define TO_SPRD_HOST(host) sdhci_pltfm_priv(sdhci_priv(host))
> @@ -276,6 +296,9 @@ static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
>  static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
>  					 unsigned int timing)
>  {
> +	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +	struct mmc_host *mmc = host->mmc;
> +	u32 *p = sprd_host->phy_delay;
>  	u16 ctrl_2;
>  
>  	if (timing == host->timing)
> @@ -314,6 +337,9 @@ static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
>  	}
>  
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +	if (!mmc->ios.enhanced_strobe)
> +		sdhci_writel(host, p[timing], SDHCI_SPRD_REG_32_DLL_DLY);
>  }
>  
>  static void sdhci_sprd_hw_reset(struct sdhci_host *host)
> @@ -381,6 +407,8 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +	u32 *p = sprd_host->phy_delay;
>  	u16 ctrl_2;
>  
>  	if (!ios->enhanced_strobe)
> @@ -395,6 +423,28 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  
>  	sdhci_sprd_sd_clk_on(host);
> +
> +	/* Set the PHY DLL delay value for HS400 enhanced strobe mode */
> +	sdhci_writel(host, p[MMC_TIMING_MMC_HS400 + 1],
> +		     SDHCI_SPRD_REG_32_DLL_DLY);
> +}
> +
> +static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
> +				       struct device_node *np)
> +{
> +	u32 *p = sprd_host->phy_delay;
> +	int ret, i, index;
> +	u32 val[4];
> +
> +	for (i = 0; i < ARRAY_SIZE(sdhci_sprd_phy_cfgs); i++) {
> +		ret = of_property_read_u32_array(np,
> +				sdhci_sprd_phy_cfgs[i].property, val, 4);
> +		if (ret)
> +			continue;
> +
> +		index = sdhci_sprd_phy_cfgs[i].timing;
> +		p[index] = val[0] | (val[1] << 8) | (val[2] << 16) | (val[3] << 24);
> +	}
>  }
>  
>  static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
> @@ -428,6 +478,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  		goto pltfm_free;
>  
>  	sprd_host = TO_SPRD_HOST(host);
> +	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
>  
>  	clk = devm_clk_get(&pdev->dev, "sdio");
>  	if (IS_ERR(clk)) {
> 

