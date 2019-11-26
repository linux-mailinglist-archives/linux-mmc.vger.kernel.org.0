Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63466109D64
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 12:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKZL64 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 06:58:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:4007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfKZL64 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 06:58:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 03:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217146245"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 03:58:54 -0800
Subject: Re: [PATCH 02/14] mmc: sdhci: clear DMA_SEL before sending tuning
 command for Standard tuning
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
 <1573816075-26390-2-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4cc20a77-24c9-1425-3059-32839113b62a@intel.com>
Date:   Tue, 26 Nov 2019 13:57:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816075-26390-2-git-send-email-haibo.chen@nxp.com>
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
> Currently, when use standard tuning, driver default disable DMA just before
> send tuning command. But on i.MX8 usdhc, this is not enough. Need also clear
> DMA_SEL. If not, once the DMA_SEL select AMDA2 before, even dma already disabled,
> when send tuning command, usdhc will still prefetch the ADMA script from wrong
> DMA address, then we will see IOMMU report some error which show lack of TLB
> mapping.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 68db86c1b4c9..1436cc9c5f82 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2361,6 +2361,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  	struct mmc_request mrq = {};
>  	unsigned long flags;
>  	u32 b = host->sdma_boundary;
> +	u8 ctrl;
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> @@ -2388,6 +2389,17 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  	 */
>  	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
>  
> +
> +	/* DMA already disabled, so clear the DMA Select here.
> +	 * Otherwise, if use ADMA2, even disable DMA, some
> +	 * controllers like i.MX usdhc will still prefetch the
> +	 * ADMA script when send tuning command, which will cause
> +	 * IOMMU report lack of TLB mapping error
> +	 */
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +	ctrl &= ~SDHCI_CTRL_DMA_MASK;

Value zero is SDMA, so this does not look like a generic sdhci change.  What
about doing it in sdhci-esdhc-imx.c before executing tuning?

> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +
>  	sdhci_send_command(host, &cmd);
>  
>  	host->cmd = NULL;
> 

