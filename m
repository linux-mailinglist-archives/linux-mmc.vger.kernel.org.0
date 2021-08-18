Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2D3F02D9
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Aug 2021 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhHRLjV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Aug 2021 07:39:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45680 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235557AbhHRLjV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 07:39:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 718DC1A50DD;
        Wed, 18 Aug 2021 13:38:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3969D1A50DE;
        Wed, 18 Aug 2021 13:38:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AA5FA183ACDC;
        Wed, 18 Aug 2021 19:38:43 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] mmc: sdhci-eadhc-imx: select the correct mode for auto tuning
Date:   Wed, 18 Aug 2021 19:16:51 +0800
Message-Id: <1629285415-7495-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

USDHC hardware auto tuning circuit support check 1/4/8 data lines
and cmd line. Out of reset uSDHC, it default select check 4 data
lines and do not check cmd line. This is incorrect if we use 8 data
lines. So need to config the auto tuning mode according to current
bus width.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a49fac719fca..f18d169bc8ff 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -94,6 +94,11 @@
 
 #define ESDHC_VEND_SPEC2		0xc8
 #define ESDHC_VEND_SPEC2_EN_BUSY_IRQ	(1 << 8)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_8BIT_EN	(1 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_4BIT_EN	(0 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN	(2 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN	(1 << 6)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK	(7 << 4)
 
 #define ESDHC_TUNING_CTRL		0xcc
 #define ESDHC_STD_TUNING_EN		(1 << 24)
@@ -114,6 +119,7 @@
 #define ESDHC_CTRL_4BITBUS		(0x1 << 1)
 #define ESDHC_CTRL_8BITBUS		(0x2 << 1)
 #define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
+#define USDHC_GET_BUSWIDTH(c) (c & ESDHC_CTRL_BUSWIDTH_MASK)
 
 /*
  * There is an INT DMA ERR mismatch between eSDHC and STD SDHC SPEC:
@@ -407,6 +413,30 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us!.\n", __func__);
 }
 
+/* Enable the auto tuning circuit to check the CMD line and BUS line */
+static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
+{
+	u32 buswidth, auto_tune_buswidth;
+
+	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
+
+	switch (buswidth) {
+	case ESDHC_CTRL_8BITBUS:
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_8BIT_EN;
+		break;
+	case ESDHC_CTRL_4BITBUS:
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_4BIT_EN;
+		break;
+	default:	/* 1BITBUS */
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+		break;
+	}
+
+	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
+			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
+			ESDHC_VEND_SPEC2);
+}
+
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -643,6 +673,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
 				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+				usdhc_auto_tuning_mode_sel(host);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -1012,6 +1043,8 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 {
 	u32 reg;
 
+	usdhc_auto_tuning_mode_sel(host);
+
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-- 
2.17.1

