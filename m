Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7CD6582
	for <lists+linux-mmc@lfdr.de>; Mon, 14 Oct 2019 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbfJNOpN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 14 Oct 2019 10:45:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43016 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbfJNOpM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2019 10:45:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so10518358pfo.10
        for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2019 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lN3aRAuKpYaZ+ZuEn6xFUroPN9c8Y6dWN+cO0mavUPk=;
        b=acWQ55Aiyz7bzg/1t6x1p4ZfHhb0zNpeZtu5QsyIdzgE1QI6KUJxYkaysyyqghEd2n
         41wFIFxypCPBodguQ7QviQd8/dveMM5h0qbssgoQLldYCRe90n15XVAtxr4abyn8T0jT
         CDFf+R5syJKkVWkiBYpgaUFQHjnjI4m0NxuJiu9I6TkeB1DMa9ZcR5jpnCdQko93nvKS
         WeLNUbdlnHZ3IHqpQlJ7mDBf4/4BbLmeF8P4beDw9Qm1EAgeW+UUoTkN4fW0nwdToN4t
         dnY8pm3GrHlVUm9BUV+viabKQ/FXPLT6JWWKgudSDhEl8xHA8esTfz4x8C+U4RFzFP5J
         +phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lN3aRAuKpYaZ+ZuEn6xFUroPN9c8Y6dWN+cO0mavUPk=;
        b=UmTQ0hMDe7XBdScoM3mNU3YZtx+7cDi4/EBtvbFtRwtiR4Ar4uLCh8UbbdyPsgocmh
         zJ+WGpV9uke6rG5XzQyf4MlGVSmNb1YFxFVofVblPvrFODSZ9aqHPDjUPoMAmXgwU8y4
         j5zyRBvyqRb2wRhvY0GrKysLynlgLnaJXCII51C1J2nSp9NogXTtvW5rkxzR5UTm0lKy
         7f1PvWOlpXkiTvAfsSLOQZ74/cbCI0z/Adv9vHjW2S+y1ipL31VU4jo8fBKAbnKagQlL
         f30L91oJVI2RbdhzEI6LQfPEX2QEYV2IQRsM7Y+uhxUNNH52Ve/s7mhCGBDL95QcQeYT
         QURw==
X-Gm-Message-State: APjAAAWr2hKj9nPt4v/8PESUaQirFEk4A+qcCf9EymQ8WAPUFmKzUK7i
        O1hIfND4megZXwRkzbT/vt2n
X-Google-Smtp-Source: APXvYqzDg0QrcgcQ38e0+fcKt09OO187d0GYMhUan8xXe5sagd9k+8PSQ+8vzIrqqnKkx9XTu0FHlg==
X-Received: by 2002:a62:31c3:: with SMTP id x186mr32802372pfx.260.1571064311986;
        Mon, 14 Oct 2019 07:45:11 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id f185sm25155509pfb.183.2019.10.14.07.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 07:45:11 -0700 (PDT)
Date:   Mon, 14 Oct 2019 20:15:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 4/7] arm64: dts: actions: Add uSD and eMMC support for
 Bubblegum96
Message-ID: <20191014144503.GB8583@mani>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916154546.24982-5-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 16, 2019 at 09:15:43PM +0530, Manivannan Sadhasivam wrote:
> Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
> S900 SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
> Since there is no PMIC support added yet, fixed regulator has been
> used as a regulator node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for v5.5.

Thanks,
Mani

> ---
>  .../boot/dts/actions/s900-bubblegum-96.dts    | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> index 732daaa6e9d3..59291e0ea1ee 100644
> --- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> +++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> @@ -12,6 +12,9 @@
>  	model = "Bubblegum-96";
>  
>  	aliases {
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		mmc2 = &mmc2;
>  		serial5 = &uart5;
>  	};
>  
> @@ -23,6 +26,24 @@
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	vcc_3v1: vcc-3v1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	sd_vcc: sd-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
>  };
>  
>  &i2c0 {
> @@ -241,6 +262,47 @@
>  			bias-pull-up;
>  		};
>  	};
> +
> +	mmc0_default: mmc0_default {
> +		pinmux {
> +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> +			function = "sd0";
> +		};
> +	};
> +
> +	mmc2_default: mmc2_default {
> +		pinmux {
> +			groups = "nand0_d0_ceb3_mfp";
> +			function = "sd2";
> +		};
> +	};
> +};
> +
> +/* uSD */
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_default>;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	vmmc-supply = <&sd_vcc>;
> +	vqmmc-supply = <&sd_vcc>;
> +};
> +
> +/* eMMC */
> +&mmc2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_default>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	bus-width = <8>;
> +	vmmc-supply = <&vcc_3v1>;
>  };
>  
>  &timer {
> -- 
> 2.17.1
> 
