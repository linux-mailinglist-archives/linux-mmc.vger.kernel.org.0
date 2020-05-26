Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E501C8573
	for <lists+linux-mmc@lfdr.de>; Thu,  7 May 2020 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGJOS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 7 May 2020 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGJOR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 05:14:17 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D08C061A10
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 02:14:17 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id a7so1602565uak.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E6ejYXQUN6uQzwbNbptfYTXpYOYtmYYidXbTwdCfWY=;
        b=vEhraAJbTv8RAFZY/e4cHPEjDX53DT5gEwaBoH59G45xq21S9EpAYQplD5AZwX5H4n
         4Dtq1ThfW1FGMJCOJ4qg5opjeJ5kbWt+eKXQxSmng4SPfD1lKZGkwFvqWGy4FoVVQBUI
         AEkOlnIXasxCd55FUDW+E7HXuw7h9q8I6JR617TPj3UBG2f2x7Iwk2kxDF5lKbBzZdA1
         MHW9bTpzFHsakYZDriw0yR0XU/HKK8p/bbMpft54r5hn28CBSqovCbWYHBdzffcqEtXh
         dd06oJsClObeV4tc63MMOIxz3DW1dAALgLu3Fh6Nn4ziZu+jl/tdWTHXypsFazN2+XPv
         g3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E6ejYXQUN6uQzwbNbptfYTXpYOYtmYYidXbTwdCfWY=;
        b=DT7kZKyvf1DMCuq8NAlQY2ZXYVc2FsmMh8saTld1LSVR1QRixajsZccduye+mUQ4ej
         wtQ+XppvNgxnwVwm42/a02QThyoKOPOwjUoweCO5xWUVMRrMGkfgKifNUSnrvEaY97sH
         wWxCnu0ywq24CjxIyBKam4Tf+ilNUu+iZDPx+gvgpuh74cATmea7gtAIkeO9r24sfNIz
         qESiQI/uAu+se5Zjh5DdbwZjq0sqq0vrVqzIefiUI5vmSUQZJE8ydwGhTBxgdFW6aaZa
         vEKnuWAcFt45CeULZCi96yIYMfCaSl123a/1ztwPUkGyPBvbbIZBpZ4ZOA6Y2i24O8mI
         jbnQ==
X-Gm-Message-State: AGi0PuaRsqeFWMJKm/vUzxp6hqIq2dtLqyu3Ak6nzoWGM0ck70lmaTlO
        6sDyD+Igw3DzxWIl1Euqwqn6iuwbVWjt5rrvnT4pig==
X-Google-Smtp-Source: APiQypI983sHlqAADkZDiSmRnB5DMbwzB1bll4tCsPfQrvdRjXt4dgjRERmkrnOVhs2K+QsifHJGZ2fXU7TKYwPRyD8=
X-Received: by 2002:ab0:5ca:: with SMTP id e68mr1349295uae.19.1588842856207;
 Thu, 07 May 2020 02:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200501235907.3978-1-angelo.dureghello@timesys.com>
In-Reply-To: <20200501235907.3978-1-angelo.dureghello@timesys.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 May 2020 11:13:39 +0200
Message-ID: <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc controller
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Geert

On Sat, 2 May 2020 at 01:54, Angelo Dureghello
<angelo.dureghello@timesys.com> wrote:
>
> Add support for sdhci-edshc mmc controller.
>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
> Changes for v3:
> - removed volatile cast from clk.c
> ---
>  arch/m68k/coldfire/clk.c                    | 15 ++++++++++
>  arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
>  arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
>  arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
>  arch/m68k/include/asm/mcfclk.h              |  2 ++
>  include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
>  6 files changed, 95 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h

Not sure what's the best way to deal with this patch. I looped in
Geert to get some input.

If it looks okay and the risk is minimal for conflicts, I can carry it
via my tree, but then I need an ack from Geert.

Kind regards
Uffe

