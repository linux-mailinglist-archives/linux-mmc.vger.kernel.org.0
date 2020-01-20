Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648BA1427A5
	for <lists+linux-mmc@lfdr.de>; Mon, 20 Jan 2020 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgATJuY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 Jan 2020 04:50:24 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48836 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgATJuY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 04:50:24 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A18B31A058D;
        Mon, 20 Jan 2020 10:50:22 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 996131A0BE8;
        Mon, 20 Jan 2020 10:50:20 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0DCCA402E3;
        Mon, 20 Jan 2020 17:50:17 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: fix serious issue clock is always disabled
Date:   Mon, 20 Jan 2020 17:48:35 +0800
Message-Id: <20200120094835.28050-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is to fix a serious issue that clock is always disabled
in esdhc_of_set_clock().

Fixes: 1b21a701aed9 ("mmc: sdhci-of-esdhc: fix clock setting for different controller versions")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8c06017..2950ae2 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -745,7 +745,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		esdhc_clock_enable(host, false);
 		esdhc_flush_async_fifo(host);
 	}
-	esdhc_clock_enable(host, false);
+	esdhc_clock_enable(host, true);
 }
 
 static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
-- 
2.7.4

