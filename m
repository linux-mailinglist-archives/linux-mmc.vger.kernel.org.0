Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93474EA2FE
	for <lists+linux-mmc@lfdr.de>; Wed, 30 Oct 2019 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfJ3SGo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 30 Oct 2019 14:06:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:32815 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJ3SGn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2019 14:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572458799;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KJMDLIU8B1NHrOUClPxWMIbrqXVVSZTTcyro8SdMjjY=;
        b=ctcxPwj9iHT/MhfqxLDdf1ikRWkpyhQUezYi6FuMt9fK4bH+wtJGVWrD58mut5+POQ
        LuAy1RitLszYnmudUsalPOTtOximXkhtB8CFCbVG4CDgw7+PdyjVv6V69jcQp9ohumMc
        mk+UsN0OWyQt7HFl6wCQiXiVpOOu0z3+jsi5JXu15RYAbXz3XtYNWW7U/5C9DBekiGNH
        2vyj9znUQEZWDuAImghFbND3yortwWjWggQiUjT696RYfP2zCJnwKhtUdtsAUouu5HpN
        aGvcXeR2Ib8EoW5IJ9St5jx52D1iCAwTd63yA7YqglJIMnPJCuDdDb1FnX4b3ewvIVf0
        SFQA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDdfvYtrvzKg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688v9UI3d8Ia
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 30 Oct 2019 19:03:39 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:03:32 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Support odd block sizes for ux500v2 and qcom
 variant
Message-ID: <20191030180332.GA73254@gerhold.net>
References: <20191029213708.17878-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029213708.17878-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 29, 2019 at 10:37:08PM +0100, Linus Walleij wrote:
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

Thanks for updating this patch!
*Without* this patch, with ux500v2 and brcmfmac I get:

    mmci-pl18x 80118000.sdi1_per2: unsupported block size (40 bytes)
    brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
    brcmfmac: brcmf_sdio_download_code_file: error -22 on writing 346151 membytes at 0x00000000
    brcmfmac: brcmf_sdio_download_firmware: dongle image file download failed

With this patch, brcmfmac works fine in PIO mode! Therefore:
Tested-by: Stephan Gerhold <stephan@gerhold.net>

See below for tests in DMA mode.

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
>   if (data->sg->offset & 3) {
>       dev_err(...);
>       return -EINVAL;
>   }
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

I'm personally quite confused about the behavior in DMA mode.
Even with this patch, it gets stuck on certain transfers, e.g.

    brcmfmac: brcmf_fil_iovar_data_get before ifidx=0, name=clmver, len=256
    sdio_io_rw_ext_helper: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, size: 292
    mmc_io_rw_extended: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, blocks: 0, blksz: 292

or

    brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=pmkid_info, len=356
    sdio_io_rw_ext_helper: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, size: 396
    mmc_io_rw_extended: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, blocks: 0, blksz: 396

(I added debug prints to sdio/mmc_io_rw_extended to see what it attempts
to write...)

For these two, it hangs, seemingly forever, on:

    Workqueue: brcmf_wq/mmc1:0001:1 brcmf_sdio_dataworker [brcmfmac]
    [<c07b3d80>] (__schedule) from [<c07b4034>] (schedule+0x50/0xc8)
    [<c07b4034>] (schedule) from [<c07b7df8>] (schedule_timeout+0x1e0/0x29c)
    [<c07b7df8>] (schedule_timeout) from [<c07b551c>] (wait_for_completion+0xc0/0x13c)
    [<c07b551c>] (wait_for_completion) from [<c051e8e0>] (mmc_wait_for_req_done+0x8c/0x108)
    [<c051e8e0>] (mmc_wait_for_req_done) from [<c0529c14>] (mmc_io_rw_extended+0x2a4/0x2e4)
    [<c0529c14>] (mmc_io_rw_extended) from [<c052b154>] (sdio_io_rw_ext_helper+0x184/0x210)
    [<c052b154>] (sdio_io_rw_ext_helper) from [<c052b2c0>] (sdio_memcpy_toio+0x20/0x28)
    [<c052b2c0>] (sdio_memcpy_toio) from [<bf028fac>] (brcmf_sdiod_skbuff_write+0x2c/0x54 [brcmfmac])
    [<bf028fac>] (brcmf_sdiod_skbuff_write [brcmfmac]) from [<bf0298d0>] (brcmf_sdiod_send_buf+0x64/0x98 [brcmfmac])
    [<bf0298d0>] (brcmf_sdiod_send_buf [brcmfmac]) from [<bf026534>] (brcmf_sdio_dataworker+0x1bd0/0x241c [brcmfmac])
    [<bf026534>] (brcmf_sdio_dataworker [brcmfmac]) from [<c01368a8>] (process_one_work+0x1f0/0x43c)

