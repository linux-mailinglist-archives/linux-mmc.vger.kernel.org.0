Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E496E7FD8
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Oct 2019 06:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfJ2Fo0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Oct 2019 01:44:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40230 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbfJ2FoZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2019 01:44:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5so1829131plr.7
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2019 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=vLoEKlV6PhyQnu5TaX9PnU1KHde3KNK0Fv7oOOpqfqAU95PmYyCYQFVqox1q5H7qmM
         1ptm2U0iVubob9AJKr4ySIpBNHZiL1SnulsIzu7/5UnYp8zsYdNRVj8LjylFYrqRoh/5
         PFot5tr6iBh5FbWJ+z20//D/4S1q7AY9/APYqH2eF6A3vlc5tmSR8SjRYLvfNrWjPQOr
         u/Zqp/ey8YNSRoJw0W6UuH7TlxouEWEMCqQNAJa/mUVBC3amQNNVmHXXA8yw3yaUPzVN
         Szh1o0B5BoPOBAknZtU2NHBG0NHVIFWezOTMwqYh2EaH4sBi4RVMmcMEboIvt4NA688s
         w6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=fpNsMjqauKW286csYDDVYBQgr09+loEBoO7YZL9k1qglRH7df6D7JbHbfBqqR62kyx
         rFFoIB6ioRjcoaEFKohAeQE0Fw996kigDwYAaP1KxAzr8iwvUxjHwH+N2qpoAJlPY3z3
         PyuI/uz4L+x0l8Ln6AkGC6g0j5dtFVubKOX+TZGWWCoT5nvzhc2L5PyjRkmFPhG0kOnn
         9HDZ9UKvAXzMERC+t7TPx9xM6q9SZG6SXMNISbTI9O/TurjPKu7Qjr4xMwyxmP8wUo3D
         e9snWVHSteL9EajWq34Qjl2p5gJXlimdzQpJ10KBGjD2Leqs7QeI5UfD9JlP4KqC/kck
         uSzA==
X-Gm-Message-State: APjAAAWYR+PHioN1Y0G8d8NR+nf5Nv69ep65FA3paoayUYKp8yBaQ2iH
        Wb3pePBrDQ84cbB+FOvHyyeOkA==
X-Google-Smtp-Source: APXvYqynwyA3Y+yY6LfpzaWZscREtHN9yCgXN9CAAIZt6tnVF4Q6hgAoYesJokVsz6dgZ/WNdlKq2A==
X-Received: by 2002:a17:902:fe89:: with SMTP id x9mr2029967plm.62.1572327864464;
        Mon, 28 Oct 2019 22:44:24 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm12026231pfi.113.2019.10.28.22.44.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 22:44:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] mmc: host: sdhci-sprd: Add software queue support
Date:   Tue, 29 Oct 2019 13:43:21 +0800
Message-Id: <c9f7aa5fd8337886866bb5db8743840f3158c140.1572326519.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index efa4019..54b86f6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -632,6 +632,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_HSQ
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..3cc1277 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
+		return;
+
+	 mmc_request_done(host->mmc, mrq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -392,6 +403,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
+	.request_done = sdhci_sprd_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -521,6 +533,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct mmc_hsq *hsq;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = mmc_hsq_init(hsq, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +712,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_hsq_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +741,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	mmc_hsq_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

