Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43126A3960
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH3OjT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 10:39:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:28588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfH3OjT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Aug 2019 10:39:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 07:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="182666581"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2019 07:39:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB46A10B; Fri, 30 Aug 2019 17:39:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mmc: mmc_spi: Convert to use for_each_sg()
Date:   Fri, 30 Aug 2019 17:39:16 +0300
Message-Id: <20190830143916.21793-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use for_each_sg() macro instead of open coded variant.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 19544b121276..66e354d51ee9 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -891,7 +891,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	/* Handle scatterlist segments one at a time, with synch for
 	 * each 512-byte block
 	 */
-	for (sg = data->sg, n_sg = data->sg_len; n_sg; n_sg--, sg++) {
+	for_each_sg(data->sg, sg, data->sg_len, n_sg) {
 		int			status = 0;
 		dma_addr_t		dma_addr = 0;
 		void			*kmap_addr;
-- 
2.23.0.rc1

