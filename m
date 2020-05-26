Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806101E1B47
	for <lists+linux-mmc@lfdr.de>; Tue, 26 May 2020 08:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgEZG3f (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 May 2020 02:29:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:47652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEZG3f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 02:29:35 -0400
IronPort-SDR: 8iiuZx4RtfHhCujPKQHv+630Qmp0ROrZPiEvpLOmFWKp/mfotx222Ad3Fx0kCBXi/5skAhXKkF
 oW/UhdFpJuhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:29:34 -0700
IronPort-SDR: q2Vs+Ko2CWHOUhKAZV1OpQPSbGqI8rc8cu03OWgAXqjObQ8pFyLfpqf/K7LmG+peGV66v5dMgk
 RshkVY5PByFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="255301200"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2020 23:29:31 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindings to yaml
Date:   Tue, 26 May 2020 14:27:58 +0800
Message-Id: <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
a valid name for node and should be changed to 'mmc'.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 ------------
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 293 ++++++++++++++++++
 2 files changed, 293 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
deleted file mode 100644
index f29bf7dd2ece..000000000000
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ /dev/null
@@ -1,192 +0,0 @@
-Device Tree Bindings for the Arasan SDHCI Controller
-
-  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
-  Only deviations are documented here.
-
-  [1] Documentation/devicetree/bindings/mmc/mmc.txt
-  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
-  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-  [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
-
-Required Properties:
-  - compatible: Compatibility string.  One of:
-    - "arasan,sdhci-8.9a": generic Arasan SDHCI 8.9a PHY
-    - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
-    - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
-    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-    - "xlnx,zynqmp-8.9a": ZynqMP SDHCI 8.9a PHY
-      For this device it is strongly suggested to include clock-output-names and
-      #clock-cells.
-    - "xlnx,versal-8.9a": Versal SDHCI 8.9a PHY
-      For this device it is strongly suggested to include clock-output-names and
-      #clock-cells.
-    - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
-	Note: This binding has been deprecated and moved to [5].
-    - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-    - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel Keem Bay eMMC
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-    - "intel,keembay-sdhci-5.1-sd": Intel Keem Bay SD controller
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-    - "intel,keembay-sdhci-5.1-sdio": Intel Keem Bay SDIO controller
-      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
-
-  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
-
-  - reg: From mmc bindings: Register location and length.
-  - clocks: From clock bindings: Handles to clock inputs.
-  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
-  - interrupts: Interrupt specifier
-
-Required Properties for "arasan,sdhci-5.1":
-  - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
-  - phy-names:  MUST be "phy_arasan".
-
-Optional Properties:
-  - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
-    used to access core corecfg registers.  Offsets of registers in this
-    syscon are determined based on the main compatible string for the device.
-  - clock-output-names: If specified, this will be the name of the card clock
-    which will be exposed by this device.  Required if #clock-cells is
-    specified.
-  - #clock-cells: If specified this should be the value <0> or <1>. With this
-    property in place we will export one or two clocks representing the Card
-    Clock. These clocks are expected to be consumed by our PHY.
-  - xlnx,fails-without-test-cd: when present, the controller doesn't work when
-    the CD line is not connected properly, and the line is not connected
-    properly. Test mode can be used to force the controller to function.
-  - xlnx,int-clock-stable-broken: when present, the controller always reports
-    that the internal clock is stable even when it is not.
-
-  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
-    which the command and data lines are configured. If not specified, driver
-    will assume this as 0.
-
-Example:
-	sdhci@e0100000 {
-		compatible = "arasan,sdhci-8.9a";
-		reg = <0xe0100000 0x1000>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&clkc 21>, <&clkc 32>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 24 4>;
-	} ;
-
-	sdhci@e2800000 {
-		compatible = "arasan,sdhci-5.1";
-		reg = <0xe2800000 0x1000>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&cru 8>, <&cru 18>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 24 4>;
-		phys = <&emmc_phy>;
-		phy-names = "phy_arasan";
-	} ;
-
-	sdhci: sdhci@fe330000 {
-		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
-		reg = <0x0 0xfe330000 0x0 0x10000>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb";
-		arasan,soc-ctl-syscon = <&grf>;
-		assigned-clocks = <&cru SCLK_EMMC>;
-		assigned-clock-rates = <200000000>;
-		clock-output-names = "emmc_cardclock";
-		phys = <&emmc_phy>;
-		phy-names = "phy_arasan";
-		#clock-cells = <0>;
-	};
-
-	sdhci: mmc@ff160000 {
-		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
-		interrupt-parent = <&gic>;
-		interrupts = <0 48 4>;
-		reg = <0x0 0xff160000 0x0 0x1000>;
-		clocks = <&clk200>, <&clk200>;
-		clock-names = "clk_xin", "clk_ahb";
-		clock-output-names = "clk_out_sd0", "clk_in_sd0";
-		#clock-cells = <1>;
-		clk-phase-sd-hs = <63>, <72>;
-	};
-
-	sdhci: mmc@f1040000 {
-		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
-		interrupt-parent = <&gic>;
-		interrupts = <0 126 4>;
-		reg = <0x0 0xf1040000 0x0 0x10000>;
-		clocks = <&clk200>, <&clk200>;
-		clock-names = "clk_xin", "clk_ahb";
-		clock-output-names = "clk_out_sd0", "clk_in_sd0";
-		#clock-cells = <1>;
-		clk-phase-sd-hs = <132>, <60>;
-	};
-
-	emmc: sdhci@ec700000 {
-		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
-		reg = <0xec700000 0x300>;
-		interrupt-parent = <&ioapic1>;
-		interrupts = <44 1>;
-		clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
-			 <&cgu0 LGM_GCLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb", "gate";
-		clock-output-names = "emmc_cardclock";
-		#clock-cells = <0>;
-		phys = <&emmc_phy>;
-		phy-names = "phy_arasan";
-		arasan,soc-ctl-syscon = <&sysconf>;
-	};
-
-	sdxc: sdhci@ec600000 {
-		compatible = "arasan,sdhci-5.1", "intel,lgm-sdhci-5.1-sdxc";
-		reg = <0xec600000 0x300>;
-		interrupt-parent = <&ioapic1>;
-		interrupts = <43 1>;
-		clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
-			 <&cgu0 LGM_GCLK_SDXC>;
-		clock-names = "clk_xin", "clk_ahb", "gate";
-		clock-output-names = "sdxc_cardclock";
-		#clock-cells = <0>;
-		phys = <&sdxc_phy>;
-		phy-names = "phy_arasan";
-		arasan,soc-ctl-syscon = <&sysconf>;
-	};
-
-	mmc: mmc@33000000 {
-		compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
-		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x0 0x33000000 0x0 0x300>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
-			 <&scmi_clk KEEM_BAY_PSS_EMMC>;
-		phys = <&emmc_phy>;
-		phy-names = "phy_arasan";
-		assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
-		assigned-clock-rates = <200000000>;
-		clock-output-names = "emmc_cardclock";
-		#clock-cells = <0>;
-		arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
-	};
-
-	sd0: mmc@31000000 {
-		compatible = "intel,keembay-sdhci-5.1-sd";
-		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x0 0x31000000 0x0 0x300>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
-			 <&scmi_clk KEEM_BAY_PSS_SD0>;
-		arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
-	};
-
-	sd1: mmc@32000000 {
-		compatible = "intel,keembay-sdhci-5.1-sdio";
-		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x0 0x32000000 0x0 0x300>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
-			 <&scmi_clk KEEM_BAY_PSS_SD1>;
-		arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
new file mode 100644
index 000000000000..927e2f13958b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -0,0 +1,293 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Device Tree Bindings for the Arasan SDHCI Controller
+
+allOf:
+  - $ref: "mmc-controller.yaml#"
+
+maintainers:
+  - Adrian Hunter <adrian.hunter@intel.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: arasan,sdhci-8.9a                # generic Arasan SDHCI 8.9a PHY
+      - const: arasan,sdhci-4.9a                # generic Arasan SDHCI 4.9a PHY
+      - const: arasan,sdhci-5.1                 # generic Arasan SDHCI 5.1 PHY
+      - items:
+          - const: rockchip,rk3399-sdhci-5.1    # rk3399 eMMC PHY
+          - const: arasan,sdhci-5.1
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+      - items:
+          - const: xlnx,zynqmp-8.9a             # ZynqMP SDHCI 8.9a PHY
+          - const: arasan,sdhci-8.9a
+        description: |
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
+      - items:
+          - const: xlnx,versal-8.9a             # Versal SDHCI 8.9a PHY
+          - const: arasan,sdhci-8.9a
+        description: |
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
+      - items:
+          - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
+          - const: arasan,sdhci-5.1
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+      - items:
+          - const: intel,lgm-sdhci-5.1-sdxc     # Intel LGM SDXC PHY
+          - const: arasan,sdhci-5.1
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+      - items:
+          - const: intel,keembay-sdhci-5.1-emmc # Intel Keem Bay eMMC PHY
+          - const: arasan,sdhci-5.1
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+      - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+      - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
+        description: |
+          For this device it is strongly suggested to include
+          arasan,soc-ctl-syscon.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: clk_xin
+      - const: clk_ahb
+      - const: gate
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: phy_arasan
+
+  arasan,soc-ctl-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle to a syscon device (see ../mfd/syscon.txt) used to access
+      core corecfg registers. Offsets of registers in this syscon are
+      determined based on the main compatible string for the device.
+
+  clock-output-names:
+    description: |
+      If specified, this will be the name of the card clock which will
+      be exposed by this device. Required if '#clock-cells' is specified.
+
+  '#clock-cells':
+    enum: [0, 1]
+    description: |
+      With this property in place we will export one or two clocks
+      representing the Card Clock. These clocks are expected to be
+      consumed by our PHY.
+
+  xlnx,fails-without-test-cd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      When present, the controller doesn't work when the CD line is not
+      connected properly, and the line is not connected properly.
+      Test mode can be used to force the controller to function.
+
+  xlnx,int-clock-stable-broken:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      When present, the controller always reports that the internal clock
+      is stable even when it is not.
+
+  xlnx,mio-bank:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      When specified, this will indicate the MIO bank number in which
+      the command and data lines are configured. If not specified, driver
+      will assume this as 0.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: arasan,sdhci-5.1
+then:
+  required:
+    - phys
+    - phy-names
+
+examples:
+  - |
+    mmc@e0100000 {
+          compatible = "arasan,sdhci-8.9a";
+          reg = <0xe0100000 0x1000>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&clkc 21>, <&clkc 32>;
+          interrupt-parent = <&gic>;
+          interrupts = <0 24 4>;
+    };
+
+  - |
+    mmc@e2800000 {
+          compatible = "arasan,sdhci-5.1";
+          reg = <0xe2800000 0x1000>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&cru 8>, <&cru 18>;
+          interrupt-parent = <&gic>;
+          interrupts = <0 24 4>;
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+    };
+
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc@fe330000 {
+          compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
+          reg = <0x0 0xfe330000 0x0 0x10000>;
+          interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+          clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
+          clock-names = "clk_xin", "clk_ahb";
+          arasan,soc-ctl-syscon = <&grf>;
+          assigned-clocks = <&cru SCLK_EMMC>;
+          assigned-clock-rates = <200000000>;
+          clock-output-names = "emmc_cardclock";
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+          #clock-cells = <0>;
+    };
+
+  - |
+    mmc@ff160000 {
+          compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+          interrupt-parent = <&gic>;
+          interrupts = <0 48 4>;
+          reg = <0x0 0xff160000 0x0 0x1000>;
+          clocks = <&clk200>, <&clk200>;
+          clock-names = "clk_xin", "clk_ahb";
+          clock-output-names = "clk_out_sd0", "clk_in_sd0";
+          #clock-cells = <1>;
+          clk-phase-sd-hs = <63 72>;
+    };
+
+  - |
+    mmc@f1040000 {
+          compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
+          interrupt-parent = <&gic>;
+          interrupts = <0 126 4>;
+          reg = <0x0 0xf1040000 0x0 0x10000>;
+          clocks = <&clk200>, <&clk200>;
+          clock-names = "clk_xin", "clk_ahb";
+          clock-output-names = "clk_out_sd0", "clk_in_sd0";
+          #clock-cells = <1>;
+          clk-phase-sd-hs = <132>, <60>;
+    };
+
+  - |
+    #define LGM_CLK_EMMC5
+    #define LGM_CLK_NGI
+    #define LGM_GCLK_EMMC
+    mmc@ec700000 {
+          compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+          reg = <0xec700000 0x300>;
+          interrupt-parent = <&ioapic1>;
+          interrupts = <44 1>;
+          clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
+                   <&cgu0 LGM_GCLK_EMMC>;
+          clock-names = "clk_xin", "clk_ahb", "gate";
+          clock-output-names = "emmc_cardclock";
+          #clock-cells = <0>;
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+          arasan,soc-ctl-syscon = <&sysconf>;
+    };
+
+  - |
+    #define LGM_CLK_SDIO
+    #define LGM_GCLK_SDXC
+    mmc@ec600000 {
+          compatible = "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1";
+          reg = <0xec600000 0x300>;
+          interrupt-parent = <&ioapic1>;
+          interrupts = <43 1>;
+          clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
+                   <&cgu0 LGM_GCLK_SDXC>;
+          clock-names = "clk_xin", "clk_ahb", "gate";
+          clock-output-names = "sdxc_cardclock";
+          #clock-cells = <0>;
+          phys = <&sdxc_phy>;
+          phy-names = "phy_arasan";
+          arasan,soc-ctl-syscon = <&sysconf>;
+    };
+
+  - |
+    #define KEEM_BAY_PSS_AUX_EMMC
+    #define KEEM_BAY_PSS_EMMC
+    mmc@33000000 {
+          compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+          interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+          reg = <0x0 0x33000000 0x0 0x300>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
+                   <&scmi_clk KEEM_BAY_PSS_EMMC>;
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+          assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
+          assigned-clock-rates = <200000000>;
+          clock-output-names = "emmc_cardclock";
+          #clock-cells = <0>;
+          arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
+    };
+
+  - |
+    #define KEEM_BAY_PSS_AUX_SD0
+    #define KEEM_BAY_PSS_SD0
+    mmc@31000000 {
+          compatible = "intel,keembay-sdhci-5.1-sd";
+          interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+          reg = <0x0 0x31000000 0x0 0x300>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
+                   <&scmi_clk KEEM_BAY_PSS_SD0>;
+          arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+    };
+
+  - |
+    #define KEEM_BAY_PSS_AUX_SD1
+    #define KEEM_BAY_PSS_SD1
+    mmc@32000000 {
+          compatible = "intel,keembay-sdhci-5.1-sdio";
+          interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+          reg = <0x0 0x32000000 0x0 0x300>;
+          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
+                   <&scmi_clk KEEM_BAY_PSS_SD1>;
+          arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
+    };
-- 
2.17.1

