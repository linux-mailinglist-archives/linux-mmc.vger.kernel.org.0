Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056513B8E4
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391427AbfFJQFH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 12:05:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43910 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389498AbfFJQFH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 12:05:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so3828420plb.10
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I97k1/yDNx0Ud4d53tFJ+yzis1/msAxhI7LkJXdDlMI=;
        b=VV9N9tGP8t2WAQUQ+OSK2mKKCq5hw/N4x7i7RZ590iX541DGS+qpKTG/j+IEqxn3rZ
         H21R38eWL4cZzvIqWG7yGw0Yx4RUYnU9IA3evlNHfq6dOXsAFoXgTAcwEqrrt/75qDWv
         1WNhWrZEc0F/+0Ap5HW9EQB8XXHjjpSbB6ID2xPX1JuBstBbT7ctDcNGOvhu80VQPrY5
         MUkeQgFjzhu8vYi6C7HA4Rt/jmQHHLQuvUs9a4wdno0iKRSy0ijN+2sbahr1MiseeeI2
         YTg3k9hu+cDwt1c8aDmL0YZ4s0933Hol8De084L5JSPIBTCLwUBcgcKYL4aMYP0xWafo
         mnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I97k1/yDNx0Ud4d53tFJ+yzis1/msAxhI7LkJXdDlMI=;
        b=IaQ6pNX4QaVeHG5O5XcmmZn74/AjBeHeRh4axDHu8hGKibWkqOfdzuriJJpUifnaF7
         ta2e29nl8VS6Mb0t7g0m087U+YaeTBoVteRsMQ3jk8lyzTg/dyvBxy7t0S0GuWO/oj3e
         VQ0qv8Qo8MY+bm6tHxguPXs2vZIm7faB5HFVUnF4JQG6hXEaEuJANasI3X0rtazFV4AM
         Xc5WHUHnWtsDhFSMKMCOjYed15xpEzjhC7RkLlrGoRs/nMrEIw6671OfhKo/JiPvwQTm
         aB1B23vcy1nTfhtgRjUV57BlWFmNNXfaZdzDW7OSowQ4f2Oc1PdoaUGLLE+FB8seAjVa
         bRbQ==
X-Gm-Message-State: APjAAAVaeJzz5XwlylKrObNx8nLP0BM+2fEZvZHSaGLrzCS/uRccGmj/
        pZAXmyAP9fa6gQFlvYOIeYkG
X-Google-Smtp-Source: APXvYqwH/NmDelm4Qk4hvpw7av9GCUs379dTbeOaPUH87D6Xn3audTYv6l3vxIFimcWYviwc+NPV4Q==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr9967531plp.168.1560182706367;
        Mon, 10 Jun 2019 09:05:06 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 144sm8900066pfa.180.2019.06.10.09.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 09:05:05 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:34:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
Message-ID: <20190610160459.GA31461@mani>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
 <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Hi Andreas,

On Mon, Jun 10, 2019 at 03:45:37PM +0200, Andreas F�rber wrote:
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Actions Semi Owl SoC's SD/MMC/SDIO controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/owl-mmc.txt       | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt
> 
> Rob, should this be YAML now?
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.txt b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > new file mode 100644
> > index 000000000000..a702f8d66cec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > @@ -0,0 +1,37 @@
> > +Actions Semi Owl SoCs SD/MMC/SDIO controller
> > +
> > +Required properties:
> > +- compatible: should be "actions,owl-mmc"
> > +- reg: offset and length of the register set for the device.
> > +- interrupts: single interrupt specifier.
> > +- clocks: single clock specifier of the controller clock.
> > +- resets: phandle to the reset line.
> > +- dma-names: should be "mmc".
> > +- dmas: single DMA channel specifier
> 
> I recall the main blocker for MMC being regulators, i.e. the I�C
> attached multi-function PMIC. Yet I don't see any such required property
> here, nor any patch series implementing it. Seems like this relies on
> U-Boot having initialized SD/eMMC? Do you intend to make them optional
> or did you want to hold off merging this one until the rest is done?
> 

Yeah, I'm planning to rely on u-boot for regulator enablement. PMIC support
in kernel will take some time because the floating SIRQ patchset is not yet
finished.

> > +
> > +Optional properties:
> > +- pinctrl-names: pinctrl state names "default" must be defined.
> > +- pinctrl-0: phandle referencing pin configuration of the controller.
> > +- bus-width: see mmc.txt
> > +- cap-sd-highspeed: see mmc.txt
> > +- cap-mmc-highspeed: see mmc.txt
> > +- sd-uhs-sdr12: see mmc.txt
> > +- sd-uhs-sdr25: see mmc.txt
> > +- sd-uhs-sdr50: see mmc.txt
> > +- non-removable: see mmc.txt
> 
> I'm not convinced duplicating common properties is a good idea here, in
> particular pinctrl.
> 

Hmmm, I thought of adding the MMC properties which were supported by the SoC.
I can remove those if needed.

Thanks,
Mani

> Regards,
> Andreas
> 
> > +
> > +Example:
> > +
> > +		mmc0: mmc@e0330000 {
> > +			compatible = "actions,owl-mmc";
> > +			reg = <0x0 0xe0330000 0x0 0x4000>;
> > +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_SD0>;
> > +			resets = <&cmu RESET_SD0>;
> > +			dmas = <&dma 2>;
> > +			dma-names = "mmc";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc0_default>;
> > +			bus-width = <4>;
> > +			cap-sd-highspeed;
> > +		};
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N�rnberg, Germany
> GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N�rnberg)
