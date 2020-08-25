Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E362513F1
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Aug 2020 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHYIO0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 25 Aug 2020 04:14:26 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54046 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYIOU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 04:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598343260; x=1629879260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkvsjFjop1+FJ6vnrQVQRzwFGDsPAxJYj9IAhFfXR2M=;
  b=EcUxzVUwCGO2e60hJYC0ITd1X6apakyH1vInFDZLMQlbVJ7lcSrvlvpw
   ykWSxuDbbKcfm4lW5vV9AM+8a6a7LIw5wuPHz02Etl7uP7GT0BmHQn+3S
   EnDZfiniZIAICMXIB5mJ5y3f4KW5Xryu6u2OZJv0IKgyna+90rs40n+C1
   MJvAPuqtr6Sk+D0GXpf+d1Ftlli0bHj6bKLDKUIBVoUplM7VCxhp/pk9l
   mW+8ttJ1k2gV9jv0fAR7PXoatRK9ol0YBur7zbE+nhAZ7nckzVo5pVdEv
   xzNPfpkumyMO7Btf1GepPYpWcDa+pIgbUKfGW5sDz+hyuRtPq19Lmvo2/
   A==;
IronPort-SDR: Y+Kbh6CEKldjYV0VyLuu8vitrX3zSXQGEoHH/6gpEJDjTqW0gBDazZdIDsys4ZvHkjv/zZ6MT3
 W6J62Bzk/cuobabQKYkQixvs8bkznB6mASmoYr0pG/K6L5HTHUsGmKscszRMH55hAE43bLBUH/
 Uxe3+w8NajBzWnSxA3RMJUnMUkrOySFSTfHwm5z5CBMAPT/cN/CrHEKQukc5Utc2w9GSRDv3bY
 5IIGu/o63FJikOsDchEy1GoWPddL5ItM0Mtso0rJhsOYNVclHDBjHqYmxDplqvUeJWrSPWiFM6
 jsA=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="24141077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2020 01:14:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 01:13:38 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 25 Aug 2020 01:13:36 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
