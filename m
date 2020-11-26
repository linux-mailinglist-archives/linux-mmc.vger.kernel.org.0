Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F922C5030
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Nov 2020 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgKZITM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Nov 2020 03:19:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:54320 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbgKZITM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:19:12 -0500
IronPort-SDR: nJKaiUNIAOgkBixc6MoLYUKiB/DlR9CiVCD82TCF9eItLfgknushRMDJMrnBeHSTLd4KT4y9NY
 /S7EB1ErOLmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233858771"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="233858771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:19:11 -0800
IronPort-SDR: tGZS5AooN0kThI4nfyDTXxDAmYt2lJOsGD/WLKMGQpg4991FFUjahO8JTd/ZWJkYxVlCB4yvjP
 cQ2rLoPS9gtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362722374"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:19:07 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 20/27] mmc: sdhci-uhs2: add request() and others
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-21-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <85cfdefa-0aaa-d79c-a03f-b91e08eaf69b@intel.com>
Date:   Thu, 26 Nov 2020 10:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-21-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 529 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  93 +++---
>  drivers/mmc/host/sdhci.h      |  21 ++
>  3 files changed, 610 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index d8afb99a9918..36e52553977a 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
>  #include <linux/module.h>
> +#include <linux/mmc/mmc.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -394,6 +395,27 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +/* TODO: move them to a header */
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +static inline void sdhci_led_activate(struct sdhci_host *host)
> +{
> +}
> +
> +static inline void sdhci_led_deactivate(struct sdhci_host *host)
> +{
> +}
> +#else
> +static inline void sdhci_led_activate(struct sdhci_host *host)
> +{
> +	__sdhci_led_activate(host);
> +}
> +
> +static inline void sdhci_led_deactivate(struct sdhci_host *host)
> +{
> +	__sdhci_led_deactivate(host);
> +}
> +#endif

Unless you need LED support, let's drop  it

> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> @@ -523,6 +545,512 @@ static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
>  	return err;
>  }
>  
> +static bool sdhci_uhs2_send_command(struct sdhci_host *host,
> +				    struct mmc_command *cmd);
> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +				     struct mmc_command *cmd,
> +				     unsigned long flags);

Always order functions so that early function declarations are not needed

> +
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	bool present;
> +
> +	/* FIXME: check more flags? */
> +	if (!host->mmc->flags & MMC_UHS2_SUPPORT) {


	if (sdhci_uhs2_mode(host))

> +		sdhci_request(mmc, mrq);
> +		return;
> +	}
> +
> +	/* Firstly check card presence */
> +	present = mmc->ops->get_cd(mmc);

Checking CD here is another legacy hangover.  Should be able to check the
bus power instead. i.e. if the card has been removed, the bus power (bit-0
Power Control reg) should get set to 0.  That can be checked under spin lock.

> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	sdhci_led_activate(host);

Drop support for sdhci LEDs unless yoy are using them

> +
> +	if (sdhci_present_error(host, mrq->cmd, present))
> +		goto out_finish;
> +
> +	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;

UHS2 doesn't use CMD23 does it?

> +
> +	if (!sdhci_uhs2_send_command_retry(host, cmd, flags))

Don't use sdhci_uhs2_send_command_retry.  sdhci_send_command_retry is again
dealing with legacy hangover.  The inhibit bits should not be set.  If they
are it can be an error immediately.  So just use sdhci_uhs2_send_commend()

> +		goto out_finish;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return;
> +
> +out_finish:
> +	sdhci_finish_mrq(host, mrq);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request);
> +
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)

Should end up being able simply to call sdhci_uhs2_request (or vice versa)

> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!host->mmc->flags & MMC_UHS2_SUPPORT)
> +		return sdhci_request_atomic(mmc, mrq);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_present_error(host, mrq->cmd, true)) {
> +		sdhci_finish_mrq(host, mrq);
> +		goto out_finish;
> +	}
> +
> +	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
> +
> +	/*
> +	 * The HSQ may send a command in interrupt context without polling
> +	 * the busy signaling, which means we should return BUSY if controller
> +	 * has not released inhibit bits to allow HSQ trying to send request
> +	 * again in non-atomic context. So we should not finish this request
> +	 * here.
> +	 */
> +	if (!sdhci_uhs2_send_command(host, cmd))
> +		ret = -EBUSY;
> +	else
> +		sdhci_led_activate(host);
> +
> +out_finish:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Core functions                                                            *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
> +
> +	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> +	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> +}
> +
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +static void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
> +						 struct mmc_command *cmd)
> +{
> +	if (!sdhci_external_dma_setup(host, cmd)) {
> +		__sdhci_external_dma_prepare_data(host, cmd);
> +	} else {
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_uhs2_prepare_data(host, cmd);
> +	}
> +}
> +#else
> +static inline void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
> +							struct mmc_command *cmd)
> +{
> +	/* This should never happen */
> +	WARN_ON_ONCE(1);
> +}
> +
> +static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +						   struct mmc_command *cmd)
> +{
> +}
> +#endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */

Let's start without support for external DMA - unless you need it

> +
> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host);
> +
> +	/*
> +	 *  FIXME: Is this condition needed?
> +	    if (host->mmc->flags & MMC_UHS2_INITIALIZED)
> +	 */
> +	__sdhci_finish_mrq(host, data->mrq);
> +}
> +
> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
> +					 struct mmc_command *cmd)
> +{
> +	u16 mode;
> +	struct mmc_data *data = cmd->data;
> +	u16 arg;
> +
> +	if (!data) {
> +		/* clear Auto CMD settings for no data CMDs */
> +		arg = cmd->uhs2_cmd->arg;
> +		if ((((arg & 0xF) << 8) | ((arg >> 8) & 0xFF)) ==
> +		       UHS2_DEV_CMD_TRANS_ABORT) {
> +			mode =  0;
> +		} else {
> +			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
> +			if (cmd->opcode == MMC_STOP_TRANSMISSION ||
> +			    cmd->opcode == MMC_ERASE)
> +				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
> +			else
> +				/* send status mode */
> +				if (cmd->opcode == MMC_SEND_STATUS)
> +					mode = 0;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_MMC_DEBUG))
> +			DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> +
> +		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +		return;
> +	}
> +
> +	WARN_ON(!host->data);
> +
> +	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
> +	if (data->flags & MMC_DATA_WRITE)
> +		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> +
> +	if (data->blocks == 1 &&
> +	    data->blksz != 512 &&
> +	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
> +	    cmd->opcode != MMC_WRITE_BLOCK) {
> +		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> +		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> +	}
> +
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		mode |= SDHCI_UHS2_TRNS_DMA;
> +
> +	if ((host->mmc->flags & MMC_UHS2_2L_HD) && !cmd->uhs2_tmode0_flag)
> +		mode |= SDHCI_UHS2_TRNS_2L_HD;
> +
> +	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG))
> +		DBG("UHS2 trans mode is 0x%x.\n", mode);
> +}
> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	int i, j;
> +	int cmd_reg;
> +
> +	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +		if (!cmd->uhs2_cmd) {
> +			pr_err("%s: fatal error, no uhs2_cmd!\n",
> +			       mmc_hostname(host->mmc));
> +			return;
> +		}
> +	}
> +
> +	i = 0;
> +	sdhci_writel(host,
> +		     ((u32)cmd->uhs2_cmd->arg << 16) |
> +				(u32)cmd->uhs2_cmd->header,
> +		     SDHCI_UHS2_CMD_PACKET + i);
> +	i += 4;
> +
> +	/*
> +	 * Per spec, playload (config) should be MSB before sending out.
> +	 * But we don't need convert here because had set payload as
> +	 * MSB when preparing config read/write commands.
> +	 */
> +	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> +		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j),
> +			     SDHCI_UHS2_CMD_PACKET + i);
> +		i += 4;
> +	}
> +
> +	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
> +		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +		DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
> +		for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
> +			DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
> +			    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> +	}
> +
> +	cmd_reg = cmd->uhs2_cmd->packet_len <<
> +		SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT;
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +		cmd_reg |= SDHCI_UHS2_COMMAND_DATA;
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd_reg |= SDHCI_UHS2_COMMAND_CMD12;
> +
> +	/* UHS2 Native ABORT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
> +	    ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) == UHS2_DEV_CMD_TRANS_ABORT))
> +		cmd_reg |= SDHCI_UHS2_COMMAND_TRNS_ABORT;
> +
> +	/* UHS2 Native DORMANT */
> +	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
> +	     ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) ==
> +				UHS2_DEV_CMD_GO_DORMANT_STATE))
> +		cmd_reg |= SDHCI_UHS2_COMMAND_DORMANT;
> +
> +	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +	sdhci_writew(host, cmd_reg, SDHCI_UHS2_COMMAND);
> +}
> +
> +static bool sdhci_uhs2_send_command(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	int flags;
> +	u32 mask;
> +	unsigned long timeout;
> +
> +	/* FIXME: Is this check necessary? */

No

> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
> +		return sdhci_send_command(host, cmd);
> +
> +	WARN_ON(host->cmd);
> +
> +	/* Initially, a command has no error */
> +	cmd->error = 0;
> +
> +	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&

Quirk

> +	    cmd->opcode == MMC_STOP_TRANSMISSION)
> +		cmd->flags |= MMC_RSP_BUSY;
> +
> +	mask = SDHCI_CMD_INHIBIT;
> +	if (sdhci_data_line_cmd(cmd))
> +		mask |= SDHCI_DATA_INHIBIT;

