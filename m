Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691A0A97A4
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfIEAey (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 20:34:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIEAey (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 20:34:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so381089pgn.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3hhWs+PTGeq58oRzKZmUr+6w+3dqicZgsi1QthEaIw=;
        b=IZs55P3RkKTRD4VH32QtaqPdQVj70FNqRrZvi+5jesntYn5kgNaMrgrMgsr39O5XSR
         HVxAw2UOkp2y/+lmGClMNKZHYGc5kFZuSh77JST86gWV8YbTEQLrS1sVqV/KyDnBgvZJ
         EqS4oc48gCSaK4FvEuggAwj0/gJfQNqlHyOsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3hhWs+PTGeq58oRzKZmUr+6w+3dqicZgsi1QthEaIw=;
        b=Z5wxvDwp4AzaaEW9SqiTaVphbq6RqZIB1L/COvfu0T+esxc4HFaR8A3oPf7y/YFhZk
         DKAUbU4v0HHCWb3+O0hQQOapO/tnE0JkGhbnnXtREHP3/vdvDcSrPsNecoev3KKVR0JL
         6nJhvrcg9mUYZXMqoiS22db/yELNogZEm7hMlD69rymS80vitOL2qn+C5l3p8Bw2sfyq
         l+iodyjgmF27MsiuG87rL97z+C6IpmOLO1qndQcTrCzul01azeLnYxMzVFV8zSchNB/K
         Hvfx9k6ZVgh+PLDbpv0R6Ob8qLJ90lmiWqDDNwvHqxdo4jRkZRA22G466OAUiDYUw0He
         npSg==
X-Gm-Message-State: APjAAAXhgQei1m8RS8hU0AeJ5UUWAU6sM+1NT3OW2cE8FdOcg0F/V2Pg
        yx4OarNTS+el2TXOWI+y4407Cg==
X-Google-Smtp-Source: APXvYqyGwxEI6MMRywn3S/p8pKGvr2pX76xPDCLdMZAhzGXKMzEb5BTg4saZM5SEE3zz9hL5TEECxQ==
X-Received: by 2002:a63:fa11:: with SMTP id y17mr708616pgh.267.1567643693967;
        Wed, 04 Sep 2019 17:34:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w26sm252325pfi.140.2019.09.04.17.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 17:34:53 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:34:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for
 MMC_CAP2_SDIO_IRQ_NOTHREAD
Message-ID: <20190905003451.GI70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-6-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:01PM +0200, Ulf Hansson wrote:
> In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> SDIO func's >irq_handler() callback.
> 
> To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> let's set the flag from inside sdio_signal_irq(), rather from
> sdio_run_irqs(). Moreover, let's also reset the flag when the SDIO IRQ have
> been properly processed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index f75043266984..0962a4357d54 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>  	struct mmc_card *card = host->card;
>  	int i, ret, count;
> +	bool sdio_irq_pending = host->sdio_irq_pending;
>  	unsigned char pending;
>  	struct sdio_func *func;
>  
> @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  	if (mmc_card_suspended(card))
>  		return 0;
>  
> +	/* Clear the flag to indicate that we have processed the IRQ. */
> +	host->sdio_irq_pending = false;
> +

It's not entirely true that we have processed the IRQ,
the sdio_get_pending_irqs() below could fail and we'd return. However
I guess if it comes to that we are in a pretty bad shape already and
the value of the flag doesn't really matter.

>  	/*
>  	 * Optimization, if there is only 1 function interrupt registered
>  	 * and we know an IRQ was signaled then call irq handler directly.
>  	 * Otherwise do the full probe.
>  	 */
>  	func = card->sdio_single_irq;
> -	if (func && host->sdio_irq_pending) {
> +	if (func && sdio_irq_pending) {
>  		func->irq_handler(func);
>  		return 1;
>  	}
> @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
>  {
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
> -		host->sdio_irq_pending = true;
>  		process_sdio_pending_irqs(host);
>  		if (host->ops->ack_sdio_irq)
>  			host->ops->ack_sdio_irq(host);
> @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
>  
>  void sdio_signal_irq(struct mmc_host *host)
>  {
> +	host->sdio_irq_pending = true;
>  	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
>  		if (ret)
>  			break;
>  		ret = process_sdio_pending_irqs(host);
> -		host->sdio_irq_pending = false;
>  		mmc_release_host(host);
>  
>  		/*

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
