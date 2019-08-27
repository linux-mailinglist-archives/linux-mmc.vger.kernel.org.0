Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B226F9E93A
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfH0NZE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 09:25:04 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35416 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfH0NZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 09:25:04 -0400
Received: by mail-vk1-f195.google.com with SMTP id b184so4783856vkh.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UcidXSfl4Z3vHSHUGEtHekVKS8cSrikyMMH4+bTgZ4M=;
        b=RVu3MC11jWStUaJWi98HfO3dbKm9C5Co8wjxsZWOo/mNHQ+5mqEUp10/RpXdwCuczF
         k8/z8CMpLF76qiJoqdzys/nxDLQCGi8UvOtNQts1UmBii+EppSvoXLAJJH2NV0LGoCd7
         4nRrgjlHGyuMTENDRa8GF3RcqJ6kG7Ef2T8xE8nRQkROzDX/NxN5XuVzVklBA2Jh4m3b
         Rpvog8ZOLY5lJ9MbqUEnRlQdXAW0lZ/0dQN4ccIdrwR8ne5YPmGGy7c5kOr1AzFQk9fD
         3Cn1hMyu83oC77lxGU0Gs/eraAg/vf6fpzOEoGZoO4STbJ0ClR14j6Y5Ux6x5/FENXAZ
         1z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UcidXSfl4Z3vHSHUGEtHekVKS8cSrikyMMH4+bTgZ4M=;
        b=LcuPPZGNWfXUtdUQ78tr3iaTOoPZf3aRk8lkHPgnejQ42Z7alacyUiKAQzDAT4ktuV
         AmF4R8txTOrtRvMGPvag9P5AnGn0LAyU5e2NE7ZfbfXGHpS/z+y26uhfHwuRAfxCCIWY
         U2X4PQLSQXZoK5UmrIRFvGXQhCPmafCDJgnSCMFiVFFWYLryIYe/QBECFter+DlfrYoo
         XRPmClLCM9BKNaStybXjua5mZYBQs9sBiRSBpg4ncUhWCcnZTpvoIMZJe1BE/ftUNEWb
         te8OhhMHk7gP9RZvKU1CathZLmqvDLbEYQzEYc62g4S0QYv/ywGVIK4u/Hrav0UhWXog
         w9LA==
X-Gm-Message-State: APjAAAVAfqfnTt3HJOlEPZ4hrn3D6+MPgN3iSsKmvpwE4xBk8nPKQch/
        od6VtQ8dYgQ6P4DuHAdmyMxtvV0N+On/zahTIH9lRQ==
X-Google-Smtp-Source: APXvYqw4rRg5A1BUZRNkhA0iBmBLWQcJBY43NvkoqQo3uQzksvmf6IWqHjVjTq74W1HznjN4U6L+Pcy1Ay77XLTU/Qg=
X-Received: by 2002:a1f:5185:: with SMTP id f127mr10726260vkb.52.1566912302772;
 Tue, 27 Aug 2019 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
In-Reply-To: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:24:26 +0200
Message-ID: <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
To:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 25 Aug 2019 at 17:06, Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:
>
> Some Allwinner H6 boards have timing problems when dealing with
> DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.
>
> These timing problems result in out of sync communication between the
> driver and the eMMC, which renders the memory unsuable for every
> operation but some basic commmands, like reading the status register.
>
> The cause of these timing problems is not yet well known, but they go
> away by disabling DDR mode operation in the driver. Like on some H5
> boards, it might be that the traces are not precise enough to support
> these speeds. However, Jernej Skrabec compared the BSP driver with this
> driver, and found that the BSP driver configures pinctrl to operate at
> 1.8 V when entering DDR mode (although 3.3 V operation is supported), whi=
le
> the mainline kernel lacks any mechanism to switch voltages dynamically.
> Finally, other possible cause might be some timing parameter that is
> different on the H6 with respect to other SoCs.
>
> Therefore, as this fix works reliably, the kernel lacks the required
> dynamic pinctrl control for now and a slow eMMC is better than a not
> working eMMC, just disable DDR operation for now on H6-compatible
> devices.
>
> Signed-off-by: Alejandro Gonz=C3=A1lez <alejandro.gonzalez.correo@gmail.c=
om>

Assuming this should go stable as well? Perhaps you can find a
relevant commit that we can put as a fixes tag as well?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d577a6b0ceae..dac57d76d009 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1395,14 +1395,17 @@ static int sunxi_mmc_probe(struct platform_device=
 *pdev)
>
>         /*
>          * Some H5 devices do not have signal traces precise enough to
> -        * use HS DDR mode for their eMMC chips.
> +        * use HS DDR mode for their eMMC chips. Other H6 devices operate
> +        * unreliably on HS DDR mode, too.
>          *
>          * We still enable HS DDR modes for all the other controller
> -        * variants that support them.
> +        * variants that support them properly.
>          */
>         if ((host->cfg->clk_delays || host->use_new_timings) &&
>             !of_device_is_compatible(pdev->dev.of_node,
> -                                    "allwinner,sun50i-h5-emmc"))
> +                                    "allwinner,sun50i-h5-emmc") &&
> +           !of_device_is_compatible(pdev->dev.of_node,
> +                                    "allwinner,sun50i-h6-emmc"))
>                 mmc->caps      |=3D MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret =3D mmc_of_parse(mmc);
> --
> 2.20.1
>
