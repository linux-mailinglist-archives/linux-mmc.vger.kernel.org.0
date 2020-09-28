Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5794F27ABDC
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Sep 2020 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1Kej (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Sep 2020 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Kej (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 06:34:39 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FCC061755
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:39 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n193so1429281vkf.12
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCHYzzH+i6txI0brWFnBDLXKpVALX+5QwAw/VNoWNk8=;
        b=AUh5XapavrB6EGo5rdwT5udLEu+YwBMaOwZgoWWXd6Pqx9CltFokFdjkgKYye4+9vY
         AHJ3AABLLQ9v0/Cl5LJdUj86j9wXiNHFqyEmAPEFJvfwgEqHGlaZBAhJDsQu7M84sRlN
         37L1CJJF2+S6zbmft1LYfATSRm4kHvsu03IMo9DDjMGDy5mmbJ6gxsQjjOJihqA+Y1/v
         8D1rNjgMo6sDpkUVmoYNI8ZPlVIXroK41m25qwBYamG0EFIqA4ELMU/JgRoexFPe/QCm
         Mfd651S/aWUTU3/yCh3hlGIua7jLKLZIYrQayF2DHPJnMsK3EhIKK29Ll5+WJ9Lba7FJ
         5HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCHYzzH+i6txI0brWFnBDLXKpVALX+5QwAw/VNoWNk8=;
        b=b3P5WI+yfKUogrM1RgV4PNOs/YtnVGm9YmuLs038jB0ywg1HcdK7jEt16+CXD65i6j
         AS5A8mVl2ICH7uTL0E/Qugk7B3DisheEbEBAq4A5lhqebrRvLO+KrWzRP4qB6csKib38
         ghugCdUV/9wl3MI7eApXlhaulrDQpCzpGr/JicnGifknOWjc18F8JFOBq0ifUFGEwkup
         BZQ12KQ20UrxzK3H7Q1SumO5c4B45dBjgLw9zNln/cpm8jMmfTn6iqKt8xCqr4VSGThB
         ju6QvK1JXvQiSvtNIgQ5yaKLk5Vh2xUtJiLhTmM2/g+ZAXinXmWrobCLM03WMrGZZ9JT
         WPFg==
X-Gm-Message-State: AOAM53274DzG921h9QBe0iTVELx0cq3jq8FRLt4eWrJmNfPTQj/A1x1J
        SZLr8thL8ffAcpVOWlyTRXQnwINR4Gmt1BjICUltWQ==
X-Google-Smtp-Source: ABdhPJzVU+3l6V26RnGTk8PQ5DqzqBEXIyhs++xSEtv4+7R85m9ghPPjrHP2K8KQzSydrbU/jiC25XfDfjoajCcPLto=
X-Received: by 2002:ac5:cced:: with SMTP id k13mr4462650vkn.7.1601289278713;
 Mon, 28 Sep 2020 03:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200925164323.29843-1-rdunlap@infradead.org>
In-Reply-To: <20200925164323.29843-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:34:02 +0200
Message-ID: <CAPDyKFrT5S_0bfr0rnUU4V6kPHpfziCbUnGS8m-HK2cAaDJHcQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: fix depends for MMC_MESON_GX w/ COMPILE_TEST
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Sep 2020 at 18:43, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix build errors for meson-gx-mmc.c when CONFIG_COMMON_CLK is not
> set/enabled. This can happen when COMPILE_TEST is set/enabled.
>
> ERROR: modpost: "clk_divider_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "devm_clk_register" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "clk_mux_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "__clk_get_name" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
>
> Fixes: 54d8454436a2 ("mmc: host: Enable compile testing of multiple drivers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20200925.orig/drivers/mmc/host/Kconfig
> +++ linux-next-20200925/drivers/mmc/host/Kconfig
> @@ -425,6 +425,7 @@ config MMC_SDHCI_IPROC
>  config MMC_MESON_GX
>         tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
>         depends on ARCH_MESON|| COMPILE_TEST
> +       depends on COMMON_CLK
>         help
>           This selects support for the Amlogic SD/MMC Host Controller
>           found on the S905/GX*/AXG family of SoCs.  This controller is
