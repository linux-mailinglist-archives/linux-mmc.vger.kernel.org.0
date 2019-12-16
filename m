Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E172F1200DC
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Dec 2019 10:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLPJUF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Dec 2019 04:20:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47258 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfLPJUF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Dec 2019 04:20:05 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39C9E1A1848;
        Mon, 16 Dec 2019 10:20:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 173491A182B;
        Mon, 16 Dec 2019 10:20:02 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E95B740296;
        Mon, 16 Dec 2019 17:19:58 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1088a
Date:   Mon, 16 Dec 2019 17:19:11 +0800
Message-Id: <20191216091911.14840-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The eSDHC on LS1088A platform uses 1/2 peripheral clock as base
clock.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7f87a90..f43abcf 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1228,7 +1228,8 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 		 * 1/2 peripheral clock.
 		 */
 		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc") ||
-		    of_device_is_compatible(np, "fsl,ls1028a-esdhc"))
+		    of_device_is_compatible(np, "fsl,ls1028a-esdhc") ||
+		    of_device_is_compatible(np, "fsl,ls1088a-esdhc"))
 			esdhc->peripheral_clock = clk_get_rate(clk) / 2;
 		else
 			esdhc->peripheral_clock = clk_get_rate(clk);
-- 
2.7.4

