Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B2B468F
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 06:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfIQEpD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 00:45:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51148 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfIQEpD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 00:45:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A78FE1A0648;
        Tue, 17 Sep 2019 06:45:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A8101A0663;
        Tue, 17 Sep 2019 06:44:59 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF44B402C4;
        Tue, 17 Sep 2019 12:44:55 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/3] mmc: sdhci: introduce start_tuning() hook
Date:   Tue, 17 Sep 2019 12:46:29 +0800
Message-Id: <20190917044631.3161-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917044631.3161-1-yangbo.lu@nxp.com>
References: <20190917044631.3161-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The tuning start process may be different from standard SD controller
for some specific controllers, like eSDHC and F_SDH30 (which is using
SDHCI_QUIRK2_TUNING_WORK_AROUND now). So introduce a start_tuning() hook.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aa..2f40490 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2471,7 +2471,10 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->tuning_delay < 0)
 		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
 
-	sdhci_start_tuning(host);
+	if (host->ops->start_tuning)
+		host->ops->start_tuning(host);
+	else
+		sdhci_start_tuning(host);
 
 	host->tuning_err = __sdhci_execute_tuning(host, opcode);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 902f855..30c8349a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -643,6 +643,7 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*start_tuning)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.7.4

