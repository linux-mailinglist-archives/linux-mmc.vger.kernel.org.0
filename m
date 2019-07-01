Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49945772
	for <lists+linux-mmc@lfdr.de>; Fri, 14 Jun 2019 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFNI2L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 14 Jun 2019 04:28:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48906 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfFNI2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Jun 2019 04:28:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94BDC200077;
        Fri, 14 Jun 2019 10:28:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4A232005D4;
        Fri, 14 Jun 2019 10:28:04 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C9B6C402DD;
        Fri, 14 Jun 2019 16:27:59 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangbo.lu@nxp.com
Subject: [PATCH v1] mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1028a
Date:   Fri, 14 Jun 2019 16:29:54 +0800
Message-Id: <20190614082954.39648-2-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614082954.39648-1-yinbo.zhu@nxp.com>
References: <20190614082954.39648-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

LS1028A used 1/2 periperhal clock as one reference clock.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c56c7d413a09..4dd43b1adf2c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1048,11 +1048,12 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 		/*
 		 * esdhc->peripheral_clock would be assigned with a value
 		 * which is eSDHC base clock when use periperal clock.
-		 * For ls1046a, the clock value got by common clk API is
-		 * peripheral clock while the eSDHC base clock is 1/2
-		 * peripheral clock.
+		 * For some platforms, the clock value got by common clk
+		 * API is peripheral clock while the eSDHC base clock is
+		 * 1/2 peripheral clock.
 		 */
-		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
+		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc") ||
+		    of_device_is_compatible(np, "fsl,ls1028a-esdhc"))
 			esdhc->peripheral_clock = clk_get_rate(clk) / 2;
 		else
 			esdhc->peripheral_clock = clk_get_rate(clk);
-- 
2.17.1

