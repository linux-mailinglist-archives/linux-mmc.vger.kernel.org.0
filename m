Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C39FC530
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfKNLSP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 06:18:15 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35936 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfKNLSP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Nov 2019 06:18:15 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1D001A00E4;
        Thu, 14 Nov 2019 12:18:13 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75D8A1A000A;
        Thu, 14 Nov 2019 12:18:11 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BE24B402FB;
        Thu, 14 Nov 2019 19:18:08 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci: fix up CMD12 sending
Date:   Thu, 14 Nov 2019 19:18:14 +0800
Message-Id: <20191114111814.35199-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The STOP command is disabled for multiple blocks r/w commands
with auto CMD12, when start to send. However, if there is data
error, software still needs to send CMD12 according to SD spec.
This patch is to allow software CMD12 sending for this case.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 09cdbe8..3041c39 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
 
 	/*
 	 * Need to send CMD12 if -
-	 * a) open-ended multiblock transfer (no CMD23)
+	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
 	 * b) error in multiblock transfer
 	 */
 	if (data->stop &&
-	    (data->error ||
-	     !data->mrq->sbc)) {
+	    ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
+	     data->error)) {
 		/*
 		 * 'cap_cmd_during_tfr' request must not use the command line
 		 * after mmc_command_done() has been called. It is upper layer's
@@ -1825,17 +1825,6 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	sdhci_led_activate(host);
 
-	/*
-	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
-	 * requests if Auto-CMD12 is enabled.
-	 */
-	if (sdhci_auto_cmd12(host, mrq)) {
-		if (mrq->stop) {
-			mrq->data->stop = NULL;
-			mrq->stop = NULL;
-		}
-	}
-
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
-- 
2.7.4

