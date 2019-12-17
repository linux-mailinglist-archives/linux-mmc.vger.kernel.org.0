Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87381122804
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Dec 2019 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfLQJyl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Dec 2019 04:54:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:35646 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfLQJyl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 04:54:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 01:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="416769642"
Received: from unknown (HELO ahunter-Desktop.fi.intel.com) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2019 01:54:40 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/2] mmc: sdhci: Workaround broken command queuing on Intel GLK
Date:   Tue, 17 Dec 2019 11:53:48 +0200
Message-Id: <20191217095349.14592-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Command queuing has been reported broken on some Lenovo systems based on
Intel GLK. This is likely a BIOS issue, so disable command queuing for
Intel GLK if the BIOS vendor string is "LENOVO".

Fixes: 8ee82bda230f ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index acefb76b4e15..5091e2c1c0e5 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -27,6 +27,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 #include <asm/iosf_mbi.h>
@@ -783,11 +784,18 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
+{
+	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
+	       dmi_match(DMI_BIOS_VENDOR, "LENOVO");
+}
+
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int ret = byt_emmc_probe_slot(slot);
 
-	slot->host->mmc->caps2 |= MMC_CAP2_CQE;
+	if (!glk_broken_cqhci(slot))
+		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
 
 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
 		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
-- 
2.17.1

