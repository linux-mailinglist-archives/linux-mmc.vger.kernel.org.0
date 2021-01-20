Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2032FD30F
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Jan 2021 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbhATOaS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Jan 2021 09:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389112AbhATO3H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 09:29:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ABBD23384;
        Wed, 20 Jan 2021 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152889;
        bh=srvIxMd3/CJ+0aeMyWaVLG54T56qZNEfkg2XSq/7Md4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1RmJwHNuffsarP9vtdXBSI+h7VyvBQt5GI2K9ZiPZs3lqqqwcrc7fbEPO/eF5RB7
         5c9D5AX+d0MS5gyJDAmJoaUCsRWjsCuKFM6Fpcb6wm/NMqn49QaUzoI0n8n57Kt4W3
         0vythuSdruIMIbR68nhKzo+3dAKjOk/g5hJfPBswlCcHh8sG5rnq/5vsmRSb3g7WNe
         mBf79EGB8r2nQqYYkmvLp9rQv5uQ16makPdeZ1kEcSGfIuqN9Hozd/O1cfdyeEvo0M
         kba8dkFAWxU4qRb4COpE+MVZ9q4iXgRGnjm605YdEDHYG819pPjJtLeabPOE6Ntp3z
         vJBp9tZJ13c+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>
Subject: [PATCH 2/2] mmc: remove sirf prima/atlas driver
Date:   Wed, 20 Jan 2021 15:28:01 +0100
Message-Id: <20210120142801.334550-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120142801.334550-1-arnd@kernel.org>
References: <20210120142801.334550-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CSR SiRF prima2/atlas platforms are getting removed, so this driver
is no longer needed.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/mmc/sdhci-sirf.txt    |  18 --
 drivers/mmc/host/Kconfig                      |  12 -
 drivers/mmc/host/Makefile                     |   1 -
 drivers/mmc/host/sdhci-sirf.c                 | 235 ------------------
 4 files changed, 266 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
 delete mode 100644 drivers/mmc/host/sdhci-sirf.c

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
deleted file mode 100644
index dd6ed464bcb8..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* SiRFprimII/marco/atlas6 SDHCI Controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-sirf driver.
-
-Required properties:
-- compatible: sirf,prima2-sdhc
-
-Optional properties:
-- cd-gpios: card detect gpio, with zero flags.
-
-Example:
-
-	sd0: sdhci@56000000 {
-		compatible = "sirf,prima2-sdhc";
-		reg = <0xcd000000 0x100000>;
-		cd-gpios = <&gpio 6 0>;
-	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 255d37e8bd3a..b67f6028b6f3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -312,18 +312,6 @@ config MMC_SDHCI_S3C
 
 	  If unsure, say N.
 
-config MMC_SDHCI_SIRF
-	tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
-	depends on ARCH_SIRF || COMPILE_TEST
-	depends on MMC_SDHCI_PLTFM
-	select MMC_SDHCI_IO_ACCESSORS
-	help
-	  This selects the SDHCI support for SiRF System-on-Chip devices.
-
-	  If you have a controller with this interface, say Y or M here.
-
-	  If unsure, say N.
-
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
 	depends on CLKDEV_LOOKUP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 43136d382d5f..d2ec428cc808 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
-obj-$(CONFIG_MMC_SDHCI_SIRF)   	+= sdhci-sirf.o
 obj-$(CONFIG_MMC_SDHCI_F_SDH30)	+= sdhci_f_sdh30.o
 obj-$(CONFIG_MMC_SDHCI_MILBEAUT)	+= sdhci-milbeaut.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
deleted file mode 100644
index e9b347b3af7e..000000000000
--- a/drivers/mmc/host/sdhci-sirf.c
+++ /dev/null
@@ -1,235 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * SDHCI support for SiRF primaII and marco SoCs
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/mmc/host.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/mmc/slot-gpio.h>
-#include "sdhci-pltfm.h"
-
-#define SDHCI_CLK_DELAY_SETTING 0x4C
-#define SDHCI_SIRF_8BITBUS BIT(3)
-#define SIRF_TUNING_COUNT 16384
-
-static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
-{
-	u8 ctrl;
-
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	ctrl &= ~(SDHCI_CTRL_4BITBUS | SDHCI_SIRF_8BITBUS);
-
-	/*
-	 * CSR atlas7 and prima2 SD host version is not 3.0
-	 * 8bit-width enable bit of CSR SD hosts is 3,
-	 * while stardard hosts use bit 5
-	 */
-	if (width == MMC_BUS_WIDTH_8)
-		ctrl |= SDHCI_SIRF_8BITBUS;
-	else if (width == MMC_BUS_WIDTH_4)
-		ctrl |= SDHCI_CTRL_4BITBUS;
-
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-}
-
-static u32 sdhci_sirf_readl_le(struct sdhci_host *host, int reg)
-{
-	u32 val = readl(host->ioaddr + reg);
-
-	if (unlikely((reg == SDHCI_CAPABILITIES_1) &&
-			(host->mmc->caps & MMC_CAP_UHS_SDR50))) {
-		/* fake CAP_1 register */
-		val = SDHCI_SUPPORT_DDR50 |
-			SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
-	}
-
-	if (unlikely(reg == SDHCI_SLOT_INT_STATUS)) {
-		u32 prss = val;
-		/* fake chips as V3.0 host conreoller */
-		prss &= ~(0xFF << 16);
-		val = prss | (SDHCI_SPEC_300 << 16);
-	}
-	return val;
-}
-
-static u16 sdhci_sirf_readw_le(struct sdhci_host *host, int reg)
-{
-	u16 ret = 0;
-
-	ret = readw(host->ioaddr + reg);
-
-	if (unlikely(reg == SDHCI_HOST_VERSION)) {
-		ret = readw(host->ioaddr + SDHCI_HOST_VERSION);
-		ret |= SDHCI_SPEC_300;
-	}
-
-	return ret;
-}
-
-static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
-{
-	int tuning_seq_cnt = 3;
-	int phase;
-	u8 tuned_phase_cnt = 0;
-	int rc = 0, longest_range = 0;
-	int start = -1, end = 0, tuning_value = -1, range = 0;
-	u16 clock_setting;
-	struct mmc_host *mmc = host->mmc;
-
-	clock_setting = sdhci_readw(host, SDHCI_CLK_DELAY_SETTING);
-	clock_setting &= ~0x3fff;
-
-retry:
-	phase = 0;
-	tuned_phase_cnt = 0;
-	do {
-		sdhci_writel(host,
-			clock_setting | phase,
-			SDHCI_CLK_DELAY_SETTING);
-
-		if (!mmc_send_tuning(mmc, opcode, NULL)) {
-			/* Tuning is successful at this tuning point */
-			tuned_phase_cnt++;
-			dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
-				 mmc_hostname(mmc), phase);
-			if (start == -1)
-				start = phase;
-			end = phase;
-			range++;
-			if (phase == (SIRF_TUNING_COUNT - 1)
-				&& range > longest_range)
-				tuning_value = (start + end) / 2;
-		} else {
-			dev_dbg(mmc_dev(mmc), "%s: Found bad phase = %d\n",
-				 mmc_hostname(mmc), phase);
-			if (range > longest_range) {
-				tuning_value = (start + end) / 2;
-				longest_range = range;
-			}
-			start = -1;
-			end = range = 0;
-		}
-	} while (++phase < SIRF_TUNING_COUNT);
-
-	if (tuned_phase_cnt && tuning_value > 0) {
-		/*
-		 * Finally set the selected phase in delay
-		 * line hw block.
-		 */
-		phase = tuning_value;
-		sdhci_writel(host,
-			clock_setting | phase,
-			SDHCI_CLK_DELAY_SETTING);
-
-		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
-			 mmc_hostname(mmc), phase);
-	} else {
-		if (--tuning_seq_cnt)
-			goto retry;
-		/* Tuning failed */
-		dev_dbg(mmc_dev(mmc), "%s: No tuning point found\n",
-		       mmc_hostname(mmc));
-		rc = -EIO;
-	}
-
-	return rc;
-}
-
-static const struct sdhci_ops sdhci_sirf_ops = {
-	.read_l = sdhci_sirf_readl_le,
-	.read_w = sdhci_sirf_readw_le,
-	.platform_execute_tuning = sdhci_sirf_execute_tuning,
-	.set_clock = sdhci_set_clock,
-	.get_max_clock	= sdhci_pltfm_clk_get_max_clock,
-	.set_bus_width = sdhci_sirf_set_bus_width,
-	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
-};
-
-static const struct sdhci_pltfm_data sdhci_sirf_pdata = {
-	.ops = &sdhci_sirf_ops,
-	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-};
-
-static int sdhci_sirf_probe(struct platform_device *pdev)
-{
-	struct sdhci_host *host;
-	struct sdhci_pltfm_host *pltfm_host;
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get clock");
-		return PTR_ERR(clk);
-	}
-
-	host = sdhci_pltfm_init(pdev, &sdhci_sirf_pdata, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
-
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->clk = clk;
-
-	sdhci_get_of_property(pdev);
-
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret)
-		goto err_clk_prepare;
-
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto err_sdhci_add;
-
-	/*
-	 * We must request the IRQ after sdhci_add_host(), as the tasklet only
-	 * gets setup in sdhci_add_host() and we oops.
-	 */
-	ret = mmc_gpiod_request_cd(host->mmc, "cd", 0, false, 0);
-	if (ret == -EPROBE_DEFER)
-		goto err_request_cd;
-	if (!ret)
-		mmc_gpiod_request_cd_irq(host->mmc);
-
-	return 0;
-
-err_request_cd:
-	sdhci_remove_host(host, 0);
-err_sdhci_add:
-	clk_disable_unprepare(pltfm_host->clk);
-err_clk_prepare:
-	sdhci_pltfm_free(pdev);
-	return ret;
-}
-
-static const struct of_device_id sdhci_sirf_of_match[] = {
-	{ .compatible = "sirf,prima2-sdhc" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sdhci_sirf_of_match);
-
-static struct platform_driver sdhci_sirf_driver = {
-	.driver		= {
-		.name	= "sdhci-sirf",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = sdhci_sirf_of_match,
-		.pm	= &sdhci_pltfm_pmops,
-	},
-	.probe		= sdhci_sirf_probe,
-	.remove		= sdhci_pltfm_unregister,
-};
-
-module_platform_driver(sdhci_sirf_driver);
-
-MODULE_DESCRIPTION("SDHCI driver for SiRFprimaII/SiRFmarco");
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.29.2

