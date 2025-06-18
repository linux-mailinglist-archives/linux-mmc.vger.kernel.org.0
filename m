Return-Path: <linux-mmc+bounces-7106-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807EADE52F
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Jun 2025 10:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CF83B4CDE
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Jun 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CE27EFF1;
	Wed, 18 Jun 2025 08:08:03 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185923504B
	for <linux-mmc@vger.kernel.org>; Wed, 18 Jun 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234083; cv=none; b=dD4ZObe7T6EpR5k2RLoeRkKo4nDF+N/uJ8KXKYCsCR5QOHG5cW3yW9/6pEQgpTpuabIlRS2ngk1Io242KY4wsy4qkogNpycU5aTKv1epu9nIdluMJsD8a8aznJl8c4+gMX89WASQ6az+7NAGEdOkmCRbXrWwgLDiyPtVbC8aFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234083; c=relaxed/simple;
	bh=uyEoAZSJNJ6VKLv5M2j+b99HxVRmgJTYF2Ke1pY4j50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyrvI01VMMPRPnUi9rsItRu+8ADWhQPTlgCEfj23qfFF/BKQdCI6gNbN7cSPgFU9zzPT5yFXzOx/ZTCQdq7AxIQUiZWf+uqMGDnX9wllgybgTukhnihxIbt8Ev6I1YNjtWFIPYCn4E2VgwYMns89OUryDkdOBZXS34w1VST1kkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8DxbKzac1JoZfsYAQ--.57619S3;
	Wed, 18 Jun 2025 16:07:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMDxH+XIc1JoikkfAQ--.28608S4;
	Wed, 18 Jun 2025 16:07:48 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	wanghongliang@loongson.cn,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
Date: Wed, 18 Jun 2025 16:07:26 +0800
Message-ID: <abfe54473135df478db14b5ef0e1773326455f21.1750216134.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750216134.git.zhoubinbin@loongson.cn>
References: <cover.1750216134.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxH+XIc1JoikkfAQ--.28608S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfZF1DWw15tw17ur1DXw1rKrX_yoW5Wr48Co
	WfuF1fZw4rJw18Z3yrCryfJFW8Zay8Z34DAw4fCrWDZFyDGw1DKFWDtF43ury3Jry5Kr43
	CFZ3tFWfta92yryUl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY67kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUZVWUtwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1xpnPUUUUU==

The MMC controllers on the Loongson-2K series CPUs are similar,
except for the interface characteristics and the use of DMA controllers.

This patch describes the MMC controllers on the Loongson-2K0500/2K1000,
with the distinguishing feature being the use of an externally shared
APBDMA engine.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                      |   1 +
 drivers/mmc/host/Kconfig         |  13 +
 drivers/mmc/host/Makefile        |   1 +
 drivers/mmc/host/loongson2-mmc.c | 820 +++++++++++++++++++++++++++++++
 4 files changed, 835 insertions(+)
 create mode 100644 drivers/mmc/host/loongson2-mmc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d1cdd2cfc2b..4a4892613c66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14180,6 +14180,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
+F:	drivers/mmc/host/loongson2-mmc.c
 
 LOONGSON-2 SOC SERIES PM DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c3f0f41a426d..7232de1c0688 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1111,6 +1111,19 @@ config MMC_OWL
 	  This selects support for the SD/MMC Host Controller on
 	  Actions Semi Owl SoCs.
 
+config MMC_LOONGSON2
+	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
+	depends on LOONGARCH || COMPILE_TEST
+	depends on HAS_DMA
+	help
+	  This selects support for the SD/SDIO/eMMC Host Controller on
+	  Loongson-2K series CPUs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mmc_loongson2.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_EXTERNAL_DMA
 	bool
 
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 75bafc7b162b..5057fea8afb6 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_MMC_USDHI6ROL0)	+= usdhi6rol0.o
 obj-$(CONFIG_MMC_TOSHIBA_PCI)	+= toshsd.o
 obj-$(CONFIG_MMC_BCM2835)	+= bcm2835.o
 obj-$(CONFIG_MMC_OWL)		+= owl-mmc.o
+obj-$(CONFIG_MMC_LOONGSON2)	+= loongson2-mmc.o
 
 obj-$(CONFIG_MMC_REALTEK_PCI)	+= rtsx_pci_sdmmc.o
 obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
