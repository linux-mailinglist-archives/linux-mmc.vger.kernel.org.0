Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021FA1035BB
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 09:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfKTIB0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 03:01:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:19484 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKTIB0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Nov 2019 03:01:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="204747852"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 00:01:23 -0800
Subject: Re: [PATCH] mmc: sdhci: Fix grammar in warning message
To:     Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
References: <20191119155503.21421-1-festevam@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cdb3be16-4549-c9ec-14b6-c447e34d8733@intel.com>
Date:   Wed, 20 Nov 2019 10:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119155503.21421-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/11/19 5:55 PM, Fabio Estevam wrote:
> The correct form is "did not become", so fix it accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe86d9f9..3140fe2e5dba 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2213,7 +2213,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		if (!(ctrl & SDHCI_CTRL_VDD_180))
>  			return 0;
>  
> -		pr_warn("%s: 3.3V regulator output did not became stable\n",
> +		pr_warn("%s: 3.3V regulator output did not become stable\n",
>  			mmc_hostname(mmc));
>  
>  		return -EAGAIN;
> @@ -2245,7 +2245,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		if (ctrl & SDHCI_CTRL_VDD_180)
>  			return 0;
>  
> -		pr_warn("%s: 1.8V regulator output did not became stable\n",
> +		pr_warn("%s: 1.8V regulator output did not become stable\n",
>  			mmc_hostname(mmc));
>  
>  		return -EAGAIN;
> 

