Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8CF731393
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Jun 2023 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbjFOJWG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Jun 2023 05:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbjFOJVy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2023 05:21:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB42976;
        Thu, 15 Jun 2023 02:21:49 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8Hpmn007658;
        Thu, 15 Jun 2023 11:21:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=CJKWO+OmV5LcnGGg09K88UHJKVty658e5Qf90lGn7FY=;
 b=rk1KHlirYQRgR9J0EGAd6tMCq3YJFGeoKbyucZ0wA1e6X3CX57ceCsvr7P6Rn35C90VB
 eChoQ6Ko1NTCyeluB//FO/1EuyYBdARX1rGDOsNtVGsjAqdKvzfjXgIRbz9/AhzVAEnK
 CtyYFsSsB6AB1Ccj02TSXnioi+aYsWD59UPtDGYnnRIwOisqh/7WPsdXo1iMaehjUIfC
 bWwAX0E5wJS82ED2v+wo2coaw4u7j3N//+ostUCyjbpqmZckfIACd46uPQqVCrC0l+K/
 igLtFLu8ozGBuYRV+2jAgKhHvEUUNYZ+/Bezmcm0mKqmgp0pBO+ACWRad+MP6HKG/hL6 JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7s1mava4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:21:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7969910002A;
        Thu, 15 Jun 2023 11:21:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7006A21A235;
        Thu, 15 Jun 2023 11:21:27 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:21:26 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 5/6] mmc: mmci: stm32: prepare other delay block support
Date:   Thu, 15 Jun 2023 11:20:00 +0200
Message-ID: <20230615092001.1213132-6-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615092001.1213132-1-yann.gautier@foss.st.com>
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Create an sdmmc_tuning_ops struct to ease support for another
delay block peripheral.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 68 +++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 0dc1ae674f44c..c51c85ca24917 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -47,10 +47,21 @@ struct sdmmc_idma {
 	bool use_bounce_buffer;
 };
 
