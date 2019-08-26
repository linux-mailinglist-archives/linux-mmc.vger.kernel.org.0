Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61259CA58
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfHZH2M (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 03:28:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:62576 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbfHZH2L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Aug 2019 03:28:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 00:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="380432368"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 26 Aug 2019 00:28:08 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Muruganx 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM eMMC
Date:   Mon, 26 Aug 2019 15:28:00 +0800
Message-Id: <20190826072800.38413-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>

The current arasan sdhci PHY configuration isn't compatible
with the PHY on Intel's LGM(Lightning Mountain) SoC devices.

Therefore, add a new compatible, to adapt the Intel's LGM
eMMC PHY with arasan-sdhc controller to configure the PHY.

Signed-off-by: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b12abf9b15f2..7023cbec4017 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -114,6 +114,12 @@ static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
 	.hiword_update = true,
 };
 
+static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
+	.baseclkfreq = { .reg = 0xa0, .width = 8, .shift = 2 },
+	.clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
+	.hiword_update = false,
+};
+
 /**
  * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
  *
@@ -373,6 +379,11 @@ static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
 	.pdata = &sdhci_arasan_cqe_pdata,
 };
 
+static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
+	.soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -474,6 +485,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "rockchip,rk3399-sdhci-5.1",
 		.data = &sdhci_arasan_rk3399_data,
 	},
+	{
+		.compatible = "intel,lgm-sdhci-5.1-emmc",
+		.data = &intel_lgm_emmc_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
-- 
2.11.0

