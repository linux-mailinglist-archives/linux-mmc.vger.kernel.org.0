Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10D491664
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jan 2022 03:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbiARCd6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jan 2022 21:33:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbiARC3a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jan 2022 21:29:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E07236114D;
        Tue, 18 Jan 2022 02:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BC2C36AEB;
        Tue, 18 Jan 2022 02:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472969;
        bh=Y52+VQDFKWPukWVOcP0x5AwatEYKIO8IinShTBqBvuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsUk3Lif2Vr4eWJnuI2LfkDi8WvjrE67ebK5OrM66XG8igcU6t5Yv1c06BrA61y6U
         k47ynu5yBCTTaDAJ4+/TaGewem7nurcwA/LpYCS8WRSHVKnyyoPMtOYOlagsMWvRHg
         eIK+3F6ezTrRdYgoQ/efyyRD5pRFRvZ1ykqPUTY+37dWxOzS/L7WOy2h46VpdqrVuz
         FkHpTpfoSEM30AfDoqQ9U1O/Tk6+ZPvnK6Jk0QjU6wlRvqq5IPBbUJU8XGtWP24Wyb
         ectnVMEM07aUjBHA2IoD5iSgJD8DkWmJLXUd5CUT9jjD4w+QTEKNoDCzaTbuVMkuLN
         hZ2INO/WbAYBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, chaotian.jing@mediatek.com,
        matthias.bgg@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 184/217] mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling
Date:   Mon, 17 Jan 2022 21:19:07 -0500
Message-Id: <20220118021940.1942199-184-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit ffaea6ebfe9ce06ebb3a54811a47688f2b0893cd ]

Replace all instances of open-coded while loops for polling registers
with calls to readl_poll_timeout() and, while at it, also fix some
possible infinite loop instances.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20211216125748.179602-1-angelogioacchino.delregno@collabora.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 632775217d35c..d5a9c269d4926 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -636,12 +636,11 @@ static void msdc_reset_hw(struct msdc_host *host)
 	u32 val;
 
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
-	while (readl(host->base + MSDC_CFG) & MSDC_CFG_RST)
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
 
 	sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
-	while (readl(host->base + MSDC_FIFOCS) & MSDC_FIFOCS_CLR)
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_FIFOCS, val,
+			   !(val & MSDC_FIFOCS_CLR), 0, 0);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
@@ -814,8 +813,9 @@ static void msdc_gate_clock(struct msdc_host *host)
 	clk_disable_unprepare(host->h_clk);
 }
 
-static void msdc_ungate_clock(struct msdc_host *host)
+static int msdc_ungate_clock(struct msdc_host *host)
 {
+	u32 val;
 	int ret;
 
 	clk_prepare_enable(host->h_clk);
@@ -825,11 +825,11 @@ static void msdc_ungate_clock(struct msdc_host *host)
 	ret = clk_bulk_prepare_enable(MSDC_NR_CLOCKS, host->bulk_clks);
 	if (ret) {
 		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
-		return;
+		return ret;
 	}
 
-	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
-		cpu_relax();
+	return readl_poll_timeout(host->base + MSDC_CFG, val,
+				  (val & MSDC_CFG_CKSTB), 1, 20000);
 }
 
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
@@ -840,6 +840,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 div;
 	u32 sclk;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
+	u32 val;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -920,8 +921,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	else
 		clk_prepare_enable(clk_get_parent(host->src_clk));
 
-	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_CFG, val, (val & MSDC_CFG_CKSTB), 0, 0);
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	mmc->actual_clock = sclk;
 	host->mclk = hz;
@@ -1231,13 +1231,13 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
-	/* The max busy time we can endure is 20ms */
-	unsigned long tmo = jiffies + msecs_to_jiffies(20);
+	u32 val;
+	int ret;
 
-	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
-			time_before(jiffies, tmo))
-		cpu_relax();
-	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
+	/* The max busy time we can endure is 20ms */
+	ret = readl_poll_timeout_atomic(host->base + SDC_STS, val,
+					!(val & SDC_STS_CMDBUSY), 1, 20000);
+	if (ret) {
 		dev_err(host->dev, "CMD bus busy detected\n");
 		host->error |= REQ_CMD_BUSY;
 		msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
@@ -1245,12 +1245,10 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 	}
 
 	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
 		/* R1B or with data, should check SDCBUSY */
-		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
-				time_before(jiffies, tmo))
-			cpu_relax();
-		if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
+		ret = readl_poll_timeout_atomic(host->base + SDC_STS, val,
+						!(val & SDC_STS_SDCBUSY), 1, 20000);
+		if (ret) {
 			dev_err(host->dev, "Controller busy detected\n");
 			host->error |= REQ_CMD_BUSY;
 			msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
@@ -1376,6 +1374,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 	    (MSDC_INT_XFER_COMPL | MSDC_INT_DATCRCERR | MSDC_INT_DATTMO
 	     | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
 	     | MSDC_INT_DMA_PROTECT);
+	u32 val;
+	int ret;
 
 	spin_lock_irqsave(&host->lock, flags);
 	done = !host->data;
@@ -1392,8 +1392,14 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 				readl(host->base + MSDC_DMA_CFG));
 		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
 				1);
-		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
-			cpu_relax();
+
+		ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CFG, val,
+						!(val & MSDC_DMA_CFG_STS), 1, 20000);
+		if (ret) {
+			dev_dbg(host->dev, "DMA stop timed out\n");
+			return false;
+		}
+
 		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
 		dev_dbg(host->dev, "DMA stop\n");
 
@@ -2674,7 +2680,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	platform_set_drvdata(pdev, mmc);
-	msdc_ungate_clock(host);
+	ret = msdc_ungate_clock(host);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
+		goto release_mem;
+	}
 	msdc_init_hw(host);
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
@@ -2833,8 +2843,12 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = msdc_ungate_clock(host);
+	if (ret)
+		return ret;
 
-	msdc_ungate_clock(host);
 	msdc_restore_reg(host);
 	return 0;
 }
-- 
2.34.1

