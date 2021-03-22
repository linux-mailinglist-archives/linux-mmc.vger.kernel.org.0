Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCB3438E1
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Mar 2021 06:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhCVFyW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Mar 2021 01:54:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:40812 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhCVFxt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 01:53:49 -0400
IronPort-SDR: a0crUhNE8wvv5YVq+Q21P+lP1MEmDUDfcWZ7/lVNT6H/9XfnAvv6voARtF8fd25CfSCFNuXieb
 JuFrOxAVOeqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="210271055"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="210271055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:53:49 -0700
IronPort-SDR: NtcBJDDTSOuQLdMjWJevcCmBndx/orvY2ZT/T3eEidr6sCoWGyjfv5T2pHGukwFkGP9xR0uD4A
 hfexdVh8PFCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="407666389"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2021 22:53:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Add PCI IDs for Intel LKF
Date:   Mon, 22 Mar 2021 07:53:56 +0200
Message-Id: <20210322055356.24923-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add PCI IDs for Intel LKF eMMC and SD card host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 drivers/mmc/host/sdhci-pci.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 62799c1d9c0c..b3caa174effe 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1903,6 +1903,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, JSL_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, LKF_EMMC,  intel_glk_emmc),
+	SDHCI_PCI_DEVICE(INTEL, LKF_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
 	SDHCI_PCI_DEVICE(O2, 8220,     o2),
 	SDHCI_PCI_DEVICE(O2, 8221,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d0ed232af0eb..8f90c4163bb5 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -57,6 +57,8 @@
 #define PCI_DEVICE_ID_INTEL_CMLH_SD	0x06f5
 #define PCI_DEVICE_ID_INTEL_JSL_EMMC	0x4dc4
 #define PCI_DEVICE_ID_INTEL_JSL_SD	0x4df8
+#define PCI_DEVICE_ID_INTEL_LKF_EMMC	0x98c4
+#define PCI_DEVICE_ID_INTEL_LKF_SD	0x98f8
 
 #define PCI_DEVICE_ID_SYSKONNECT_8000	0x8000
 #define PCI_DEVICE_ID_VIA_95D0		0x95d0
-- 
2.17.1

