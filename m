Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D242F6F19
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Nov 2019 08:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKHfZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 02:35:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43714 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKKHfZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 02:35:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so8906044pgh.10
        for <linux-mmc@vger.kernel.org>; Sun, 10 Nov 2019 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=s0ExBf69BmmTL8g8enNiPwaRmpBMFWW+q7MngojPegddgeqfh2kgXDFE2hDQ8T2JyG
         ggi+0b0rIR/nNwAiYSw6V/WvnJpfITQzXqiNJtBp/wqHduWt3VLLhzVBSTM7p3KZGs/N
         ex5F/9AKeJcvhao21rlQ8yVLzgJ39s90ruG/NY28kqG1I7UI6aH93dX1eOX1ccF2Q4Vn
         o5XOb0liCGl/CZxAlUiwyHaXC8NQIbKk6gejnCc99hzVFILoZbA5kX/i4b7wkD1KtBlX
         ZLogjfb2lQyl5XmpZDRB2UH0VrmWkiV57kI1rh/oVYq1IEScxehvEKBlH4vAu3VE9hGk
         BWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=ZU2WS+lM14hvSUWVKXRvcvmf35rL16wEL355U/w1rwjvtSmB+B4OKafcZJf1tZyFcG
         6zhKAKzqVq7LkXOuLdjzCAogY+stBN5xIGm7GPWq7E148BIoS2ROdwZIBMnYd+3qIzL+
         JSKOqSd4YDK/mE2q2bnfPhPHxufF/2k/PHsyXgq+hiJhEY0C3SR6zpN9Y8mQRgMKxGCt
         KMInzwlDFNfUfyPYq6ZA+aJ+1mj/CbYQ3TR2Lu0bnU4TiH1iBPdEqWFWwp6esnJdWoj8
         qZWKy7TDRLyjFk2hkaCin23XKUvfjXVY1BFyN92C6CYlgJqwBgpFsOV0haN+uwSDp2TN
         9lUw==
X-Gm-Message-State: APjAAAUv509tZbD0ZfF8ojOT3UdrjfaaiSJ+aww6d9piPK6lq/6jdZEP
        l9hmsgSv+7H505ixRCPXe4iLKA==
X-Google-Smtp-Source: APXvYqzGhEowdl33ZG3Nn+JSXRL0cpS3eAkme+jXg+GvtWTyLHfqqj7nPp7wfJIa1XDaOOa04ma3+g==
X-Received: by 2002:a62:ea1a:: with SMTP id t26mr5386170pfh.14.1573457722961;
        Sun, 10 Nov 2019 23:35:22 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c184sm17345285pfc.159.2019.11.10.23.35.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 23:35:22 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] mmc: host: sdhci-sprd: Add software queue support
Date:   Mon, 11 Nov 2019 15:33:59 +0800
Message-Id: <c9f7aa5fd8337886866bb5db8743840f3158c140.1573456284.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
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

