Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF7FC69D
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKNMyG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 07:54:06 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44919 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKNMyF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 07:54:05 -0500
Received: by mail-vs1-f66.google.com with SMTP id j85so3749944vsd.11
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FD4rWZvRtjq6yENRSiMKVtNcvX/RF09g3K3VFm1ugEY=;
        b=KbvsZSYDIxGePu0L2CAqFoQQVRCU4t6p5EltIbJBOhwSNAhoQsyCYOzW0153Cy2o5c
         BQIKv5nM+jFnLIpIexEEpsh5XGW34sIZYZfmpsIwbLJgpGl1+3x01FltLTF4Hg6l/5Yu
         eFVzTOXa+ib5Jn/X/SxZ7s5Lw3u1PsMv/egwElA4H7geGX7efG+H45OITVmIu05Nf3fH
         1LCasBR65pP+mkf0BywJD3p3ccp9RH50QoR2GS8UDs5az3fRm+an5Z2Ch+5VoIdu0QkD
         BhZk8w4tT85ZkO1tA8zqS1DyX0rvKIyyygoXhZLKm0lixVgndIdRvwCYqnoSs7ByxSIS
         0LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD4rWZvRtjq6yENRSiMKVtNcvX/RF09g3K3VFm1ugEY=;
        b=YwdmMW8wdzMMZoR56t5vnYhxVmLgp+rB4pMuRCJOYqlLu14s4s07R0HiTntbcD7S8R
         y7NyKQQxHd6YnIA8jkq6KASSBuUOl9mmKC7XMnBzzSLY0MUPVk09PZfbMeyLfp0dAzP8
         MEFrX9HrdT86inE/SGKm17xlRTsDjaUGh5eRL23TO4ZF5CdlIAW0L5pf2Vakc/7Bak/J
         QnhbM0BwjolmuRt1lz3gNRs2KBH58C7uHx9RayDqNE9aGBnH2hjySyGUTBFe1n0WWarA
         hD2uWJi2NO/ZecQb3XnY9xL1P0XkcdCZaagUMMXJc+y3LuXMvNlh012HU4hM+97tP+e8
         0q3A==
X-Gm-Message-State: APjAAAUQmgISBI3XwfkvPw1HQBnUkMn/u1KlvJsPu3joN6s7tdYWXPDO
        RH94MoNt/pH7S0wiqf0NkEc/N62AceghCnyurE17hw==
X-Google-Smtp-Source: APXvYqxi7fyU4+jooeOZ+IRMiLOIyKT3tKM38JWeDbD8Q0d7jOcsPdRO0XHDqMVmSK/f+8kswp6EKP9vA+qe0OrmOpg=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr5486988vsr.165.1573736043630;
 Thu, 14 Nov 2019 04:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:27 +0100
Message-ID: <CAPDyKFpA6iYmTVt84CDics2pWdSnjwQhgW31aaH8sdDtXgyAnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Nov 2019 at 17:09, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 66e354d51ee9..74c6cfbf9172 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1421,7 +1421,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * Index 0 is card detect
>          * Old boardfiles were specifying 1 ms as debounce
>          */
> -       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1, NULL);
> +       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000, NULL);
>         if (status == -EPROBE_DEFER)
>                 goto fail_add_host;
>         if (!status) {
> --
> 2.23.0
>
