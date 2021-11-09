Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671944A7FB
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Nov 2021 08:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhKIIBS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Nov 2021 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhKIIBS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 03:01:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177BC061764;
        Mon,  8 Nov 2021 23:58:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so14206458pfd.10;
        Mon, 08 Nov 2021 23:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGBuUZRnBPE1j8H15Pzt4P6SH29+1heBNdMmfhYcuHg=;
        b=FzOl1fAa6xR6HZv4N2aea5BzLnlb3tBS1CMul86Eb3fdRhi69vl4qDlFiRvYMJQWkN
         NSR5wEjhAML9mxuAdSPT9aEBJlG3jKkZ0X7CHaNqTKaGtf5sAwYzFlZi3pv+sIzx1sMf
         4sq1c+KbMRNedVcQjN+W6dTBBgHJXohjrFXQkaMIQIQw04hxWMjZeL9BZ8hDkITgbmNe
         DslGIv3UWBu+Evv+1eyV6KniA0KJUDaTKMYjBgdqYXQ/5Dog6dmkHo1RNlvQBtoki2Fd
         KPwhYxgEE/XCafIiaz40juOEfIpaIjgo90wocd/eywoMsQoFu45kT4ew5XJsmTmw/qHT
         RHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGBuUZRnBPE1j8H15Pzt4P6SH29+1heBNdMmfhYcuHg=;
        b=oLE1Y1e5vd/haeaAC+k0/6a5ghmw5VmTuEwKKXL7BhrVZZS0+pD0HCR0nbYIYbcdfI
         ecW5qdGI3aqb4RKPudG8u1KNeQ8l886abwccFKIuMNdRyWsgTw+Ocn5N4EESaEOl4zlD
         tCwDAMgIU707Wa3ysWpa5/naH/ZF4YaTLCSg/tzBb2t9JikyhJxZV5ie9yW8ixXAWisy
         z48xwtR2q6vSRVFMMcCSR6UzUQzRrVHwEJEwKOIQuhfqyCeP7jx2Y5jr2KZLH6Hoqdbz
         vgeYUoAJ4VDSJT0pPYl7MT+CmJDNYRYNhL8CQkkoLgf614P8igtyXh/i/8RWoWx0P6w7
         EDhg==
X-Gm-Message-State: AOAM532WJzY5L2UTiHtqjjz9Zws2h15sGEFSSiqHjak0HcFpJ5s8Lf7P
        rB91J1npU8Hrft2akyXP1qM=
X-Google-Smtp-Source: ABdhPJxhTXkRnyBkT/+1l19vdllmp/oFhSuTskFYOvBa8ZmLI7EMAK/Ozxe8gnfhFb5SlYm4JoEKNA==
X-Received: by 2002:a05:6a00:2283:b0:49f:dea0:b9ba with SMTP id f3-20020a056a00228300b0049fdea0b9bamr11988999pfe.56.1636444712090;
        Mon, 08 Nov 2021 23:58:32 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x135sm10635714pfd.78.2021.11.08.23.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 23:58:31 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v2 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
Date:   Tue,  9 Nov 2021 15:58:24 +0800
Message-Id: <1636444705-17883-2-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add SD/SDIO driver for Sunplus SP7021.

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
Changes in v2:
 - Addressed all comments from Mr. Philipp Zabel
 - Modified the structure and register access method.
 - Modifiedthe path about MAINTAINERS. ( wrong messages PATH in v1).

 MAINTAINERS                    |    6 +
 drivers/mmc/host/Kconfig       |   10 +
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sunplus_sd2.c | 1068 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sunplus_sd2.h |  155 ++++++
 5 files changed, 1240 insertions(+)
 create mode 100644 drivers/mmc/host/sunplus_sd2.c
 create mode 100644 drivers/mmc/host/sunplus_sd2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 170bbbe..2746084 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18189,6 +18189,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
+M:	LH Kuo <lh.kuo@sunplus.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sunplus_sd2.*
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5af8494..2aba9eb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1091,5 +1091,15 @@ config MMC_OWL
 	  This selects support for the SD/MMC Host Controller on
 	  Actions Semi Owl SoCs.
 
+config MMC_SP_SDV2
+	tristate "Sunplus SP7021 SD/SDIO Controller"
+	depends on SOC_SP7021
+	help
+		If you say yes here, you will get support for SD/SDIO host interface
+		on sunplus Socs.
+		If you have a controller with this interface, say Y or M here.
+		If unsure, say N.
+                Sunplus  SD/SDIO Host Controller support"
+
 config MMC_SDHCI_EXTERNAL_DMA
 	bool
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ea36d37..167aa5c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
 cqhci-y					+= cqhci-core.o
 cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
 obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
