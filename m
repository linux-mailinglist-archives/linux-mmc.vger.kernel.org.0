Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595871AE6DF
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Apr 2020 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgDQUjC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Apr 2020 16:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgDQUjC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Apr 2020 16:39:02 -0400
Received: from ROU-LT-M43218B.mchp-main.com (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1597120656;
        Fri, 17 Apr 2020 20:38:54 +0000 (UTC)
Date:   Fri, 17 Apr 2020 22:39:22 +0200
From:   ludovic.desroches@microchip.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 01/19] mmc: atmel-mci: Keep timer enabled when queuing a
 next request
Message-ID: <20200417203922.j2gwgxvqo5fiwnwk@ROU-LT-M43218B.mchp-main.com>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-2-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:13:55PM +0200, Ulf Hansson wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> When atmci_request_end() is about to finish a request for one slot, there
> is a possibility that there is new request queued for another slot. If this
> turns out to be the case, the new request is started and the timer is
> re-programmed for it.
> 
> Although, a few lines below in atmci_request_end(), this timer becomes
> deleted, likely corresponding to the other recently completed request. This
> looks wrong, so let's fix it.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Nice catch.

Thanks

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index aeaaa5314924..0472df8391b5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1557,6 +1557,8 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
> 
>         WARN_ON(host->cmd || host->data);
> 
> +       del_timer(&host->timer);
> +
>         /*
>          * Update the MMC clock rate if necessary. This may be
>          * necessary if set_ios() is called when a different slot is
> @@ -1583,8 +1585,6 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
>                 host->state = STATE_IDLE;
>         }
> 
> -       del_timer(&host->timer);
> -
>         spin_unlock(&host->lock);
>         mmc_request_done(prev_mmc, mrq);
>         spin_lock(&host->lock);
> --
> 2.20.1
> 
