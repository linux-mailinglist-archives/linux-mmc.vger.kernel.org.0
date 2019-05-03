Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0912818
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfECGya (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 02:54:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:61164 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfECGya (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 May 2019 02:54:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 23:54:29 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2019 23:54:26 -0700
Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20190429090310.25484-1-haibo.chen@nxp.com>
 <20190429090310.25484-3-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5ceb72f5-3dca-d2b4-5cd1-0d1c1d5db0ef@intel.com>
Date:   Fri, 3 May 2019 09:53:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429090310.25484-3-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/04/19 11:55 AM, BOUGH CHEN wrote:
> On some SoCs such as i.MX7ULP, there is no busfreq
> driver, but cpuidle has some levels which may disable
> system/bus clocks, so need to add pm_qos to prevent
> cpuidle from entering low level idles and make sure
> system/bus clocks are enabled when usdhc is active.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 32 +++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8dbbc1f62b70..053e8586d557 100644
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
> @@ -1659,9 +1682,13 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int err;
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_add_request(&imx_data->pm_qos_req,
> +			PM_QOS_CPU_DMA_LATENCY, 0);
> +
>  	err = clk_prepare_enable(imx_data->clk_ahb);
>  	if (err)
> -		return err;
> +		goto remove_pm_qos_request;
>  
>  	if (!sdhci_sdio_irq_enabled(host)) {
>  		err = clk_prepare_enable(imx_data->clk_per);
> @@ -1690,6 +1717,9 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  		clk_disable_unprepare(imx_data->clk_per);
>  disable_ahb_clk:
>  	clk_disable_unprepare(imx_data->clk_ahb);
> +remove_pm_qos_request:
> +	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> +		pm_qos_remove_request(&imx_data->pm_qos_req);
>  	return err;
>  }
>  #endif
> 

