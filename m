Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126322D638
	for <lists+linux-mmc@lfdr.de>; Wed, 29 May 2019 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfE2HYB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 29 May 2019 03:24:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54449 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2HYB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 May 2019 03:24:01 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9AAD0E000D;
        Wed, 29 May 2019 07:23:55 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: mmc: sun4i: Add YAML schemas
Date:   Wed, 29 May 2019 09:23:44 +0200
Message-Id: <18bb36183d93fd6bc03a401c2b6b498c0171d375.1559114458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <fab0ec653b4e059cdb1206f65bfca051c8b0a7de.1559114458.git-series.maxime.ripard@bootlin.com>
References: <fab0ec653b4e059cdb1206f65bfca051c8b0a7de.1559114458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v2
  - Add Rob's Reviewed-by
---
 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt                | 52 +--------------------------------------
 2 files changed, 98 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
new file mode 100644
index 000000000000..df0280edef97
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/allwinner,sun4i-a10-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 MMC Controller Device Tree Bindings
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun4i-a10-mmc
+      - const: allwinner,sun5i-a13-mmc
+      - const: allwinner,sun7i-a20-mmc
+      - const: allwinner,sun8i-a83t-emmc
+      - const: allwinner,sun9i-a80-mmc
+      - const: allwinner,sun50i-a64-emmc
+      - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun8i-a83t-mmc
+          - const: allwinner,sun7i-a20-mmc
+      - items:
+          - const: allwinner,sun50i-h6-emmc
+          - const: allwinner,sun50i-a64-emmc
+      - items:
+          - const: allwinner,sun50i-h6-mmc
+          - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun8i-r40-emmc
+          - const: allwinner,sun50i-a64-emmc
+      - items:
+          - const: allwinner,sun8i-r40-mmc
+          - const: allwinner,sun50i-a64-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+      - description: Output Clock
+      - description: Sample Clock
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      - const: ahb
+      - const: mmc
+      - const: output
+      - const: sample
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: ahb
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    mmc0: mmc@1c0f000 {
+        compatible = "allwinner,sun5i-a13-mmc";
+        reg = <0x01c0f000 0x1000>;
+        clocks = <&ahb_gates 8>, <&mmc0_clk>;
+        clock-names = "ahb", "mmc";
+        interrupts = <32>;
+        bus-width = <4>;
+        cd-gpios = <&pio 7 1 0>;
+    };
+
+# FIXME: We should set it, but it would report all the generic
+# properties as additional properties.
+# additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
deleted file mode 100644
index e9cb3ec5e502..000000000000
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Allwinner sunxi MMC controller
-
-The highspeed MMC host controller on Allwinner SoCs provides an interface
-for MMC, SD and SDIO types of memory cards.
-
-Supported maximum speeds are the ones of the eMMC standard 4.5 as well
-as the speed of SD standard 3.0.
-Absolute maximum transfer rate is 200MB/s
-
-Required properties:
- - compatible : should be one of:
-   * "allwinner,sun4i-a10-mmc"
-   * "allwinner,sun5i-a13-mmc"
-   * "allwinner,sun7i-a20-mmc"
-   * "allwinner,sun8i-a83t-emmc"
-   * "allwinner,sun9i-a80-mmc"
-   * "allwinner,sun50i-a64-emmc"
-   * "allwinner,sun50i-a64-mmc"
-   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
-   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"
- - reg : mmc controller base registers
- - clocks : a list with 4 phandle + clock specifier pairs
- - clock-names : must contain "ahb", "mmc", "output" and "sample"
- - interrupts : mmc controller interrupt
-
-Optional properties:
- - resets : phandle + reset specifier pair
- - reset-names : must contain "ahb"
- - for cd, bus-width and additional generic mmc parameters
-   please refer to mmc.txt within this directory
-
-Examples:
-	- Within .dtsi:
-	mmc0: mmc@1c0f000 {
-		compatible = "allwinner,sun5i-a13-mmc";
-		reg = <0x01c0f000 0x1000>;
-		clocks = <&ahb_gates 8>, <&mmc0_clk>, <&mmc0_output_clk>, <&mmc0_sample_clk>;
-		clock-names = "ahb", "mod", "output", "sample";
-		interrupts = <0 32 4>;
-		status = "disabled";
-	};
-
-	- Within dts:
-	mmc0: mmc@1c0f000 {
-		pinctrl-names = "default", "default";
-		pinctrl-0 = <&mmc0_pins_a>;
-		pinctrl-1 = <&mmc0_cd_pin_reference_design>;
-		bus-width = <4>;
-		cd-gpios = <&pio 7 1 0>; /* PH1 */
-		cd-inverted;
-		status = "okay";
-	};
-- 
git-series 0.9.1
