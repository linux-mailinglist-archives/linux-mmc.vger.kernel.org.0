Return-Path: <linux-mmc+bounces-258-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E9B7FB54C
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Nov 2023 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD08282628
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Nov 2023 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6203D39A;
	Tue, 28 Nov 2023 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqTJ36Rp"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7BD4C;
	Tue, 28 Nov 2023 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701162758; x=1732698758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HJCBhWau23olURkNwP9LFY4MkHCSEIKKCHNz47W5Qp0=;
  b=OqTJ36RpaCe2ZK29RYBUFXX//WogFC71/dr6kYDi3RX91TDyHYcbjIEW
   8+jQi+B1M/KYjj4O/PrmOrhD9K/tjBa8GQXHk79woKFP+3nwodSYpbdZH
   3Gg3ATFz07QxG1xwZ7XClEsVVt1iS3RDnr538clxGhTu0NYo8Poml69sa
   vw5vk4rxr44Rskf2oElkSxCr7fuzoWPIrw+QltE3wgtbez2eGwkFzPyrI
   mcjGJq0dXpPBWt+CAIlt/XQbxEfgy2FEzycXvQucw0t6QZFwYwv2XPWYd
   J+1badW9/62FwwcTk7tAp+5roH76rJrY2VxzbB7RJSGAuAUEYeYlKuc8B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373053554"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373053554"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1100025863"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1100025863"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:11:27 -0800
Message-ID: <228dab31-8073-44f5-98ac-35aedb508e04@intel.com>
Date: Tue, 28 Nov 2023 11:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 11/21] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
Content-Language: en-US
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
 <20231117113149.9069-12-victorshihgli@gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231117113149.9069-12-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/23 13:31, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V13:
>  - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.
> 
> Updates in V8:
>  - Adjust the position of matching brackets.
> 
> Updates in V6:
>  - Remove unnecessary functions and simplify code.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index e339821d3504..ef6f02583d61 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,7 +10,9 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -21,6 +23,8 @@
>  #define SDHCI_UHS2_DUMP(f, x...) \
>  	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>  
> +#define UHS2_RESET_TIMEOUT_100MS		100000
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>  	if (!(sdhci_uhs2_mode(host)))
> @@ -49,6 +53,47 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> +{
> +	return	host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
> +}

This is the same as mmc_card_uhs2(host->mmc)

> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +	u32 val;
> +
> +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +	if (mask & SDHCI_UHS2_SW_RESET_FULL)
> +		host->clock = 0;
> +
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> +				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
> +		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
> +			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
> +		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 2bfe18d29bca..8253d50f7852 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -177,5 +177,7 @@
>  struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +bool sdhci_uhs2_mode(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  
>  #endif /* __SDHCI_UHS2_H */


