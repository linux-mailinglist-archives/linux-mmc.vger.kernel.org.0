Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88E53A2C5
	for <lists+linux-mmc@lfdr.de>; Wed,  1 Jun 2022 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352097AbiFAKhe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 Jun 2022 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350946AbiFAKhd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 06:37:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D67DE01
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 03:37:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f9so2930775ejc.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ruEUCSVI7DrtQBKLY2P/BRfRHzEPjLfTcPMRiBcXzxs=;
        b=h24fq2usbxQVcqEw6DGDW0eZ2ERV7MD892u/63S0jJwGxx6Wn5FflSWhBQry3IQ3nS
         ZnZJtRDkjJIEbohMRxw3HQ9fX8FHFmGG+cOvg1L3pXi9I5f9cFD2lpBfSSyOFt25wQe/
         Ni0/GJ7rR33SGd9u4Y5767VWUwbGbNBTADH1fA6lFkaA4j7jtVa2DqXXAFNOExzmFDuh
         1Fx3Y8TbVOTVqjHXysKhsYb72Ai1d7v5pY1F68lbHJNjStGzQoRRF4gN6PvmdJcuVg/O
         UWYiOGIVDWet4uK+J1v+LT4etuFqbeo3e7or6vc5Mx+E9S16kkJSzn1MuBmkYupIWdrG
         CpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ruEUCSVI7DrtQBKLY2P/BRfRHzEPjLfTcPMRiBcXzxs=;
        b=LpbA24Lt9Si9OyTxiEMGyDMDWGAUzl/i759DcgqMOyP+AYcYZBpiiyzXYLuD+Knl3Z
         s9awSQTMpE+lBLeAxBC901As4pBHVx0FscBwn5Wpe8e9WijizquwNxR1LgWfKyiQ9qHE
         oaUkGqt39JF7lK0bW7UBvz0GCybYQY2j30uGlR67Mu+FiMuwd6+4StJYcZ4FIxMqexVE
         9sTRy0di+kp2VCqj0oEkldQl/gDNOkym7VIa2DgbmH9lA5fW/xVfayEVXEroRJA2mQci
         v+JmEbrrtLPabfH8pLUFYKWLIC3mHDjLS3OANsUfrwfZfI9V/EBVyni3Uo/8E8HrlK3N
         Hd6Q==
X-Gm-Message-State: AOAM533VLZPVOj+M7aqRm6pfrS7nmS5Cn8G964RyLemqyO5cKMbTuuCK
        H/vXtGnLskagMo8WldXWvghDQg==
X-Google-Smtp-Source: ABdhPJymR4UxpYx6yrnq9yd4MIP5Ez/fF2GGavM4Y9vDkkKM4TXqy33Vd7y5qv7GtbYocdiNRc433A==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr57466759ejc.671.1654079845460;
        Wed, 01 Jun 2022 03:37:25 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b0042aad9edc9bsm743623edr.71.2022.06.01.03.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:37:24 -0700 (PDT)
