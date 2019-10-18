Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB28CDC32E
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408516AbfJRK4x (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:56:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42565 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408494AbfJRK4x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:56:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id r19so1580437uap.9
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY7lFyrHaU8+oA6DvMJgP3Iv+qTUAFJEzk1GXAvtrx4=;
        b=HWwssPuPT5PifwSCD5NhcePRn2f+ZzbP6zPPhLLPIw3Ba+ZwsY64t93AV6ZDoVRf+P
         GtEcP6AxKbDhZb4aeAXhFJ7LKwzQy18X9mLZzFjg3l69TZM656yqgPbVJe1ph0apblOH
         zpiHBA9MxyOptlT/ckRWBqs5RnQS0ZwMk32fBgNNHtl1egCvgygXRKzP6q9FYY7GgH4j
         IX3HP7sAZxr/FF+mPkYQ0A12D/gQTFKYnOU0ckK1PLfd2gCx2OBeFOMah5fjPMGgeYQX
         s0CdcKW3PYDu6Y1SJvqyv1FCph7SFawKTy3IaAPV+spKaEG5gmDGe/DWTffb4AK+u2zd
         4lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY7lFyrHaU8+oA6DvMJgP3Iv+qTUAFJEzk1GXAvtrx4=;
        b=b0p2g/YmVXzh7ZAEZIyNLBHP1V4BoFSJInCY2KuJNKOQuvnhEfKn4fdseLTtmjBgmW
         GB3ecHFsNHEGhlEE2WpDiPVqliWnaf29p09X9mtLQWg4pGM6BOzT5yQ94rP6PQBI1Jd/
         mUSdAgMI5g1H7aGFKV+Vhq/JMwDj7RP6h5PsqQFNZ/xAbe48jrhrxR0H9M4wY/1xoEY9
         s8o/+PnyyGebNoutoSti0qsN213mf6/Xjagu9u/udObHuCcD5oWSopeddBmQFcE/qK4l
         4Tnrx3j09LXQQelgp1uAc18doOWNBN2IVh3rBf4wWyFAvQ9iav48sYq5baOfIjsEvsXs
         GQBQ==
X-Gm-Message-State: APjAAAXQEJm1p+TdqcNBjRS+2OwyeQLJVT99m7hqKc5tIeV6sr0bazX7
        14yswIIJJWE9FdSJCnXQkMn4x8yjCKot7caKgtgJ8P1w
X-Google-Smtp-Source: APXvYqz/SShoa3XTS8voTIAQNQnZDjh0ea7364t7jbf47xMWfss+qljtsOER3sxNNKKBAIJ9tpVLe1gvmh+l/LbdV7A=
X-Received: by 2002:ab0:310f:: with SMTP id e15mr5136065ual.19.1571396211823;
 Fri, 18 Oct 2019 03:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191011103340.26749-1-ludovic.desroches@microchip.com>
In-Reply-To: <20191011103340.26749-1-ludovic.desroches@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:56:14 +0200
Message-ID: <CAPDyKFqxfBG-CDd_O9d8X89GZmNFXh=CoFE2QqptgtLtOU5=_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Oct 2019 at 12:33, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> There is a new compatible string for the SAM9X60 sdhci device. It involves
> an update of the properties about the clocks stuff.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

This doesn't apply any more, can you please re-spin it?

Kind regards
Uffe


> ---
>
> Changes:
> - v2: remove the extra example and fix node label
>
> This patch conflicts with Nicolas' one: "dt-bindings: sdhci-of-at91: add
> the microchip,sdcal-inverted property". Let me know which one has to be
> rebased or you can handle it.
>
> Ludovic
>
>
>  .../devicetree/bindings/mmc/sdhci-atmel.txt       | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 1b662d7171a0..5d541ad4d4eb 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,17 +5,26 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>
>  Required properties:
> -- compatible:          Must be "atmel,sama5d2-sdhci".
> +- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
>  - clocks:              Phandlers to the clocks.
> -- clock-names:         Must be "hclock", "multclk", "baseclk";
> +- clock-names:         Must be "hclock", "multclk", "baseclk" for
> +                       "atmel,sama5d2-sdhci".
> +                       Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> +
> +Optional properties:
> +- assigned-clocks:     The same with "multclk".
> +- assigned-clock-rates The rate of "multclk" in order to not rely on the
> +                       gck configuration set by previous components.
>
>
>  Example:
>
> -sdmmc0: sdio-host@a0000000 {
> +mmc0: sdio-host@a0000000 {
>         compatible = "atmel,sama5d2-sdhci";
>         reg = <0xa0000000 0x300>;
>         interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
>         clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
>         clock-names = "hclock", "multclk", "baseclk";
> +       assigned-clocks = <&sdmmc0_gclk>;
> +       assigned-clock-rates = <480000000>;
>  };
> --
> 2.23.0
>