>
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 7bc666e482eb..8d048a72e173 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
>  #endif /* MCFPM_PPMCR1 */
>  #endif /* MCFPM_PPMCR0 */
>
> +static void __clk_enable2(struct clk *clk)
> +{
> +       __set_bit(clk->slot, MCFSDHC_CLK);
> +}
> +
> +static void __clk_disable2(struct clk *clk)
> +{
> +       __clear_bit(clk->slot, MCFSDHC_CLK);
> +}
> +
> +struct clk_ops clk_ops2 = {
> +       .enable         = __clk_enable2,
> +       .disable        = __clk_disable2,
> +};
> +
>  struct clk *clk_get(struct device *dev, const char *id)
>  {
>         const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index b4103b6bfdeb..9ef4ec0aea00 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -22,6 +22,7 @@
>  #include <asm/mcfqspi.h>
>  #include <linux/platform_data/edma.h>
>  #include <linux/platform_data/dma-mcf-edma.h>
> +#include <linux/platform_data/mmc-esdhc-mcf.h>
>
>  /*
>   *     All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> @@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
>                 .platform_data = &mcf_edma_data,
>         }
>  };
> -
>  #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
>
> +#if IS_ENABLED(CONFIG_MMC)
> +static struct mcf_esdhc_platform_data mcf_esdhc_data = {
> +       .max_bus_width = 4,
> +       .cd_type = ESDHC_CD_NONE,
> +};
> +
> +static struct resource mcf_esdhc_resources[] = {
> +       {
> +               .start = MCFSDHC_BASE,
> +               .end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
> +               .flags = IORESOURCE_MEM,
> +       }, {
> +               .start = MCF_IRQ_SDHC,
> +               .end = MCF_IRQ_SDHC,
> +               .flags = IORESOURCE_IRQ,
> +       },
> +};
> +
> +static struct platform_device mcf_esdhc = {
> +       .name                   = "sdhci-esdhc-mcf",
> +       .id                     = 0,
> +       .num_resources          = ARRAY_SIZE(mcf_esdhc_resources),
> +       .resource               = mcf_esdhc_resources,
> +       .dev.platform_data      = &mcf_esdhc_data,
> +};
> +#endif /* IS_ENABLED(CONFIG_MMC) */
> +
>  static struct platform_device *mcf_devices[] __initdata = {
>         &mcf_uart,
>  #if IS_ENABLED(CONFIG_FEC)
> @@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
>  #if IS_ENABLED(CONFIG_MCF_EDMA)
>         &mcf_edma,
>  #endif
> +#if IS_ENABLED(CONFIG_MMC)
> +       &mcf_esdhc,
> +#endif
>  };
>
>  /*
> @@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
>  }
>
>  arch_initcall(mcf_init_devices);
> -
> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> index 5bd24c9b865d..ffa02de1a3fb 100644
> --- a/arch/m68k/coldfire/m5441x.c
> +++ b/arch/m68k/coldfire/m5441x.c
> @@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
>  DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
>  DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
>  DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
> -DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
> +DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
>  DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
>  DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
>  DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
> @@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
>  DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
>  DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
>
> +DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
> +DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
> +DEFINE_CLK(2, "per.0", 2, MCF_CLK);
> +
>  struct clk *mcf_clks[] = {
>         &__clk_0_2,
>         &__clk_0_8,
> @@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
>         &__clk_1_34,
>         &__clk_1_36,
>         &__clk_1_37,
> +
> +       &__clk_2_0,
> +       &__clk_2_1,
> +       &__clk_2_2,
> +
>         NULL,
>  };
>
> @@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
>         &__clk_0_33, /* pit.1 */
>         &__clk_0_37, /* eport */
>         &__clk_0_48, /* pll */
> +       &__clk_0_51, /* esdhc */
>
>         &__clk_1_36, /* CCM/reset module/Power management */
>         &__clk_1_37, /* gpio */
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> index 4892f314ff38..750555a6fa87 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -278,6 +278,17 @@
>  #define MCFGPIO_IRQ_VECBASE    (MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
>  #define MCFGPIO_PIN_MAX                87
>
> +/*********************************************************************
> + *
> + * Phase Locked Loop (PLL)
> + *
> + *********************************************************************/
> +
> +/* Register read/write macros */
> +#define MCF_PLL_CR             0xFC0C0000
> +#define MCF_PLL_DR             0xFC0C0004
> +#define MCF_PLL_SR             0xFC0C0008
> +
>  /*
>   *  DSPI module.
>   */
> @@ -298,5 +309,13 @@
>  #define MCFEDMA_IRQ_INTR16     (MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
>  #define MCFEDMA_IRQ_INTR56     (MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
>  #define MCFEDMA_IRQ_ERR        (MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
> +/*
> + *  esdhc module.
> + */
> +#define MCFSDHC_BASE           0xfc0cc000
> +#define MCFSDHC_SIZE           256
> +#define MCFINT2_SDHC           31
> +#define MCF_IRQ_SDHC           (MCFINT2_VECBASE + MCFINT2_SDHC)
> +#define MCFSDHC_CLK            (MCFSDHC_BASE + 0x2c)
>
>  #endif /* m5441xsim_h */
> diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
> index 0aca504fae31..722627e06d66 100644
> --- a/arch/m68k/include/asm/mcfclk.h
> +++ b/arch/m68k/include/asm/mcfclk.h
> @@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
>  extern struct clk_ops clk_ops1;
>  #endif /* MCFPM_PPMCR1 */
>
> +extern struct clk_ops clk_ops2;
> +
>  #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
>  static struct clk __clk_##clk_bank##_##clk_slot = { \
>         .name = clk_name, \
> diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
> new file mode 100644
> index 000000000000..85cb786a62fe
> --- /dev/null
> +++ b/include/linux/platform_data/mmc-esdhc-mcf.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> +#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> +
> +enum cd_types {
> +       ESDHC_CD_NONE,          /* no CD, neither controller nor gpio */
> +       ESDHC_CD_CONTROLLER,    /* mmc controller internal CD */
> +       ESDHC_CD_PERMANENT,     /* no CD, card permanently wired to host */
> +};
> +
> +struct mcf_esdhc_platform_data {
> +       int max_bus_width;
> +       int cd_type;
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
> --
> 2.26.0
>
