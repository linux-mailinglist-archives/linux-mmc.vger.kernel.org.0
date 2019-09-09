Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA726AD7CF
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Sep 2019 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbfIILUi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 07:20:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:18530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391048AbfIILUi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Sep 2019 07:20:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 04:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="383945819"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2019 04:20:35 -0700
Subject: Re: [PATCH v2 09/11] mmc: sdhci: Drop redundant check in
 sdhci_ack_sdio_irq()
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
 <20190908101236.2802-10-ulf.hansson@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <40034b79-8e52-8ed7-2d18-1a8da498e5ea@intel.com>
Date:   Mon, 9 Sep 2019 14:19:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908101236.2802-10-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/09/19 1:12 PM, Ulf Hansson wrote:
> The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
> Therefore, let's drop the redundant check of the internal
> SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d814dc004bad..efa6cda8c991 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2163,8 +2163,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&host->lock, flags);
> -	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
> -		sdhci_enable_sdio_irq_nolock(host, true);
> +	sdhci_enable_sdio_irq_nolock(host, true);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> 

