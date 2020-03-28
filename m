Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEC196293
	for <lists+linux-mmc@lfdr.de>; Sat, 28 Mar 2020 01:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgC1AdU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Mar 2020 20:33:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52304 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgC1AdT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2020 20:33:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id z18so13564575wmk.2;
        Fri, 27 Mar 2020 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=665fZkiQeQxQz0e6yTC3YNhkYs0sFtr287HV50LsYZA=;
        b=I3aO5wPJy2zoEsoipA7CXpUpUlMIDwnkQXDCJyxOls6zsQe2X8tSNwEnMa4RCFoolh
         ctnAqA9d2fr8Zsrr5tkN0tmRB529sy0KU7zqQLzTmKDY2pruW5JI3nVtCHiCekgPckDN
         +13PmIo07UVlDtwr4Kd8vd4edKIJpoeYZW2OERLitVxcUvJ5XVOD+hdO8gwhf+2avQhT
         d8l0rAPtz1+Q51g/et8K12OMKytuXstIFxMEMoJlICjelrlhUSi1JFIeTejvxNlMGU8S
         lb6vzxAZxw8uAAINOGsMGnvMrNqpvWXgTHlv3iB4bajJPlqscxLIjzAigYiACObIrETb
         2wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=665fZkiQeQxQz0e6yTC3YNhkYs0sFtr287HV50LsYZA=;
        b=VGfeFrYDlnkpGH9O0Sh5qYjbvWTE47M8A007Qp4Rh1uPNia5DjQRNyzpgNE3QNMLax
         L1HRxVwMt7lx00VYgQCcoLCWXU2KKxiMtkkAikPIHsFm9mWTWdKi62JM9aXZvYk/qzeI
         Z3/tX8pZYpjuTIb6gXqwE0hBJJFDbye7RKhvh2RJRADOyieQ8/lJTXkljwz1pfdmbWeP
         +EUcQinpHvSunA8MxMn5XYrKyHbVItc6Y9BzgIf5jxXN6c/NHiSvaa89rYnGK4Emmnkg
         IhaFE2HSjSMsQcwT1kcY1D+jQKokwIqH0yXEFkTGL9D9PnzhbQXx2YXil7aRxIBX+G+Q
         cogA==
X-Gm-Message-State: ANhLgQ3hIZVlF5xIqX0Z82JxpJTnhxpMtf4x9nWQPP8KBEEyBlLGDqK3
        sPQ4+tBcOZeeXCODjZvPTlI=
X-Google-Smtp-Source: ADFU+vs6pei8+YtfMKOYbZ8goQWS4GvVXwvzmF1A32j7V+nrAIhek6nMb1+trxkKv6LVMaYK09PA7w==
X-Received: by 2002:a7b:c388:: with SMTP id s8mr1357582wmj.168.1585355595562;
        Fri, 27 Mar 2020 17:33:15 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f1sm10346246wrv.37.2020.03.27.17.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:33:15 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 1/3] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Sat, 28 Mar 2020 01:32:47 +0100
Message-Id: <20200328003249.1248978-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock). It embeds an internal clock controller
which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
fed by four external input clocks (clkin[0-3]). "pclk" is the module
register clock, it has to be enabled to access the registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..1ca44529f622
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson SDHC controller Device Tree Bindings
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |
+  The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
+  card interface with 1/4/8-bit bus width.
+  It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - amlogic,meson8-sdhc
+        - amlogic,meson8b-sdhc
+        - amlogic,meson8m2-sdhc
+      - const: amlogic,meson-mx-sdhc
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    minItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    minItems: 9
+
+  clock-names:
+    items:
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
+      - const: pclk
+      - const: mod_clk
+      - const: sd_clk
+      - const: tx_clk
+      - const: rx_clk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/meson-mx-sdhc-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sdhc: mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      #clock-cells = <1>;
+      clocks = <&xtal>,
+               <&fclk_div4>,
+               <&fclk_div3>,
+               <&fclk_div5>,
+               <&sdhc_pclk>,
+               <&sdhc SDHC_CLKID_MOD_CLK>,
+               <&sdhc SDHC_CLKID_SD_CLK>,
+               <&sdhc SDHC_CLKID_TX_CLK>,
+               <&sdhc SDHC_CLKID_RX_CLK>;
+      clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk",
+                    "mod_clk", "sd_clk", "tx_clk", "rx_clk";
+    };
diff --git a/include/dt-bindings/clock/meson-mx-sdhc-clkc.h b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
new file mode 100644
index 000000000000..ad9f6e4dc426
--- /dev/null
+++ b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define SDHC_CLKID_SRC_SEL	0
+#define SDHC_CLKID_DIV		1
+#define SDHC_CLKID_MOD_CLK	2
+#define SDHC_CLKID_SD_CLK	3
+#define SDHC_CLKID_TX_CLK	4
+#define SDHC_CLKID_RX_CLK	5
-- 
2.26.0

