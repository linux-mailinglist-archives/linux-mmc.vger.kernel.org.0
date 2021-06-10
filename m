Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CBA3A2B55
	for <lists+linux-mmc@lfdr.de>; Thu, 10 Jun 2021 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFJMVe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 10 Jun 2021 08:21:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52564 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhFJMVd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Jun 2021 08:21:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 71D041A054F;
        Thu, 10 Jun 2021 14:19:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 71D041A054F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1623327576;
        bh=EZ3FppNteKzYjJs/t69gGzPnD6M6vtQMyzx3Nj0MQVk=;
        h=From:To:Cc:Subject:Date:From;
        b=VrMAm9HqxBt+7ZuJx+/d8y9PpQ0Oj8ywJNH4xSPFMyBvnc31bnwxcqIY7vYZSXVn2
         b3dT4JXfx/HivwIiEIstoedWcQEga3+tzaMSi87BT68t+Z7xdb/PKEWESYDDXyL3jD
         gPKtCYsR0rub9SoTKthMdXs78ZTxhFlBJfQNn2w8tsg5AcIK6TKYiQb5jkaqES2Qfa
         qh0wr3M8LXGkZcDr7zEXOnVhcIDF5dWeUyLSlskdOyhvc12DAPQ6c1ZRhvDEhjGPsQ
         eAyv3Vaji8fafhTTkhLGtUZY8tYa7UgMNouXoIfWqgRNNvA18a4FlDSugBABXA3eTz
         C+F/t8jjba6zg==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B81B61A2DAE;
        Thu, 10 Jun 2021 14:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com B81B61A2DAE
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DF72F402CF;
        Thu, 10 Jun 2021 20:19:27 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: add sdio wakeup feature
Date:   Thu, 10 Jun 2021 20:01:26 +0800
Message-Id: <1623326486-25275-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Set the wakeup capability for the SDIO device which can wakeup system.
And user can enable this wakeup through sysfs interface.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7336ae749137..72c0bf0c1887 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1620,6 +1620,14 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ahb_clk;
 
+	/*
+	 * Setup the wakeup capability here, let user to decide
+	 * whether need to enable this wakeup through sysfs interface.
+	 */
+	if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
+			(host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ))
+		device_set_wakeup_capable(&pdev->dev, true);
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.17.1

