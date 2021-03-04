Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235C632C2E4
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Mar 2021 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCDAAM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 3 Mar 2021 19:00:12 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:39502 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839555AbhCCIFV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 03:05:21 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 99419A7884;
        Wed,  3 Mar 2021 15:48:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19729T140185384916736S1614757734881043_;
        Wed, 03 Mar 2021 15:48:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8c5b24f560b714c292c798000abcaba7>
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
Subject: [PATCH 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
Date:   Wed,  3 Mar 2021 15:48:42 +0800
Message-Id: <1614757723-225262-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614757723-225262-1-git-send-email-shawn.lin@rock-chips.com>
References: <1614757723-225262-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds rockchip support in sdhci-of-dwcmhsc.yaml

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml  | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
index ff2bff1..4808094 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
@@ -22,6 +22,7 @@ select:
 properties:
   compatible:
     enum:
+      - rockchip,dwcmshc-sdhci
       - snps,dwcmshc-sdhci
 
   reg:
@@ -33,16 +34,26 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     description:
       Handle to "core" for core clock and "bus" for optional bus clock.
+      "axi", "block" and "timer" are for Rockchip specified which aims for
+      DMA, pipe and internal timer respectively.
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     items:
       - const: bus
       - const: core
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
@@ -55,6 +66,15 @@ unevaluatedProperties: false
 
 examples:
   - |
+    sdhci@fe310000 {
+      compatible = "rockchip,dwcmshc-sdhci";
+      reg = <0xfe310000 0x10000>;
+      interrupts = <0 25 0x4>;
+      bus-width = <8>;
+      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>;
+      clock-names = "core", "axi", "block", "timer";
+    };
+  - |
     sdhci@aa0000 {
       compatible = "snps,dwcmshc-sdhci";
       reg = <0xaa000 0x1000>;
-- 
2.7.4



