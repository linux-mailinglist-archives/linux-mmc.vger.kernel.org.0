Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB801832EA
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Mar 2020 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCLOZv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Mar 2020 10:25:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:41667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOZv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348397"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:25:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 1/3] mmc: core: Try harder if transfer mode switch fails
Date:   Thu, 12 Mar 2020 16:24:59 +0200
Message-Id: <20200312142501.9868-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142501.9868-1-adrian.hunter@intel.com>
References: <20200312142501.9868-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add extra busy wait and retries if transfer mode switch fails.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa0cab190cd8..619088a94688 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -599,6 +599,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.sanitize_busy = true;
 
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	if (err && index == EXT_CSD_HS_TIMING) {
+		/* Try harder for timing changes */
+		__mmc_poll_for_busy(card, timeout_ms, send_status,
+				    retry_crc_err, MMC_BUSY_CMD6);
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	}
 	if (err)
 		goto out;
 
-- 
2.17.1