On the other hand, many other similarly looking transfers work just
fine. Some examples of transfers that work fine (in random order):

    mmc_io_rw_extended: write: 0, fn: 1, addr: 0x8000, incr_addr: 1, blocks: 0, blksz: 4
    mmc_io_rw_extended: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, blocks: 0, blksz: 56
    mmc_io_rw_extended: write: 1, fn: 2, addr: 0x8000, incr_addr: 1, blocks: 0, blksz: 288
    mmc_io_rw_extended: write: 0, fn: 2, addr: 0x8000, incr_addr: 0, blocks: 2, blksz: 512

I can provide full logs if that helps.

The only thing I noticed is that it seems to fail with particularly
large transfers in byte mode (blocks == 0).
No idea what is going wrong here...

However, the problem with DMA mode is not really related to this patch.
This patch makes brcmfmac work in PIO mode at least! :)

Small nitpick for the patch below.

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
> ---
>  drivers/mmc/host/mmci.c | 19 +++++++++++++++----
>  drivers/mmc/host/mmci.h |  6 +++++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..459969f410b2 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -168,6 +168,7 @@ static struct variant_data variant_ux500 = {
>  	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>  	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>  	.st_sdio		= true,
>  	.st_clkdiv		= true,
> @@ -201,6 +202,7 @@ static struct variant_data variant_ux500v2 = {
>  	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>  	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
>  	.st_sdio		= true,
>  	.st_clkdiv		= true,
> @@ -279,6 +281,7 @@ static struct variant_data variant_qcom = {
>  	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
>  	.datalength_bits	= 24,
>  	.datactrl_blocksz	= 11,
> +	.datactrl_odd_blocksz	= true,
>  	.pwrreg_powerup		= MCI_PWR_UP,
>  	.f_max			= 208000000,
>  	.explicit_mclk_control	= true,
> @@ -447,10 +450,11 @@ void mmci_dma_setup(struct mmci_host *host)
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
> @@ -515,7 +519,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
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
> @@ -872,9 +878,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
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
> index 833236ecb31e..4c4aa0a258fa 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -278,7 +278,10 @@ struct mmci_host;
>   * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
>   * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
>   * @datactrl_mask_sdio: SDIO enable mask in datactrl register
> - * @datactrl_blksz: block size in power of two
> + * @datactrl_blocksz: block size in power of two
> + * @datactrl_odd_blocksz: true if block any sizes are supported, such as one
> + *		      single character, as is necessary when using some SDIO
> + *		      devices.
>   * @datactrl_first: true if data must be setup before send command
>   * @datacnt_useless: true if you could not use datacnt register to read
>   *		     remaining data
> @@ -323,6 +326,7 @@ struct variant_data {
>  	unsigned int		datactrl_mask_ddrmode;
>  	unsigned int		datactrl_mask_sdio;
>  	unsigned int		datactrl_blocksz;
> +	u8			datactrl_odd_blocksz;

The other boolean flags use a bit field here:

>  	u8			datactrl_first:1;
>  	u8			datacnt_useless:1;
>  	u8			st_sdio:1;
> -- 
> 2.21.0
> 
