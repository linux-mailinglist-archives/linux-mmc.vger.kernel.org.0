Return-Path: <linux-mmc+bounces-3332-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4839525D5
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2024 00:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E002B22E54
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F34C14EC79;
	Wed, 14 Aug 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="aokBFlIM"
X-Original-To: linux-mmc@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6B60B96;
	Wed, 14 Aug 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674904; cv=pass; b=RkaIET/gDR0YDCd1hgcq8Y+cWm7pKf7QT+NwXqSF9AkcFtnATsNfI+kP0YoetTcNHDpweTDgVtIL5InhKyqDGT3XqsXwSchtyqiZGT/dBGOFB1n0md28PTOyT3sXcYevkKokF5CPwvDawKd3RBi4PcVNqT1YJLMBep3EPK7vtY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674904; c=relaxed/simple;
	bh=lt9QrNAThuMnmsDhWCTY7drPRB+TIQjRb++6AHrZCqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2uedlAbc1N6ThH3cUEh19Xu0SzmWJI/WFXiUME1ncvJUsrq2AkqH6eXNDCzp3pcFg03r6bLcIHGX8i4tID4kLaeOhG/9V0ya1N8ogEAaWLFQRL0bWj6k3C/+Ew1W5/Hg1wRbMj2tNc2oO6AJizOuKEOujxbLI4yxhAv1txyQek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=aokBFlIM; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723674877; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EGSXNJEBxi9LLaZ2ZqW649n43+gqF8arv7DpwOIiIL16QzqBapIF5E2VgyND5qvIboPAN0TsYRSKIarbp2+tHPrPv/4dAK0I77DwHaMY7XcLgh6I3+PzHeLO8p+zOTRpdlAEwyAxJAzEz6pbSo0LJjEtjPrn1B5NONdXDPuwhzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674877; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nwZ71hZV+gNmLOh0K/QZssl4osS7eYQruaBZZmkWuuQ=; 
	b=Td6ViPYjs+uK4BES46eCH2M5/sYR8WzXLZTgRHxRq2Ove0nPUyxDSyV4F6HYbK6DPlXo8/XSp4gARbWDkuIjIBpg6y8rV7NulJXCfo4nn8rtwDEdZljD6LIiB/5+qdik8E2YKKQEQZ/DCF7vd5peOLSGW00JYSJaxHTqkjRCIco=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674877;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nwZ71hZV+gNmLOh0K/QZssl4osS7eYQruaBZZmkWuuQ=;
	b=aokBFlIMffe/NRZYt2Jj3YcNpdc4Gw/BcWuNVpzP03Kz/U/tEHFrrJ5CGNh67cP5
	tQ8adU12R9N5YZ/gQS+n0Vqc/XESxhP4TYALYoacSiLyu56kDGDp0sh6k1HKWXjlSl1
	+SMJxrXhrJ9Erdf9SZSvAVu7LW8JcmrFlxZ9RAFM=
Received: by mx.zohomail.com with SMTPS id 17236748749611007.2751147530727;
	Wed, 14 Aug 2024 15:34:34 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 3/3] mmc: dw_mmc-rockchip: Add internal phase support
Date: Wed, 14 Aug 2024 18:34:02 -0400
Message-ID: <20240814223555.3695-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814223555.3695-1-detlev.casanova@collabora.com>
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Shawn Lin <shawn.lin@rock-chips.com>

Some Rockchip devices put the phase settings into the dw_mmc controller.

The feature is implemented in devices where the USRID register contains
0x20230002.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 184 ++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 367633f4e8892..03e25a8b8a305 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -16,6 +16,17 @@
 #include "dw_mmc-pltfm.h"
 
 #define RK3288_CLKGEN_DIV	2
+#define USRID_INTER_PHASE	0x20230001
+#define SDMMC_TIMING_CON0	0x130
+#define SDMMC_TIMING_CON1	0x134
+#define ROCKCHIP_MMC_DELAY_SEL BIT(10)
+#define ROCKCHIP_MMC_DEGREE_MASK 0x3
+#define ROCKCHIP_MMC_DELAYNUM_OFFSET 2
+#define ROCKCHIP_MMC_DELAYNUM_MASK (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
+#define PSECS_PER_SEC 1000000000000LL
+#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC 60
+#define HIWORD_UPDATE(val, mask, shift) \
+		((val) << (shift) | (mask) << ((shift) + 16))
 
 static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
 
