Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25B79D1FE
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Sep 2023 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjILNXs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Sep 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjILNXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 09:23:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641910CA
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 06:23:43 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38DCD3F185
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694525022;
        bh=5Lxiti3504/sLyp6T4S9ryQpCZcLlVdHH9n53WPzN64=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JR2/VTNmKqgZr3X+J+U7tyaP2bK4NiL8N9otbebnPBmVTvb+pB4BN8jgdsx2EG58S
         ozBerDRenqkMxJbJxlBE7QsfSFr6Yv3iwaN+E6rmDY94F0NylGyl5OJzDb+YJKWEw+
         7qPWuPUIM7KYij4XTnpjrTgMkH1O64+XuATZmsfLEtBd7xhoEHC//d/wR7EPHNh3pc
         5UAj1t28oYs1pEV4YUfeT+CArRMdobOBRTH3nqYlA4xO0LmhHoZMMZse4cMDnWt5CP
         Yp/PmmEFoxCB8m0rWw2XqXceoFGRfesmXDBPIwYkITZnsOCUyYwSZi9PFDdDhqG+jd
         dZ6oT2urTPIjg==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3aa164dd2d1so6142976b6e.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 06:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525021; x=1695129821;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Lxiti3504/sLyp6T4S9ryQpCZcLlVdHH9n53WPzN64=;
        b=gDa9369GsIBw22yy7K87SdNCyUdymR8fVGklhiiEg6jnMtos2cYpyAV5lj++H3QgDU
         voZ/3BI3J0kF7Kef2GWeFPH9AsSOPcFuiy2QtpfbtZygyiRBRkOIDEsbj5EhK8F1I3LD
         so1fmAeHr2mDrLJZ8lbCzprv80kglBLdS6qqbhuhBIVhO1sm27bxgTaLEsrIP1ujv8lc
         y7n2MNb7vuJRfpW7yAkUSAs2Rx55213jqiXwWDjzaOLB8ceUnA2HGBOj7sv7NZDt7qTI
         YEfgL8P+kNlpuOUYU7DPHopCPpkDuX4xxbQzTJ6kym50xe7KBgcQeFJGgZtWBmhFKx5r
         pypw==
X-Gm-Message-State: AOJu0YwqFuGYdYrxf1m/ZflC/SrrK8fPwDh3c6Zf1osMe3wgfhqqmVax
        E9VcKI2ImSlGyQCbUhCk8k1JtcMmN3M2Io3xFnlzi9JtCze5dDD9OfPKc/fhrfbPgWLThPjJ6lI
        jmvEqi5mQl1WK6CJhef9eCDk+DNpWSQNfwnWJvWY3SHKpXrMqnnEgpw==
X-Received: by 2002:a05:6808:2394:b0:3a7:72e8:2728 with SMTP id bp20-20020a056808239400b003a772e82728mr16500927oib.36.1694525021079;
        Tue, 12 Sep 2023 06:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaUEsbuPdJZYyDwnlg26xZulU68nzVT5NwGrT5q6SFOIuKio1J4UMpbDyFSeywa38u/Cm3m/nJRvaJkVWQaSY=
X-Received: by 2002:a05:6808:2394:b0:3a7:72e8:2728 with SMTP id
 bp20-20020a056808239400b003a772e82728mr16500907oib.36.1694525020862; Tue, 12
 Sep 2023 06:23:40 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 06:23:40 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230912081402.51477-7-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com> <20230912081402.51477-7-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 06:23:40 -0700
Message-ID: <CAJM55Z-_V6Ty61u1bF=BziBRwn7bzTygE02g_4B3UW9tG4yikw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Drop unused properties and
 limit frquency
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

William Qiu wrote:
> Drop unused properties and limit cclk_in to 50M, thus cancelling the
> internal frequency and adopting the by-pass mode.

That's two unrelated changes which should really be in different patches. But
again the hardware still has the relevant field in the syscon registers even if
the driver doesn't use it, so maybe just leave them and just keep this patch
adding the assigned-clock* properties.

/Emil

>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi                      | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index d79f94432b27..d1f2ec308bca 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -205,6 +205,8 @@ &i2c6 {
>
>  &mmc0 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> @@ -221,6 +223,8 @@ &mmc0 {
>
>  &mmc1 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	no-sdio;
>  	no-mmc;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index e85464c328d0..7b8e841aeef8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -870,7 +870,6 @@ mmc0: mmc@16010000 {
>  			fifo-depth = <32>;
>  			fifo-watermark-aligned;
>  			data-addr = <0>;
> -			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
>  			status = "disabled";
>  		};
>
> @@ -886,7 +885,6 @@ mmc1: mmc@16020000 {
>  			fifo-depth = <32>;
>  			fifo-watermark-aligned;
>  			data-addr = <0>;
> -			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
>  			status = "disabled";
>  		};
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