+obj-$(CONFIG_MMC_SP_SDV2)		+= sunplus_sd2.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sunplus_sd2.c b/drivers/mmc/host/sunplus_sd2.c
new file mode 100644
index 0000000..756c3d4
--- /dev/null
+++ b/drivers/mmc/host/sunplus_sd2.c
@@ -0,0 +1,1068 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * (C) Copyright 2019 Sunplus Technology. <http://www.sunplus.com/>
+ *
+ * Sunplus SD host controller v2.0
+ *
+ */
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/clk.h>
+#include <linux/bitops.h>
+#include <linux/uaccess.h>
+#include "sunplus_sd2.h"
+
+enum loglevel {
+	SPSDC_LOG_OFF,
+	SPSDC_LOG_ERROR,
+	SPSDC_LOG_WARNING,
+	SPSDC_LOG_INFO,
+	SPSDC_LOG_DEBUG,
+	SPSDC_LOG_VERBOSE,
+	SPSDC_LOG_MAX
+};
+static int loglevel = SPSDC_LOG_WARNING;
+
+/**
+ * we do not need `SPSDC_LOG_' prefix here, when specify @level.
+ */
+#define spsdc_pr(level, fmt, ...)	\
+	do {	\
+		if (unlikely(SPSDC_LOG_##level <= loglevel))	\
+			pr_info("SPSDC [" #level "] " fmt, ##__VA_ARGS__);	\
+	} while (0)
+
+/* Produces a mask of set bits covering a range of a 32-bit value */
+static inline u32 bitfield_mask(u32 shift, u32 width)
+{
+	return ((1 << width) - 1) << shift;
+}
+
+/* Extract the value of a bitfield found within a given register value */
+static inline u32 bitfield_extract(u32 reg_val, u32 shift, u32 width)
+{
+	return (reg_val & bitfield_mask(shift, width)) >> shift;
+}
+
+/* Replace the value of a bitfield found within a given register value */
+static inline u32 bitfield_replace(u32 reg_val, u32 shift, u32 width, u32 val)
+{
+	u32 mask = bitfield_mask(shift, width);
+
+	return (reg_val & ~mask) | (val << shift);
+}
+/* for register value with mask bits */
+#define __bitfield_replace(value, shift, width, new_value)		\
+	(bitfield_replace(value, shift, width, new_value)|bitfield_mask(shift+16, width))
+
+/**
+ * wait for transaction done, return -1 if error.
+ */
+static inline int spsdc_wait_finish(struct spsdc_host *host)
+{
+	/* Wait for transaction finish */
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_SDSTATE_FINISH)
+			return 0;
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_SDSTATE_ERROR)
+			return -1;
+	}
+	return -1;
+}
+
+static inline int spsdc_wait_sdstatus(struct spsdc_host *host, unsigned int status_bit)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPSD2_SD_STATUS_REG) & status_bit)
+			return 0;
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_SDSTATE_ERROR)
+			return -1;
+	}
+	return -1;
+}
+
+#define spsdc_wait_rspbuf_full(host) spsdc_wait_sdstatus(host, SPSDC_SDSTATUS_RSP_BUF_FULL)
+#define spsdc_wait_rxbuf_full(host) spsdc_wait_sdstatus(host, SPSDC_SDSTATUS_RX_DATA_BUF_FULL)
+#define spsdc_wait_txbuf_empty(host) spsdc_wait_sdstatus(host, SPSDC_SDSTATUS_TX_DATA_BUF_EMPTY)
+
+static void spsdc_get_rsp(struct spsdc_host *host, struct mmc_command *cmd)
+{
+	u32 value0_3, value4_5;
+
+	if (unlikely(!(cmd->flags & MMC_RSP_PRESENT)))
+		return;
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[1] |= value0_3 >> 8;
+		cmd->resp[2] = value0_3 << 24;
+		cmd->resp[2] |= value4_5 << 8;
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[2] |= value0_3 >> 24;
+		cmd->resp[3] = value0_3 << 8;
+		cmd->resp[3] |= value4_5 >> 8;
+	} else {
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+	}
+}
+
+static void spsdc_set_bus_clk(struct spsdc_host *host, int clk)
+{
+	unsigned int clkdiv;
+	int f_min = host->mmc->f_min;
+	int f_max = host->mmc->f_max;
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+
+	if (clk < f_min)
+		clk = f_min;
+	if (clk > f_max)
+		clk = f_max;
+
+	// SD 2.0 only max set to 50Mhz CLK
+	if (clk >= SPSDC_50M_CLK)
+		clk = f_max;
+
+	spsdc_pr(INFO, "set bus clock to %d\n", clk);
+	clkdiv = (clk_get_rate(host->clk)+clk)/clk-1;
+	if (clkdiv > 0xfff) {
+		spsdc_pr(WARNING, "clock %d is too low to be set!\n", clk);
+		clkdiv = 0xfff;
+	}
+	value = bitfield_replace(value, 0, 12, clkdiv);
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+
+	/* In order to reduce the frequency of context switch,
+	 * if it is high speed or upper, we do not use interrupt
+	 * when send a command that without data.
+	 */
+	if (clk > 25000000)
+		host->use_int = 0;
+	else
+		host->use_int = 1;
+}
+
+static void spsdc_set_bus_timing(struct spsdc_host *host, unsigned int timing)
+{
+	u32 value = readl(host->base + SPSD2_SD_TIMING_CONF0_REG);
+	int clkdiv = readl(host->base + SPSD2_SD_CONF_REG) & 0xfff;
+	int delay = (clkdiv/2 < 7) ? clkdiv/2 : 7;
+	char *timing_name;
+
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		value = bitfield_replace(value, 11, 1, 0); /* sd_high_speed_en */
+		timing_name = "legacy";
+		break;
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_HS:
+		value = bitfield_replace(value, 11, 1, 1);
+		value = bitfield_replace(value, 12, 3, delay); /* sd_wr_dly_sel */
+		timing_name = "hs";
+		break;
+	}
+	spsdc_pr(INFO, "set bus timing to %s\n", timing_name);
+	writel(value, host->base + SPSD2_SD_TIMING_CONF0_REG);
+}
+
+static void spsdc_set_bus_width(struct spsdc_host *host, int width)
+{
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+	int bus_width;
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		value = bitfield_replace(value, 12, 1, 0);
+		value = bitfield_replace(value, 18, 1, 1);
+		bus_width = 8;
+		break;
+	case MMC_BUS_WIDTH_4:
+		value = bitfield_replace(value, 12, 1, 1);
+		value = bitfield_replace(value, 18, 1, 0);
+		bus_width = 4;
+		break;
+	default:
+		value = bitfield_replace(value, 12, 1, 0);
+		value = bitfield_replace(value, 18, 1, 0);
+		bus_width = 1;
+		break;
+	};
+	spsdc_pr(INFO, "set bus width to %d bit(s)\n", bus_width);
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+}
+/**
+ * select the working mode of controller: sd/sdio/emmc
+ */
+static void spsdc_select_mode(struct spsdc_host *host, int mode)
+{
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+
+	host->mode = mode;
+	/* set `sdmmcmode', as it will sample data at fall edge
+	 * of SD bus clock if `sdmmcmode' is not set when
+	 * `sd_high_speed_en' is not set, which is not compliant
+	 * with SD specification
+	 */
+	value = bitfield_replace(value, 16, 1, 1);
+	switch (mode) {
+	case SPSDC_MODE_EMMC:
+		value = bitfield_replace(value, 20, 1, 0);
+		writel(value, host->base + SPSD2_SD_CONF_REG);
+		break;
+	case SPSDC_MODE_SDIO:
+		value = bitfield_replace(value, 20, 1, 1);
+		writel(value, host->base + SPSD2_SD_CONF_REG);
+		value = readl(host->base + SPSD2_SDIO_CTRL_REG);
+		value = bitfield_replace(value, 6, 1, 1); /* int_multi_trig */
+		writel(value, host->base + SPSD2_SDIO_CTRL_REG);
+		break;
+	case SPSDC_MODE_SD:
+	default:
+		value = bitfield_replace(value, 20, 1, 0);
+		host->mode = SPSDC_MODE_SD;
+		writel(value, host->base + SPSD2_SD_CONF_REG);
+		break;
+	}
+}
+
+static void spsdc_sw_reset(struct spsdc_host *host)
+{
+	spsdc_pr(DEBUG, "sw reset\n");
+	writel(0x7, host->base + SPSD2_SD_RST_REG);
+	writel(0x6, host->base + SPSD2_DMA_STOP_RST_REG);
+	while (readl(host->base + SPSD2_DMA_STOP_RST_REG) & BIT(2))
+		;
+	/* reset dma operation */
+	writel(0x0, host->base + SPSD2_DMA_CTRL_REG);
+	writel(0x1, host->base + SPSD2_DMA_CTRL_REG);
+	writel(0x0, host->base + SPSD2_DMA_CTRL_REG);
+	spsdc_pr(DEBUG, "sw reset done\n");
+}
+
+static void spsdc_prepare_cmd(struct spsdc_host *host, struct mmc_command *cmd)
+{
+
+	u32 value;
+
+	writeb((u8)(cmd->opcode | 0x40), host->base + SPSD2_SD_CMD_BUF0_REG);
+	writeb((u8)((cmd->arg >> 24) & 0x000000ff), host->base + SPSD2_SD_CMD_BUF1_REG);
+	writeb((u8)((cmd->arg >> 16) & 0x000000ff), host->base + SPSD2_SD_CMD_BUF2_REG);
+	writeb((u8)((cmd->arg >> 8) & 0x000000ff), host->base + SPSD2_SD_CMD_BUF3_REG);
+	writeb((u8)((cmd->arg >> 0) & 0x000000ff), host->base + SPSD2_SD_CMD_BUF4_REG);
+
+	/* disable interrupt if needed */
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value = bitfield_replace(value, 2, 1, 1); /* sd_cmp_clr */
+	if (likely(!host->use_int || cmd->flags & MMC_RSP_136))
+		value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	else
+		value = bitfield_replace(value, 0, 1, 1);
+	writel(value, host->base + SPSD2_SD_INT_REG);
+
+	value = readl(host->base + SPSD2_SD_CONF0_REG);
+	value = bitfield_replace(value, 4, 2, 0); /* sd_trans_mode */
+	value = bitfield_replace(value, 7, 1, 1); /* sdcmddummy */
+	if (likely(cmd->flags & MMC_RSP_PRESENT)) {
+		value = bitfield_replace(value, 6, 1, 1); /* sdautorsp */
+	} else {
+		value = bitfield_replace(value, 6, 1, 0);
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+		return;
+	}
+	/*
+	 * Currently, host is not capable of checking R2's CRC7,
+	 * thus, enable crc7 check only for 48 bit response commands
+	 */
+	if (likely(cmd->flags & MMC_RSP_CRC && !(cmd->flags & MMC_RSP_136)))
+		value = bitfield_replace(value, 8, 1, 1); /* sdrspchk_en */
+	else
+		value = bitfield_replace(value, 8, 1, 0);
+	writel(value, host->base + SPSD2_SD_CONF0_REG);
+
+	value = readl(host->base + SPSD2_SD_CONF_REG);
+	if (unlikely(cmd->flags & MMC_RSP_136))
+		value = bitfield_replace(value, 13, 1, 1); /* sdrsptype */
+	else
+		value = bitfield_replace(value, 13, 1, 0);
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+
+}
+
+static void spsdc_prepare_data(struct spsdc_host *host, struct mmc_data *data)
+{
+	u32 value;
+
+	writel(data->blocks - 1, host->base + SPSD2_SD_PAGE_NUM_REG);
+	writel(data->blksz - 1, host->base + SPSD2_BLOCKSIZE_REG);
+	value = readl(host->base + SPSD2_SD_CONF0_REG);
+	if (data->flags & MMC_DATA_READ) {
+		value = bitfield_replace(value, 4, 2, 2); /* sd_trans_mode */
+		value = bitfield_replace(value, 6, 1, 0); /* sdautorsp */
+		value = bitfield_replace(value, 7, 1, 0); /* sdcmddummy */
+		writel(0x12, host->base + SPSD2_DMA_SRCDST_REG);
+	} else {
+		value = bitfield_replace(value, 4, 2, 1);
+		writel(0x21, host->base + SPSD2_DMA_SRCDST_REG);
+	}
+	/* to prevent of the responses of CMD18/25 being by CMD12's,
+	 * send CMD12 by ourself instead of by controller automatically
+	 *
+	 *	#if 0
+	 *	if ((cmd->opcode == MMC_READ_MULTIPLE_BLOCK)
+	 *	 || (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK))
+	 *		value = bitfield_replace(value, 2, 1, 0); //sd_len_mode
+	 *	else
+	 *		value = bitfield_replace(value, 2, 1, 1);
+	 *	#endif
+	 */
+	value = bitfield_replace(value, 2, 1, 1);
+
+	if (likely(host->dmapio_mode == SPSDC_DMA_MODE)) {
+		struct scatterlist *sg;
+		dma_addr_t dma_addr;
+		unsigned int dma_size;
+		void __iomem *reg_addr;
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+		int i, count = dma_map_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+
+		if (unlikely(!count || count > SPSDC_MAX_DMA_MEMORY_SECTORS)) {
+			spsdc_pr(ERROR, "error at dma_mapp_sg: count = %d\n", count);
+			data->error = -EINVAL;
+			return;
+		}
+		for_each_sg(data->sg, sg, count, i) {
+			dma_addr = sg_dma_address(sg);
+			dma_size = sg_dma_len(sg) / data->blksz - 1;
+			//dma_size = sg_dma_len(sg) / 512 - 1;
+			if (i == 0) {
+				writel(dma_addr, host->base + SPSD2_DMA_BASE_ADDR0_REG);
+				writel(dma_addr >> 16, host->base + SPSD2_DMA_BASE_ADDR16_REG);
+				writel(dma_size, host->base + SPSD2_SDRAM_SECTOR_SIZE_REG);
+			} else {
+				reg_addr = host->base + (SPSD2_SDRAM_SECTOR_ADDR_REG + (i - 1) * 8);
+				writel(dma_addr, reg_addr);
+				writel(dma_size, reg_addr + 4);
+			}
+		}
+		value = bitfield_replace(value, 0, 1, 0); /* sdpiomode */
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+		writel(data->blksz - 1, host->base + SPSD2_DMA_SIZE_REG);
+		/* enable interrupt if needed */
+		if (!host->use_int && data->blksz * data->blocks > host->dma_int_threshold) {
+			host->dma_use_int = 1;
+			value = readl(host->base + SPSD2_SD_INT_REG);
+			value = bitfield_replace(value, 0, 1, 1); /* sdcmpen */
+			writel(value, host->base + SPSD2_SD_INT_REG);
+		}
+	} else {
+		value = bitfield_replace(value, 0, 1, 1);
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+	}
+}
+
+static inline void spsdc_trigger_transaction(struct spsdc_host *host)
+{
+	u32 value = readl(host->base + SPSD2_SD_CTRL_REG);
+
+	value = bitfield_replace(value, 0, 1, 1); /* trigger transaction */
+	writel(value, host->base + SPSD2_SD_CTRL_REG);
+}
+
+static int __send_stop_cmd(struct spsdc_host *host, struct mmc_command *stop)
+{
+	u32 value;
+
+	spsdc_prepare_cmd(host, stop);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	if (spsdc_wait_finish(host)) {
+		value = readl(host->base + SPSD2_SD_STATUS_REG);
+		if (value & SPSDC_SDSTATUS_RSP_CRC7_ERROR)
+			stop->error = -EILSEQ;
+		else
+			stop->error = -ETIMEDOUT;
+		return -1;
+	}
+	spsdc_get_rsp(host, stop);
+	return 0;
+}
+
+#ifdef SPSDC_WIDTH_SWITCH
+
+static int __switch_sdio_bus_width(struct spsdc_host *host, int width)
+{
+	struct mmc_command cmd = {0};
+	u8 ctrl;
+	u32 value;
+	int ret = 0;
+
+	cmd.opcode = SD_IO_RW_DIRECT;
+	cmd.arg |= SDIO_CCCR_IF << 9;
+	cmd.flags = MMC_RSP_R5;
+	spsdc_prepare_cmd(host, &cmd);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	ret = spsdc_wait_finish(host);
+	if (ret) {
+		spsdc_sw_reset(host);
+		return ret;
+	}
+	spsdc_get_rsp(host, &cmd);
+	ctrl = cmd.resp[0] & 0xff;
+
+	ctrl &= ~SDIO_BUS_WIDTH_MASK;
+	if (width == MMC_BUS_WIDTH_4) {
+		/* set to 4-bit bus width */
+		ctrl |= SDIO_BUS_WIDTH_4BIT;
+	}
+
+	cmd.arg |= 0x80000000;
+	cmd.arg |= ctrl;
+	spsdc_prepare_cmd(host, &cmd);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	ret = spsdc_wait_finish(host);
+	if (ret) {
+		spsdc_sw_reset(host);
+		return ret;
+	}
+	spsdc_get_rsp(host, &cmd);
+	spsdc_set_bus_width(host, width);
+
+	return ret;
+}
+
+#endif
+
+/**
+ * check if error during transaction.
+ * @host -  host
+ * @mrq - the mrq
+ * @return 0 if no error otherwise the error number.
+ */
+static int spsdc_check_error(struct spsdc_host *host, struct mmc_request *mrq)
+{
+	int ret = 0;
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+	u32 value = readl(host->base + SPSD2_SD_STATE_REG);
+
+	if (unlikely(value & SPSDC_SDSTATE_ERROR)) {
+		u32 timing_cfg0, timing_cfg1;
+
+		spsdc_pr(DEBUG, "%s cmd %d with data %p error!\n", __func__, cmd->opcode, data);
+		spsdc_pr(VERBOSE, "%s sd_state: 0x%08x\n", __func__, value);
+		value = readl(host->base + SPSD2_SD_STATUS_REG);
+		spsdc_pr(VERBOSE, "%s sd_status: 0x%08x\n", __func__, value);
+		timing_cfg0 = readl(host->base + SPSD2_SD_TIMING_CONF0_REG);
+		host->tuning_info.wr_dly = bitfield_extract(timing_cfg0, 12, 3);
+		timing_cfg1 = readl(host->base + SPSD2_SD_TIMING_CONF1_REG);
+		host->tuning_info.rd_dly = bitfield_extract(timing_cfg1, 13, 3);
+		if (value & SPSDC_SDSTATUS_RSP_TIMEOUT) {
+			ret = -ETIMEDOUT;
+			host->tuning_info.wr_dly++;
+		} else if (value & SPSDC_SDSTATUS_RSP_CRC7_ERROR) {
+			ret = -EILSEQ;
+			host->tuning_info.rd_dly++;
+		}
+		if (data) {
+			if ((value & SPSDC_SDSTATUS_STB_TIMEOUT) ||
+				(value & SPSDC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT)) {
+				ret = -ETIMEDOUT;
+				host->tuning_info.rd_dly++;
+			} else if (value & SPSDC_SDSTATUS_CRC_TOKEN_CHECK_ERROR) {
+				ret = -EILSEQ;
+				host->tuning_info.wr_dly++;
+			} else if (value & SPSDC_SDSTATUS_RDATA_CRC16_ERROR) {
+				ret = -EILSEQ;
+				host->tuning_info.rd_dly++;
+			}
+			data->error = ret;
+			data->bytes_xfered = 0;
+		}
+		cmd->error = ret;
+		if (!host->tuning_info.need_tuning)
+			cmd->retries = SPSDC_MAX_RETRIES; /* retry it */
+		spsdc_sw_reset(host);
+		timing_cfg0 = bitfield_replace(timing_cfg0, 12, 3, host->tuning_info.wr_dly);
+		writel(timing_cfg0, host->base + SPSD2_SD_TIMING_CONF0_REG);
+		timing_cfg1 = bitfield_replace(timing_cfg0, 13, 3, host->tuning_info.rd_dly);
+		writel(timing_cfg1, host->base + SPSD2_SD_TIMING_CONF1_REG);
+
+	} else if (data) {
+		data->bytes_xfered = data->blocks * data->blksz;
+	}
+	host->tuning_info.need_tuning = ret;
+	return ret;
+}
+
+
+static inline __maybe_unused void spsdc_txdummy(struct spsdc_host *host)
+{
+	u32 value;
+
+	value = readl(host->base + SPSD2_SD_CTRL_REG);
+	value = bitfield_replace(value, 1, 1, 1); /* trigger tx dummy */
+	writel(value, host->base + SPSD2_SD_CTRL_REG);
+}
+
+static void spsdc_xfer_data_pio(struct spsdc_host *host, struct mmc_data *data)
+{
+	u16 *buf; /* tx/rx 2 bytes one time in pio mode */
+	int data_left = data->blocks * data->blksz;
+	int consumed, remain;
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
+	unsigned int flags = 0;
+
+	if (data->flags & MMC_DATA_WRITE)
+		flags |= SG_MITER_FROM_SG;
+	else
+		flags |= SG_MITER_TO_SG;
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
+	while (data_left > 0) {
+		consumed = 0;
+		if (!sg_miter_next(sg_miter))
+			break;
+		buf = sg_miter->addr;
+		remain = sg_miter->length;
+		do {
+			if (data->flags & MMC_DATA_WRITE) {
+				if (spsdc_wait_txbuf_empty(host))
+					goto done;
+				writel(*buf, host->base + SPSD2_SD_PIO_TX_REG);
+			} else {
+				if (spsdc_wait_rxbuf_full(host))
+					goto done;
+				*buf = readl(host->base + SPSD2_SD_PIO_RX_REG);
+			}
+			buf++;
+			consumed += 2;
+			remain -= 2;
+		} while (remain);
+		sg_miter->consumed = consumed;
+		data_left -= consumed;
+	}
+done:
+	sg_miter_stop(sg_miter);
+}
+
+static void spsdc_controller_init(struct spsdc_host *host)
+{
+	u32 value;
+	int ret = reset_control_assert(host->rstc);
+
+	if (!ret) {
+		usleep_range(1000, 1250);
+		ret = reset_control_deassert(host->rstc);
+	}
+	if (ret)
+		spsdc_pr(WARNING, "Failed to reset SD controller!\n");
+	value = readl(host->base + SPSD2_MEDIA_TYPE_REG);
+	value = bitfield_replace(value, 0, 3, SPSDC_MEDIA_SD);
+	writel(value, host->base + SPSD2_MEDIA_TYPE_REG);
+}
+
+static void spsdc_set_power_mode(struct spsdc_host *host, struct mmc_ios *ios)
+{
+	if (host->power_state == ios->power_mode)
+		return;
+
+	switch (ios->power_mode) {
+		/* power off->up->on */
+	case MMC_POWER_ON:
+		spsdc_pr(DEBUG, "set MMC_POWER_ON\n");
+		spsdc_controller_init(host);
+		pm_runtime_get_sync(host->mmc->parent);
+		break;
+	case MMC_POWER_UP:
+		spsdc_pr(DEBUG, "set MMC_POWER_UP\n");
+		break;
+	case MMC_POWER_OFF:
+		spsdc_pr(DEBUG, "set MMC_POWER_OFF\n");
+		pm_runtime_put(host->mmc->parent);
+		break;
+	}
+	host->power_state = ios->power_mode;
+}
+
+/**
+ * 1. unmap scatterlist if needed;
+ * 2. get response & check error conditions;
+ * 3. unlock host->mrq_lock
+ * 4. notify mmc layer the request is done
+ */
+static void spsdc_finish_request(struct spsdc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+
+	if (!mrq)
+		return;
+
+	cmd = mrq->cmd;
+	data = mrq->data;
+
+	if (data && SPSDC_DMA_MODE == host->dmapio_mode) {
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+		dma_unmap_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		host->dma_use_int = 0;
+	}
+	spsdc_get_rsp(host, cmd);
+	spsdc_check_error(host, mrq);
+	if (mrq->stop) {
+		if (__send_stop_cmd(host, mrq->stop))
+			spsdc_sw_reset(host);
+	}
+	host->mrq = NULL;
+
+#ifdef SPSDC_WIDTH_SWITCH
+	if (host->restore_4bit_sdio_bus) {
+		__switch_sdio_bus_width(host, MMC_BUS_WIDTH_4);
+		host->restore_4bit_sdio_bus = 0;
+	}
+#endif
+
+	mutex_unlock(&host->mrq_lock);
+	spsdc_pr(VERBOSE, "request done > error:%d, cmd:%d, resp:0x%08x\n",
+				cmd->error, cmd->opcode, cmd->resp[0]);
+	mmc_request_done(host->mmc, mrq);
+}
+
+/* Interrupt Service Routine */
+irqreturn_t spsdc_irq(int irq, void *dev_id)
+{
+	struct spsdc_host *host = dev_id;
+	u32 value = readl(host->base + SPSD2_SD_INT_REG);
+
+	spin_lock(&host->lock);
+	if ((value & SPSDC_SDINT_SDCMP) &&
+		(value & SPSDC_SDINT_SDCMPEN)) {
+		value = bitfield_replace(value, 0, 1, 0); /* disable sdcmp */
+		value = bitfield_replace(value, 2, 1, 1); /* sd_cmp_clr */
+		writel(value, host->base + SPSD2_SD_INT_REG);
+		/* we may need send stop command to stop data transaction,
+		 * which is time consuming, so make use of tasklet to handle this.
+		 */
+		if (host->mrq && host->mrq->stop)
+			tasklet_schedule(&host->tsklet_finish_req);
+		else
+			spsdc_finish_request(host, host->mrq);
+
+	}
+	if ((value & SPSDC_SDINT_SDIO) &&
+		(value & SPSDC_SDINT_SDIOEN)) {
+		mmc_signal_sdio_irq(host->mmc);
+	}
+	spin_unlock(&host->lock);
+	return IRQ_HANDLED;
+}
+
+static void spsdc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct spsdc_host *host = mmc_priv(mmc);
+	struct mmc_data *data;
+	struct mmc_command *cmd;
+
+#ifdef SPSDC_WIDTH_SWITCH
+	int bus_width = mmc->ios.bus_width;
+#endif
+
+	mutex_lock_interruptible(&host->mrq_lock);
+	host->mrq = mrq;
+	data = mrq->data;
+	cmd = mrq->cmd;
+	spsdc_pr(VERBOSE, "%s > cmd:%d, arg:0x%08x, data len:%d\n", __func__,
+		 cmd->opcode, cmd->arg, data ? (data->blocks*data->blksz) : 0);
+
+#ifdef SPSDC_WIDTH_SWITCH
+	if (cmd->opcode == SD_IO_RW_EXTENDED && bus_width ==
+			MMC_BUS_WIDTH_4 && data->blocks*data->blksz <= 4) {
+		if (__switch_sdio_bus_width(host, MMC_BUS_WIDTH_1)) {
+			cmd->error = -1;
+			host->mrq = NULL;
+			mutex_unlock(&host->mrq_lock);
+			mmc_request_done(host->mmc, mrq);
+			return;
+		}
+		host->restore_4bit_sdio_bus = 1;
+	}
+#endif
+
+	spsdc_prepare_cmd(host, cmd);
+	/* we need manually read response R2. */
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		spsdc_trigger_transaction(host);
+		spsdc_get_rsp(host, cmd);
+		spsdc_wait_finish(host);
+		spsdc_check_error(host, mrq);
+		host->mrq = NULL;
+		spsdc_pr(VERBOSE, "request done > error:%d, cmd:%d, resp:%08x %08x %08x %08x\n",
+			 cmd->error, cmd->opcode, cmd->resp[0],
+			 cmd->resp[1], cmd->resp[2], cmd->resp[3]);
+		mutex_unlock(&host->mrq_lock);
+		mmc_request_done(host->mmc, mrq);
+	} else {
+		if (data)
+			spsdc_prepare_data(host, data);
+
+		if ((host->dmapio_mode && data) ==  SPSDC_PIO_MODE) {
+			u32 value;
+			/* pio data transfer do not use interrupt */
+			value = readl(host->base + SPSD2_SD_INT_REG);
+			value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+			writel(value, host->base + SPSD2_SD_INT_REG);
+			spsdc_trigger_transaction(host);
+			spsdc_xfer_data_pio(host, data);
+			spsdc_wait_finish(host);
+			spsdc_finish_request(host, mrq);
+		} else {
+			if (!(host->use_int || host->dma_use_int)) {
+				spsdc_trigger_transaction(host);
+				spsdc_wait_finish(host);
+				spsdc_finish_request(host, mrq);
+			} else {
+				spsdc_trigger_transaction(host);
+			}
+		}
+	}
+}
+
+static void spsdc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct spsdc_host *host = (struct spsdc_host *)mmc_priv(mmc);
+
+	mutex_lock(&host->mrq_lock);
+	spsdc_set_power_mode(host, ios);
+	spsdc_set_bus_clk(host, ios->clock);
+	spsdc_set_bus_timing(host, ios->timing);
+	spsdc_set_bus_width(host, ios->bus_width);
+	/* ensure mode is correct, because we might have hw reset the controller */
+	spsdc_select_mode(host, host->mode);
+	mutex_unlock(&host->mrq_lock);
+
+}
+
+/**
+ * Return values for the get_cd callback should be:
+ *   0 for a absent card
+ *   1 for a present card
+ *   -ENOSYS when not supported (equal to NULL callback)
+ *   or a negative errno value when something bad happened
+ */
+int spsdc_get_cd(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (mmc_can_gpio_cd(mmc))
+		ret = mmc_gpio_get_cd(mmc);
+	else
+		spsdc_pr(WARNING, "no gpio assigned for card detection\n");
+
+	if (ret < 0) {
+		spsdc_pr(ERROR, "Failed to get card presence status\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static void spsdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct spsdc_host *host = mmc_priv(mmc);
+	u32 value = readl(host->base + SPSD2_SD_INT_REG);
+
+	value = bitfield_replace(value, 6, 1, 1); /* sdio_int_clr */
+	if (enable)
+		value = bitfield_replace(value, 4, 1, 1);
+	else
+		value = bitfield_replace(value, 4, 1, 0);
+	writel(value, host->base + SPSD2_SD_INT_REG);
+}
+
+static const struct mmc_host_ops spsdc_ops = {
+	.request = spsdc_request,
+	.set_ios = spsdc_set_ios,
+	.get_cd = spsdc_get_cd,
+	.enable_sdio_irq = spsdc_enable_sdio_irq,
+};
+
+static void tsklet_func_finish_req(unsigned long data)
+{
+	struct spsdc_host *host = (struct spsdc_host *)data;
+
+	spin_lock(&host->lock);
+	spsdc_finish_request(host, host->mrq);
+	spin_unlock(&host->lock);
+}
+
+static int spsdc_drv_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct mmc_host *mmc;
+	struct resource *resource;
+	struct spsdc_host *host;
+	unsigned int mode;
+
+	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto probe_free_host;
+	}
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->power_state = MMC_POWER_OFF;
+	host->dma_int_threshold = 1024;
+	host->dmapio_mode = SPSDC_DMA_MODE;
+
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk)) {
+		spsdc_pr(ERROR, "Can not find clock source\n");
+		ret = PTR_ERR(host->clk);
+		goto probe_free_host;
+	}
+
+	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(host->rstc)) {
+		spsdc_pr(ERROR, "Can not find reset controller\n");
+		ret = PTR_ERR(host->rstc);
+		goto probe_free_host;
+	}
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(resource)) {
+		spsdc_pr(ERROR, "get sd register resource fail\n");
+		ret = PTR_ERR(resource);
+		goto probe_free_host;
+	}
+
+	host->base = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR((void *)host->base)) {
+		spsdc_pr(ERROR, "devm_ioremap_resource fail\n");
+		ret = PTR_ERR((void *)host->base);
+		goto probe_free_host;
+	}
+
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		spsdc_pr(ERROR, "get sd irq resource fail\n");
+		ret = -EINVAL;
+		goto probe_free_host;
+	}
+	if (devm_request_irq(&pdev->dev, host->irq, spsdc_irq,
+		IRQF_SHARED, dev_name(&pdev->dev), host)) {
+		spsdc_pr(ERROR, "Failed to request sd card interrupt.\n");
+		ret = -ENOENT;
+		goto probe_free_host;
+	}
+	spsdc_pr(INFO, "spsdc driver probe, reg base:0x%p, irq:%d\n", host->base, host->irq);
+
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto probe_free_host;
+
+	ret = clk_prepare(host->clk);
+	if (ret)
+		goto probe_free_host;
+
+	ret = clk_enable(host->clk);
+	if (ret)
+		goto probe_clk_unprepare;
+
+	spin_lock_init(&host->lock);
+	mutex_init(&host->mrq_lock);
+	tasklet_init(&host->tsklet_finish_req, tsklet_func_finish_req, (unsigned long)host);
+	mmc->ops = &spsdc_ops;
+	mmc->f_min = SPSDC_MIN_CLK;
+	if (mmc->f_max > SPSDC_MAX_CLK) {
+		spsdc_pr(DEBUG, "max-frequency is too high, set it to %d\n", SPSDC_MAX_CLK);
+		mmc->f_max = SPSDC_MAX_CLK;
+	}
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->max_seg_size = SPSDC_MAX_BLK_COUNT * 512;
+	/* Host controller supports up to "SPSDC_MAX_DMA_MEMORY_SECTORS",
+	 * a.k.a. max scattered memory segments per request
+	 */
+	/* Limited by the max value of dma_size & data_length, set it to 512 bytes for now */
+	mmc->max_segs = SPSDC_MAX_DMA_MEMORY_SECTORS;
+	mmc->max_req_size = SPSDC_MAX_BLK_COUNT * 512;
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = SPSDC_MAX_BLK_COUNT; /* Limited by sd_page_num */
+
+	dev_set_drvdata(&pdev->dev, host);
+	spsdc_controller_init(host);
+	mode = (int)of_device_get_match_data(&pdev->dev);
+	spsdc_select_mode(host, mode);
+	mmc_add_host(mmc);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+probe_clk_unprepare:
+	spsdc_pr(ERROR, "unable to enable controller clock\n");
+	clk_unprepare(host->clk);
+probe_free_host:
+	if (mmc)
+		mmc_free_host(mmc);
+
+	return ret;
+}
+
+static int spsdc_drv_remove(struct platform_device *dev)
+{
+	struct spsdc_host *host = platform_get_drvdata(dev);
+
+	mmc_remove_host(host->mmc);
+	clk_disable(host->clk);
+	clk_unprepare(host->clk);
+	pm_runtime_disable(&dev->dev);
+	platform_set_drvdata(dev, NULL);
+	mmc_free_host(host->mmc);
+
+	return 0;
+}
+
+
+static int spsdc_drv_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct spsdc_host *host;
+
+	host = platform_get_drvdata(dev);
+	mutex_lock(&host->mrq_lock); /* Make sure that no one is holding the controller */
+	mutex_unlock(&host->mrq_lock);
+	clk_disable(host->clk);
+	return 0;
+}
+
+static int spsdc_drv_resume(struct platform_device *dev)
+{
+	struct spsdc_host *host;
+
+	host = platform_get_drvdata(dev);
+	return clk_enable(host->clk);
+}
+
+#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
+static int spsdc_pm_suspend(struct device *dev)
+{
+	pm_runtime_force_suspend(dev);
+	return 0;
+}
+
+static int spsdc_pm_resume(struct device *dev)
+{
+	pm_runtime_force_resume(dev);
+	return 0;
+}
+#endif /* ifdef CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME_SD
+static int spsdc_pm_runtime_suspend(struct device *dev)
+{
+	struct spsdc_host *host;
+
+	host = dev_get_drvdata(dev);
+	if (__clk_is_enabled(host->clk))
+		clk_disable(host->clk);
+	return 0;
+}
+
+static int spsdc_pm_runtime_resume(struct device *dev)
+{
+	struct spsdc_host *host;
+	int ret = 0;
+
+	host = dev_get_drvdata(dev);
+	if (!host->mmc)
+		return -EINVAL;
+	if (mmc_can_gpio_cd(host->mmc)) {
+		ret = mmc_gpio_get_cd(host->mmc);
+		if (!ret) {
+			spsdc_pr(DEBUG, "No card insert\n");
+			return 0;
+		}
+	}
+	return clk_enable(host->clk);
+}
+#endif /* ifdef CONFIG_PM_RUNTIME_SD */
+
+static const struct dev_pm_ops spsdc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(spsdc_pm_suspend, spsdc_pm_resume)
+#ifdef CONFIG_PM_RUNTIME_SD
+	SET_RUNTIME_PM_OPS(spsdc_pm_runtime_suspend, spsdc_pm_runtime_resume, NULL)
+#endif
+};
+#endif /* ifdef CONFIG_PM */
+
+static const struct of_device_id spsdc_of_table[] = {
+	{
+		.compatible = "sunplus,sp7021-card1",
+		.data = (void *)SPSDC_MODE_SD,
+	},
+	{
+		.compatible = "sunplus,sp7021-sdio",
+		.data = (void *)SPSDC_MODE_SDIO,
+	},
+	{/* sentinel */}
+
+};
+MODULE_DEVICE_TABLE(of, spsdc_of_table);
+
+static struct platform_driver spsdc_driver = {
+	.probe = spsdc_drv_probe,
+	.remove = spsdc_drv_remove,
+	.suspend = spsdc_drv_suspend,
+	.resume = spsdc_drv_resume,
+	.driver = {
+		.name = "spsdc",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &spsdc_pm_ops,
+#endif
+		.of_match_table = spsdc_of_table,
+	},
+};
+module_platform_driver(spsdc_driver);
+
+MODULE_AUTHOR("lh.kuo <lh.kuo@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus SD/SDIO host controller v2.0 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sunplus_sd2.h b/drivers/mmc/host/sunplus_sd2.h
new file mode 100644
index 0000000..65760ec
--- /dev/null
+++ b/drivers/mmc/host/sunplus_sd2.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * (C) Copyright 2019 Sunplus Technology. <http://www.sunplus.com/>
+ *
+ * Sunplus SD host controller v2.0
+ */
+#ifndef __SPSDC_H__
+#define __SPSDC_H__
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+
+
+#define SPSDC_WIDTH_SWITCH
+
+#define SPSDC_MIN_CLK	400000
+#define SPSDC_MAX_CLK	52000000
+#define SPSDC_50M_CLK   50000000
+
+#define SPSDC_MAX_BLK_COUNT 65536
+
+#define __rsvd_regs(l) __append_suffix(l, __COUNTER__)
+#define __append_suffix(l, s) _append_suffix(l, s)
+#define _append_suffix(l, s) (reserved##s[l])
+
+#define SPSD2_MEDIA_TYPE_REG 0x0000
+#define SPSDC_MEDIA_NONE 0
+#define SPSDC_MEDIA_SD 6
+#define SPSDC_MEDIA_MS 7
+
+
+#define SPSD2_SDRAM_SECTOR_SIZE_REG 0x0010
+
+#define SPSDC_MAX_DMA_MEMORY_SECTORS 8 /* support up to 8 fragmented memory blocks */
+
+#define SPSD2_SDRAM_SECTOR_ADDR_REG 0x001C
+
+#define SPSD2_SD_INT_REG            0x00B0
+#define SPSDC_SDINT_SDCMPEN	BIT(0)
+#define SPSDC_SDINT_SDCMP	BIT(1)
+#define SPSDC_SDINT_SDIOEN	BIT(4)
+#define SPSDC_SDINT_SDIO	BIT(5)
+
+#define SPSD2_SD_PAGE_NUM_REG       0x00B4
+#define SPSD2_SD_CONF0_REG          0x00B8
+#define SPSD2_SDIO_CTRL_REG         0x00Bc
+#define SPSD2_SD_RST_REG            0x00C0
+
+#define SPSD2_SD_CONF_REG           0x00C4
+#define SPSDC_MODE_SDIO	2
+#define SPSDC_MODE_EMMC	1
+#define SPSDC_MODE_SD	0
+
+#define SPSD2_SD_CTRL_REG           0x00C8
+#define SPSDC_SDSTATUS_DUMMY_READY			BIT(0)
+#define SPSDC_SDSTATUS_RSP_BUF_FULL			BIT(1)
+#define SPSDC_SDSTATUS_TX_DATA_BUF_EMPTY		BIT(2)
+#define SPSDC_SDSTATUS_RX_DATA_BUF_FULL			BIT(3)
+#define SPSDC_SDSTATUS_CMD_PIN_STATUS			BIT(4)
+#define SPSDC_SDSTATUS_DAT0_PIN_STATUS			BIT(5)
+#define SPSDC_SDSTATUS_RSP_TIMEOUT			BIT(6)
+#define SPSDC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT		BIT(7)
+#define SPSDC_SDSTATUS_STB_TIMEOUT			BIT(8)
+#define SPSDC_SDSTATUS_RSP_CRC7_ERROR			BIT(9)
+#define SPSDC_SDSTATUS_CRC_TOKEN_CHECK_ERROR		BIT(10)
+#define SPSDC_SDSTATUS_RDATA_CRC16_ERROR		BIT(11)
+#define SPSDC_SDSTATUS_SUSPEND_STATE_READY		BIT(12)
+#define SPSDC_SDSTATUS_BUSY_CYCLE			BIT(13)
+
+#define SPSD2_SD_STATUS_REG         0x00CC
+
+#define SPSD2_SD_STATE_REG          0x00D0
+#define SPSDC_SDSTATE_IDLE	(0x0)
+#define SPSDC_SDSTATE_TXDUMMY	(0x1)
+#define SPSDC_SDSTATE_TXCMD	(0x2)
+#define SPSDC_SDSTATE_RXRSP	(0x3)
+#define SPSDC_SDSTATE_TXDATA	(0x4)
+#define SPSDC_SDSTATE_RXCRC	(0x5)
+#define SPSDC_SDSTATE_RXDATA	(0x5)
+#define SPSDC_SDSTATE_MASK	(0x7)
+#define SPSDC_SDSTATE_BADCRC	(0x5)
+#define SPSDC_SDSTATE_ERROR	BIT(13)
+#define SPSDC_SDSTATE_FINISH	BIT(14)
+
+#define SPSD2_BLOCKSIZE_REG         0x00D4
+#define SPSD2_SD_TIMING_CONF0_REG   0x00Dc
+#define SPSD2_SD_TIMING_CONF1_REG   0x00E0
+#define SPSD2_SD_PIO_TX_REG         0x00E4
+#define SPSD2_SD_PIO_RX_REG         0x00E8
+#define SPSD2_SD_CMD_BUF0_REG       0x00Ec
+#define SPSD2_SD_CMD_BUF1_REG       0x00F0
+#define SPSD2_SD_CMD_BUF2_REG       0x00F4
+#define SPSD2_SD_CMD_BUF3_REG       0x00F8
+#define SPSD2_SD_CMD_BUF4_REG       0x00Fc
+
+#define SPSD2_SD_RSP_BUF0_3_REG     0x0100
+#define SPSD2_SD_RSP_BUF4_5_REG     0x0104
+
+#define SPSD2_DMA_SRCDST_REG        0x0204
+#define SPSD2_DMA_SIZE_REG          0x0208
+#define SPSD2_DMA_STOP_RST_REG      0x020c
+#define SPSD2_DMA_CTRL_REG          0x0210
+#define SPSD2_DMA_BASE_ADDR0_REG    0x0214
+#define SPSD2_DMA_BASE_ADDR16_REG   0x0218
+
+struct spsdc_tuning_info {
+	int need_tuning;
+#define SPSDC_MAX_RETRIES (8 * 8)
+	int retried; /* how many times has been retried */
+	u32 wr_dly:3;
+	u32 rd_dly:3;
+	u32 clk_dly:3;
+};
+
+struct spsdc_host {
+	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *rstc;
+	int mode; /* SD/SDIO/eMMC */
+	spinlock_t lock; /* controller lock */
+	struct mutex mrq_lock;
+	/* tasklet used to handle error then finish the request */
+	struct tasklet_struct tsklet_finish_req;
+	struct mmc_host *mmc;
+	struct mmc_request *mrq; /* current mrq */
+
+	int irq;
+	int use_int; /* should raise irq when done */
+	int power_state; /* current power state: off/up/on */
+
+
+#ifdef SPSDC_WIDTH_SWITCH
+	int restore_4bit_sdio_bus;
+#endif
+
+#define SPSDC_DMA_MODE 0
+#define SPSDC_PIO_MODE 1
+	int dmapio_mode;
+	/* for purpose of reducing context switch, only when transfer data that
+	 *  length is greater than `dma_int_threshold' should use interrupt
+	 */
+	int dma_int_threshold;
+	int dma_use_int; /* should raise irq when dma done */
+	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
+	struct spsdc_tuning_info tuning_info;
+};
+
+#endif /* #ifndef __SPSDC_H__ */
-- 
2.7.4

