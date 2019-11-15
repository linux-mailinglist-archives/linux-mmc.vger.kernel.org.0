Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC16FDC20
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKOLSx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:18:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59762 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLSx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:18:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54600200094;
        Fri, 15 Nov 2019 12:18:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5320200049;
        Fri, 15 Nov 2019 12:18:45 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DDF4340305;
        Fri, 15 Nov 2019 19:18:38 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 12/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken binding
Date:   Fri, 15 Nov 2019 19:16:46 +0800
Message-Id: <1573816606-26779-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816606-26779-1-git-send-email-haibo.chen@nxp.com>
References: <1573816606-26779-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add fsl,auto-cmd23-broken binding.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index d50144f5f1d2..a776f418a028 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -43,6 +43,14 @@ Optional properties:
   property allows user to change the delay target for the strobe input read clock.
   If not use this property, driver default set the delay target to value 7.
   Only eMMC HS400 mode need to take care of this property.
+- fsl,auto-cmd23-broken: disable the ACMD23 function of USDHC.
+  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use ADMA mode. Because
+  for these SoC, it do not support the ACMD23 completely, only take the 16 bit block
+  count from the 0x4 register (BLK_ATT) as argument for the ACMD23, the upper 16 bit
+  of the CMD23's argument is ignored. This will impact the reliable write operation
+  and the RPMB block write operation, because these operations need to set the bit 31
+  of the CMD23's argument. SDMA mode will default disable the ACMD23 mode. SD card do
+  not has this limitation on these SoCs.
 
 Examples:
 
-- 
2.17.1

