Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B76FF36
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 14:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfGVMHr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 08:07:47 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54029 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfGVMHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 08:07:47 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A3355FF802;
        Mon, 22 Jul 2019 12:07:44 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: mmc: sunxi: reorder MMC compatibles
Date:   Mon, 22 Jul 2019 14:07:39 +0200
Message-Id: <20190722120740.8966-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMC compatibles in the bindings are not ordered as they should, so
let's make sure it's sorted.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index df0280edef97..06329115dc6a 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -29,18 +29,18 @@ properties:
       - items:
           - const: allwinner,sun8i-a83t-mmc
           - const: allwinner,sun7i-a20-mmc
-      - items:
-          - const: allwinner,sun50i-h6-emmc
-          - const: allwinner,sun50i-a64-emmc
-      - items:
-          - const: allwinner,sun50i-h6-mmc
-          - const: allwinner,sun50i-a64-mmc
       - items:
           - const: allwinner,sun8i-r40-emmc
           - const: allwinner,sun50i-a64-emmc
       - items:
           - const: allwinner,sun8i-r40-mmc
           - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun50i-h6-emmc
+          - const: allwinner,sun50i-a64-emmc
+      - items:
+          - const: allwinner,sun50i-h6-mmc
+          - const: allwinner,sun50i-a64-mmc
 
   reg:
     maxItems: 1
-- 
2.21.0

