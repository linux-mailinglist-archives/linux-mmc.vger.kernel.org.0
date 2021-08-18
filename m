Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642503F00B9
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Aug 2021 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhHRJkU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Aug 2021 05:40:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33322 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231539AbhHRJkU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 05:40:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2717E1A070A;
        Wed, 18 Aug 2021 11:39:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E295B1A4DB8;
        Wed, 18 Aug 2021 11:39:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 63954183ACDE;
        Wed, 18 Aug 2021 17:39:43 +0800 (+08)
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add a new compatible string
Date:   Wed, 18 Aug 2021 17:17:57 +0800
Message-Id: <1629278277-7313-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Lack a compatible string "fsl,imx6sll-usdhc", so add it here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 8a9f1775b0e2..1457eb21473e 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -29,6 +29,7 @@ properties:
           - fsl,imx53-esdhc
           - fsl,imx6q-usdhc
           - fsl,imx6sl-usdhc
+          - fsl,imx6sll-usdhc
           - fsl,imx6sx-usdhc
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
-- 
2.17.1

