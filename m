Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0D109E56
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKZMwy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 07:52:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:34480 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfKZMwy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 07:52:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 04:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217156343"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 04:52:51 -0800
Subject: Re: [PATCH 05/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl
 available
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
 <1573816361-26535-2-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <705eff49-f692-bbf1-4810-159a6078d369@intel.com>
Date:   Tue, 26 Nov 2019 14:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816361-26535-2-git-send-email-haibo.chen@nxp.com>
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
> When using jailhouse to support two Linux on i.MX8MQ EVK, we use the
> 1st Linux to configure pinctrl for the 2nd Linux. Then the 2nd Linux
> could use the mmc without pinctrl driver.
> 
> So give a warning message when no pinctrl available, but no fail probe.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 25b01f059aca..bc743f82d8c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1489,13 +1489,14 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>  	if (IS_ERR(imx_data->pinctrl)) {
>  		err = PTR_ERR(imx_data->pinctrl);
> -		goto disable_ahb_clk;
> -	}
> -
> -	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
> +		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
> +		imx_data->pins_default = ERR_PTR(-EINVAL);
> +	} else {
> +		imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
>  						PINCTRL_STATE_DEFAULT);
> -	if (IS_ERR(imx_data->pins_default))
> -		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
> +		if (IS_ERR(imx_data->pins_default))
> +			dev_warn(mmc_dev(host->mmc), "could not get default state\n");
> +	}
>  
>  	if (esdhc_is_usdhc(imx_data)) {
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> 

