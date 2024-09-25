Return-Path: <linux-mmc+bounces-3981-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB939859B5
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Sep 2024 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A971C21082
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Sep 2024 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1552175D4B;
	Wed, 25 Sep 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WbqMT3PS"
X-Original-To: linux-mmc@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D81AD3FB;
	Wed, 25 Sep 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264401; cv=none; b=emIjq24RX7zHN2zXyOYxNLvzpIiXg+udLZ6fpPsNjV2jy6bHtnxTqkRUUFuaGy2SgtC901nsx1LNFCUK9B+7wQ/84P8FrW7aIWLQqWayElor5plH1ii2fAyZMiEg/uaLQoPm1wEes6xtXya6Yp+ngKgUJeOQC/2OmsdvxnGgrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264401; c=relaxed/simple;
	bh=7gRw46b0f+Sja2/CBpKqTi59zrLbvDkgMdNYSRtjEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbloJpNnPAUL4rJAMwuu3aucxWqfs/kui3CE+yEfKKBAwYaaDcI5UaPLrvVcU/ceuYl/xCxcL+HuLCButGRFa6g+jvBboVscTvIOI//8AYVUzq19EQTyf1RijJbw4BwIVm3bzAXfQjaivld1i5mvjjP2qit9cEtyTHpQGJ8VY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WbqMT3PS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727264392;
	bh=7gRw46b0f+Sja2/CBpKqTi59zrLbvDkgMdNYSRtjEWg=;
	h=From:To:Cc:Subject:Date:From;
	b=WbqMT3PSVNr7sjvJErkS85CATCsNFDdZWnuVb02zWp5eiae9ZK6RX+4WAMUHUr2Al
	 ACFkQHrkOsZveYXrNtUbhFegQQYhkTSDc7aY3HTzxJx1GtHwRNcAxwxx2ZUNBREQjN
	 JmDz6v78jvhJXnlim/kB0RdocY7wAmbq7RanyH9qjpMSkf42+uG40KWDbOeWf2zyfB
	 PesKwVL2lvqnFoTmZMdXRzVEcTIcDFvgd3oiDBYmZPzHSTvTaPg2EypOMyZ3pUibnz
	 aj5d9xrJeIETV1hJM5trQtYhM6HVj5GQChT9xZm1Jxqn5Ni/K/3IDMedy5Gz8vdTNd
	 ozKZA1IBWwFoQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDAF317E1270;
	Wed, 25 Sep 2024 13:39:51 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chaotian.jing@mediatek.com
Cc: ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] mmc: mtk-sd: Implement Host Software Queue for eMMC and SD Card
Date: Wed, 25 Sep 2024 13:39:49 +0200
Message-ID: <20240925113949.149655-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Host Software Queue (HSQ) and enable it when the
controller instance does not have Command Queue Engine HW support.

It was chosen to enable HSQ only for eMMC and SD/MicroSD cards
and not for SDIO as performance improvements are seen only for
the former.

Performance was measured with a SanDisk Extreme Ultra A2 MicroSD
card in a MediaTek MT8195T Acer Chromebook Spin 513 (CP513-2H),
by running FIO (bs=4k) on an ArchLinux userspace.

.... Summarizing ....
Random read:     +24.28% IOPS, +24.29% BW
Sequential read: +3.14%  IOPS, +3.49%  BW
Random RW (avg): +50.53% IOPS, +50.68% BW

Below, more data from the benchmarks.

Before:
 - Random read: IOPS=1643, BW=6574KiB/s
   bw (  KiB/s): min= 4578, max= 7440, per=99.95%, avg=6571.55, stdev=74.16, samples=953
   iops        : min= 1144, max= 1860, avg=1642.14, stdev=18.54, samples=953
   lat (msec)  : 100=0.01%, 250=0.12%, 500=0.38%, 750=97.89%, 1000=1.44%, 2000=0.16%
 - Sequential read: IOPS=19.1k, BW=74.4MiB/s
   bw (  KiB/s): min=12288, max=118483, per=100.00%, avg=76293.38, stdev=1971.42, samples=956
   iops        : min= 3072, max=29620, avg=19072.14, stdev=492.87, samples=956
   lat (msec)  : 4=0.01%, 10=0.01%, 20=0.21%, 50=23.95%, 100=75.67%, 250=0.05%, 500=0.03%, 750=0.08%
 - Random R/W: read: IOPS=282, BW=1129KiB/s (1156kB/s)  write: IOPS=284, BW=1136KiB/s
   read bw (  KiB/s): min=   31, max= 3496, per=100.00%, avg=1703.67, stdev=155.42, samples=630
   read iops        : min=    7, max=  873, avg=425.22, stdev=38.85, samples=630
   wri  bw (  KiB/s): min=   31, max= 3443, per=100.00%, avg=1674.27, stdev=164.23, samples=644
   wri  iops        : min=    7, max=  860, avg=417.87, stdev=41.03, samples=644
   lat (msec)   : 250=0.13%, 500=0.44%, 750=0.84%, 1000=22.29%, 2000=74.01%, >=2000=2.30%

