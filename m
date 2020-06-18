Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF751FF466
	for <lists+linux-mmc@lfdr.de>; Thu, 18 Jun 2020 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgFRONy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 18 Jun 2020 10:13:54 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53767 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbgFRONv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2020 10:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592489631; x=1624025631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Olbw4+eagxlIiCMHRbBmMPr4NjxHK3uFqmkVqHcK/q4=;
  b=YTnUg2zepURhCxAVk1AoP8xZ1NjCbmlyECHcKlvrcBAsAsXXMpSK72Z4
   tIkAKn9fPwpVcvpoLBlxKJPlNNP9X+ck/0KLizUksZbxSTFrsm0Q7SUbA
   aEnqf8qbIJSYSyTRwIemhLXoNjl6Mk5LgRdzUzGaa7Swh+h5GBrVtUGs8
   laTI5sv35DUTt+Lz2XvE4MAfBSKnSGmJ2aN3nBB7z/43NtgHGTjn1D3er
   tSSYBO+n6LsmTMLrnpdO08EmvYQRwYhQgDw8PLsuy0FebCsezrQRzGkP3
   AoQXMFlUwJ/0ez2aOoQ4nzov1wU9TIzY9NezcQd91K9beyp6w9KsArTH5
   w==;
IronPort-SDR: 2CsKK5r63mLQvZdKyfx+QCzw9HYCT3HhH8Co7yG6mbiG6QtFgIoTNegIS1xoCXlOOgqRDYvBW6
 pS2fEos0owaLy6rUNv+Wah31AGLY7QvbLWLJGseUrgUrpCWlhDqm74SyT5d2yMw2aGNbovcZXE
 8stUTPcsrScLZJxhnR3Z7021PjJyjf7uUrj2PfHpk5blEIk2fSOcXdZSeE3Si7+RtF/3Rmtthj
 JH6yM+pRgqElo72b0ibFsFCdkGeJFOKV2vGUxJoibuVKtQufHh2DTeX3m9Bk0TNEZA9iHSam81
 ois=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="78953850"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:13:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:13:44 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:13:41 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
Date:   Thu, 18 Jun 2020 16:13:24 +0200
Message-ID: <20200618141326.25723-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618141326.25723-1-lars.povlsen@microchip.com>
References: <20200618141326.25723-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Sparx5 SDHCI controller is based on the Designware controller IP.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
new file mode 100644
index 0000000000000..55883290543b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 Mobile Storage Host Controller Binding
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    const: microchip,dw-sparx5-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Handle to "core" clock for the sdhci controller.
+
+  clock-names:
+    items:
+      - const: core
+
+  microchip,clock-delay:
+    description: Delay clock to card to meet setup time requirements.
+      Each step increase by 1.25ns.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 15
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/microchip,sparx5.h>
+    sdhci0: mmc@600800000 {
+        compatible = "microchip,dw-sparx5-sdhci";
+        reg = <0x00800000 0x1000>;
+        pinctrl-0 = <&emmc_pins>;
+        pinctrl-names = "default";
+        clocks = <&clks CLK_ID_AUX1>;
+        clock-names = "core";
+        assigned-clocks = <&clks CLK_ID_AUX1>;
+        assigned-clock-rates = <800000000>;
+        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+        bus-width = <8>;
+        microchip,clock-delay = <10>;
+    };
--
2.27.0
