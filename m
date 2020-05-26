Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063B81BF62E
	for <lists+linux-mmc@lfdr.de>; Thu, 30 Apr 2020 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD3LLF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 30 Apr 2020 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3LLE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 07:11:04 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C998C035495
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 04:11:04 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u12so2143002uau.10
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGQ7HEJMPitq5k4JWES0M6ZN7loGaGKzPDJ0dzbRiD0=;
        b=hEONr2YPgmyM7UtwlPoUd9Ry3bjW97+5NVE50dLmPT1ij4ap95JRc/P/fZ4ZSw70Zl
         Kvs0ZEJ5Tj2RLx4xylE6ueWL3vF7EUgEUFKDqbmC9itQbWfxF2HT6TSjqcguEqI6ajtY
         9DckUgdJPFB7OZYcoL8dqNlhqmyIcnjeefxBoRQqHYAzGizaNhggHBhjA1w2cmZYnIVO
         CUTAixhkRhz+FGayt16gFx1KU8ysBnnaGN75X1QWkQ1WN3Wh7Ng5O85dmdLj8aQNAqjY
         OtKGZUMGbJL2t5JlP5wRhgdpc1y2Ke4Urt8v4Dpe7WBpe3qBD/sXip8Ga6Ulf1zGENQM
         cGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGQ7HEJMPitq5k4JWES0M6ZN7loGaGKzPDJ0dzbRiD0=;
        b=WifljVwl2PLvdJe/gWfcOdOwcY6x3F7KvhCQ5Nilj/DNmtu2hXeLNT8R1DDsvsmOM6
         09AkC1ikkOheuUdRQCqqk7cey9gVtqcXM/E3HzXNHw/JFVMUcXYQZKFdzVwLHPWmn+v6
         Y/3fZggbazRd+u2K+9Qz0iPf2GaXsqU4V3UoaZLQobVVsPGSWCDbwohuMZMoNnbrR/31
         t5IyJx9/IiJvO5Df/0zGtOnsNMwYan8vMwXyYvMCHarQaChAOx+zpdEcZtFqeAXNOPm5
         SYL66Qj3nH4Y1CFYzaUnjhz/1Vaxj9sb9qnqBQtnluENJMx0/a8JbECQElzIQZpmvipK
         l1Aw==
X-Gm-Message-State: AGi0PubcjuN5XpS3oEYEVTjcNO+Xelz9yBo1HDchSypFJf7JtD7YGMwz
        G9gtXZ1iiSfbk8tY31D6Pf076L5mpoE/3gD3iHx62w==
X-Google-Smtp-Source: APiQypLv/CscUPIU0JrwToIQyrb8mmx1gfyx05WoSgrVPXEwIXy143BGmgl61F4V4uPx0RRkzcsIbUxve+Xxv5Nf76I=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr1909650uaa.15.1588245063374;
 Thu, 30 Apr 2020 04:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
 <20200428210229.703309-3-martin.blumenstingl@googlemail.com> <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Apr 2020 13:10:27 +0200
Message-ID: <CAPDyKFoEh8qKYFONo1SHnvwhDwjUa5bMnnT1Kbu8=4rd=T-8Kg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Stephen

