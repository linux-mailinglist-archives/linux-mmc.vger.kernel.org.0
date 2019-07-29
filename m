Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0595D7910E
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Jul 2019 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfG2Qfn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Jul 2019 12:35:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32868 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbfG2Qfn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jul 2019 12:35:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so28312366pfq.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jul 2019 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IEddiYi3k/QkBC5cxfQW5fAN4XjjJLsCvTR0ynzn9xQ=;
        b=PFOOf1pY2vYwMTBzCHhJbt6J3OJX9kEF5fPBmfilOEVHC7yfX6C8vdygMvSnG/ORXJ
         +ubu/CTvk6N9l3Hpyyd3g4nctPRzdxe6Wq1t3Eb4eDZho2NwHODoNKaBeWPkSiWF672+
         wwNrEzYzu+TH35C5nW4a1HvCbhiXC4sOnUUAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IEddiYi3k/QkBC5cxfQW5fAN4XjjJLsCvTR0ynzn9xQ=;
        b=KQysglpHvPy8bMiPC9JK11RYdlR27+9zbx6cgQngco0yZ955mVLmJjrda6URyRI5ad
         hbO60qSZM/nld1JsktoHeLdnfxzu+moP8ep2p1qlHPuGjCU3Q8XcaaW5GZopB2hj6pKF
         EvG9Ee66b/mHGm6UzD1lJkMOOo8mRJkI0oWChn8vVnNi3YGOozG+/4zzfdOVCPprTWou
         WCRa7aaOqrX+JKiG6EilLC6tzzw+BUamiIobZ7D6xgbdVKVvym6HgDtdllstxQu50avT
         n7trwVfhIThw+D/keSr8NpxG2/JqfUHkA1+KX2oJaAvqeIHaZQXxywILnFMVABNxifmv
         sHAA==
X-Gm-Message-State: APjAAAWf69DhMMhIlTBhjnR94a1g5jrjD6DKVJsx3LErcJ6BekylPr67
        ot99puZlWie6vwk5errdVp03sA==
X-Google-Smtp-Source: APXvYqzgPp1ai8L1U1DHi9sD7NWNDjDbn+/ShCDM00cHu0bZrIrBVGOukCtp85AANTBOMAzU8Deeyg==
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr37907100pfn.185.1564418142347;
        Mon, 29 Jul 2019 09:35:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l26sm63883324pgb.90.2019.07.29.09.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:35:41 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:35:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <201907290935.2B95CBC@keescook>
References: <20190729000123.GA23902@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729000123.GA23902@embeddedor>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jul 28, 2019 at 07:01:23PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mmc/host/atmel-mci.c: In function 'atmci_get_cap':
> drivers/mmc/host/atmel-mci.c:2415:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_odd_clk_div = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2416:2: note: here
>   case 0x400:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2422:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_highspeed = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2423:2: note: here
>   case 0x200:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.need_notbusy_for_read_ops = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2427:2: note: here
>   case 0x100:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mmc/host/atmel-mci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9ee0bc0ce6d0..c26fbe5f2222 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
>  	case 0x600:
>  	case 0x500:
>  		host->caps.has_odd_clk_div = 1;
> +		/* Fall through */
>  	case 0x400:
>  	case 0x300:
>  		host->caps.has_dma_conf_reg = 1;
> @@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
>  		host->caps.has_cfg_reg = 1;
>  		host->caps.has_cstor_reg = 1;
>  		host->caps.has_highspeed = 1;
> +		/* Fall through */
>  	case 0x200:
>  		host->caps.has_rwproof = 1;
>  		host->caps.need_blksz_mul_4 = 0;
>  		host->caps.need_notbusy_for_read_ops = 1;
> +		/* Fall through */
>  	case 0x100:
>  		host->caps.has_bad_data_ordering = 0;
>  		host->caps.need_reset_after_xfer = 0;
> +		/* Fall through */
>  	case 0x0:
>  		break;
>  	default:
> -- 
> 2.22.0
> 

-- 
Kees Cook
