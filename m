Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4C3F2A81
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Aug 2021 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhHTLEV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 Aug 2021 07:04:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:45636 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239799AbhHTLES (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216753593"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216753593"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="680059878"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 04:03:38 -0700
Subject: Re: [PATCH] mmc: sdhci: correct the tuning command handle for PIO
 mode
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com
References: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <76af88e2-d068-dafc-9b17-cd590b3f8953@intel.com>
Date:   Fri, 20 Aug 2021 14:04:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/08/21 3:34 pm, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> If sdhci use PIO mode, and use mmc_send_tuning() to send the
> tuning command, system will stuck because of the storm irq
> of sdhci. For PIO mode, use mmc_send_tuning(), it will trigger
> buffer_read_ready interrupt and data transfer complete interrupt.
> In current code logic, it will directly return in sdhci_data_irq,
> can not call the sdhci_transfer_pio(). So the buffer_read_ready
> interrupt storm happen. So for standard tuning method, need to
> excluse this case.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aba6e10b8605..acee54b368b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3278,8 +3278,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	u32 command;
>  
> -	/* CMD19 generates _only_ Buffer Read Ready interrupt */
> -	if (intmask & SDHCI_INT_DATA_AVAIL) {
> +	/*
> +	 * CMD19 generates _only_ Buffer Read Ready interrupt if
> +	 * use sdhci_send_tuning.
> +	 * Need to exclude this case: PIO mode and use mmc_send_tuning,
> +	 * If not, sdhci_transfer_pio will never be called, make the
> +	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
> +	 */
> +	if ((intmask & SDHCI_INT_DATA_AVAIL) && (!host->data)) {
>  		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
>  		if (command == MMC_SEND_TUNING_BLOCK ||
>  		    command == MMC_SEND_TUNING_BLOCK_HS200) {
> 

