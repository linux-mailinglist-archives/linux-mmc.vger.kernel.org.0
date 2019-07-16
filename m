Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C06A401
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfGPIj3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 04:39:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46445 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPIj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 04:39:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so8747243pfb.13
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uAruQz0/cDNuufDZKPd/IRh0T9ZXWWj4lYhqkpVhEs8=;
        b=zlPZOySkHLqWi+pEQXn481ljUFj//r2HStU4XwfOEHuqTYckG6+odAWQB6yBM+AJo9
         Jqi7O/vwEWuAtot0CprqN00OBe2kE7i9b66IFM/8p3LWctT2QNtwl/nAA3+TiXkMEpks
         ip610KlGxk+PO5NXXj2dSSziXfGGs0XPyviaRMyAUZ8sVP78oSoiiM6/a8EDdE88HRYM
         nTcYEHp+mYumdlGZ3VxKgNrjzCKiy8kBazB/CmEOr6WmPo45iw96SRdgJ9nyiICC/paB
         tp6JRBVzXNlX6sj93xFOMCC2EgutWkgADC6RF92A2u5XKUkJm+qwQSTLXHENlaWJVUSc
         eo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uAruQz0/cDNuufDZKPd/IRh0T9ZXWWj4lYhqkpVhEs8=;
        b=ZcXwqd6f9T4cRe9XTW4lFrvfXqIml23qVzkLMW2lc43R+bnEt/BxPoSvnKOCllj5r6
         1bfOmDC51KS7q0oEAgvei9gWOzAc4FBo/XvN5aujHg6OuKaem1dzkN1zG4GQPaHJe3cS
         VBAa2HZeA/zY6a08xJiDkIda+ULkbtMM0xQ38mE9eGYxbxnJa8TAeU4fLhbolUt9f3xX
         gmHNSeGOXtW5o46t334fyDfX6Vc0m59zeVA4VfCR2VewpAIQdul6S3fWzgKMk+l+Ngu/
         6ci/FnYKarTFj1Rhs7YMQBOHhvt/1BCC3bztM2b3ktVC59VH2LeKtZBQE1vHTll6d8q9
         G9Vg==
X-Gm-Message-State: APjAAAWYj0NFPWLJ4BzzWznFv2GdEgieaO6P9dQDXu3rkVsghQFsKU0E
        TbYie7/XWYKmXRDWtr7G6oY61g==
X-Google-Smtp-Source: APXvYqz+Viix925Y0M0SFoaGOcNdMr05fM33QZNnyWdxV+QDE4buLKPms1xJU0KKdExAWl7T4qOzBw==
X-Received: by 2002:a63:6ec6:: with SMTP id j189mr32907542pgc.168.1563266368504;
        Tue, 16 Jul 2019 01:39:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 33sm26302763pgy.22.2019.07.16.01.39.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 01:39:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mmc: host: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming
Date:   Tue, 16 Jul 2019 16:39:19 +0800
Message-Id: <7ab490e5b311f6cb057c4663d69ef7cbe3318dae.1563266066.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, which will cause Spreadtrum host controller work abnormally after
resuming.

Thus for Spreadtrum platform that do not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, adding a specific reset operation that add one condition to validate
the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
just reset command and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().

Changes from v1:
 - Add a specific reset operation instead of changing the core to avoid
 affecting other hardware.
---
 drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 603a5d9..bc9393c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * When try to reset controller after runtime suspend, we should not
+	 * reset for all if the SD/eMMC card is not power down, just reset
+	 * command and data lines instead. Otherwise will meet some strange
+	 * behaviors for Spreadtrum host controller.
+	 */
+	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
+	    !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))
+		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+
+	sdhci_reset(host, mask);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = sdhci_sprd_reset,
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
-- 
1.7.9.5

