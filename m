Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4694FC75D
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKNN0E (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 08:26:04 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34418 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfKNN0E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Nov 2019 08:26:04 -0500
Received: from wf0530.dip.tu-dresden.de ([141.76.182.18] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iVF8H-0002V4-Fs; Thu, 14 Nov 2019 14:25:57 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
Date:   Thu, 14 Nov 2019 14:25:56 +0100
Message-ID: <1918981.kTmXGv9Lqf@phil>
In-Reply-To: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de>
References: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Markus,

Am Dienstag, 12. November 2019, 09:45:36 CET schrieb Markus Reichl:
> Add SDR104 capability and regulators to SD card node.

> While at it, fix a typo in lcd pinctrl and remove two
> undocumented bindings from pmic.

A commit message like this always is a good indicator that this wants to
be multiple patches ;-) [Keywords: "While at it", "And", ...]


> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
> v2: Remove always-on from vcc3v0_sd
> ---
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index d1eb55c855b3..a31099f7620b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -135,6 +135,19 @@
>  		vin-supply = <&vcc_1v8>;
>  	};
>  
> +	vcc3v0_sd: vcc3v0-sd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v0_sd_en>;
> +		regulator-name = "vcc3v0_sd";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
>  	vcc3v3_sys: vcc3v3-sys {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc3v3_sys";
> @@ -293,8 +306,6 @@
>  		vcc10-supply = <&vcc3v3_sys>;
>  		vcc11-supply = <&vcc3v3_sys>;
>  		vcc12-supply = <&vcc3v3_sys>;
> -		vcc13-supply = <&vcc3v3_sys>;
> -		vcc14-supply = <&vcc3v3_sys>;

Separate patch with nice description perhaps? (remove undocumented inputs)


>  		vddio-supply = <&vcc_3v0>;
>  
>  		regulators {
> @@ -576,7 +587,7 @@
>  
>  	lcd-panel {
>  		lcd_panel_reset: lcd-panel-reset {
> -			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> +			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;

Separate patch please, "use correct pin for lcd-reset pinctrl" or so.

>  		};
>  	};
>  
> @@ -602,6 +613,10 @@
>  		vsel2_gpio: vsel2-gpio {
>  			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
>  		};
> +
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
>  	};
>  
>  	sdio-pwrseq {
> @@ -610,9 +625,9 @@
>  		};
>  	};
>  
> -	pmic {
> -		pmic_int_l: pmic-int-l {
> -			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;

separate patch please talking about regrouping the two
separate pmic pin-groups.


> +	sdmmc {
> +		vcc3v0_sd_en: vcc3v0-sd-en {
> +			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
>  
> @@ -667,6 +682,9 @@
>  	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	max-frequency = <150000000>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v0_sd>;
> +	vqmmc-supply = <&vcc_sdio>;

Alphabetical sorting of new properties please
(status staying at the bottom though)

>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>  	status = "okay";
> 

Thanks
Heiko


