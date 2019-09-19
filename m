Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A50B72F4
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfISF7U (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 01:59:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33002 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISF7S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 01:59:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so1256481pgn.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Sep 2019 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4zoX/y4PganInWe3/mARbaR8aRBFEpK4D2RgCbSuiC4=;
        b=o/AXHGJNcTfb/QBuxV38Fov0fPaFAUpu8RlqAYA4p8z9IGQUjrbH1dhdTrh7Pxn5tt
         1c4mVI7h4+1BboYpvs2myRmOEcH8K0jR+YSh2OvqgmCpviiwqzimh64MVuKX2ti+hhxX
         LtvbniIR/k8e8TUEm10xjPxY9KLs8J08cAK77cFe3pI08aJpQHb2mqSHvDQFv9eknMuZ
         pw6qLJahZEZCj8epZ7qNz/1PZWUA9o8N6+34wQl37HLz1ObtcasbIVBSJNxTMuhbho7h
         inGOKpUPjGqphtG8c1q9JUH7O3yCf5MzZv9lH08E9tLPgEZefupgWwXVDzmQl8WBz0Wd
         vG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4zoX/y4PganInWe3/mARbaR8aRBFEpK4D2RgCbSuiC4=;
        b=eESC0klII9k9n02GCf6unq4lAAe7RwVx0t/4yhC05obs7250Fr5C816dCOfIYtU4mK
         3Kzgilfamru86TR/YxO9lM72YJTKlVWIaXbY3mHkRcXuGRSCh8i5Q1vJgmavC2n98FY2
         p8bpweXCAjWUhR1i/J1wAWGOYOVEZj3LKRLI7uaaINPny7hh9Fiva9po+poL15+oJD03
         PuV5Js823Jrg0Wd1f7nydWJeXnStYLKqPIBZnjRkbawNs6ZY6VCWKXkICmdtsyMCEoDr
         hpEzI0AVxw0YQ31tJO9ObThyYKBm5x57kP5SvOjjcZ42u+9oFVwRxeGNSjg/f7MIulJo
         A7OQ==
X-Gm-Message-State: APjAAAVAqXBDdJrnf13idS2mN1ZhLvPJ1VXd1zFLFUpFMLTmZkOsETvB
        fBzVLI4Q9m50Geo2/XkZdQxYEA==
X-Google-Smtp-Source: APXvYqwz76HqhSedoS5r2mMBa6dzmPqh1Ag3DfmlNk0vZL1fBXLgDth4GoDuVRex1pgIuJTQXdT58Q==
X-Received: by 2002:a62:583:: with SMTP id 125mr8684554pff.69.1568872757864;
        Wed, 18 Sep 2019 22:59:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c127sm9666027pfb.5.2019.09.18.22.59.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 22:59:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mmc: host: sdhci-sprd: Add software queue support
Date:   Thu, 19 Sep 2019 13:58:47 +0800
Message-Id: <17069e44dbab0302bb7bd5eee64dc769b1f181d3.1568864713.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
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
index d117f18..862e8e9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SQHCI
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..4dec0b3 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "sqhci.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (sqhci_finalize_request(host->mmc, mrq))
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
+	struct sqhci_host *sq_host;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	sq_host = devm_kzalloc(&pdev->dev, sizeof(*sq_host), GFP_KERNEL);
+	if (!sq_host) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = sqhci_init(sq_host, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +712,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	sqhci_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +741,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	sqhci_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

