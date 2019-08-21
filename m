Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C58978C9
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfHUMFr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 08:05:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:37554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfHUMFr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Aug 2019 08:05:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="181010081"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2019 05:05:43 -0700
Subject: Re: [PATCH V5 1/4] mmc: sdhci: Change timeout of loop for checking
 internal clock stable
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
References: <20190820020625.8230-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4e494909-01ba-bf23-2e01-faa131d75b00@intel.com>
Date:   Wed, 21 Aug 2019 15:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820020625.8230-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/19 5:06 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> According to section 3.2.1 internal clock setup in SD Host Controller
> Simplified Specifications 4.20, the timeout of loop for checking
> internal clock stable is defined as 150ms.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..bed0760a6c2a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> +	/* Wait max 150 ms */
> +	timeout = ktime_add_ms(ktime_get(), 150);
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> 

