Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07F11840F
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Dec 2019 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLJJv3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 10 Dec 2019 04:51:29 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34644 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfLJJv2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:51:28 -0500
Received: by mail-vs1-f66.google.com with SMTP id g15so12580903vsf.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMORO6YLurGC9coObMxz6fn2NzFCAetPjibkmjGyJDQ=;
        b=qg2idsjzuM2EuulQzs29kdk+EbcoL3LZeGdKFx4UZWJFOCsLHnmWc/hU73nthUZD+F
         arcP1pp32UjqCNm5/aPyoOH3mVM9F3flbtbe9u2HpPhFyBb8uaFp/t15yLayWsAjvmVD
         jjzXA5tO29AYwR82Qstx2Lg3ILrPBMLWlLGeXZje/PEVo0ei7BFhqpHzL5YUcHiQHETp
         70wHWykRYkNsgx2wwiyVZ1/CQZ6O1/bAVaXArRu1qJ7kbtHyOUSxpVp8ZQr5+DsYCl1D
         5mZwNwYGOE4o5is8DhOMS3vgfbp3OMflJ6d1pu44qdG5Ah4LWJYNN9dE08thuz4QrmkM
         Ws+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMORO6YLurGC9coObMxz6fn2NzFCAetPjibkmjGyJDQ=;
        b=tl8J1XDYiw76L8KsOeoLG6y7wMv8aTuw1p4pXdtVhBC+GP0H6cykIJ52gldZ1S/mI8
         vXt/+lRtLXWhe2NvGd25N/KyWUWj7hoX/HPGB/+36ss1YZ27iJrtnTfQ/+icgd5d+gA2
         zg/Uit0lmZXftIuqBYtV1Ms2OsxHs3Nb3RXx7FQZU/IWPW9V3oWKQHolGaAu70IGVakV
         ewahP0Zs/DN1XfDVNCggs0fc/VJCCN5K4reXAsEMl680Q7rZWju5URI0cvdN8J/4UjOa
         6WIUIkC7wqj962AsjoHcGQV/mUVhJ+uNLeOd88Zqg+hKHUD0thtaTd8z59CFIvAEnsdQ
         y6JA==
X-Gm-Message-State: APjAAAWwtLIEugeoISQIKAkpvgDo/Zkhdx/m3CXb+fnW283dUtOu38uR
        N+lyHZy3+8YW7oPluhh86zYP1Fje0vu8MK5VmE9FBQ==
X-Google-Smtp-Source: APXvYqyqVsfloBxPx+OU7yT1yq+RRFLOjF9tbpSgQt+rFvvOjS8FfYO5WQc5l2AzCPayN08YsHD/0wd7QvMvEkOnnXY=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr24239747vsf.200.1575971487761;
 Tue, 10 Dec 2019 01:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20191128074522.69706-1-ludovic.desroches@microchip.com> <20191128074522.69706-2-ludovic.desroches@microchip.com>
