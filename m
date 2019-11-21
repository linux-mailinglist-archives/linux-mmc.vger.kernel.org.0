Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED7810516C
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Nov 2019 12:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKULaW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Nov 2019 06:30:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33907 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKULaV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2019 06:30:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id y23so2034685vso.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2019 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAvATSVruPsj7LsQgxfr72XL8+9iGgaqaBjQQXBk1cc=;
        b=dq6+0uwWhO4MChZo1CR8QWarL8IwZhnfYAVunlHBkD3arPvFXTR5Bi+M+tJ/ASSk4q
         Fv4f8VIGc8X/L1AmoTXFH2Q9XJeO6ae1KMFZPSf2XD7OhccO0hNA7dO5XPoaopBA3abj
         c34BA8AdzuUUVbmD8g+mSf7jzwPfgHPcVnrxRNCXEJga9yxg/Hb4fVti4gvFy8iUWBYY
         0Fgtq/IOeLQUi4z6c46PzlRiSXq+LgezO1T4wc4uBsT7JwZxn5CcNFhO1ZO43RRpb+yG
         /Sjcr3zJ4xVWMZzAwGZ/Z78rV68qfoBklmUNw1g1sAxu9byM9gcql7x498YYPS3KXPlr
         d8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAvATSVruPsj7LsQgxfr72XL8+9iGgaqaBjQQXBk1cc=;
        b=Ug46LtZtg3yI0mDtH8TWhBMtMLBRt2KPBS/xS7/I72jT2TcQIajKjSBZOvakUh4hdu
         hsGQqnYMfkYAm3ATJkq7tUekNaUKEjY6P4qULGuSRIy3TzwIrgIrZ2DZpXauLHw+oG7U
         3BWJibtTFNsIZfXcA6G6yKuYXm3WjQhwY5sRlrvg02l3D77h7K6yqi+EF4o0u0gGBHzI
         5VzwVU68HYZ9QHjYO/HCs9rozPXruulLxlcsob9FjDZ6DNcPO8koQuXT0/gDDrx9+YnO
         835DwJVjOLMe63LQ/6hZsTTaFyMi2ADIeTXoCslteob8HmAL9/JcjtgSe8jnrAWPxSeb
         i7Bw==
X-Gm-Message-State: APjAAAWpjcf5Bqk71vVHBF/N6G9PFCouDM3ReCyEEiaxl19E/g8c8U2j
        LqLiAbSGSEsLcKbPsitWRT5qHmZVApn3BOgbfxwBFA==
X-Google-Smtp-Source: APXvYqz9UTyZ6JIkT9SfssHJBW4aXMqLiOmpjFl8l8AYazb4snpLewpcYUqtYvh39fz2nDfCXl8K20zU565fyazkR7U=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr5684247vsa.34.1574335819171;
 Thu, 21 Nov 2019 03:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20191121111733.23738-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20191121111733.23738-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Nov 2019 12:29:43 +0100
Message-ID: <CAPDyKFoEeM7wRLAuH2zQ69-xyhxF_TEC4X15kLZBKqJvhUhFpQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: tmio: remove workaround for NON_REMOVABLE"
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Nov 2019 at 12:17, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This reverts commit 7a7dab237027939cb95dc07c4647b80bad5fbbde. We found
> out that there is still a race with RuntimePM. This can lead to a hang
> when accessing the eMMC in some situations. Revert this change until the
> RPM issue is fixed.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, adding a reported/tested-by from Geert, thanks!

Let's revisit this after v5.5-rc1.

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 75f16ff65ac5..c4a1d49fbea4 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1209,6 +1209,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         if (!_host->reset)
>                 _host->reset = tmio_mmc_reset;
>
> +       /*
> +        * On Gen2+, eMMC with NONREMOVABLE currently fails because native
> +        * hotplug gets disabled. It seems RuntimePM related yet we need further
> +        * research. Since we are planning a PM overhaul anyway, let's enforce
> +        * for now the device being active by enabling native hotplug always.
> +        */
> +       if (pdata->flags & TMIO_MMC_MIN_RCAR2)
> +               _host->native_hotplug = true;
> +
>         /*
>          * While using internal tmio hardware logic for card detection, we need
>          * to ensure it stays powered for it to work.
> --
> 2.20.1
>
