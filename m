Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1F24EE3F
	for <lists+linux-mmc@lfdr.de>; Sun, 23 Aug 2020 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgHWQQ4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 23 Aug 2020 12:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHWQQs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:16:48 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7222076D;
        Sun, 23 Aug 2020 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199407;
        bh=zn6SwQvRqTQI9Av55ZFXzkgJGiEIGN9PfDf4Q2x9mwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU2RoaJcPkOYCWG3H88Wf9mVI6pdoaJGzjaINJp+gE0Tka89iqCWOu59r4O0cu7IK
         RjVRixJieVJLRUEee6NA60Ent4ezbm3dToAQyOXK8VLmBjk5WvxnAsvZu2Go3V/Ul5
         4gdOZCyyM5CwvjCEagYWGLTouKHjaCAuwXX6NyV4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 11/22] dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
Date:   Sun, 23 Aug 2020 18:15:39 +0200
Message-Id: <20200823161550.3981-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible:0: 'fsl,imx8mn-tmu' is not one of ['fsl,imx8mm-tmu', 'fsl,imx8mp-tmu']
    From schema: Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible: ['fsl,imx8mn-tmu', 'fsl,imx8mm-tmu'] is too long

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible: Additional items are not allowed ('fsl,imx8mm-tmu' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/thermal/imx8mm-thermal.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
index 38852877b8e3..89c54e08ee61 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -18,9 +18,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8mm-tmu
-      - fsl,imx8mp-tmu
+    oneOf:
+      - enum:
+          - fsl,imx8mm-tmu
+          - fsl,imx8mp-tmu
+      - items:
+          - const: fsl,imx8mn-tmu
+          - const: fsl,imx8mm-tmu
 
   reg:
     maxItems: 1
-- 
2.17.1