In-Reply-To: <20191128074522.69706-2-ludovic.desroches@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:50:51 +0100
Message-ID: <CAPDyKFrJmWTtJGT+KuPSVb_ywQ3uwwdYzipK=B_1_dBeuM5dMg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: sdhci-of-at91: rework clocks management to
 support SAM9x60 device
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Nov 2019 at 08:45, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> In the SAM9x60 SoC, there are only two clocks instead of three for the
> SDHCI device. The base clk is no longer provided, it is generated
> internally from the mult clk.
>
> The values of the base clk and mul in the capabilities registers may not
> reflect the reality as the mult clk is a programmable clock which can take
> several rates. As we can't trust those values, take them from the clock
> tree and update the capabilities according to.
>
> As we can have the same pitfall, in some cases, with the SAMA5D2 Soc,
> stop relying on capabilities too.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>


Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes:
> - v4: fix typo for the capabilities register and remove extra
>   parentheses
> - v3: none
> - v2: none
>
>  drivers/mmc/host/sdhci-of-at91.c | 105 +++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 5959e394b416..b2a8c45c9c23 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -33,7 +33,14 @@
>
>  #define SDHCI_AT91_PRESET_COMMON_CONF  0x400 /* drv type B, programmable clock mode */
>
> +struct sdhci_at91_soc_data {
> +       const struct sdhci_pltfm_data *pdata;
> +       bool baseclk_is_generated_internally;
> +       unsigned int divider_for_baseclk;
> +};
> +
>  struct sdhci_at91_priv {
> +       const struct sdhci_at91_soc_data *soc_data;
>         struct clk *hclock;
>         struct clk *gck;
>         struct clk *mainck;
> @@ -141,12 +148,24 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>         .set_power              = sdhci_at91_set_power,
>  };
>
> -static const struct sdhci_pltfm_data soc_data_sama5d2 = {
> +static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
>         .ops = &sdhci_at91_sama5d2_ops,
>  };
>
> +static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
> +       .pdata = &sdhci_sama5d2_pdata,
> +       .baseclk_is_generated_internally = false,
> +};
> +
> +static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
> +       .pdata = &sdhci_sama5d2_pdata,
> +       .baseclk_is_generated_internally = true,
> +       .divider_for_baseclk = 2,
> +};
> +
>  static const struct of_device_id sdhci_at91_dt_match[] = {
>         { .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
> +       { .compatible = "microchip,sam9x60-sdhci", .data = &soc_data_sam9x60 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
> @@ -156,50 +175,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
>         unsigned int                    caps0, caps1;
>         unsigned int                    clk_base, clk_mul;
> -       unsigned int                    gck_rate, real_gck_rate;
> +       unsigned int                    gck_rate, clk_base_rate;
>         unsigned int                    preset_div;
>
> -       /*
> -        * The mult clock is provided by as a generated clock by the PMC
> -        * controller. In order to set the rate of gck, we have to get the
> -        * base clock rate and the clock mult from capabilities.
> -        */
>         clk_prepare_enable(priv->hclock);
>         caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>         caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> -       clk_base = (caps0 & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
> -       clk_mul = (caps1 & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;
> -       gck_rate = clk_base * 1000000 * (clk_mul + 1);
> -       ret = clk_set_rate(priv->gck, gck_rate);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set gck");
> -               clk_disable_unprepare(priv->hclock);
> -               return ret;
> -       }
> -       /*
> -        * We need to check if we have the requested rate for gck because in
> -        * some cases this rate could be not supported. If it happens, the rate
> -        * is the closest one gck can provide. We have to update the value
> -        * of clk mul.
> -        */
> -       real_gck_rate = clk_get_rate(priv->gck);
> -       if (real_gck_rate != gck_rate) {
> -               clk_mul = real_gck_rate / (clk_base * 1000000) - 1;
> -               caps1 &= (~SDHCI_CLOCK_MUL_MASK);
> -               caps1 |= ((clk_mul << SDHCI_CLOCK_MUL_SHIFT) &
> -                         SDHCI_CLOCK_MUL_MASK);
> -               /* Set capabilities in r/w mode. */
> -               writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN,
> -                      host->ioaddr + SDMMC_CACR);
> -               writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
> -               /* Set capabilities in ro mode. */
> -               writel(0, host->ioaddr + SDMMC_CACR);
> -               dev_info(dev, "update clk mul to %u as gck rate is %u Hz\n",
> -                        clk_mul, real_gck_rate);
> -       }
> +
> +       gck_rate = clk_get_rate(priv->gck);
> +       if (priv->soc_data->baseclk_is_generated_internally)
> +               clk_base_rate = gck_rate / priv->soc_data->divider_for_baseclk;
> +       else
> +               clk_base_rate = clk_get_rate(priv->mainck);
> +
> +       clk_base = clk_base_rate / 1000000;
> +       clk_mul = gck_rate / clk_base_rate - 1;
> +
> +       caps0 &= ~SDHCI_CLOCK_V3_BASE_MASK;
> +       caps0 |= (clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK;
> +       caps1 &= ~SDHCI_CLOCK_MUL_MASK;
> +       caps1 |= (clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK;
> +       /* Set capabilities in r/w mode. */
> +       writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
> +       writel(caps0, host->ioaddr + SDHCI_CAPABILITIES);
> +       writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
> +       /* Set capabilities in ro mode. */
> +       writel(0, host->ioaddr + SDMMC_CACR);
> +
> +       dev_info(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> +                clk_mul, gck_rate, clk_base_rate);
>
>         /*
>          * We have to set preset values because it depends on the clk_mul
> @@ -207,19 +213,19 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>          * maximum sd clock value is 120 MHz instead of 208 MHz. For that
>          * reason, we need to use presets to support SDR104.
>          */
> -       preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
> +       preset_div = DIV_ROUND_UP(gck_rate, 24000000) - 1;
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_SDR12);
> -       preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +       preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_SDR25);
> -       preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
> +       preset_div = DIV_ROUND_UP(gck_rate, 100000000) - 1;
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_SDR50);
> -       preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
> +       preset_div = DIV_ROUND_UP(gck_rate, 120000000) - 1;
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_SDR104);
> -       preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +       preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>
> @@ -314,7 +320,7 @@ static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
>  static int sdhci_at91_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id       *match;
> -       const struct sdhci_pltfm_data   *soc_data;
> +       const struct sdhci_at91_soc_data        *soc_data;
>         struct sdhci_host               *host;
>         struct sdhci_pltfm_host         *pltfm_host;
>         struct sdhci_at91_priv          *priv;
> @@ -325,17 +331,22 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         soc_data = match->data;
>
> -       host = sdhci_pltfm_init(pdev, soc_data, sizeof(*priv));
> +       host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
>         pltfm_host = sdhci_priv(host);
>         priv = sdhci_pltfm_priv(pltfm_host);
> +       priv->soc_data = soc_data;
>
>         priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
>         if (IS_ERR(priv->mainck)) {
> -               dev_err(&pdev->dev, "failed to get baseclk\n");
> -               return PTR_ERR(priv->mainck);
> +               if (soc_data->baseclk_is_generated_internally) {
> +                       priv->mainck = NULL;
> +               } else {
> +                       dev_err(&pdev->dev, "failed to get baseclk\n");
> +                       return PTR_ERR(priv->mainck);
> +               }
>         }
>
>         priv->hclock = devm_clk_get(&pdev->dev, "hclock");
> --
> 2.24.0
>
