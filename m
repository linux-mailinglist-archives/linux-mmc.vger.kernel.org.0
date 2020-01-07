Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1598913261D
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Jan 2020 13:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgAGMYS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Jan 2020 07:24:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:50699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgAGMYS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 07:24:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 04:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="271486440"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2020 04:24:16 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-of-esdhc: fix esdhc_reset() for different
 controller versions
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20191224084122.25381-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <12d82268-4f94-41d3-e0e7-2a3ab8a6964f@intel.com>
Date:   Tue, 7 Jan 2020 14:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224084122.25381-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/12/19 10:41 am, Yangbo Lu wrote:
> This patch is to fix operating in esdhc_reset() for different
> controller versions, and to add bus-width restoring after data
> reset for eSDHC (verdor version <= 2.2).
> 
> Also add annotation for understanding.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

One minor cosmetic comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index cd3b676..502e317 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -758,23 +758,53 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> -	u32 val;
> +	u32 val, bus_width = 0;
>  
> +	/* Add delay to make sure all the DMA transfers are finished
> +	 * for quirk.
> +	 */

sdhci-of-esdhc.c seems to have a mix of multi-line comment styles.
The preferred style is documented in Documentation/process/coding-style.rst

>  	if (esdhc->quirk_delay_before_data_reset &&
>  	    (mask & SDHCI_RESET_DATA) &&
>  	    (host->flags & SDHCI_REQ_USE_DMA))
>  		mdelay(5);
>  
> +	/* Save bus-width for eSDHC whose vendor version is 2.2
> +	 * or lower for data reset.
> +	 */
> +	if ((mask & SDHCI_RESET_DATA) &&
> +	    (esdhc->vendor_ver <= VENDOR_V_22)) {
> +		val = sdhci_readl(host, ESDHC_PROCTL);
> +		bus_width = val & ESDHC_CTRL_BUSWIDTH_MASK;
> +	}
> +
>  	sdhci_reset(host, mask);
>  
> -	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> -	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +	/* Restore bus-width setting and interrupt registers for eSDHC
> +	 * whose vendor version is 2.2 or lower for data reset.
> +	 */
> +	if ((mask & SDHCI_RESET_DATA) &&
> +	    (esdhc->vendor_ver <= VENDOR_V_22)) {
> +		val = sdhci_readl(host, ESDHC_PROCTL);
> +		val &= ~ESDHC_CTRL_BUSWIDTH_MASK;
> +		val |= bus_width;
> +		sdhci_writel(host, val, ESDHC_PROCTL);
> +
> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +	}
>  
> -	if (mask & SDHCI_RESET_ALL) {
> +	/* Some bits have to be cleaned manually for eSDHC whose spec
> +	 * version is higher than 3.0 for all reset.
> +	 */
> +	if ((mask & SDHCI_RESET_ALL) &&
> +	    (esdhc->spec_ver >= SDHCI_SPEC_300)) {
>  		val = sdhci_readl(host, ESDHC_TBCTL);
>  		val &= ~ESDHC_TB_EN;
>  		sdhci_writel(host, val, ESDHC_TBCTL);
>  
> +		/* Initialize eSDHC_DLLCFG1[DLL_PD_PULSE_STRETCH_SEL] to
> +		 * 0 for quirk.
> +		 */
>  		if (esdhc->quirk_unreliable_pulse_detection) {
>  			val = sdhci_readl(host, ESDHC_DLLCFG1);
>  			val &= ~ESDHC_DLL_PD_PULSE_STRETCH_SEL;
> 

