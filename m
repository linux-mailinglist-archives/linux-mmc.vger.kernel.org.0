Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0266FC38E
	for <lists+linux-mmc@lfdr.de>; Tue,  9 May 2023 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjEIKKp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 May 2023 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjEIKKe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 06:10:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13939E709
        for <linux-mmc@vger.kernel.org>; Tue,  9 May 2023 03:10:33 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a5e0f5b1aso53305127b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2023 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627032; x=1686219032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JEDJ2rRfQXOxy23bXO/m5rzJ7j9h/DglKojLvaBGks=;
        b=QzI09S1vQJ3kpkLwYCOWKtNEIbImnD3qNaVYLqVvYAIEyunEmTgMaXPYecdVLtHtWs
         dEhzve2q8lbJntL85jfarv17CDRzfqp4kE5u3+xli2UJzqlUsbZMe3R3iqEfh+sA8tKz
         7riJHzYkv9j7doZA3uLxhMDtZx2c44/b2kLGAjnOGOClPQXubS1n1Wd/IWlJuEvlW9f/
         F6q35QsRm3/JiBLfC9GuQpXoMr7B1r/noctRyJtlWxY9zc0+1Y47ZmTVQJ69V8aR0Et/
         ZXOVmeqAgew+IzDpMGwj2J6aQYElE7fuLdDWo2y3muj/ESZd5kSyUcYosjsrvQ6TMinq
         S2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627032; x=1686219032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JEDJ2rRfQXOxy23bXO/m5rzJ7j9h/DglKojLvaBGks=;
        b=dY9z45jOxqpdE3WKj4b+WU3Hhc8A5eehLBcsmVybcodjL7YKDGx7Ib24BaqmP2UsSF
         BmpGgimN/N6rJf0KDfCqky3MlCK56sy2E4etBtKyvxLhj0dpXxlG7SC15b8LcT9sMAa2
         sW0CqBXFd36a3xfBdbLA0ThF+iu9Sd60R6TXJussOIZl6TtyrWucKE6tcqS5Rs9MZFPq
         8r1kjPuoMksSxuba2eMN+6mE4a5ro+V6zfm9xJ5aTZN13NqscFUQEzgDp65v7zc//7p7
         TvLz7AP1CZ9i+poArqCzoM9fFY8CnDjz1BvdGncAAGWLzgUPywhIDV3h6JqZD6XLXd9f
         nswQ==
X-Gm-Message-State: AC+VfDwpQAF06XPjjdW65ZeaNG+HLO7XprUBC/nCAJ4bK8JJx+JXhgMA
        YZKVOrCp8norsZx9W5T6wWQC/278AZrVjZKUeAfN4Q==
X-Google-Smtp-Source: ACHHUZ6DTSRnu1VlxQ1078f3IZ4zkS5hkV9bCzfMAhPFO0ql6GbBk4UHxRfaLAujWc5V9oPLdieg7povqYsY7RZky8U=
X-Received: by 2002:a81:4e45:0:b0:55a:985e:8ad1 with SMTP id
 c66-20020a814e45000000b0055a985e8ad1mr14683116ywb.33.1683627032246; Tue, 09
 May 2023 03:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230504112222.3599602-1-haibo.chen@nxp.com>
In-Reply-To: <20230504112222.3599602-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:09:56 +0200
Message-ID: <CAPDyKFruP6BK5nwzgp5b0GbaXuqUPK40YddV6rN+ffytPhK0Bg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, s.hauer@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 May 2023 at 13:19, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> After commit 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate
> ESDHC_FLAG_HS400* only on 8bit bus"), the property "no-mmc-hs400"
> from device tree file do not work any more.
> This patch reorder the code, which can avoid the warning message
> "drop HS400 support since no 8-bit bus" and also make the property
> "no-mmc-hs400" from dts file works.
>
> Fixes: 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d7c0c0b9e26c..eebf94604a7f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1634,6 +1634,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         if (ret)
>                 return ret;
>
> +       /* HS400/HS400ES require 8 bit bus */
> +       if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
> +               host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +
>         if (mmc_gpio_get_cd(host->mmc) >= 0)
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
> @@ -1724,10 +1728,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->mmc_host_ops.init_card = usdhc_init_card;
>         }
>
> -       err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> -       if (err)
> -               goto disable_ahb_clk;
> -
>         if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>                 sdhci_esdhc_ops.platform_execute_tuning =
>                                         esdhc_executing_tuning;
> @@ -1735,15 +1735,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>
> -       if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
> -           imx_data->socdata->flags & ESDHC_FLAG_HS400)
> +       if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>                 host->mmc->caps2 |= MMC_CAP2_HS400;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
>                 host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
>
> -       if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
> -           imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
> +       if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
>                 host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>                 host->mmc_host_ops.hs400_enhanced_strobe =
>                                         esdhc_hs400_enhanced_strobe;
> @@ -1765,6 +1763,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                         goto disable_ahb_clk;
>         }
>
> +       err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> +       if (err)
> +               goto disable_ahb_clk;
> +
>         sdhci_esdhc_imx_hwinit(host);
>
>         err = sdhci_add_host(host);
> --
> 2.34.1
>
