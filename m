Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A5BAE3A
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393070AbfIWHAV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 03:00:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:27863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393062AbfIWHAV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Sep 2019 03:00:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 00:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="200438449"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2019 00:00:18 -0700
Subject: Re: [PATCH 1/3] mmc: sdhci: improve ADMA error reporting
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2719870a-27fb-ba70-6c75-45455eeeb09e@intel.com>
Date:   Mon, 23 Sep 2019 09:59:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/09/19 1:26 PM, Russell King wrote:
> ADMA errors are potentially data corrupting events; although we print
> the register state, we do not usefully print the ADMA descriptors.
> Worse than that, we print them by referencing their virtual address
> which is meaningless when the register state gives us the DMA address
> of the failing descriptor.
> 
> Print the ADMA descriptors giving their DMA addresses rather than their
> virtual addresses, and print them using SDHCI_DUMP() rather than DBG().
> 
> We also do not show the correct value of the interrupt status register;
> the register dump shows the current value, after we have cleared the
> pending interrupts we are going to service.  What is more useful is to
> print the interrupts that _were_ pending at the time the ADMA error was
> encountered.  Fix that too.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..0f33097c55ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2855,6 +2855,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  static void sdhci_adma_show_error(struct sdhci_host *host)
>  {
>  	void *desc = host->adma_table;
> +	dma_addr_t dma = host->adma_addr;
>  
>  	sdhci_dumpregs(host);
>  
> @@ -2862,18 +2863,21 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>  		struct sdhci_adma2_64_desc *dma_desc = desc;
>  
>  		if (host->flags & SDHCI_USE_64_BIT_DMA)
> -			DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> -			    desc, le32_to_cpu(dma_desc->addr_hi),
> +			SDHCI_DUMP("%08llx: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> +			    (unsigned long long)dma,
> +			    le32_to_cpu(dma_desc->addr_hi),
>  			    le32_to_cpu(dma_desc->addr_lo),
>  			    le16_to_cpu(dma_desc->len),
>  			    le16_to_cpu(dma_desc->cmd));
>  		else
> -			DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> -			    desc, le32_to_cpu(dma_desc->addr_lo),
> +			SDHCI_DUMP("%08llx: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> +			    (unsigned long long)dma,
> +			    le32_to_cpu(dma_desc->addr_lo),
>  			    le16_to_cpu(dma_desc->len),
>  			    le16_to_cpu(dma_desc->cmd));
>  
>  		desc += host->desc_sz;
> +		dma += host->desc_sz;
>  
>  		if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
>  			break;
> @@ -2949,7 +2953,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			!= MMC_BUS_TEST_R)
>  		host->data->error = -EILSEQ;
>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
> -		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
> +		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
> +		       intmask);
>  		sdhci_adma_show_error(host);
>  		host->data->error = -EIO;
>  		if (host->ops->adma_workaround)
> 