Date:   Tue, 25 Aug 2020 10:13:56 +0200
Message-ID: <20200825081357.32354-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825081357.32354-1-lars.povlsen@microchip.com>
References: <20200825081357.32354-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds the eMMC driver for the Sparx5 SoC. It is based upon the
designware IP, but requires some extra initialization and quirks.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/Kconfig           |  12 ++
 drivers/mmc/host/Makefile          |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c | 269 +++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9c89a5b780e8..14ab8c03e4b8 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -213,6 +213,18 @@ config MMC_SDHCI_OF_DWCMSHC
 	  If you have a controller with this interface, say Y or M here.
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_SPARX5
+	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
+	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_SPARX5
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  found in the MCHP Sparx5 SoC.
+
+	  If you have a Sparx5 SoC with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4d5bcb0144a0..451c25fc2c69 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
+obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
new file mode 100644
index 000000000000..14b5dad6575a
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * drivers/mmc/host/sdhci-of-sparx5.c
+ *
+ * MCHP Sparx5 SoC Secure Digital Host Controller Interface.
+ *
+ * Copyright (c) 2019 Microchip Inc.
+ *
+ * Author: Lars Povlsen <lars.povlsen@microchip.com>
+ */
+
+#include <linux/sizes.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/dma-mapping.h>
+
+#include "sdhci-pltfm.h"
+
+#define CPU_REGS_GENERAL_CTRL	(0x22 * 4)
+#define  MSHC_DLY_CC_MASK	GENMASK(16, 13)
+#define  MSHC_DLY_CC_SHIFT	13
+#define  MSHC_DLY_CC_MAX	15
+
+#define CPU_REGS_PROC_CTRL	(0x2C * 4)
+#define  ACP_CACHE_FORCE_ENA	BIT(4)
+#define  ACP_AWCACHE		BIT(3)
+#define  ACP_ARCACHE		BIT(2)
+#define  ACP_CACHE_MASK		(ACP_CACHE_FORCE_ENA|ACP_AWCACHE|ACP_ARCACHE)
+
+#define MSHC2_VERSION			0x500	/* Off 0x140, reg 0x0 */
+#define MSHC2_TYPE			0x504	/* Off 0x140, reg 0x1 */
+#define MSHC2_EMMC_CTRL			0x52c	/* Off 0x140, reg 0xB */
+#define  MSHC2_EMMC_CTRL_EMMC_RST_N	BIT(2)
+#define  MSHC2_EMMC_CTRL_IS_EMMC	BIT(0)
+
+struct sdhci_sparx5_data {
+	struct sdhci_host *host;
+	struct regmap *cpu_ctrl;
+	int delay_clock;
+};
+
+#define BOUNDARY_OK(addr, len) \
+	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
+
+/*
+ * If DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that each DMA transfer doesn't exceed the boundary.
+ */
+static void sdhci_sparx5_adma_write_desc(struct sdhci_host *host, void **desc,
+					  dma_addr_t addr, int len,
+					  unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len))) {
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
+		return;
+	}
+
+	pr_debug("%s: write_desc: splitting dma len %d, offset 0x%0llx\n",
+		 mmc_hostname(host->mmc), len, addr);
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
+}
+
+static void sparx5_set_cacheable(struct sdhci_host *host, u32 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
+
+	pr_debug("%s: Set Cacheable = 0x%x\n", mmc_hostname(host->mmc), value);
+
+	/* Update ACP caching attributes in HW */
+	regmap_update_bits(sdhci_sparx5->cpu_ctrl,
+			   CPU_REGS_PROC_CTRL, ACP_CACHE_MASK, value);
+}
+
+static void sparx5_set_delay(struct sdhci_host *host, u8 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sparx5_data *sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
+
+	pr_debug("%s: Set DLY_CC = %u\n", mmc_hostname(host->mmc), value);
+
+	/* Update DLY_CC in HW */
+	regmap_update_bits(sdhci_sparx5->cpu_ctrl,
+			   CPU_REGS_GENERAL_CTRL,
+			   MSHC_DLY_CC_MASK,
+			   (value << MSHC_DLY_CC_SHIFT));
+}
+
+static void sdhci_sparx5_set_emmc(struct sdhci_host *host)
+{
+	if (!mmc_card_is_removable(host->mmc)) {
+		u8 value;
+
+		value = sdhci_readb(host, MSHC2_EMMC_CTRL);
+		if (!(value & MSHC2_EMMC_CTRL_IS_EMMC)) {
+			value |= MSHC2_EMMC_CTRL_IS_EMMC;
+			pr_debug("%s: Set EMMC_CTRL: 0x%08x\n",
+				 mmc_hostname(host->mmc), value);
+			sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
+		}
+	}
+}
+
+static void sdhci_sparx5_reset_emmc(struct sdhci_host *host)
+{
+	u8 value;
+
+	pr_debug("%s: Toggle EMMC_CTRL.EMMC_RST_N\n", mmc_hostname(host->mmc));
+	value = sdhci_readb(host, MSHC2_EMMC_CTRL) &
+		~MSHC2_EMMC_CTRL_EMMC_RST_N;
+	sdhci_writeb(host, value, MSHC2_EMMC_CTRL);
+	/* For eMMC, minimum is 1us but give it 10us for good measure */
+	usleep_range(10, 20);
+	sdhci_writeb(host, value | MSHC2_EMMC_CTRL_EMMC_RST_N,
+		     MSHC2_EMMC_CTRL);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 400);
+}
+
+static void sdhci_sparx5_reset(struct sdhci_host *host, u8 mask)
+{
+	pr_debug("%s: *** RESET: mask %d\n", mmc_hostname(host->mmc), mask);
+
+	sdhci_reset(host, mask);
+
+	/* Be sure CARD_IS_EMMC stays set */
+	sdhci_sparx5_set_emmc(host);
+}
+
+static const struct sdhci_ops sdhci_sparx5_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_sparx5_reset,
+	.adma_write_desc	= sdhci_sparx5_adma_write_desc,
+};
+
+static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
+	.quirks  = 0,
+	.quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Controller issue */
+		   SDHCI_QUIRK2_NO_1_8_V, /* No sdr104, ddr50, etc */
+	.ops = &sdhci_sparx5_ops,
+};
+
+static int sdhci_sparx5_probe(struct platform_device *pdev)
+{
+	int ret;
+	const char *syscon = "microchip,sparx5-cpu-syscon";
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_sparx5_data *sdhci_sparx5;
+	struct device_node *np = pdev->dev.of_node;
+	u32 value;
+	u32 extra;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_sparx5_pdata,
+				sizeof(*sdhci_sparx5));
+
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	/*
+	 * extra adma table cnt for cross 128M boundary handling.
+	 */
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
+	if (extra > SDHCI_MAX_SEGS)
+		extra = SDHCI_MAX_SEGS;
+	host->adma_table_cnt += extra;
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
+	sdhci_sparx5->host = host;
+
+	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pltfm_host->clk)) {
+		ret = PTR_ERR(pltfm_host->clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
+		goto free_pltfm;
+	}
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		goto free_pltfm;
+
+	if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
+	    (value > 0 && value <= MSHC_DLY_CC_MAX))
+		sdhci_sparx5->delay_clock = value;
+
+	sdhci_get_of_property(pdev);
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_clk;
+
+	sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
+	if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
+		dev_err(&pdev->dev, "No CPU syscon regmap !\n");
+		ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
+		goto err_clk;
+	}
+
+	if (sdhci_sparx5->delay_clock >= 0)
+		sparx5_set_delay(host, sdhci_sparx5->delay_clock);
+
+	if (!mmc_card_is_removable(host->mmc)) {
+		/* Do a HW reset of eMMC card */
+		sdhci_sparx5_reset_emmc(host);
+		/* Update EMMC_CTRL */
+		sdhci_sparx5_set_emmc(host);
+		/* If eMMC, disable SD and SDIO */
+		host->mmc->caps2 |= (MMC_CAP2_NO_SDIO|MMC_CAP2_NO_SD);
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_clk;
+
+	/* Set AXI bus master to use un-cached access (for DMA) */
+	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
+	    IS_ENABLED(CONFIG_DMA_DECLARE_COHERENT))
+		sparx5_set_cacheable(host, ACP_CACHE_FORCE_ENA);
+
+	pr_debug("%s: SDHC version: 0x%08x\n",
+		 mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_VERSION));
+	pr_debug("%s: SDHC type:    0x%08x\n",
+		 mmc_hostname(host->mmc), sdhci_readl(host, MSHC2_TYPE));
+
+	return ret;
+
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return ret;
+}
+
+static const struct of_device_id sdhci_sparx5_of_match[] = {
+	{ .compatible = "microchip,dw-sparx5-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
+
+static struct platform_driver sdhci_sparx5_driver = {
+	.driver = {
+		.name = "sdhci-sparx5",
+		.of_match_table = sdhci_sparx5_of_match,
+		.pm = &sdhci_pltfm_pmops,
+	},
+	.probe = sdhci_sparx5_probe,
+	.remove = sdhci_pltfm_unregister,
+};
+
+module_platform_driver(sdhci_sparx5_driver);
+
+MODULE_DESCRIPTION("Sparx5 SDHCI OF driver");
+MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

