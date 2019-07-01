Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4867F138C0
	for <lists+linux-mmc@lfdr.de>; Sat,  4 May 2019 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEDK0D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 4 May 2019 06:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:48458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfEDK0D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 4 May 2019 06:26:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E5B0AF03;
        Sat,  4 May 2019 10:26:01 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 20:24:57 +1000
Subject: [PATCH 3/4] mmc: mtk-sd: enable internal card-detect logic.
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155696549691.8632.10285608726034686897.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mtk-sd silicon has integrated card-detect logic that is
enabled on the MT7621.  The circuit is phased out on newer hardware so
we should be careful to only enabled it on hardware known to support
it.  This a new "use_internal_cd" flag in struct mtk_mmc_compatible.

If the sdhci isn't marked non-removable and doesn't have a
cd-gpio configured, and if use_internal_cd is set, then assume the
internal cd logic should be used as recommended by
 Documentation/devicetree/bindings/mmc/mmc.txt

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/mtk-sd.c |   64 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0c2be4f54b1f..c518cc208a1f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -300,6 +300,8 @@
 #define CMD_TIMEOUT         (HZ/10 * 5)	/* 100ms x5 */
 #define DAT_TIMEOUT         (HZ    * 5)	/* 1000ms x5 */
 
+#define DEFAULT_DEBOUNCE	(8)	/* 8 cycles CD debounce */
+
 #define PAD_DELAY_MAX	32 /* PAD delay cells */
 /*--------------------------------------------------------------------------*/
 /* Descriptor Structure                                                     */
@@ -372,6 +374,7 @@ struct mtk_mmc_compatible {
 	bool stop_clk_fix;
 	bool enhance_rx;
 	bool support_64g;
+	bool use_internal_cd;
 };
 
 struct msdc_tune_para {
@@ -430,6 +433,7 @@ struct msdc_host {
 	bool hs400_cmd_resp_sel_rising;
 				 /* cmd response sample selection for HS400 */
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
+	bool internal_cd;	/* Use internal card-detect logic */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -526,6 +530,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
 	.busy_check = false,
 	.stop_clk_fix = false,
 	.enhance_rx = false,
+	.use_internal_cd = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1430,6 +1435,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			sdio_signal_irq(host->mmc);
 		}
 
+		if ((events & event_mask) & MSDC_INT_CDSC) {
+			if (host->internal_cd)
+				mmc_detect_change(host->mmc, msecs_to_jiffies(20));
+			events &= ~MSDC_INT_CDSC;
+		}
+
 		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;
 
@@ -1463,14 +1474,24 @@ static void msdc_init_hw(struct msdc_host *host)
 	/* Reset */
 	msdc_reset_hw(host);
 
-	/* Disable card detection */
-	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
-
 	/* Disable and clear all interrupts */
 	writel(0, host->base + MSDC_INTEN);
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
 
+	/* Configure card detection */
+	if (host->internal_cd) {
+		sdr_set_field(host->base + MSDC_PS, MSDC_PS_CDDEBOUNCE,
+			      DEFAULT_DEBOUNCE);
+		sdr_set_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CDSC);
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+	} else {
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+		sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CDSC);
+	}
+
 	if (host->top_base) {
 		writel(0, host->top_base + EMMC_TOP_CONTROL);
 		writel(0, host->top_base + EMMC_TOP_CMD);
@@ -1580,6 +1601,13 @@ static void msdc_init_hw(struct msdc_host *host)
 static void msdc_deinit_hw(struct msdc_host *host)
 {
 	u32 val;
+
+	if (host->internal_cd) {
+		/* Disabled card-detect */
+		sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+	}
+
 	/* Disable and clear all interrupts */
 	writel(0, host->base + MSDC_INTEN);
 
@@ -2078,13 +2106,31 @@ static void msdc_ack_sdio_irq(struct mmc_host *mmc)
 	__msdc_enable_sdio_irq(mmc, 1);
 }
 
+static int msdc_get_cd(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	int val;
+
+	if (mmc->caps & MMC_CAP_NONREMOVABLE)
+		return 1;
+
+	if (!host->internal_cd)
+		return mmc_gpio_get_cd(mmc);
+
+	val = readl(host->base + MSDC_PS) & MSDC_PS_CDSTS;
+	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
+		return !!val;
+	else
+		return !val;
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
-	.get_cd = mmc_gpio_get_cd,
+	.get_cd = msdc_get_cd,
 	.enable_sdio_irq = msdc_enable_sdio_irq,
 	.ack_sdio_irq = msdc_ack_sdio_irq,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
@@ -2216,6 +2262,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	else
 		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
 
+	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    !mmc_can_gpio_cd(mmc) &&
+	    host->dev_comp->use_internal_cd) {
+		/*
+		 * Is removable but no GPIO declared, so
+		 * use internal functionality.
+		 */
+		host->internal_cd = true;
+	}
+
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 


