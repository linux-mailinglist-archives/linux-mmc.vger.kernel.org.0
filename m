Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10A33EC3
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 08:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFDGJK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 02:09:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59376 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFDGJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 02:09:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54692kN109750;
        Tue, 4 Jun 2019 01:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559628542;
        bh=PrQgR1tyd+6Tb+EW5dqTCe61J5++hd7LMPqAUwhVVN0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zAq2LP01fKzHRmxsvoK3KRJOnMFHHtSqjS3WhGUKU6YBdyyGETJJumAnmbahazrjr
         PbhzBBbrIa7Vw0ZikfBVtwdMbgyaK6E9gObKHVAl8CEQm5GtBNdMoiPje6QFOyzE4k
         MDsx7N8L1xH5jFTqpJXUmr+nxtdWwH3NgJ8D3/kQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54692Hu034820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 01:09:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 01:09:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 01:09:01 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5468pZ0049516;
        Tue, 4 Jun 2019 01:08:58 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <nm@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 1/4] dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's J721E devices.
Date:   Tue, 4 Jun 2019 11:39:11 +0530
Message-ID: <20190604060914.10886-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding documentation for mmc host controllers present on TI's J721E
SOC. The 4 bit IP on J721E doesn't have a phy DLL so make DLL related
properties as optional for that compatible. Also add an optional
strobe-sel property used for HS400 speed mode.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
index 15dbbbace27e..50e87df47971 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -8,7 +8,10 @@ Only deviations are documented here.
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Required Properties:
-	- compatible: should be "ti,am654-sdhci-5.1"
+	- compatible: should be one of:
+			"ti,am654-sdhci-5.1": SDHCI on AM654 device.
+			"ti,j721e-sdhci-8bit": 8 bit SDHCI on J721E device.
+			"ti,j721e-sdhci-4bit": 4 bit SDHCI on J721E device.
 	- reg: Must be two entries.
 		- The first should be the sdhci register space
 		- The second should the subsystem/phy register space
@@ -16,9 +19,13 @@ Required Properties:
 	- clock-names: Tuple including "clk_xin" and "clk_ahb"
 	- interrupts: Interrupt specifiers
 	- ti,otap-del-sel: Output Tap Delay select
+
+Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
 	- ti,trm-icp: DLL trim select
 	- ti,driver-strength-ohm: driver strength in ohms.
 				  Valid values are 33, 40, 50, 66 and 100 ohms.
+Optional Properties:
+	- ti,strobe-sel: strobe select delay for HS400 speed mode. Default value: 0x0.
 
 Example:
 
-- 
2.19.2

