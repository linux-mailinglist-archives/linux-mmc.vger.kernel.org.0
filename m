Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66041F12
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407172AbfFLIaR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 04:30:17 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37985 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405127AbfFLIaR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2019 04:30:17 -0400
X-Originating-IP: 80.12.27.70
Received: from localhost (unknown [80.12.27.70])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0C0C2E0015;
        Wed, 12 Jun 2019 08:30:10 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:30:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/4] mmc: host: atmel-mci: no need to check return value
 of debugfs_create functions
Message-ID: <20190612083008.GN25472@piout.net>
References: <20190612082531.2652-1-gregkh@linuxfoundation.org>
 <20190612082531.2652-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612082531.2652-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/06/2019 10:25:29+0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 38 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 735aa5871358..e1f10c3fa144 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -579,42 +579,18 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>  	struct mmc_host		*mmc = slot->mmc;
>  	struct atmel_mci	*host = slot->host;
>  	struct dentry		*root;
> -	struct dentry		*node;
>  
>  	root = mmc->debugfs_root;
>  	if (!root)
>  		return;
>  
> -	node = debugfs_create_file("regs", S_IRUSR, root, host,
> -				   &atmci_regs_fops);
> -	if (IS_ERR(node))
> -		return;
> -	if (!node)
> -		goto err;
> -
> -	node = debugfs_create_file("req", S_IRUSR, root, slot,
> -				   &atmci_req_fops);
> -	if (!node)
> -		goto err;
> -
> -	node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
> -	if (!node)
> -		goto err;
> -
> -	node = debugfs_create_x32("pending_events", S_IRUSR, root,
> -				     (u32 *)&host->pending_events);
> -	if (!node)
> -		goto err;
> -
> -	node = debugfs_create_x32("completed_events", S_IRUSR, root,
> -				     (u32 *)&host->completed_events);
> -	if (!node)
> -		goto err;
> -
> -	return;
> -
> -err:
> -	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
> +	debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
> +	debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> +	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
> +	debugfs_create_x32("pending_events", S_IRUSR, root,
> +			   (u32 *)&host->pending_events);
> +	debugfs_create_x32("completed_events", S_IRUSR, root,
> +			   (u32 *)&host->completed_events);
>  }
>  
>  #if defined(CONFIG_OF)
> -- 
> 2.22.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
