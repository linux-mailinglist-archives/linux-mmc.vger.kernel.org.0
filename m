Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E39D7FD58
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfHBPRA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 11:17:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46694 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391406AbfHBPRA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 11:17:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id r3so51518515vsr.13
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/2TKAA2eHey/AJMPKbULt2KgA6zmWugOWMLV/zLdIQ=;
        b=MOnyX+ENZwETJxfcOsqblof0a5+oHsd548wkWcaufdcOARpVP6mirV4rDTs4r7nNNz
         Q9PYFbuq0inCJjPWfvp39vJaHis4Nu+BLljBFrXmXlRwNDQQgCs69XrFlq414pfJRcaX
         ut5O1R9I3YkEUZ/nYExGXOuKC2JyQ/8GLhadgne5IeTAfdTLisHwcSrN5RuUDDyORs8e
         uviMnn0lHnuUeweHEmQg3w2gWVpi8/DCOGJ8MtKbxy0FKVf/WycngUTDR9yiAbo5zRcQ
         nO2R/Nx/Idv316NUzQqBsUUwRnfk/xMUvir/CPfTu7KmcA67Fw6b7kl6/iRqnN7j78zO
         CB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/2TKAA2eHey/AJMPKbULt2KgA6zmWugOWMLV/zLdIQ=;
        b=uZznFKaTVHZzLy+6YZm9ucqWfKTbX7dhbVBcsXZtzkyMCYd8stYDoLOHcg0AV0Tj8x
         vuHCEkMd8hglhFGaszUKAHlo1FrtHvW7szTURKkegkNwcSJ2lwgRysfKGaR8sLIEmhxA
         +2y72NYpqlq0jhrvk4kwgV6GhAtVgxNobn76LPtgbKEPiQRxZkW0jOYQ8zX2RgB+3NXE
         ONk0BqrgPxuodCJ/JA6DNL7LO5zkAd2crTSW7yZ8smMJaRtBorhRfeaEjk+fa8NaEbQO
         T2hH5XenvZarDBwmMkt12ySIzaJKJKUeDjUgBl1eZa9BwWyjk4jGOUJQEdstzclEVm0X
         SB8Q==
X-Gm-Message-State: APjAAAWv6pkIgaMBKZ4vPmQhvzDGML6l956sKobgCBAA6EV2eBbgATgI
        tEj7QqxczeTilodXnV8XLH5O1x9F5n5G0myqoKxWNg==
X-Google-Smtp-Source: APXvYqx9frm06YF1N5D53ooE2tPKeuM65QVyErgco5333MettoQsWU5nOdnhCLPi/9YXZJUk29Ou7PZ2QcY3Y8ZMcrw=
X-Received: by 2002:a67:8709:: with SMTP id j9mr86962584vsd.35.1564759019207;
 Fri, 02 Aug 2019 08:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190729000123.GA23902@embeddedor>
In-Reply-To: <20190729000123.GA23902@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:22 +0200
Message-ID: <CAPDyKFo9UjyiCrWpB2Xid=tWdZ3GUgdO7pnzrZ4JEKm7nPZAww@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 29 Jul 2019 at 02:01, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9ee0bc0ce6d0..c26fbe5f2222 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
>         case 0x600:
>         case 0x500:
>                 host->caps.has_odd_clk_div = 1;
> +               /* Fall through */
>         case 0x400:
>         case 0x300:
>                 host->caps.has_dma_conf_reg = 1;
> @@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
>                 host->caps.has_cfg_reg = 1;
>                 host->caps.has_cstor_reg = 1;
>                 host->caps.has_highspeed = 1;
> +               /* Fall through */
>         case 0x200:
>                 host->caps.has_rwproof = 1;
>                 host->caps.need_blksz_mul_4 = 0;
>                 host->caps.need_notbusy_for_read_ops = 1;
> +               /* Fall through */
>         case 0x100:
>                 host->caps.has_bad_data_ordering = 0;
>                 host->caps.need_reset_after_xfer = 0;
> +               /* Fall through */
>         case 0x0:
>                 break;
>         default:
> --
> 2.22.0
>
