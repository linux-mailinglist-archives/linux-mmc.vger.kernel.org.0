Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8023DD6B
	for <lists+linux-mmc@lfdr.de>; Thu,  6 Aug 2020 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgHFRJP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 6 Aug 2020 13:09:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35094 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgHFRGC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E8DF1A09FD;
        Thu,  6 Aug 2020 13:53:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 831351A0A00;
        Thu,  6 Aug 2020 13:53:09 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D79040302;
        Thu,  6 Aug 2020 13:53:04 +0200 (CEST)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending tuning command for manual tuning method
Date:   Thu,  6 Aug 2020 19:48:24 +0800
Message-Id: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

According to IC suggestion, everytime before sending the tuning command,
need to reset the usdhc, so to reset the tuning circuit, to let every
tuning command work well for the manual tuning method. For standard
tuning method, IC already add the reset operation in the logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a76b4513fbec..e4694eb1b914 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -990,6 +990,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
+	sdhci_reset(host, SDHCI_RESET_ALL);
 
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
-- 
2.17.1

