Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71497109F9C
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 14:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfKZNxr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 08:53:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:54899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfKZNxp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 08:53:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 05:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217166072"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 05:53:42 -0800
Subject: Re: [PATCH 10/14] mmc: sdhci-esdhc-imx: optimize the clock setting
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
 <1573816712-26841-2-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c492fa5b-854e-28b6-d67a-e303c29028c0@intel.com>
Date:   Tue, 26 Nov 2019 15:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816712-26841-2-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/19 1:18 PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> When force clock off, check the SDOFF of register PRSSTAT to make sure
> the clock is gate off. Before force clock on, check the SDSTB of register
> PRSSTAT to make sure the clock is stable, this will eliminate the clock
> glitch.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 24 +++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-esdhc.h     |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2ed945f5c259..0667b6903708 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> @@ -313,6 +314,17 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
>  }
>  
> +static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
> +{
> +	u32 present_state;
> +	int ret;
> +
> +	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, present_state,
> +				(present_state & ESDHC_CLOCK_GATE_OFF), 2, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us!.\n", __func__);
> +}
> +
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -526,6 +538,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		else
>  			new_val &= ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
>  		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
> +		if (!(new_val & ESDHC_VENDOR_SPEC_FRC_SDCLK_ON))
> +			esdhc_wait_for_card_clock_gate_off(host);
>  		return;
>  	case SDHCI_HOST_CONTROL2:
>  		new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> @@ -754,12 +768,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  	int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
>  	int pre_div = 1;
>  	int div = 1;
> +	int ret;
>  	u32 temp, val;
>  
>  	if (esdhc_is_usdhc(imx_data)) {
>  		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>  		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>  			host->ioaddr + ESDHC_VENDOR_SPEC);
> +		esdhc_wait_for_card_clock_gate_off(host);
>  	}
>  
>  	if (clock == 0) {
> @@ -814,13 +830,18 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  		| (pre_div << ESDHC_PREDIV_SHIFT));
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
> +	/* need to wait the bit 3 of the PRSSTAT to be set, make sure card clock is stable */
> +	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, temp,
> +				(temp & ESDHC_CLOCK_STABLE), 2, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc), "card clock still not stable in 100us!.\n");
> +
>  	if (esdhc_is_usdhc(imx_data)) {
>  		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>  		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>  			host->ioaddr + ESDHC_VENDOR_SPEC);
>  	}
>  
> -	mdelay(1);
>  }
>  
>  static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
> @@ -1005,6 +1026,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
>  		~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>  		host->ioaddr + ESDHC_VENDOR_SPEC);
> +	esdhc_wait_for_card_clock_gate_off(host);
>  
>  	/* force a reset on strobe dll */
>  	writel(ESDHC_STROBE_DLL_CTRL_RESET,
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 9289bb4d633e..947212f16bc6 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -31,6 +31,7 @@
>  
>  /* Present State Register */
>  #define ESDHC_PRSSTAT			0x24
> +#define ESDHC_CLOCK_GATE_OFF		0x00000080
>  #define ESDHC_CLOCK_STABLE		0x00000008
>  
>  /* Protocol Control Register */
> 

