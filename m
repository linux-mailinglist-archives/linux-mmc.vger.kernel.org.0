Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC09E4EB598
	for <lists+linux-mmc@lfdr.de>; Wed, 30 Mar 2022 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiC2WIA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Mar 2022 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiC2WH6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 18:07:58 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4286E174BA8
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2022 15:06:11 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E6E662C0486;
        Tue, 29 Mar 2022 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648591567;
        bh=gLEhXnrobZUnUff/cymUxqHovA9CWp9J4FRqiyJst08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcNis2tden9gj/+Y4eOhwpju4Af6/oDxcSYn6bbHFLD/OE9asPR4giC2+biUfZ0/5
         KHe4ySbjQQO36VvG7uS9Lz2l6wi+6x+OX0XlpakG2fqYSmWiCzty8jsaKILEGEwByt
         xEdsctLkuralsJeI23J8Xpd62X1mOOWGenDAr+w9XIRGLf3Wojc7NdMi3ubGqRz+5/
         vAXPVbktu/Lu+6HgxR1KknWofRaUjDrOMxyCiXdqCsDx7f+VZSu+Ke0+PfIhmUbmUW
         0aI/g/1hc5AxCwr6K3WW7WmKw7Bfro+ebmFTHHkI10JhMagSzgG23cpDt1kMsIz6vD
         8rMyNZWEiC6CQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624382cf0002>; Wed, 30 Mar 2022 11:06:07 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 84E4213EE56;
        Wed, 30 Mar 2022 11:06:07 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8B5A32A2678; Wed, 30 Mar 2022 11:06:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Date:   Wed, 30 Mar 2022 11:05:44 +1300
Message-Id: <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
References: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M5GUcnROAAAA:8 a=ZLoJpuIJC4DlFNBnRGwA:9 a=AjGcO6oz07-iQ99wixmX:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
in-tree dts files don't validate because they use sdhci@ instead of mmc@
as required by the generic mmc-controller schema.

The compatible "marvell,sdhci-xenon" was not documented in the old
binding but it accompanies the of "marvell,armada-3700-sdhci" in the
armada-37xx SoC dtsi so this combination is added to the new binding
document.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Notes:
    Changes in v5:
    - Fix silly error in examples
    Changes in v4:
    - Add review from Krzysztof
    - Squash in addition of marvell,sdhci-xenon with an explanation in th=
e
      commit message
    Changes in v3:
    - Don't accept ap807 without ap806
    - Add ref: string for pad-type
    Changes in v2:
    - Update MAINTAINERS entry
    - Incorporate feedback from Krzysztof

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
 .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 276 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.tx=
