Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0845641C73
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFLGno (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 02:43:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:14406 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbfFLGnn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jun 2019 02:43:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 23:43:43 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2019 23:43:42 -0700
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirks for be to le byte swapping
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20190512194125.7091-1-angelo@sysam.it>
 <20190512194125.7091-2-angelo@sysam.it>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b2adda22-613e-67bf-cc3a-6bdd603ae02c@intel.com>
Date:   Wed, 12 Jun 2019 09:42:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190512194125.7091-2-angelo@sysam.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/05/19 10:41 PM, Angelo Dureghello wrote:
> Some controller as the ColdFire eshdc may require an endianness
> byte swap, becouse DMA read endianness is not configurable.

becouse -> because

Do any other drivers have this issue?

> 
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
>  drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  7 +++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 97158344b862..317dcfb4bb4c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2592,6 +2592,18 @@ static const struct mmc_host_ops sdhci_ops = {
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
> @@ -2647,6 +2659,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  						host->bounce_addr,
>  						host->bounce_buffer_size,
>  						DMA_FROM_DEVICE);
> +
> +					if (host->quirks2 &
> +					    SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP)
> +						sdhci_be_to_le(
> +							host->bounce_buffer,
> +							length);

How come it only affects the bounce buffer?  What about if there is no
bounce buffer?

> +
>  					sg_copy_from_buffer(data->sg,
>  						data->sg_len,
>  						host->bounce_buffer,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d6bcc584c92b..38fa69678cec 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -486,6 +486,13 @@ struct sdhci_host {
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

