Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09F74FE9
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jul 2019 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbfGYNoS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 09:44:18 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45122 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbfGYNoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 09:44:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id h28so33713835vsl.12
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4bEfkUUJYfGvI6TKW6ozHty+vZn220gLxXD+QbuwkE=;
        b=iKz+5sz3lDIsAPShxvIuZPW5WFrpsRecZP4JHvtCJ5xFKGT5WCQW0SUWPxEHTF9dwa
         HQkhuc9EhuQ/uo/FaGW8AzVVGS1R0BrAmDH4/ysvbAquL+FfIKmmk5mg7hCOY8ZR3sA3
         r2ioLVQpTtYzFsvAclhX+ukvMNeL37NFVB9x4Wpg7dZPUOo1tuca49ACji8I34xiKBC3
         daE24Y1Wm9rcmpYJa1unIlTECQKMWTp5HuSyZpXKkhZjAl9bjorN41of1HBNIqfserEW
         DT8dVEUJYcmug1cfwy2fcUlq7tKEpO2Fv/gccMeIFRDhTdlOj2E6Sr5ffE4wjOQJapEv
         LJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4bEfkUUJYfGvI6TKW6ozHty+vZn220gLxXD+QbuwkE=;
        b=oBSvoUHSKbp+lqnOn5sJXMd21w8RlURnjyRmbMXFIKX7SyIo0v/9EEIpFhoij7aYS3
         +JI6nhc1y8JKDbnDqGW7PbR9ytTzG+ERdICwEDMcnfVhE3+ZK1wH1A0OBX6e20fL4d5b
         EiXDOqGK7XDPrAZ3yOF5YXfysLNSgKpYyV8nNJf17YKTF0am1ywNy+h8esLSIoK37snR
         nBXNvyGhqg+Ca40bK2701Rt6Kvh8cgpJN46jXRyHTdht4FCakiENUrtdz5YVpfJ3ahe+
         AS7aWln61VcDbHP/5/kIfLaiO+VM3EjkL6AXN+BXiDGHjJ0FHkJjJo0Tn7HHdx0Waz0E
         KaLQ==
X-Gm-Message-State: APjAAAWOTKCqUSzxBf9BP7M+8SontRWmRcTRW99Bi1/VmToy+9lqjjnn
        Ew9govX9dxFRrXmS4OP7YQ8heSlu0Ylqx5TeN2u7ZA==
X-Google-Smtp-Source: APXvYqwsN3NYipZ2L8tQzc9xLMlMYic80Y3TsG8VamwC6SFVel/aQctyGDJPPeLXxRUhndnucYPhTHxT68Biqy/IzKU=
X-Received: by 2002:a67:e454:: with SMTP id n20mr57354696vsm.34.1564062256550;
 Thu, 25 Jul 2019 06:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu> <1563289264-26432-2-git-send-email-uli+renesas@fpond.eu>
In-Reply-To: <1563289264-26432-2-git-send-email-uli+renesas@fpond.eu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:43:40 +0200
Message-ID: <CAPDyKFq2i0pRKGtMA6YESpKOAAzK-enhW7fkT6=63Ad2mQGmJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: leave clock handling to PM if enabled
To:     Ulrich Hecht <uli+renesas@fpond.eu>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Jul 2019 at 17:01, Ulrich Hecht <uli+renesas@fpond.eu> wrote:
>
> This fixes a clock imbalance that occurs because the SD clock is handled
> by both PM and the hardware driver.
> See https://www.spinics.net/lists/linux-mmc/msg44431.html for details.

This is a generic problem, when a device are being attached to a genpd
and when the genpd has got the ->stop|start() callbacks assigned, as
to manage device clocks.

Can you try to describe this problem a little bit more in detail, as I
think that's important to carry in the change log.

>
> This patch removes the clock handling from the driver's PM callbacks and

runtime PM callbacks and/or system PM callbacks?

> turns the clock off after probing.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
> ---
>  drivers/mmc/host/tmio_mmc_core.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 31ffcc3..26dcbba 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1260,9 +1260,14 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         /* See if we also get DMA */
>         tmio_mmc_request_dma(_host, pdata);
>
> -       pm_runtime_set_active(&pdev->dev);
> +#ifdef CONFIG_PM
> +       /* PM handles the clock; disable it so it won't be enabled twice. */
> +       if (_host->clk_disable)
> +               _host->clk_disable(_host);

The clock managed here, is that the same clock as being managed by
genpd's ->stop|start() callbacks?

> +       pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>         pm_runtime_use_autosuspend(&pdev->dev);
> +#endif

So what happens if you have CONFIG_PM set, but the device doesn't have
a genpd attached?

I am guessing the driver should handle the clock in such scenario, right?

>
>         ret = mmc_add_host(mmc);
>         if (ret)
> @@ -1302,20 +1307,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>
>  #ifdef CONFIG_PM
> -static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
> -{
> -       if (!host->clk_enable)
> -               return -ENOTSUPP;
> -
> -       return host->clk_enable(host);
> -}
> -
> -static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
> -{
> -       if (host->clk_disable)
> -               host->clk_disable(host);
> -}
> -
>  int tmio_mmc_host_runtime_suspend(struct device *dev)
>  {
>         struct tmio_mmc_host *host = dev_get_drvdata(dev);
> @@ -1325,8 +1316,6 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>         if (host->clk_cache)
>                 host->set_clock(host, 0);
>
> -       tmio_mmc_clk_disable(host);
> -
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_suspend);
> @@ -1340,7 +1329,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>  {
>         struct tmio_mmc_host *host = dev_get_drvdata(dev);
>
> -       tmio_mmc_clk_enable(host);
>         tmio_mmc_hw_reset(host->mmc);
>
>         if (host->clk_cache)
> --
> 2.7.4
>

Kind regards
Uffe
