Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD07D6E32C9
	for <lists+linux-mmc@lfdr.de>; Sat, 15 Apr 2023 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDOROK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 15 Apr 2023 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjDOROJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Apr 2023 13:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DF19B5;
        Sat, 15 Apr 2023 10:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB6460DD5;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 376CEC4339C;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681578846;
        bh=G2tLPQgRxtDu3DlqJOjUZMbxuxbA9j8nbZJ62Yt8Xr4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=PydQOLA8GYq4RoykBlKmDwhVvmvYNjYP0K78lPjrqBm35+n0OIM7damXQdIg4gqIA
         x625zOT8aNcL4vzTnwxdxoeyU6e2HbC1A7xaUEmNPPiHxojqIT1Cb8+kpt82Svf6PW
         25cGTbSuLw1JrMaPE2L/teZeLJZ4ldDoM/K8CO/2j84Wv6K6n7RRpfhtNHPakxCsyN
         p66oFKFV5LEr3w+vfkr6qntwVPxIwwpCzePFmYsVhyBLQNHVSiH8AT5GrYTMDYc/eP
         26wN/KcASaK5HRlwLHxNBNfHzmovRcFPTZt1AfkuateuX2MsHf6CQIpoZhK+6V/PRH
         nLCflkRSgag4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1F770C77B73;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 01:13:16 +0800
Subject: [PATCH RFC v2 1/3] mmc: dw_mmc-hi3798cv200: rename to dw_mmc-histb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v2-1-1d274f9b71da@outlook.com>
References: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681578841; l=7027;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=eoErTepi3JKctxpmeTvJxlWPwF/xYjRv313AFyJJwn4=;
 b=R5BBYdyqfPcT93023bQw5XUb1MJKxMX1ynole5Q+KlpYZ+0kNi0KqLfxjgvV/XGc/eRRl9BeC
 xKrXuvHbOkDAORvEJty5TRrlsIAVXECj+8T4LY05lmoAsHYckWxZIEF
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Rename to dw_mmc-histb and introduce a mechanism similar to
dw-mmc_exynos to support more devices in a single driver. It is a
preparation for introducing extension for Hi3798MV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/host/Kconfig                           |  8 +--
 drivers/mmc/host/Makefile                          |  2 +-
 .../host/{dw_mmc-hi3798cv200.c => dw_mmc-histb.c}  | 79 ++++++++++++++--------
 3 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4745fe217ade3..0aef4d845b743 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -779,14 +779,14 @@ config MMC_DW_EXYNOS
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on Exynos4 and Exynos5 SoC's.
 
-config MMC_DW_HI3798CV200
-	tristate "Hi3798CV200 specific extensions for Synopsys DW Memory Card Interface"
+config MMC_DW_HISTB
+	tristate "HiSTB specific extensions for Synopsys DW Memory Card Interface"
 	depends on MMC_DW
 	select MMC_DW_PLTFM
 	help
-	  This selects support for HiSilicon Hi3798CV200 SoC specific extensions to the
+	  This selects support for HiSilicon HiSTB SoC specific extensions to the
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
-	  for platforms based on HiSilicon Hi3798CV200 SoC.
+	  for platforms based on HiSilicon HiSTB SoC.
 
 config MMC_DW_K3
 	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1cc..0373741afebf1 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -50,7 +50,7 @@ obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
 obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
 obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
 obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
-obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
+obj-$(CONFIG_MMC_DW_HISTB) += dw_mmc-histb.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-histb.c
similarity index 69%
rename from drivers/mmc/host/dw_mmc-hi3798cv200.c
rename to drivers/mmc/host/dw_mmc-histb.c
index 6f22fe0540879..106e586bcff4b 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-histb.c
@@ -18,14 +18,29 @@
 
 #define ALL_INT_CLR		0x1ffff
 
