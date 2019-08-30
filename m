Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63588A2CD3
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 04:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfH3CZo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 22:25:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38453 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfH3CZo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 22:25:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so2677235pga.5;
        Thu, 29 Aug 2019 19:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1DP6sVSTjUmv+v5aZNI0L/eUO/uKGvBLSqa/GLq1GE=;
        b=GLPGcoxHIcr+clm9fvV4dRSZbl59T+Gg45IoZa5QoEhqUSS6Zw07yB+3rhMJrS8fJs
         fHB975wiAahP6Ib4m2rvxR2i97fJjTQ0EpAslsdjHU6RfSa4lzY3nlc3k4nF7L4EihKk
         w+GHp5H/IiTBAJkudTYGW6MlUihb3ySLj6aD0qZxzQ3Od3t+g7myBilFHqei3abjLKJo
         JIjXFAkd/TW+AjcWLBWzktj0hGob1jcyy4upzKD+K+Z5Q/L1d+miwXKa+rGcaQSD2Y16
         DR7GWNxwfedLgqqS+Xf37ElQBvkj3DNNhAX8SIRuLmtEe7zX6dTW/j2LkVXwvG3j8q+s
         mKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1DP6sVSTjUmv+v5aZNI0L/eUO/uKGvBLSqa/GLq1GE=;
        b=cdcZdkcHYop/vCI/EqaaBhq0XopFUBdLntvYGXrbXOv1uQj8pYtoV2xyC8OVM3p3bh
         rQUEH+ESV0eiEH5WW7J6amS94/QyqNhbhiHyGYaJU26gHzz9v8n6vBr8mTnJQOQICObW
         Xj/3BsahdBrDTUsQha00shGVCiUQs+l/Tq1AkOhPLMBTtZprrhCXZ5nIB/LOnw97R5xw
         yzZWZr3qk+kPo+F1bjfGLFEFjQtXmRO2ryHL0f4Am4UdFAsodHZQKSM1Yk5fcgKd5+BL
         s7fM97F36tfpKFc/Tc9q9u4nW5B4zF/5rHT8ENIvPLaf5U20XZK5ZJni1rRt10Hz3lOh
         LW2A==
X-Gm-Message-State: APjAAAU8y3aYgkv3Fq0frsDD8q6ah+mu8WbBG7FS/+xkg7KBR6b3vOlB
        fo+S+uptljnEGwTXGJzusBc=
X-Google-Smtp-Source: APXvYqynaJfQM8mrD6jZnL4YLmTtRMMF653yGlI7oSzOsWU+uyTIwh+4fOc//wibKjtx3Fvgy8IZBQ==
X-Received: by 2002:a17:90a:358a:: with SMTP id r10mr13492072pjb.30.1567131943549;
        Thu, 29 Aug 2019 19:25:43 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id b18sm4915719pfi.160.2019.08.29.19.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:25:42 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
Date:   Fri, 30 Aug 2019 10:25:42 +0800
Message-Id: <20190830022542.8571-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add support for the GL9750 and GL9755 chipsets.

Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
tuning flow for GL9750.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
---
 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 350 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 5 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 931770f17087..9fbfff514d6c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
 	select IOSF_MBI if X86
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 73578718f119..661445415090 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
-				   sdhci-pci-dwc-mshc.o
+				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4154ee11b47d..e5835fbf73bc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1682,6 +1682,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
 	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
 	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
