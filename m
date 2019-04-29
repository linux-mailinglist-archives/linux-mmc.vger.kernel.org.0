Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC4DCBE
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfD2HTf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 03:19:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:57518 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbfD2HTf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 03:19:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 00:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="135244099"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga007.jf.intel.com with ESMTP; 29 Apr 2019 00:19:31 -0700
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20190428082727.3419-1-haibo.chen@nxp.com>
 <20190428082727.3419-2-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <21be463d-38bd-b568-fa9d-7170290cf364@intel.com>
Date:   Mon, 29 Apr 2019 10:18:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428082727.3419-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/04/19 11:19 AM, BOUGH CHEN wrote:
> On some SoCs such as i.MX7ULP, there is no busfreq
> driver, but cpuidle has some levels which may disable
> system/bus clocks, so need to add pm_qos to prevent
> cpuidle from entering low level idles and make sure
> system/bus clocks are enabled when usdhc is active.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8dbbc1f62b70..6a02e8b50dc7 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/pm_qos.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sdio.h>
> @@ -156,6 +157,8 @@
>  #define ESDHC_FLAG_HS400_ES		BIT(11)
>  /* The IP has Host Controller Interface for Command Queuing */
>  #define ESDHC_FLAG_CQHCI		BIT(12)
> +/* need request pmqos during low power */
> +#define ESDHC_FLAG_PMQOS		BIT(13)
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> @@ -204,6 +207,12 @@ static const struct esdhc_soc_data usdhc_imx7d_data = {
>  			| ESDHC_FLAG_HS400,
>  };
>  
> +static struct esdhc_soc_data usdhc_imx7ulp_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_PMQOS,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -229,6 +238,7 @@ struct pltfm_imx_data {
>  		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
>  	} multiblock_status;
>  	u32 is_ddr;
> +	struct pm_qos_request pm_qos_req;
>  };
>  
>  static const struct platform_device_id imx_esdhc_devtype[] = {
> @@ -257,6 +267,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
>  	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
>  	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
> +	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
>  	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
>  	{ /* sentinel */ }
>  };
> @@ -1436,6 +1447,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	imx_data->socdata = of_id ? of_id->data : (struct esdhc_soc_data *)
>  						  pdev->id_entry->driver_data;
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_add_request(&imx_data->pm_qos_req,
> +			PM_QOS_CPU_DMA_LATENCY, 0);
> +
>  	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(imx_data->clk_ipg)) {
>  		err = PTR_ERR(imx_data->clk_ipg);
> @@ -1557,6 +1572,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  disable_per_clk:
>  	clk_disable_unprepare(imx_data->clk_per);
>  free_sdhci:
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_remove_request(&imx_data->pm_qos_req);
>  	sdhci_pltfm_free(pdev);
>  	return err;
>  }
> @@ -1578,6 +1595,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(imx_data->clk_ipg);
>  	clk_disable_unprepare(imx_data->clk_ahb);
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_remove_request(&imx_data->pm_qos_req);
> +
>  	sdhci_pltfm_free(pdev);
>  
>  	return 0;
> @@ -1649,6 +1669,9 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  	}
>  	clk_disable_unprepare(imx_data->clk_ahb);
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_remove_request(&imx_data->pm_qos_req);
> +
>  	return ret;
>  }
>  
> @@ -1659,6 +1682,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int err;
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_add_request(&imx_data->pm_qos_req,
> +			PM_QOS_CPU_DMA_LATENCY, 0);

Shouldn't you then remove the request on the subsequent error paths?

> +
>  	err = clk_prepare_enable(imx_data->clk_ahb);
>  	if (err)
>  		return err;
> 

