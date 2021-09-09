Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FD404FFE
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Sep 2021 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbhIIMYE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Sep 2021 08:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353052AbhIIMUL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Sep 2021 08:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13A0D6128B;
        Thu,  9 Sep 2021 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188228;
        bh=Q5XMrTSI9DyeV30QZ8sULXpxduy3HPeYCnQmNk1zuRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4vQc4wnn1kFIkMS2UqxsNhkk7OLYS/Wm9GIkMgCoKCB+Ubn2o0JbuY/Sliw28mxd
         M05QZ1qy8WNHa0nu2a3mARKbPNhMDD0ekV+xpb++SWuCnALhF1C4984WAPxpiD02z5
         FJZ4nOo6wgNjmyRMe9WLB3lCac8atMttkYK8LIZV7NIrcxonBwwfXHIDTPFd1K8dvm
         3jjqh9iCzsVeYLBcIRHhFcUH1RSC2kPdA0omquuCDk0neXv9XzPD2p05SnE2q2DKUb
         LMMqpEdQ0nXmXNQ3loSM6OpvqDsEbGcXB6iP228n2A/oPkIv0X6ZT2L7bLYPSGvjKT
         DiY6K8v64HRfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 181/219] mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
Date:   Thu,  9 Sep 2021 07:45:57 -0400
Message-Id: <20210909114635.143983-181-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114635.143983-1-sashal@kernel.org>
References: <20210909114635.143983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Manish Narani <manish.narani@xilinx.com>

[ Upstream commit c0b4e411a9b09748466ee06d2ae6772effa64dfb ]

SD standard speed timing was met only at 19MHz and not 25 MHz, that's
why changing driver to 19MHz. The reason for this is when a level shifter
is used on the board, timing was met for standard speed only at 19MHz.
Since this level shifter is commonly required for high speed modes,
the driver is modified to use standard speed of 19Mhz.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1623753837-21035-2-git-send-email-manish.narani@xilinx.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 839965f7c717..fc3e41c76ab4 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -159,6 +159,12 @@ struct sdhci_arasan_data {
 /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
  * internal clock even when the clock isn't stable */
 #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
+/*
+ * Some of the Arasan variations might not have timing requirements
+ * met at 25MHz for Default Speed mode, those controllers work at
+ * 19MHz instead
+ */
+#define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
 };
 
 struct sdhci_arasan_of_data {
@@ -290,6 +296,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 		sdhci_arasan->is_phy_on = false;
 	}
 
+	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN) {
+		/*
+		 * Some of the Arasan variations might not have timing
+		 * requirements met at 25MHz for Default Speed mode,
+		 * those controllers work at 19MHz instead.
+		 */
+		if (clock == DEFAULT_SPEED_MAX_DTR)
+			clock = (DEFAULT_SPEED_MAX_DTR * 19) / 25;
+	}
+
 	/* Set the Input and Output Clock Phase Delays */
 	if (clk_data->set_clk_delays)
 		clk_data->set_clk_delays(host);
@@ -1598,6 +1614,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
 		host->mmc_host_ops.execute_tuning =
 			arasan_zynqmp_execute_tuning;
+
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN;
 	}
 
 	arasan_dt_parse_clk_phases(dev, &sdhci_arasan->clk_data);
-- 
2.30.2

