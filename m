Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20F3ED473
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Aug 2021 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhHPNAz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Aug 2021 09:00:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58068 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhHPNAz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 09:00:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B1BFC1A2891;
        Mon, 16 Aug 2021 15:00:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77CFB1A288D;
        Mon, 16 Aug 2021 15:00:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E829A183AC8B;
        Mon, 16 Aug 2021 21:00:20 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add fsl,sdio-async-interrupt-enabled binding
Date:   Mon, 16 Aug 2021 20:38:25 +0800
Message-Id: <1629117508-4886-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add a new fsl,sdio-async-interrupt-enabled binding for sdio devices
which enable the async interrupt function. When get this property,
driver will avoid to use DAT[1] for hardware auto tuning check.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index b5baf439fbac..8a9f1775b0e2 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -122,6 +122,16 @@ properties:
       - const: state_200mhz
       - const: sleep
 
+  fsl,sdio-async-interrupt-enabled:
+    description: |
+      Recommend for SDIO cards that enables SDIO async interrupt for SDR104 and SDR50
+      operating modes. SDIO async interrupt uses DAT[1] to signal the card's interrupt.
+      uSDHC tuning mechanism must use DAT[0] and CMD signals to avoid a possible
+      conflict and incorrect delay line calculated by the uSDHC auto tuning mechanism.
+      Enabling this device tree property is only recommended for layouts that are
+      matching the SD interface length.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.17.1

