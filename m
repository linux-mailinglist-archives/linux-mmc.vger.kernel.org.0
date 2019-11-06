Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C257F1C01
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Nov 2019 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfKFRC0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Nov 2019 12:02:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37426 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732194AbfKFRC0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2019 12:02:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6GqiEo025942;
        Wed, 6 Nov 2019 18:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=7WCpCgfw9RqI6UDhMd2PommfIsCuY3X4p4xKZk9/wQg=;
 b=sBUpwNUdAm16Bpc/ZkuqIpe+BbQrdKNvwCNS09Z1IIwt2Yts3WobBik2+EICzSB0zOPm
 z0S3ItnwdRPw09uCgUPAaiNpcjWs7gQ9lYU5ZegKXsN6hGx7gsK+TxWC8InDxzW6QXNo
 dO0j1n3PVD0vGPkLflbLCN6hZvgjt6C3YqfuTFIeFYmjnoNPgX/QyLBF1VPFxPtUPGgZ
 l2li0/JHmhnTeV2ZMO7TJr7TwnRHT+zwC9AN/PZsagq4J7mAGHkaGlyjGGpc0wXKkk97
 7r3T0eUcy4D7H6y7HE5NhWFtEu5VIW6uo48DvFUib3ZaqVQ3m7T9yAMY3jZ3SJusEBfp LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vgr3gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 18:02:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 093B710002A;
        Wed,  6 Nov 2019 18:02:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE7C02FF5F1;
        Wed,  6 Nov 2019 18:02:09 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Nov
 2019 18:02:09 +0100
Subject: Re: [PATCH v2] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC:     Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20191104104021.7063-1-linus.walleij@linaro.org>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <965e6d7b-836b-1072-a457-9e7a26a6a128@st.com>
Date:   Wed, 6 Nov 2019 18:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191104104021.7063-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_05:2019-11-06,2019-11-06 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Linus

sdio and sdmmc tests ok on stm32mp157 dk2 board (sdmmc variant)

Tested-by: Ludovic Barre <ludovic.barre@st.com>

