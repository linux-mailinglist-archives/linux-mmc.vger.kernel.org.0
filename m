Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C1CF603
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2019 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHJ2T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Oct 2019 05:28:19 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52992 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfJHJ2T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2019 05:28:19 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pDzxr0OUpql/p028ANa/qShsuGwVQJ+VlFqqMdoAYI3NgErKPw/kU2uB+3PGIK3tUS8gy6VRkD
 Weq23HT8B2olfafGZccCnOLgf69Q93nz5ojgpkiH50uFyUjnC5HGlvKic/xSR2O+wHsSPk/fDC
 9+le4PgmTTiJkCI8WO+YNI9TG2IGlRX0UhNfKjHdE2acXwLlEDUF6eP1GTxS5DTvOfvGSGGbWk
 svbwmDuVNGlkJ8xw2NcOUxDu3jHDRPLlO7W3v/Kt+rP7NXSWmmBbs1KpFkj8fpT7gP8VYQGZpl
 a5g=
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="51904800"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2019 02:28:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Oct 2019 02:28:18 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 8 Oct 2019 02:28:17 -0700
Date:   Tue, 8 Oct 2019 11:28:27 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
Message-ID: <20191008092826.63kbia2wkggeab74@M43218.corp.atmel.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        claudiu.beznea@microchip.com
References: <20190912200908.31318-1-ludovic.desroches@microchip.com>
 <20190930145613.GA11254@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190930145613.GA11254@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 30, 2019 at 09:56:13AM -0500, Rob Herring wrote:
> On Thu, Sep 12, 2019 at 10:09:06PM +0200, Ludovic Desroches wrote:
> > There is a new compatible string for the SAM9X60 sdhci device. It involves
> > an update of the properties about the clocks stuff.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > ---
> >  .../devicetree/bindings/mmc/sdhci-atmel.txt   | 25 ++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > index 1b662d7171a0..364ceea330b6 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > @@ -5,12 +5,19 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
> >  sdhci-of-at91 driver.
> >  
> >  Required properties:
> > -- compatible:		Must be "atmel,sama5d2-sdhci".
> > +- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
> >  - clocks:		Phandlers to the clocks.
> > -- clock-names:		Must be "hclock", "multclk", "baseclk";
> > +- clock-names:		Must be "hclock", "multclk", "baseclk" for
> > +			"atmel,sama5d2-sdhci".
> > +			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> >  
> > +Optional properties:
> > +- assigned-clocks:	The same with "multclk".
> > +- assigned-clock-rates	The rate of "multclk" in order to not rely on the
> > +			gck configuration set by previous components.
> >  
> > -Example:
> > +
> > +Examples:
> >  
> >  sdmmc0: sdio-host@a0000000 {
> >  	compatible = "atmel,sama5d2-sdhci";
> > @@ -18,4 +25,16 @@ sdmmc0: sdio-host@a0000000 {
> >  	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
> >  	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> >  	clock-names = "hclock", "multclk", "baseclk";
> > +	assigned-clocks = <&sdmmc0_gclk>;
> > +	assigned-clock-rates = <480000000>;
> > +};
> > +
> > +sdmmc0: sdio-host@80000000 {
> 
> mmc@...
> 
> Though I don't see much value in a second example. Examples are not a 
> complete enumeration of all possible dts entries.
> 

Ok, I'll skip this example.

Ludovic

> > +	compatible = "microchip,sam9x60-sdhci";
> > +	reg = <0x80000000 0x300>;
> > +	interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> > +	clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
> > +	clock-names = "hclock", "multclk";
> > +	assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
> > +	assigned-clock-rates = <100000000>;
> >  };
> > -- 
> > 2.23.0
> > 