@@ -25,9 +36,121 @@ struct dw_mci_rockchip_priv_data {
 	int			default_sample_phase;
 	int			num_phases;
 	bool			use_v2_tuning;
+	int			usrid;
 	int			last_degree;
 };
 
+/*
+ * Each fine delay is between 44ps-77ps. Assume each fine delay is 60ps to
+ * simplify calculations. So 45degs could be anywhere between 33deg and 57.8deg.
+ */
+static int rockchip_mmc_get_phase(struct dw_mci *host, bool sample)
+{
+	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u32 raw_value;
+	u16 degrees;
+	u32 delay_num = 0;
+
+	/* Constant signal, no measurable phase shift */
+	if (!rate)
+		return 0;
+
+	if (sample)
+		raw_value = mci_readl(host, TIMING_CON1) >> 1;
+	else
+		raw_value = mci_readl(host, TIMING_CON0) >> 1;
+
+	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
+
+	if (raw_value & ROCKCHIP_MMC_DELAY_SEL) {
+		/* degrees/delaynum * 1000000 */
+		unsigned long factor = (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
+					36 * (rate / 10000);
+
+		delay_num = (raw_value & ROCKCHIP_MMC_DELAYNUM_MASK);
+		delay_num >>= ROCKCHIP_MMC_DELAYNUM_OFFSET;
+		degrees += DIV_ROUND_CLOSEST(delay_num * factor, 1000000);
+	}
+
+	return degrees % 360;
+}
+
+static int rockchip_mmc_set_phase(struct dw_mci *host, bool sample, int degrees)
+{
+	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u8 nineties, remainder;
+	u8 delay_num;
+	u32 raw_value;
+	u32 delay;
+
+	/*
+	 * The below calculation is based on the output clock from
+	 * MMC host to the card, which expects the phase clock inherits
+	 * the clock rate from its parent, namely the output clock
+	 * provider of MMC host. However, things may go wrong if
+	 * (1) It is orphan.
+	 * (2) It is assigned to the wrong parent.
+	 *
+	 * This check help debug the case (1), which seems to be the
+	 * most likely problem we often face and which makes it difficult
+	 * for people to debug unstable mmc tuning results.
+	 */
+	if (!rate) {
+		dev_err(host->dev, "%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
+	nineties = degrees / 90;
+	remainder = (degrees % 90);
+
+	/*
+	 * Due to the inexact nature of the "fine" delay, we might
+	 * actually go non-monotonic.  We don't go _too_ monotonic
+	 * though, so we should be OK.  Here are options of how we may
+	 * work:
+	 *
+	 * Ideally we end up with:
+	 *   1.0, 2.0, ..., 69.0, 70.0, ...,  89.0, 90.0
+	 *
+	 * On one extreme (if delay is actually 44ps):
+	 *   .73, 1.5, ..., 50.6, 51.3, ...,  65.3, 90.0
+	 * The other (if delay is actually 77ps):
+	 *   1.3, 2.6, ..., 88.6. 89.8, ..., 114.0, 90
+	 *
+	 * It's possible we might make a delay that is up to 25
+	 * degrees off from what we think we're making.  That's OK
+	 * though because we should be REALLY far from any bad range.
+	 */
+
+	/*
+	 * Convert to delay; do a little extra work to make sure we
+	 * don't overflow 32-bit / 64-bit numbers.
+	 */
+	delay = 10000000; /* PSECS_PER_SEC / 10000 / 10 */
+	delay *= remainder;
+	delay = DIV_ROUND_CLOSEST(delay,
+			(rate / 1000) * 36 *
+				(ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10));
+
+	delay_num = (u8) min_t(u32, delay, 255);
+
+	raw_value = delay_num ? ROCKCHIP_MMC_DELAY_SEL : 0;
+	raw_value |= delay_num << ROCKCHIP_MMC_DELAYNUM_OFFSET;
+	raw_value |= nineties;
+
+	if (sample)
+		mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+	else
+		mci_writel(host, TIMING_CON0, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+
+	dev_dbg(host->dev, "set %s_phase(%d) delay_nums=%u actual_degrees=%d\n",
+		sample ? "sample" : "drv", degrees, delay_num,
+		rockchip_mmc_get_phase(host, sample)
+	);
+
+	return 0;
+}
+
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
@@ -65,8 +188,12 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 
 	/* Make sure we use phases which we can enumerate with */
-	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
-		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS) {
+		if (priv->usrid == USRID_INTER_PHASE)
+			rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
+		else
+			clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+	}
 
 	/*
 	 * Set the drive phase offset based on speed mode to achieve hold times.
@@ -129,7 +256,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			break;
 		}
 
-		clk_set_phase(priv->drv_clk, phase);
+		if (priv->usrid == USRID_INTER_PHASE)
+			rockchip_mmc_set_phase(host, false, phase);
+		else
+			clk_set_phase(priv->drv_clk, phase);
 	}
 }
 
@@ -141,13 +271,16 @@ static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	struct dw_mci *host = slot->host;
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
 	struct mmc_host *mmc = slot->mmc;
-	u32 degrees[4] = {90, 180, 270, 360};
+	u32 degree, degrees[4] = {90, 180, 270, 360};
 	int i;
 	static bool inherit = true;
 
 	if (inherit) {
 		inherit = false;
-		i = clk_get_phase(priv->sample_clk) / 90 - 1;
+		if (priv->usrid == USRID_INTER_PHASE)
+			i = rockchip_mmc_get_phase(host, true) / 90;
+		else
+			i = clk_get_phase(priv->sample_clk) / 90 - 1;
 		goto done;
 	}
 
@@ -156,7 +289,11 @@ static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		if (degrees[i] == priv->last_degree)
 			continue;
 
-		clk_set_phase(priv->sample_clk, degrees[i]);
+		degree = (degrees[i] + priv->last_degree + 90) % 360;
+		if (priv->usrid == USRID_INTER_PHASE)
+			rockchip_mmc_set_phase(host, true, degree);
+		else
+			clk_set_phase(priv->sample_clk, degree);
 		if (!mmc_send_tuning(mmc, opcode, NULL))
 			break;
 	}
@@ -189,6 +326,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	int longest_range_len = -1;
 	int longest_range = -1;
 	int middle_phase;
+	int phase;
 
 	if (IS_ERR(priv->sample_clk)) {
 		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
@@ -209,8 +347,15 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 
 	/* Try each phase and extract good ranges */
 	for (i = 0; i < priv->num_phases; ) {
-		clk_set_phase(priv->sample_clk,
-			      TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
+		/* Cannot guarantee any phases larger than 270 would work well */
+		if (TUNING_ITERATION_TO_PHASE(i, priv->num_phases) > 270)
+			break;
+		if (priv->usrid == USRID_INTER_PHASE)
+			rockchip_mmc_set_phase(host, true,
+				TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
+		else
+			clk_set_phase(priv->sample_clk,
+				TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
 
 		v = !mmc_send_tuning(mmc, opcode, NULL);
 
@@ -256,7 +401,10 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	}
 
 	if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
-		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+		if (priv->usrid == USRID_INTER_PHASE)
+			rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
+		else
+			clk_set_phase(priv->sample_clk, priv->default_sample_phase);
 		dev_info(host->dev, "All phases work, using default phase %d.",
 			 priv->default_sample_phase);
 		goto free;
@@ -293,12 +441,13 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 
 	middle_phase = ranges[longest_range].start + longest_range_len / 2;
 	middle_phase %= priv->num_phases;
-	dev_info(host->dev, "Successfully tuned phase to %d\n",
-		 TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases));
+	phase = TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases);
+	dev_info(host->dev, "Successfully tuned phase to %d\n", phase);
 
-	clk_set_phase(priv->sample_clk,
-		      TUNING_ITERATION_TO_PHASE(middle_phase,
-						priv->num_phases));
+	if (priv->usrid == USRID_INTER_PHASE)
+		rockchip_mmc_set_phase(host, true, phase);
+	else
+		clk_set_phase(priv->sample_clk, phase);
 
 free:
 	kfree(ranges);
@@ -342,6 +491,7 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
 	int ret, i;
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
 
 	/* It is slot 8 on Rockchip SoCs */
 	host->sdio_id0 = 8;
@@ -365,6 +515,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 			dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
 	}
 
+	priv->usrid = mci_readl(host, USRID);
+	if (priv->usrid == USRID_INTER_PHASE) {
+		priv->sample_clk = NULL;
+		priv->drv_clk = NULL;
+	}
+
 	return 0;
 }
 
-- 
2.46.0