On Thu, 30 Apr 2020 at 11:47, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Tue 28 Apr 2020 at 23:02, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
> > card interface with 1/4/8-bit bus width.
> > It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
> >
> > The public S805 datasheet [0] contains a short documentation about the
> > registers. Unfortunately it does not describe how to use the registers
> > to make the hardware work. Thus this driver is based on reading (and
> > understanding) the Amlogic 3.10 GPL kernel code.
> >
> > Some hardware details are not easy to see. Jianxin Pan was kind enough
> > to answer my questions:
> > The hardware has built-in busy timeout support. The maximum timeout is
> > 30 seconds. This is only documented in Amlogic's internal
> > documentation.
> >
> > The controller only works with very specific clock configurations. The
> > details are not part of the public datasheet. In my own words the
> > supported configurations are:
> > - 399.812kHz: clkin =  850MHz div = 2126 sd_rx_phase = 63
> > - 1MHz:               clkin =  850MHz div = 850  sd_rx_phase = 55
> > - 5.986MHz:   clkin =  850MHz div = 142  sd_rx_phase = 24
> > - 25MHz:      clkin =  850MHz div = 34   sd_rx_phase = 15
> > - 47.222MHz:  clkin =  850MHz div = 18   sd_rx_phase = 11/15 (SDR50/HS)
> > - 53.125MHz:  clkin =  850MHz div = 16   sd_rx_phase = (tuning)
> > - 70.833MHz:  clkin =  850MHz div = 12   sd_rx_phase = (tuning)
> > - 85MHz:      clkin =  850MHz div = 10   sd_rx_phase = (tuning)
> > - 94.44MHz:   clkin =  850MHz div = 9    sd_rx_phase = (tuning)
> > - 106.25MHz:  clkin =  850MHz div = 8    sd_rx_phase = (tuning)
> > - 127.5MHz:     clkin = 1275MHz div = 10   sd_rx_phase = (tuning)
> > - 141.667MHz:   clkin =  850MHz div = 6    sd_rx_phase = (tuning)
> > - 159.375MHz: clkin = 1275MHz div = 8    sd_rx_phase = (tuning)
> > - 212.5MHz:   clkin = 1275MHz div = 6    sd_rx_phase = (tuning)
> > - (sd_tx_phase is always 1, 94.44MHz is not listed in the datasheet
> >    but this is what the 3.10 BSP kernel on Odroid-C1 actually uses)
> >
> > NOTE: CMD23 support is disabled for now because it results in command
> > timeouts and thus decreases read performance.
> >
> > Tested-by: Wei Wang <lnykww@gmail.com>
> > Tested-by: Xin Yin <yinxin_1989@aliyun.com>
> > Reviewed-by: Xin Yin <yinxin_1989@aliyun.com>
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/mmc/host/Kconfig              |  14 +
> >  drivers/mmc/host/Makefile             |   1 +
> >  drivers/mmc/host/meson-mx-sdhc-clkc.c | 188 ++++++
> >  drivers/mmc/host/meson-mx-sdhc.c      | 916 ++++++++++++++++++++++++++
> >  drivers/mmc/host/meson-mx-sdhc.h      | 138 ++++
> >  5 files changed, 1257 insertions(+)
> >  create mode 100644 drivers/mmc/host/meson-mx-sdhc-clkc.c
> >  create mode 100644 drivers/mmc/host/meson-mx-sdhc.c
> >  create mode 100644 drivers/mmc/host/meson-mx-sdhc.h
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 462b5352fea7..df3fc572f842 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -405,6 +405,20 @@ config MMC_MESON_GX
> >
> >         If you have a controller with this interface, say Y here.
> >
> > +config MMC_MESON_MX_SDHC
> > +     tristate "Amlogic Meson SDHC Host Controller support"
> > +     depends on (ARM && ARCH_MESON) || COMPILE_TEST
> > +     depends on COMMON_CLK
> > +     depends on OF
> > +     help
> > +       This selects support for the SDHC Host Controller on
> > +       Amlogic Meson6, Meson8, Meson8b and Meson8m2 SoCs.
> > +       The controller supports the SD/SDIO Spec 3.x and eMMC Spec 4.5x
> > +       with 1, 4, and 8 bit bus widths.
> > +
> > +       If you have a controller with this interface, say Y or M here.
> > +       If unsure, say N.
> > +
> >  config MMC_MESON_MX_SDIO
> >       tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
> >       depends on ARCH_MESON || COMPILE_TEST
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index b929ef941208..8bcb420e071c 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -68,6 +68,7 @@ obj-$(CONFIG_MMC_VUB300)    += vub300.o
> >  obj-$(CONFIG_MMC_USHC)               += ushc.o
> >  obj-$(CONFIG_MMC_WMT)                += wmt-sdmmc.o
> >  obj-$(CONFIG_MMC_MESON_GX)   += meson-gx-mmc.o
> > +obj-$(CONFIG_MMC_MESON_MX_SDHC)      += meson-mx-sdhc-clkc.o meson-mx-sdhc.o
> >  obj-$(CONFIG_MMC_MESON_MX_SDIO)      += meson-mx-sdio.o
> >  obj-$(CONFIG_MMC_MOXART)     += moxart-mmc.o
> >  obj-$(CONFIG_MMC_SUNXI)              += sunxi-mmc.o
> > diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> > new file mode 100644
> > index 000000000000..1e9dea94f9dc
> > --- /dev/null
> > +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Amlogic Meson SDHC clock controller
> > + *
> > + * Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > + */
> > +
> > +#include <dt-bindings/clock/meson-mx-sdhc-clkc.h>
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "meson-mx-sdhc.h"
> > +
> > +#define MESON_SDHC_NUM_BUILTIN_CLKS  6
> > +
> > +struct meson_mx_sdhc_clkc {
> > +     struct clk_mux                  src_sel;
> > +     struct clk_divider              div;
> > +     struct clk_gate                 mod_clk_en;
> > +     struct clk_gate                 tx_clk_en;
> > +     struct clk_gate                 rx_clk_en;
> > +     struct clk_gate                 sd_clk_en;
> > +     struct clk_hw_onecell_data      hw_onecell_data;
> > +};
> > +
> > +static const struct clk_div_table meson_mx_sdhc_div_table[] = {
> > +     { .div = 6, .val = 5, },
> > +     { .div = 8, .val = 7, },
> > +     { .div = 9, .val = 8, },
> > +     { .div = 10, .val = 9, },
> > +     { .div = 12, .val = 11, },
> > +     { .div = 16, .val = 15, },
> > +     { .div = 18, .val = 17, },
> > +     { .div = 34, .val = 33, },
> > +     { .div = 142, .val = 141, },
> > +     { .div = 850, .val = 849, },
> > +     { .div = 2126, .val = 2125, },
> > +     { .div = 4096, .val = 4095, },
> > +     { /* sentinel */ }
> > +};
> > +
> > +static const struct meson_mx_sdhc_clkc meson_mx_sdhc_clkc_data = {
> > +     .src_sel = {
> > +             .mask = 0x3,
> > +             .shift = 16,
> > +     },
> > +     .div = {
> > +             .shift = 0,
> > +             .width = 12,
> > +             .table = meson_mx_sdhc_div_table,
> > +     },
> > +     .mod_clk_en = {
> > +             .bit_idx = 15,
> > +     },
> > +     .tx_clk_en = {
> > +             .bit_idx = 14,
> > +     },
> > +     .rx_clk_en = {
> > +             .bit_idx = 13,
> > +     },
> > +     .sd_clk_en = {
> > +             .bit_idx = 12,
> > +     },
> > +};
> > +
> > +static const struct clk_init_data meson_mx_sdhc_clkc_init_data[] = {
> > +     [SDHC_CLKID_SRC_SEL] = {
> > +             .name = "sdhc_src_sel",
> > +             .ops = &clk_mux_ops,
> > +             .parent_data = (const struct clk_parent_data[]) {
> > +                     { .fw_name = "clkin0" },
> > +                     { .fw_name = "clkin1" },
> > +                     { .fw_name = "clkin2" },
> > +                     { .fw_name = "clkin3" },
> > +             },
> > +             .num_parents = 4,
> > +     },
> > +     [SDHC_CLKID_DIV] = {
> > +             .name = "sdhc_div",
> > +             .ops = &clk_divider_ops,
> > +             .parent_hws = (const struct clk_hw *[]) {
> > +                     &meson_mx_sdhc_clkc_data.src_sel.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +     [SDHC_CLKID_MOD_CLK] = {
> > +             .name = "sdhc_mod_clk_on",
> > +             .ops = &clk_gate_ops,
> > +             .parent_hws = (const struct clk_hw *[]) {
> > +                     &meson_mx_sdhc_clkc_data.div.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +     [SDHC_CLKID_SD_CLK] = {
> > +             .name = "sdhc_tx_clk_on",
> > +             .ops = &clk_gate_ops,
> > +             .parent_hws = (const struct clk_hw *[]) {
> > +                     &meson_mx_sdhc_clkc_data.div.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +     [SDHC_CLKID_TX_CLK] = {
> > +             .name = "sdhc_rx_clk_on",
> > +             .ops = &clk_gate_ops,
> > +             .parent_hws = (const struct clk_hw *[]) {
> > +                     &meson_mx_sdhc_clkc_data.div.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +     [SDHC_CLKID_RX_CLK] = {
> > +             .name = "sdhc_sd_clk_on",
> > +             .ops = &clk_gate_ops,
> > +             .parent_hws = (const struct clk_hw *[]) {
> > +                     &meson_mx_sdhc_clkc_data.div.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
>
> That quite lot of structures.
> The interesting information is the parent and divider table mostly, and
> a few defines for the bit_idx.
>
> I feel this could be simplified so it is easier to follow.
> Maybe something in the same fashion as meson8b-dwmac driver ?
>
> > +
> > +int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base)
> > +{
> > +     const struct clk_hw *div_parents[1], *gate_parents[1];
> > +     struct clk_hw_onecell_data *onecell_data;
> > +     struct meson_mx_sdhc_clkc *clkc_data;
> > +     struct clk_init_data init_data;
> > +     int i, ret;
> > +
> > +     clkc_data = devm_kzalloc(dev, struct_size(clkc_data,
> > +                                               hw_onecell_data.hws,
> > +                                               MESON_SDHC_NUM_BUILTIN_CLKS),
> > +                              GFP_KERNEL);
> > +     if (!clkc_data)
> > +             return -ENOMEM;
> > +
> > +     memcpy(clkc_data, &meson_mx_sdhc_clkc_data,
> > +            sizeof(meson_mx_sdhc_clkc_data));
> > +
> > +     div_parents[0] = &clkc_data->src_sel.hw;
> > +     gate_parents[0] = &clkc_data->div.hw;
> > +
> > +     clkc_data->src_sel.reg = base + MESON_SDHC_CLKC;
> > +     clkc_data->div.reg = base + MESON_SDHC_CLKC;
> > +     clkc_data->mod_clk_en.reg = base + MESON_SDHC_CLKC;
> > +     clkc_data->sd_clk_en.reg = base + MESON_SDHC_CLKC;
> > +     clkc_data->tx_clk_en.reg = base + MESON_SDHC_CLKC;
> > +     clkc_data->rx_clk_en.reg = base + MESON_SDHC_CLKC;
> > +
> > +     onecell_data = &clkc_data->hw_onecell_data;
> > +     onecell_data->hws[SDHC_CLKID_SRC_SEL] = &clkc_data->src_sel.hw;
> > +     onecell_data->hws[SDHC_CLKID_DIV] = &clkc_data->div.hw;
> > +     onecell_data->hws[SDHC_CLKID_MOD_CLK] = &clkc_data->mod_clk_en.hw;
> > +     onecell_data->hws[SDHC_CLKID_SD_CLK] = &clkc_data->sd_clk_en.hw;
> > +     onecell_data->hws[SDHC_CLKID_TX_CLK] = &clkc_data->tx_clk_en.hw;
> > +     onecell_data->hws[SDHC_CLKID_RX_CLK] = &clkc_data->rx_clk_en.hw;
> > +
> > +     for (i = 0; i < MESON_SDHC_NUM_BUILTIN_CLKS; i++) {
> > +             init_data = meson_mx_sdhc_clkc_init_data[i];
> > +
> > +             if (i == SDHC_CLKID_SRC_SEL)
> > +                     /* uses clk_parent_data instead */
> > +                     init_data.parent_hws = NULL;
> > +             else if (i == SDHC_CLKID_DIV)
> > +                     init_data.parent_hws = div_parents;
> > +             else
> > +                     init_data.parent_hws = gate_parents;
> > +
> > +             onecell_data->hws[i]->init = &init_data;
> > +
> > +             ret = devm_clk_hw_register(dev, onecell_data->hws[i]);
> > +             if (ret) {
> > +                     dev_err(dev, "Registration of SDHC clock %d failed\n",
> > +                             i);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     onecell_data->num = MESON_SDHC_NUM_BUILTIN_CLKS;
> > +
> > +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                        onecell_data);
>
> I think registering a provider for a module that does not provide clocks
> to any other device is a bit overkill.
>
> I understand the matter is getting the per-user clk* pointer.
> Since this is the module registering the clock, you can use clk_hw->clk
> to get it.
>
> Once you have the clk* of the leaf clocks, you don't even need to keep
> track of the clk_hw* since you are using devm_
>
> Afterward, we should propably discuss with Stephen if something should
> be added in CCF to get a struct clk* from struct clk_hw*.
>

[...]

Hmm.

I am not sure the above is a good idea, at all. Unless, I am
misunderstanding your point, which may be the case.

I think above "shortcuts" could lead to abuse of the clock framework
and its internal data structures. When going forward, this could make
it unnecessary harder to maintain the clock framework.

I know, it's not my responsibility, but from my experience with MMC
and SDIO interfaces, is that those have been too easy abuse - since
most of the data structures and interfaces have been exported. Now,
it's hard to roll back that, if you see what I mean.

> > +}
> > diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc.c
> > new file mode 100644
> > index 000000000000..3c54d5f91fbc
> > --- /dev/null
> > +++ b/drivers/mmc/host/meson-mx-sdhc.c
> > @@ -0,0 +1,916 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Amlogic Meson6/Meson8/Meson8b/Meson8m2 SDHC MMC host controller driver.
> > + *
> > + * Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > + */

[...]

Kind regards
Uffe
