Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7101F13B487
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Jan 2020 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANViX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 14 Jan 2020 16:38:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44430 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANViX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2020 16:38:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so13708570wrm.11;
        Tue, 14 Jan 2020 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f9U5Bcu50iadv0QgDoBy+54uXwpfM8hXO8Wzm2sPm+4=;
        b=gfGJgRQSF8cGe6buDT2zg5bh5jYRCHzk/iOUGakroYL3N+SVnzgtZ53tSfPs7hMM3G
         y+XVNos8uAnEFk+rz3Ztp2zrZ3riiEsikZrYrbySCEDUq9VslAG93dvMirJsMpoj3IF9
         BPFtJ8XRlFa2YhAX8cB7fH3dcSDMtP+0CTPbcFOLBPtdnL5NhhlMX+tWXJfiS6BP5lXd
         BwOl3Eu6JOTGl/rfQcBSYdc4b/d4z4eiEwXVrgRqsTu2WvXYMgop40MdzV16gMq02hK3
         e9qVpd6NoNPqCnhwHX3oxQMsjHxXKSLqUH+gY+4Q6cumFUCXirC9kaeTPUTW4OnyVjIj
         1HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f9U5Bcu50iadv0QgDoBy+54uXwpfM8hXO8Wzm2sPm+4=;
        b=HynQ56lsZO6LCp87mPSgNhd+ASuaXfCePrX+fhN45ylXu0h5GWlTmm9spjDUg5xfFu
         HSC8xaag45AWrpFGmVHiwSXYQOjykdTEMDDGkahjP3vqPiUowj3Hi+dFP80j3h9DtsRp
         Ru0mdL8zQmMk09dPY9eBcy8Y4aJ1eUyStHop8eTvyT0LN4CyFQ6q1ddDy1mumQ/6ppsT
         oJfISVpCrCyc0NSsN1FZ/d/p36vA8izJs9DJF0jAKvkErhgmILIO23Q9+3j4hHeqDImp
         fy498IlyUH9NxFkHw0oaiONyzlr37NhPhBoJgSmuuKFU16w6o8bmGHMQdhc4tilVwIep
         ZEqw==
X-Gm-Message-State: APjAAAVRNR1pCURd4xSjsmjn2PsdGfqsHYBlI95j/sLg27ngzj6QeR8/
        /rGjyeFSraDjM2goPgoqePA=
X-Google-Smtp-Source: APXvYqx7jlovPuzPwm+3f5goeCHcrWhmaN+zGSu6JtqQaKt8TKMrJ9ixa+Z423zRHHFdOQu5pahIjg==
X-Received: by 2002:adf:db84:: with SMTP id u4mr28121908wri.317.1579037897557;
        Tue, 14 Jan 2020 13:38:17 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w17sm21639511wrt.89.2020.01.14.13.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:38:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH v1 1/3] dt-bindings: mmc: combine common mmc and dw-mshc properties
Date:   Tue, 14 Jan 2020 22:38:07 +0100
Message-Id: <20200114213809.27166-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Combine the common properties for mmc and dw-mshc in
mmc-controller-common.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/mmc/mmc-controller-common.yaml        | 342 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    | 335 +-------------------
 2 files changed, 346 insertions(+), 331 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
