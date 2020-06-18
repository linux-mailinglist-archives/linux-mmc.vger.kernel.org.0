Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE261FE97E
	for <lists+linux-mmc@lfdr.de>; Thu, 18 Jun 2020 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFRDeW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jun 2020 23:34:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42306 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgFRDeS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Jun 2020 23:34:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D33D200039;
        Thu, 18 Jun 2020 05:34:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 523A9200015;
        Thu, 18 Jun 2020 05:34:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A063402B0;
        Thu, 18 Jun 2020 11:34:01 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        s.trumtrar@pengutronix.de, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 3/3] dt-bindings: clock: Correct example in i.MX8QXP LPCG binding
Date:   Thu, 18 Jun 2020 11:22:58 +0800
Message-Id: <1592450578-30140-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In i.MX8QXP LPCG binding's example, "fsl,imx7d-usdhc" as fallback
compatible is incorrect, remove it to avoid below build error:

Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
mmc@5b010000: compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch, to fix build error when patch #1 is added.
---
 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
index 33f3010..1d5e9bc 100644
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
@@ -62,7 +62,7 @@ examples:
     };
 
     mmc@5b010000 {
-        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+        compatible = "fsl,imx8qxp-usdhc";
         interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
         reg = <0x5b010000 0x10000>;
         clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-- 
2.7.4