Le 11/4/19 à 11:40 AM, Linus Walleij a écrit :
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> This is something like the 5th time this patch is posted,
> so let's try to fix this now, once and for all.
> 
> For the ux500v2 variant of the PL18x block, odd block sizes are
> supported. This is necessary to support some SDIO transfers
> such as single bytes. This also affects the QCOM MMCI variant.
> 
> This will work fine for PIO using IRQs: SDIO packets are
> accepted down to single bytes and the transfers go through
> just fine.
> 
> This patch has proven necessary for enabling SDIO for WLAN on
> PostmarketOS-based Ux500 platforms.
> 
> This patch is based on Ulf Hansson's patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
> 
> Ulf noted on an earlier iteration in:
> https://marc.info/?l=linux-mmc&m=140845189316370&w=2
> 
> "There are some prerequisites of the data buffers to supports
> any block size, at least for ux500. (...) The conclusion from
> the above is that we need to adopt mmci_pio_write() to handle
> corner cases."
> 
> This points back to a discussion in 2012. The main point was
> made by Russell in this message:
> https://marc.info/?l=linux-arm-kernel&m=135351237018301&w=2
> 
> IIUC this pertains to this code (now gone from the patch):
> 
>    if (data->sg->offset & 3) {
>        dev_err(...);
>        return -EINVAL;
>    }
> 
> This hit Stephan as he noticed that DMA (DMA40) would not work
> with the MMCI driver, so this patch combined with disabling
> DMA would do the trick. That way we don't toss unaligned
> accesses at the DMA engine as SDIO apparently tends to
> do. (This is not a problem when writing ordinary block device
> blocks as these are always 512 bytes aligned on a 4-byte
> boundary.)
> 
> As Ulf notes, odd SG offsets like this should be handled
> by the driver even if we run it in DMA mode. I conclude
> it must be the duty of the DMA driver to say NO to SG
> offsets it cannot handle, or otherwise bitstuff things
> around to avoid the situation.
> 
> So as a first step make sure errors are propagated upward
> from the DMA engine, and assume the DMA engine will say no
> to things with weird SG offsets that it cannot handle, and
> then the driver will fall back to using PIO.
> 
> It might be that some DMA engines (such as the Ux500
> DMA40) do not properly say no to sglists with uneven
> offsets, or ignore the offset altogether resulting in
> unpredictable behavior. That is in that case a bug in the
> DMA driver and needs to be fixed there. I got the impression
> that the Qualcomm DMA actually can handle these odd
> alignments without problems.
> 
> (Make a drive-by fix for datactrl_blocksz, misspelled.)
> 
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Specify odd blocksize field to 1 bit (:1)
> - Specify that STMMC supports odd block sizes
> - Collect Stephan's test tag
> ---
>   drivers/mmc/host/mmci.c | 20 ++++++++++++++++----
>   drivers/mmc/host/mmci.h |  6 +++++-
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..3ffcdf78a428 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -168,6 +168,7 @@ static struct variant_data variant_ux500 = {
>   	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
>   	.datalength_bits	= 24,
>   	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>   	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>   	.st_sdio		= true,
>   	.st_clkdiv		= true,
> @@ -201,6 +202,7 @@ static struct variant_data variant_ux500v2 = {
>   	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
>   	.datalength_bits	= 24,
>   	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>   	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>   	.st_sdio		= true,
>   	.st_clkdiv		= true,
> @@ -260,6 +262,7 @@ static struct variant_data variant_stm32_sdmmc = {
>   	.datacnt_useless	= true,
>   	.datalength_bits	= 25,
>   	.datactrl_blocksz	= 14,
> +	.datactrl_odd_blocksz	= true,
>   	.stm32_idmabsize_mask	= GENMASK(12, 5),
>   	.init			= sdmmc_variant_init,
>   };
> @@ -279,6 +282,7 @@ static struct variant_data variant_qcom = {
>   	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
>   	.datalength_bits	= 24,
>   	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>   	.pwrreg_powerup		= MCI_PWR_UP,
>   	.f_max			= 208000000,
>   	.explicit_mclk_control	= true,
> @@ -447,10 +451,11 @@ void mmci_dma_setup(struct mmci_host *host)
>   static int mmci_validate_data(struct mmci_host *host,
>   			      struct mmc_data *data)
>   {
> +	struct variant_data *variant = host->variant;
> +
>   	if (!data)
>   		return 0;
> -
> -	if (!is_power_of_2(data->blksz)) {
> +	if (!is_power_of_2(data->blksz) && !variant->datactrl_odd_blocksz) {
>   		dev_err(mmc_dev(host->mmc),
>   			"unsupported block size (%d bytes)\n", data->blksz);
>   		return -EINVAL;
> @@ -515,7 +520,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
>   		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
>   		 data->sg_len, data->blksz, data->blocks, data->flags);
>   
> -	host->ops->dma_start(host, &datactrl);
> +	ret = host->ops->dma_start(host, &datactrl);
> +	if (ret)
> +		return ret;
>   
>   	/* Trigger the DMA transfer */
>   	mmci_write_datactrlreg(host, datactrl);
> @@ -872,9 +879,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
>   int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
>   {
>   	struct mmci_dmae_priv *dmae = host->dma_priv;
> +	int ret;
>   
>   	host->dma_in_progress = true;
> -	dmaengine_submit(dmae->desc_current);
> +	ret = dma_submit_error(dmaengine_submit(dmae->desc_current));
> +	if (ret < 0) {
> +		host->dma_in_progress = false;
> +		return ret;
> +	}
>   	dma_async_issue_pending(dmae->cur);
>   
>   	*datactrl |= MCI_DPSM_DMAENABLE;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 833236ecb31e..c7f94726eaa1 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -278,7 +278,10 @@ struct mmci_host;
>    * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
>    * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
>    * @datactrl_mask_sdio: SDIO enable mask in datactrl register
> - * @datactrl_blksz: block size in power of two
> + * @datactrl_blocksz: block size in power of two
> + * @datactrl_odd_blocksz: true if block any sizes are supported, such as one
> + *		      single character, as is necessary when using some SDIO
> + *		      devices.
>    * @datactrl_first: true if data must be setup before send command
>    * @datacnt_useless: true if you could not use datacnt register to read
>    *		     remaining data
> @@ -323,6 +326,7 @@ struct variant_data {
>   	unsigned int		datactrl_mask_ddrmode;
>   	unsigned int		datactrl_mask_sdio;
>   	unsigned int		datactrl_blocksz;
> +	u8			datactrl_odd_blocksz:1;
>   	u8			datactrl_first:1;
>   	u8			datacnt_useless:1;
>   	u8			st_sdio:1;
> 
