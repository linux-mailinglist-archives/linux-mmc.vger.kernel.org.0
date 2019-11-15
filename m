Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4FFDBFC
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOLKV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:10:21 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41256 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLKV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:10:21 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02ED81A0A30;
        Fri, 15 Nov 2019 12:10:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 561B91A0A2E;
        Fri, 15 Nov 2019 12:10:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AB9F040305;
        Fri, 15 Nov 2019 19:10:12 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 03/14] mmc: sdhci: correct the DMA setting for IOMMU
Date:   Fri, 15 Nov 2019 19:07:55 +0800
Message-Id: <1573816075-26390-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The default max segment size of IOMMU is 64KB, which exceed the ADMA
limitation if ADMA only support max to 65535, 64KB - 1Byte. IOMMU will
optimize the segments it received, merge the little segment into one
big segment. If we use the default IOMMU config, then ADMA will get
some segments which it's size is 64KB. Then ADMA error will shows up.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1436cc9c5f82..3a8093de26c7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3743,6 +3743,7 @@ static inline bool sdhci_can_64bit_dma(struct sdhci_host *host)
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
+	struct device *dev;
 	u32 max_current_caps;
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
@@ -3754,6 +3755,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		return -EINVAL;
 
 	mmc = host->mmc;
+	dev = mmc_dev(mmc);
 
 	/*
 	 * If there are external regulators, get them. Note this must be done
@@ -4224,10 +4226,20 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * be larger than 64 KiB though.
 	 */
 	if (host->flags & SDHCI_USE_ADMA) {
-		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
+		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
 			mmc->max_seg_size = 65535;
-		else
+
+			/*
+			 * send the ADMA limitation to IOMMU. In default,
+			 * the max segment size of IOMMU is 64KB, this exceed
+			 * the ADMA max segment limitation, which is 65535.
+			 */
+			dev->dma_parms = devm_kzalloc(dev,
+					sizeof(*dev->dma_parms), GFP_KERNEL);
+			dma_set_max_seg_size(dev, SZ_64K - 1);
+		} else {
 			mmc->max_seg_size = 65536;
+		}
 	} else {
 		mmc->max_seg_size = mmc->max_req_size;
 	}
-- 
2.17.1

