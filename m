Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36011E077
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfD2KYy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:24:54 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42211 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfD2KYy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:24:54 -0400
Received: by mail-ua1-f66.google.com with SMTP id h4so3295162uaj.9
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPCG35Z0sQWoCgRDLwq42tnfmX+wifRoA3FWD5hwxvc=;
        b=tLB4/F4wex0McW37xwqLzfYZqBfhM+Bg+Pvur+3g8qDeYazjWIQy/lz5m0zk/FCQVQ
         XmOtG+UkXnucGqOpekVmieTSCQDorVC/eeJo4j7pRneQgx/AAWdFucmgRQomE6QmtBKC
         I8ddOlX8EfNwRcQOh4KXqy9HVAFzvv46Mu/YDmYD5GazbztlELwz2tEZxc7huSZj/8F1
         lH3mIhuq7CJVwV1LlCzLCJ1f6adSoUq7d212wKYvvqeBRXvpswVN/3dkL0jKxw11MVHl
         j8fUCB5zAQbbieIR089A55ltNxZ8UixUQ3weKX76eUudDUTdTm0Yin/Q8GaFLAM7myjb
         RI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPCG35Z0sQWoCgRDLwq42tnfmX+wifRoA3FWD5hwxvc=;
        b=GgIx4PyTrLhPwpmvqoIpWfc1IHygzkyljc7YeCVA7olkJ47+gJiDFFlDdafifERxFn
         VSQr9ug0Y4K3p7a5ERMabiuMyaQt1nN//J2XPrLobour85H4wM/w6kaRM/t6pDWJEdJi
         R4nmHWjKVLAzyjStLe4W5p867G9h/4XwDBJrMDyDQJxzGhHerHFxF4nP705ldwKYhjF3
         kyWqQ8EC5BzzcNAg3GVfdpobN11a1fZax2EwZnMDgLbbiEY7HxbfvAOvRLfBDmyaGddd
         0A6+hBi4x7ngXmxVcuoXhaw9iGZ/DCeK7eppiW69jvbPeYxFTEKVKzgEPaLGW2KDJzVZ
         Mz1A==
X-Gm-Message-State: APjAAAV2NwvQ348HnUSUallC9PnNjH1RdnpJYxdgmN47+cOZ1yz83JHk
        fbw1ssKg0n9Wmq+elu6IVYTw1o7PuT3CNSH90FFxyw==
X-Google-Smtp-Source: APXvYqxF1WTtM1rV78s3KnjLyCxrofhMMER4xv6KhDMnpmQc+hYEaAbnXgGlRozcA1Fl3/o8EkKoGfFL2x0giENTDUE=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr5482164uar.15.1556533492970;
 Mon, 29 Apr 2019 03:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:24:16 +0200
Message-ID: <CAPDyKFouv1MDJXwDryqhC=X4mLycoAigB3x6Xee09U+QNGTa-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
To:     Takao Orito <orito.takao@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Apr 2019 at 04:04, Takao Orito <orito.takao@socionext.com> wrote:
>
> Signed-off-by: Takao Orito <orito.takao@socionext.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> new file mode 100644
> index 0000000..7008462
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> @@ -0,0 +1,35 @@
> +* SOCIONEXT SDHCI controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci_milbeaut driver.
> +
> +Required properties:
> +- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
> +- clocks: Must contain an entry for each entry in clock-names. It is a
> +  list of phandles and clock-specifier pairs.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain the following two entries:
> +       "iface" - clock used for sdhci interface
> +       "core"  - core clock for sdhci controller
> +
> +Optional properties:
> +- vqmmc-supply: phandle to the regulator device tree node, mentioned
> +  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> +  requires the CMD_DAT_DELAY control to be enabled.
> +- sni,mmc-power-gpio: set property indicating that power on or off needs
> +  control of gpios.

Please use a vmmc-supply instead of "power-gpio" (which means you need
to model this as a fixed GPIO regulator).

> +
> +Example:
> +       sdhci3: mmc@1b010000 {
> +               compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +               reg = <0x1b010000 0x10000>;
> +               interrupts = <0 265 0x4>;
> +               voltage-ranges = <3300 3300>;
> +               bus-width = <4>;
> +               clocks = <&clk 7>, <&ahb_clk>;
> +               clock-names = "core", "iface";
> +               cap-sdio-irq;
> +               sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
> +                       fujitsu,cmd-dat-delay-select;
> +       };
> --
> 1.9.1
>
>

Kind regards
Uffe
