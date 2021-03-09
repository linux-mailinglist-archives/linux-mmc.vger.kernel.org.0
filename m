Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3319331CA6
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Mar 2021 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCIB5V (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Mar 2021 20:57:21 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:50528 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCIB4x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 20:56:53 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6062AA7F49;
        Tue,  9 Mar 2021 09:56:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23505T140626794366720S1615254997318814_;
        Tue, 09 Mar 2021 09:56:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b60339c4527dbc220ff3d2d4e33573ac>
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
Subject: [PATCH v3 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
Date:   Tue,  9 Mar 2021 09:56:29 +0800
Message-Id: <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds rockchip support in sdhci-of-dwcmhsc.yaml

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index f99fb9f..43989f2 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -16,6 +16,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - rockchip,dwcmshc-sdhci
       - snps,dwcmshc-sdhci
 
   reg:
@@ -31,12 +32,24 @@ properties:
     items:
       - description: core clock
       - description: bus clock for optional
+      - description: axi clock for rockchip specified
+      - description: block clock for rockchip specified
+      - description: timer clock for rockchip specified
+
 
   clock-names:
     minItems: 1
     items:
       - const: core
       - const: bus
+      - const: axi
+      - const: block
+      - const: timer
+
+  rockchip,txclk-tapnum:
+    description: Specify the number of delay for tx sampling.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 
 required:
   - compatible
@@ -49,6 +62,17 @@ unevaluatedProperties: false
 
 examples:
   - |
+    mmc@fe310000 {
+      compatible = "rockchip,dwcmshc-sdhci";
+      reg = <0xfe310000 0x10000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
+      clock-names = "core", "bus", "axi", "block", "timer";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+  - |
     mmc@aa0000 {
       compatible = "snps,dwcmshc-sdhci";
       reg = <0xaa000 0x1000>;
-- 
2.7.4



