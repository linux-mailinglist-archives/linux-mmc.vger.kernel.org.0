Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57836D0538
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 03:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJIB22 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Oct 2019 21:28:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:22712 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfJIB21 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Oct 2019 21:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 18:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="205597249"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 08 Oct 2019 18:28:24 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        michal.simek@xilinx.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM SDXC
Date:   Wed,  9 Oct 2019 09:28:17 +0800
Message-Id: <20191009012818.32763-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a new compatible to use the sdhc-arasan host controller driver
with the SDXC PHY to support on Intel's Lightning Mountain(LGM) SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7ca0aa7ccc0b..eb78d9a28c8b 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -19,6 +19,8 @@ Required Properties:
 	Note: This binding has been deprecated and moved to [5].
     - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
 
   [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 
@@ -97,3 +99,18 @@ Example:
 		phy-names = "phy_arasan";
 		arasan,soc-ctl-syscon = <&sysconf>;
 	};
+
+	sdxc: sdhci@ec600000 {
+		compatible = "arasan,sdhci-5.1", "intel,lgm-sdhci-5.1-sdxc";
+		reg = <0xec600000 0x300>;
+		interrupt-parent = <&ioapic1>;
+		interrupts = <43 1>;
+		clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
+			 <&cgu0 LGM_GCLK_SDXC>;
+		clock-names = "clk_xin", "clk_ahb", "gate";
+		clock-output-names = "sdxc_cardclock";
+		#clock-cells = <0>;
+		phys = <&sdxc_phy>;
+		phy-names = "phy_arasan";
+		arasan,soc-ctl-syscon = <&sysconf>;
+	};
-- 
2.11.0

