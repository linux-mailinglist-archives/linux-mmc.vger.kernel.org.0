Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268DA6FF38
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfGVMHt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 08:07:49 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60937 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfGVMHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 08:07:49 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1068F60005;
        Mon, 22 Jul 2019 12:07:46 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] dt-bindings: mmc: sunxi: Add H5 compatibles
Date:   Mon, 22 Jul 2019 14:07:40 +0200
Message-Id: <20190722120740.8966-2-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722120740.8966-1-maxime.ripard@bootlin.com>
References: <20190722120740.8966-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The conversion to the YAML binding left out two compatibles. Add them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 06329115dc6a..d2d4308596b8 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -35,6 +35,12 @@ properties:
       - items:
           - const: allwinner,sun8i-r40-mmc
           - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun50i-h5-emmc
+          - const: allwinner,sun50i-a64-emmc
+      - items:
+          - const: allwinner,sun50i-h5-mmc
+          - const: allwinner,sun50i-a64-mmc
       - items:
           - const: allwinner,sun50i-h6-emmc
           - const: allwinner,sun50i-a64-emmc
-- 
2.21.0