new file mode 100644
index 000000000000..872f5dc21b21
--- /dev/null
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Loongson-2K MMC/SDIO controller driver
+ *
+ * Copyright (C) 2018-2025 Loongson Technology Corporation Limited.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitrev.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define LOONGSON2_MMC_REG_CTL		0x00 /* Control Register */
+#define LOONGSON2_MMC_REG_PRE		0x04 /* Prescaler Register */
+#define LOONGSON2_MMC_REG_CARG		0x08 /* Command Register */
+#define LOONGSON2_MMC_REG_CCTL		0x0c /* Command Control Register */
+#define LOONGSON2_MMC_REG_CSTS		0x10 /* Command Status Register */
+#define LOONGSON2_MMC_REG_RSP0		0x14 /* Command Response Register 0 */
+#define LOONGSON2_MMC_REG_RSP1		0x18 /* Command Response Register 1 */
+#define LOONGSON2_MMC_REG_RSP2		0x1c /* Command Response Register 2 */
+#define LOONGSON2_MMC_REG_RSP3		0x20 /* Command Response Register 3 */
+#define LOONGSON2_MMC_REG_TIMER		0x24 /* Data Timeout Register */
+#define LOONGSON2_MMC_REG_BSIZE		0x28 /* Block Size Register */
+#define LOONGSON2_MMC_REG_DCTL		0x2c /* Data Control Register */
+#define LOONGSON2_MMC_REG_DCNT		0x30 /* Data Counter Register */
+#define LOONGSON2_MMC_REG_DSTS		0x34 /* Data Status Register */
+#define LOONGSON2_MMC_REG_FSTS		0x38 /* FIFO Status Register */
+#define LOONGSON2_MMC_REG_INT		0x3c /* Interrupt Register */
+#define LOONGSON2_MMC_REG_DATA		0x40 /* Data Register */
+#define LOONGSON2_MMC_REG_IEN		0x64 /* Interrupt Enable Register */
+
+/* Bitfields of control register */
+#define LOONGSON2_MMC_CTL_ENCLK		BIT(0)
+#define LOONGSON2_MMC_CTL_EXTCLK	BIT(1)
+#define LOONGSON2_MMC_CTL_RESET		BIT(8)
+
+/* Bitfields of prescaler register */
+#define LOONGSON2_MMC_PRE		GENMASK(9, 0)
+#define LOONGSON2_MMC_PRE_EN		BIT(31)
+
+/* Bitfields of command control register */
+#define LOONGSON2_MMC_CCTL_INDEX	GENMASK(5, 0)
+#define LOONGSON2_MMC_CCTL_HOST		BIT(6)
+#define LOONGSON2_MMC_CCTL_START	BIT(8)
+#define LOONGSON2_MMC_CCTL_WAIT_RSP	BIT(9)
+#define LOONGSON2_MMC_CCTL_LONG_RSP	BIT(10)
+#define LOONGSON2_MMC_CCTL_ABORT	BIT(12)
+#define LOONGSON2_MMC_CCTL_CHECK	BIT(13)
+#define LOONGSON2_MMC_CCTL_SDIO		BIT(14)
+#define LOONGSON2_MMC_CCTL_CMD6		BIT(18)
+
+/* Bitfields of command status register */
+#define LOONGSON2_MMC_CSTS_INDEX	GENMASK(7, 0)
+#define LOONGSON2_MMC_CSTS_ON		BIT(8)
+#define LOONGSON2_MMC_CSTS_RSP		BIT(9)
+#define LOONGSON2_MMC_CSTS_TIMEOUT	BIT(10)
+#define LOONGSON2_MMC_CSTS_END		BIT(11)
+#define LOONGSON2_MMC_CSTS_CRC_ERR	BIT(12)
+#define LOONGSON2_MMC_CSTS_AUTO_STOP	BIT(13)
+#define LOONGSON2_MMC_CSTS_FIN		BIT(14)
+
+/* Bitfields of data timeout register */
+#define LOONGSON2_MMC_DTIMR		GENMASK(23, 0)
+
+/* Bitfields of block size register */
+#define LOONGSON2_MMC_BSIZE		GENMASK(11, 0)
+
+/* Bitfields of data control register */
+#define LOONGSON2_MMC_DCTL_BNUM		GENMASK(11, 0)
+#define LOONGSON2_MMC_DCTL_START	BIT(14)
+#define LOONGSON2_MMC_DCTL_ENDMA	BIT(15)
+#define LOONGSON2_MMC_DCTL_WIDE		BIT(16)
+#define LOONGSON2_MMC_DCTL_RWAIT	BIT(17)
+#define LOONGSON2_MMC_DCTL_IO_SUSPEND	BIT(18)
+#define LOONGSON2_MMC_DCTL_IO_RESUME	BIT(19)
+#define LOONGSON2_MMC_DCTL_RW_RESUME	BIT(20)
+#define LOONGSON2_MMC_DCTL_8BIT_BUS	BIT(26)
+
+/* Bitfields of sata counter register */
+#define LOONGSON2_MMC_DCNT_BNUM		GENMASK(11, 0)
+#define LOONGSON2_MMC_DCNT_BYTE		GENMASK(23, 12)
+
+/* Bitfields of command status register */
+#define LOONGSON2_MMC_DSTS_RXON		BIT(0)
+#define LOONGSON2_MMC_DSTS_TXON		BIT(1)
+#define LOONGSON2_MMC_DSTS_SBITERR	BIT(2)
+#define LOONGSON2_MMC_DSTS_BUSYFIN	BIT(3)
+#define LOONGSON2_MMC_DSTS_XFERFIN	BIT(4)
+#define LOONGSON2_MMC_DSTS_DTIMEOUT	BIT(5)
+#define LOONGSON2_MMC_DSTS_RXCRC	BIT(6)
+#define LOONGSON2_MMC_DSTS_TXCRC	BIT(7)
+#define LOONGSON2_MMC_DSTS_IRQ		BIT(8)
+#define LOONGSON2_MMC_DSTS_START	BIT(13)
+#define LOONGSON2_MMC_DSTS_RESUME	BIT(15)
+#define LOONGSON2_MMC_DSTS_SUSPEND	BIT(16)
+
+/* Bitfields of interrupt register */
+#define LOONGSON2_MMC_INT_DFIN		BIT(0)
+#define LOONGSON2_MMC_INT_DTIMEOUT	BIT(1)
+#define LOONGSON2_MMC_INT_RXCRC		BIT(2)
+#define LOONGSON2_MMC_INT_TXCRC		BIT(3)
+#define LOONGSON2_MMC_INT_PROGERR	BIT(4)
+#define LOONGSON2_MMC_INT_SDIOIRQ	BIT(5)
+#define LOONGSON2_MMC_INT_CSENT		BIT(6)
+#define LOONGSON2_MMC_INT_CTIMEOUT	BIT(7)
+#define LOONGSON2_MMC_INT_RESPCRC	BIT(8)
+#define LOONGSON2_MMC_INT_BUSYEND	BIT(9)
+
+/* Bitfields of interrupt enable register */
+#define LOONGSON2_MMC_IEN_DFIN		BIT(0)
+#define LOONGSON2_MMC_IEN_DTIMEOUT	BIT(1)
+#define LOONGSON2_MMC_IEN_RXCRC		BIT(2)
+#define LOONGSON2_MMC_IEN_TXCRC		BIT(3)
+#define LOONGSON2_MMC_IEN_PROGERR	BIT(4)
+#define LOONGSON2_MMC_IEN_SDIOIRQ	BIT(5)
+#define LOONGSON2_MMC_IEN_CSENT		BIT(6)
+#define LOONGSON2_MMC_IEN_CTIMEOUT	BIT(7)
+#define LOONGSON2_MMC_IEN_RESPCRC	BIT(8)
+#define LOONGSON2_MMC_IEN_BUSYEND	BIT(9)
+
+#define LOONGSON2_MMC_IEN_ALL		GENMASK(9, 0)
+#define LOONGSON2_MMC_INT_CLEAR		GENMASK(9, 0)
+
+/* Loongson-2K1000 SDIO2 DMA routing register */
+#define LS2K1000_SDIO_DMA_MASK		GENMASK(17, 15)
+#define LS2K1000_DMA0_CONF		0x0
+#define LS2K1000_DMA1_CONF		0x1
+#define LS2K1000_DMA2_CONF		0x2
+#define LS2K1000_DMA3_CONF		0x3
+#define LS2K1000_DMA4_CONF		0x4
+
+/* Loongson-2K0500 SDIO2 DMA routing register */
+#define LS2K0500_SDIO_DMA_MASK		GENMASK(15, 14)
+#define LS2K0500_DMA0_CONF		0x1
+#define LS2K0500_DMA1_CONF		0x2
+#define LS2K0500_DMA2_CONF		0x3
+
+enum loongson2_mmc_state {
+	STATE_NONE,
+	STATE_FINALIZE,
+	STATE_CMDSENT,
+	STATE_RSPFIN,
+	STATE_XFERFINISH,
+	STATE_XFERFINISH_RSPFIN,
+};
+
+struct loongson2_dma_desc {
+	u32 ndesc_addr;
+	u32 mem_addr;
+	u32 apb_addr;
+	u32 len;
+	u32 step_len;
+	u32 step_times;
+	u32 cmd;
+	u32 stats;
+	u32 high_ndesc_addr;
+	u32 high_mem_addr;
+	u32 reserved[2];
+} __packed;
+
+struct loongson2_mmc_host {
+	struct device *dev;
+	struct mmc_request *mrq;
+	struct regmap *regmap;
+	struct resource *res;
+	struct clk *clk;
+	u64 rate;
+	int dma_complete;
+	struct dma_chan *chan;
+	int cmd_is_stop;
+	int bus_width;
+	spinlock_t lock; /* Prevent races with irq handler */
+	enum loongson2_mmc_state state;
+	const struct loongson2_mmc_pdata *pdata;
+};
+
+struct loongson2_mmc_pdata {
+	const struct regmap_config *regmap_config;
+	void (*reorder_cmd_data)(struct loongson2_mmc_host *host, struct mmc_command *cmd);
+	int (*setting_dma)(struct loongson2_mmc_host *host, struct platform_device *pdev);
+	int (*prepare_dma)(struct loongson2_mmc_host *host, struct mmc_data *data);
+	void (*release_dma)(struct loongson2_mmc_host *host, struct device *dev);
+};
+
+static void loongson2_mmc_send_command(struct loongson2_mmc_host *host,
+				       struct mmc_command *cmd)
+{
+	u32 cctrl;
+
+	if (cmd->data)
+		host->state = STATE_XFERFINISH_RSPFIN;
+	else if (cmd->flags & MMC_RSP_PRESENT)
+		host->state = STATE_RSPFIN;
+	else
+		host->state = STATE_CMDSENT;
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_CARG, cmd->arg);
+
+	cctrl = FIELD_PREP(LOONGSON2_MMC_CCTL_INDEX, cmd->opcode);
+	cctrl |= LOONGSON2_MMC_CCTL_HOST | LOONGSON2_MMC_CCTL_START;
+
+	if (cmd->opcode == SD_SWITCH && cmd->data)
+		cctrl |= LOONGSON2_MMC_CCTL_CMD6;
+
+	if (cmd->flags & MMC_RSP_PRESENT)
+		cctrl |= LOONGSON2_MMC_CCTL_WAIT_RSP;
+
+	if (cmd->flags & MMC_RSP_136)
+		cctrl |= LOONGSON2_MMC_CCTL_LONG_RSP;
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_CCTL, cctrl);
+}
+
+static int loongson2_mmc_setup_data(struct loongson2_mmc_host *host,
+				    struct mmc_data *data)
+{
+	u32 dctrl;
+
+	if ((data->blksz & 3) != 0)
+		return -EINVAL;
+
+	dctrl = FIELD_PREP(LOONGSON2_MMC_DCTL_BNUM, data->blocks);
+	dctrl |= LOONGSON2_MMC_DCTL_START | LOONGSON2_MMC_DCTL_ENDMA;
+
+	if (host->bus_width == MMC_BUS_WIDTH_4)
+		dctrl |= LOONGSON2_MMC_DCTL_WIDE;
+	else if (host->bus_width == MMC_BUS_WIDTH_8)
+		dctrl |= LOONGSON2_MMC_DCTL_8BIT_BUS;
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_DCTL, dctrl);
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_BSIZE, data->blksz);
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_TIMER, U32_MAX);
+
+	return 0;
+}
+
+static int loongson2_mmc_prepare_dma(struct loongson2_mmc_host *host,
+				     struct mmc_data *data)
+{
+	int ret;
+
+	if (!data)
+		return 0;
+
+	ret = loongson2_mmc_setup_data(host, data);
+	if (ret)
+		return ret;
+
+	host->dma_complete = 0;
+
+	return host->pdata->prepare_dma(host, data);
+}
+
+static void loongson2_mmc_send_request(struct mmc_host *mmc)
+{
+	int ret;
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
+
+	ret = loongson2_mmc_prepare_dma(host, cmd->data);
+	if (ret) {
+		dev_err(host->dev, "DMA data prepared failed with %d\n", ret);
+		cmd->error = ret;
+		cmd->data->error = ret;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
+	loongson2_mmc_send_command(host, cmd);
+
+	/* Fix deselect card */
+	if (cmd->opcode == MMC_SELECT_CARD && cmd->arg == 0) {
+		cmd->error = 0;
+		mmc_request_done(mmc, mrq);
+	}
+}
+
+static irqreturn_t loongson2_mmc_irq_worker(int irq, void *devid)
+{
+	struct loongson2_mmc_host *host = (struct loongson2_mmc_host *)devid;
+	struct mmc_host *mmc = mmc_from_priv(host);
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
+
+	if (cmd->data)
+		dma_unmap_sg(mmc_dev(mmc), cmd->data->sg, cmd->data->sg_len,
+			     mmc_get_dma_dir(cmd->data));
+
+	if (cmd->data && !cmd->error &&
+	    !cmd->data->error && !host->dma_complete)
+		return IRQ_HANDLED;
+
+	/* Read response from controller. */
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP0, &cmd->resp[0]);
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP1, &cmd->resp[1]);
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP2, &cmd->resp[2]);
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP3, &cmd->resp[3]);
+
+	/* Cleanup controller */
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_CARG, 0);
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_CCTL, 0);
+
+	if (cmd->data && cmd->error)
+		cmd->data->error = cmd->error;
+
+	if (cmd->data && cmd->data->stop && !host->cmd_is_stop) {
+		host->cmd_is_stop = 1;
+		loongson2_mmc_send_request(mmc);
+		return IRQ_HANDLED;
+	}
+
+	/* If we have no data transfer we are finished here */
+	if (!mrq->data)
+		goto request_done;
+
+	/* Calculate the amount of bytes transfer if there was no error */
+	if (mrq->data->error == 0) {
+		mrq->data->bytes_xfered =
+			(mrq->data->blocks * mrq->data->blksz);
+	} else {
+		mrq->data->bytes_xfered = 0;
+	}
+
+request_done:
+	host->state = STATE_NONE;
+	host->mrq = NULL;
+	mmc_request_done(mmc, mrq);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
+{
+	struct loongson2_mmc_host *host = (struct loongson2_mmc_host *)devid;
+	struct mmc_host *mmc = mmc_from_priv(host);
+	struct mmc_command *cmd;
+	unsigned long iflags;
+	u32 dsts, imsk;
+
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_INT, &imsk);
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_DSTS, &dsts);
+
+	if ((dsts & LOONGSON2_MMC_DSTS_IRQ) &&
+	    (imsk & LOONGSON2_MMC_INT_SDIOIRQ)) {
+		regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_INT,
+				   LOONGSON2_MMC_INT_SDIOIRQ,
+				   LOONGSON2_MMC_INT_SDIOIRQ);
+
+		sdio_signal_irq(mmc);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock_irqsave(&host->lock, iflags);
+
+	if (host->state == STATE_NONE || host->state == STATE_FINALIZE ||
+	    !host->mrq)
+		goto irq_out;
+
+	cmd = host->cmd_is_stop ? host->mrq->stop : host->mrq->cmd;
+	if (!cmd)
+		goto irq_out;
+
+	cmd->error = 0;
+
+	if (imsk & LOONGSON2_MMC_INT_CTIMEOUT) {
+		cmd->error = -ETIMEDOUT;
+		goto close_transfer;
+	}
+
+	if (imsk & LOONGSON2_MMC_INT_CSENT) {
+		if (host->state == STATE_RSPFIN || host->state == STATE_CMDSENT)
+			goto close_transfer;
+
+		if (host->state == STATE_XFERFINISH_RSPFIN)
+			host->state = STATE_XFERFINISH;
+	}
+
+	if (!cmd->data)
+		goto irq_out;
+
+	if (imsk & (LOONGSON2_MMC_INT_RXCRC | LOONGSON2_MMC_INT_TXCRC)) {
+		cmd->data->error = -EILSEQ;
+		goto close_transfer;
+	}
+
+	if (imsk & LOONGSON2_MMC_INT_DTIMEOUT) {
+		cmd->data->error = -ETIMEDOUT;
+		goto close_transfer;
+	}
+
+	if (imsk & LOONGSON2_MMC_INT_DFIN) {
+		if (host->state == STATE_XFERFINISH) {
+			host->dma_complete = 1;
+			goto close_transfer;
+		}
+
+		if (host->state == STATE_XFERFINISH_RSPFIN)
+			host->state = STATE_RSPFIN;
+	}
+
+irq_out:
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
+	spin_unlock_irqrestore(&host->lock, iflags);
+	return IRQ_HANDLED;
+
+close_transfer:
+	host->state = STATE_FINALIZE;
+	host->pdata->reorder_cmd_data(host, cmd);
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
+	spin_unlock_irqrestore(&host->lock, iflags);
+	return IRQ_WAKE_THREAD;
+}
+
+static void loongson2_mmc_set_clk(struct loongson2_mmc_host *host, struct mmc_ios *ios)
+{
+	u32 pre;
+
+	pre = DIV_ROUND_UP(host->rate, ios->clock);
+	if (pre > 255)
+		pre = 255;
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_PRE, pre | LOONGSON2_MMC_PRE_EN);
+
+	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
+			   LOONGSON2_MMC_CTL_ENCLK, LOONGSON2_MMC_CTL_ENCLK);
+}
+
+static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	if (ios->power_mode == MMC_POWER_UP) {
+		if (!IS_ERR(mmc->supply.vmmc)) {
+			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+			if (ret) {
+				dev_err(host->dev, "failed to enable vmmc regulator\n");
+				/*return, if failed turn on vmmc*/
+				return;
+			}
+		}
+		regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSON2_MMC_CTL_RESET);
+		mdelay(10);
+		regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSON2_MMC_CTL_EXTCLK);
+		regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, LOONGSON2_MMC_IEN_ALL);
+		regmap_write(host->regmap, LOONGSON2_MMC_REG_IEN, LOONGSON2_MMC_INT_CLEAR);
+	} else if (ios->power_mode == MMC_POWER_OFF) {
+		regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
+				   LOONGSON2_MMC_CTL_RESET, LOONGSON2_MMC_CTL_RESET);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		return;
+	}
+
+	loongson2_mmc_set_clk(host, ios);
+
+	host->bus_width = ios->bus_width;
+}
+
+static void loongson2_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+
+	host->cmd_is_stop = 0;
+	host->mrq = mrq;
+	loongson2_mmc_send_request(mmc);
+}
+
+static void loongson2_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+
+	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_IEN,
+			   LOONGSON2_MMC_INT_SDIOIRQ, enable);
+}
+
+static void loongson2_mmc_ack_sdio_irq(struct mmc_host *mmc)
+{
+	loongson2_mmc_enable_sdio_irq(mmc, 1);
+}
+
+static struct mmc_host_ops loongson2_mmc_ops = {
+	.request	= loongson2_mmc_request,
+	.set_ios	= loongson2_mmc_set_ios,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
+	.enable_sdio_irq = loongson2_mmc_enable_sdio_irq,
+	.ack_sdio_irq	= loongson2_mmc_ack_sdio_irq,
+};
+
+static const struct regmap_config ls2k1000_mmc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = LOONGSON2_MMC_REG_IEN,
+};
+
+static int loongson2_reorder_cmd_list[] = { SD_APP_SEND_SCR, SD_APP_SEND_NUM_WR_BLKS,
+					    SD_APP_SD_STATUS, MMC_SEND_WRITE_PROT,
+					    SD_SWITCH };
+
+/*
+ * According to SD spec, ACMD13, ACMD22, ACMD51 and CMD30
+ * response datas has different byte order with usual data packets.
+ * However sdio controller will send these datas in usual data format,
+ * so we need to adjust these datas to a protocol consistent byte order.
+ */
+static void loongson2_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
+					   struct mmc_command *cmd)
+{
+	struct scatterlist *sg;
+	u32 *data;
+	int i, j;
+
+	if (mmc_cmd_type(cmd) != MMC_CMD_ADTC)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(loongson2_reorder_cmd_list); i++)
+		if (cmd->opcode == loongson2_reorder_cmd_list[i])
+			break;
+
+	if (i == ARRAY_SIZE(loongson2_reorder_cmd_list))
+		return;
+
+	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
+		data = sg_virt(&sg[i]);
+		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+			if (cmd->opcode == SD_SWITCH)
+				data[j] = bitrev8x4(data[j]);
+			else
+				data[j] = (__force u32)cpu_to_be32(data[j]);
+	}
+}
+
+static int loongson2_mmc_prepare_external_dma(struct loongson2_mmc_host *host,
+					      struct mmc_data *data)
+{
+	struct mmc_host *mmc = mmc_from_priv(host);
+	struct dma_slave_config dma_conf = { };
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	ret = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
+			 mmc_get_dma_dir(data));
+	if (!ret)
+		return -ENOMEM;
+
+	dma_conf.src_addr = host->res->start + LOONGSON2_MMC_REG_DATA,
+	dma_conf.dst_addr = host->res->start + LOONGSON2_MMC_REG_DATA,
+	dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	dma_conf.direction = !(data->flags & MMC_DATA_WRITE) ?
+			     DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+
+	dmaengine_slave_config(host->chan, &dma_conf);
+	desc = dmaengine_prep_slave_sg(host->chan, data->sg, data->sg_len,
+				       dma_conf.direction,
+				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc)
+		goto unmap_exit;
+
+	dmaengine_submit(desc);
+	dma_async_issue_pending(host->chan);
+
+	return 0;
+
+unmap_exit:
+	dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
+	return -ENOMEM;
+}
+
+static void loongson2_mmc_release_external_dma(struct loongson2_mmc_host *host,
+					       struct device *dev)
+{
+	dma_release_channel(host->chan);
+}
+
+static int ls2k0500_mmc_set_external_dma(struct loongson2_mmc_host *host,
+					 struct platform_device *pdev)
+{
+	int ret, val;
+	void __iomem *regs;
+
+	regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	val = readl(regs);
+	val |= FIELD_PREP(LS2K0500_SDIO_DMA_MASK, LS2K0500_DMA2_CONF);
+	writel(val, regs);
+
+	host->chan = dma_request_chan(&pdev->dev, "rx-tx");
+	ret = PTR_ERR_OR_ZERO(host->chan);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot get DMA channel.\n");
+		return  ret;
+	}
+
+	return 0;
+}
+
+static struct loongson2_mmc_pdata ls2k0500_mmc_pdata = {
+	.regmap_config		= &ls2k1000_mmc_regmap_config,
+	.reorder_cmd_data	= loongson2_mmc_reorder_cmd_data,
+	.setting_dma		= ls2k0500_mmc_set_external_dma,
+	.prepare_dma		= loongson2_mmc_prepare_external_dma,
+	.release_dma		= loongson2_mmc_release_external_dma,
+};
+
+static int ls2k1000_mmc_set_external_dma(struct loongson2_mmc_host *host,
+					 struct platform_device *pdev)
+{
+	int ret, val;
+	void __iomem *regs;
+
+	regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	val = readl(regs);
+	val |= FIELD_PREP(LS2K1000_SDIO_DMA_MASK, LS2K1000_DMA1_CONF);
+	writel(val, regs);
+
+	host->chan = dma_request_chan(&pdev->dev, "rx-tx");
+	ret = PTR_ERR_OR_ZERO(host->chan);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot get DMA channel.\n");
+		return  ret;
+	}
+
+	return 0;
+}
+
+static struct loongson2_mmc_pdata ls2k1000_mmc_pdata = {
+	.regmap_config		= &ls2k1000_mmc_regmap_config,
+	.reorder_cmd_data	= loongson2_mmc_reorder_cmd_data,
+	.setting_dma		= ls2k1000_mmc_set_external_dma,
+	.prepare_dma		= loongson2_mmc_prepare_external_dma,
+	.release_dma		= loongson2_mmc_release_external_dma,
+};
+
+static int loongson2_mmc_resource_request(struct platform_device *pdev,
+					  struct loongson2_mmc_host *host)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret, irq;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &host->res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	host->regmap = devm_regmap_init_mmio(dev, base, host->pdata->regmap_config);
+	if (IS_ERR(host->regmap))
+		return PTR_ERR(host->regmap);
+
+	host->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
+
+	if (host->clk) {
+		ret = devm_clk_rate_exclusive_get(dev, host->clk);
+		if (ret)
+			return PTR_ERR(host->clk);
+
+		host->rate = clk_get_rate(host->clk);
+	} else {
+		/* For ACPI, we get rate through clock-frequency attribute */
+		device_property_read_u64(dev, "clock-frequency", &host->rate);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, loongson2_mmc_irq,
+					loongson2_mmc_irq_worker,
+					IRQF_ONESHOT, "loongson2-mmc", host);
+	if (ret)
+		return ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	return host->pdata->setting_dma(host, pdev);
+}
+
+static int loongson2_mmc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct loongson2_mmc_host *host;
+	struct mmc_host	*mmc;
+	int ret;
+
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
+	if (!mmc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mmc);
+
+	host = mmc_priv(mmc);
+	host->state = STATE_NONE;
+	spin_lock_init(&host->lock);
+
+	host->pdata = device_get_match_data(dev);
+	if (!host->pdata)
+		return dev_err_probe(dev, -EINVAL, "Failed to get match data\n");
+
+	ret = loongson2_mmc_resource_request(pdev, host);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request resource\n");
+
+	mmc->ops = &loongson2_mmc_ops;
+	mmc->f_min = DIV_ROUND_UP(host->rate, 256);
+	mmc->f_max = host->rate;
+	mmc->max_blk_count = 4095;
+	mmc->max_blk_size = 4095;
+	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
+	mmc->max_segs = 1;
+	mmc->max_seg_size = mmc->max_req_size;
+
+	/* Process SDIO IRQs through the sdio_irq_work. */
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret || mmc->ocr_avail == 0) {
+		dev_warn(dev, "Can't get voltage, defaulting to 3.3V\n");
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	}
+
+	ret = mmc_of_parse(mmc);
+	if (ret) {
+		dev_err(dev, "Failed to parse device node\n");
+		goto free_dma;
+	}
+
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(dev, "Failed to add mmc host\n");
+		goto free_dma;
+	}
+
+	return 0;
+
+free_dma:
+	host->pdata->release_dma(host, dev);
+	return ret;
+}
+
+static void loongson2_mmc_remove(struct platform_device *pdev)
+{
+	struct mmc_host *mmc  = platform_get_drvdata(pdev);
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+
+	mmc_remove_host(mmc);
+	host->pdata->release_dma(host, &pdev->dev);
+}
+
+static const struct of_device_id loongson2_mmc_of_ids[] = {
+	{ .compatible = "loongson,ls2k0500-mmc", .data = &ls2k0500_mmc_pdata },
+	{ .compatible = "loongson,ls2k1000-mmc", .data = &ls2k1000_mmc_pdata },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, loongson2_mmc_of_ids);
+
+static int loongson2_mmc_suspend(struct device *dev)
+{
+	struct mmc_host *mmc  = dev_get_drvdata(dev);
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+
+	clk_disable_unprepare(host->clk);
+
+	return 0;
+}
+
+static int loongson2_mmc_resume(struct device *dev)
+{
+	struct mmc_host *mmc  = dev_get_drvdata(dev);
+	struct loongson2_mmc_host *host = mmc_priv(mmc);
+
+	return clk_prepare_enable(host->clk);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(loongson2_mmc_pm_ops, loongson2_mmc_suspend,
+				loongson2_mmc_resume);
+
+static struct platform_driver loongson2_mmc_driver = {
+	.driver	= {
+		.name = "loongson2-mmc",
+		.of_match_table = loongson2_mmc_of_ids,
+		.pm = pm_ptr(&loongson2_mmc_pm_ops),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = loongson2_mmc_probe,
+	.remove = loongson2_mmc_remove,
+};
+
+module_platform_driver(loongson2_mmc_driver);
+
+MODULE_DESCRIPTION("Loongson-2K SD/SDIO/eMMC Interface driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.47.1


