Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993ACFDBFB
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOLKT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 06:10:19 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51052 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLKT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Nov 2019 06:10:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B5742000E5;
        Fri, 15 Nov 2019 12:10:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D921200066;
        Fri, 15 Nov 2019 12:10:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0578B402F8;
        Fri, 15 Nov 2019 19:10:09 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 02/14] mmc: sdhci: clear DMA_SEL before sending tuning command for Standard tuning
Date:   Fri, 15 Nov 2019 19:07:54 +0800
Message-Id: <1573816075-26390-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Currently, when use standard tuning, driver default disable DMA just before
send tuning command. But on i.MX8 usdhc, this is not enough. Need also clear
DMA_SEL. If not, once the DMA_SEL select AMDA2 before, even dma already disabled,
when send tuning command, usdhc will still prefetch the ADMA script from wrong
DMA address, then we will see IOMMU report some error which show lack of TLB
mapping.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 68db86c1b4c9..1436cc9c5f82 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2361,6 +2361,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	struct mmc_request mrq = {};
 	unsigned long flags;
 	u32 b = host->sdma_boundary;
+	u8 ctrl;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2388,6 +2389,17 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
+
+	/* DMA already disabled, so clear the DMA Select here.
+	 * Otherwise, if use ADMA2, even disable DMA, some
+	 * controllers like i.MX usdhc will still prefetch the
+	 * ADMA script when send tuning command, which will cause
+	 * IOMMU report lack of TLB mapping error
+	 */
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl &= ~SDHCI_CTRL_DMA_MASK;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
 	sdhci_send_command(host, &cmd);
 
 	host->cmd = NULL;
-- 
2.17.1