After:
 - Random read: IOPS=2042, BW=8171KiB/s
   bw (  KiB/s): min= 4907, max= 9072, per=99.94%, avg=8166.80, stdev=93.77, samples=954
   iops        : min= 1226, max= 2268, avg=2040.78, stdev=23.41, samples=954
   lat (msec)   : 100=0.03%, 250=0.13%, 500=52.88%, 750=46.64%, 1000=0.32%
 - Sequential read: IOPS=19.7k, BW=77.0MiB/s
   bw (  KiB/s): min=67980, max=94248, per=100.00%, avg=78894.27, stdev=1475.07, samples=956
   iops        : min=16994, max=23562, avg=19722.45, stdev=368.76, samples=956
   lat (msec)   : 4=0.01%, 10=0.01%, 20=0.05%, 50=28.78%, 100=71.14%, 250=0.01%, 500=0.02%
 - Random R/W: read: IOPS=424, BW=1699KiB/s  write: IOPS=428, BW=1714KiB/s
   read bw (  KiB/s): min=  228, max= 2856, per=100.00%, avg=1796.60, stdev=112.59, samples=901
   read iops        : min=   54, max=  712, avg=447.81, stdev=28.21, samples=901
   wri  bw (  KiB/s): min=   28, max= 2904, per=100.00%, avg=1780.11, stdev=128.27, samples=916
   wri  iops        : min=    4, max=  724, avg=443.69, stdev=32.14, samples=916

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 49 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5165a33bf74b..57ae5840696f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -33,6 +33,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "cqhci.h"
+#include "mmc_hsq.h"
 
 #define MAX_BD_NUM          1024
 #define MSDC_NR_CLOCKS      3
@@ -473,6 +474,7 @@ struct msdc_host {
 	bool hs400_tuning;	/* hs400 mode online tuning */
 	bool internal_cd;	/* Use internal card-detect logic */
 	bool cqhci;		/* support eMMC hw cmdq */
+	bool hsq_en;		/* Host Software Queue is enabled */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -1170,7 +1172,9 @@ static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 
 static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 {
+	struct mmc_host *mmc = mmc_from_priv(host);
 	unsigned long flags;
+	bool hsq_req_done;
 
 	/*
 	 * No need check the return value of cancel_delayed_work, as only ONE
@@ -1178,6 +1182,27 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	 */
 	cancel_delayed_work(&host->req_timeout);
 
+	/*
+	 * If the request was handled from Host Software Queue, there's almost
+	 * nothing to do here, and we also don't need to reset mrq as any race
+	 * condition would not have any room to happen, since HSQ stores the
+	 * "scheduled" mrqs in an internal array of mrq slots anyway.
+	 * However, if the controller experienced an error, we still want to
+	 * reset it as soon as possible.
+	 *
+	 * Note that non-HSQ requests will still be happening at times, even
+	 * though it is enabled, and that's what is going to reset host->mrq.
+	 * Also, msdc_unprepare_data() is going to be called by HSQ when needed
+	 * as HSQ request finalization will eventually call the .post_req()
+	 * callback of this driver which, in turn, unprepares the data.
+	 */
+	hsq_req_done = host->hsq_en ? mmc_hsq_finalize_request(mmc, mrq) : false;
+	if (hsq_req_done) {
+		if (host->error)
+			msdc_reset_hw(host);
+		return;
+	}
+
 	spin_lock_irqsave(&host->lock, flags);
 	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1187,7 +1212,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 		msdc_unprepare_data(host, mrq->data);
 	if (host->error)
 		msdc_reset_hw(host);
-	mmc_request_done(mmc_from_priv(host), mrq);
+	mmc_request_done(mmc, mrq);
 	if (host->dev_comp->recheck_sdio_irq)
 		msdc_recheck_sdio_irq(host);
 }
@@ -1347,7 +1372,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct msdc_host *host = mmc_priv(mmc);
 
 	host->error = 0;
-	WARN_ON(host->mrq);
+	WARN_ON(!host->hsq_en && host->mrq);
 	host->mrq = mrq;
 
 	if (mrq->data)
@@ -2916,6 +2941,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		mmc->max_seg_size = 64 * 1024;
 		/* Reduce CIT to 0x40 that corresponds to 2.35us */
 		msdc_cqe_cit_cal(host, 2350);
+	} else if (mmc->caps2 & MMC_CAP2_NO_SDIO) {
+		/* Use HSQ on eMMC/SD (but not on SDIO) if HW CQE not supported */
+		struct mmc_hsq *hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+		if (!hsq) {
+			ret = -ENOMEM;
+			goto release;
+		}
+
+		ret = mmc_hsq_init(hsq, mmc);
+		if (ret)
+			goto release;
+
+		host->hsq_en = true;
 	}
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
@@ -3043,6 +3081,9 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
 
+	if (host->hsq_en)
+		mmc_hsq_suspend(mmc);
+
 	msdc_save_reg(host);
 
 	if (sdio_irq_claimed(mmc)) {
@@ -3073,6 +3114,10 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 		pinctrl_select_state(host->pinctrl, host->pins_uhs);
 		enable_irq(host->irq);
 	}
+
+	if (host->hsq_en)
+		mmc_hsq_resume(mmc);
+
 	return 0;
 }
 
-- 
2.46.1