-struct hi3798cv200_priv {
+enum dw_mci_histb_type {
+	DW_MCI_TYPE_HI3798CV200,
+};
+
+static struct dw_mci_histb_compat {
+	const char * const compatible;
+	enum dw_mci_histb_type ctrl_type;
+} histb_compat[] = {
+	{
+		.compatible = "hisilicon,hi3798cv200-dw-mshc",
+		.ctrl_type = DW_MCI_TYPE_HI3798CV200,
+	},
+};
+
+struct dw_mci_histb_priv {
+	enum dw_mci_histb_type ctrl_type;
 	struct clk *sample_clk;
 	struct clk *drive_clk;
 };
 
-static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+static void dw_mci_histb_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
-	struct hi3798cv200_priv *priv = host->priv;
+	struct dw_mci_histb_priv *priv = host->priv;
 	u32 val;
 
 	val = mci_readl(host, UHS_REG);
@@ -62,7 +77,7 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 {
 	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
 	struct dw_mci *host = slot->host;
-	struct hi3798cv200_priv *priv = host->priv;
+	struct dw_mci_histb_priv *priv = host->priv;
 	int raise_point = -1, fall_point = -1;
 	int err, prev_err = -1;
 	int found = 0;
@@ -118,15 +133,21 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 	return err;
 }
 
-static int dw_mci_hi3798cv200_init(struct dw_mci *host)
+static int dw_mci_histb_init(struct dw_mci *host)
 {
-	struct hi3798cv200_priv *priv;
-	int ret;
+	struct dw_mci_histb_priv *priv;
+	struct device_node *np = host->dev->of_node;
+	int ret, idx;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	for (idx = 0; idx < ARRAY_SIZE(histb_compat); idx++) {
+		if (of_device_is_compatible(np, histb_compat[idx].compatible))
+			priv->ctrl_type = histb_compat[idx].ctrl_type;
+	}
+
 	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
 	if (IS_ERR(priv->sample_clk)) {
 		dev_err(host->dev, "failed to get ciu-sample clock\n");
@@ -161,20 +182,29 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
 
 static const struct dw_mci_drv_data hi3798cv200_data = {
 	.common_caps = MMC_CAP_CMD23,
-	.init = dw_mci_hi3798cv200_init,
-	.set_ios = dw_mci_hi3798cv200_set_ios,
+	.init = dw_mci_histb_init,
+	.set_ios = dw_mci_histb_set_ios,
 	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
 };
 
-static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
+static const struct of_device_id dw_mci_histb_match[] = {
+	{ .compatible = "hisilicon,hi3798cv200-dw-mshc", .data = &hi3798cv200_data },
+	{},
+};
+
+static int dw_mci_histb_probe(struct platform_device *pdev)
 {
-	return dw_mci_pltfm_register(pdev, &hi3798cv200_data);
+	const struct of_device_id *match;
+
+	match = of_match_node(dw_mci_histb_match, pdev->dev.of_node);
+
+	return dw_mci_pltfm_register(pdev, match->data);
 }
 
-static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
+static int dw_mci_histb_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
-	struct hi3798cv200_priv *priv = host->priv;
+	struct dw_mci_histb_priv *priv = host->priv;
 
 	clk_disable_unprepare(priv->drive_clk);
 	clk_disable_unprepare(priv->sample_clk);
@@ -184,23 +214,18 @@ static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id dw_mci_hi3798cv200_match[] = {
-	{ .compatible = "hisilicon,hi3798cv200-dw-mshc", },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
-static struct platform_driver dw_mci_hi3798cv200_driver = {
-	.probe = dw_mci_hi3798cv200_probe,
-	.remove = dw_mci_hi3798cv200_remove,
+MODULE_DEVICE_TABLE(of, dw_mci_histb_match);
+static struct platform_driver dw_mci_histb_driver = {
+	.probe = dw_mci_histb_probe,
+	.remove = dw_mci_histb_remove,
 	.driver = {
-		.name = "dwmmc_hi3798cv200",
+		.name = "dwmmc_histb",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = dw_mci_hi3798cv200_match,
+		.of_match_table = dw_mci_histb_match,
 	},
 };
-module_platform_driver(dw_mci_hi3798cv200_driver);
+module_platform_driver(dw_mci_histb_driver);
 
-MODULE_DESCRIPTION("HiSilicon Hi3798CV200 Specific DW-MSHC Driver Extension");
+MODULE_DESCRIPTION("HiSilicon HiSTB Specific DW-MSHC Driver Extension");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:dwmmc_hi3798cv200");
+MODULE_ALIAS("platform:dwmmc_histb");

-- 
2.39.2

