Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3233566E
	for <lists+linux-mmc@lfdr.de>; Wed,  5 Jun 2019 07:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFEFvg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 5 Jun 2019 01:51:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:49038 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfFEFvf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Jun 2019 01:51:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 22:51:35 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2019 22:51:33 -0700
Subject: Re: [PATCH] sdhci: tegra: Do not log error message on deferred probe
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20190604153446.22857-1-thierry.reding@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f856f9c3-e989-df46-739b-72f3030bdeb8@intel.com>
Date:   Wed, 5 Jun 2019 08:50:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604153446.22857-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/06/19 6:34 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Recent changes have made it much more probably that clocks are not
> available yet when the SDHCI driver is first probed. However, that
> is a situation that the driver can cope with just fine.
> 
> To avoid confusion, don't output an error when this happens.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 10d7aaf68bab..8a6a51bc038b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1550,8 +1550,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  
>  	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {
> -		dev_err(mmc_dev(host->mmc), "clk err\n");
>  		rc = PTR_ERR(clk);
> +
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get clock: %d\n", rc);
> +
>  		goto err_clk_get;
>  	}
>  	clk_prepare_enable(clk);
> 

