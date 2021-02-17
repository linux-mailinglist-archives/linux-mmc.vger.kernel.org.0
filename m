Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0131DB12
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Feb 2021 15:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBQOAZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Feb 2021 09:00:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:50407 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBQOAZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Feb 2021 09:00:25 -0500
IronPort-SDR: vNZwFu1tXDxpQrq61pZZX7Yt1ewWP1gWHvEyxiM/matzgCI67TM20+7CHRXbksUxJFxO5cOPC2
 zYvxQ4Dt6x7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="179689891"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="179689891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 05:59:44 -0800
IronPort-SDR: 9XbQD4vkLGTF3rpYU3auiBC9/uuDbcDsE2wKJjqHGPIZBgws7EfJsGT24g9hQW+9aVSxG+f5Qd
 lhMBEod9GgTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439368415"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2021 05:59:43 -0800
Subject: Re: [PATCH] sdhci: stop poking into swiotlb internals
To:     Christoph Hellwig <hch@lst.de>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
References: <20210205162346.2847165-1-hch@lst.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cc03dbbe-5269-e8f9-8a3f-f08696747098@intel.com>
Date:   Wed, 17 Feb 2021 15:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210205162346.2847165-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/02/21 6:23 pm, Christoph Hellwig wrote:
> Use the proper API to query the max mapping size instead of guessing
> it based on swiotlb internals.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 646823ddd31715..2d73407ee52ec7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -20,7 +20,6 @@
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sizes.h>
> -#include <linux/swiotlb.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> @@ -4582,12 +4581,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		mmc->max_segs = SDHCI_MAX_SEGS;
>  	} else if (host->flags & SDHCI_USE_SDMA) {
>  		mmc->max_segs = 1;
> -		if (swiotlb_max_segment()) {
> -			unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
> -						IO_TLB_SEGSIZE;
> -			mmc->max_req_size = min(mmc->max_req_size,
> -						max_req_size);
> -		}
> +		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
> +					  dma_max_mapping_size(mmc_dev(mmc)));
>  	} else { /* PIO */
>  		mmc->max_segs = SDHCI_MAX_SEGS;
>  	}
> 

