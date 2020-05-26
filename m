Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA11C21B8
	for <lists+linux-mmc@lfdr.de>; Sat,  2 May 2020 01:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAXyj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 1 May 2020 19:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgEAXyi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2020 19:54:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81EC08E859
        for <linux-mmc@vger.kernel.org>; Fri,  1 May 2020 16:54:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so2966245wrn.6
        for <linux-mmc@vger.kernel.org>; Fri, 01 May 2020 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfX7XotTRbRZpU8qW6O6HOsTohRIT4UKSMXcugy5qWQ=;
        b=Qa4iw/LxlEN1ZQnw94k6aygbsApt+5oy2zEsvEzWejoMJNJ9l/UIonwrbDpk52dq4X
         M+uiSqfm6eeRvJCBEyzW6CPIQfP/POj1nB88vHeytjBuj3bAazfJNqzILZ320QZbB004
         aYWiGab+wotQT1bhL5a//q9f4U8OnGFsOd4F1ZPx5u2jSPbwNKRVaOR3PChuiyDOuDWW
         OpRUeBozviksY1asD3uiZdJqej9XW+MgJtg/kQMXefRUkeolJhXFn4m7a/7712Iuxq2G
         +5br+V4N2vn/DcZ3PN7yfHNILvunt9ceRgcJLhA5T/nnkdhgpqGukTFW6EW9rBa6lnQy
         HhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfX7XotTRbRZpU8qW6O6HOsTohRIT4UKSMXcugy5qWQ=;
        b=Eqh8bo+J1i9Mu+XkXTB2bmVJviH+AykCT5wYzaNm0i6tincLFglsLcYgAwP8p+NPxm
         YIameqUqqwQ485MAE6QPP0OjygBK7J8gRiij7TCVdi+6/pqxv5vUgh31PT0puo1ie8mv
         fC7D2GtffJMU8INJqT70LvE1PHco5iAoMUn/pssWouZ4S6hz+E2CrnfcISxmvRXA3sNI
         FlGyW1nQGYIiI84Ji5N3PZPz/SLQShsKXBQZPdAuZFQK2sSgHWQ1DFAmNMvtQb4tt+eo
         Spt187AX8zh033g9vVqIgNvz+fMUbCoAH+ERMJAUmPKMm5UajN5BPpYzGEKH9HKpnADM
         K41A==
X-Gm-Message-State: AGi0PuZTE2EGQp2Hkw3lk1zWjqVOQkqZXI16aR1q728rQeC/JP5C5kgP
        QF+Nqfu+ZDP4hftfLCAdVS1fPg==
X-Google-Smtp-Source: APiQypLhq5mv4xFO/++RArfBBACcwgbhkakj7lSQllPofKe/pwiueZnYbdKvFLg7UaQdrc13Nrd52A==
X-Received: by 2002:adf:f282:: with SMTP id k2mr6172310wro.133.1588377276656;
        Fri, 01 May 2020 16:54:36 -0700 (PDT)
Received: from localhost.localdomain (host142-13-dynamic.2-87-r.retail.telecomitalia.it. [87.2.13.142])
        by smtp.gmail.com with ESMTPSA id r20sm1495155wmh.26.2020.05.01.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:54:35 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc controller
Date:   Sat,  2 May 2020 01:59:05 +0200
Message-Id: <20200501235907.3978-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for sdhci-edshc mmc controller.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
Changes for v3:
- removed volatile cast from clk.c
---
 arch/m68k/coldfire/clk.c                    | 15 ++++++++++
 arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
 arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
 arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
 arch/m68k/include/asm/mcfclk.h              |  2 ++
 include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
 6 files changed, 95 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 7bc666e482eb..8d048a72e173 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
 #endif /* MCFPM_PPMCR1 */
 #endif /* MCFPM_PPMCR0 */
 
+static void __clk_enable2(struct clk *clk)
+{
+	__set_bit(clk->slot, MCFSDHC_CLK);
+}
+
+static void __clk_disable2(struct clk *clk)
+{
+	__clear_bit(clk->slot, MCFSDHC_CLK);
+}
+
+struct clk_ops clk_ops2 = {
+	.enable		= __clk_enable2,
+	.disable	= __clk_disable2,
+};
+
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index b4103b6bfdeb..9ef4ec0aea00 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -22,6 +22,7 @@
 #include <asm/mcfqspi.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/dma-mcf-edma.h>
