Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429944502E3
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Nov 2021 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhKOK7l (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Nov 2021 05:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhKOK7f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 05:59:35 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2CC061746
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 02:56:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so42415617lfv.10
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMjL3KGHGCu5hceBLZ1A8Lt8hm3+JYwCKT4ycpSLRDY=;
        b=sdeZzuJjuxC1GH5CbosT9rO285E1tyPwPEZeExcKCXi4YuHEVaWXNHv1bp/BrX+O0m
         vF94uR6nLAWUQtw+aVmw6cb7UVezx2TZWL9OZOMIt1U4NP6clzx66rXS+zm8L06BE4HX
         f/Nhz4vMeBbuTLM4MWj5Yv0pZzNHJ2zak17C1xD706Q5yR31byg3uyOHYHaCDVwauWqF
         LWHTwHnScTWjZjjeJf/AS7F1l4xLq2VjYLu/xB1nbQpzJ+WA7/vGkM1IDuvxlIu0SngM
         XcBjdQXTWzmNa9yt3mir1nad1c8z/E7DBNl4vjr6/rbROge/eIr5/pePXpI8a6bj6hEk
         YThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMjL3KGHGCu5hceBLZ1A8Lt8hm3+JYwCKT4ycpSLRDY=;
        b=kb7kG4gZE87zFwd5s/ihVW/FYB2G8r9aFPAP/bZFv8r4aZ6zvJrxvIz3FrBK0LoVrK
         kSWH3yG7D1o2b4HXFWEjNdIh8GPymsRL3IdUN8G/vIsBfjcLmgFupojs9rePWrNFWm3J
         6TnCq4WcoqNgGBXv2dZWjI2cjmq8/alSTrwPNJLM6H9k/3FRQayK76DbZM7v5/sZbUMK
         6XvkL9KxLSFJqamPDRM6LGiJMUtp7NAW8SIM+yaxdXbBzQmYatwdzZlmD3HqQVl8OWdq
         SLOa7R8glWLPNhj1Y/dPB4omXWEb3V2ZY9vzvYYoirAQOx7BOymAbyfXeuRFNKfVqDPS
         Kjdg==
X-Gm-Message-State: AOAM531iqHdER6co5qGQs0FEg1j73HabjEsDQ1t8Byyr4KhYwKFGuf7/
        ePhSD0hBJuMQu90XZv4fqGjPzWiVO+plDL4sXc6mqCa29qU=
X-Google-Smtp-Source: ABdhPJx3ALnWielc4AoTimzxkI6Nugo3rVzkrCt4sq0osRKPBQU5KAf8FDgz8XeOQxOsblYgJ7LKqjoWPMmt9bv3vx8=
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr35556910lfj.254.1636973797671;
 Mon, 15 Nov 2021 02:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20211103122646.64422-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211103122646.64422-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 11:56:01 +0100
Message-ID: <CAPDyKFotgvLvtZ3EzsFz_4HfUeKwpZbyq0-2BjuJZoDw9u=Ptw@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: reinit card irqs in reset routine
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Nov 2021 at 13:26, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Refactor the code so that card detect irqs are always reenabled after a
> reset. This avoids doing it manually all over the code or forgetting to
> do this in the future.
>
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> [wsa: added a comment when 'native_hotplug' has to be set]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index e2affa52ef46..a5850d83908b 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -960,14 +960,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_POWER_OFF:
>                 tmio_mmc_power_off(host);
>                 /* For R-Car Gen2+, we need to reset SDHI specific SCC */
> -               if (host->pdata->flags & TMIO_MMC_MIN_RCAR2) {
> -                       host->reset(host);
> -
> -                       if (host->native_hotplug)
> -                               tmio_mmc_enable_mmc_irqs(host,
> -                                               TMIO_STAT_CARD_REMOVE |
> -                                               TMIO_STAT_CARD_INSERT);
> -               }
> +               if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
> +                       tmio_mmc_reset(host);
>
>                 host->set_clock(host, 0);
>                 break;
> @@ -1175,6 +1169,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         if (mmc_can_gpio_cd(mmc))
>                 _host->ops.get_cd = mmc_gpio_get_cd;
>
> +       /* must be set before tmio_mmc_reset() */
>         _host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
>                                   mmc->caps & MMC_CAP_NEEDS_POLL ||
>                                   !mmc_card_is_removable(mmc));
> @@ -1295,10 +1290,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>         if (host->clk_cache)
>                 host->set_clock(host, host->clk_cache);
>
> -       if (host->native_hotplug)
> -               tmio_mmc_enable_mmc_irqs(host,
> -                               TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
> -
>         tmio_mmc_enable_dma(host, true);
>
>         return 0;
> --
> 2.30.2
>
