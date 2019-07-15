Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF168811
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfGOLUx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 07:20:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:65163 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfGOLUw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Jul 2019 07:20:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 04:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="169584028"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2019 04:20:49 -0700
Subject: Re: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation
 when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c54077a4-3aae-c95c-8491-db5f05b0305c@intel.com>
Date:   Mon, 15 Jul 2019 14:19:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/07/19 1:58 PM, Baolin Wang wrote:
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, but according to the specification, we should issue reset command
> and reinitialize the SD/eMMC card.

Where does it say that?

>                                    However, we only do reinitialize the
> SD/eMMC card when the SD/eMMC card are power down during runtime suspend.
> 
> Thus for those platforms that do not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all.
>                                                           To fix this
> issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
> to decide if we can do software reset for all or just reset command
> and data lines.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9715834..470c5e0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>  			host->ops->enable_dma(host);
>  	}
>  
> -	sdhci_init(host, 0);
> +	sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));

We have done a full reset for a long time, so it would be surprising to need
to change it.

What problem is it causing?

>  
>  	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
>  	    mmc->ios.power_mode != MMC_POWER_OFF) {
> 
