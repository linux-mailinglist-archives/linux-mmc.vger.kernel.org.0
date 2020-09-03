Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0025BC75
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Sep 2020 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgICILh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Sep 2020 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgICIKq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:46 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46CC061247
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:46 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p185so1233722vsp.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6LsPfr5gFZyjAJhJ1htpVvYg6c4dCrFqquppUrb+pM=;
        b=WV2YQwByktAObsod47J822KrC/FHRhiSoUACACKvWnufVMSwUyKNjdY63RocHXof26
         cx8Ya/rnK0PKhtl6+Uc41KNZXqibvOsimJDbYcxqblhb71ZGyLjepEVa6RXqqyWyaxDA
         Tt8tMCuFF6fM/z1CK0YUmCvAgeuQx0Gcj2vZJS4FITqT0clwhZTEmOIt6L1ANqDQmP5j
         le08/1r2jIBbkdnfKlSrP0BTK87jCd2C4sllPSjR89OwHGMVHJFrHcRrWQQpL9EA0RWX
         2BjCJrN5LHn7IGM9Pvw0LgcWZAyyyKTZqcHZkIidL6h8U32HlElUVldAaLCRnjxW7XMl
         twsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6LsPfr5gFZyjAJhJ1htpVvYg6c4dCrFqquppUrb+pM=;
        b=f1xFnOanJDPssuAdsJ5IbeTaxj4q0Vt+2oFSPMKOslg7PWHJ0XSHtO7jFy0HPtlteS
         IkpWVZiMkJ9BLAjtF+T4lvmKwV+W1iF5eK46JGhAPdlFS21P2uakzmyq/e1FfuBYnU0c
         rXG6F8Reas7AK9VimAkGAqLj1qE/8jaVhgm+nIF/YI0OyMiWDgy2FAjksjUpO6DG8Tww
         Wg7mK1f3RAFlq3Wx+8RPwJD4YmIURoTFGgHoLrk1jJ7B0Nn2ylT5+bByGH206kcpmRfY
         gvM5kb13iZ91CnGr0BlfGbrdIFZ9tRICwiZ5mXRuuIAMSEByAb7pxQWaVfMi20FYw8Wv
         Cs0g==
X-Gm-Message-State: AOAM533pD5dQmbOS5yC4Aa9RSsej3eUM2c/ElaGOLgjCPdoMfs7UlRs/
        kHiykP9fJ1MSEeTOInQ1L20t7qyL/yMbbpwXhHOfKQ==
X-Google-Smtp-Source: ABdhPJxIUy5MxKGx8qbHJTTySUccfXkN5uPedOk+7Ne8jVpgbd3HgSEgllLV2IRu0n9jm/Btpnnqm32x8+dJmCaYFSU=
X-Received: by 2002:a67:308c:: with SMTP id w134mr387339vsw.8.1599120645493;
 Thu, 03 Sep 2020 01:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200903054333.18331-1-krzk@kernel.org>
In-Reply-To: <20200903054333.18331-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:08 +0200
Message-ID: <CAPDyKFrzBD-m78Q=k2sgYh1zh03N=_1KcFQ3hYpR29LiqHBOpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: s3cmci: Drop unused variables in dbg_dumpregs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 07:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The 'imask' and 'bsize' are not used in dbg_dumpregs:
>
>   drivers/mmc/host/s3cmci.c:149:36: warning: variable 'imask' set but not used [-Wunused-but-set-variable]
>   drivers/mmc/host/s3cmci.c:148:63: warning: variable 'bsize' set but not used [-Wunused-but-set-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index ac94f926624d..40329aeacfdf 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -145,8 +145,8 @@ static void s3cmci_reset(struct s3cmci_host *host);
>
>  static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
>  {
> -       u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer, bsize;
> -       u32 datcon, datcnt, datsta, fsta, imask;
> +       u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer;
> +       u32 datcon, datcnt, datsta, fsta;
>
>         con     = readl(host->base + S3C2410_SDICON);
>         pre     = readl(host->base + S3C2410_SDIPRE);
> @@ -158,12 +158,10 @@ static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
>         r2      = readl(host->base + S3C2410_SDIRSP2);
>         r3      = readl(host->base + S3C2410_SDIRSP3);
>         timer   = readl(host->base + S3C2410_SDITIMER);
> -       bsize   = readl(host->base + S3C2410_SDIBSIZE);
>         datcon  = readl(host->base + S3C2410_SDIDCON);
>         datcnt  = readl(host->base + S3C2410_SDIDCNT);
>         datsta  = readl(host->base + S3C2410_SDIDSTA);
>         fsta    = readl(host->base + S3C2410_SDIFSTA);
> -       imask   = readl(host->base + host->sdiimsk);
>
>         dbg(host, dbg_debug, "%s  CON:[%08x]  PRE:[%08x]  TMR:[%08x]\n",
>                                 prefix, con, pre, timer);
> --
> 2.17.1
>
