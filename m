Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB58125BD18
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Sep 2020 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgICIUc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Sep 2020 04:20:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:36764 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgICIUc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Sep 2020 04:20:32 -0400
IronPort-SDR: UAhQwI9nWr5N0Ssk91Enat0eUs15ciWos+Mpf9aZyd9VfUitB9WC+vPWh1uI8SDDj4GleLaAws
 HrPm3i/171hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="242356326"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="242356326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 01:20:31 -0700
IronPort-SDR: us9vTGT33QbxjZoviJb7le3HTC8FOUlIec36VMhX5tXlhCcvcPW9B/SKFJcwEJiMvCa3zvNnDf
 7Vbl3UaoRlmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="334396201"
Received: from slisovsk-lenovo-ideapad-720s-13ikb.fi.intel.com (HELO ahunter-Desktop.fi.intel.com) ([10.237.72.190])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2020 01:20:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Yue Hu <huyue2@yulong.com>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] mmc: sdio: Use mmc_pre_req() / mmc_post_req()
Date:   Thu,  3 Sep 2020 11:20:07 +0300
Message-Id: <20200903082007.18715-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI changed from using a tasklet to finish requests, to using an IRQ
thread i.e. commit c07a48c2651965 ("mmc: sdhci: Remove finish_tasklet").
Because this increased the latency to complete requests, a preparatory
change was made to complete the request from the IRQ handler if
possible i.e. commit 19d2f695f4e827 ("mmc: sdhci: Call mmc_request_done()
from IRQ handler if possible").  That alleviated the situation for MMC
block devices because the MMC block driver makes use of mmc_pre_req()
and mmc_post_req() so that successful requests are completed in the IRQ
handler and any DMA unmapping is handled separately in mmc_post_req().
However SDIO was still affected, and an example has been reported with
up to 20% degradation in performance.

Looking at SDIO I/O helper functions, sdio_io_rw_ext_helper() appeared
to be a possible candidate for making use of asynchronous requests
within its I/O loops, but analysis revealed that these loops almost
never iterate more than once, so the complexity of the change would not
be warrented.

Instead, mmc_pre_req() and mmc_post_req() are added before and after I/O
submission (mmc_wait_for_req) in mmc_io_rw_extended().  This still has
the potential benefit of reducing the duration of interrupt handlers, as
well as addressing the latency issue for SDHCI.  It also seems a more
reasonable solution than forcing drivers to do everything in the IRQ
handler.

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: c07a48c2651965 ("mmc: sdhci: Remove finish_tasklet")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/sdio_ops.c | 39 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 93d346c01110..4c229dd2b6e5 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -121,6 +121,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	struct sg_table sgtable;
 	unsigned int nents, left_size, i;
 	unsigned int seg_size = card->host->max_seg_size;
+	int err;
 
 	WARN_ON(blksz == 0);
 
@@ -170,28 +171,32 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 
 	mmc_set_data_timeout(&data, card);
 
-	mmc_wait_for_req(card->host, &mrq);
+	mmc_pre_req(card->host, &mrq);
 
-	if (nents > 1)
-		sg_free_table(&sgtable);
+	mmc_wait_for_req(card->host, &mrq);
 
 	if (cmd.error)
-		return cmd.error;
-	if (data.error)
-		return data.error;
-
-	if (mmc_host_is_spi(card->host)) {
+		err = cmd.error;
+	else if (data.error)
+		err = data.error;
+	else if (mmc_host_is_spi(card->host))
 		/* host driver already reported errors */
-	} else {
-		if (cmd.resp[0] & R5_ERROR)
-			return -EIO;
-		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
-			return -EINVAL;
-		if (cmd.resp[0] & R5_OUT_OF_RANGE)
-			return -ERANGE;
-	}
+		err = 0;
+	else if (cmd.resp[0] & R5_ERROR)
+		err = -EIO;
+	else if (cmd.resp[0] & R5_FUNCTION_NUMBER)
+		err = -EINVAL;
+	else if (cmd.resp[0] & R5_OUT_OF_RANGE)
+		err = -ERANGE;
+	else
+		err = 0;
 
-	return 0;
+	mmc_post_req(card->host, &mrq, err);
+
+	if (nents > 1)
+		sg_free_table(&sgtable);
+
+	return err;
 }
 
 int sdio_reset(struct mmc_host *host)
-- 
2.17.1

