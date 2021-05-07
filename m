Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC66F375E93
	for <lists+linux-mmc@lfdr.de>; Fri,  7 May 2021 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhEGBxs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 6 May 2021 21:53:48 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:39754 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhEGBxr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 21:53:47 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 23DBC1FAB;
        Fri,  7 May 2021 09:52:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31917T139684271351552S1620352363371334_;
        Fri, 07 May 2021 09:52:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c3c23211b67c3297beb40161e855acda>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <dcea3e14-4669-60ad-992f-a588a3c8c20f@rock-chips.com>
Date:   Fri, 7 May 2021 09:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] mmc: core: Enable eMMC sleep commands to use HW
 busy polling
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-6-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-6-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2021/5/5 0:12, Ulf Hansson wrote:
> After the eMMC sleep command (CMD5) has been sent, the card start signals
> busy on the DAT0 line, which can be monitored to understand when it's
> allowed to proceed to power off the VCC regulator.
> 
> When MMC_CAP_WAIT_WHILE_BUSY isn't supported by the host the DAT0 line
> isn't being monitored for busy completion, but instead we are waiting a
> fixed period of time. The time corresponds to the sleep timeout that is
> specified in the EXT_CSD register of the eMMC card. This is many cases
> suboptimal, as the timeout corresponds to the worst case scenario.
> 
> To improve the situation add support for HW busy polling through the
> ->card_busy() host ops, when the host supports this.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/mmc.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 63a7bd0b239c..13074aa1f605 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1905,6 +1905,14 @@ static int mmc_can_sleep(struct mmc_card *card)
>   	return card->ext_csd.rev >= 3;
>   }
>   
> +static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
> +{
> +	struct mmc_host *host = cb_data;
> +
> +	*busy = host->ops->card_busy(host);
> +	return 0;
> +}
> +
>   static int mmc_sleep(struct mmc_host *host)
>   {
>   	struct mmc_command cmd = {};
> @@ -1930,13 +1938,20 @@ static int mmc_sleep(struct mmc_host *host)
>   		goto out_release;
>   
>   	/*
> -	 * If the host does not wait while the card signals busy, then we will
> -	 * will have to wait the sleep/awake timeout.  Note, we cannot use the
> -	 * SEND_STATUS command to poll the status because that command (and most
> -	 * others) is invalid while the card sleeps.
> +	 * If the host does not wait while the card signals busy, then we can
> +	 * try to poll, but only if the host supports HW polling, as the
> +	 * SEND_STATUS cmd is not allowed. If we can't poll, then we simply need
> +	 * to wait the sleep/awake timeout.
>   	 */
> -	if (!use_r1b_resp || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
> +	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY && use_r1b_resp)
> +		goto out_release;
> +
> +	if (!host->ops->card_busy) {
>   		mmc_delay(timeout_ms);
> +		goto out_release;
> +	}
> +
> +	err = __mmc_poll_for_busy(card, timeout_ms, &mmc_sleep_busy_cb, host);
>   
>   out_release:
>   	mmc_retune_release(host);
> 


