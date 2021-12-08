Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DA46D156
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Dec 2021 11:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhLHKvz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Dec 2021 05:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhLHKvy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2021 05:51:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE9C061B38
        for <linux-mmc@vger.kernel.org>; Wed,  8 Dec 2021 02:48:22 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v15so3305499ljc.0
        for <linux-mmc@vger.kernel.org>; Wed, 08 Dec 2021 02:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+SdIraKU1h/VTJU366bK+146L0b2CZSCkrC1RqcLiI=;
        b=fhXHxYwOAsjpDT7PFmr/Ay2Bpv6Q52w7gzhLvGp3vi03x0kgJwC1mR2nR1tEBwpntR
         5BIgAfnWN19+UstNXJU4S3pPdsYuWBgNebk4d3ZIyHcMtWi3YzAF0eZIz8zZvhekOaoN
         dpXhu+rLaGYfNU3wPEK81pcn5RGWC+TYP50YKir8VfeN5bYZl1TC19FCevLctaRQ7GbS
         gPCsf9ihaBJkTM0mvs/9FwV0KyzdDAXiEqb7QKxeQwaG8ND1MHBq/EpD6AasS8g7Ta3l
         bXpZYLOXalhq5nbUEDXeIJBRG84NeR6F77adUrF6zH9WKGEaVG6SVgZm6ihC4RzUHLYr
         VlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+SdIraKU1h/VTJU366bK+146L0b2CZSCkrC1RqcLiI=;
        b=KYk/rdr26S95n0ju9UMZEgv/XFXm3TJdqX4yiWASxANWLSZKQu0+G1h7O1A15gKZe3
         dufEHLaxFXYM4CA7HfrW1I+z33XHDMOBFmfRkG4oQHYV/GFOSYwwcwRs5O2dYJB37yLq
         44aeLOzacTyixmofVD2oOPEgZf7XKbWjrtrOwhFks9jLyx0GGc16RAOWHjoulILmdT0d
         DzTrKiZoSG1yLwl864JAz2NMkJSCeoFF55nfz3S8Q3r8m2wd5zqAdAMgfJYdpHJzX+EH
         f61MAk7Zq6ibEnljTfVM8SVRkRnDa2BRyAEULHygyxEMWZuk9oJepe1xCDxR24OPpgHv
         soGA==
X-Gm-Message-State: AOAM530mEQ+JgBf+xM/+SMcfuRzbCi4Nj2tES9Gr/3VSn7PNl+l7wiIR
        uL4G0xdw9FzEtaWZcoX11bg6mMPcOA8PDd7SVEGhCw==
X-Google-Smtp-Source: ABdhPJwVpthnKSrDF/C2HexBrqNAjJ6E3HCFUU7MoAlXVzpyAbLD4i9B/Oo9exkRlkxfOdIXnrTziCam6tJi8meqZow=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr48977767ljm.16.1638960500425;
 Wed, 08 Dec 2021 02:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com> <20211204061042.1248028-12-Mr.Bossman075@gmail.com>
In-Reply-To: <20211204061042.1248028-12-Mr.Bossman075@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Dec 2021 11:47:44 +0100
Message-ID: <CAPDyKFohGQ9M08sJmM5eo2jNhrvFSHA2bnb31AEgiFCFfV78ng@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] mmc: sdhci-esdhc-imx: Add sdhc support for
 i.MXRT series
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        Kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 Dec 2021 at 07:11, Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> From: Jesse Taube <mr.bossman075@gmail.com>
>
> Add support for i.MXRT1050's sdhc.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

No need to resend this, it's already been applied.

Kind regards
Uffe



> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Rename imxrt to imxrt1050
> * Remove BROKEN_AUTO_CMD23 and MAN_TUNING flags
> V3->V4:
> * Nothing done
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 764ee1b761d9..55981b0f0b10 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -305,6 +305,9 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>                         | ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
> +static struct esdhc_soc_data usdhc_imxrt1050_data = {
> +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_HS200 | ESDHC_FLAG_ERR004536,
> +};
>
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> @@ -355,6 +358,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>         { .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
>         { .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
>         { .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
> +       { .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
>         { .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
>         { /* sentinel */ }
>  };
> --
> 2.34.0
>