+struct sdmmc_dlyb;
+
+struct sdmmc_tuning_ops {
+	int (*dlyb_enable)(struct sdmmc_dlyb *dlyb);
+	void (*set_input_ck)(struct sdmmc_dlyb *dlyb);
+	int (*tuning_prepare)(struct mmci_host *host);
+	int (*set_cfg)(struct sdmmc_dlyb *dlyb, int unit __maybe_unused,
+		       int phase, bool sampler __maybe_unused);
+};
+
 struct sdmmc_dlyb {
 	void __iomem *base;
 	u32 unit;
 	u32 max;
+	struct sdmmc_tuning_ops *ops;
 };
 
 static int sdmmc_idma_validate_data(struct mmci_host *host,
@@ -299,7 +310,7 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
-static void sdmmc_dlyb_input_ck(struct sdmmc_dlyb *dlyb)
+static void sdmmc_dlyb_mp15_input_ck(struct sdmmc_dlyb *dlyb)
 {
 	if (!dlyb || !dlyb->base)
 		return;
@@ -316,7 +327,8 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
 	/* adds OF options */
 	pwr = host->pwr_reg_add;
 
-	sdmmc_dlyb_input_ck(dlyb);
+	if (dlyb && dlyb->ops->set_input_ck)
+		dlyb->ops->set_input_ck(dlyb);
 
 	if (ios.power_mode == MMC_POWER_OFF) {
 		/* Only a reset could power-off sdmmc */
@@ -430,8 +442,15 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	return true;
 }
 
-static void sdmmc_dlyb_set_cfgr(struct sdmmc_dlyb *dlyb,
-				int unit, int phase, bool sampler)
+static int sdmmc_dlyb_mp15_enable(struct sdmmc_dlyb *dlyb)
+{
+	writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
+
+	return 0;
+}
+
+static int sdmmc_dlyb_mp15_set_cfg(struct sdmmc_dlyb *dlyb,
+				   int unit, int phase, bool sampler)
 {
 	u32 cfgr;
 
@@ -443,16 +462,18 @@ static void sdmmc_dlyb_set_cfgr(struct sdmmc_dlyb *dlyb,
 
 	if (!sampler)
 		writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
+
+	return 0;
 }
 
-static int sdmmc_dlyb_lng_tuning(struct mmci_host *host)
+static int sdmmc_dlyb_mp15_prepare(struct mmci_host *host)
 {
 	struct sdmmc_dlyb *dlyb = host->variant_priv;
 	u32 cfgr;
 	int i, lng, ret;
 
 	for (i = 0; i <= DLYB_CFGR_UNIT_MAX; i++) {
-		sdmmc_dlyb_set_cfgr(dlyb, i, DLYB_CFGR_SEL_MAX, true);
+		dlyb->ops->set_cfg(dlyb, i, DLYB_CFGR_SEL_MAX, true);
 
 		ret = readl_relaxed_poll_timeout(dlyb->base + DLYB_CFGR, cfgr,
 						 (cfgr & DLYB_CFGR_LNGF),
@@ -482,10 +503,14 @@ static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
 {
 	struct sdmmc_dlyb *dlyb = host->variant_priv;
 	int cur_len = 0, max_len = 0, end_of_len = 0;
-	int phase;
+	int phase, ret;
 
 	for (phase = 0; phase <= dlyb->max; phase++) {
-		sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
+		ret = dlyb->ops->set_cfg(dlyb, dlyb->unit, phase, false);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "tuning config failed\n");
+			return ret;
+		}
 
 		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
 			cur_len = 0;
@@ -503,10 +528,15 @@ static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
 		return -EINVAL;
 	}
 
-	writel_relaxed(0, dlyb->base + DLYB_CR);
+	if (dlyb->ops->set_input_ck)
+		dlyb->ops->set_input_ck(dlyb);
 
 	phase = end_of_len - max_len / 2;
-	sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
+	ret = dlyb->ops->set_cfg(dlyb, dlyb->unit, phase, false);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "tuning reconfig failed\n");
+		return ret;
+	}
 
 	dev_dbg(mmc_dev(host->mmc), "unit:%d max_dly:%d phase:%d\n",
 		dlyb->unit, dlyb->max, phase);
@@ -519,6 +549,7 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct mmci_host *host = mmc_priv(mmc);
 	struct sdmmc_dlyb *dlyb = host->variant_priv;
 	u32 clk;
+	int ret;
 
 	if ((host->mmc->ios.timing != MMC_TIMING_UHS_SDR104 &&
 	     host->mmc->ios.timing != MMC_TIMING_MMC_HS200) ||
@@ -528,7 +559,9 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!dlyb || !dlyb->base)
 		return -EINVAL;
 
-	writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
+	ret = dlyb->ops->dlyb_enable(dlyb);
+	if (ret)
+		return ret;
 
 	/*
 	 * SDMMC_FBCK is selected when an external Delay Block is needed
@@ -539,8 +572,9 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	clk |= MCI_STM32_CLK_SELFBCK;
 	mmci_write_clkreg(host, clk);
 
-	if (sdmmc_dlyb_lng_tuning(host))
-		return -EINVAL;
+	ret = dlyb->ops->tuning_prepare(host);
+	if (ret)
+		return ret;
 
 	return sdmmc_dlyb_phase_tuning(host, opcode);
 }
@@ -598,6 +632,13 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.post_sig_volt_switch = sdmmc_post_sig_volt_switch,
 };
 
+static struct sdmmc_tuning_ops dlyb_tuning_mp15_ops = {
+	.dlyb_enable = sdmmc_dlyb_mp15_enable,
+	.set_input_ck = sdmmc_dlyb_mp15_input_ck,
+	.tuning_prepare = sdmmc_dlyb_mp15_prepare,
+	.set_cfg = sdmmc_dlyb_mp15_set_cfg,
+};
+
 void sdmmc_variant_init(struct mmci_host *host)
 {
 	struct device_node *np = host->mmc->parent->of_node;
@@ -616,6 +657,7 @@ void sdmmc_variant_init(struct mmci_host *host)
 		return;
 
 	dlyb->base = base_dlyb;
+	dlyb->ops = &dlyb_tuning_mp15_ops;
 	host->variant_priv = dlyb;
 	host->mmc_ops->execute_tuning = sdmmc_execute_tuning;
 }
-- 
2.25.1

