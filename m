Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4A3EB5D7
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Aug 2021 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhHMM4O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Aug 2021 08:56:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43802 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239708AbhHMM4O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Aug 2021 08:56:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 69F931A167B;
        Fri, 13 Aug 2021 14:55:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31E211A1503;
        Fri, 13 Aug 2021 14:55:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F8DA183AC89;
        Fri, 13 Aug 2021 20:55:45 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH] mmc: sdhci: correct the tuning command handle for PIO mode
Date:   Fri, 13 Aug 2021 20:34:01 +0800
Message-Id: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

If sdhci use PIO mode, and use mmc_send_tuning() to send the
tuning command, system will stuck because of the storm irq
of sdhci. For PIO mode, use mmc_send_tuning(), it will trigger
buffer_read_ready interrupt and data transfer complete interrupt.
In current code logic, it will directly return in sdhci_data_irq,
can not call the sdhci_transfer_pio(). So the buffer_read_ready
interrupt storm happen. So for standard tuning method, need to
excluse this case.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aba6e10b8605..acee54b368b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3278,8 +3278,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
 	u32 command;
 
-	/* CMD19 generates _only_ Buffer Read Ready interrupt */
-	if (intmask & SDHCI_INT_DATA_AVAIL) {
+	/*
+	 * CMD19 generates _only_ Buffer Read Ready interrupt if
+	 * use sdhci_send_tuning.
+	 * Need to exclude this case: PIO mode and use mmc_send_tuning,
+	 * If not, sdhci_transfer_pio will never be called, make the
+	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
+	 */
+	if ((intmask & SDHCI_INT_DATA_AVAIL) && (!host->data)) {
 		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
 		if (command == MMC_SEND_TUNING_BLOCK ||
 		    command == MMC_SEND_TUNING_BLOCK_HS200) {
-- 
2.17.1

