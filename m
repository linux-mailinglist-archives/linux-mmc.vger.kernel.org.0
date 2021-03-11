Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7956D336C23
	for <lists+linux-mmc@lfdr.de>; Thu, 11 Mar 2021 07:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCKGWK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 11 Mar 2021 01:22:10 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:59072 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhCKGVs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 01:21:48 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id F0958B96E0;
        Thu, 11 Mar 2021 14:21:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139928614725376S1615443697190972_;
        Thu, 11 Mar 2021 14:21:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a308aea072323fa8e67949bb35b72d40>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Convert to yaml file
Date:   Thu, 11 Mar 2021 14:21:22 +0800
Message-Id: <1615443684-198078-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch converts sdhci-of-dwcmshc.txt to sdhci-of-dwcmshc.yaml

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4:
- add tag from Rob
Changes in v3:
- fix filename and other improvments suggested by Rob

 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   | 20 -------
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
deleted file mode 100644
index ee4253b..0000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Synopsys DesignWare Cores Mobile Storage Host Controller
-
-Required properties:
-- compatible: should be one of the following:
-    "snps,dwcmshc-sdhci"
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: Array of clocks required for SDHCI; requires at least one for
-    core clock.
-- clock-names: Array of names corresponding to clocks property; shall be
-    "core" for core clock and "bus" for optional bus clock.
-
-Example:
-	sdhci2: sdhci@aa0000 {
-		compatible = "snps,dwcmshc-sdhci";
-		reg = <0xaa0000 0x1000>;
-		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&emmcclk>;
-		bus-width = <8>;
-	}
diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
new file mode 100644
index 0000000..f99fb9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware Mobile Storage Host Controller Binding
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+  - Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - snps,dwcmshc-sdhci
+
+  reg:
+    minItems: 1
+    items:
+      - description: Offset and length of the register set for the device
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: core clock
+      - description: bus clock for optional
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: bus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@aa0000 {
+      compatible = "snps,dwcmshc-sdhci";
+      reg = <0xaa000 0x1000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>;
+      clock-names = "core", "bus";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+...
-- 
2.7.4



