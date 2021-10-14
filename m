Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEECC42DA49
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Oct 2021 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJNN2U (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Oct 2021 09:28:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:8033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhJNN2T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 09:28:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="313873813"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="313873813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="527594024"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2021 06:26:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB51036E; Thu, 14 Oct 2021 16:26:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v3 2/5] mmc: sdhci: Remove unused prototype declaration in the header
Date:   Thu, 14 Oct 2021 16:26:10 +0300
Message-Id: <20211014132613.27861-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
References: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_card_detect() is not defined anywhere. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c593af479832..bb883553d3b4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -750,7 +750,6 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 	return host->private;
 }
 
-void sdhci_card_detect(struct sdhci_host *host);
 void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 		       const u32 *caps, const u32 *caps1);
 int sdhci_setup_host(struct sdhci_host *host);
-- 
2.33.0

