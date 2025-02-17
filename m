Return-Path: <linux-mmc+bounces-5545-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF00A33D24
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Feb 2025 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595A218898FD
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Feb 2025 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6902139AF;
	Thu, 13 Feb 2025 10:59:26 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36A2135D7;
	Thu, 13 Feb 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444366; cv=none; b=hTKl2PpF/vj79ZgKelnHH+Sm5lnUqF6ScLrw8XOhVecWonSxUxr2Tk57+N5pQIMlPjtHfSce7RmF2773uv77Dm9ctgK9c1cVNG46m6GA4vket+r0mH/3MWRG1PXlLIz7iaPTYyGGN2iBAZh9n9IUcPGH7wgsnwBvi9HVXMdlbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444366; c=relaxed/simple;
	bh=8j6cqSa5QFnHdqAJ15ix52ipBFPvdYNxl3XJo1WBswA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udC+8TljT5kRxyRCZcMRc4fjuP9mntPmW1hWk1rYpCEwE2bs7oZDXfnBaG+yAw3VHEiSRJJ463Mw0/782XTYkbxMt5aAEAalOM6hnCXb/Pre85xUbGNu8UeZcqr6SZ2M3LbXjlaBOI0mez1COjIJSc7jGBHPlvilK3xz554VsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [180.172.76.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7CA64343175;
	Thu, 13 Feb 2025 10:59:19 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 13 Feb 2025 18:58:25 +0800
Subject: [PATCH RFC 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-20-k1-sdhci-v1-2-1f4362a980cd@gentoo.org>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
In-Reply-To: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11663; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=8j6cqSa5QFnHdqAJ15ix52ipBFPvdYNxl3XJo1WBswA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBnrdB7l4cX7d2507Bb/aK3WMGZrqwxOT/ica9Cz
 AioKl3EKL+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZ63Qe18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277a1JEACJSJD3XQexzEebm2
 HbiP760I6ZqJjH6fivRq6crNLlDmTeMgTlZrOpa1j88u51GlbqAY6tj297/OtuDn+QYhB3udmja
 kvkp3iCOjvkWBKZDD6mMDuMw3gxRfGYg7tg+1nrm0mj5dQdec/v7ajgllIheivatZgsyoJgFIkP
 uwRizAk94nWAnXtYZ+GAigwI/T7w4dp+ypleiyddIsmPn6lhOsFX6ce1jKtHAVCwvlkD1ilERi2
 NFOxta677d+Vb4yc90ccL40kk9NSlYq5oMMyF8qXX3GSCq9ryt+OMznpSMO/JbKvtb8c4KWqXeO
 zZxFeaRGWLwEA3ItwElCDDxrmJHM+2nyXAukqNhKGO3T0yKaLc4Ps4XProoOp//OOjNcORVmZWi
 6XJGfaLX/dQzhBU8cTNaRiPijbt11ppENgkUZPGsIXixBnU8u9mxL75vtQ1O2hEUYitxDWD3Pp0
 XE5GPGKYgJvw41TG4B4bhpQvIxXkkJMJWvIM3pn0T621dpdwkSEOJy2R8jvvumUNlp5acICMQjq
 ijuvAX0CigG/ns5wZrYr49O5uM0hLN3GPn3cWcMoFtQMumhX7Tc+eIXmd4iGXIeFwB2mkldXK7A
 4N/IaZWC97LpE7Nj4cnSkD5ZKL124ip1W6isFpnElFC4QK9+HtHtfiqjqkrh4HQgysfw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SDHCI controller found in SpacemiT K1 SoC features SD,
SDIO, eMMC support, such as:

- Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
- Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
- Compatible for 8bit eMMC5.1, up to HS400

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/host/Kconfig       |  14 ++
 drivers/mmc/host/Makefile      |   1 +
 drivers/mmc/host/sdhci-of-k1.c | 320 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
 	  If you have a controller with this interface, say Y or M here.
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_K1
+	tristate "SDHCI OF support for the SpacemiT K1 SoC"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  found in the SpacemiT K1 SoC.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_OF_SPARX5
 	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
+obj-$(CONFIG_MMC_SDHCI_OF_K1)		+= sdhci-of-k1.o
 obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
 obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
new file mode 100644
index 0000000000000000000000000000000000000000..8202a893a46ef9f10675b031b31b72e81eaacd14
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/init.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SDHC_MMC_CTRL_REG		0x114
+#define  MISC_INT_EN			BIT(1)
+#define  MISC_INT			BIT(2)
+#define  ENHANCE_STROBE_EN		BIT(8)
+#define  MMC_HS400			BIT(9)
+#define  MMC_HS200			BIT(10)
+#define  MMC_CARD_MODE			BIT(12)
+
+#define SDHC_TX_CFG_REG			0x11C
+#define  TX_INT_CLK_SEL			BIT(30)
+#define  TX_MUX_SEL			BIT(31)
+
+#define SDHC_PHY_CTRL_REG		0x160
+#define  PHY_FUNC_EN			BIT(0)
+#define  PHY_PLL_LOCK			BIT(1)
+#define  HOST_LEGACY_MODE		BIT(31)
+
+#define SDHC_PHY_FUNC_REG		0x164
+#define  PHY_TEST_EN			BIT(7)
+#define  HS200_USE_RFIFO		BIT(15)
+
+#define SDHC_PHY_DLLCFG			0x168
+#define  DLL_PREDLY_NUM			0x04
+#define  DLL_FULLDLY_RANGE		0x10
+#define  DLL_VREG_CTRL			0x40
+#define  DLL_ENABLE			0x80000000
+#define  DLL_REFRESH_SWEN_SHIFT		0x1C
+#define  DLL_REFRESH_SW_SHIFT		0x1D
+
+#define SDHC_PHY_DLLCFG1		0x16C
+#define  DLL_REG2_CTRL			0x0C
+#define  DLL_REG3_CTRL_MASK		0xFF
+#define  DLL_REG3_CTRL_SHIFT		0x10
+#define  DLL_REG2_CTRL_MASK		0xFF
+#define  DLL_REG2_CTRL_SHIFT		0x08
+#define  DLL_REG1_CTRL			0x92
+#define  DLL_REG1_CTRL_MASK		0xFF
+#define  DLL_REG1_CTRL_SHIFT		0x00
+
+#define SDHC_PHY_DLLSTS			0x170
+#define  DLL_LOCK_STATE			0x01
+
+#define SDHC_PHY_DLLSTS1		0x174
+#define  DLL_MASTER_DELAY_MASK		0xFF
+#define  DLL_MASTER_DELAY_SHIFT		0x10
+
+#define SDHC_PHY_PADCFG_REG		0x178
+#define  RX_BIAS_CTRL			BIT(5)
+#define  PHY_DRIVE_SEL_MASK		0x7
+#define  PHY_DRIVE_SEL_DEFAULT		0x4
+
+struct spacemit_sdhci_host {
+	struct clk *clk_core;
+	struct clk *clk_io;
+};
+
+static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
+}
+
+static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val, int reg)
+{
+	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
+}
+
+static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u32 set, int reg)
+{
+	u32 val = sdhci_readl(host, reg);
+
+	val = (val & ~clr) | set;
+	sdhci_writel(host, val, reg);
+}
+
+static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct platform_device *pdev;
+
+	pdev = to_platform_device(mmc_dev(host->mmc));
+	sdhci_reset(host, mask);
+
+	if (mask != SDHCI_RESET_ALL)
+		return;
+
+	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
+
+	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL_MASK,
+				  RX_BIAS_CTRL | PHY_DRIVE_SEL_DEFAULT,
+				  SDHC_PHY_PADCFG_REG);
+
+	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
+		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	if (timing == MMC_TIMING_MMC_HS200)
+		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
+
+	if (timing == MMC_TIMING_MMC_HS400)
+		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
+
+	sdhci_set_uhs_signaling(host, timing);
+
+	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
+		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
+}
+
+static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
+		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
+	else
+		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
+
+	sdhci_set_clock(host, clock);
+};
+
+static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
+{
+	u32 state;
+	int ret;
+
+	spacemit_sdhci_setbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
+			       SDHC_PHY_DLLCFG);
+	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL_MASK, DLL_REG1_CTRL,
+				  SDHC_PHY_DLLCFG1);
+	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
+
+	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
+				 state & DLL_LOCK_STATE, 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
+}
+
+static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (!ios->enhanced_strobe) {
+		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
+		return;
+	}
+
+	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
+	spacemit_sdhci_phy_dll_init(host);
+}
+
+static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
+static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+
+	return 0;
+}
+
+static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	spacemit_sdhci_phy_dll_init(host);
+	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
+}
+
+static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK,
+			       SDHC_PHY_CTRL_REG);
+	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN,
+			       SDHC_MMC_CTRL_REG);
+	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
+
+	udelay(5);
+
+	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
+}
+
+static inline int spacemit_sdhci_get_clocks(struct device *dev,
+					    struct sdhci_pltfm_host *pltfm_host)
+{
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+
+	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
+	if (IS_ERR(sdhst->clk_core))
+		return -EINVAL;
+
+	sdhst->clk_io = devm_clk_get_enabled(dev, "io");
+	if (IS_ERR(sdhst->clk_io))
+		return -EINVAL;
+
+	pltfm_host->clk = sdhst->clk_io;
+
+	return 0;
+}
+
+static const struct sdhci_ops spacemit_sdhci_ops = {
+	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
+	.reset			= spacemit_sdhci_reset,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_clock		= spacemit_sdhci_set_clock,
+	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
+	.ops = &spacemit_sdhci_ops,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		  SDHCI_QUIRK_32BIT_ADMA_SIZE |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+	.quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct of_device_id spacemit_sdhci_of_match[] = {
+	{ .compatible = "spacemit,k1-sdhci" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spacemit_sdhci_of_match);
+
+static int spacemit_sdhci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spacemit_sdhci_host *sdhst;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct mmc_host_ops *mops;
+	int ret;
+
+	host = sdhci_pltfm_init(pdev, &spacemit_sdhci_k1_pdata, sizeof(*sdhst));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_pltfm;
+
+	sdhci_get_of_property(pdev);
+
+	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
+		mops = &host->mmc_host_ops;
+		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
+		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
+		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;
+		mops->hs400_enhanced_strobe = spacemit_sdhci_hs400_enhanced_strobe;
+	}
+
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
+	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
+		goto err_pltfm;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_pltfm;
+
+	return 0;
+
+err_pltfm:
+	sdhci_pltfm_free(pdev);
+	return ret;
+}
+
+static void spacemit_sdhci_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	sdhci_remove_host(host, 1);
+	sdhci_pltfm_free(pdev);
+}
+
+static struct platform_driver spacemit_sdhci_driver = {
+	.driver		= {
+		.name	= "sdhci-spacemit",
+		.of_match_table = of_match_ptr(spacemit_sdhci_of_match),
+	},
+	.probe		= spacemit_sdhci_probe,
+	.remove		= spacemit_sdhci_remove,
+};
+module_platform_driver(spacemit_sdhci_driver);
+
+MODULE_DESCRIPTION("SpacemiT SDHCI platform driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1


