Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD7103A8F
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfKTM7p (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 07:59:45 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39268 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfKTM7p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Nov 2019 07:59:45 -0500
Received: by mail-vs1-f66.google.com with SMTP id x21so16767679vsp.6
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2019 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GsJhhGZziWPIah7qk/z5Cok3HzOYzMQmBX1mYOxe68=;
        b=BxOuNhoXjXd7xZ0Be4KtsmFiQfzvDQvBVmru+3tyzBSZR/nGSbq+JIKk1OsurULq0i
         U9fENJLcwMod5KHm1u5YmxfVvNQDqg17NcUuHou//ZCcA3cFo8J9LfVHjcCXcw68+ehR
         Ufm0+t+w2x6FODMHWjrJv/N7P7t/zWPOP1QYXXf+AgW1XT7+aNEktopH7pqxTxuIyKz0
         BHWL++d3C+4EobD0/+PW7UpQwvql484AXgazIM2hNb+fe9fDmWrfy29rMFwZuHNlvWbR
         FD85BWjx05lzPZxYlktdXGrxjna8Ooqkg/pzQWKtWEZyXM0UsFe8CWIAnws4WIqTgPxi
         FB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GsJhhGZziWPIah7qk/z5Cok3HzOYzMQmBX1mYOxe68=;
        b=eM84Xxv3NWLuXu5famcrxNg9uUOP2SYLvKszhJ/0rypyMCPaWinl/Bbz28ng3s0GuD
         pRwSoazjTsimYZpQbWKZMYWNC4WYFejN1KyyM2HHyMBWMlZuzXnHNFpEmPkVL/osSLFX
         5VBbYksQ7cmeFJWs4E6smJPvyRE3850CuNfTO2EBYmGKU2M3B7U5JzmkvLV36+0SS31h
         rinyoeuJBuHdTi4c2cC8mcMUMiZhYSDpK6B7/EiV2djcbao6u1La/X5WgqtIydzduLkH
         gZbzl7fHbAnHJWSb8J4nWnTDrF4GS3/7GQshXRdb09fh97GfU+341/7t19LprITDxPge
         7VKg==
X-Gm-Message-State: APjAAAVqbh7cphuAW12Gp06m/DKjCR2SE3mPGEVNoQD29b7La0Uz7XYv
        l3gEIj6geQndf7lkySJ7lnSujxfBsj9Kp6Px7+dsyZXk
X-Google-Smtp-Source: APXvYqxKLOwg03HuPsiZsUmV0PZs3AODHPLGrS5ZkfHVPSlG1TPJPXrAvJh4lHPwDY6NkNl5pvLp3dVVFPHjhHEjOE0=
X-Received: by 2002:a67:fc04:: with SMTP id o4mr1424395vsq.35.1574254783696;
 Wed, 20 Nov 2019 04:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20191119155503.21421-1-festevam@gmail.com>
In-Reply-To: <20191119155503.21421-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:59:07 +0100
Message-ID: <CAPDyKFrzbpYWJdFpw__-rSjy1JYG7APETJVOLa2B0DC9CBVg8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix grammar in warning message
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Nov 2019 at 16:55, Fabio Estevam <festevam@gmail.com> wrote:
>
> The correct form is "did not become", so fix it accordingly.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe86d9f9..3140fe2e5dba 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2213,7 +2213,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>                 if (!(ctrl & SDHCI_CTRL_VDD_180))
>                         return 0;
>
> -               pr_warn("%s: 3.3V regulator output did not became stable\n",
> +               pr_warn("%s: 3.3V regulator output did not become stable\n",
>                         mmc_hostname(mmc));
>
>                 return -EAGAIN;
> @@ -2245,7 +2245,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>                 if (ctrl & SDHCI_CTRL_VDD_180)
>                         return 0;
>
> -               pr_warn("%s: 1.8V regulator output did not became stable\n",
> +               pr_warn("%s: 1.8V regulator output did not become stable\n",
>                         mmc_hostname(mmc));
>
>                 return -EAGAIN;
> --
> 2.17.1
>
