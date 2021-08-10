Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99203DB3AE
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Jul 2021 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhG3Gdc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Jul 2021 02:33:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:45258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237512AbhG3Gda (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jul 2021 02:33:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193318819"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="193318819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="664714908"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2021 23:33:20 -0700
From:   rashmi.a@intel.com
To:     linux-drivers-review-request@eclists.intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, kenchappa.demakkanavar@intel.com,
        rashmi.a@intel.com
Subject: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver
Date:   Fri, 30 Jul 2021 12:03:08 +0530
Message-Id: <20210730063309.8194-3-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730063309.8194-1-rashmi.a@intel.com>
References: <20210730063309.8194-1-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Intel Thunder Bay SoC eMMC controller is based on Arasan
eMMC 5.1 host controller IP

Signed-off-by: Rashmi A <rashmi.a@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 839965f7c717..6f202fb7a546 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -185,6 +185,13 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
 	.hiword_update = false,
 };
 
+static const struct sdhci_arasan_soc_ctl_map thunderbay_soc_ctl_map = {
+	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
+	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
+	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
+	.hiword_update = false,
+};
+
 static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
 	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
@@ -430,6 +437,15 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_arasan_thunderbay_pdata = {
+	.ops = &sdhci_arasan_cqe_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		SDHCI_QUIRK2_STOP_WITH_TC |
+		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -1098,6 +1114,12 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.clk_ops = &arasan_clk_ops,
 };
 
+static const struct sdhci_arasan_of_data sdhci_arasan_thunderbay_data = {
+	.soc_ctl_map = &thunderbay_soc_ctl_map,
+	.pdata = &sdhci_arasan_thunderbay_pdata,
+	.clk_ops = &arasan_clk_ops,
+};
+
 static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -1231,6 +1253,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "intel,keembay-sdhci-5.1-sdio",
 		.data = &intel_keembay_sdio_data,
 	},
+	{
+		.compatible = "intel,thunderbay-sdhci-5.1",
+		.data = &sdhci_arasan_thunderbay_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
@@ -1582,7 +1608,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
-	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
+	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio") ||
+	    of_device_is_compatible(np, "intel,thunderbay-sdhci-5.1")) {
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 		sdhci_arasan_update_support64b(host, 0x0);
 
-- 
2.17.1