Command inhibit for data is not supported by UHS2

> +
> +	/* We shouldn't wait for data inihibit for stop commands, even
> +	   though they might use busy signaling */
> +	if (cmd->mrq->data && (cmd == cmd->mrq->data->stop))
> +		mask &= ~SDHCI_DATA_INHIBIT;

Ditto

> +
> +	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
> +		return false;
> +
> +	host->cmd = cmd;
> +	host->data_timeout = 0;
> +	if (sdhci_data_line_cmd(cmd)) {
> +		WARN_ON(host->data_cmd);
> +		host->data_cmd = cmd;
> +		__sdhci_uhs2_set_timeout(host);
> +	}
> +
> +	if (cmd->data) {
> +		if (host->use_external_dma)
> +			sdhci_uhs2_external_dma_prepare_data(host, cmd);

To start with, let's drop support for external DMA with UHS2. i.e. disallow
UHS2 mode if external DMA is enabled

> +		else
> +			sdhci_uhs2_prepare_data(host, cmd);
> +	}
> +
> +	sdhci_uhs2_set_transfer_mode(host, cmd);
> +
> +	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> +		WARN_ONCE(1, "Unsupported response type!\n");
> +		/*
> +		 * This does not happen in practice because 136-bit response
> +		 * commands never have busy waiting, so rather than complicate
> +		 * the error path, just remove busy waiting and continue.
> +		 */
> +		cmd->flags &= ~MMC_RSP_BUSY;
> +	}
> +
> +	if (!(cmd->flags & MMC_RSP_PRESENT))
> +		flags = SDHCI_CMD_RESP_NONE;
> +	else if (cmd->flags & MMC_RSP_136)
> +		flags = SDHCI_CMD_RESP_LONG;
> +	else if (cmd->flags & MMC_RSP_BUSY)
> +		flags = SDHCI_CMD_RESP_SHORT_BUSY;
> +	else
> +		flags = SDHCI_CMD_RESP_SHORT;
> +
> +	if (cmd->flags & MMC_RSP_CRC)
> +		flags |= SDHCI_CMD_CRC;
> +	if (cmd->flags & MMC_RSP_OPCODE)
> +		flags |= SDHCI_CMD_INDEX;
> +
> +	/* CMD19 is special in that the Data Present Select should be set */
> +	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> +	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)

No tuning commands fo UHS2

> +		flags |= SDHCI_CMD_DATA;

flags are never used?

