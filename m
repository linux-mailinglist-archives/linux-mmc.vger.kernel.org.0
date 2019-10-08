Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8047FCF772
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2019 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfJHKuY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Oct 2019 06:50:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:20711 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfJHKuY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Oct 2019 06:50:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 03:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="205377937"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.188]) ([10.237.72.188])
  by orsmga002.jf.intel.com with ESMTP; 08 Oct 2019 03:50:22 -0700
Subject: Re: [v2, 1/2] mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit
 until completion
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190924093131.17471-1-yangbo.lu@nxp.com>
 <20190924093131.17471-2-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2d4e8bb6-f58a-06dd-9de5-40c8083ecee5@intel.com>
Date:   Tue, 8 Oct 2019 13:49:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924093131.17471-2-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/19 12:31 PM, Yangbo Lu wrote:
> The ESDHC_FLUSH_ASYNC_FIFO bit which is set to flush asynchronous FIFO
> should be polled until it's auto cleared by hardware.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 1d1953d..be0ba6b 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -655,6 +655,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  		temp = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>  		temp |= ESDHC_FLUSH_ASYNC_FIFO;
>  		sdhci_writel(host, temp, ESDHC_DMA_SYSCTL);
> +		/* Wait max 20 ms */
> +		timeout = ktime_add_ms(ktime_get(), 20);
> +		while (1) {
> +			bool timedout = ktime_after(ktime_get(), timeout);
> +
> +			if (!(sdhci_readl(host, ESDHC_DMA_SYSCTL) &
> +			      ESDHC_FLUSH_ASYNC_FIFO))
> +				break;
> +			if (timedout) {
> +				pr_err("%s: tuning block polling FLUSH_ASYNC_FIFO timeout.\n",
> +					mmc_hostname(host->mmc));
> +				break;
> +			}
> +			udelay(10);
> +		}
>  	}
>  
>  	/* Wait max 20 ms */
> @@ -811,6 +826,7 @@ static struct soc_device_attribute soc_fixup_tuning[] = {
>  
>  static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
>  {
> +	ktime_t timeout;
>  	u32 val;
>  
>  	esdhc_clock_enable(host, false);
> @@ -819,6 +835,22 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
>  	val |= ESDHC_FLUSH_ASYNC_FIFO;
>  	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
>  
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		if (!(sdhci_readl(host, ESDHC_DMA_SYSCTL) &
> +		      ESDHC_FLUSH_ASYNC_FIFO))
> +			break;
> +		if (timedout) {
> +			pr_err("%s: tuning block polling FLUSH_ASYNC_FIFO timeout.\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +		udelay(10);
> +	}

That code is the same as the block above, so it could be a separate
function.  Also you don't use SDHCI_QUIRK_CLOCK_BEFORE_RESET so using
usleep_range would be ok instead of udelay.

> +
>  	val = sdhci_readl(host, ESDHC_TBCTL);
>  	if (enable)
>  		val |= ESDHC_TB_EN;
> 