Message-ID: <2f7be7c4-9e61-7285-803b-979af6d28c11@linaro.org>
Date:   Wed, 1 Jun 2022 12:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 16/17] arm64: dts: mediatek: add mt8365 device-tree
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-17-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-17-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add device-tree for the MT8365 SoC. More information can be found
> about that SoC at the following address:
> https://www.mediatek.com/products/aiot/i350-mt8365
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi | 1047 ++++++++++++++++++++++
>  1 file changed, 1047 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> new file mode 100644
> index 000000000000..e22b1d259418
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -0,0 +1,1047 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/power/mt8365-power.h>
> +#include <dt-bindings/memory/mt8365-larb-port.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "mediatek,mt8365";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		ovl0 = &ovl0;
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +		color0 = &color0;
> +		ccorr0 = &ccorr0;
> +		aal0 = &aal0;
> +		gamma0 = &gamma0;
> +		dither0 = &dither0;
> +		dsi0 = &dsi0;
> +		dpi0 = &dpi0;
> +	};
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0: cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			clock-frequency = <1600000000>;
> +			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			clock-frequency = <1600000000>;
> +			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate", "armpll";
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			clock-frequency = <1600000000>;
> +			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate", "armpll";
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			clock-frequency = <1600000000>;
> +			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate", "armpll";
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	cluster0_opp: opp-table-0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp-850000000 {
> +			opp-hz = /bits/ 64 <850000000>;
> +			opp-microvolt = <650000>;
> +		};
> +		opp-918000000 {
> +			opp-hz = /bits/ 64 <918000000>;
> +			opp-microvolt = <668750>;
> +		};
> +		opp-987000000 {
> +			opp-hz = /bits/ 64 <987000000>;
> +			opp-microvolt = <687500>;
> +		};
> +		opp-1056000000 {
> +			opp-hz = /bits/ 64 <1056000000>;
> +			opp-microvolt = <706250>;
> +		};
> +		opp-1125000000 {
> +			opp-hz = /bits/ 64 <1125000000>;
> +			opp-microvolt = <725000>;
> +		};
> +		opp-1216000000 {
> +			opp-hz = /bits/ 64 <1216000000>;
> +			opp-microvolt = <750000>;
> +		};
> +		opp-1308000000 {
> +			opp-hz = /bits/ 64 <1308000000>;
> +			opp-microvolt = <775000>;
> +		};
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp-1466000000 {
> +			opp-hz = /bits/ 64 <1466000000>;
> +			opp-microvolt = <825000>;
> +		};
> +		opp-1533000000 {
> +			opp-hz = /bits/ 64 <1533000000>;
> +			opp-microvolt = <850000>;
> +		};
> +		opp-1633000000 {
> +			opp-hz = /bits/ 64 <1633000000>;
> +			opp-microvolt = <887500>;
> +		};
> +		opp-1700000000 {
> +			opp-hz = /bits/ 64 <1700000000>;
> +			opp-microvolt = <912500>;
> +		};
> +		opp-1767000000 {
> +			opp-hz = /bits/ 64 <1767000000>;
> +			opp-microvolt = <937500>;
> +		};
> +		opp-1834000000 {
> +			opp-hz = /bits/ 64 <1834000000>;
> +			opp-microvolt = <962500>;
> +		};
> +		opp-1917000000 {
> +			opp-hz = /bits/ 64 <1917000000>;
> +			opp-microvolt = <993750>;
> +		};
> +		opp-2001000000 {
> +			opp-hz = /bits/ 64 <2001000000>;
> +			opp-microvolt = <1025000>;
> +		};
> +	};
> +
> +	clk26m: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;

This does not look like property of a SoC. Are you sure MT8365 SoC has
this clock (not the board)?

