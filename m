Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3FB151E
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfILUJ2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 16:09:28 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22175 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfILUJ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 16:09:28 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: GNDS3s3JLom+rZWyh4asQBjdgjybdJ0dcQ2hqdbq+vyBSvzIzNWxxxEAF4k8wOmiy69Y1T4wFM
 Icg+maMwEfwBJz4AmKAGEODNWM6ady0L8oH4dTjP2Nb1P+V4K80SRBwe9vbq9LToyj4obuNTHT
 Vknd8HlloevCm0da1nN5v5a9X1FVo6fzd0DnPBz5CLTd22lctO6VBFgbauUSdrFyyo/69HRP6F
 sZvmlxkNMMmMZqLmDomdzkTO+VojPt96Hz1RDLwLMTvvFRfTCnGeaNHOMu56urR3aMusoO+A9M
 rXw=
X-IronPort-AV: E=Sophos;i="5.64,498,1559545200"; 
   d="scan'208";a="47283694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2019 13:09:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Sep 2019 13:09:25 -0700
Received: from sekiro.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 12 Sep 2019 13:09:24 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] dt-bindings: sdhci-of-at91: new compatible string and update properties
Date:   Thu, 12 Sep 2019 22:09:06 +0200
Message-ID: <20190912200908.31318-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a new compatible string for the SAM9X60 sdhci device. It involves
an update of the properties about the clocks stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../devicetree/bindings/mmc/sdhci-atmel.txt   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 1b662d7171a0..364ceea330b6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -5,12 +5,19 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
 sdhci-of-at91 driver.
 
 Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci".
+- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
 - clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk";
+- clock-names:		Must be "hclock", "multclk", "baseclk" for
+			"atmel,sama5d2-sdhci".
+			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
 
+Optional properties:
+- assigned-clocks:	The same with "multclk".
+- assigned-clock-rates	The rate of "multclk" in order to not rely on the
+			gck configuration set by previous components.
 
-Example:
+
+Examples:
 
 sdmmc0: sdio-host@a0000000 {
 	compatible = "atmel,sama5d2-sdhci";
@@ -18,4 +25,16 @@ sdmmc0: sdio-host@a0000000 {
 	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
 	clock-names = "hclock", "multclk", "baseclk";
+	assigned-clocks = <&sdmmc0_gclk>;
+	assigned-clock-rates = <480000000>;
+};
+
+sdmmc0: sdio-host@80000000 {
+	compatible = "microchip,sam9x60-sdhci";
+	reg = <0x80000000 0x300>;
+	interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+	clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
+	clock-names = "hclock", "multclk";
+	assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
+	assigned-clock-rates = <100000000>;
 };
-- 
2.23.0

