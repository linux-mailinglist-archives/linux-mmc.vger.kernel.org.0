Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55A4242B
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438267AbfFLLgz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 07:36:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:46878 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438269AbfFLLgz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 07:36:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 04:36:53 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 04:36:50 -0700
Subject: Re: [PATCH] enable acpi support in esdhc driver
To:     Udit Kumar <udit.kumar@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Jimmy Zhao <jimmy.zhao@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
References: <1559538333-362-1-git-send-email-udit.kumar@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <95e552d9-2fe7-e153-60dc-cc77aac3452e@intel.com>
Date:   Wed, 12 Jun 2019 14:35:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559538333-362-1-git-send-email-udit.kumar@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/06/19 8:05 AM, Udit Kumar wrote:
> This pacth enables acpi support in esdhc driver

pacth -> patch

> 
> Signed-off-by: Udit Kumar <udit.kumar@nxp.com>

Looks ok, but some minor comments.

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 55 +++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index e20c00f..11d9f48 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2007, 2010, 2012 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
> + * Copyright 2019 NXP
>   *
>   * Authors: Xiaobo Xie <X.Xie@freescale.com>
>   *	    Anton Vorontsov <avorontsov@ru.mvista.com>
> @@ -13,6 +14,7 @@
>   * your option) any later version.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -75,6 +77,12 @@ struct esdhc_clk_fixup {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_esdhc_of_match);
>  
> +static const struct acpi_device_id sdhci_esdhc_ids[] = {
> +	{"NXP0003" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(acpi, sdhci_esdhc_ids);
> +
>  struct sdhci_esdhc {
>  	u8 vendor_ver;
>  	u8 spec_ver;
> @@ -1038,22 +1046,28 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  	match = of_match_node(sdhci_esdhc_of_match, pdev->dev.of_node);
>  	if (match)
>  		esdhc->clk_fixup = match->data;
> -	np = pdev->dev.of_node;
> -	clk = of_clk_get(np, 0);
> -	if (!IS_ERR(clk)) {
> -		/*
> -		 * esdhc->peripheral_clock would be assigned with a value
> -		 * which is eSDHC base clock when use periperal clock.
> -		 * For ls1046a, the clock value got by common clk API is
> -		 * peripheral clock while the eSDHC base clock is 1/2
> -		 * peripheral clock.
> -		 */
> -		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
> -			esdhc->peripheral_clock = clk_get_rate(clk) / 2;
> -		else
> -			esdhc->peripheral_clock = clk_get_rate(clk);
>  
> -		clk_put(clk);
> +	np = pdev->dev.of_node;
> +	// in case of device tree, get clock frame work

I prefer to remain consistent with the legacy comment style i.e.

	/* In case of device tree, get clock frame work */

> +	if (np) {
> +		clk = of_clk_get(np, 0);
> +		if (!IS_ERR(clk)) {
> +			/*
> +			 * esdhc->peripheral_clock would be assigned a value
> +			 * which is eSDHC base clock when use periperal clock.
> +			 * For ls1046a, the clock value got by common clk API is
> +			 * peripheral clock while the eSDHC base clock is 1/2
> +			 * peripheral clock.
> +			 */
> +			if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
> +				esdhc->peripheral_clock = clk_get_rate(clk) / 2;
> +			else
> +				esdhc->peripheral_clock = clk_get_rate(clk);
> +			clk_put(clk);
> +		}
> +	} else {
> +		device_property_read_u32(&pdev->dev, "clock-frequency",
> +						&esdhc->peripheral_clock);
>  	}

Not sure the "if (np) {}" really serves a purpose since of_clk_get(() will
return an error in that case anyway.

>  
>  	if (esdhc->peripheral_clock) {
> @@ -1062,7 +1076,8 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  		val |= ESDHC_PERIPHERAL_CLK_SEL;
>  		sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
>  		esdhc_clock_enable(host, true);
> -	}
> +	} else
> +		WARN_ON(1);

Please balance braces:

	} else {
		WARN_ON(1);
	}

>  }
>  
>  static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
> @@ -1081,9 +1096,10 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  
>  	np = pdev->dev.of_node;
>  
> -	if (of_property_read_bool(np, "little-endian"))
> +	if (device_property_read_bool(&pdev->dev, "little-endian")) {
>  		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_le_pdata,
>  					sizeof(struct sdhci_esdhc));
> +	}
>  	else

Also here:

	} else {

>  		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_be_pdata,
>  					sizeof(struct sdhci_esdhc));

	}

> @@ -1143,8 +1159,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto err;
> -
> -	mmc_of_parse_voltage(np, &host->ocr_mask);
> +	if (np)

Again not sure the "if (np)" is really needed.

> +		mmc_of_parse_voltage(np, &host->ocr_mask);
>  
>  	ret = sdhci_add_host(host);
>  	if (ret)
> @@ -1160,6 +1176,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	.driver = {
>  		.name = "sdhci-esdhc",
>  		.of_match_table = sdhci_esdhc_of_match,
> +		.acpi_match_table       = sdhci_esdhc_ids,
>  		.pm = &esdhc_of_dev_pm_ops,
>  	},
>  	.probe = sdhci_esdhc_probe,
> 

