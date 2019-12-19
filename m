Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7F1259FE
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Dec 2019 04:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLSDYg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Dec 2019 22:24:36 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48740 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLSDYg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 22:24:36 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C1801A01C0;
        Thu, 19 Dec 2019 04:24:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8633D1A0181;
        Thu, 19 Dec 2019 04:24:31 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 870104028B;
        Thu, 19 Dec 2019 11:24:27 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround
Date:   Thu, 19 Dec 2019 11:23:35 +0800
Message-Id: <20191219032335.26528-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The erratum A-009204 workaround patch was reverted because of
incorrect implementation.

8b6dc6b mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
        erratum A-009204 support"

This patch is to re-implement the workaround (add a 5 ms delay
before setting SYSCTL[RSTD] to make sure all the DMA transfers
are finished).

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4abb781..cd3b676 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -80,6 +80,7 @@ struct sdhci_esdhc {
 	bool quirk_tuning_erratum_type1;
 	bool quirk_tuning_erratum_type2;
 	bool quirk_ignore_data_inhibit;
+	bool quirk_delay_before_data_reset;
 	bool in_sw_tuning;
 	unsigned int peripheral_clock;
 	const struct esdhc_clk_fixup *clk_fixup;
@@ -759,6 +760,11 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	u32 val;
 
+	if (esdhc->quirk_delay_before_data_reset &&
+	    (mask & SDHCI_RESET_DATA) &&
+	    (host->flags & SDHCI_REQ_USE_DMA))
+		mdelay(5);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
@@ -1218,6 +1224,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	if (match)
 		esdhc->clk_fixup = match->data;
 	np = pdev->dev.of_node;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc"))
+		esdhc->quirk_delay_before_data_reset = true;
+
 	clk = of_clk_get(np, 0);
 	if (!IS_ERR(clk)) {
 		/*
-- 
2.7.4

