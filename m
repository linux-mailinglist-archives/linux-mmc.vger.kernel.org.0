Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7E697B82
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Feb 2023 13:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjBOMMY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Feb 2023 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjBOMMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 07:12:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDB33465
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:12:22 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E3EA33F4A8
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676463139;
        bh=d2HVhvClqqd8WHxTQTRIymEsBK4G3tyKOtWAvm3jRPM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QhPZ1QoZz/LWBNLn6cSWQx/wvjpmTCGPPdhZJD/JOO1UzG/AC7Jc0md4qZm0cdgz2
         FGm3hiCGnoMpd3rtdiuU5rq0Ulha1NBdgxuI9pZcn/qvi0afd9EACuKmD6wMWqi9ZD
         TIzxqaM4ZHOMY606QP3JbOa3yBSY0LvqSnqkzlvl9+lSB0uAwBkql74z25e3DmxwEd
         Sw4h+k5N/3r7fYRTQ7vlS0I758JMU4T572qmW3MmZXJZwsBGlI39a3MJeDxlUH4iq5
         K3jRgyECzU+RPVdwt3xu94rvtPEmNCQx6FZHsYAEy3ds4X9ixZRBJblTxhfhIq+qt+
         h33gaJ4PwPIeQ==
Received: by mail-qt1-f198.google.com with SMTP id i5-20020ac813c5000000b003b86b748aadso11080404qtj.14
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676463139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2HVhvClqqd8WHxTQTRIymEsBK4G3tyKOtWAvm3jRPM=;
        b=Akdk4JIPJ6+NY3LVs4scUvj4RAUqNFLs9KbYN5FCW2gQ3MNqDWdGDAp0PKId0oH7a3
         d0jhLT3/KOLHA6b4XxyRYMXIQit2jKqGAvqMmq3t8RdjH/fxcsEFrztPvWV7GWhzQGgX
         /1G6x8DpVfHVJ6W/BxvDLagvlP3LMG/cG6te0zUK35+c5jxeMiYl9rAz2JnaDsGYWQCT
         xDp7rmXp4xavEHcgxd7IltKIPyM/XXLqTfPvIBXGExl2CjscogZwUh496GFWq5wNuYMZ
         8Dt2nCpkgtE8KeCxGt/CIhjBAuS7Cefun5IzQ+l/uST0Omn7fBmlOR2QH4Bm26XApN+L
         1DuQ==
X-Gm-Message-State: AO0yUKWDL/bq9TRU5XroLpTe0QAnYLHgEJtPzgpECqARtsp9/J/JPv6r
        fl0ng00EIr2/WF0vg01YS8aJ8h+2pP2B1jieBk5QL4A6BTE1l0vHbkvPTt4/elAy+xFsXJvefdV
        KNlhfGrZ3Q+vUGe7zfkWkVfta6YpGrgyK+3Tb6ta/JAQ6RZjv2+mNdA==
X-Received: by 2002:a0c:aa99:0:b0:56e:9a77:3d2c with SMTP id f25-20020a0caa99000000b0056e9a773d2cmr120699qvb.5.1676463138968;
        Wed, 15 Feb 2023 04:12:18 -0800 (PST)
X-Google-Smtp-Source: AK7set94W4bHbLWyqqCBU/wia3LQtnIJnTfo8vvQ0Q6eIDjwkquQyW4opvnzwzhSgOt3jgiSN6xmjaU6v/LfsoIKTM0=
X-Received: by 2002:a0c:aa99:0:b0:56e:9a77:3d2c with SMTP id
 f25-20020a0caa99000000b0056e9a773d2cmr120692qvb.5.1676463138706; Wed, 15 Feb
 2023 04:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com> <20230215113249.47727-4-william.qiu@starfivetech.com>
In-Reply-To: <20230215113249.47727-4-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 13:12:01 +0100
Message-ID: <CAJM55Z8gVEZS4Ws2Gi7_JbdkS-4y3_8mQvR4ZxLCWZ4A1y9X1g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 12:35, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Add the mmc node for the StarFive JH7110 SoC.
> Set mmco node to emmc and set mmc1 node to sd.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 23 +++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 47 +++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index c60280b89c73..e1a0248e907f 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -42,6 +42,29 @@ &rtc_osc {
>         clock-frequency = <32768>;
>  };
>
> +&mmc0 {
> +       max-frequency = <100000000>;
> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       non-removable;
> +       cap-mmc-hw-reset;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};
> +
> +&mmc1 {
> +       max-frequency = <100000000>;
> +       bus-width = <4>;
> +       no-sdio;
> +       no-mmc;
> +       broken-cd;
> +       cap-sd-highspeed;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};
> +
>  &gmac0_rmii_refin {
>         clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 64d260ea1f29..17f7b3ee6ca3 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -314,6 +314,11 @@ uart2: serial@10020000 {
>                         status = "disabled";
>                 };
>
> +               stg_syscon: syscon@10240000 {
> +                       compatible = "starfive,jh7110-stg-syscon", "syscon";
> +                       reg = <0x0 0x10240000 0x0 0x1000>;
> +               };
> +
>                 uart3: serial@12000000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x0 0x12000000 0x0 0x10000>;
> @@ -370,6 +375,11 @@ syscrg: clock-controller@13020000 {
>                         #reset-cells = <1>;
>                 };
>
> +               sys_syscon: syscon@13030000 {
> +                       compatible = "starfive,jh7110-sys-syscon", "syscon";
> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> +               };
> +
>                 gpio: gpio@13040000 {
>                         compatible = "starfive,jh7110-sys-pinctrl";
>                         reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -397,6 +407,11 @@ aoncrg: clock-controller@17000000 {
>                         #reset-cells = <1>;
>                 };
>
> +               aon_syscon: syscon@17010000 {
> +                       compatible = "starfive,jh7110-aon-syscon", "syscon";
> +                       reg = <0x0 0x17010000 0x0 0x1000>;
> +               };
> +
>                 gpioa: gpio@17020000 {
>                         compatible = "starfive,jh7110-aon-pinctrl";
>                         reg = <0x0 0x17020000 0x0 0x10000>;
> @@ -407,5 +422,37 @@ gpioa: gpio@17020000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                 };
> +
> +               mmc0: mmc@16010000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16010000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <74>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
> +                       status = "disabled";
> +               };
> +
> +               mmc1: mmc@16020000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16020000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <75>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
> +                       status = "disabled";
> +               };

Hi William,

These nodes still don't seem to be sorted by address, eg. by the
number after the @
Also please move the dt-binding patch before this one, so dtb_check
won't fail no matter where git bisect happens to land.

/Emil

>         };
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