t b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
deleted file mode 100644
index c51a62d751dc..000000000000
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+++ /dev/null
@@ -1,173 +0,0 @@
-Marvell Xenon SDHCI Controller device tree bindings
-This file documents differences between the core mmc properties
-described by mmc.txt and the properties used by the Xenon implementation=
.
-
-Multiple SDHCs might be put into a single Xenon IP, to save size and cos=
t.
-Each SDHC is independent and owns independent resources, such as registe=
r sets,
-clock and PHY.
-Each SDHC should have an independent device tree node.
-
-Required Properties:
-- compatible: should be one of the following
-  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SoC.
-  Must provide a second register area and marvell,pad-type.
-  - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
-  - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
-  - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
-
-- clocks:
-  Array of clocks required for SDHC.
-  Require at least input clock for Xenon IP core. For Armada AP806 and
-  CP110, the AXI clock is also mandatory.
-
-- clock-names:
-  Array of names corresponding to clocks property.
-  The input clock for Xenon IP core should be named as "core".
-  The input clock for the AXI bus must be named as "axi".
-
-- reg:
-  * For "marvell,armada-3700-sdhci", two register areas.
-    The first one for Xenon IP register. The second one for the Armada 3=
700 SoC
-    PHY PAD Voltage Control register.
-    Please follow the examples with compatible "marvell,armada-3700-sdhc=
i"
-    in below.
-    Please also check property marvell,pad-type in below.
-
-  * For other compatible strings, one register area for Xenon IP.
-
-Optional Properties:
-- marvell,xenon-sdhc-id:
-  Indicate the corresponding bit index of current SDHC in
-  SDHC System Operation Control Register Bit[7:0].
-  Set/clear the corresponding bit to enable/disable current SDHC.
-  If Xenon IP contains only one SDHC, this property is optional.
-
-- marvell,xenon-phy-type:
-  Xenon support multiple types of PHYs.
-  To select eMMC 5.1 PHY, set:
-  marvell,xenon-phy-type =3D "emmc 5.1 phy"
-  eMMC 5.1 PHY is the default choice if this property is not provided.
-  To select eMMC 5.0 PHY, set:
-  marvell,xenon-phy-type =3D "emmc 5.0 phy"
-
-  All those types of PHYs can support eMMC, SD and SDIO.
-  Please note that this property only presents the type of PHY.
-  It doesn't stand for the entire SDHC type or property.
-  For example, "emmc 5.1 phy" doesn't mean that this Xenon SDHC only
-  supports eMMC 5.1.
-
-- marvell,xenon-phy-znr:
-  Set PHY ZNR value.
-  Only available for eMMC PHY.
-  Valid range =3D [0:0x1F].
-  ZNR is set as 0xF by default if this property is not provided.
-
-- marvell,xenon-phy-zpr:
-  Set PHY ZPR value.
-  Only available for eMMC PHY.
-  Valid range =3D [0:0x1F].
-  ZPR is set as 0xF by default if this property is not provided.
-
-- marvell,xenon-phy-nr-success-tun:
-  Set the number of required consecutive successful sampling points
-  used to identify a valid sampling window, in tuning process.
-  Valid range =3D [1:7].
-  Set as 0x4 by default if this property is not provided.
-
-- marvell,xenon-phy-tun-step-divider:
-  Set the divider for calculating TUN_STEP.
-  Set as 64 by default if this property is not provided.
-
-- marvell,xenon-phy-slow-mode:
-  If this property is selected, transfers will bypass PHY.
-  Only available when bus frequency lower than 55MHz in SDR mode.
-  Disabled by default. Please only try this property if timing issues
-  always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
-  SD Default Speed and HS mode and eMMC legacy speed mode.
-
-- marvell,xenon-tun-count:
-  Xenon SDHC SoC usually doesn't provide re-tuning counter in
-  Capabilities Register 3 Bit[11:8].
-  This property provides the re-tuning counter.
-  If this property is not set, default re-tuning counter will
-  be set as 0x9 in driver.
-
-- marvell,pad-type:
-  Type of Armada 3700 SoC PHY PAD Voltage Controller register.
-  Only valid when "marvell,armada-3700-sdhci" is selected.
-  Two types: "sd" and "fixed-1-8v".
-  If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning and i=
s
-  switched to 1.8V when later in higher speed mode.
-  If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for eM=
MC.
-  Please follow the examples with compatible "marvell,armada-3700-sdhci"
-  in below.
-
-Example:
-- For eMMC:
-
-	sdhci@aa0000 {
-		compatible =3D "marvell,armada-ap806-sdhci";
-		reg =3D <0xaa0000 0x1000>;
-		interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
-		clocks =3D <&emmc_clk>,<&axi_clk>;
-		clock-names =3D "core", "axi";
-		bus-width =3D <4>;
-		marvell,xenon-phy-slow-mode;
-		marvell,xenon-tun-count =3D <11>;
-		non-removable;
-		no-sd;
-		no-sdio;
-
-		/* Vmmc and Vqmmc are both fixed */
-	};
-
-- For SD/SDIO:
-
-	sdhci@ab0000 {
-		compatible =3D "marvell,armada-cp110-sdhci";
-		reg =3D <0xab0000 0x1000>;
-		interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
-		vqmmc-supply =3D <&sd_vqmmc_regulator>;
-		vmmc-supply =3D <&sd_vmmc_regulator>;
-		clocks =3D <&sdclk>, <&axi_clk>;
-		clock-names =3D "core", "axi";
-		bus-width =3D <4>;
-		marvell,xenon-tun-count =3D <9>;
-	};
-
-- For eMMC with compatible "marvell,armada-3700-sdhci":
-
-	sdhci@aa0000 {
-		compatible =3D "marvell,armada-3700-sdhci";
-		reg =3D <0xaa0000 0x1000>,
-		      <phy_addr 0x4>;
-		interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
-		clocks =3D <&emmcclk>;
-		clock-names =3D "core";
-		bus-width =3D <8>;
-		mmc-ddr-1_8v;
-		mmc-hs400-1_8v;
-		non-removable;
-		no-sd;
-		no-sdio;
-
-		/* Vmmc and Vqmmc are both fixed */
-
-		marvell,pad-type =3D "fixed-1-8v";
-	};
-
-- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
-
-	sdhci@ab0000 {
-		compatible =3D "marvell,armada-3700-sdhci";
-		reg =3D <0xab0000 0x1000>,
-		      <phy_addr 0x4>;
-		interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
-		vqmmc-supply =3D <&sd_regulator>;
-		/* Vmmc is fixed */
-		clocks =3D <&sdclk>;
-		clock-names =3D "core";
-		bus-width =3D <4>;
-
-		marvell,pad-type =3D "sd";
-	};
diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.ya=
ml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
new file mode 100644
index 000000000000..c79639e9027e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -0,0 +1,275 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/marvell,xenon-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Xenon SDHCI Controller
+
+description: |
+  This file documents differences between the core MMC properties descri=
bed by
+  mmc-controller.yaml and the properties used by the Xenon implementatio=
n.
+
+  Multiple SDHCs might be put into a single Xenon IP, to save size and c=
ost.
+  Each SDHC is independent and owns independent resources, such as regis=
ter
+  sets, clock and PHY.
+
+  Each SDHC should have an independent device tree node.
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,armada-cp110-sdhci
+          - marvell,armada-ap806-sdhci
+
+      - items:
+          - const: marvell,armada-ap807-sdhci
+          - const: marvell,armada-ap806-sdhci
+
+      - items:
+          - const: marvell,armada-3700-sdhci
+          - const: marvell,sdhci-xenon
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      For "marvell,armada-3700-sdhci", two register areas.  The first on=
e
+      for Xenon IP register. The second one for the Armada 3700 SoC PHY =
PAD
+      Voltage Control register.  Please follow the examples with compati=
ble
+      "marvell,armada-3700-sdhci" in below.
+      Please also check property marvell,pad-type in below.
+
+      For other compatible strings, one register area for Xenon IP.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: axi
+
+  marvell,xenon-sdhc-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: |
+      Indicate the corresponding bit index of current SDHC in SDHC Syste=
m
+      Operation Control Register Bit[7:0].  Set/clear the corresponding =
bit to
+      enable/disable current SDHC.
+
+  marvell,xenon-phy-type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - "emmc 5.1 phy"
+      - "emmc 5.0 phy"
+    description: |
+      Xenon support multiple types of PHYs. To select eMMC 5.1 PHY, set:
+      marvell,xenon-phy-type =3D "emmc 5.1 phy" eMMC 5.1 PHY is the defa=
ult
+      choice if this property is not provided.  To select eMMC 5.0 PHY, =
set:
+      marvell,xenon-phy-type =3D "emmc 5.0 phy"
+
+      All those types of PHYs can support eMMC, SD and SDIO. Please note=
 that
