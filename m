Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721D362E00
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Jul 2019 04:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGICQo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jul 2019 22:16:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39883 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGICQo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2019 22:16:44 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so24306060ioh.6;
        Mon, 08 Jul 2019 19:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YB0ihnOm59Ua/y7c0WmEoM3xopDstN/prTb9Z8UqdvE=;
        b=eJeRfatW5PTCYutRVe9L4uMSdw/I0lVJTvCOsRqWIskY7V+XAL+bkn3eq+iWh/pbQx
         ng6IPpLqXonFSGHqSLlNvC1mNlGyBBh7dCqPKij0eHaK21uIgW7Kp0Cdj7ZGMWGdu1rD
         +sn+21vPpbWHl8aUllHL5LjqDeF/GD14M1IEJP4hcQO+efuHf34FrMQgalDeI2VKssxz
         H2DW8Az0liBCmO5UvezTzMQcSV/ZzoxaL4M90wwPtFA/l8vnxS2twsckzra5BhGL/mkD
         FCbBBczG176lL01/XTLBpCoWkLM/SFcOH0wXyTYptAOEar8igd+jNC4SuyFQiULqFO75
         3MzA==
X-Gm-Message-State: APjAAAW8/W5ElVzP3LJDfLWEDvFIocNayy2YsoJaba9iM2uguQQqybbT
        OAdpEl9hUkwHXpwBDm/h0w==
X-Google-Smtp-Source: APXvYqyGmoebgc+iVTlZYu5TrVkwa3yYJYbNaeC3MeCzrmiEnG6yJ78bPDh0A3WHvjO4ADy2Ivp3Pw==
X-Received: by 2002:a02:600c:: with SMTP id i12mr23983205jac.108.1562638603364;
        Mon, 08 Jul 2019 19:16:43 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t4sm15342760iop.0.2019.07.08.19.16.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:16:42 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:16:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ulf.hansson@linaro.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
Message-ID: <20190709021641.GA28185@bogus>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
 <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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

Would be nice and might get reviewed faster, but I'll leave that to Ulf 
to start requiring.

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

The main value is to define which common properties are valid for this 
binding (and by omission which ones aren't valid).

Rob
