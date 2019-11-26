Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBB109D3E
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfKZLt5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 06:49:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:20363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfKZLt5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 06:49:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 03:49:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217144673"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 03:49:55 -0800
Subject: Re: [PATCH 01/14] mmc: sdhci: do not enable card detect interrupt for
 gpio cd type
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7d21c0eb-1bf0-5d35-dfdd-5bde703bcb68@intel.com>
Date:   Tue, 26 Nov 2019 13:48:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/19 1:07 PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
> we also do not need to handle controller native card detect interrupt
> for gpio cd type.
> If we wrong enabled the card detect interrupt for gpio case, it will
> cause a lot of unexpected card detect interrupts during data transfer
> which should not happen.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Currently sdhci expects drivers to use SDHCI_QUIRK_BROKEN_CARD_DETECTION but
this is OK too.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe86d9f9..68db86c1b4c9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -152,7 +152,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  	u32 present;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> -	    !mmc_card_is_removable(host->mmc))
> +	    !mmc_card_is_removable(host->mmc) || mmc_can_gpio_cd(host->mmc))
>  		return;
>  
>  	if (enable) {
> 

