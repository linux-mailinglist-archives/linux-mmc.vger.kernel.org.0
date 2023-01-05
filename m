Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30765F5E8
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Jan 2023 22:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjAEVjZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Jan 2023 16:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEVjY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2023 16:39:24 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06023671BC;
        Thu,  5 Jan 2023 13:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AhH6eLvFTyTXzefYJDRhSSM1c636n8NUP2ghngWh9B4=; b=TJE+5zRtvlUdOanWiqGg8fa+aL
        VOYQjIk3sHp76KJSCjmZUwbfy71hJ1PYXBO3gTEuIMWYKWet2B1Yi/J4gr0cPylEPDrhNO2WLy7bp
        m9EYIOD6xZvCJ/rOvdCFK746juuU3vZx03HSVSMdy+JBLFBoR8YeyTxMPCv025ALgM0nWhKMNhPjJ
        yVsRsNSI2jVldje1EEJZ3VqPIlLeWhl1qLA+Rh+Vdqptz/CGXklILXIH6xX5JJ5MXBtNpBsfpVskh
        4rJCcPTz3sQu9cV0nd4uMxchq1DAq5H501fIBsPEEkP7ecdly3qjiQkVc9QUFaPHiBuUERwcyT3R1
        3xBG7Hbg==;
Received: from p200300ccff1194001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff11:9400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pDXx1-0001Ks-B1; Thu, 05 Jan 2023 22:39:03 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pDXx0-007ffw-NW; Thu, 05 Jan 2023 22:39:02 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible combinations
Date:   Thu,  5 Jan 2023 22:38:56 +0100
Message-Id: <20230105213856.1828360-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently make dtbs_check shows lots of errors because imx*.dtsi does
not use single compatibles but combinations of them.
Allow all the combinations used there.

Patches fixing the dtsi files according to binding documentation were
submitted multiple times and are commonly rejected, so relax the rules.
Example:
https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/

Reason: compatibility of new dtbs with old kernels or bootloaders.

This will significantly reduce noise on make dtbs_check.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index dc6256f04b42..118ebb75f136 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -37,6 +37,30 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+      - items:
+          - const: fsl,imx50-esdhc
+          - const: fsl,imx53-esdhc
+      - items:
+          - const: fsl,imx6sl-usdhc
+          - const: fsl,imx6q-usdhc
+      - items:
+          - const: fsl,imx6sll-usdhc
+          - const: fsl,imx6sx-usdhc
+      - items:
+          - const: fsl,imx6sx-usdhc
+          - const: fsl,imx6sl-usdhc
+      - items:
+          - const: fsl,imx6ul-usdhc
+          - const: fsl,imx6sx-usdhc
+      - items:
+          - const: fsl,imx6ull-usdhc
+          - const: fsl,imx6sx-usdhc
+      - items:
+          - const: fsl,imx7d-usdhc
+          - const: fsl,imx6sl-usdhc
+      - items:
+          - const: fsl,imx7ulp-usdhc
+          - const: fsl,imx6sx-usdhc
       - items:
           - enum:
               - fsl,imx8mq-usdhc
-- 
2.30.2

