Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8E3CF8FC
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jul 2021 13:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhGTLCG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Jul 2021 07:02:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:57865 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236474AbhGTLB7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jul 2021 07:01:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211218060"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211218060"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 04:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="510723705"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2021 04:41:39 -0700
From:   rashmi.a@intel.com
To:     linux-drivers-review-request@eclists.intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, kenchappa.demakkanavar@intel.com,
        rashmi.a@intel.com
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=201/3=5D=20dt-bindings=3A=20phy=3A=20intel=3A=20Add=20Thunder=20Bay=20eMMC=20PHY=20bindings?=
Date:   Tue, 20 Jul 2021 17:11:31 +0530
Message-Id: <20210720114133.8936-2-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720114133.8936-1-rashmi.a@intel.com>
References: <20210720114133.8936-1-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Binding description for Intel Thunder Bay eMMC PHY.
Added the newly introduced files into MAINTAINERS file-list

Signed-off-by: Rashmi A <rashmi.a@intel.com>
---
 .../phy/intel,phy-thunderbay-emmc.yaml        | 49 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml b/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
new file mode 100644
index 000000000000..5b764095746e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,phy-thunderbay-emmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Thunder Bay eMMC PHY bindings
+
+maintainers:
+  - Srikandan Nandhini <nandhini.srikandan@intel.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: intel,thunderbay-emmc-phy
+      - const: intel,thunderbay-sdhci-5.1
+      - const: intel,thunderbay-sd-phy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: emmcclk
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+     mmc_phy@80440800 {
+     #phy-cells = <0x0>;
+     compatible = "intel,thunderbay-emmc-phy";
+     status = "okay";
+     reg = <0x80440800 0x100>;
+     clocks = <&emmc>;
+     clock-names = "emmcclk";
+     };
diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..44533319c900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9278,6 +9278,13 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
 F:	drivers/crypto/keembay/ocs-hcu.c
 F:	drivers/crypto/keembay/ocs-hcu.h
 
+INTEL THUNDER BAY EMMC PHY DRIVER
+M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
+M:	Rashmi A <rashmi.a@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
+F:	drivers/phy/intel/phy-intel-thunderbay-emmc.c
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

