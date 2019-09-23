Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749B7BAE3B
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393142AbfIWHAg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 03:00:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:55747 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393062AbfIWHAf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Sep 2019 03:00:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 00:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="200438503"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2019 00:00:32 -0700
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bc2ef677-d094-b436-dd68-3fcaa82cf857@intel.com>
Date:   Mon, 23 Sep 2019 09:59:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/09/19 1:26 PM, Russell King wrote:
> We must not unconditionally set the DMA snoop bit; if the DMA API is
> assuming that the device is not DMA coherent, and the device snoops the
> CPU caches, the device can see stale cache lines brought in by
> speculative prefetch.
> 
> This leads to the device seeing stale data, potentially resulting in
> corrupted data transfers.  Commonly, this results in a descriptor fetch
> error such as:
> 
> mmc0: ADMA error
> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> mmc0: sdhci: Host ctl2: 0x00000000
> mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> mmc0: sdhci: ============================================
> mmc0: error -5 whilst initialising SD card
> 
> but can lead to other errors, and potentially direct the SDHCI
> controller to read/write data to other memory locations (e.g. if a valid
> descriptor is visible to the device in a stale cache line.)
> 
> Fix this by ensuring that the DMA snoop bit corresponds with the
> behaviour of the DMA API.  Since the driver currently only supports DT,
> use of_dma_is_coherent().  Note that device_get_dma_attr() can not be
> used as that risks re-introducing this bug if/when the driver is
> converted to ACPI.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4dd43b1adf2c..74de5e8c45c8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -495,7 +495,12 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>  
>  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> -	value |= ESDHC_DMA_SNOOP;
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		value |= ESDHC_DMA_SNOOP;
> +	else
> +		value &= ~ESDHC_DMA_SNOOP;
> +
>  	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
>  	return 0;
>  }
> 