new file mode 100644
index 000000000..92e5c3129
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -0,0 +1,342 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMC Controller Common Properties
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  "#address-cells":
+    const: 1
+    description: |
+      The cell is the slot ID if a function subnode is used.
+
+  "#size-cells":
+    const: 0
+
+  # Card Detection.
+  # If none of these properties are supplied, the host native card
+  # detect will be used. Only one of them should be provided.
+
+  broken-cd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      There is no card detection available; polling must be used.
+
+  cd-gpios:
+    description:
+      The card detection will be done using the GPIO provided.
+
+  non-removable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Non-removable slot (like eMMC); assume always present.
+
+  # *NOTE* on CD and WP polarity. To use common for all SD/MMC host
+  # controllers line polarity properties, we have to fix the meaning
+  # of the "normal" and "inverted" line levels. We choose to follow
+  # the SDHCI standard, which specifies both those lines as "active
+  # low." Therefore, using the "cd-inverted" property means, that the
+  # CD line is active high, i.e. it is high, when a card is
+  # inserted. Similar logic applies to the "wp-inverted" property.
+  #
+  # CD and WP lines can be implemented on the hardware in one of two
+  # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
+  # as dedicated pins. Polarity of dedicated pins can be specified,
+  # using *-inverted properties. GPIO polarity can also be specified
+  # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
+  # latter case. We choose to use the XOR logic for GPIO CD and WP
+  # lines.  This means, the two properties are "superimposed," for
+  # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
+  # respective *-inverted property property results in a
+  # double-inversion and actually means the "normal" line polarity is
+  # in effect.
+  wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The Write Protect line polarity is inverted.
+
+  cd-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CD line polarity is inverted.
+
+  # Other properties
+
+  bus-width:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 4, 8]
+        default: 1
+    description:
+      Number of data lines.
+
+  max-frequency:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 400000
+      - maximum: 200000000
+    description:
+      Maximum operating frequency of the bus.
+
+  disable-wp:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, no physical write-protect line is present. This
+      property should only be specified when the controller has a
+      dedicated write-protect detection logic. If a GPIO is always used
+      for the write-protect detection logic, it is sufficient to not
+      specify the wp-gpios property in the absence of a write-protect
+      line. Not used in combination with eMMC or SDIO.
+
+  wp-gpios:
+    description:
+      GPIO to use for the write-protect detection.
+
+  cd-debounce-delay-ms:
+    description:
+      Set delay time before detecting card after card insert
+      interrupt.
+
+  no-1-8-v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When specified, denotes that 1.8V card voltage is not supported
+      on this system, even if the controller claims it.
+
+  cap-sd-highspeed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD high-speed timing is supported.
+
+  cap-mmc-highspeed:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      MMC high-speed timing is supported.
+
+  sd-uhs-sdr12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR12 speed is supported.
+
+  sd-uhs-sdr25:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR25 speed is supported.
+
+  sd-uhs-sdr50:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR50 speed is supported.
+
+  sd-uhs-sdr104:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS SDR104 speed is supported.
+
+  sd-uhs-ddr50:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SD UHS DDR50 speed is supported.
+
+  cap-power-off-card:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Powering off the card is safe.
+
+  cap-mmc-hw-reset:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC hardware reset is supported
+
+  cap-sdio-irq:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      enable SDIO IRQ signalling on this interface
+
+  full-pwr-cycle:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Full power cycle of the card is supported.
+
+  mmc-ddr-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (1.2V I/O) is supported.
+
+  mmc-ddr-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (1.8V I/O) is supported.
+
+  mmc-ddr-3_3v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC high-speed DDR mode (3.3V I/O) is supported.
+
+  mmc-hs200-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS200 mode (1.2V I/O) is supported.
+
+  mmc-hs200-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS200 mode (1.8V I/O) is supported.
+
+  mmc-hs400-1_2v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 mode (1.2V I/O) is supported.
+
+  mmc-hs400-1_8v:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 mode (1.8V I/O) is supported.
+
+  mmc-hs400-enhanced-strobe:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      eMMC HS400 enhanced strobe mode is supported
+
+  dsr:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 0xffff
+    description:
+      Value the card Driver Stage Register (DSR) should be programmed
+      with.
+
+  no-sdio:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send SDIO commands during
+      initialization.
+
+  no-sd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send SD commands during initialization.
+
+  no-mmc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Controller is limited to send MMC commands during
+      initialization.
+
+  fixed-emmc-driver-type:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      For non-removable eMMC, enforce this driver type. The value is
+      the driver type as specified in the eMMC specification (table
+      206 in spec version 5.1)
+
+  post-power-on-delay-ms:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 10
+    description:
+      It was invented for MMC pwrseq-simple which could be referred to
+      mmc-pwrseq-simple.txt. But now it\'s reused as a tunable delay
+      waiting for I/O signalling and card power supply to be stable,
+      regardless of whether pwrseq-simple is used. Default to 10ms if
+      no available.
+
+  supports-cqe:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates that the corresponding
+      MMC host controller supports HW command queue feature.
+
+  disable-cqe-dcmd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates that the MMC
+      controller\'s command queue engine (CQE) does not support direct
+      commands (DCMDs).
+
+  keep-power-in-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SDIO only. Preserves card power during a suspend/resume cycle.
+
+  # Deprecated: enable-sdio-wakeup
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      SDIO only. Enables wake up of host system on SDIO IRQ assertion.
+
+  vmmc-supply:
+    description:
+      Supply for the card power
+
+  vqmmc-supply:
+    description:
+      Supply for the bus IO line power
+
+  mmc-pwrseq:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      System-on-Chip designs may specify a specific MMC power
+      sequence. To successfully detect an (e)MMC/SD/SDIO card, that
+      power sequence must be maintained while initializing the card.
+
+patternProperties:
+  "^.*@[0-9]+$":
+    type: object
+    description: |
+      On embedded systems the cards connected to a host may need
+      additional properties. These can be specified in subnodes to the
+      host controller node. The subnodes are identified by the
+      standard \'reg\' property. Which information exactly can be
+      specified depends on the bindings for the SDIO function driver
+      for the subnode, as specified by the compatible string.
+
+    properties:
+      compatible:
+        description: |
+          Name of SDIO function following generic names recommended
+          practice
+
+      reg:
+        items:
+          - minimum: 0
+            maximum: 7
+            description:
+              Must contain the SDIO function number of the function this
+              subnode describes. A value of 0 denotes the memory SD
+              function, values from 1 to 7 denote the SDIO functions.
+
+      broken-hpi:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Use this to indicate that the mmc-card has a broken hpi
+          implementation, and that hpi should not be used.
+
+    required:
+      - reg
+
+  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 359
+      description:
+        Set the clock (phase) delays which are to be configured in the
+        controller while switching to particular speed mode. These values
+        are in pair of degrees.
+
+dependencies:
+  cd-debounce-delay-ms: [ cd-gpios ]
+  fixed-emmc-driver-type: [ non-removable ]
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 3c0df4016..6c7085395 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -14,341 +14,14 @@ description: |
   that requires the respective functionality should implement them using
   these definitions.
 
