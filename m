Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA205122919
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Dec 2019 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLQKoC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Dec 2019 05:44:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:20321 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfLQKoC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 05:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576579435;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RuE00aG6o+k7X1Sja8f0ccwKPFjJqEJIVTGNneqa/NA=;
        b=mVdvNwF2RM6WP1aOthWK3d/ufXdEPsYTuDm+DfeAgKFI+PWg830jTl1A5YaM5Ip8l8
        t3j2SSvweORV3s3SBYhT15PBoCtxE/mLDJ+3+1B1/tbj6og8dXmu0aY9eWpA5iLv5bG6
        5ZYhBv3V4WwHKwNOYUNcM+dDKzaTYQL4pci4p5ghQFF1esFK9t0mbtiBc1dEWz3ajugT
        UtmqdnfmHMTdFpazM1oWlnz4AXmZcdHnHwIZOsXyR4yxVJPEus+nAD/jX0sesgLr0J79
        PpHDjsS4wI3Rc13HPBwPlEbkeMrbzIGsU2bLecchFPlQPASTc0t2Plkmmerb/F3VO152
        tnVQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDdfbYtbb1Kg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.0.7 AUTH)
        with ESMTPSA id N0b206vBHAhjS80
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 17 Dec 2019 11:43:45 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:43:41 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
Message-ID: <20191217104341.GA20539@gerhold.net>
References: <20191216214659.29778-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216214659.29778-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 10:46:59PM +0100, Linus Walleij wrote:
> For the ux500v2 variant of the PL18x block, odd block sizes
> are supported. This is necessary to support some SDIO
> transfers. This also affects the QCOM MMCI variant and the
> ST micro variant.
> 
> For Ux500 an additional quirk only allowing DMA on blocks
> that are a power of two is needed. This might be a bug in
> the DMA engine (DMA40) or the MMCI or in the interconnect,
> but the most likely is the MMCI, as transfers of these
> sizes work fine for other devices using the same DMA
> engine. DMA works fine also with SDIO as long as the
> blocksize is a power of 2.
> 
> This patch has proven necessary for enabling SDIO for WLAN on
> PostmarketOS-based Ux500 platforms.
> 
> What we managed to test in practice is Broadcom WiFi over
> SDIO on the Ux500 based Samsung GT-I8190 and GT-S7710.
> This WiFi chip, BCM4334 works fine after the patch.
> 
> Before this patch:
> 
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4334-sdio
> 	  for chip BCM4334/3
> mmci-pl18x 80118000.sdi1_per2: unsupported block size (60 bytes)
> brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> brcmfmac: brcmf_sdio_download_code_file: error -22 on writing
> 	  434236 membytes at 0x00000000
> brcmfmac: brcmf_sdio_download_firmware: dongle image file download
> 	  failed
> 
> After this patch:
> 
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4334/3 wl0:
> 	  Nov 21 2012 00:21:28 version 6.10.58.813 (B2) FWID 01-0
> 
> Bringing up networks, discovering networks with "iw dev wlan0 scan"
> and connecting works fine from this point.
> 
> This patch is inspired by Ulf Hansson's patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
> 
> As the DMA engines on these platforms may now get block sizes
> they were not used to before, make sure to also respect if
> the DMA engine says "no" to a transfer.
> 
> Make a drive-by fix for datactrl_blocksz, misspelled.
> 
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v5:
> - Rename variant members as Ulf want them.
> ChangeLog v3->v4:
> - Rewrite the patch to accept odd packages but only
>   let power of two packages pass on to the DMA.
> - Drop the patches disallowing DMA not divisible by 4:
>   this doesn't work. Instead just push the whole
>   power of two criteria down to the DMA submission
>   phase.
> - Drop the patch handling odd sglist offsets and
>   passing of page boundaries in SG buffers when
>   using PIO: it just doesn't happen in practice, we
>   don't know why, but likely because all packets are
>   small.
> ChangeLog v2->v3:
> - Repost with the inclusion of other patches.
> ChangeLog v1->v2:
> - Specify odd blocksize field to 1 bit (:1)
> - Specify that STMMC supports odd block sizes
> - Collect Stephan's test tag
> ---
>  drivers/mmc/host/mmci.c | 34 ++++++++++++++++++++++++++++++----
>  drivers/mmc/host/mmci.h |  8 +++++++-
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..5afe9145f957 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -168,6 +168,8 @@ static struct variant_data variant_ux500 = {
>  	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
> +	.only_pow_2_dma		= true,
>  	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>  	.st_sdio		= true,
>  	.st_clkdiv		= true,
> @@ -201,6 +203,8 @@ static struct variant_data variant_ux500v2 = {
>  	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
> +	.only_pow_2_dma		= true,
>  	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>  	.st_sdio		= true,
>  	.st_clkdiv		= true,
> @@ -260,6 +264,7 @@ static struct variant_data variant_stm32_sdmmc = {
>  	.datacnt_useless	= true,
>  	.datalength_bits	= 25,
>  	.datactrl_blocksz	= 14,
> +	.datactrl_odd_blocksz	= true,
>  	.stm32_idmabsize_mask	= GENMASK(12, 5),
>  	.init			= sdmmc_variant_init,
>  };
> @@ -279,6 +284,7 @@ static struct variant_data variant_qcom = {
>  	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>  	.pwrreg_powerup		= MCI_PWR_UP,
>  	.f_max			= 208000000,
>  	.explicit_mclk_control	= true,
> @@ -447,10 +453,11 @@ void mmci_dma_setup(struct mmci_host *host)
>  static int mmci_validate_data(struct mmci_host *host,
>  			      struct mmc_data *data)
>  {
> +	struct variant_data *variant = host->variant;
> +
>  	if (!data)
>  		return 0;
> -
> -	if (!is_power_of_2(data->blksz)) {
> +	if (!is_power_of_2(data->blksz) && !variant->datactrl_odd_blocksz) {
>  		dev_err(mmc_dev(host->mmc),
>  			"unsupported block size (%d bytes)\n", data->blksz);
>  		return -EINVAL;
> @@ -515,7 +522,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
>  		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
>  		 data->sg_len, data->blksz, data->blocks, data->flags);
>  
> -	host->ops->dma_start(host, &datactrl);
> +	ret = host->ops->dma_start(host, &datactrl);
> +	if (ret)
> +		return ret;
>  
>  	/* Trigger the DMA transfer */
>  	mmci_write_datactrlreg(host, datactrl);
> @@ -822,6 +831,18 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>  	if (data->blksz * data->blocks <= variant->fifosize)
>  		return -EINVAL;
>  
> +	/*
> +	 * This is necessary to get SDIO working on the Ux500. We do not yet
> +	 * know if this is a bug in:
> +	 * - The Ux500 DMA controller (DMA40)
> +	 * - The MMCI DMA interface on the Ux500
> +	 * some power of two blocks (such as 64 bytes) are sent regularly
> +	 * during SDIO traffic and those work fine so for these we enable DMA
> +	 * transfers.
> +	 */
> +	if (host->variant->only_pow_2_dma && !is_power_of_2(data->blksz))
> +		return -EINVAL;

You forgot to rename the references of datactrl_odd_blocksz/only_pow_2_dma. :)
Until here you reference the old names, but below you define the new names.

> +
>  	device = chan->device;
>  	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
>  			   mmc_get_dma_dir(data));
> @@ -872,9 +893,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
>  int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
>  {
>  	struct mmci_dmae_priv *dmae = host->dma_priv;
> +	int ret;
>  
>  	host->dma_in_progress = true;
> -	dmaengine_submit(dmae->desc_current);
> +	ret = dma_submit_error(dmaengine_submit(dmae->desc_current));
> +	if (ret < 0) {
> +		host->dma_in_progress = false;
> +		return ret;
> +	}
>  	dma_async_issue_pending(dmae->cur);
>  
>  	*datactrl |= MCI_DPSM_DMAENABLE;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 833236ecb31e..89ab73343cf3 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -278,7 +278,11 @@ struct mmci_host;
>   * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
>   * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
>   * @datactrl_mask_sdio: SDIO enable mask in datactrl register
> - * @datactrl_blksz: block size in power of two
> + * @datactrl_blocksz: block size in power of two
> + * @datactrl_any_blocksz: true if block any block sizes are accepted by
> + *		  hardware, such as with some SDIO traffic that send
> + *		  odd packets.
> + * @dma_power_of_2: DMA only works with blocks that are a power of 2.
>   * @datactrl_first: true if data must be setup before send command
>   * @datacnt_useless: true if you could not use datacnt register to read
>   *		     remaining data
> @@ -323,6 +327,8 @@ struct variant_data {
>  	unsigned int		datactrl_mask_ddrmode;
>  	unsigned int		datactrl_mask_sdio;
>  	unsigned int		datactrl_blocksz;
> +	u8			datactrl_any_blocksz:1;
> +	u8			dma_power_of_2:1;
>  	u8			datactrl_first:1;
>  	u8			datacnt_useless:1;
>  	u8			st_sdio:1;
> -- 
> 2.21.0
> 
