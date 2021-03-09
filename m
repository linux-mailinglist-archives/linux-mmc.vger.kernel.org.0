Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6F331CA8
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Mar 2021 02:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCIB5V (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Mar 2021 20:57:21 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:47104 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCIB4x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 20:56:53 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 95FC9B94DA;
        Tue,  9 Mar 2021 09:56:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23505T140626794366720S1615254997318814_;
        Tue, 09 Mar 2021 09:56:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a09f1e6671dee1dbf1ca1fcac0a15b7c>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform support
Date:   Tue,  9 Mar 2021 09:56:30 +0800
Message-Id: <1615254990-192784-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci based synopsys MMC IP is also used on some rockchip platforms,
so add a basic support here.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None

 drivers/mmc/host/sdhci-of-dwcmshc.c | 220 ++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 59d8d96..959084c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -9,9 +9,11 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/sizes.h>
 
 #include "sdhci-pltfm.h"
@@ -21,11 +23,43 @@
 /* DWCMSHC specific Mode Select value */
 #define DWCMSHC_CTRL_HS400		0x7
 
+/* Rockchip specific Registers */
+#define DWCMSHC_HOST_CTRL3		0x508
+#define DWCMSHC_EMMC_CONTROL		0x52c
+#define DWCMSHC_EMMC_ATCTRL		0x540
+#define DWCMSHC_EMMC_DLL_CTRL		0x800
+#define DWCMSHC_EMMC_DLL_RXCLK		0x804
+#define DWCMSHC_EMMC_DLL_TXCLK		0x808
+#define DWCMSHC_EMMC_DLL_STRBIN		0x80c
+#define DWCMSHC_EMMC_DLL_STATUS0	0x840
+#define DWCMSHC_EMMC_DLL_START		BIT(0)
+#define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL	29
+#define DWCMSHC_EMMC_DLL_START_POINT	16
+#define DWCMSHC_EMMC_DLL_INC		8
+#define DWCMSHC_EMMC_DLL_DLYENA		BIT(27)
+#define DLL_TXCLK_TAPNUM_DEFAULT	0x8
+#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
+#define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
+#define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
+#define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
+#define DWCMSHC_EMMC_DLL_TIMEOUT	BIT(9)
+#define DLL_RXCLK_NO_INVERTER		1
+#define DLL_RXCLK_INVERTER		0
+#define DWCMSHC_ENHANCED_STROBE		BIT(8)
+#define DLL_LOCK_WO_TMOUT(x) \
+	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
+	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
+#define ROCKCHIP_MAX_CLKS		3
+
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
+
+	/* Rockchip specified optional clocks */
+	struct clk_bulk_data rockchip_clks[ROCKCHIP_MAX_CLKS];
+	int txclk_tapnum;
 };
 
 /*
@@ -100,6 +134,97 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void dwcmshc_rk_hs400_enhanced_strobe(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	u32 vendor;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	vendor = sdhci_readl(host, DWCMSHC_EMMC_CONTROL);
+	if (ios->enhanced_strobe)
+		vendor |= DWCMSHC_ENHANCED_STROBE;
+	else
+		vendor &= ~DWCMSHC_ENHANCED_STROBE;
+
+	sdhci_writel(host, vendor, DWCMSHC_EMMC_CONTROL);
+}
+
+static void dwcmshc_rk_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT, extra;
+	int err;
+
+	host->mmc->actual_clock = 0;
+
+	/* DO NOT TOUCH THIS SETTING */
+	extra = DWCMSHC_EMMC_DLL_DLYENA |
+		DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
+	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
+
+	if (clock == 0)
+		return;
+
+	/* Rockchip platform only support 375KHz for identify mode */
+	if (clock <= 400000)
+		clock = 375000;
+
+	err = clk_set_rate(pltfm_host->clk, clock);
+	if (err)
+		dev_err(mmc_dev(host->mmc), "fail to set clock %d", clock);
+
+	sdhci_set_clock(host, clock);
+
+	/* Disable cmd conflict check */
+	extra = sdhci_readl(host, DWCMSHC_HOST_CTRL3);
+	extra &= ~BIT(0);
+	sdhci_writel(host, extra, DWCMSHC_HOST_CTRL3);
+
+	if (clock <= 400000) {
+		/* Disable DLL to reset sample clock */
+		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
+		return;
+	}
+
+	/* Reset DLL */
+	sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
+	udelay(1);
+	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
+
+	/* Init DLL settings */
+	extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
+		0x2 << DWCMSHC_EMMC_DLL_INC |
+		DWCMSHC_EMMC_DLL_START;
+	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CTRL);
+	err = readl_poll_timeout(host->ioaddr + DWCMSHC_EMMC_DLL_STATUS0,
+				 extra, DLL_LOCK_WO_TMOUT(extra), 1,
+				 500 * USEC_PER_MSEC);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
+		return;
+	}
+
+	extra = 0x1 << 16 | /* tune clock stop en */
+		0x2 << 17 | /* pre-change delay */
+		0x3 << 19;  /* post-change delay */
+	sdhci_writel(host, extra, DWCMSHC_EMMC_ATCTRL);
+
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
+	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
+		txclk_tapnum = priv->txclk_tapnum;
+
+	extra = DWCMSHC_EMMC_DLL_DLYENA |
+		DLL_TXCLK_TAPNUM_FROM_SW |
+		txclk_tapnum;
+	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
+
+	extra = DWCMSHC_EMMC_DLL_DLYENA |
+		DLL_STRBIN_TAPNUM_DEFAULT |
+		DLL_STRBIN_TAPNUM_FROM_SW;
+	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -109,21 +234,91 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_rk_ops = {
+	.set_clock		= dwcmshc_rk_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+};
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_rk_pdata = {
+	.ops = &sdhci_dwcmshc_rk_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+};
+
+static int rockchip_pltf_init(struct sdhci_host *host, struct dwcmshc_priv *priv)
+{
+	int err;
+
+	priv->rockchip_clks[0].id = "axi";
+	priv->rockchip_clks[1].id = "block";
+	priv->rockchip_clks[2].id = "timer";
+	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), ROCKCHIP_MAX_CLKS,
+					 priv->rockchip_clks);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
+		return err;
+	}
+
+	err = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
+		return err;
+	}
+
+	if (of_property_read_u32(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
+				 &priv->txclk_tapnum))
+		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
+
+	/* Disable cmd conflict check */
+	sdhci_writel(host, 0x0, DWCMSHC_HOST_CTRL3);
+	/* Reset previous settings */
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{
+		.compatible = "snps,dwcmshc-sdhci",
+		.data = &sdhci_dwcmshc_pdata,
+	},
+	{
+		.compatible = "rockchip,dwcmshc-sdhci",
+		.data = &sdhci_dwcmshc_rk_pdata,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
+
 static int dwcmshc_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
+	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
+	pltfm_data = of_device_get_match_data(&pdev->dev);
+	if (!pltfm_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+
+	host = sdhci_pltfm_init(pdev, pltfm_data,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
@@ -161,6 +356,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	host->mmc_host_ops.request = dwcmshc_request;
 
+	if (pltfm_data == &sdhci_dwcmshc_rk_pdata) {
+		host->mmc_host_ops.hs400_enhanced_strobe =
+			dwcmshc_rk_hs400_enhanced_strobe;
+
+		err = rockchip_pltf_init(host, priv);
+		if (err)
+			goto err_clk;
+	}
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto err_clk;
@@ -170,6 +374,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
+	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -185,6 +390,7 @@ static int dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
+	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
 
 	sdhci_pltfm_free(pdev);
 
@@ -207,6 +413,8 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
+	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
+
 	return ret;
 }
 
@@ -227,18 +435,16 @@ static int dwcmshc_resume(struct device *dev)
 			return ret;
 	}
 
+	ret = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
+	if (ret)
+		return ret;
+
 	return sdhci_resume_host(host);
 }
 #endif
 
 static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
 
-static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
-	{ .compatible = "snps,dwcmshc-sdhci" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
-
 static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
 		.name	= "sdhci-dwcmshc",
-- 
2.7.4



