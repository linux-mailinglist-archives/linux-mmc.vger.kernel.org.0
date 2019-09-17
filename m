Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D98B4690
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfIQEpE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 00:45:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390794AbfIQEpE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 00:45:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 442101A0B02;
        Tue, 17 Sep 2019 06:45:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBA441A0642;
        Tue, 17 Sep 2019 06:44:59 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CA7B402CA;
        Tue, 17 Sep 2019 12:44:56 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
Date:   Tue, 17 Sep 2019 12:46:30 +0800
Message-Id: <20190917044631.3161-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917044631.3161-1-yangbo.lu@nxp.com>
References: <20190917044631.3161-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ESDHC_FLUSH_ASYNC_FIFO bit which is set to flush asynchronous FIFO
should be polled until it's auto cleared by hardware.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4dd43b1..a01d3a5 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -650,6 +650,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		temp = sdhci_readl(host, ESDHC_DMA_SYSCTL);
 		temp |= ESDHC_FLUSH_ASYNC_FIFO;
 		sdhci_writel(host, temp, ESDHC_DMA_SYSCTL);
+		/* Wait max 20 ms */
+		timeout = ktime_add_ms(ktime_get(), 20);
+		while (1) {
+			bool timedout = ktime_after(ktime_get(), timeout);
+
+			if (!(sdhci_readl(host, ESDHC_DMA_SYSCTL) &
+			      ESDHC_FLUSH_ASYNC_FIFO))
+				break;
+			if (timedout) {
+				pr_err("%s: tuning block polling FLUSH_ASYNC_FIFO timeout.\n",
+					mmc_hostname(host->mmc));
+				break;
+			}
+			udelay(10);
+		}
 	}
 
 	/* Wait max 20 ms */
@@ -806,6 +821,7 @@ static struct soc_device_attribute soc_fixup_tuning[] = {
 
 static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
 {
+	ktime_t timeout;
 	u32 val;
 
 	esdhc_clock_enable(host, false);
@@ -814,6 +830,22 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
 	val |= ESDHC_FLUSH_ASYNC_FIFO;
 	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
 
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readl(host, ESDHC_DMA_SYSCTL) &
+		      ESDHC_FLUSH_ASYNC_FIFO))
+			break;
+		if (timedout) {
+			pr_err("%s: tuning block polling FLUSH_ASYNC_FIFO timeout.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+		udelay(10);
+	}
+
 	val = sdhci_readl(host, ESDHC_TBCTL);
 	if (enable)
 		val |= ESDHC_TB_EN;
-- 
2.7.4

