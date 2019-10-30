Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E873CE9A0F
	for <lists+linux-mmc@lfdr.de>; Wed, 30 Oct 2019 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfJ3Kg2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 30 Oct 2019 06:36:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25196 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfJ3Kg1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2019 06:36:27 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UAWbHR025843;
        Wed, 30 Oct 2019 11:36:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iukvrcSYRcBC5q8srFYv5s9jlguroNa4HK3Fsk86e3I=;
 b=tANDDEl9ezOnbLw7u+ePzVrbLe9gWMJ0EK6z/YncfGZggC5Gy5fkhUVzkcDtRwJqL+dx
 6iENsPQ7oNpu5fKWeGIwKnsVhRv+3uwSqJTNOvRdhCSyVo+NRkMFqoz08GaLTpPV6JXR
 4d6To64uVJo9cA+f1RhPddOTRu/jhl/cKDG6tLE6v/R86ZMwI2PtVOsKICWj1NA6c2dz
 cYuntYUBUHxeez2TNSVheGExn8sCUVTLCwfe/Nh/sjgoAJ2OmyWF2w54cGnfZyFIFla5
 Zzzs1/MG3sLSDfmqMMxQrMN8FoZNo0G2tgPKtXNoFynyarkFS02QOGoalwQltHJ3shcE 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vxwhe32fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 11:36:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E78F10002A;
        Wed, 30 Oct 2019 11:36:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24AC02B1E79;
        Wed, 30 Oct 2019 11:36:11 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Oct
 2019 11:36:10 +0100
Subject: Re: [PATCH] mmc: mmci: Support odd block sizes for ux500v2 and qcom
 variant
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC:     Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20191029213708.17878-1-linus.walleij@linaro.org>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <418bb606-3143-7372-09b8-e08ccd206e62@st.com>
Date:   Wed, 30 Oct 2019 11:36:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191029213708.17878-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_04:2019-10-30,2019-10-30 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Le 10/29/19 à 10:37 PM, Linus Walleij a écrit :
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
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Ludovic: are you using your MMCI derivative for SDIO?
> Can you check if the flag for odd lengths should be
> set on the late ST derivatives as well?

like you explain, SDIO cards may transfer data in either a multi-byte
(1 to 512 bytes) or an optional block format, while the SD memory cards
are fixed in the block transfer mode.

The SDMMC variant uses an Internal DMA.
This internal DMA could transfert one segment aligned or not.
     "When the DATALENGTH is not an integer multiple of 4 (burst size)
      the remaining, smaller then burst size data is transfered using
      single transfer mode".

But the link list feature of Internal DMA is not supported in sdio.
With Link list, the segments size shall be an integer multiple of 4
(burst size) excepting for last segment (which can be no multiple of 4).

So for sdmmc, we could set the datactrl_odd_blocksz.
To be sure, I would like to test this patch with sdmmc.

Regards
Ludo

> ---
>   drivers/mmc/host/mmci.c | 19 +++++++++++++++----
>   drivers/mmc/host/mmci.h |  6 +++++-
>   2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..459969f410b2 100644
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
> @@ -279,6 +281,7 @@ static struct variant_data variant_qcom = {
>   	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
>   	.datalength_bits	= 24,
>   	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>   	.pwrreg_powerup		= MCI_PWR_UP,
>   	.f_max			= 208000000,
>   	.explicit_mclk_control	= true,
> @@ -447,10 +450,11 @@ void mmci_dma_setup(struct mmci_host *host)
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
> @@ -515,7 +519,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
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
> @@ -872,9 +878,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
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
> index 833236ecb31e..4c4aa0a258fa 100644
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
> +	u8			datactrl_odd_blocksz;
>   	u8			datactrl_first:1;
>   	u8			datacnt_useless:1;
>   	u8			st_sdio:1;
> 
