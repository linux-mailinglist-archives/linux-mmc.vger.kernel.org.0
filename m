Return-Path: <linux-mmc+bounces-3641-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4B966493
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2024 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC391F24F92
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0B1B3B20;
	Fri, 30 Aug 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="izmgrZVe"
X-Original-To: linux-mmc@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A141B1D64;
	Fri, 30 Aug 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029554; cv=none; b=W1m3fa9wCApOq5bgAIXNIivjQY44O83Z/xdj40TJnu+V1MgyRXKYjS5zdDjwu0ntx3zA65XL9qeeslqgtqMqzzrRYAC8xVKsc/azp5jiEu356ymadJOcX65fNjSJIuM0RGNKkAQrxx9Occebg2Sv2iKTOkw8BW5sXQV+YGGIY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029554; c=relaxed/simple;
	bh=CNEIm5PnFZJmWeAl6BE1N6y7V3hbmu1mNPTzEXRqxK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kvD0+xrDwjZz9KOyzPVJjZVEVFFrSoWJX3ubOyUTtHDrkPUfmvaHzfQwihG9Zm9BLHOJe9tnsYZjfITRlfnwJXx5OOiWPnRWm3dDKPQWhT18CK+wIQOvykqfv+K4T3426WanB6jtsLT4jhC7w9fT4xhXpxn389+P6ENb349CvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=izmgrZVe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725029552; x=1756565552;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CNEIm5PnFZJmWeAl6BE1N6y7V3hbmu1mNPTzEXRqxK4=;
  b=izmgrZVerb9BjBeob57DcwpmTLqYLiVmIetQCb01vo2X3VB6gS1OFIwl
   fAEEDbZ9C/2NWuzYvFmkNSkOexjDuzQIYUsGvzzfPphySgstc+2ez5IqT
   fYpIGEonhW8a+J5P3PUG0DYsMxZggavjf33Bd5PwWkv+SyRVFioWtLgAq
   4AfsHVkai4G6iPIy+5P+7XbNGnOH2mti/XH425WSv/bDoqysuNV+3SOED
   9lzkTmQM6OjNgPJglu+NKOvbm6pOi/1AkLY5szqI8e/++qp0tEEZQpI7j
   8S6mEcQOJZ3h69Bpwz+Tq/xUMjamK7Q2JyiK/JHA6VrxKTQk50/POpir7
   g==;
X-CSE-ConnectionGUID: 2zZRB9uxQuqDg306Gmx2hg==
X-CSE-MsgGUID: 7/WDRQ9yQseza/p2GshC6A==
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="31104532"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 07:52:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 07:51:48 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 07:51:41 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 20:21:20 +0530
Subject: [PATCH v3 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v3-1-7c97a0872af4@microchip.com>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
In-Reply-To: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725029490; l=4662;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=CNEIm5PnFZJmWeAl6BE1N6y7V3hbmu1mNPTzEXRqxK4=;
 b=lcJCTUuGXUl2Zwbw0BhytjcMlrl0Es0XxoWWB792wbISSkojPKgjHqrNE9Wbhj0+yWmXjHPi5
 x3PlJoU9NpHDMMLlhVznRTgNXTrb9M90BDFKn7x/bafZkpTVMCwTshZ
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert sdhci-atmel documentation to yaml format. The new file will inherit
from sdhci-common.yaml.

Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
in the DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 90 ++++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 ---------
 2 files changed, 90 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
new file mode 100644
index 000000000000..ba4786328833
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SDHCI controller
+
+maintainers:
+  - Aubin Constans <aubin.constans@microchip.com>
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+description:
+  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,sama5d2-sdhci
+          - atmel,sama5d3-sdhci
+          - atmel,sama5d4-sdhci
+          - microchip,sam9x60-sdhci
+      - items:
+          - enum:
+              - microchip,sama7g5-sdhci
+          - const: microchip,sam9x60-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: hclock
+      - description: multclk
+      - description: baseclk
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: hclock
+      - const: multclk
+      - const: baseclk
+    minItems: 2
+
+  microchip,sdcal-inverted:
+    type: boolean
+    description:
+      When present, polarity on the SDCAL SoC pin is inverted.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: sdhci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,sama5d2-sdhci
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    mmc@a0000000 {
+        compatible = "atmel,sama5d2-sdhci";
+        reg = <0xa0000000 0x300>;
+        interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
+        clock-names = "hclock", "multclk", "baseclk";
+        assigned-clocks = <&sdmmc0_gclk>;
+        assigned-clock-rates = <480000000>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
deleted file mode 100644
index a9fb0a91245f..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* Atmel SDHCI controller
-
-This file documents the differences between the core properties in
-Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
-sdhci-of-at91 driver.
-
-Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
-			or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
-- clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk" for
-			"atmel,sama5d2-sdhci".
-			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
-			Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
-
-Optional properties:
-- assigned-clocks:	The same with "multclk".
-- assigned-clock-rates	The rate of "multclk" in order to not rely on the
-			gck configuration set by previous components.
-- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
-  inverted. The default polarity for this signal is described in the datasheet.
-  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
-  and a capacitor (see "SDMMC I/O Calibration" chapter).
-
-Example:
-
-mmc0: sdio-host@a0000000 {
-	compatible = "atmel,sama5d2-sdhci";
-	reg = <0xa0000000 0x300>;
-	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
-	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
-	clock-names = "hclock", "multclk", "baseclk";
-	assigned-clocks = <&sdmmc0_gclk>;
-	assigned-clock-rates = <480000000>;
-};

-- 
2.43.0


