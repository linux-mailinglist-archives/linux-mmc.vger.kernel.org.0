Return-Path: <linux-mmc+bounces-4474-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A69AE2F6
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Oct 2024 12:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9366D1F23244
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Oct 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2F1B219E;
	Thu, 24 Oct 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjyxalGJ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087B1C728F;
	Thu, 24 Oct 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766836; cv=none; b=mKbJ6OcpEhJyusuOSu/GI0gOpv+pKGEn5EUTF2q3xj5fOBf5YBXVd3N9tEt24bvsC3mdgwBWtHPu5w2G0iTPh7TDviTAAQzEXn4pjdFofqwhYnkjirOGODYZ8uORM9UHGCZtOHJB6xLiAXnMhGxBj0xQSJ0fVrUmZL/1I6n3Fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766836; c=relaxed/simple;
	bh=hc5Khr+PplWiwdJ7VvqrVI/F9A6oiqzOEzbLA5DlbwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfn1JVtQK5d10rJJZQ1PFzuFsJQU3eEck35BsiPT0niO697vT0X1XPGybeZ22Xdbs81Rp4S5+ciKZneCkQoH/jSejOQW2dKqmDkHQIzWzDpiQn/D6oVNjL0orgs6x2qgMHZtqNu+vBws61oG01UhKlXjlV46rbH+0vXjwMzY8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjyxalGJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729766830; x=1761302830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hc5Khr+PplWiwdJ7VvqrVI/F9A6oiqzOEzbLA5DlbwI=;
  b=TjyxalGJUY40GrOBRI5RCWoPirknZpjLgPUMyo65Pwj0KrtLohvAztyn
   btnvV+Tb26SPD4lezGfuNx+9xTMqbEyaWqs8dLce0fpbhvorzQWTiWcsm
   JHIITeDfs/Su5xbPcHu4pzXkwnW4SdY+1NbIJ5SE7HXFQvS3u20JgQ+ba
   R3qhoI767G05GehKT5on4j4Iz2uzekyW2oAsN8j9kDk5N643tQkn3VJsS
   5LdKw0WvwVB2PPfdVL34/pXCu9cEYD5gIe7IRrH9tIuShuLIWPDfSy+2F
   25kPnhP3pxV9yq2jxvA8vKqONP7Yu3TTJIlHUGyCvWkBq0zKJcvngj1d0
   g==;