+#include <linux/platform_data/mmc-esdhc-mcf.h>
 
 /*
  *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
@@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
 		.platform_data = &mcf_edma_data,
 	}
 };
-
 #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
 
+#if IS_ENABLED(CONFIG_MMC)
+static struct mcf_esdhc_platform_data mcf_esdhc_data = {
+	.max_bus_width = 4,
+	.cd_type = ESDHC_CD_NONE,
+};
+
+static struct resource mcf_esdhc_resources[] = {
+	{
+		.start = MCFSDHC_BASE,
+		.end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = MCF_IRQ_SDHC,
+		.end = MCF_IRQ_SDHC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mcf_esdhc = {
+	.name			= "sdhci-esdhc-mcf",
+	.id			= 0,
+	.num_resources		= ARRAY_SIZE(mcf_esdhc_resources),
+	.resource		= mcf_esdhc_resources,
+	.dev.platform_data	= &mcf_esdhc_data,
+};
+#endif /* IS_ENABLED(CONFIG_MMC) */
+
 static struct platform_device *mcf_devices[] __initdata = {
 	&mcf_uart,
 #if IS_ENABLED(CONFIG_FEC)
@@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
 #if IS_ENABLED(CONFIG_MCF_EDMA)
 	&mcf_edma,
 #endif
+#if IS_ENABLED(CONFIG_MMC)
+	&mcf_esdhc,
+#endif
 };
 
 /*
@@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
 }
 
 arch_initcall(mcf_init_devices);
-
diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 5bd24c9b865d..ffa02de1a3fb 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
 DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
 DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
 DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
-DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
+DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
 DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
 DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
 DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
@@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
 DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
 DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
 
+DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
+DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
+DEFINE_CLK(2, "per.0", 2, MCF_CLK);
+
 struct clk *mcf_clks[] = {
 	&__clk_0_2,
 	&__clk_0_8,
@@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
 	&__clk_1_34,
 	&__clk_1_36,
 	&__clk_1_37,
+
+	&__clk_2_0,
+	&__clk_2_1,
+	&__clk_2_2,
+
 	NULL,
 };
 
@@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
 	&__clk_0_33, /* pit.1 */
 	&__clk_0_37, /* eport */
 	&__clk_0_48, /* pll */
+	&__clk_0_51, /* esdhc */
 
 	&__clk_1_36, /* CCM/reset module/Power management */
 	&__clk_1_37, /* gpio */
diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index 4892f314ff38..750555a6fa87 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -278,6 +278,17 @@
 #define MCFGPIO_IRQ_VECBASE	(MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
 #define MCFGPIO_PIN_MAX		87
 
+/*********************************************************************
+ *
+ * Phase Locked Loop (PLL)
+ *
+ *********************************************************************/
+
+/* Register read/write macros */
+#define MCF_PLL_CR		0xFC0C0000
+#define MCF_PLL_DR		0xFC0C0004
+#define MCF_PLL_SR		0xFC0C0008
+
 /*
  *  DSPI module.
  */
@@ -298,5 +309,13 @@
 #define MCFEDMA_IRQ_INTR16	(MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
 #define MCFEDMA_IRQ_INTR56	(MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
 #define MCFEDMA_IRQ_ERR	(MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
+/*
+ *  esdhc module.
+ */
+#define MCFSDHC_BASE		0xfc0cc000
+#define MCFSDHC_SIZE		256
+#define MCFINT2_SDHC		31
+#define MCF_IRQ_SDHC		(MCFINT2_VECBASE + MCFINT2_SDHC)
+#define MCFSDHC_CLK		(MCFSDHC_BASE + 0x2c)
 
 #endif /* m5441xsim_h */
diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
index 0aca504fae31..722627e06d66 100644
--- a/arch/m68k/include/asm/mcfclk.h
+++ b/arch/m68k/include/asm/mcfclk.h
@@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
 extern struct clk_ops clk_ops1;
 #endif /* MCFPM_PPMCR1 */
 
+extern struct clk_ops clk_ops2;
+
 #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
 static struct clk __clk_##clk_bank##_##clk_slot = { \
 	.name = clk_name, \
diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
new file mode 100644
index 000000000000..85cb786a62fe
--- /dev/null
+++ b/include/linux/platform_data/mmc-esdhc-mcf.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
+#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
+	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
+struct mcf_esdhc_platform_data {
+	int max_bus_width;
+	int cd_type;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
-- 
2.26.0

