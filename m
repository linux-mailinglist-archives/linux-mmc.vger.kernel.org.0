Return-Path: <linux-mmc+bounces-83-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1117EBE9D
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 09:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603471F26643
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947D2F3A;
	Wed, 15 Nov 2023 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-mmc@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6132E835
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 08:34:46 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB80F1;
	Wed, 15 Nov 2023 00:34:44 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3AF8YECt071583;
	Wed, 15 Nov 2023 16:34:14 +0800 (+08)
	(envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SVbtC2D7lz2N1Kdv;
	Wed, 15 Nov 2023 16:29:07 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 15 Nov
 2023 16:34:13 +0800
From: Wenchao Chen <wenchao.chen@unisoc.com>
To: <ulf.hansson@linaro.org>, <zhang.lyra@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2] mmc: sprd: Fix vqmmc not shutting down after the card was pulled
Date: Wed, 15 Nov 2023 16:34:06 +0800
Message-ID: <20231115083406.7368-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL:SHSQR01.spreadtrum.com 3AF8YECt071583

With cat regulator_summary, we found that vqmmc was not shutting
down after the card was pulled.

cat /sys/kernel/debug/regulator/regulator_summary
1.before fix
1)Insert SD card
 vddsdio		1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2.after fix
1)Insert SD cardt
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio		0    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Change in v2:
- Remove useless sdhci_sprd_signal_voltage_switch and power_mode.
- Use mmc_regulator_get_supply in probe to prevent sdhci_setup_host
  from powering up vqmmc.
---
 drivers/mmc/host/sdhci-sprd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b84ba27e6ab..6b8a57e2d20f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -416,12 +416,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -823,6 +844,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-- 
2.17.1


