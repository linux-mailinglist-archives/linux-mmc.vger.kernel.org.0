Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8016D251492
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Aug 2020 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHYIr5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 25 Aug 2020 04:47:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52657 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgHYIr5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 04:47:57 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2CD061C0011;
        Tue, 25 Aug 2020 08:47:53 +0000 (UTC)
Date:   Tue, 25 Aug 2020 10:47:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller
 bindings
Message-ID: <20200825084752.GD2389103@piout.net>
References: <20200824151035.31093-1-lars.povlsen@microchip.com>
 <20200824151035.31093-2-lars.povlsen@microchip.com>
 <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/08/2020 09:33:45+0200, Ulf Hansson wrote:
> On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
> >
> > The Sparx5 SDHCI controller is based on the Designware controller IP.
> >
> > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > ---
> >  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > new file mode 100644
> > index 0000000000000..55883290543b9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip Sparx5 Mobile Storage Host Controller Binding
> > +
> > +allOf:
> > +  - $ref: "mmc-controller.yaml"
> > +
> > +maintainers:
> > +  - Lars Povlsen <lars.povlsen@microchip.com>
> > +
> > +# Everything else is described in the common file
> > +properties:
> > +  compatible:
> > +    const: microchip,dw-sparx5-sdhci
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      Handle to "core" clock for the sdhci controller.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +
> > +  microchip,clock-delay:
> > +    description: Delay clock to card to meet setup time requirements.
> > +      Each step increase by 1.25ns.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 1
> > +    maximum: 15
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/microchip,sparx5.h>
> > +    sdhci0: mmc@600800000 {
> 
> Nitpick:
> 
> I think we should use solely "mmc[n]" here. So:
> 
> mmc0@600800000 {
> 
> Please update patch3/3 accordingly as well.

This is not what the devicetree specification says. 2.2.2 says that the
generic name is mmc, not mmc[n]. Since there is a proper unit-address, I
don't see the need for an index here.

> 
> > +        compatible = "microchip,dw-sparx5-sdhci";
> > +        reg = <0x00800000 0x1000>;
> > +        pinctrl-0 = <&emmc_pins>;
> > +        pinctrl-names = "default";
> > +        clocks = <&clks CLK_ID_AUX1>;
> > +        clock-names = "core";
> > +        assigned-clocks = <&clks CLK_ID_AUX1>;
> > +        assigned-clock-rates = <800000000>;
> > +        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +        bus-width = <8>;
> > +        microchip,clock-delay = <10>;
> > +    };
> 
> Kind regards
> Uffe

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
