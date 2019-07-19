Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E996ECC7
	for <lists+linux-mmc@lfdr.de>; Sat, 20 Jul 2019 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfGSXgM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Jul 2019 19:36:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43136 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfGSXgM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jul 2019 19:36:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so15084050pgv.10
        for <linux-mmc@vger.kernel.org>; Fri, 19 Jul 2019 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adPQzI1v5diG916E3ftdRP7KVUpoq7ni2PbSErONVno=;
        b=G3cOINU5IIalyfSzoeJGzYHjbbTayjz7uKTmRzNWMjmloTNLmboShFlXotMdaNFDe8
         LAdBksnVHUYSUdjAjmD3cROKn41n3SKUCER9oghvqyO+rKroqQj7uNodSK+RT3bUNB1S
         DXoVHjQtNrBXRF4FRkraXhiN3WesLyTqJ7RQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adPQzI1v5diG916E3ftdRP7KVUpoq7ni2PbSErONVno=;
        b=AAS+Ir7JaSJyo1LQMpZ12Zayul1hPkdZnbIf8v7aR+P59gHyLnYkBxNnbYHomFfb/T
         kwzLGIavbPP1MN2JU/6u9UVli6Gui0VGylLh/T/8ssZuN/wXH/kVYAnrfBjV9zP3oqYS
         8DnGdF5cfFhfgXhsbKnv2tYnqKvN1R4bhhx3Tdjq1Y4tBSBb5CH21gxAKfSTklW+gW+W
         tMqV3xM22GNfGPdW0auFtSJJrA8vWAH5Br5BvmV/XonIRiUecVRD9Utwuu/5PIrvOC9J
         O0ZPt/WCgVJJqpvBNDiODyr6Vh2tOKUyl6oxOQkc+rDZpd+m2Llp4Bm0x5npN1dh3+pP
         Vntw==
X-Gm-Message-State: APjAAAVzhIBEGcHiV+CTsDZyZmZtTUMKVtK7CBYFEGiCZDdzxQd6RDKy
        9+bEfKDoABj0BHFKJWaoyR1CCw==
X-Google-Smtp-Source: APXvYqxbqPCgcMawQkjn4LpCVpIZIiiIhPeZYJ2X7r56FNvFvPhSCu3KoIIFPtYjLuP6gyd08GrXzQ==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr56615815pgj.4.1563579371281;
        Fri, 19 Jul 2019 16:36:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id a21sm38313759pfi.27.2019.07.19.16.36.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 16:36:09 -0700 (PDT)
Date:   Fri, 19 Jul 2019 16:36:06 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        linux-mmc@vger.kernel.org, davem@davemloft.net,
        Xinming Hu <huxinming820@gmail.com>,
        linux-kernel@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 2/2] mwifiex: Make use of the new sdio_trigger_replug()
 API to reset
Message-ID: <20190719233605.GA66171@google.com>
References: <20190716164209.62320-1-dianders@chromium.org>
 <20190716164209.62320-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716164209.62320-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Doug,

On Tue, Jul 16, 2019 at 09:42:09AM -0700, Doug Anderson wrote:
> As described in the patch ("mmc: core: Add sdio_trigger_replug()
> API"), the current mwifiex_sdio_card_reset() is broken in the cases
> where we're running Bluetooth on a second SDIO func on the same card
> as WiFi.  The problem goes away if we just use the
> sdio_trigger_replug() API call.

I'm unfortunately not a good evaluator of SDIO/MMC stuff, so I'll mostly
leave that to others and assume that the "replug" description is pretty
much all I need to know.

> NOTE: Even though with this new solution there is less of a reason to
> do our work from a workqueue (the unplug / plug mechanism we're using
> is possible for a human to perform at any time so the stack is
> supposed to handle it without it needing to be called from a special
> context), we still need a workqueue because the Marvell reset function
> could called from a context where sleeping is invalid and thus we
> can't claim the host.  One example is Marvell's wakeup_timer_fn().
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 24c041dad9f6..f77ad2615f08 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -2218,14 +2218,6 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
>  {
>  	struct sdio_mmc_card *card = adapter->card;
>  	struct sdio_func *func = card->func;
> -	int ret;
> -
> -	mwifiex_shutdown_sw(adapter);

I'm very mildly unhappy to see this driver diverge from the PCIe one
again, but the only way it makes sense to do things the same is if there
is such thing as a "function level reset" for SDIO (i.e., doesn't also
kill the Bluetooth function). But it appears we don't really have such a
thing.

> -
> -	/* power cycle the adapter */
> -	sdio_claim_host(func);
> -	mmc_hw_reset(func->card->host);
> -	sdio_release_host(func);
>  
>  	/* Previous save_adapter won't be valid after this. We will cancel

^^^ FTR, the "save_adapter" note was already obsolete as of

  cc75c577806a mwifiex: get rid of global save_adapter and sdio_work

but the clear_bit() calls were (before this patch) still useful for
other reasons.

>  	 * pending work requests.
> @@ -2233,9 +2225,9 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
>  	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
>  	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);

But now, I don't think you need these clear_bit() calls any more --
you're totally destroying the card and its workqueue on remove(). (And
anyway, MWIFIEX_IFACE_WORK_CARD_RESET was just cleared by your caller.)

>  
> -	ret = mwifiex_reinit_sw(adapter);
> -	if (ret)
> -		dev_err(&func->dev, "reinit failed: %d\n", ret);
> +	sdio_claim_host(func);
> +	sdio_trigger_replug(func);
> +	sdio_release_host(func);

And...we're approximately back to where we were 4 years ago :)

commit b4336a282db86b298b70563f8ed51782b36b772c
Author: Andreas Fenkart <afenkart@gmail.com>
Date:   Thu Jul 16 18:50:01 2015 +0200

    mwifiex: sdio: reset adapter using mmc_hw_reset

Anyway, assuming the "function reset" thing isn't workable, and you drop
the clear_bit() stuff, I think this is fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  }
>  
>  /* This function read/write firmware */
> -- 
> 2.22.0.510.g264f2c817a-goog
> 
