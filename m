Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C571345C1
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Jan 2020 16:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgAHPH6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Jan 2020 10:07:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgAHPH5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 10:07:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008F7rSI059184;
        Wed, 8 Jan 2020 09:07:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578496073;
        bh=j7w2DtxlICKliC+wv2TI2d8tahuuGdO68EPbAxoop4w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TAu7Ybx41NcuSHawO3dtkMJM03FDVMAfi2OG2o9OUWCOSw+DIG9HDfA1R1901j2rG
         RnbNh3aS49Za4DEGIvkfKLltE3a2P530frsKz+ur1OKLWru/MApQe9SWA7B9w664j/
         Cn2EuN8dJJ+MNxJMAR+aYibksizrUYU/QWEKACDg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008F7rwF070676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 09:07:53 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 09:07:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 09:07:52 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ln1018107;
        Wed, 8 Jan 2020 09:07:50 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
Date:   Wed, 8 Jan 2020 20:39:18 +0530
Message-ID: <20200108150920.14547-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20200108150920.14547-1-faiz_abbas@ti.com>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to latest AM65x Data Manual[1], a different output tap delay
value is recommended for all speed modes. Therefore, replace the
ti,otap-del-sel binding with one ti,otap-del-sel- for each MMC/SD speed
mode.

[1] http://www.ti.com/lit/gpn/am6526

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.txt   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
index 50e87df47971..c6ccecb9ae5a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -18,7 +18,20 @@ Required Properties:
 	- clocks: Handles to the clock inputs.
 	- clock-names: Tuple including "clk_xin" and "clk_ahb"
 	- interrupts: Interrupt specifiers
-	- ti,otap-del-sel: Output Tap Delay select
+	Output tap delay for each speed mode:
+	- ti,otap-del-sel-legacy
+	- ti,otap-del-sel-mmc-hs
+	- ti,otap-del-sel-sd-hs
+	- ti,otap-del-sel-sdr12
+	- ti,otap-del-sel-sdr25
+	- ti,otap-del-sel-sdr50
+	- ti,otap-del-sel-sdr104
+	- ti,otap-del-sel-ddr50
+	- ti,otap-del-sel-ddr52
+	- ti,otap-del-sel-hs200
+	- ti,otap-del-sel-hs400
+	  These bindings must be provided otherwise the driver will disable the
+	  corresponding speed mode (i.e. all nodes must provide at least -legacy)
 
 Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
 	- ti,trm-icp: DLL trim select
@@ -38,6 +51,10 @@ Example:
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		sdhci-caps-mask = <0x80000007 0x0>;
 		mmc-ddr-1_8v;
-		ti,otap-del-sel = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x5>;
+		ti,otap-del-sel-hs200 = <0x5>;
+		ti,otap-del-sel-hs400 = <0x0>;
 		ti,trm-icp = <0x8>;
 	};
-- 
2.19.2

