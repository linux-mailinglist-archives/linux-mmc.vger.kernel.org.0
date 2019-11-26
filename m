Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2584E109FAC
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKZNzk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 08:55:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:40467 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfKZNzk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 08:55:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 05:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217166625"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 05:55:38 -0800
Subject: Re: [PATCH 11/14] mmc: sdhci-esdhc-imx: optimize the strobe dll
 setting
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
 <1573816712-26841-3-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <62e7d88e-04fb-8ee5-02db-57390a039088@intel.com>
Date:   Tue, 26 Nov 2019 15:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816712-26841-3-git-send-email-haibo.chen@nxp.com>
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
> After set the STROBE SLV delay target value, it need to wait some
> time to let the usdhc lock the REF and SLV clock. In normal case,
> 1~2us is enough for imx8/imx6 and imx7d, and 4~5us is enough for
> imx7ulp, but when do reboot stress test or do the bind/unbind stress
> test, sometimes need to wait about 10us to get the status lock.
> 
> This patch optimize delay handle method, only print the warning
> message if the status is still not lock after 1ms delay.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 0667b6903708..80a148f8009e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1021,6 +1021,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	u32 strobe_delay;
>  	u32 v;
> +	int ret;
>  
>  	/* disable clock before enabling strobe dll */
>  	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
> @@ -1046,15 +1047,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
>  		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
>  	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
> -	/* wait 5us to make sure strobe dll status register stable */
> -	udelay(5);
> -	v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
> -	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
> -		dev_warn(mmc_dev(host->mmc),
> -		"warning! HS400 strobe DLL status REF not lock!\n");
> -	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
> +
> +	/* wait max 50us to get the REF/SLV lock */
> +	ret = readl_poll_timeout(host->ioaddr + ESDHC_STROBE_DLL_STATUS, v,
> +		((v & ESDHC_STROBE_DLL_STS_REF_LOCK) && (v & ESDHC_STROBE_DLL_STS_SLV_LOCK)), 1, 50);
> +	if (ret == -ETIMEDOUT)
>  		dev_warn(mmc_dev(host->mmc),
> -		"warning! HS400 strobe DLL status SLV not lock!\n");
> +		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
>  }
>  
>  static void esdhc_reset_tuning(struct sdhci_host *host)
> 