> +
> +	timeout = jiffies;
> +	if (host->data_timeout)
> +		timeout += nsecs_to_jiffies(host->data_timeout);
> +	else if (!cmd->data && cmd->busy_timeout > 9000)
> +		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> +	else
> +		timeout += 10 * HZ;
> +	sdhci_mod_timer(host, cmd->mrq, timeout);
> +
> +	if (host->use_external_dma)
> +		sdhci_external_dma_pre_transfer(host, cmd);
> +
> +	__sdhci_uhs2_send_command(host, cmd);
> +
> +	return true;
> +}
> +
> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +				     struct mmc_command *cmd,
> +				     unsigned long flags)

Can probably get rid of sdhci_uhs2_send_command_retry

> +	__releases(host->lock)
> +	__acquires(host->lock)
> +{
> +	struct mmc_command *deferred_cmd = host->deferred_cmd;
> +	int timeout = 10; /* Approx. 10 ms */
> +	bool present;
> +
> +	while (!sdhci_uhs2_send_command(host, cmd)) {
> +		if (!timeout--) {
> +			pr_err("%s: Controller never released inhibit bit(s).\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			cmd->error = -EIO;
> +			return false;
> +		}
> +
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
> +		usleep_range(1000, 1250);
> +
> +		present = host->mmc->ops->get_cd(host->mmc);
> +
> +		spin_lock_irqsave(&host->lock, flags);
> +
> +		/* A deferred command might disappear, handle that */
> +		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
> +			return true;
> +
> +		if (sdhci_present_error(host, cmd, present))
> +			return false;
> +	}
> +
> +	if (cmd == host->deferred_cmd)
> +		host->deferred_cmd = NULL;
> +
> +	return true;
> +}
> +
> +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +	u8 resp;
> +	u8 ecode;
> +	bool bReadA0 = 0;
> +	int i;
> +
> +	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +		if (resp & UHS2_RES_NACK_MASK) {
> +			ecode = (resp >> UHS2_RES_ECODE_POS) &
> +				UHS2_RES_ECODE_MASK;
> +			pr_err("%s: NACK is got, ECODE=0x%x.\n",
> +			       mmc_hostname(host->mmc), ecode);
> +		}
> +		bReadA0 = 1;
> +	}
> +
> +	if (cmd->uhs2_resp &&
> +	    cmd->uhs2_resp_len && cmd->uhs2_resp_len <= 20) {
> +		/* Get whole response of some native CCMD, like
> +		 * DEVICE_INIT, ENUMERATE.
> +		 */
> +		for (i = 0; i < cmd->uhs2_resp_len; i++)
> +			cmd->uhs2_resp[i] =
> +				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
> +	} else {
> +		/* Get SD CMD response and Payload for some read
> +		 * CCMD, like INQUIRY_CFG.
> +		 */
> +		/* Per spec (p136), payload field is divided into
> +		 * a unit of DWORD and transmission order within
> +		 * a DWORD is big endian.
> +		 */
> +		if (!bReadA0)
> +			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> +		for (i = 4; i < 20; i += 4) {
> +			cmd->resp[i / 4 - 1] =
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i) << 24) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 1)
> +					<< 16) |
> +				(sdhci_readb(host,
> +					     SDHCI_UHS2_RESPONSE + i + 2)
> +					<< 8) |
> +				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
> +		}
> +	}
> +}
> +
> +static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	/* FIXME: Is this check necessary? */
> +	if (!(host->mmc->flags & MMC_UHS2_SUPPORT)) {
> +		sdhci_finish_command(host);
> +		return;
> +	}
> +
> +	__sdhci_uhs2_finish_command(host);
> +
> +	host->cmd = NULL;
> +
> +	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
> +		mmc_command_done(host->mmc, cmd->mrq);
> +
> +	/*
> +	 * The host can send and interrupt when the busy state has
> +	 * ended, allowing us to wait without wasting CPU cycles.
> +	 * The busy signal uses DAT0 so this is similar to waiting
> +	 * for data to complete.
> +	 *
> +	 * Note: The 1.0 specification is a bit ambiguous about this
> +	 *       feature so there might be some problems with older
> +	 *       controllers.
> +	 */
> +	if (cmd->flags & MMC_RSP_BUSY) {
> +		if (cmd->data) {
> +			DBG("Cannot wait for busy signal when also doing a data transfer");
> +		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +			   cmd == host->data_cmd) {
> +			/* Command complete before busy is ended */
> +			return;
> +		}
> +	}
> +
> +	/* Finished CMD23, now send actual command. */

