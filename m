Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C63F18DD
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Aug 2021 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhHSMOr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Aug 2021 08:14:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60708 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239061AbhHSMOq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Aug 2021 08:14:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68DF61A035B;
        Thu, 19 Aug 2021 14:14:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 310D31A0FB6;
        Thu, 19 Aug 2021 14:14:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A7717183ACDC;
        Thu, 19 Aug 2021 20:14:07 +0800 (+08)
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: fsl-imx-esdhc: change the pinctrl-names rule
Date:   Thu, 19 Aug 2021 19:52:18 +0800
Message-Id: <1629373938-9226-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Change the pinctrl-names rule to cover all cases.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index d7c8e5880473..f04728145275 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -124,12 +124,17 @@ properties:
       - const: per
 
   pinctrl-names:
-    minItems: 1
-    items:
-      - const: default
-      - const: state_100mhz
-      - const: state_200mhz
-      - const: sleep
+    oneOf:
+      - minItems: 3
+        items:
+          - const: default
+          - const: state_100mhz
+          - const: state_200mhz
+          - const: sleep
+      - minItems: 1
+        items:
+          - const: default
+          - const: sleep
 
 required:
   - compatible
-- 
2.17.1

