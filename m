Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D359A620
	for <lists+linux-mmc@lfdr.de>; Fri, 19 Aug 2022 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350789AbiHSTIP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Aug 2022 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351060AbiHSTID (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 15:08:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1310AE14;
        Fri, 19 Aug 2022 12:07:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7fOr115796;
        Fri, 19 Aug 2022 14:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660936061;
        bh=i1NuIgqPXRGTGN8FoZMoWICP0m5oma4h3hunqbYx3z0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lqq/2/ppFbxq1P9iRjdBeoXjBO/EzsMaXgszq8/ReVDhf5x4UhqBdxO+uzfKzmCxy
         gzVCbghNljHDLJ0DAsaZbBauL9Uq0Yq8ByKiYE0F3g8en+ZqyEZw4xuxzjg7OkdaRS
         rtFTWMXS7sfg/p368nKzuqK0R1HdF1OqSue0bl2I=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27JJ7f96130045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 14:07:41 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 14:07:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 14:07:40 -0500
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7T2t051038;
        Fri, 19 Aug 2022 14:07:36 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 1/3] dt-bindings: irqchip: ti,sci-inta: Fix warning '#interrupt-cells' was unexpected
Date:   Sat, 20 Aug 2022 00:37:27 +0530
Message-ID: <20220819190729.32358-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819190729.32358-1-a-nandan@ti.com>
References: <20220819190729.32358-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

#interrupt-cells = <0> property is required in device tree for
ti,sci-inta nodes, or else we will have following warning when building
device tree files with W=2 warning level.

arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:147.51-156.5: Warning (interrupt_provider): /bus@100000/main-navss/interrupt-controller@33d00000: Missing #interrupt-cells in interrupt provider

And further, #interrupt-cells is required to be in yaml bindings as well
to prevent following schema warnings:

k3-j721e-common-proc-board.dtb: interrupt-controller@33d00000: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
From schema: linux/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml

Add #interrupt-cells property in ti,sci-inta.yaml

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index 88c46e61732e..1151518859bd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -59,6 +59,9 @@ properties:
 
   interrupt-controller: true
 
+  '#interrupt-cells':
+    const: 0
+
   msi-controller: true
 
   ti,interrupt-ranges:
-- 
2.17.1