+allOf:
+  - $ref: "mmc-controller-common.yaml"
+
+# Everything else is described in the common file
 properties:
   $nodename:
     pattern: "^mmc(@.*)?$"
 
-  "#address-cells":
-    const: 1
-    description: |
-      The cell is the slot ID if a function subnode is used.
-
-  "#size-cells":
-    const: 0
-
-  # Card Detection.
-  # If none of these properties are supplied, the host native card
-  # detect will be used. Only one of them should be provided.
-
-  broken-cd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      There is no card detection available; polling must be used.
-
-  cd-gpios:
-    description:
-      The card detection will be done using the GPIO provided.
-
-  non-removable:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Non-removable slot (like eMMC); assume always present.
-
-  # *NOTE* on CD and WP polarity. To use common for all SD/MMC host
-  # controllers line polarity properties, we have to fix the meaning
-  # of the "normal" and "inverted" line levels. We choose to follow
-  # the SDHCI standard, which specifies both those lines as "active
-  # low." Therefore, using the "cd-inverted" property means, that the
-  # CD line is active high, i.e. it is high, when a card is
-  # inserted. Similar logic applies to the "wp-inverted" property.
-  #
-  # CD and WP lines can be implemented on the hardware in one of two
-  # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
-  # as dedicated pins. Polarity of dedicated pins can be specified,
-  # using *-inverted properties. GPIO polarity can also be specified
-  # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
-  # latter case. We choose to use the XOR logic for GPIO CD and WP
-  # lines.  This means, the two properties are "superimposed," for
-  # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
-  # respective *-inverted property property results in a
-  # double-inversion and actually means the "normal" line polarity is
-  # in effect.
-  wp-inverted:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The Write Protect line polarity is inverted.
-
-  cd-inverted:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The CD line polarity is inverted.
-
-  # Other properties
-
-  bus-width:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 4, 8]
-        default: 1
-    description:
-      Number of data lines.
-
-  max-frequency:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 400000
-      - maximum: 200000000
-    description:
-      Maximum operating frequency of the bus.
-
-  disable-wp:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      When set, no physical write-protect line is present. This
-      property should only be specified when the controller has a
-      dedicated write-protect detection logic. If a GPIO is always used
-      for the write-protect detection logic, it is sufficient to not
-      specify the wp-gpios property in the absence of a write-protect
-      line. Not used in combination with eMMC or SDIO.
-
-  wp-gpios:
-    description:
-      GPIO to use for the write-protect detection.
-
-  cd-debounce-delay-ms:
-    description:
-      Set delay time before detecting card after card insert
-      interrupt.
-
-  no-1-8-v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      When specified, denotes that 1.8V card voltage is not supported
-      on this system, even if the controller claims it.
-
-  cap-sd-highspeed:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD high-speed timing is supported.
-
-  cap-mmc-highspeed:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      MMC high-speed timing is supported.
-
-  sd-uhs-sdr12:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR12 speed is supported.
-
-  sd-uhs-sdr25:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR25 speed is supported.
-
-  sd-uhs-sdr50:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR50 speed is supported.
-
-  sd-uhs-sdr104:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS SDR104 speed is supported.
-
-  sd-uhs-ddr50:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SD UHS DDR50 speed is supported.
-
-  cap-power-off-card:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Powering off the card is safe.
-
-  cap-mmc-hw-reset:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC hardware reset is supported
-
-  cap-sdio-irq:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      enable SDIO IRQ signalling on this interface
-
-  full-pwr-cycle:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Full power cycle of the card is supported.
-
-  mmc-ddr-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (1.2V I/O) is supported.
-
-  mmc-ddr-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (1.8V I/O) is supported.
-
-  mmc-ddr-3_3v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC high-speed DDR mode (3.3V I/O) is supported.
-
-  mmc-hs200-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS200 mode (1.2V I/O) is supported.
-
-  mmc-hs200-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS200 mode (1.8V I/O) is supported.
-
-  mmc-hs400-1_2v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 mode (1.2V I/O) is supported.
-
-  mmc-hs400-1_8v:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 mode (1.8V I/O) is supported.
-
-  mmc-hs400-enhanced-strobe:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      eMMC HS400 enhanced strobe mode is supported
-
-  dsr:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-      - maximum: 0xffff
-    description:
-      Value the card Driver Stage Register (DSR) should be programmed
-      with.
-
-  no-sdio:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send SDIO commands during
-      initialization.
-
-  no-sd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send SD commands during initialization.
-
-  no-mmc:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Controller is limited to send MMC commands during
-      initialization.
-
-  fixed-emmc-driver-type:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-      - maximum: 4
-    description:
-      For non-removable eMMC, enforce this driver type. The value is
-      the driver type as specified in the eMMC specification (table
-      206 in spec version 5.1)
-
-  post-power-on-delay-ms:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - default: 10
-    description:
-      It was invented for MMC pwrseq-simple which could be referred to
-      mmc-pwrseq-simple.txt. But now it\'s reused as a tunable delay
-      waiting for I/O signalling and card power supply to be stable,
-      regardless of whether pwrseq-simple is used. Default to 10ms if
-      no available.
-
-  supports-cqe:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The presence of this property indicates that the corresponding
-      MMC host controller supports HW command queue feature.
-
-  disable-cqe-dcmd:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The presence of this property indicates that the MMC
-      controller\'s command queue engine (CQE) does not support direct
-      commands (DCMDs).
-
-  keep-power-in-suspend:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
-
-  # Deprecated: enable-sdio-wakeup
-  wakeup-source:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      SDIO only. Enables wake up of host system on SDIO IRQ assertion.
-
-  vmmc-supply:
-    description:
-      Supply for the card power
-
-  vqmmc-supply:
-    description:
-      Supply for the bus IO line power
-
-  mmc-pwrseq:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      System-on-Chip designs may specify a specific MMC power
-      sequence. To successfully detect an (e)MMC/SD/SDIO card, that
-      power sequence must be maintained while initializing the card.
-
-patternProperties:
-  "^.*@[0-9]+$":
-    type: object
-    description: |
-      On embedded systems the cards connected to a host may need
-      additional properties. These can be specified in subnodes to the
-      host controller node. The subnodes are identified by the
-      standard \'reg\' property. Which information exactly can be
-      specified depends on the bindings for the SDIO function driver
-      for the subnode, as specified by the compatible string.
-
-    properties:
-      compatible:
-        description: |
-          Name of SDIO function following generic names recommended
-          practice
-
-      reg:
-        items:
-          - minimum: 0
-            maximum: 7
-            description:
-              Must contain the SDIO function number of the function this
-              subnode describes. A value of 0 denotes the memory SD
-              function, values from 1 to 7 denote the SDIO functions.
-
-      broken-hpi:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          Use this to indicate that the mmc-card has a broken hpi
-          implementation, and that hpi should not be used.
-
-    required:
-      - reg
-
-  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 2
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 359
-      description:
-        Set the clock (phase) delays which are to be configured in the
-        controller while switching to particular speed mode. These values
-        are in pair of degrees.
-
-dependencies:
-  cd-debounce-delay-ms: [ cd-gpios ]
-  fixed-emmc-driver-type: [ non-removable ]
-
 examples:
   - |
     sdhci@ab000000 {
-- 
2.11.0

