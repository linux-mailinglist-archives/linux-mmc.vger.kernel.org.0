Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7877D0878
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJIHko (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 03:40:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42350 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJIHko (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Oct 2019 03:40:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4649A1A09F9;
        Wed,  9 Oct 2019 09:40:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E4ECE1A03BD;
        Wed,  9 Oct 2019 09:40:40 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A229F402DA;
        Wed,  9 Oct 2019 15:40:37 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 1/2] mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
Date:   Wed,  9 Oct 2019 15:41:39 +0800
Message-Id: <20191009074140.3934-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009074140.3934-1-yangbo.lu@nxp.com>
References: <20191009074140.3934-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ESDHC_FLUSH_ASYNC_FIFO bit which is set to flush asynchronous FIFO
should be polled until it's auto cleared by hardware.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- Converted to use esdhc_flush_async_fifo() and usleep_range().
---
 drivers/mmc/host/sdhci-of-esdhc.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 1d1953d..d4bcf95 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -560,6 +560,32 @@ static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
 	}
 }
 
+static void esdhc_flush_async_fifo(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 val;
+
+	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	val |= ESDHC_FLUSH_ASYNC_FIFO;
+	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readl(host, ESDHC_DMA_SYSCTL) &
+		      ESDHC_FLUSH_ASYNC_FIFO))
+			break;
+		if (timedout) {
+			pr_err("%s: flushing asynchronous FIFO timeout.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+		usleep_range(10, 20);
+	}
+}
+
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -652,9 +678,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
 
 		esdhc_clock_enable(host, false);
-		temp = sdhci_readl(host, ESDHC_DMA_SYSCTL);
-		temp |= ESDHC_FLUSH_ASYNC_FIFO;
-		sdhci_writel(host, temp, ESDHC_DMA_SYSCTL);
+		esdhc_flush_async_fifo(host);
 	}
 
 	/* Wait max 20 ms */
@@ -814,10 +838,7 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
 	u32 val;
 
 	esdhc_clock_enable(host, false);
-
-	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
-	val |= ESDHC_FLUSH_ASYNC_FIFO;
-	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+	esdhc_flush_async_fifo(host);
 
 	val = sdhci_readl(host, ESDHC_TBCTL);
 	if (enable)
-- 
2.7.4