X-CSE-ConnectionGUID: js1qEVwaRmubjKDNX4a6Ow==
X-CSE-MsgGUID: 7+INg26oT02/nh6+WK8oDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29608763"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29608763"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 03:47:09 -0700
X-CSE-ConnectionGUID: xj/l4/2xQtGXXUgWqqB9Ng==
X-CSE-MsgGUID: EwQNuLT1QMyyuhVe41bx3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80478221"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 03:47:05 -0700
Message-ID: <a8033f18-7836-4de4-b21a-b81f52c1698d@intel.com>
Date: Thu, 24 Oct 2024 13:47:00 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V23 01/16] mmc: core: Support UHS-II card control and
 access
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Jason Lai <jason.lai@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-2-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241018105333.4569-2-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/24 13:53, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Embed UHS-II access/control functionality into the MMC request
> processing flow.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V23:
>  - Remove mmc_uhs2_card_prepare_cmd() function.
>  - Remove mmc_sd_can_poweroff_notify() function.
>  - Modify ios.timing setting in the sd_uhs2_power_off() function.
>  - Restore the position of assign the host->card to original position
>    in the sd_uhs2_init_card() function.
>  - Remove unnecessary error handle in the sd_uhs2_init_card() function.
>  - Add oldcard judgment to skip some programs in the
>    sd_uhs2_legacy_init() function.
>  - Remove unnecessary error handle in the sd_uhs2_legacy_init() function.
>  - Remove mmc_card_set_present() function in the sd_uhs2_reinit()function.
> 
> Updates in V16:
>  - Separate the Error Recovery mechanism into a separate patch#8.
> 
> Updates in V15:
>  - Move struct uhs2_command uhs2_cmd to struct mmc_request and
>    modify whatever other changers to make it work.
>  - Refer the SD Host Controller Standard Specification Section 3.10
>    to add Error Recovery mechanism to recover the command error.
> 
> Updates in V13:
>  - Separate __mmc_go_idle() into one patch for re-factorring the code.
>  - Move mmc_decode_scr declaration to sd.h.
>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN. 
>  - Drop unnecessary comment.
> 
> Updates in V12:
>  - Use mmc_op_multi() to check DCMD which supports multi read/write
>    in mmc_uhs2_prepare_cmd().
> 
> Updates in V10:
>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
>  - Drop do_multi in the mmc_blk_rw_rq_prep().
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
> 
> Updates in V8:
>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>  - Modify return value in sd_uhs2_attach().
> 
> Updates in V7:
>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
>  - Drop uhs2_state in favor of ios->timing.
>  - Remove unnecessary functions.
> 
> ---
> 
>  drivers/mmc/core/core.c    |    8 +-
>  drivers/mmc/core/sd.c      |    8 +-
>  drivers/mmc/core/sd.h      |    5 +
>  drivers/mmc/core/sd_ops.c  |    9 +
>  drivers/mmc/core/sd_ops.h  |    2 +
>  drivers/mmc/core/sd_uhs2.c | 1097 ++++++++++++++++++++++++++++++++++--
>  include/linux/mmc/core.h   |   17 +
>  include/linux/mmc/host.h   |   15 +
>  8 files changed, 1122 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 54ca9dc2114c..a499f3c59de5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -354,6 +354,9 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  	if (err)
>  		return err;
>  
> +	if (host->uhs2_sd_tran)
> +		mmc_uhs2_prepare_cmd(host, mrq);
> +
>  	led_trigger_event(host->led, LED_FULL);
>  	__mmc_start_request(host, mrq);
>  
> @@ -453,6 +456,9 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  	if (err)
>  		goto out_err;
>  
> +	if (host->uhs2_sd_tran)
> +		mmc_uhs2_prepare_cmd(host, mrq);
> +
>  	err = host->cqe_ops->cqe_request(host, mrq);
>  	if (err)
>  		goto out_err;
> @@ -1135,7 +1141,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>  		return 0;
>  	}
>  
> -	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> +	if (!mmc_card_uhs2(host) && host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
>  		bit = ffs(ocr) - 1;
>  		ocr &= 3 << bit;
>  		mmc_power_cycle(host, ocr);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 918b86bf8bbb..f3811b523f68 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -200,7 +200,7 @@ static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
>  /*
>   * Given a 64-bit response, decode to our card SCR structure.
>   */
> -static int mmc_decode_scr(struct mmc_card *card)
> +int mmc_decode_scr(struct mmc_card *card)
>  {
>  	struct sd_scr *scr = &card->scr;
>  	unsigned int scr_struct;
> @@ -903,7 +903,7 @@ int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc)
>  	return 0;
>  }
>  
> -static int mmc_sd_get_ro(struct mmc_host *host)
> +int mmc_sd_get_ro(struct mmc_host *host)
>  {
>  	int ro;
>  
> @@ -1635,7 +1635,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>  	}
>  }
>  
> -static int sd_can_poweroff_notify(struct mmc_card *card)
> +int sd_can_poweroff_notify(struct mmc_card *card)
>  {
>  	return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
>  }
> @@ -1663,7 +1663,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
>  	return 0;
>  }
>  
> -static int sd_poweroff_notify(struct mmc_card *card)
> +int sd_poweroff_notify(struct mmc_card *card)
>  {
>  	struct sd_busy_data cb_data;
>  	u8 *reg_buf;
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 7e8beface2ca..0060accc3a31 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -11,10 +11,15 @@ struct mmc_card;
>  
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
>  int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc);
> +int mmc_decode_scr(struct mmc_card *card);
> +int mmc_sd_get_ro(struct mmc_host *host);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>  	bool reinit);
>  unsigned mmc_sd_get_max_clock(struct mmc_card *card);
>  int mmc_sd_switch_hs(struct mmc_card *card);
>  
> +int sd_can_poweroff_notify(struct mmc_card *card);
> +int sd_poweroff_notify(struct mmc_card *card);
> +
>  #endif
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 50d1380e93b8..cd86463dd306 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -42,6 +42,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>  	if (WARN_ON(card && card->host != host))
>  		return -EINVAL;
>  
> +	/*
> +	 * UHS2 packet has APP bit so only set APP_CMD flag here.
> +	 * Will set the APP bit when assembling UHS2 packet.
> +	 */
> +	if (host->uhs2_sd_tran) {
> +		host->uhs2_app_cmd = true;
> +		return 0;
> +	}
> +
>  	cmd.opcode = MMC_APP_CMD;
>  
>  	if (card) {
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index fd3f10b9cf86..a86c0cfa0aae 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  
>  struct mmc_card;
> +struct mmc_command;
>  struct mmc_host;
>  
>  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> @@ -22,6 +23,7 @@ int mmc_app_send_scr(struct mmc_card *card);
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
>  int mmc_send_ext_addr(struct mmc_host *host, u32 addr);
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
>  
>  #endif
>  
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 19d62d45e1ec..4e6889430957 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1,23 +1,51 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2021 Linaro Ltd
> - *
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
>   *
> + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + * Author: Yi Sun <yi.y.sun@intel.com>
> + *
> + * Copyright (C) 2020 Genesys Logic, Inc.
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * Copyright (C) 2022 Genesys Logic, Inc.
> + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2023 Genesys Logic, Inc.
> + * Authors: Victor Shih <victor.shih@genesyslogic.com.tw>
> + *
>   * Support for SD UHS-II cards
>   */
>  #include <linux/err.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sd_uhs2.h>
>  
> +#include "card.h"
>  #include "core.h"
>  #include "bus.h"
>  #include "sd.h"
> +#include "sd_ops.h"
>  #include "mmc_ops.h"
>  
> +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
> +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
> +
>  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
>  
> +struct sd_uhs2_wait_active_state_data {
> +	struct mmc_host *host;
> +	struct mmc_command *cmd;
> +};
> +
>  static int sd_uhs2_power_up(struct mmc_host *host)
>  {
>  	int err;
> @@ -42,12 +70,46 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>  
>  	host->ios.vdd = 0;
>  	host->ios.clock = 0;
> +	/* Must set UHS2 timing to identify UHS2 mode */

That comment is stale, but...

>  	host->ios.timing = MMC_TIMING_LEGACY;

MMC_TIMING_UHS2_SPEED_A is also checked by mmc_card_uhs2()
which is used a lot.

It might be that ios.timing should be MMC_TIMING_UHS2_SPEED_A
until after calling host->ops->uhs2_control() ?

>  	host->ios.power_mode = MMC_POWER_OFF;
> +	host->uhs2_sd_tran = false;
>  
>  	return host->ops->uhs2_control(host, UHS2_SET_IOS);
>  }
>  
> +/*
> + * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embedded in
> + *                          mmc_command structure
> + * @cmd:	MMC command to executed
> + * @uhs2_cmd:	UHS2 command corresponded to MMC command
> + * @header:	Header field of UHS-II command cxpacket
> + * @arg:	Argument field of UHS-II command packet
> + * @payload:	Payload field of UHS-II command packet
> + * @plen:	Payload length
> + * @resp:	Response buffer is allocated by caller and it is used to keep
> + *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
> + *              should be null and SD-TRAN command response should be stored in
> + *              resp of mmc_command.
> + * @resp_len:	Response buffer length
> + *
> + * The uhs2_command structure contains message packets which are transmited/
> + * received on UHS-II bus. This function fills in the contents of uhs2_command
> + * structure and embededs UHS2 command into mmc_command structure, which is used
> + * in legacy SD operation functions.
> + *
> + */
> +static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
> +				 struct uhs2_command *uhs2_cmd,
> +				 u8 plen, u8 resp_len)
> +{
> +	uhs2_cmd->payload_len = plen * sizeof(u32);
> +	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
> +
> +	cmd->uhs2_cmd = uhs2_cmd;
> +	cmd->uhs2_cmd->uhs2_resp_len = resp_len;
> +}
> +
>  /*
>   * Run the phy initialization sequence, which mainly relies on the UHS-II host
>   * to check that we reach the expected electrical state, between the host and
> @@ -55,7 +117,15 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>   */
>  static int sd_uhs2_phy_init(struct mmc_host *host)
>  {
> -	return 0;
> +	int err;
> +
> +	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +	if (err) {
> +		pr_err("%s: failed to initial phy for UHS-II!\n",
> +		       mmc_hostname(host));
> +	}
> +
> +	return err;
>  }
>  
>  /*
> @@ -64,6 +134,83 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_dev_init(struct mmc_host *host)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u32 cnt;
> +	u32 dap, gap, resp_gap;
> +	u8 gd = 0;
> +	int err;
> +
> +	dap = host->uhs2_caps.dap;
> +	gap = host->uhs2_caps.gap;
> +
> +	/*
> +	 * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVICE_INIT CCMD format.
> +	 * Head:
> +	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +	 *      - IOADR = CMD_BASE + 002h
> +	 * Payload:
> +	 *      - bit [3:0]  : GAP(Group Allocated Power)
> +	 *      - bit [7:4]  : GD(Group Descriptor)
> +	 *      - bit [11]   : Complete Flag
> +	 *      - bit [15:12]: DAP(Device Allocated Power)
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +	uhs2_cmd.arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> +	       UHS2_NATIVE_CMD_WRITE |
> +	       UHS2_NATIVE_CMD_PLEN_4B |
> +	       (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> +
> +	/*
> +	 * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> +	 * Max. time from DEVICE_INIT CCMD EOP reception on Device
> +	 * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> +	 * 1 second.
> +	 */
> +	cmd.busy_timeout = 1000;
> +
> +	/*
> +	 * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> +	 * Let's retry the DEVICE_INIT command no more than 30 times.
> +	 */
> +	for (cnt = 0; cnt < 30; cnt++) {
> +		uhs2_cmd.payload[0] = ((dap & 0xF) << 12) |
> +				       UHS2_DEV_INIT_COMPLETE_FLAG |
> +				       ((gd & 0xF) << 4) |
> +				       (gap & 0xF);
> +
> +		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
> +				     UHS2_DEV_INIT_RESP_LEN);
> +
> +		err = mmc_wait_for_cmd(host, &cmd, 0);
> +
> +		if (err) {
> +			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +			       mmc_hostname(host), __func__, err);
> +			continue;
> +		}
> +
> +		if (uhs2_cmd.uhs2_resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> +			pr_err("%s: DEVICE_INIT response is wrong!\n",
> +			       mmc_hostname(host));
> +			return -EIO;
> +		}
> +
> +		if (uhs2_cmd.uhs2_resp[5] & 0x8) {
> +			host->uhs2_caps.group_desc = gd;
> +			return 0;
> +		}
> +		resp_gap = uhs2_cmd.uhs2_resp[4] & 0x0F;
> +		if (gap == resp_gap)
> +			gd++;
> +	}
> +
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -74,6 +221,48 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u8 id_f = 0xF, id_l = 0x0;
> +	int err;
> +
> +	/*
> +	 * Refer to UHS-II Addendum Version 1.02 Figure 6-28 to see ENUMERATE CCMD format.
> +	 * Header:
> +	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +	 *      - IOADR = CMD_BASE + 003h
> +	 * Payload:
> +	 *      - bit [3:0]: ID_L(Last Node ID)
> +	 *      - bit [7:4]: ID_F(First Node ID)
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +	uhs2_cmd.arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_4B |
> +			(UHS2_DEV_CMD_ENUMERATE >> 8);
> +
> +	uhs2_cmd.payload[0] = (id_f << 4) | id_l;
> +	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_ENUM_PAYLOAD_LEN, UHS2_DEV_ENUM_RESP_LEN);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	if (uhs2_cmd.uhs2_resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
> +		pr_err("%s: ENUMERATE response is wrong!\n",
> +		       mmc_hostname(host));
> +		return -EIO;
> +	}
> +
> +	id_f = (uhs2_cmd.uhs2_resp[4] >> 4) & 0xF;
> +	id_l = uhs2_cmd.uhs2_resp[4] & 0xF;
> +	*node_id = id_f;
> +
>  	return 0;
>  }
>  
> @@ -84,6 +273,180 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>   */
>  static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u32 cap;
> +	int err;
> +
> +	/*
> +	 * Use Control Read CCMD to read Generic Capability from Configuration Register.
> +	 * - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +	 * - IOADR = Generic Capability Register(CFG_BASE + 000h)
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_READ |
> +			UHS2_NATIVE_CMD_PLEN_4B |
> +			(UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> +
> +	/*
> +	 * There is no payload because per spec, there should be
> +	 * no payload field for read CCMD.
> +	 * Plen is set in arg. Per spec, plen for read CCMD
> +	 * represents the len of read data which is assigned in payload
> +	 * of following RES (p136).
> +	 */
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Generic Capability Register:
> +	 * bit [7:0]  : Reserved
> +	 * bit [13:8] : Device-Specific Number of Lanes and Functionality
> +	 *              bit 8: 2L-HD
> +	 *              bit 9: 2D-1U FD
> +	 *              bit 10: 1D-2U FD
> +	 *              bit 11: 2D-2U FD
> +	 *              Others: Reserved
> +	 * bit [14]   : DADR Length
> +	 *              0: 4 bytes
> +	 *              1: Reserved
> +	 * bit [23:16]: Application Type
> +	 *              bit 16: 0=Non-SD memory, 1=SD memory
> +	 *              bit 17: 0=Non-SDIO, 1=SDIO
> +	 *              bit 18: 0=Card, 1=Embedded
> +	 * bit [63:24]: Reserved
> +	 */
> +	cap = cmd.resp[0];
> +	card->uhs2_config.n_lanes =
> +				(cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
> +				UHS2_DEV_CONFIG_N_LANES_MASK;
> +	card->uhs2_config.dadr_len =
> +				(cap >> UHS2_DEV_CONFIG_DADR_POS) &
> +				UHS2_DEV_CONFIG_DADR_MASK;
> +	card->uhs2_config.app_type =
> +				(cap >> UHS2_DEV_CONFIG_APP_POS) &
> +				UHS2_DEV_CONFIG_APP_MASK;
> +
> +	/*
> +	 * Use Control Read CCMD to read PHY Capability from Configuration Register.
> +	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = PHY Capability Register(CFG_BASE + 002h)
> +	 */
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_READ |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_PHY_CAPS >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * PHY Capability Register:
> +	 * bit [3:0]  : PHY Minor Revision
> +	 * bit [5:4]  : PHY Major Revision
> +	 * bit [15]   : Support Hibernate Mode
> +	 *              0: Not support Hibernate Mode
> +	 *              1: Support Hibernate Mode
> +	 * bit [31:16]: Reserved
> +	 * bit [35:32]: Device-Specific N_LSS_SYN
> +	 * bit [39:36]: Device-Specific N_LSS_DIR
> +	 * bit [63:40]: Reserved
> +	 */
> +	cap = cmd.resp[0];
> +	card->uhs2_config.phy_minor_rev =
> +				cap & UHS2_DEV_CONFIG_PHY_MINOR_MASK;
> +	card->uhs2_config.phy_major_rev =
> +				(cap >> UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
> +				 UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
> +	card->uhs2_config.can_hibernate =
> +				(cap >> UHS2_DEV_CONFIG_CAN_HIBER_POS) &
> +				 UHS2_DEV_CONFIG_CAN_HIBER_MASK;
> +
> +	cap = cmd.resp[1];
> +	card->uhs2_config.n_lss_sync =
> +				cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +	card->uhs2_config.n_lss_dir =
> +				(cap >> UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
> +				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +	if (card->uhs2_config.n_lss_sync == 0)
> +		card->uhs2_config.n_lss_sync = 16 << 2;
> +	else
> +		card->uhs2_config.n_lss_sync <<= 2;
> +
> +	if (card->uhs2_config.n_lss_dir == 0)
> +		card->uhs2_config.n_lss_dir = 16 << 3;
> +	else
> +		card->uhs2_config.n_lss_dir <<= 3;
> +
> +	/*
> +	 * Use Control Read CCMD to read LINK/TRAN Capability from Configuration Register.
> +	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = LINK/TRAN Capability Register(CFG_BASE + 004h)
> +	 */
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_READ |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * LINK/TRAN Capability Register:
> +	 * bit [3:0]  : LINK_TRAN Minor Revision
> +	 * bit [5:4]  : LINK/TRAN Major Revision
> +	 * bit [7:6]  : Reserved
> +	 * bit [15:8] : Device-Specific N_FCU
> +	 * bit [18:16]: Device Type
> +	 *              001b=Host
> +	 *              010b=Device
> +	 *              011b=Reserved for CMD issuable Device
> +	 * bit [19]   : Reserved
> +	 * bit [31:20]: Device-Specific MAX_BLKLEN
> +	 * bit [39:32]: Device-Specific N_DATA_GAP
> +	 * bit [63:40]: Reserved
> +	 */
> +	cap = cmd.resp[0];
> +	card->uhs2_config.link_minor_rev =
> +				cap & UHS2_DEV_CONFIG_LT_MINOR_MASK;
> +	card->uhs2_config.link_major_rev =
> +				(cap >> UHS2_DEV_CONFIG_LT_MAJOR_POS) &
> +				UHS2_DEV_CONFIG_LT_MAJOR_MASK;
> +	card->uhs2_config.n_fcu =
> +				(cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
> +				UHS2_DEV_CONFIG_N_FCU_MASK;
> +	card->uhs2_config.dev_type =
> +				(cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
> +				UHS2_DEV_CONFIG_DEV_TYPE_MASK;
> +	card->uhs2_config.maxblk_len =
> +				(cap >> UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
> +				UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
> +
> +	cap = cmd.resp[1];
> +	card->uhs2_config.n_data_gap =
> +				cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
> +	if (card->uhs2_config.n_fcu == 0)
> +		card->uhs2_config.n_fcu = 256;
> +
>  	return 0;
>  }
>  
> @@ -98,26 +461,350 @@ static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
>   */
>  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u8 nMinDataGap;
> +	int err;
> +
> +	/*
> +	 * Use Control Write CCMD to set Generic Setting in Configuration Register.
> +	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = Generic Setting Register(CFG_BASE + 008h)
> +	 * - Payload = New contents to be written to Generic Setting Register
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +	/*
> +	 * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
> +	 * defined in UHS-II addendem Ver1.01 are optional.
> +	 */
> +	host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +	card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +
> +	uhs2_cmd.payload[0] = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
> +	uhs2_cmd.payload[1] = 0;
> +	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +
> +	/*
> +	 * There is no payload because per spec, there should be
> +	 * no payload field for read CCMD.
> +	 * Plen is set in arg. Per spec, plen for read CCMD
> +	 * represents the len of read data which is assigned in payload
> +	 * of following RES (p136).
> +	 */
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Use Control Write CCMD to set PHY Setting in Configuration Register.
> +	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = PHY Setting Register(CFG_BASE + 00Ah)
> +	 * - Payload = New contents to be written to PHY Setting Register
> +	 */
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_PHY_SET >> 8);
> +
> +	if (host->uhs2_caps.speed_range == UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
> +		if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> +		    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> +			/* Support HD */
> +			host->ios.timing = MMC_TIMING_UHS2_SPEED_B_HD;
> +			nMinDataGap = 1;
> +		} else {
> +			/* Only support 2L-FD so far */
> +			host->ios.timing = MMC_TIMING_UHS2_SPEED_B;
> +			nMinDataGap = 3;
> +		}
> +		card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
> +	} else {
> +		if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> +		    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> +			/* Support HD */
> +			host->ios.timing = MMC_TIMING_UHS2_SPEED_A_HD;
> +			nMinDataGap = 1;
> +		} else {
> +			/* Only support 2L-FD so far */
> +			host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
> +			nMinDataGap = 3;
> +		}
> +		card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
> +	}
> +
> +	uhs2_cmd.payload[0] =
> +			card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
> +
> +	card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
> +						host->uhs2_caps.n_lss_sync) >> 2) &
> +					   UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +	host->uhs2_caps.n_lss_sync_set = card->uhs2_config.n_lss_sync_set;
> +
> +	card->uhs2_config.n_lss_dir_set = (max(card->uhs2_config.n_lss_dir,
> +					       host->uhs2_caps.n_lss_dir) >> 3) &
> +					  UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +	host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
> +
> +	uhs2_cmd.payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> +			      card->uhs2_config.n_lss_sync_set;
> +	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +
> +	memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +			     UHS2_CFG_WRITE_PHY_SET_RESP_LEN);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	if ((uhs2_cmd.uhs2_resp[2] & 0x80)) {
> +		pr_err("%s: %s: UHS2 CMD not accepted, resp= 0x%x!\n",
> +		       mmc_hostname(host), __func__, uhs2_cmd.uhs2_resp[2]);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Use Control Write CCMD to set LINK/TRAN Setting in Configuration Register.
> +	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = LINK/TRAN Setting Register(CFG_BASE + 00Ch)
> +	 * - Payload = New contents to be written to LINK/TRAN Setting Register
> +	 */
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
> +
> +	if (card->uhs2_config.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
> +		card->uhs2_config.maxblk_len_set = UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
> +	else
> +		card->uhs2_config.maxblk_len_set = min(card->uhs2_config.maxblk_len,
> +						       host->uhs2_caps.maxblk_len);
> +	host->uhs2_caps.maxblk_len_set = card->uhs2_config.maxblk_len_set;
> +
> +	card->uhs2_config.n_fcu_set = min(card->uhs2_config.n_fcu, host->uhs2_caps.n_fcu);
> +	host->uhs2_caps.n_fcu_set = card->uhs2_config.n_fcu_set;
> +
> +	card->uhs2_config.n_data_gap_set = max(nMinDataGap, card->uhs2_config.n_data_gap);
> +	host->uhs2_caps.n_data_gap_set = card->uhs2_config.n_data_gap_set;
> +
> +	host->uhs2_caps.max_retry_set = 3;
> +	card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
> +
> +	uhs2_cmd.payload[0] =
> +			(card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
> +			(card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
> +			(card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
> +	uhs2_cmd.payload[1] = card->uhs2_config.n_data_gap_set;
> +	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Use Control Write CCMD to set Config Completion(payload bit 63) in Generic Setting
> +	 * Register.
> +	 * Header:
> +	 *      - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +	 *      - IOADR = PGeneric Setting Register(CFG_BASE + 008h)
> +	 * Payload:
> +	 *      - bit [63]: Config Completion
> +	 *
> +	 * DLSM transits to Active state immediately when Config Completion is set to 1.
> +	 */
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +	uhs2_cmd.payload[0] = 0;
> +	uhs2_cmd.payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> +	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +
> +	memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +			     UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/* Set host Config Setting registers */
> +	err = host->ops->uhs2_control(host, UHS2_SET_CONFIG);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sd_uhs2_go_dormant(struct mmc_host *host, u32 node_id)
> +{
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	int err;
> +
> +	/* Disable Normal INT */
> +	err = host->ops->uhs2_control(host, UHS2_DISABLE_INT);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
> +	/*
> +	 * Refer to UHS-II Addendum Version 1.02 Figure 6-17 to see GO_DORMANT_STATE CCMD format.
> +	 * Header:
> +	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +	 *      - IOADR = CMD_BASE + 001h
> +	 * Payload:
> +	 *      - bit [7]: HBR(Entry to Hibernate Mode)
> +	 *                 1: Host intends to enter Hibernate mode during Dormant state.
> +	 *                 The default setting is 0 because hibernate is currently not supported.
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			UHS2_NATIVE_CMD_PLEN_4B |
> +			(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_GO_DORMANT_PAYLOAD_LEN, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/* Check Dormant State in Present */
> +	err = host->ops->uhs2_control(host, UHS2_CHECK_DORMANT);
> +	if (err)
> +		return err;
> +
> +	/* Disable UHS2 card clock */
> +	err = host->ops->uhs2_control(host, UHS2_DISABLE_CLK);
> +	if (err)
> +		return err;
> +
> +	/* Restore sd clock */
> +	mmc_delay(5);
> +	err = host->ops->uhs2_control(host, UHS2_ENABLE_CLK);
> +	if (err)
> +		return err;
> +
> +	/* Enable Normal INT */
> +	err = host->ops->uhs2_control(host, UHS2_ENABLE_INT);
> +	if (err)
> +		return err;
> +
> +	/* Detect UHS2 */
> +	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  }
>  
> -/*
> - * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> - * commands/requests to be backwards compatible through the legacy SD protocol.
> - * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
> - * be set through a legacy CMD6. Note that, the power limit that becomes set,
> - * survives a soft reset through the GO_DORMANT_STATE command.
> - */
> -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> +static int sd_uhs2_wait_active_state_cb(void *cb_data, bool *busy)
> +{
> +	struct sd_uhs2_wait_active_state_data *data = cb_data;
> +	struct mmc_host *host = data->host;
> +	struct mmc_command *cmd = data->cmd;
> +	int err;
> +
> +	err = mmc_wait_for_cmd(host, cmd, 0);
> +	if (err)
> +		return err;
> +
> +	if (cmd->resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
> +		*busy = false;
> +	else
> +		*busy = true;
> +
> +	return 0;
> +}
> +
> +static int sd_uhs2_go_dormant_state(struct mmc_host *host, u32 node_id)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	int err;
> +	struct sd_uhs2_wait_active_state_data cb_data = {
> +		.host = host,
> +		.cmd = &cmd
> +	};
> +
> +	err = sd_uhs2_go_dormant(host, node_id);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Use Control Read CCMD to check Config Completion(bit 63) in Generic Setting Register.
> +	 * - Control Read(R/W=0) with 8-Byte payload(PLEN=10b).
> +	 * - IOADR = Generic Setting Register(CFG_BASE + 008h)
> +	 *
> +	 * When UHS-II card been switched to new speed mode, it will set Config Completion to 1.
> +	 */
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_READ |
> +			UHS2_NATIVE_CMD_PLEN_8B |
> +			(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +	err = __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_US,
> +				  UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
> +				  &sd_uhs2_wait_active_state_cb, &cb_data);
> +	if (err) {
> +		pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
>  	return 0;
>  }
>  
> +static void sd_uhs2_remove(struct mmc_host *host)
> +{
> +	mmc_remove_card(host->card);
> +	host->card = NULL;
> +}
> +
>  /*
>   * Allocate the data structure for the mmc_card and run the UHS-II specific
>   * initialization sequence.
>   */
> -static int sd_uhs2_init_card(struct mmc_host *host)
> +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
>  {
>  	struct mmc_card *card;
>  	u32 node_id = 0;
> @@ -131,33 +818,211 @@ static int sd_uhs2_init_card(struct mmc_host *host)
>  	if (err)
>  		return err;
>  
> -	card = mmc_alloc_card(host, &sd_type);
> -	if (IS_ERR(card))
> -		return PTR_ERR(card);
> +	if (oldcard) {
> +		card = oldcard;
> +	} else {
> +		card = mmc_alloc_card(host, &sd_type);
> +		if (IS_ERR(card))
> +			return PTR_ERR(card);
> +	}
>  
>  	card->uhs2_config.node_id = node_id;
>  	card->type = MMC_TYPE_SD;
>  
>  	err = sd_uhs2_config_read(host, card);
>  	if (err)
> -		goto err;
> +		return err;

This leaks card if !oldcard.  Still need:

err:
	if (!oldcard)
		mmc_remove_card(card);


>  
>  	err = sd_uhs2_config_write(host, card);
>  	if (err)
> -		goto err;
> +		return err;

Ditto

>  
>  	host->card = card;
> +	/* If change speed to Range B, need to GO_DORMANT_STATE */
> +	if (host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
> +		err = sd_uhs2_go_dormant_state(host, node_id);
> +		if (err)
> +			return err;

And here host->card is assigned but we have failed.
The other card types do not set host->card until
just before return 0.  Then this can be goto err
instead of return err.

> +	}
> +
> +	host->uhs2_sd_tran = true;
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> + * commands/requests to be backwards compatible through the legacy SD protocol.
> + * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
> + * be set through a legacy CMD6. Note that, the power limit that becomes set,
> + * survives a soft reset through the GO_DORMANT_STATE command.
> + */
> +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
> +			       struct mmc_card *oldcard)
> +{
> +	int err;
> +	u32 cid[4];
> +	u32 ocr;
> +	u32 rocr;
> +	u8  *status;
> +	int ro;
> +
> +	/* Send CMD0 to reset SD card */
> +	err = __mmc_go_idle(host);
> +	if (err)
> +		return err;
> +
> +	mmc_delay(1);
> +
> +	/* Send CMD8 to communicate SD interface operation condition */
> +	err = mmc_send_if_cond(host, host->ocr_avail);
> +	if (err) {
> +		dev_warn(mmc_dev(host), "CMD8 error\n");
> +		goto err;
> +	}
> +
> +	/*
> +	 * Probe SD card working voltage.
> +	 */
> +	err = mmc_send_app_op_cond(host, 0, &ocr);
> +	if (err)
> +		goto err;
> +
> +	card->ocr = ocr;
> +
> +	/*
> +	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
> +	 * these bits as being in-valid and especially also bit7.
> +	 */
> +	ocr &= ~0x7FFF;
> +	rocr = mmc_select_voltage(host, ocr);
> +	/*
> +	 * Some cards have zero value of rocr in UHS-II mode. Assign host's
> +	 * ocr value to rocr.
> +	 */
> +	if (!rocr)
> +		rocr = host->ocr_avail;
> +
> +	rocr |= (SD_OCR_CCS | SD_OCR_XPC);
> +
> +	/* Wait SD power on ready */
> +	ocr = rocr;
> +
> +	err = mmc_send_app_op_cond(host, ocr, &rocr);
> +	if (err)
> +		goto err;
> +
> +	err = mmc_send_cid(host, cid);
> +	if (err)
> +		goto err;
> +
> +	if (oldcard) {
> +		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
> +			pr_debug("%s: Perhaps the card was replaced\n",
> +				 mmc_hostname(host));
> +			return -ENOENT;
> +		}
> +
> +		card = oldcard;
> +	} else {
> +		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> +		mmc_decode_cid(card);
> +	}
> +
> +	/*
> +	 * For native busses:  get card RCA and quit open drain mode.
> +	 */
> +	err = mmc_send_relative_addr(host, &card->rca);
> +	if (err)
> +		goto err;
> +
> +	err = mmc_sd_get_csd(card, false);
> +	if (err)
> +		goto err;
> +
> +	/*
> +	 * Select card, as all following commands rely on that.
> +	 */
> +	err = mmc_select_card(card);
> +	if (err)
> +		goto err;
> +
> +	/*
> +	 * Fetch SCR from card.
> +	 */
> +	err = mmc_app_send_scr(card);
> +	if (err)
> +		goto err;
> +
> +	err = mmc_decode_scr(card);
> +	if (err)
> +		goto err;
> +
> +	/*
> +	 * Switch to high power consumption mode.
> +	 * Even switch failed, sd card can still work at lower power consumption mode, but
> +	 * performance will be lower than high power consumption mode.
> +	 */
> +	status = kmalloc(64, GFP_KERNEL);
> +	if (!status)
> +		return -ENOMEM;
> +
> +	if (!(card->csd.cmdclass & CCC_SWITCH)) {
> +		pr_warn("%s: card lacks mandatory switch function, performance might suffer\n",
> +			mmc_hostname(card->host));
> +	} else {
> +		/* send CMD6 to set Maximum Power Consumption to get better performance */
> +		err = mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1_80W, status);
> +		if (!err)
> +			err = mmc_sd_switch(card, 1, 3, SD4_SET_POWER_LIMIT_1_80W, status);
> +
> +		err = 0;
> +	}
> +
> +	/*
> +	 * Check if read-only switch is active.
> +	 */
> +	ro = mmc_sd_get_ro(host);
> +	if (ro < 0) {
> +		pr_warn("%s: host does not support read-only switch, assuming write-enable\n",
> +			mmc_hostname(host));
> +	} else if (ro > 0) {
> +		mmc_card_set_readonly(card);
> +	}
> +
> +	/*
> +	 * NOTE:
> +	 * Should we read Externsion Register to check power notification feature here?
> +	 */
> +
> +	kfree(status);
> +
>  	return 0;
>  
>  err:
> -	mmc_remove_card(card);
>  	return err;
>  }
>  
> -static void sd_uhs2_remove(struct mmc_host *host)
> +static int sd_uhs2_reinit(struct mmc_host *host)
>  {
> -	mmc_remove_card(host->card);
> -	host->card = NULL;
> +	struct mmc_card *card = host->card;
> +	int err;
> +
> +	sd_uhs2_power_up(host);
> +	err = sd_uhs2_phy_init(host);
> +	if (err)
> +		return err;
> +
> +	err = sd_uhs2_init_card(host, card);
> +	if (err)
> +		return err;
> +
> +	err = sd_uhs2_legacy_init(host, card, card);
> +	if (err)
> +		return err;
> +
> +	return err;
>  }
>  
>  static int sd_uhs2_alive(struct mmc_host *host)
> @@ -183,34 +1048,188 @@ static void sd_uhs2_detect(struct mmc_host *host)
>  	}
>  }
>  
> +static int _sd_uhs2_suspend(struct mmc_host *host)
> +{
> +	struct mmc_card *card = host->card;
> +	int err = 0;
> +
> +	mmc_claim_host(host);
> +
> +	if (mmc_card_suspended(card))
> +		goto out;
> +
> +	if (sd_can_poweroff_notify(card))
> +		err = sd_poweroff_notify(card);
> +
> +	if (!err) {
> +		sd_uhs2_power_off(host);

MMC_TIMING_UHS2_SPEED_A is also checked by mmc_card_uhs2()
which is used a lot.

Are you sure we don't need it here for the host controller's
suspend / resume? i.e.

		host->ios.timing = MMC_TIMING_UHS2_SPEED_A;

> +		mmc_card_set_suspended(card);
> +	}
> +
> +out:
> +	mmc_release_host(host);
> +	return err;
> +}
> +
> +/*
> + * Callback for suspend
> + */
>  static int sd_uhs2_suspend(struct mmc_host *host)
>  {
> -	return 0;
> +	int err;
> +
> +	err = _sd_uhs2_suspend(host);
> +	if (!err) {
> +		pm_runtime_disable(&host->card->dev);
> +		pm_runtime_set_suspended(&host->card->dev);
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * This function tries to determine if the same card is still present
> + * and, if so, restore all state to it.
> + */
> +static int _mmc_sd_uhs2_resume(struct mmc_host *host)
> +{
> +	int err = 0;
> +
> +	mmc_claim_host(host);
> +
> +	if (!mmc_card_suspended(host->card))
> +		goto out;
> +
> +	/* Power up UHS2 SD card and re-initialize it. */
> +	err = sd_uhs2_reinit(host);
> +	mmc_card_clr_suspended(host->card);
> +
> +out:
> +	mmc_release_host(host);
> +	return err;
>  }
>  
> +/*
> + * Callback for resume
> + */
>  static int sd_uhs2_resume(struct mmc_host *host)
>  {
> +	pm_runtime_enable(&host->card->dev);
>  	return 0;
>  }
>  
> +/*
> + * Callback for runtime_suspend.
> + */
>  static int sd_uhs2_runtime_suspend(struct mmc_host *host)
>  {
> -	return 0;
> +	int err;
> +
> +	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> +		return 0;
> +
> +	err = _sd_uhs2_suspend(host);
> +	if (err)
> +		pr_err("%s: error %d doing aggressive suspend\n", mmc_hostname(host), err);
> +
> +	return err;
>  }
>  
>  static int sd_uhs2_runtime_resume(struct mmc_host *host)
>  {
> -	return 0;
> +	int err;
> +
> +	err = _mmc_sd_uhs2_resume(host);
> +	if (err && err != -ENOMEDIUM)
> +		pr_err("%s: error %d doing runtime resume\n", mmc_hostname(host), err);
> +
> +	return err;
>  }
>  
> -static int sd_uhs2_shutdown(struct mmc_host *host)
> +static int sd_uhs2_hw_reset(struct mmc_host *host)
>  {
> -	return 0;
> +	int err;
> +
> +	sd_uhs2_power_off(host);
> +	/* Wait at least 1 ms according to SD spec */
> +	mmc_delay(1);
> +	sd_uhs2_power_up(host);
> +
> +	err = sd_uhs2_reinit(host);
> +
> +	return err;
>  }
>  
> -static int sd_uhs2_hw_reset(struct mmc_host *host)
> +/*
> + * mmc_uhs2_prepare_cmd - prepare for SD command packet
> + * @host:	MMC host
> + * @mrq:	MMC request
> + *
> + * Initialize and fill in a header and a payload of SD command packet.
> + * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
> + * advance.
> + *
> + * Return:	0 on success, non-zero error on failure
> + */
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -	return 0;
> +	struct mmc_command *cmd;
> +	struct uhs2_command *uhs2_cmd;
> +	u8 plen;
> +
> +	cmd = mrq->cmd;
> +	cmd->uhs2_cmd = &mrq->uhs2_cmd;
> +	uhs2_cmd = cmd->uhs2_cmd;
> +	uhs2_cmd->header = host->card->uhs2_config.node_id;
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +		uhs2_cmd->header |= UHS2_PACKET_TYPE_DCMD;
> +	else
> +		uhs2_cmd->header |= UHS2_PACKET_TYPE_CCMD;
> +
> +	uhs2_cmd->arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
> +	if (host->uhs2_app_cmd) {
> +		uhs2_cmd->arg |= UHS2_SD_CMD_APP;
> +		host->uhs2_app_cmd = false;
> +	}
> +
> +	/*
> +	 * UHS-II Addendum 7.2.1.2
> +	 * Host may set DM to 1 for DCMD which supports multi-block read/write regardless of
> +	 * data transfer length (e.g., CMD18, CMD25). Otherwise, it shall not set DM to 1.
> +	 * (e.g., CMD6, CMD17, CMD24). These rules are also applied to other multi-block read/write
> +	 * commands defined in other Part of SD specifications (for example, Host may set DM to 1
> +	 * for ACMD18 or ACMD25).
> +	 */
> +	if (mmc_op_multi(cmd->opcode))
> +		cmd->uhs2_cmd->tmode_half_duplex = mmc_card_uhs2_hd_mode(host);
> +	else
> +		cmd->uhs2_cmd->tmode_half_duplex = 0;
> +
> +	uhs2_cmd = cmd->uhs2_cmd;
> +	plen = 2; /* at the maximum */
> +
> +	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
> +	    cmd->uhs2_cmd->tmode_half_duplex) {
> +		if (mmc_card_uhs2_hd_mode(host))
> +			uhs2_cmd->arg |= UHS2_DCMD_2L_HD_MODE;
> +
> +		uhs2_cmd->arg |= UHS2_DCMD_LM_TLEN_EXIST;
> +
> +		if (cmd->data->blocks == 1 &&
> +		    cmd->data->blksz != 512 &&
> +		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
> +		    cmd->opcode != MMC_WRITE_BLOCK) {
> +			uhs2_cmd->arg |= UHS2_DCMD_TLUM_BYTE_MODE;
> +			uhs2_cmd->payload[1] = cpu_to_be32(cmd->data->blksz);
> +		} else {
> +			uhs2_cmd->payload[1] = cpu_to_be32(cmd->data->blocks);
> +		}
> +	} else {
> +		plen = 1;
> +	}
> +
> +	uhs2_cmd->payload[0] = cpu_to_be32(cmd->arg);
> +	sd_uhs2_cmd_assemble(cmd, uhs2_cmd, plen, 0);
>  }
>  
>  static const struct mmc_bus_ops sd_uhs2_ops = {
> @@ -221,7 +1240,7 @@ static const struct mmc_bus_ops sd_uhs2_ops = {
>  	.resume = sd_uhs2_resume,
>  	.runtime_suspend = sd_uhs2_runtime_suspend,
>  	.runtime_resume = sd_uhs2_runtime_resume,
> -	.shutdown = sd_uhs2_shutdown,
> +	.shutdown = sd_uhs2_suspend,
>  	.hw_reset = sd_uhs2_hw_reset,
>  };
>  
> @@ -237,11 +1256,11 @@ static int sd_uhs2_attach(struct mmc_host *host)
>  	if (err)
>  		goto err;
>  
> -	err = sd_uhs2_init_card(host);
> +	err = sd_uhs2_init_card(host, NULL);
>  	if (err)
>  		goto err;
>  
> -	err = sd_uhs2_legacy_init(host, host->card);
> +	err = sd_uhs2_legacy_init(host, host->card, NULL);
>  	if (err)
>  		goto err;
>  
> @@ -254,21 +1273,31 @@ static int sd_uhs2_attach(struct mmc_host *host)
>  		goto remove_card;
>  
>  	mmc_claim_host(host);
> +
>  	return 0;
>  
>  remove_card:
> -	mmc_remove_card(host->card);
> -	host->card = NULL;
> +	sd_uhs2_remove(host);
>  	mmc_claim_host(host);
> -	mmc_detach_bus(host);
> +
>  err:
> +	mmc_detach_bus(host);
>  	sd_uhs2_power_off(host);
>  	return err;
>  }
>  
> +/**
> + * mmc_attach_sd_uhs2 - select UHS2 interface
> + * @host: MMC host
> + *
> + * Try to select UHS2 interface and initialize the bus for a given
> + * frequency, @freq.
> + *
> + * Return:	0 on success, non-zero error on failure
> + */
>  int mmc_attach_sd_uhs2(struct mmc_host *host)
>  {
> -	int i, err = 0;
> +	int i, err;
>  
>  	if (!(host->caps2 & MMC_CAP2_SD_UHS2))
>  		return -EOPNOTSUPP;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index a890a71288ef..56972bd78462 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -11,6 +11,20 @@
>  struct mmc_data;
>  struct mmc_request;
>  
> +#define UHS2_MAX_PAYLOAD_LEN 2
> +#define UHS2_MAX_RESP_LEN 20
> +
> +struct uhs2_command {
> +	u16	header;
> +	u16	arg;
> +	__be32	payload[UHS2_MAX_PAYLOAD_LEN];
> +	u8	payload_len;
> +	u8	packet_len;
> +	u8	tmode_half_duplex;
> +	u8	uhs2_resp[UHS2_MAX_RESP_LEN];	/* UHS2 native cmd resp */
> +	u8	uhs2_resp_len;			/* UHS2 native cmd resp len */
> +};
> +
>  struct mmc_command {
>  	u32			opcode;
>  	u32			arg;
> @@ -97,6 +111,8 @@ struct mmc_command {
>  	struct mmc_data		*data;		/* data segment associated with cmd */
>  	struct mmc_request	*mrq;		/* associated request */
>  
> +	struct uhs2_command	*uhs2_cmd;	/* UHS2 command */
> +
>  	/* for SDUC */
>  	bool has_ext_addr;
>  	u8 ext_addr;
> @@ -158,6 +174,7 @@ struct mmc_request {
>  	const struct bio_crypt_ctx *crypto_ctx;
>  	int			crypto_key_slot;
>  #endif
> +	struct uhs2_command	uhs2_cmd;
>  };
>  
>  struct mmc_card;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0980d06ed419..b4c00dbcaf0b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -127,6 +127,13 @@ struct sd_uhs2_caps {
>  };
>  
>  enum sd_uhs2_operation {
> +	UHS2_PHY_INIT = 0,
> +	UHS2_SET_CONFIG,
> +	UHS2_ENABLE_INT,
> +	UHS2_DISABLE_INT,
> +	UHS2_ENABLE_CLK,
> +	UHS2_DISABLE_CLK,
> +	UHS2_CHECK_DORMANT,
>  	UHS2_SET_IOS,
>  };
>  
> @@ -453,6 +460,8 @@ struct mmc_host {
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
>  
> +	bool			uhs2_sd_tran;
> +	bool			uhs2_app_cmd;	/* Host UHS-II APP Command */
>  	struct sd_uhs2_caps	uhs2_caps;	/* Host UHS-II capabilities */
>  
>  	int			fixed_drv_type;	/* fixed driver type for non-removable media */
> @@ -714,6 +723,12 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
>  	host->err_stats[stat] += 1;
>  }
>  
> +static inline int mmc_card_uhs2_hd_mode(struct mmc_host *host)
> +{
> +	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
> +}
> +
>  int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
>  		u8 value, u8 *resp);
>  int mmc_send_status(struct mmc_card *card, u32 *status);


