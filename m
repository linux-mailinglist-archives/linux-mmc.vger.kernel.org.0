Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A540109E69
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfKZM7S (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 07:59:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:60129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfKZM7S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 07:59:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 04:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217157186"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 04:59:14 -0800
Subject: Re: [PATCH 09/14] mmc: sdhci-esdhc-imx: add strobe-dll-delay-target
 support
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <861edc92-741f-93e9-7787-d40cc2127091@intel.com>
Date:   Tue, 26 Nov 2019 14:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
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
> strobe-dll-delay-target is the delay cell add on the strobe line.
> Strobe line the the uSDHC loopback read clock which is use in HS400
> mode. Different strobe-dll-delay-target may need to set for different
> board/SoC. If this delay cell is not set to an appropriate value,
> we may see some read operation meet CRC error after HS400 mode select
> which already pass the tuning.
> 
> This patch add the strobe-dll-delay-target setting in driver, so that
> user can easily config this delay cell in dts file.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 12 +++++++++++-
>  include/linux/platform_data/mmc-esdhc-imx.h |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 448b29b2da62..2ed945f5c259 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -73,6 +73,7 @@
>  #define ESDHC_STROBE_DLL_CTRL		0x70
>  #define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
>  #define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
> +#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT	0x7
>  #define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
>  #define ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT	(4 << 20)
>  
> @@ -995,6 +996,9 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>   */
>  static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 strobe_delay;
>  	u32 v;
>  
>  	/* disable clock before enabling strobe dll */
> @@ -1012,9 +1016,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  	 * enable strobe dll ctrl and adjust the delay target
>  	 * for the uSDHC loopback read clock
>  	 */
> +	if (imx_data->boarddata.strobe_dll_delay_target)
> +		strobe_delay = imx_data->boarddata.strobe_dll_delay_target;
> +	else
> +		strobe_delay = ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT;
>  	v = ESDHC_STROBE_DLL_CTRL_ENABLE |
>  		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
> -		(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
> +		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
>  	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
>  	/* wait 5us to make sure strobe dll status register stable */
>  	udelay(5);
> @@ -1340,6 +1348,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	of_property_read_u32(np, "fsl,tuning-start-tap",
>  			     &boarddata->tuning_start_tap);
>  
> +	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
> +				&boarddata->strobe_dll_delay_target);
>  	if (of_find_property(np, "no-1-8-v", NULL))
>  		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 6c006078c8a1..0434f68eda86 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -37,5 +37,6 @@ struct esdhc_platform_data {
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
> +	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
>  };
>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> 