+	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
+	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
new file mode 100644
index 000000000000..ed87a32b4470
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Genesys Logic, Inc.
+ *
+ * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *
+ * Version: v0.9.0 (2019-08-08)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/pci.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
+#include "sdhci.h"
+#include "sdhci-pci.h"
+
+/*  Genesys Logic extra registers */
+#define SDHCI_GLI_9750_WT         0x800
+#define   SDHCI_GLI_9750_WT_EN      BIT(0)
+#define   GLI_9750_WT_EN_ON	    0x1
+#define   GLI_9750_WT_EN_OFF	    0x0
+
+#define SDHCI_GLI_9750_DRIVING      0x860
+#define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
+#define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
+#define   GLI_9750_DRIVING_1_VALUE    0xFFF
+#define   GLI_9750_DRIVING_2_VALUE    0x3
+
+#define SDHCI_GLI_9750_PLL	      0x864
+#define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
+#define   SDHCI_GLI_9750_PLL_TX2_DLY    GENMASK(22, 20)
+#define   GLI_9750_PLL_TX2_INV_VALUE    0x1
+#define   GLI_9750_PLL_TX2_DLY_VALUE    0x0
+
+#define SDHCI_GLI_9750_SW_CTRL      0x874
+#define   SDHCI_GLI_9750_SW_CTRL_4    GENMASK(7, 6)
+#define   GLI_9750_SW_CTRL_4_VALUE    0x3
+
+#define SDHCI_GLI_9750_MISC            0x878
+#define   SDHCI_GLI_9750_MISC_TX1_INV    BIT(2)
+#define   SDHCI_GLI_9750_MISC_RX_INV     BIT(3)
+#define   SDHCI_GLI_9750_MISC_TX1_DLY    GENMASK(6, 4)
+#define   GLI_9750_MISC_TX1_INV_VALUE    0x0
+#define   GLI_9750_MISC_RX_INV_ON        0x1
+#define   GLI_9750_MISC_RX_INV_OFF       0x0
+#define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
+#define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
+
+#define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
+#define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
+#define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
+#define   GLI_9750_TUNING_CONTROL_EN_OFF            0x0
+#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1    BIT(16)
+#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2    GENMASK(20, 19)
+#define   GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE    0x1
+#define   GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE    0x2
+
+#define SDHCI_GLI_9750_TUNING_PARAMETERS           0x544
+#define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
+#define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
+
+#define GLI_MAX_TUNING_LOOP 40
+
+/* Genesys Logic chipset */
+static inline void gl9750_wt_on(struct sdhci_host *host)
+{
+	u32 wt_value = 0;
+	u32 wt_enable = 0;
+
+	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
+
+	if (wt_enable == GLI_9750_WT_EN_ON)
+		return;
+
+	wt_value &= ~SDHCI_GLI_9750_WT_EN;
+	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_ON);
+
+	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+}
+
+static inline void gl9750_wt_off(struct sdhci_host *host)
+{
+	u32 wt_value = 0;
+	u32 wt_enable = 0;
+
+	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
+
+	if (wt_enable == GLI_9750_WT_EN_OFF)
+		return;
+
+	wt_value &= ~SDHCI_GLI_9750_WT_EN;
+	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_OFF);
+
+	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+}
+
+static void gli_set_9750(struct sdhci_host *host)
+{
+	u32 driving_value = 0;
+	u32 pll_value = 0;
+	u32 sw_ctrl_value = 0;
+	u32 misc_value = 0;
+	u32 parameter_value = 0;
+	u32 control_value = 0;
+
+	u16 ctrl2 = 0;
+
+	gl9750_wt_on(host);
+
+	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
+	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
+	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
+	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+	parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
+	control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	driving_value &= ~(SDHCI_GLI_9750_DRIVING_1);
+	driving_value &= ~(SDHCI_GLI_9750_DRIVING_2);
+	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_1,
+				    GLI_9750_DRIVING_1_VALUE);
+	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
+				    GLI_9750_DRIVING_2_VALUE);
+	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
+
+	sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
+	sw_ctrl_value |= FIELD_PREP(SDHCI_GLI_9750_SW_CTRL_4,
+				    GLI_9750_SW_CTRL_4_VALUE);
+	sdhci_writel(host, sw_ctrl_value, SDHCI_GLI_9750_SW_CTRL);
+
+	/* reset the tuning flow after reinit and before starting tuning */
+	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_INV;
+	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_DLY;
+	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_INV,
+				GLI_9750_PLL_TX2_INV_VALUE);
+	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_DLY,
+				GLI_9750_PLL_TX2_DLY_VALUE);
+
+	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_INV;
+	misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
+	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_DLY;
+	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_INV,
+				 GLI_9750_MISC_TX1_INV_VALUE);
+	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
+				 GLI_9750_MISC_RX_INV_VALUE);
+	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_DLY,
+				 GLI_9750_MISC_TX1_DLY_VALUE);
+
+	parameter_value &= ~SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY;
+	parameter_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY,
+				      GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE);
+
+	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1;
+	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2;
+	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1,
+				    GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE);
+	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2,
+				    GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE);
+
+	sdhci_writel(host, pll_value, SDHCI_GLI_9750_PLL);
+	sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+
+	/* disable tuned clk */
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	/* enable tuning parameters control */
+	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
+	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
+				    GLI_9750_TUNING_CONTROL_EN_ON);
+	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	/* write tuning parameters */
+	sdhci_writel(host, parameter_value, SDHCI_GLI_9750_TUNING_PARAMETERS);
+
+	/* disable tuning parameters control */
+	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
+	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
+				    GLI_9750_TUNING_CONTROL_EN_OFF);
+	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	/* clear tuned clk */
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	udelay(1);
+
+	gl9750_wt_off(host);
+}
+
+static void gli_set_9750_rx_inv(struct sdhci_host *host, bool b)
+{
+	u32 misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+
+	gl9750_wt_on(host);
+
+	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+	if (b) {
+		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
+		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
+					 GLI_9750_MISC_RX_INV_ON);
+		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+	} else {
+		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
+		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
+					 GLI_9750_MISC_RX_INV_OFF);
+		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+	}
+
+	gl9750_wt_off(host);
+}
+
+static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+	int rx_inv = 0;
+
+	for (rx_inv = 0; rx_inv < 2; rx_inv++) {
+		if (rx_inv & 0x1)
+			gli_set_9750_rx_inv(host, true);
+		else
+			gli_set_9750_rx_inv(host, false);
+
+		sdhci_start_tuning(host);
+
+		for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
+			u16 ctrl;
+
+			sdhci_send_tuning(host, opcode);
+
+			if (!host->tuning_done) {
+				if (rx_inv == 1) {
+					pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
+						mmc_hostname(host->mmc));
+					sdhci_abort_tuning(host, opcode);
+					return -ETIMEDOUT;
+				}
+				sdhci_abort_tuning(host, opcode);
+				break;
+			}
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+				if (ctrl & SDHCI_CTRL_TUNED_CLK)
+					return 0; /* Success! */
+				break;
+			}
+		}
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+	return -EAGAIN;
+}
+
+static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	host->mmc->retune_period = 0;
+	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		host->mmc->retune_period = host->tuning_count;
+
+	gli_set_9750(host);
+	host->tuning_err = __sdhci_execute_tuning_9750(host, opcode);
+	sdhci_end_tuning(host);
+
+	return 0;
+}
+
+static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+
+	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
+static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+
+	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
+static void sdhci_gli_voltage_switch(struct sdhci_host *host)
+{
+	usleep_range(5000, 5500);
+}
+
+static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+	gli_set_9750(host);
+}
+
+static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
+{
+	u32 value;
+
+	value = readl(host->ioaddr + reg);
+	if (unlikely(reg == SDHCI_MAX_CURRENT)) {
+		if (!(value & 0xff))
+			value |= 0xc8;
+	}
+	return value;
+}
+
+static const struct sdhci_ops sdhci_gl9755_ops = {
+	.set_clock		= sdhci_set_clock,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.voltage_switch		= sdhci_gli_voltage_switch,
+};
+
+const struct sdhci_pci_fixes sdhci_gl9755 = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
+	.probe_slot	= gli_probe_slot_gl9755,
+	.ops            = &sdhci_gl9755_ops,
+};
+
+static const struct sdhci_ops sdhci_gl9750_ops = {
+	.read_l                 = sdhci_gl9750_readl,
+	.set_clock		= sdhci_set_clock,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_gl9750_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.voltage_switch		= sdhci_gli_voltage_switch,
+	.platform_execute_tuning = gl9750_execute_tuning,
+};
+
+const struct sdhci_pci_fixes sdhci_gl9750 = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
+	.probe_slot	= gli_probe_slot_gl9750,
+	.ops            = &sdhci_gl9750_ops,
+};
+
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e5dc6e44c7a4..738ba5afcc20 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -65,6 +65,9 @@
 
 #define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
 
+#define PCI_DEVICE_ID_GLI_9755		0x9755
+#define PCI_DEVICE_ID_GLI_9750		0x9750
+
 /*
  * PCI device class and mask
  */
@@ -185,5 +188,7 @@ int sdhci_pci_enable_dma(struct sdhci_host *host);
 extern const struct sdhci_pci_fixes sdhci_arasan;
 extern const struct sdhci_pci_fixes sdhci_snps;
 extern const struct sdhci_pci_fixes sdhci_o2;
+extern const struct sdhci_pci_fixes sdhci_gl9750;
+extern const struct sdhci_pci_fixes sdhci_gl9755;
 
 #endif /* __SDHCI_PCI_H */
-- 
2.22.1

