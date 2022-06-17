Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19E754EFF0
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Jun 2022 06:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiFQEDK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Jun 2022 00:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiFQEDI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2022 00:03:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4090D13F3F;
        Thu, 16 Jun 2022 21:03:07 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D09E0812F;
        Fri, 17 Jun 2022 03:58:15 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: sdhci-omap: Fix a lockdep warning for PM runtime init
Date:   Fri, 17 Jun 2022 07:03:00 +0300
Message-Id: <20220617040300.30321-1-tony@atomide.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We need hardware enabled early in probe to detect capabilities, but must
not call sdhci_runtime_resume_host() until sdhci_setup_host() has been
called. Let's check for an initialized controller like we already do
for context restore.

Fixes: f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1441,7 +1441,8 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
-	sdhci_runtime_suspend_host(host);
+	if (omap_host->con != -EINVAL)
+		sdhci_runtime_suspend_host(host);
 
 	sdhci_omap_context_save(omap_host);
 
@@ -1458,10 +1459,10 @@ static int __maybe_unused sdhci_omap_runtime_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	if (omap_host->con != -EINVAL)
+	if (omap_host->con != -EINVAL) {
 		sdhci_omap_context_restore(omap_host);
-
-	sdhci_runtime_resume_host(host, 0);
+		sdhci_runtime_resume_host(host, 0);
+	}
 
 	return 0;
 }
-- 
2.36.1
