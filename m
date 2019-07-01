Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919803B915
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbfFJQLg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 12:11:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38020 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389178AbfFJQLf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 12:11:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so3847467plb.5
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QET9pg+wg4oBG+Qp5Q1cj6O60aOdmHNnSi9zeIidUAw=;
        b=UkbcdtV1H7m1I0gRKzsmcd6Znvvr4WjHTOqLxmQpJdxVjeRm7Wicg3zXZm6YupWk1j
         cun43ZADHgOP6ggmqFg60lZfwvSO5MXKFTvFw0TRR0WfG2y9dypk517rd/2oJvXU/J5E
         sKPo9mZF4qdBLlUNuZGELaTpcM2GyzwQVmK46iJ+kqInACxc88sScLfgvE05VFDIH4Vz
         Bt6Ln5rCnz5Z0mBvxYns3xkVaMayygOxI55YjBX8w0hexmbY0+Ry37/8nIgI8Op41Ixn
         3HKnTZoQzqIQo7H97TINZI6yh44gqpm6eVzlVjAKw1bRVO9fEy0dHbprol7ldHvDMvgH
         g8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QET9pg+wg4oBG+Qp5Q1cj6O60aOdmHNnSi9zeIidUAw=;
        b=rHXLG7NHAX5lP12lamTZaPcvzRTLY0lmsKKy4uYP3e2wlRyh0pWlwlUcqND9rNlTBj
         L1YsRuHNwilgQpCge5scXQQw1OnbIm77L8HGLuDDSNjQdIQ2WBQahNwnKyu/Fb9ZAdkH
         p1bj9EOGsQOijRptpM4PCpysMaVCmjSZoq6jfH/YEzCLz1qlcLKAuVh9uQGBBgcWvmT3
         YjpJS10xaBtYk17Tod757tWxJj3bE1ZsZZaOd563tmqM4hJ3foV0GrnPQt38wBM0dOUY
         HzOvtjW6rqOj5f6MbJmys43QQ5RvbS4E/OLIVhgclk3inrGnfnjFaDReScutV24bNgyg
         WaYw==
X-Gm-Message-State: APjAAAViUGPwzSvAVZuqy3KsdysGkT1Zbj6kpInvmtKaUZf/AMCZcvQ+
        wy51Hq8deHTwE6ZqGcgKmF1y
X-Google-Smtp-Source: APXvYqy3Ql2jZPLLK7tXmhrVL1GGBblVr3ED1gm9qp676tSVKbCk6HseyNK9zBGjo0G0pvapjBsw8w==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr4568605plz.335.1560183094968;
        Mon, 10 Jun 2019 09:11:34 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 26sm11070938pfi.147.2019.06.10.09.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 09:11:34 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:41:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: actions: Add uSD and eMMC support for
 Bubblegum96
Message-ID: <20190610161128.GC31461@mani>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-5-manivannan.sadhasivam@linaro.org>
 <1381305a-8585-9dcf-6b43-34e852e785ab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1381305a-8585-9dcf-6b43-34e852e785ab@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Hi Andreas,

On Mon, Jun 10, 2019 at 04:08:26PM +0200, Andreas F�rber wrote:
> Hi Mani,
> 
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
> > Owl SoC.
> 
> What information does "based on Actions Semi Owl SoC" give us? :)
> The board name should be unique enough - Owl is a family of SoCs,
> "actions:" is in the subject and "s900-" is in the filename.
> 

Makes sense!

> > SD0 is connected to uSD slot and SD2 is connected to eMMC.
> 
> Suggest to add that as comments above the two nodes instead.
> 

Okay.

> > Since there is no PMIC support added yet, fixed regulator has been
> > used as a regulator node.
> 
> Fine with me - maybe add a comment and make sure it's aligned with the
> schematics naming wrt PMIC.
> 

Okay.

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../boot/dts/actions/s900-bubblegum-96.dts    | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > index 732daaa6e9d3..3b596d72de25 100644
> > --- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > +++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > @@ -13,6 +13,9 @@
> >  
> >  	aliases {
> >  		serial5 = &uart5;
> > +		mmc0 = &mmc0;
> > +		mmc1 = &mmc1;
> > +		mmc2 = &mmc2;
> 
> Sort them alphabetically?
> 

Ack.

> >  	};
> >  
> >  	chosen {
> > @@ -23,6 +26,14 @@
> >  		device_type = "memory";
> >  		reg = <0x0 0x0 0x0 0x80000000>;
> >  	};
> > +
> > +	reg_3p1v: regulator-3p1v {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "fixed-3.1V";
> > +		regulator-min-microvolt = <3100000>;
> > +		regulator-max-microvolt = <3100000>;
> > +		regulator-always-on;
> > +	};
> >  };
> >  
> >  &i2c0 {
> > @@ -241,6 +252,45 @@
> >  			bias-pull-up;
> >  		};
> >  	};
> > +
> > +	mmc0_default: mmc0_default {
> > +		pinmux {
> > +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> > +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> > +			function = "sd0";
> > +		};
> > +	};
> > +
> > +	mmc2_default: mmc2_default {
> > +		pinmux {
> > +			groups = "nand0_d0_ceb3_mfp";
> > +			function = "sd2";
> > +		};
> > +	};
> 
> Wouldn't it make more sense to move these and the below pinctrl-* to
> s900.dtsi for sharing with other theoretical boards? I really dislike
> the imx model where pin muxing is duplicated into each individual board.
> 

Matter of taste. IMO pinctrl config belongs to the board design and I don't
wanna dump all combinations in the soc dtsi.

Thanks,
Mani

> Regards,
> Andreas
> 
> > +};
> > +
> > +&mmc0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc0_default>;
> > +	no-sdio;
> > +	no-mmc;
> > +	no-1-8-v;
> > +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> > +	bus-width = <4>;
> > +	vmmc-supply = <&reg_3p1v>;
> > +	vqmmc-supply = <&reg_3p1v>;
> > +};
> > +
> > +&mmc2 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc2_default>;
> > +	no-sdio;
> > +	no-sd;
> > +	non-removable;
> > +	bus-width = <8>;
> > +	vmmc-supply = <&reg_3p1v>;
> >  };
> >  
> >  &timer {
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N�rnberg, Germany
> GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N�rnberg)
