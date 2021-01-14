Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683212F64AA
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Jan 2021 16:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbhANPby (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Jan 2021 10:31:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:7040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbhANP3y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:54 -0500
IronPort-SDR: xM73YUArT37qIhM80LIMC+3qiuQWW170TUbXUCF7LWAsIU8apgR+YbIRqFninkUCQLi0tDH0oN
 TS4KQlrqwbuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604697"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:56 -0800
IronPort-SDR: nP6C3lC+JjiBDX182Y3R3hgQLQY0sRYjpkIQeBwS+WDP3wqXHUVugQ/Vwd6izmiwdpgL6pQZ73
 0nyTX1l18bDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193663"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:53 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 9/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem Bay SOC
Date:   Thu, 14 Jan 2021 23:27:00 +0800
Message-Id: <20210114152700.21916-10-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Keem Bay SOC can support dual voltage operations for GPIO SD pins to
either 1.8V or 3.3V for bus IO line power. In order to operate the GPIOs
line for Clk, Cmd and Data on Keem Bay hardware, it is important to
configure the supplied voltage applied to their I/O Rail and the output
of the I²C expander pin. Final Voltage applied on the GPIOs line are
dependent by both supplied voltage rail and expander pin output as it is
been set after passing through the voltage sense resistor.

Keem Bay hardware is somewhat unique in the way of how IO bus line
voltage are been controlled.

Expander pin output is controlled by gpio-regulator. Voltage rail output
is controlled by Keem Bay SD regulator. Keem Bay SD regulator encapsulated
the Secure Monitor Calling Convention (SMCCC) to communicate with Trusted
Firmware during set voltage operation.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 263 +++++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 585ca32ff330..94253e3b8e52 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -22,6 +22,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/firmware/intel/keembay.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 
 #include "cqhci.h"
@@ -79,6 +80,8 @@ struct sdhci_arasan_soc_ctl_field {
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
  * @clockmultiplier:	Where to find corecfg_clockmultiplier
  * @support64b:		Where to find SUPPORT64B bit
+ * @otap_delay:		Where to find otap_delay
+ * @sel_clk_buffer:	Where to find clock buffer delay
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
  *
  * It's up to the licensee of the Arsan IP block to make these available
@@ -89,6 +92,8 @@ struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
 	struct sdhci_arasan_soc_ctl_field	clockmultiplier;
 	struct sdhci_arasan_soc_ctl_field	support64b;
+	struct sdhci_arasan_soc_ctl_field	otap_delay;
+	struct sdhci_arasan_soc_ctl_field	sel_clk_buffer;
 	bool					hiword_update;
 };
 
@@ -139,6 +144,8 @@ struct sdhci_arasan_clk_data {
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
  * @quirks:		Arasan deviations from spec.
+ * @aux_regulator:	Struct for regulator.
+ * @aux_regulator_en:	True if regulator is on; false if not.
  */
 struct sdhci_arasan_data {
 	struct sdhci_host *host;
@@ -153,6 +160,8 @@ struct sdhci_arasan_data {
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	unsigned int	quirks;
+	struct regulator *aux_regulator;
+	bool aux_regulator_en;
 
 /* Controller does not have CD wired and will not function normally without */
 #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
@@ -189,6 +198,8 @@ static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
 	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
 	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
+	.otap_delay = { .reg = 0x24, .width = 5, .shift = 23 },
+	.sel_clk_buffer = { .reg = 0x2c, .width = 3, .shift = 25 },
 	.hiword_update = false,
 };
 
@@ -364,6 +375,132 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+/**
+ * sdhci_arasan_keembay_voltage_switch - Voltage switch operation
+ * @mmc:	Pointer to mmc_host
+ * @ios:	Pointer to IO bus setting
+ *
+ * For Keem Bay hardware, in order to operate the GPIOs line for Clk, Cmd and Data,
+ * it is important to configure the supplied voltage applied to their I/O Rail
+ * and the output of the I²C expander Pin.
+ *
+ * Note that to configure the voltage rail output setting, specific bits in AON_CFG
+ * register must be set. This AON_CFG register is a secure register. Keem Bay regulator
+ * was introduced to encapsulate the Secure Monitor Call Calling Convention (SMCCC) for
+ * voltage rail output change. While to configure the I²C expander pin output,
+ * GPIO regulator modelling is been used to control the pin state.
+ *
+ * Regulator configuration:
+ * mmc->supply.vqmmc		- expander pin output voltage
+ * sdhci_arasan->aux_regulator	- voltage rail output voltage
+ *
+ * Final Voltage applied on the GPIOs Line are dependent by both supplied voltage
+ * I/O Rail and expander pin output as it is been set after passing through the
+ * voltage sense resistor.
+ *
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
+					       struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct keembay_reg_supply supplies[KEEMBAY_REG_NUM_CONSUMERS];
+	u16 ctrl_2, clk;
+	int i, ret;
+
+	/* If no vqmmc supply then we can't change the expander pin output voltage */
+	if (IS_ERR(mmc->supply.vqmmc))
+		return PTR_ERR(mmc->supply.vqmmc);
+
+	/* If no sdvrail supply then we can't change the voltage rail output voltage */
+	if (IS_ERR(sdhci_arasan->aux_regulator))
+		return PTR_ERR(sdhci_arasan->aux_regulator);
+
+	supplies[0].consumer = mmc->supply.vqmmc;
+	supplies[1].consumer = sdhci_arasan->aux_regulator;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_CARD_EN)
+			return -EAGAIN;
+
+		sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
+				   SDHCI_POWER_CONTROL);
+
+		for (i = 0; i < KEEMBAY_REG_NUM_CONSUMERS; i++) {
+			ret = regulator_set_voltage(supplies[i].consumer,
+						    KEEMBAY_IOV_1_8V_uV,
+						    KEEMBAY_IOV_1_8V_uV);
+			if (ret)
+				return ret;
+		}
+
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* Sleep for 5ms to stabilize 1.8V regulator */
+		usleep_range(5000, 5500);
+
+		/* 1.8V regulator output should be stable within 5 ms */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl_2 & SDHCI_CTRL_VDD_180))
+			return -EAGAIN;
+
+		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		return 0;
+	case MMC_SIGNAL_VOLTAGE_330:
+		for (i = 0; i < KEEMBAY_REG_NUM_CONSUMERS; i++) {
+			ret = regulator_set_voltage(supplies[i].consumer,
+						    KEEMBAY_IOV_3_3V_uV,
+						    KEEMBAY_IOV_3_3V_uV);
+			if (ret)
+				return ret;
+		}
+
+		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl_2 &= ~SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* Sleep for 5ms to stabilize 3.3V regulator */
+		usleep_range(5000, 5500);
+
+		/* 3.3V regulator output should be stable within 5 ms */
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (ctrl_2 & SDHCI_CTRL_VDD_180)
+			return -EAGAIN;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sdhci_arasan_keembay_select_drive_strength(struct mmc_card *card,
+					unsigned int max_dtr, int host_drv,
+					int card_drv, int *drv_type)
+{
+	switch (card->host->ios.signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		*drv_type = MMC_SET_DRIVER_TYPE_C;
+		return 0;
+	case MMC_SIGNAL_VOLTAGE_330:
+		*drv_type = MMC_SET_DRIVER_TYPE_B;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -968,6 +1105,72 @@ static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 	sdhci_arasan_syscon_write(host, &soc_ctl_map->baseclkfreq, mhz);
 }
 
+/**
+ * sdhci_arasan_update_otap_delay - Set otap delay
+ * @host:		The sdhci_host
+ * @value:		The value to write
+ *
+ * Otap delay can be use to control the txclk tap delay for flopping the final stage flops.
+ *
+ * NOTE:
+ * Many existing devices don't seem to do this and work fine. To keep compatibility for
+ * old hardware where the device tree doesn't provide a register map, this function is a
+ * noop if a soc_ctl_map hasn't been provided for this platform.
+ */
+static void sdhci_arasan_update_otap_delay(struct sdhci_host *host, u32 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	struct device *dev = host->mmc->parent;
+
+	/* Having a map is optional */
+	soc_ctl_map = sdhci_arasan->soc_ctl_map;
+	if (!soc_ctl_map)
+		return;
+
+	/* If we have a map, we expect to have a syscon */
+	if (!sdhci_arasan->soc_ctl_base) {
+		dev_warn(dev, "Have regmap, but no soc-ctl-syscon.\n");
+		return;
+	}
+
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->otap_delay, value);
+}
+
+/**
+ * sdhci_arasan_update_sel_clkbuf - Clock buffer select
+ * @host:		The sdhci_host
+ * @value:		The value to write
+ *
+ * Clock buffer select is use to delay the clock buffer.
+ *
+ * NOTE:
+ * Many existing devices don't seem to do this and work fine. To keep compatibility for
+ * old hardware where the device tree doesn't provide a register map, this function is a
+ * noop if a soc_ctl_map hasn't been provided for this platform.
+ */
+static void sdhci_arasan_update_sel_clkbuf(struct sdhci_host *host, u32 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	struct device *dev = host->mmc->parent;
+
+	/* Having a map is optional */
+	soc_ctl_map = sdhci_arasan->soc_ctl_map;
+	if (!soc_ctl_map)
+		return;
+
+	/* If we have a map, we expect to have a syscon */
+	if (!sdhci_arasan->soc_ctl_base) {
+		dev_warn(dev, "Have regmap, but no soc-ctl-syscon.\n");
+		return;
+	}
+
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->sel_clk_buffer, value);
+}
+
 static void sdhci_arasan_set_clk_delays(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1256,6 +1459,42 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
 
+static int sdhci_arasan_keembay_regulator_setup(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = host->mmc->parent;
+
+	sdhci_arasan->aux_regulator = devm_regulator_get_optional(dev, "sdvrail");
+	if (IS_ERR(sdhci_arasan->aux_regulator))
+		return PTR_ERR(sdhci_arasan->aux_regulator);
+
+	return regulator_enable(sdhci_arasan->aux_regulator);
+}
+
+static int sdhci_arasan_keembay_phy_configuration(struct sdhci_host *host)
+{
+	struct device *dev = host->mmc->parent;
+	struct device_node *phys;
+	u32 otap_delay, sel_clk_buffer;
+
+	phys = of_parse_phandle(dev->of_node, "phys", 0);
+	if (!phys) {
+		dev_err(dev, "Can't get phys for sd0\n");
+		return -ENODEV;
+	}
+
+	of_property_read_u32(phys, "intel,keembay-emmc-phy-otap-dly", &otap_delay);
+	of_property_read_u32(phys, "intel,keembay-emmc-phy-sel-clkbuf", &sel_clk_buffer);
+
+	of_node_put(phys);
+
+	sdhci_arasan_update_otap_delay(host, otap_delay);
+	sdhci_arasan_update_sel_clkbuf(host, sel_clk_buffer);
+
+	return 0;
+}
+
 /**
  * sdhci_arasan_register_sdcardclk - Register the sdcardclk for a PHY to use
  *
@@ -1590,6 +1829,24 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	}
 
+	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
+		ret = sdhci_arasan_keembay_regulator_setup(host);
+		if (ret)
+			goto clk_disable_all;
+
+		sdhci_arasan->aux_regulator_en = true;
+
+		ret = sdhci_arasan_keembay_phy_configuration(host);
+		if (ret)
+			goto clk_disable_all;
+
+		host->mmc_host_ops.start_signal_voltage_switch =
+			sdhci_arasan_keembay_voltage_switch;
+
+		host->mmc_host_ops.select_drive_strength =
+			sdhci_arasan_keembay_select_drive_strength;
+	}
+
 	sdhci_arasan_update_baseclkfreq(host);
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
@@ -1651,6 +1908,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 err_pltfm_free:
+	if (sdhci_arasan->aux_regulator_en)
+		regulator_disable(sdhci_arasan->aux_regulator);
+
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
@@ -1669,6 +1929,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 		phy_exit(sdhci_arasan->phy);
 	}
 
+	if (sdhci_arasan->aux_regulator_en)
+		regulator_disable(sdhci_arasan->aux_regulator);
+
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 
 	ret = sdhci_pltfm_unregister(pdev);
-- 
2.17.1

