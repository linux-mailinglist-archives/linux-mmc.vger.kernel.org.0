Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029A64CB4F
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFTJuV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Jun 2019 05:50:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:61109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFTJuU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Jun 2019 05:50:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 02:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="358892667"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2019 02:50:19 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Add support for Intel EHL
Date:   Thu, 20 Jun 2019 12:49:01 +0300
Message-Id: <20190620094901.8539-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add PCI Ids for Intel EHL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 drivers/mmc/host/sdhci-pci.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index fa6a8fa560c3..4041878eb0f3 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1668,6 +1668,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, CNPH_SD,   intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, ICP_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, ICP_SD,    intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, EHL_EMMC,  intel_glk_emmc),
+	SDHCI_PCI_DEVICE(INTEL, EHL_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e5dc6e44c7a4..cdd15f357d01 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -50,6 +50,8 @@
 #define PCI_DEVICE_ID_INTEL_CNPH_SD	0xa375
 #define PCI_DEVICE_ID_INTEL_ICP_EMMC	0x34c4
 #define PCI_DEVICE_ID_INTEL_ICP_SD	0x34f8
+#define PCI_DEVICE_ID_INTEL_EHL_EMMC	0x4b47
+#define PCI_DEVICE_ID_INTEL_EHL_SD	0x4b48
 #define PCI_DEVICE_ID_INTEL_CML_EMMC	0x02c4
 #define PCI_DEVICE_ID_INTEL_CML_SD	0x02f5
 
-- 
2.17.1