+      this property only presents the type of PHY.  It doesn't stand for=
 the
+      entire SDHC type or property.  For example, "emmc 5.1 phy" doesn't=
 mean
+      that this Xenon SDHC only supports eMMC 5.1.
+
+  marvell,xenon-phy-znr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x1f
+    default: 0xf
+    description: |
+      Set PHY ZNR value.
+      Only available for eMMC PHY.
+
+  marvell,xenon-phy-zpr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x1f
+    default: 0xf
+    description: |
+      Set PHY ZPR value.
+      Only available for eMMC PHY.
+
+  marvell,xenon-phy-nr-success-tun:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 7
+    default: 0x4
+    description: |
+      Set the number of required consecutive successful sampling points
+      used to identify a valid sampling window, in tuning process.
+
+  marvell,xenon-phy-tun-step-divider:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 64
+    description: |
+      Set the divider for calculating TUN_STEP.
+
+  marvell,xenon-phy-slow-mode:
+    type: boolean
+    description: |
+      If this property is selected, transfers will bypass PHY.
+      Only available when bus frequency lower than 55MHz in SDR mode.
+      Disabled by default. Please only try this property if timing issue=
s
+      always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
+      SD Default Speed and HS mode and eMMC legacy speed mode.
+
+  marvell,xenon-tun-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x9
+    description: |
+      Xenon SDHC SoC usually doesn't provide re-tuning counter in
+      Capabilities Register 3 Bit[11:8].
+      This property provides the re-tuning counter.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,armada-3700-sdhci
+
+    then:
+      properties:
+        reg:
+          items:
+            - description: Xenon IP registers
+            - description: Armada 3700 SoC PHY PAD Voltage Control regis=
ter
+          minItems: 2
+
+        marvell,pad-type:
+          $ref: /schemas/types.yaml#/definitions/string
+          enum:
+            - sd
+            - fixed-1-8v
+          description: |
+            Type of Armada 3700 SoC PHY PAD Voltage Controller register.
+            If "sd" is selected, SoC PHY PAD is set as 3.3V at the begin=
ning
+            and is switched to 1.8V when later in higher speed mode.
+            If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such=
 as for
