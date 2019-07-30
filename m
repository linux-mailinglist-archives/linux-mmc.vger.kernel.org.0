Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1147A119
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Jul 2019 08:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfG3GIq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 30 Jul 2019 02:08:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:5850 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfG3GIp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Jul 2019 02:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 23:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,325,1559545200"; 
   d="scan'208";a="195688995"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2019 23:08:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Add another Id for Intel CML
Date:   Tue, 30 Jul 2019 09:07:23 +0300
Message-Id: <20190730060723.21715-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add another PCI Id for Intel CML.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 30d6051cd1d5..e1ca185d7328 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1672,6 +1672,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, EHL_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
 	SDHCI_PCI_DEVICE(O2, 8220,     o2),
 	SDHCI_PCI_DEVICE(O2, 8221,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index cdd15f357d01..1abc9d47a4c0 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -54,6 +54,7 @@
 #define PCI_DEVICE_ID_INTEL_EHL_SD	0x4b48
 #define PCI_DEVICE_ID_INTEL_CML_EMMC	0x02c4
 #define PCI_DEVICE_ID_INTEL_CML_SD	0x02f5
+#define PCI_DEVICE_ID_INTEL_CMLH_SD	0x06f5
 
 #define PCI_DEVICE_ID_SYSKONNECT_8000	0x8000
 #define PCI_DEVICE_ID_VIA_95D0		0x95d0
-- 
2.17.1

