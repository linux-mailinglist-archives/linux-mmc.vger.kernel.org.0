Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A484718F7
	for <lists+linux-mmc@lfdr.de>; Sun, 12 Dec 2021 08:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhLLHCX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 12 Dec 2021 02:02:23 -0500
Received: from marcansoft.com ([212.63.210.85]:59162 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhLLHCW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Dec 2021 02:02:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 649D0425D8;
        Sun, 12 Dec 2021 07:02:18 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF platforms
Date:   Sun, 12 Dec 2021 16:02:09 +0900
Message-Id: <20211212070210.141664-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212070210.141664-1-marcan@marcan.st>
References: <20211212070210.141664-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is required on some Apple ARM64 laptops using this controller.
As is typical on DT platforms, pull these quirks from the device tree
using the standard mmc bindings.

See Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4fd99c1e82ba..ad742743a494 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
@@ -114,8 +115,10 @@
 #define   GLI_9755_WT_EN_OFF    0x0
 
 #define PCI_GLI_9755_PECONF   0x44
-#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
-#define   PCI_GLI_9755_DMACLK   BIT(29)
+#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
+#define   PCI_GLI_9755_DMACLK         BIT(29)
+#define   PCI_GLI_9755_INVERT_CD      BIT(30)
+#define   PCI_GLI_9755_INVERT_WP      BIT(31)
 
 #define PCI_GLI_9755_CFG2          0x48
 #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
@@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	gl9755_wt_on(pdev);
 
 	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		/*
+		 * Apple ARM64 platforms using these chips may have
+		 * inverted CD/WP detection.
+		 */
+		if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
+			value |= PCI_GLI_9755_INVERT_CD;
+		if (of_property_read_bool(pdev->dev.of_node, "wp-inverted"))
+			value |= PCI_GLI_9755_INVERT_WP;
+	}
+#endif
 	value &= ~PCI_GLI_9755_LFCLK;
 	value &= ~PCI_GLI_9755_DMACLK;
 	pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
-- 
2.33.0

