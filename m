Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE42109E5E
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfKZMz1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 07:55:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:24526 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfKZMz1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 07:55:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 04:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217156697"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 04:55:24 -0800
Subject: Re: [PATCH 07/14] mmc: sdhci-esdhc-imx: restore the per_clk rate in
 PM_RUNTIME
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
 <1573816361-26535-4-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bab2dcc2-9eae-c76c-3a7b-afd0fcd986f8@intel.com>
Date:   Tue, 26 Nov 2019 14:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816361-26535-4-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/19 1:12 PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> When pm_runtime_suspend is run, a call to SCFW power off the SS (SS is a
> power domain, usdhc belong to this SS power domain) in which the resource
> resides is made. The SCFW can power off the SS if no other resource in
> active in that SS. If so, all state associated with all the resources within
> the SS that is powered off is lost, this includes the clock rates, clock state
> etc. When pm_runtime_resume is called, the SS associated with that resource
> is powered up. But the clocks are left in the default state.
> 
> This patch restore clock rate in pm_runtime_resume, make sure the
> clock is right rather than depending on the default state setting
> by SCFW.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2c8a78218c8e..448b29b2da62 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -162,6 +162,8 @@
>  #define ESDHC_FLAG_PMQOS		BIT(13)
>  /* The IP state got lost in low power mode */
>  #define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
> +/* The IP lost clock rate in PM_RUNTIME */
> +#define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> @@ -225,7 +227,8 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_CQHCI
> -			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> +			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
>  };
>  
>  struct pltfm_imx_data {
> @@ -1711,6 +1714,9 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  		pm_qos_add_request(&imx_data->pm_qos_req,
>  			PM_QOS_CPU_DMA_LATENCY, 0);
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME)
> +		clk_set_rate(imx_data->clk_per, pltfm_host->clock);
> +
>  	err = clk_prepare_enable(imx_data->clk_ahb);
>  	if (err)
>  		goto remove_pm_qos_request;
> 

