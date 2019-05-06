Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42914682
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFIjI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 04:39:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:40624 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfEFIjH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 May 2019 04:39:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 01:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="148965440"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2019 01:38:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH V2] mmc: sdhci-pci: Fix BYT OCP setting
Date:   Mon,  6 May 2019 11:38:53 +0300
Message-Id: <20190506083853.12741-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some time ago, a fix was done for the sdhci-acpi driver, refer
commit 6e1c7d6103fe ("mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO
hangs"). The same issue was not expected to affect the sdhci-pci driver,
but there have been reports to the contrary, so make the same hardware
setting change.

This patch applies to v5.0+ but before that backports will be required.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---



Changes in V2:
	Get rid of macros BYT_PM_OPS, BYT_SPM_OPS and BYT_RPM_OPS
	Add fix pm ops also to sdhci_intel_byt_emmc



 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 96 +++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9c01310a0d2e..d084a9d63623 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -92,6 +92,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select IOSF_MBI if X86
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index a3d7a9db76c5..ab9e2b901094 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -31,6 +31,10 @@
 #include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
 
+#ifdef CONFIG_X86
+#include <asm/iosf_mbi.h>
+#endif
+
 #include "cqhci.h"
 
 #include "sdhci.h"
@@ -451,6 +455,50 @@ static const struct sdhci_pci_fixes sdhci_intel_pch_sdio = {
 	.probe_slot	= pch_hc_probe_slot,
 };
 
+#ifdef CONFIG_X86
+
+#define BYT_IOSF_SCCEP			0x63
+#define BYT_IOSF_OCP_NETCTRL0		0x1078
+#define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
+
+static void byt_ocp_setting(struct pci_dev *pdev)
+{
+	u32 val = 0;
+
+	if (pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC &&
+	    pdev->device != PCI_DEVICE_ID_INTEL_BYT_SDIO &&
+	    pdev->device != PCI_DEVICE_ID_INTEL_BYT_SD &&
+	    pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC2)
+		return;
+
+	if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
+			  &val)) {
+		dev_err(&pdev->dev, "%s read error\n", __func__);
+		return;
+	}
+
+	if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
+		return;
+
+	val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
+
+	if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
+			   val)) {
+		dev_err(&pdev->dev, "%s write error\n", __func__);
+		return;
+	}
+
+	dev_dbg(&pdev->dev, "%s completed\n", __func__);
+}
+
+#else
+
+static inline void byt_ocp_setting(struct pci_dev *pdev)
+{
+}
+
+#endif
+
 enum {
 	INTEL_DSM_FNS		=  0,
 	INTEL_DSM_V18_SWITCH	=  3,
@@ -715,6 +763,8 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
 
 	byt_read_dsm(slot);
 
+	byt_ocp_setting(slot->chip->pdev);
+
 	ops->execute_tuning = intel_execute_tuning;
 	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
 
@@ -938,7 +988,35 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int byt_resume(struct sdhci_pci_chip *chip)
+{
+	byt_ocp_setting(chip->pdev);
+
+	return sdhci_pci_resume_host(chip);
+}
+
+#endif
+
+#ifdef CONFIG_PM
+
+static int byt_runtime_resume(struct sdhci_pci_chip *chip)
+{
+	byt_ocp_setting(chip->pdev);
+
+	return sdhci_pci_runtime_resume_host(chip);
+}
+
+#endif
+
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
+#ifdef CONFIG_PM_SLEEP
+	.resume		= byt_resume,
+#endif
+#ifdef CONFIG_PM
+	.runtime_resume	= byt_runtime_resume,
+#endif
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
@@ -972,6 +1050,12 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
 };
 
 static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
+#ifdef CONFIG_PM_SLEEP
+	.resume		= byt_resume,
+#endif
+#ifdef CONFIG_PM
+	.runtime_resume	= byt_runtime_resume,
+#endif
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
 			  SDHCI_QUIRK_NO_LED,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
@@ -983,6 +1067,12 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
+#ifdef CONFIG_PM_SLEEP
+	.resume		= byt_resume,
+#endif
+#ifdef CONFIG_PM
+	.runtime_resume	= byt_runtime_resume,
+#endif
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
 			  SDHCI_QUIRK_NO_LED,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
@@ -994,6 +1084,12 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
+#ifdef CONFIG_PM_SLEEP
+	.resume		= byt_resume,
+#endif
+#ifdef CONFIG_PM
+	.runtime_resume	= byt_runtime_resume,
+#endif
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
 			  SDHCI_QUIRK_NO_LED,
 	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
-- 
2.17.1

