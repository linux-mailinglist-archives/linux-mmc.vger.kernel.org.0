Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD4109E5D
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfKZMyc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 07:54:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:39794 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfKZMyc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 07:54:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 04:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217156528"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 04:54:29 -0800
Subject: Re: [PATCH 06/14] mmc: sdhci-esdhci-imx: retune needed for Mega/Mix
 enabled SoCs
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
 <1573816361-26535-3-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7f3c85d2-4fbc-96cc-0ff8-11b5d2872033@intel.com>
Date:   Tue, 26 Nov 2019 14:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816361-26535-3-git-send-email-haibo.chen@nxp.com>
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
> For Mega/Mix enabled SoCs like MX7D and MX6SX, uSDHC will lost power in
> LP mode no matter whether the MMC_KEEP_POWER flag is set or not.
> This may cause state misalign between kernel and HW, especially for
> SDIO3.0 WiFi cards.
> e.g. SDIO WiFi driver usually will keep power during system suspend.
> And after resume, no card re-enumeration called.
> But the tuning state is lost due to Mega/Mix.
> Then CRC error may happen during next data transfer.
> 
> So we should always fire a mmc_retune_needed() for such type SoC
> to tell MMC core retuning is needed for next data transfer.
> mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index bc743f82d8c3..2c8a78218c8e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -160,6 +160,8 @@
>  #define ESDHC_FLAG_CQHCI		BIT(12)
>  /* need request pmqos during low power */
>  #define ESDHC_FLAG_PMQOS		BIT(13)
> +/* The IP state got lost in low power mode */
> +#define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> @@ -193,32 +195,37 @@ static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  
>  static const struct esdhc_soc_data usdhc_imx6sx_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> -			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6ull_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> -			| ESDHC_FLAG_ERR010450,
> +			| ESDHC_FLAG_ERR010450
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> -			| ESDHC_FLAG_HS400,
> +			| ESDHC_FLAG_HS400
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> -			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400,
> +			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> -			| ESDHC_FLAG_CQHCI,
> +			| ESDHC_FLAG_CQHCI
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  struct pltfm_imx_data {
> @@ -1613,6 +1620,8 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  static int sdhci_esdhc_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> @@ -1621,6 +1630,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  			return ret;
>  	}
>  
> +	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
> +		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> +		mmc_retune_timer_stop(host->mmc);
> +		mmc_retune_needed(host->mmc);
> +	}
> +
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> 

