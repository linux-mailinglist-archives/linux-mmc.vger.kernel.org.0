Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588F5FDC2A
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOLUf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:20:35 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51078 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLUf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:20:35 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D9491A0A30;
        Fri, 15 Nov 2019 12:20:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CF991A0AB2;
        Fri, 15 Nov 2019 12:20:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B7C8A40309;
        Fri, 15 Nov 2019 19:20:23 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH 13/14] mmc: sdhci-esdhc-imx: handle 'auto-cmd23-broken' from devicetree
Date:   Fri, 15 Nov 2019 19:18:31 +0800
Message-Id: <1573816712-26841-4-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq->sbc
when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD23 for
RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, the
RPMB write operation will return general fail.

According to the sdhci logic, SDMA mode will disable the ACMD23, and only in
ADMA mode, it will chose to use ACMD23 if the host support. But according to
debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
the ACMD23 feature completely. These SoCs only use the 16 bit block count of
the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
means it will ignore the upper 16 bit of the CMD23's argument. This will block
the reliable write operation in RPMB, because RPMB reliable write need to set
the bit31 of the CMD23's argument. This is the hardware limitation. Due to
imx6sl use SDMA, so for imx6qpdl/imx6sx/imx7d, it need to broke the ACMD23 for
eMMC, SD card do not has this limitation, because SD card do not support reliable
write.

For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, it
change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADMA mode.

This patch handle 'fsl,auto-cmd23-broken' from devicetree.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 80a148f8009e..83b4156b2cf4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1374,6 +1374,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_find_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
+	if (of_find_property(np, "fsl,auto-cmd23-broken", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
+
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
-- 
2.17.1