> +		clock-output-names = "clk26m";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@43000000 {
> +			no-map;
> +			reg = <0 0x43000000 0 0x20000>;
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;

Why do you have four cells here (and passing 0 as interrupt)?

> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x80000>,
> +			      <0 0x0c080000 0 0x80000>;
> +
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8365-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: syscon@10001000 {
> +			compatible = "mediatek,mt8365-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8365-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		syscfg_pctl: syscfg-pctl@10005000 {

This is I guess also syscon, like other nodes?

> +			compatible = "syscon";

You need specific compatible. Please run `make dtbs_check` and fix the
errors.

> +			reg = <0 0x10005000 0 0x1000>;
> +		};
> +
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";

You need specific compatible.

> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;

This is definitely wrong now. It's not a simple-mfd device, so please do
not use that property.

> +
> +			/* System Power Manager */
> +			spm: power-controller {
> +				compatible = "mediatek,mt8365-power-controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domains of the SoC */

The comment suggests you will later add here power domains not for the
SoC. If that's not true, just skip the comment.

> +				power-domain@MT8365_POWER_DOMAIN_MM {
> +					reg = <MT8365_POWER_DOMAIN_MM>;
> +					clocks = <&topckgen CLK_TOP_MM_SEL>,
> +						 <&mmsys CLK_MM_MM_SMI_COMMON>,
> +						 <&mmsys CLK_MM_MM_SMI_COMM0>,
> +						 <&mmsys CLK_MM_MM_SMI_COMM1>,
> +						 <&mmsys CLK_MM_MM_SMI_LARB0>;
> +					clock-names = "mm", "mm-0", "mm-1",
> +						      "mm-2", "mm-3";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +					mediatek,infracfg_nao = <&infracfg_nao>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					power-domain@MT8365_POWER_DOMAIN_CAM {
> +						reg = <MT8365_POWER_DOMAIN_CAM>;
> +						clocks = <&camsys CLK_CAM_LARB2>,
> +							 <&camsys CLK_CAM_SENIF>,
> +							 <&camsys CLK_CAMSV0>,
> +							 <&camsys CLK_CAMSV1>,
> +							 <&camsys CLK_CAM_FDVT>,
> +							 <&camsys CLK_CAM_WPE>;
> +						clock-names = "cam-0", "cam-1",
> +							      "cam-2", "cam-3",
> +							      "cam-4", "cam-5";
> +						#power-domain-cells = <0>;
> +						mediatek,infracfg = <&infracfg>;
> +						mediatek,smi = <&smi_common>;
> +					};
> +
> +					power-domain@MT8365_POWER_DOMAIN_VDEC {
> +						reg = <MT8365_POWER_DOMAIN_VDEC>;
> +						#power-domain-cells = <0>;
> +						mediatek,smi = <&smi_common>;
> +					};
> +
> +					power-domain@MT8365_POWER_DOMAIN_VENC {
> +						reg = <MT8365_POWER_DOMAIN_VENC>;
> +						#power-domain-cells = <0>;
> +						mediatek,smi = <&smi_common>;
> +					};
> +
> +					power-domain@MT8365_POWER_DOMAIN_APU {
> +						reg = <MT8365_POWER_DOMAIN_APU>;
> +						clocks = <&infracfg CLK_IFR_APU_AXI>,
> +							 <&apu CLK_APU_IPU_CK>,
> +							 <&apu CLK_APU_AXI>,
> +							 <&apu CLK_APU_JTAG>,
> +							 <&apu CLK_APU_IF_CK>,
> +							 <&apu CLK_APU_EDMA>,
> +							 <&apu CLK_APU_AHB>;
> +						clock-names = "apu", "apu-0",
> +							      "apu-1", "apu-2",
> +							      "apu-3", "apu-4",
> +							      "apu-5";
> +						#power-domain-cells = <0>;
> +						mediatek,infracfg = <&infracfg>;
> +						mediatek,smi = <&smi_common>;
> +					};
> +				};
> +
> +				power-domain@MT8365_POWER_DOMAIN_CONN {
> +					reg = <MT8365_POWER_DOMAIN_CONN>;
> +					clocks = <&topckgen CLK_TOP_CONN_32K>,
> +						 <&topckgen CLK_TOP_CONN_26M>;
> +					clock-names = "conn", "conn1";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +
> +				power-domain@MT8365_POWER_DOMAIN_MFG {
> +					reg = <MT8365_POWER_DOMAIN_MFG>;
> +					clocks = <&topckgen CLK_TOP_MFG_SEL>;
> +					clock-names = "mfg";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +
> +				power-domain@MT8365_POWER_DOMAIN_AUDIO {
> +					reg = <MT8365_POWER_DOMAIN_AUDIO>;
> +					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +						 <&infracfg CLK_IFR_AUDIO>,
> +						 <&infracfg CLK_IFR_AUD_26M_BK>;
> +					clock-names = "audio", "audio1", "audio2";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +
> +				power-domain@MT8365_POWER_DOMAIN_DSP {
> +					reg = <MT8365_POWER_DOMAIN_DSP>;
> +					clocks = <&topckgen CLK_TOP_DSP_SEL>,
> +						 <&topckgen CLK_TOP_DSP_26M>;
> +					clock-names = "dsp", "dsp1";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +			};
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8365-wdt",
> +				     "mediatek,mt6589-wdt";
> +			reg = <0 0x10007000 0 0x100>;
> +			#reset-cells = <1>;
> +		};
> +
> +		gpt: apxgpt@10008000 {

Generic node names, so "timer"

> +			compatible = "mediatek,mt8365-timer",
> +				     "mediatek,mt6577-timer";
> +			reg = <0 0x10008000 0 0x1000>;
> +			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_SYS_26M_D2>;
> +			clock-names = "clk13m";
> +		};
> +
> +		pio: pinctrl@1000b000 {
> +			compatible = "mediatek,mt8365-pinctrl";
> +			reg = <0 0x1000b000 0 0x1000>;
> +			mediatek,pctl-regmap = <&syscfg_pctl>;
> +			pins-are-numbered;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8365-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pwrap: pwrap@1000d000 {
> +			compatible = "mediatek,mt8365-pwrap";
> +			reg = <0 0x1000d000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_IFR_PWRAP_SPI>,
> +				 <&infracfg CLK_IFR_PMIC_AP>,
> +				 <&infracfg CLK_IFR_PWRAP_SYS>,
> +				 <&infracfg CLK_IFR_PWRAP_TMR>;
> +			clock-names = "spi", "wrap", "sys", "tmr";
> +		};
> +
> +		keypad: kp@10010000 {

s/kp/keypad/

> +			compatible = "mediatek,mt6779-keypad";
> +			reg = <0 0x10010000 0 0x1000>;
> +			wakeup-source;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
> +			clocks = <&clk26m>;
> +			clock-names = "kpd";
> +			status = "disabled";
> +		};
> +
> +		mcucfg: syscon@10200000 {
> +			compatible = "mediatek,mt8365-mcucfg", "syscon";
> +			reg = <0 0x10200000 0 0x2000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sysirq: intpol-controller@10200a80 {

interrupt-controller

> +			compatible = "mediatek,mt8365-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x20>;
> +		};
> +
> +		iommu: iommu@10205000 {
> +			compatible = "mediatek,mt8365-m4u";
> +			reg = <0 0x10205000 0 0x1000>;
> +			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
> +			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>;
> +			#iommu-cells = <1>;
> +		};
> +
> +		infracfg_nao: infracfg-nao@1020e000 {

Other nodes are named syscon

> +			compatible = "syscon";

No, syscon cannot be alone.

> +			reg = <0 0x1020e000 0 0x1000>;
> +		};
> +
> +		rng: rng@1020f000 {
> +			compatible = "mediatek,mt8365-rng",
> +				     "mediatek,mt7623-rng";
> +			reg = <0 0x1020f000 0 0x100>;
> +			clocks = <&infracfg CLK_IFR_TRNG>;
> +			clock-names = "rng";
> +		};
> +
> +		apdma: dma-controller@11000280 {
> +			compatible = "mediatek,mt8365-uart-dma",
> +				     "mediatek,mt6577-uart-dma";
> +			reg = <0 0x11000280 0 0x80>,
> +			      <0 0x11000300 0 0x80>,
> +			      <0 0x11000380 0 0x80>,
> +			      <0 0x11000400 0 0x80>,
> +			      <0 0x11000580 0 0x80>,
> +			      <0 0x11000600 0 0x80>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +			dma-requests = <6>;
> +			clocks = <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "apdma";
> +			#dma-cells = <1>;
> +		};
> +
> +		auxadc: adc@11001000 {
> +			compatible = "mediatek,mt8365-auxadc",
> +				     "mediatek,mt8173-auxadc";
> +			reg = <0 0x11001000 0 0x1000>;
> +			clocks = <&infracfg CLK_IFR_AUXADC>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 0
> +				&apdma 1>;

You need to split these into two phandles.

> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART1>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 2
> +				&apdma 3>;

Ditto.

> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11004000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11004000 0 0x1000>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART2>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 4
> +				&apdma 5>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		pwm: pwm@11006000 {
> +			compatible = "mediatek,mt8365-pwm";
> +			reg = <0 0x11006000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_PWM_HCLK>,
> +				 <&infracfg CLK_IFR_PWM>,
> +				 <&infracfg CLK_IFR_PWM1>,
> +				 <&infracfg CLK_IFR_PWM2>,
> +				 <&infracfg CLK_IFR_PWM3>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
> +		};
> +
> +		i2c0: i2c@11007000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11007000 0 0xa0>,
> +			      <0 0x11000080 0 0x80>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C0_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@11008000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11008000 0 0xa0>,
> +			      <0 0x11000100 0 0x80>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C1_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11009000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11009000 0 0xa0>,
> +			      <0 0x11000180 0 0x80>;
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C2_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi: spi@1100a000 {
> +			compatible = "mediatek,mt8365-spi",
> +				     "mediatek,mt7622-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x100>;

Reg goes after compatible.

> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_IFR_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		thermal: thermal@1100b000 {
> +			compatible = "mediatek,mt8365-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_THERM>,
> +				 <&infracfg CLK_IFR_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		disp_pwm: disp-pwm@1100e000 {

Generic node names, so "pwm"

> +			compatible = "mediatek,mt8365-disp-pwm",
> +				     "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
> +				 <&infracfg CLK_IFR_DISP_PWM>;
> +			clock-names = "main", "mm";
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@1100f000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x1100f000 0 0xa0>,
> +			      <0 0x11000200 0 0x80>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C3_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		ssusb: usb@11201000 {
> +			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11201000 0 0x2e00>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u2port1 PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +				 <&infracfg CLK_IFR_SSUSB_REF>,
> +				 <&infracfg CLK_IFR_SSUSB_SYS>,
> +				 <&infracfg CLK_IFR_ICUSB>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck",
> +				      "dma_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host: usb@11200000 {
> +				compatible = "mediatek,mt8365-xhci",
> +					     "mediatek,mtk-xhci";
> +				reg = <0 0x11200000 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +					 <&infracfg CLK_IFR_SSUSB_REF>,
> +					 <&infracfg CLK_IFR_SSUSB_SYS>,
> +					 <&infracfg CLK_IFR_ICUSB>,
> +					 <&infracfg CLK_IFR_SSUSB_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck",
> +					      "dma_ck", "xhci_ck";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11cd0000 0 0x1000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&infracfg CLK_IFR_MSDC0_HCLK>,
> +				 <&infracfg CLK_IFR_MSDC0_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11240000 {
> +			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11240000 0 0x1000>,
> +			      <0 0x11c90000 0 0x1000>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&infracfg CLK_IFR_MSDC1_HCLK>,
> +				 <&infracfg CLK_IFR_MSDC1_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		ethernet: ethernet@112a0000 {
> +			compatible = "mediatek,mt8365-eth";
> +			reg = <0 0x112a0000 0 0x1000>;
> +			mediatek,pericfg = <&infracfg>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_ETH_SEL>,
> +				 <&infracfg CLK_IFR_NIC_AXI>,
> +				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
> +			clock-names = "core", "reg", "trans";
> +			status = "disabled";
> +		};
> +
> +		mipi_tx0: dsi-phy@11c00000 {
> +			compatible = "mediatek,mt8365-mipi-tx",
> +				     "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11c00000 0 0x800>;
> +			clocks = <&clk26m>;
> +			clock-names = "ref_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			clock-output-names = "mipi_tx0_pll";
> +		};
> +
> +		efuse: efuse@11c50000 {
> +			compatible = "mediatek,mt8365-efuse", "mediatek,efuse";
> +			reg = <0 0x11c50000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
> +		};
> +
> +		u3phy: t-phy@11cc0000 {

s/t-phy/phy/

> +			compatible = "mediatek,mt8365-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <2>;
> +			#phy-cells = <1>;

address-cells, then size, then phy

> +			#size-cells = <2>;
> +			ranges;
> +			status = "okay";

No need for status ok.

> +
> +			u2port0: usb-phy@11cc0000 {
> +				reg = <0 0x11cc0000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +				status = "okay";

Ditto

> +			};
> +
> +			u2port1: usb-phy@11cc1000 {
> +				reg = <0 0x11cc1000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +				status = "okay";
> +			};
> +		};
> +
> +		mfgcfg: syscon@13000000 {
> +			compatible = "mediatek,mt8365-mfgcfg", "syscon";
> +			reg = <0 0x13000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mmsys: syscon@14000000 {
> +			compatible = "mediatek,mt8365-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mutex: mutex@14001000 {
> +			compatible =  "mediatek,mt8365-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +		};
> +
> +		smi_common: smi@14002000 {

s/smi/memory-controller/ in node name?

> +			compatible = "mediatek,mt8365-smi-common",
> +				     "mediatek,mt8186-smi-common";
> +			reg = <0 0x14002000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_MM_SMI_COMM0>,
> +				 <&mmsys CLK_MM_MM_SMI_COMM1>;
> +			clock-names = "apb", "smi", "gals0", "gals1";
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +		};
> +
> +		larb0: larb@14003000 {

The same?

> +			compatible = "mediatek,mt8365-smi-larb",
> +				     "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
> +				 <&mmsys CLK_MM_MM_SMI_LARB0>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;



Best regards,
Krzysztof