+            eMMC.
+            Please follow the examples with compatible
+            "marvell,armada-3700-sdhci" in below.
+
+      required:
+        - marvell,pad-type
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,armada-cp110-sdhci
+              - marvell,armada-ap807-sdhci
+              - marvell,armada-ap806-sdhci
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          items:
+            - const: core
+            - const: axi
+
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // For eMMC
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc@aa0000 {
+      compatible =3D "marvell,armada-ap807-sdhci", "marvell,armada-ap806=
-sdhci";
+      reg =3D <0xaa0000 0x1000>;
+      interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+      clocks =3D <&emmc_clk 0>, <&axi_clk 0>;
+      clock-names =3D "core", "axi";
+      bus-width =3D <4>;
+      marvell,xenon-phy-slow-mode;
+      marvell,xenon-tun-count =3D <11>;
+      non-removable;
+      no-sd;
+      no-sdio;
+
+      /* Vmmc and Vqmmc are both fixed */
+    };
+
+  - |
+    // For SD/SDIO
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc@ab0000 {
+      compatible =3D "marvell,armada-cp110-sdhci";
+      reg =3D <0xab0000 0x1000>;
+      interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+      vqmmc-supply =3D <&sd_vqmmc_regulator>;
+      vmmc-supply =3D <&sd_vmmc_regulator>;
+      clocks =3D <&sdclk 0>, <&axi_clk 0>;
+      clock-names =3D "core", "axi";
+      bus-width =3D <4>;
+      marvell,xenon-tun-count =3D <9>;
+    };
+
+  - |
+    // For eMMC with compatible "marvell,armada-3700-sdhci":
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc@aa0000 {
+      compatible =3D "marvell,armada-3700-sdhci", "marvell,sdhci-xenon";
+      reg =3D <0xaa0000 0x1000>,
+            <0x17808 0x4>;
+      interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+      clocks =3D <&emmcclk 0>;
+      clock-names =3D "core";
+      bus-width =3D <8>;
+      mmc-ddr-1_8v;
+      mmc-hs400-1_8v;
+      non-removable;
+      no-sd;
+      no-sdio;
+
+      /* Vmmc and Vqmmc are both fixed */
+
+      marvell,pad-type =3D "fixed-1-8v";
+    };
+
+  - |
+    // For SD/SDIO with compatible "marvell,armada-3700-sdhci":
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc@ab0000 {
+      compatible =3D "marvell,armada-3700-sdhci", "marvell,sdhci-xenon";
+      reg =3D <0xab0000 0x1000>,
+            <0x17808 0x4>;
+      interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+      vqmmc-supply =3D <&sd_regulator>;
+      /* Vmmc is fixed */
+      clocks =3D <&sdclk 0>;
+      clock-names =3D "core";
+      bus-width =3D <4>;
+
+      marvell,pad-type =3D "sd";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b555a5e8704f..95921c86aa82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11706,7 +11706,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
 M:	Hu Ziji <huziji@marvell.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
 F:	drivers/mmc/host/sdhci-xenon*
=20
 MATROX FRAMEBUFFER DRIVER
--=20
2.35.1

