Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812F6250287
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Aug 2020 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHXQdA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Aug 2020 12:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgHXQ14 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:27:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FAE214F1;
        Mon, 24 Aug 2020 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286474;
        bh=yKCM7tLnXxMws8MTZ9jhKA97yUjAzHOZPP6ETkwSECU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T28+DYimoy5ezz1TXh0OAU7UF/YfnHNFL5qVY9mjiduN7+REBZvhRh0pmYSQFqGGj
         w+t3D2KHxkx1wevSR322Urb5CVSvHzQ8se31+dhbPvC2x9YKmq3iUlwue7nS/1H6Ju
         XRftq/YfTgR0Fbn7Sw71UGh0vzsd8jBrncXH2hOc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
Date:   Mon, 24 Aug 2020 18:26:39 +0200
Message-Id: <20200824162652.21047-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,imx27-pwm']
    From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: Additional items are not allowed ('fsl,imx27-pwm' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 01df06777cba..473863eb67e5 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -19,9 +19,17 @@ properties:
       - 3
 
   compatible:
-    enum:
-      - fsl,imx1-pwm
-      - fsl,imx27-pwm
+    oneOf:
+      - enum:
+          - fsl,imx1-pwm
+          - fsl,imx27-pwm
+      - items:
+          - enum:
+              - fsl,imx8mm-pwm
+              - fsl,imx8mn-pwm
+              - fsl,imx8mp-pwm
+              - fsl,imx8mq-pwm
+          - const: fsl,imx27-pwm
 
   reg:
     maxItems: 1
-- 
2.17.1

