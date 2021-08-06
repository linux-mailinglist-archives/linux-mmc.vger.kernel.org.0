Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA983E2B2C
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Aug 2021 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbhHFNIP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Aug 2021 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343976AbhHFNIP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 09:08:15 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53516C061798
        for <linux-mmc@vger.kernel.org>; Fri,  6 Aug 2021 06:07:59 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id t26so3564124uao.12
        for <linux-mmc@vger.kernel.org>; Fri, 06 Aug 2021 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0egmAKT/R197XZi0htjrUJND/Awk5tinif8Td4ZFcM=;
        b=MXR1khDqS1eNnpFM3QeAursRq7gGKAtsJ1Sy6dOKISqveosfbsPg9KID0N75x/e0Te
         XPErSBft6i6DgOIi13b0GjuUmEt/4i6vZ7Nu0Xb6TLTN/Ec3IrFsqicucren2zKxL760
         yImVPEVc8ffKRdPKdNJpSGi6XKScMWdW3r/Xc3JfqC0chBL+fhnjoMRXW7zCo1pUahWa
         W58kXgKlVxFFtlgdypAMzTgEldhAb+psOvi06BcRIK9G+dsi25q8+QyI7v73hVM43Sgr
         WtPnRMzyvKwjkm3DKw4J3KdqhJsNo5O5UTt4IFiDFrCCMKISSPSzP/StnO50x9tdNbCp
         rPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0egmAKT/R197XZi0htjrUJND/Awk5tinif8Td4ZFcM=;
        b=ORoyxlKuyHI7zJbY+wn0rWAY+J2uK7aMtGUhEqay5C/4nK1mvqZFxAyC4e4qaG0jtz
         6pxOOb3tt59Km4B/+pkj1WZKiF77+mzuoB8UHcjwfoH2k0TR/kywmTuNO2vs9Umvyir/
         bk6tGzjLu9bT0oU1uvmfNjQll7eUhxiFSBkTx5AQErbVbc4IiNGhav9nUYdCHeJddCij
         59aYK2XXHtPEJMK1sKEGMG3nJ5osfytBiMaEEeVFp0z4aCW1jgfMvK+NNZ0i1rhoevn1
         R0ENzFhPWvwL5RAe1gHo9639vohWixS9VPiEk7tY4mfyEv8PZ0XV986FObAB73HgNRHR
         jN+Q==
X-Gm-Message-State: AOAM530Ml/7Q3s0VGlEaUL5LI+aqlYgeHOqJnRGI2Fa+QYnMuKe94Cgg
        bkhpBzTcnUSuSH36fORDVstxqmKW2/WG/M/rHGNy6A==
X-Google-Smtp-Source: ABdhPJwF2MBEeQ/5HJFMv6urvBEooXwnkUHyU3lHAQ3A6aTqF85k3o+mJgrnwOjSi4EXgnmUmQ8SWYfylfrE5x7YLgU=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr7981146uaf.129.1628255278475;
 Fri, 06 Aug 2021 06:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210726163654.1110969-1-sean.anderson@seco.com>
In-Reply-To: <20210726163654.1110969-1-sean.anderson@seco.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 15:07:21 +0200
Message-ID: <CAPDyKFrkOXOuRM-n5f=MORdf4VTggYS6sA4DQ+r5ujHpU+PRWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: Don't warn about vendor CIS tuples
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Jul 2021 at 18:37, Sean Anderson <sean.anderson@seco.com> wrote:
>
> CIS tuples in the range 0x80-0x8F are reserved for vendors. Some devices
> have tuples in this range which get warned about every boot. Since this
> is normal behavior, don't print these tuples unless debug is enabled.
>
> Unfortunately, we cannot use a variable for the format string since it
> gets pasted by pr_*_ratelimited.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/sdio_cis.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index b23773583179..7518b27bcef2 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -330,13 +330,23 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
>                         prev = &this->next;
>
>                         if (ret == -ENOENT) {
> +
>                                 if (time_after(jiffies, timeout))
>                                         break;
> -                               /* warn about unknown tuples */
> -                               pr_warn_ratelimited("%s: queuing unknown"
> -                                      " CIS tuple 0x%02x (%u bytes)\n",
> -                                      mmc_hostname(card->host),
> -                                      tpl_code, tpl_link);
> +
> +#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x (%u bytes)\n"
> +                               /*
> +                                * Tuples in this range are reserved for
> +                                * vendors, so don't warn about them
> +                                */
> +                               if (tpl_code >= 0x80 && tpl_code <= 0x8f)
> +                                       pr_debug_ratelimited(FMT("vendor"),
> +                                               mmc_hostname(card->host),
> +                                               tpl_code, tpl_link);
> +                               else
> +                                       pr_warn_ratelimited(FMT("unknown"),
> +                                               mmc_hostname(card->host),
> +                                               tpl_code, tpl_link);
>                         }
>
>                         /* keep on analyzing tuples */
> --
> 2.25.1
>
