Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC6BB3CB
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394195AbfIWMdR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 08:33:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:29087 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392341AbfIWMdR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Sep 2019 08:33:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 05:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="218523740"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2019 05:33:15 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190904164625.236978-1-rrangel@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6e65c246-a485-91c8-53e1-2ad0319a1e89@intel.com>
Date:   Mon, 23 Sep 2019 15:31:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/09/19 7:46 PM, Raul E Rangel wrote:
> In sdhci_do_reset we call the reset callback which is typically
> sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
> controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
> controller will clear the IRQ mask. If during that 100ms the card is
> removed there is no notification to the MMC system that the card was
> removed. So from the drivers point of view the card is always present.
> 
> By making sdhci_reinit compare the present state it can schedule a
> rescan if the card was removed while a reset was in progress.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Should have Acked this ages ago, sorry :-(

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Sorry this took me so long to send out. I tested out the patch set on
> 5.3-rc5 with multiple devices.
> 
> This patch was proposed here by Adrian: https://patchwork.kernel.org/patch/10925469/#22691177
> 
>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..b0045880ee3d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -337,8 +337,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> +	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +
>  	sdhci_init(host, 0);
>  	sdhci_enable_card_detection(host);
> +
> +	/*
> +	 * A change to the card detect bits indicates a change in present state,
> +	 * refer sdhci_set_card_detection(). A card detect interrupt might have
> +	 * been missed while the host controller was being reset, so trigger a
> +	 * rescan to check.
> +	 */
> +	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
> +		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>  
>  static void __sdhci_led_activate(struct sdhci_host *host)
> 