UHS2 doesn't use CMD23 does it?

> +	if (cmd == cmd->mrq->sbc) {
> +		if (!sdhci_uhs2_send_command(host, cmd->mrq->cmd)) {
> +			WARN_ON(host->deferred_cmd);
> +			host->deferred_cmd = cmd->mrq->cmd;
> +		}
> +	} else {
> +
> +		/* Processed actual command. */
> +		if (host->data && host->data_early)
> +			sdhci_uhs2_finish_data(host);
> +
> +		if (!cmd->data)
> +			__sdhci_finish_mrq(host, cmd->mrq);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -691,6 +1219,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
> +	host->mmc_host_ops.request = sdhci_uhs2_request;
>  
>  	if (!host->mmc_host_ops.uhs2_detect_init)
>  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index becb228330af..a9f5449bddcc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -48,8 +48,6 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> -static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> -
>  void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
> @@ -148,10 +146,13 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
>  
> -static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> +bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>  	return cmd->data || cmd->flags & MMC_RSP_BUSY;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
> +
> +/* TODO: move this as an inline function to a header */
>  
>  static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  {
> @@ -363,7 +364,7 @@ static void sdhci_reinit(struct sdhci_host *host)
>  		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>  
> -static void __sdhci_led_activate(struct sdhci_host *host)
> +void __sdhci_led_activate(struct sdhci_host *host)
>  {
>  	u8 ctrl;
>  
> @@ -374,8 +375,9 @@ static void __sdhci_led_activate(struct sdhci_host *host)
>  	ctrl |= SDHCI_CTRL_LED;
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_led_activate);
>  
> -static void __sdhci_led_deactivate(struct sdhci_host *host)
> +void __sdhci_led_deactivate(struct sdhci_host *host)
>  {
>  	u8 ctrl;
>  
> @@ -386,6 +388,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
>  	ctrl &= ~SDHCI_CTRL_LED;
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_led_deactivate);
>  
>  #if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
> @@ -464,14 +467,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
>  
>  #endif
>  
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> -			    unsigned long timeout)
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +		     unsigned long timeout)
>  {
>  	if (sdhci_data_line_cmd(mrq->cmd))
>  		mod_timer(&host->data_timer, timeout);
>  	else
>  		mod_timer(&host->timer, timeout);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_mod_timer);
>  
>  static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -1043,8 +1047,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  		__sdhci_set_timeout(host, cmd);
>  }
>  
> -static void sdhci_initialize_data(struct sdhci_host *host,
> -				  struct mmc_data *data)
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
>  {
>  	WARN_ON(host->data);
>  
> @@ -1057,6 +1060,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
>  
>  static inline void sdhci_set_block_info(struct sdhci_host *host,
>  					struct mmc_data *data)
> @@ -1079,12 +1083,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
>  	}
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
>  {
> -	struct mmc_data *data = cmd->data;
> -
> -	sdhci_initialize_data(host, data);
> -
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		struct scatterlist *sg;
>  		unsigned int length_mask, offset_mask;
> @@ -1169,6 +1169,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	sdhci_set_transfer_irqs(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
> +	sdhci_prepare_dma(host, data);
>  
>  	sdhci_set_block_info(host, data);
>  }
> @@ -1211,8 +1221,7 @@ static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
>  	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>  }
>  
> -static int sdhci_external_dma_setup(struct sdhci_host *host,
> -				    struct mmc_command *cmd)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int ret, i;
>  	enum dma_transfer_direction dir;
> @@ -1264,8 +1273,9 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_setup);
>  
> -static void sdhci_external_dma_release(struct sdhci_host *host)
> +void sdhci_external_dma_release(struct sdhci_host *host)
>  {
>  	if (host->tx_chan) {
>  		dma_release_channel(host->tx_chan);
> @@ -1279,9 +1289,10 @@ static void sdhci_external_dma_release(struct sdhci_host *host)
>  
>  	sdhci_switch_external_dma(host, false);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_release);
>  
> -static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> -					      struct mmc_command *cmd)
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +				       struct mmc_command *cmd)
>  {
>  	struct mmc_data *data = cmd->data;
>  
> @@ -1292,6 +1303,7 @@ static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  
>  	sdhci_set_block_info(host, data);
>  }
> +EXPORT_SYMBOL(__sdhci_external_dma_prepare_data);
>  
>  static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  					    struct mmc_command *cmd)
> @@ -1306,8 +1318,8 @@ static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>  	}
>  }
>  
> -static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> -					    struct mmc_command *cmd)
> +void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +				     struct mmc_command *cmd)
>  {
>  	struct dma_chan *chan;
>  
> @@ -1318,6 +1330,7 @@ static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>  	if (chan)
>  		dma_async_issue_pending(chan);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_external_dma_pre_transfer);
>  
>  #else
>  
> @@ -1369,11 +1382,11 @@ static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
>  	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>  }
>  
> -static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
> -				      struct mmc_request *mrq)
> +bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_manual_cmd23);
>  
>  static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>  					 struct mmc_command *cmd,
> @@ -1483,7 +1496,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
>  }
>  
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	if (host->cmd && host->cmd->mrq == mrq)
>  		host->cmd = NULL;
> @@ -1507,15 +1520,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  	if (!sdhci_has_requests(host))
>  		sdhci_led_deactivate(host);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
>  
> -static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	__sdhci_finish_mrq(host, mrq);
>  
>  	queue_work(host->complete_wq, &host->complete_work);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
>  
> -static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +void __sdhci_finish_data_common(struct sdhci_host *host)
>  {
>  	struct mmc_command *data_cmd = host->data_cmd;
>  	struct mmc_data *data = host->data;
> @@ -1548,6 +1563,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  		data->bytes_xfered = 0;
>  	else
>  		data->bytes_xfered = data->blksz * data->blocks;
> +}
> +EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
> +
> +static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	__sdhci_finish_data_common(host);
>  
>  	/*
>  	 * Need to send CMD12 if -
> @@ -1586,12 +1609,13 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  	}
>  }
>  
> -static void sdhci_finish_data(struct sdhci_host *host)
> +void sdhci_finish_data(struct sdhci_host *host)
>  {
>  	__sdhci_finish_data(host, false);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_data);
>  
> -static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> +bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int flags;
>  	u32 mask;
> @@ -1633,8 +1657,6 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  			sdhci_prepare_data(host, cmd);
>  	}
>  
> -	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> -
>  	sdhci_set_transfer_mode(host, cmd);
>  
>  	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> @@ -1678,13 +1700,16 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	if (host->use_external_dma)
>  		sdhci_external_dma_pre_transfer(host, cmd);
>  
> +	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_send_command);
>  
> -static bool sdhci_present_error(struct sdhci_host *host,
> -				struct mmc_command *cmd, bool present)
> +bool sdhci_present_error(struct sdhci_host *host,
> +			 struct mmc_command *cmd, bool present)
>  {
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		cmd->error = -ENOMEDIUM;
> @@ -1693,6 +1718,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_present_error);
>  
>  static bool sdhci_send_command_retry(struct sdhci_host *host,
>  				     struct mmc_command *cmd,
> @@ -1755,7 +1781,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_finish_command(struct sdhci_host *host)
> +void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> @@ -1808,6 +1834,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  			__sdhci_finish_mrq(host, cmd->mrq);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_command);
>  
>  static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e84ebddb20d8..6eeb74741da3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -831,8 +831,29 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +                     unsigned long timeout);
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_external_dma_release(struct sdhci_host *host);
> +void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +                                       struct mmc_command *cmd);
> +void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +                                     struct mmc_command *cmd);
> +#endif
> +bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_data_common(struct sdhci_host *host);
> +bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_finish_command(struct sdhci_host *host);
> +bool sdhci_present_error(struct sdhci_host *host,
> +                         struct mmc_command *cmd, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> 

