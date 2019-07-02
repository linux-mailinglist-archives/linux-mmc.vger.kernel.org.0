Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED75CC71
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jul 2019 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGBJLy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 2 Jul 2019 05:11:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:6567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJLy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jul 2019 05:11:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 02:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="scan'208";a="171725836"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2019 02:11:52 -0700
Subject: Re: [PATCH v2 2/3] mmc: sdhci: add quirks for be to le byte swapping
To:     Angelo Dureghello <angelo@sysam.it>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190616204823.32758-2-angelo@sysam.it>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <93921f9e-08a2-c53e-58a2-aa28e66a191d@intel.com>
Date:   Tue, 2 Jul 2019 12:10:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616204823.32758-2-angelo@sysam.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/06/19 11:48 PM, Angelo Dureghello wrote:
> Some controller as the ColdFire eshdc may require an endianness
> byte swap, because DMA read endianness is not configurable.

I would prefer something more generic, like adding another callback
for ->request_done() e.g.


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f56ae6f153d4..a63e528cb885 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }


Then you can use the ->request_done() callback to iterate over the data->sg
and make byte-swaps as needed.

> 
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
>  drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  7 +++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..f56ae6f153d4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2600,6 +2600,18 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.card_busy	= sdhci_card_busy,
>  };
>  
> +static void sdhci_be_to_le(char *buff, u32 length)
> +{
> +	int i, size = length >> 2;
> +	u32 *buffer = (u32 *)buff;
> +	u32 temp;
> +
> +	for (i = 0; i < size; i++) {
> +		temp = *buffer;
> +		*buffer++ = __le32_to_cpu(temp);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Request done                                                              *
> @@ -2655,6 +2667,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  						host->bounce_addr,
>  						host->bounce_buffer_size,
>  						DMA_FROM_DEVICE);
> +
> +					if (host->quirks2 &
> +					    SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP)
> +						sdhci_be_to_le(
> +							host->bounce_buffer,
> +							length);
> +
>  					sg_copy_from_buffer(data->sg,
>  						data->sg_len,
>  						host->bounce_buffer,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb..be08ff1a8c6f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -482,6 +482,13 @@ struct sdhci_host {
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>  
> +/*
> + * On some architectures, as ColdFire/m68k, native endianness is big endian,
> + * and the dma buffer is filled in big endian order only (no other options).
> + * So, a swap is needed for these specific cases.
> + */
> +#define SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP		(1<<19)
> +
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
>  	char *bounce_buffer;	/* For packing SDMA reads/writes */
> 

