Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F0AD726
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Sep 2019 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfIIKq5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 06:46:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38911 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfIIKq5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 06:46:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so14054125wme.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e7moCh+jQSw0jwF9Rlsy8SQKxliBxNOLoz695izoqns=;
        b=a618mjz3tppctfX0DICSnWVTgdVsGHGN7Eq7AHhMSKSFFwuXkRnUe70VIAsgLrHahk
         ElXRQK3hazu+rdS4tstIRYoaEMO6TbcxX0cp9hffeX55WBLnTl1zVgnWtTJi8b3/0RuK
         tZy393oPrV8QOm8H1WakMMfc4yOWYT3NdAZzTpgT/BangpUbZyNGSOuXcekqoRsP4Eeb
         5yJbDcAnbrLudW3Sbxeff/xJ12YG0cZ2KDPr4sb685dSJvKBtxXbFQnOVIDdPs+9mVbo
         Ztcr80LhCWr4gVWnuiQGokQ7I4Re/RXn2UeVTqSwZcIk1RpDLhOCkS1LLHqfYQGo1JcG
         svEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7moCh+jQSw0jwF9Rlsy8SQKxliBxNOLoz695izoqns=;
        b=UTH3kIOYA3no2fGF5cdXFwoGiuzujNY+dzLPkzW9lD/SpPwR/htmam0mVyhEq3sAde
         3jrkGT1hS/Sy9Em3AOwRXRALASmszPTz5rvyzXqy5Fy5CgD8IIzAccPgfm75M/lhTO+B
         a7cHCcDDQVxs4ZvRzuiN9qsIYFTGS1OqYMkG1hU5llMu0Jv9SUtCdy6O4yuWHRqjLl3l
         42PU/1Df6qFgfyolg/BzjRNlxd7R7YMW/ZiJcBhuXJ7QN9ESvCNcWT6kgwT4WFkLY4hq
         s/pb+vSmRW7vkPZOubeNS8EGgTDcYzl1/5S4DSDvHsTGBMcWygoLfQp86ECVpFH3vCsW
         OrRA==
X-Gm-Message-State: APjAAAXrZCHq7TQC6W/ollOOLs42rCUOFtx955mY7M/04Wu592A4/vCh
        Q9oNLDYlJXklFhESMvy5qtXh/C13hRGWtA==
X-Google-Smtp-Source: APXvYqw5lFA91EojJNkqbGtjzqEv2INthA8qJ3AjPKFocqGmAr0e/CNJHMA66MdDlR0F829s1my1nA==
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr18158808wmb.76.1568026012737;
        Mon, 09 Sep 2019 03:46:52 -0700 (PDT)
Received: from localhost.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id n8sm18667415wma.7.2019.09.09.03.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:46:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: tmio: Fixup runtime PM management during probe and remove
Date:   Mon,  9 Sep 2019 12:46:49 +0200
Message-Id: <20190909104649.4960-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

During probe, tmio variant drivers calls pm_runtime_enable() before they
call tmio_mmc_host_probe(). This doesn't work as expected, because
tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
status to RPM_ACTIVE for the device, when its been enabled for runtime PM.

Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
To avoid the device from being runtime suspended during the probe phase,
let's also increase the runtime PM usage count in tmio_mmc_host_probe().
Consequentially, each tmio variant driver can decide themselves when to
call pm_runtime_put(), to allow the device to become runtime suspended.

Additionally, if the tmio variant driver decided to call pm_runtime_put()
during probe, it's is expected that it also calls pm_runtime_get_sync() to
restore the usage count, before it calls tmio_mmc_host_remove().

Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 10 +++-------
 drivers/mmc/host/tmio_mmc.c          |  6 ++----
 drivers/mmc/host/tmio_mmc_core.c     |  8 +++++---
 drivers/mmc/host/uniphier-sd.c       |  6 ++----
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 4c9774dbcfc1..6846c6b688a2 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -777,8 +777,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	pm_runtime_enable(&pdev->dev);
-
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
 		goto efree;
@@ -845,6 +843,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		goto eirq;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
@@ -858,9 +858,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	renesas_sdhi_clk_disable(host);
 efree:
 	tmio_mmc_host_free(host);
-
-	pm_runtime_disable(&pdev->dev);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
@@ -869,11 +866,10 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 8539e10784b4..219029a1c420 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -172,7 +172,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
 
-	pm_runtime_enable(&pdev->dev);
 
 	ret = tmio_mmc_host_probe(host);
 	if (ret)
@@ -184,6 +183,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto host_remove;
 
+	pm_runtime_put(&pdev->dev);
 	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
 		(unsigned long)host->ctl, irq);
 
@@ -193,7 +193,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	tmio_mmc_host_remove(host);
 host_free:
 	tmio_mmc_host_free(host);
-	pm_runtime_disable(&pdev->dev);
 cell_disable:
 	if (cell->disable)
 		cell->disable(pdev);
@@ -206,12 +205,11 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	tmio_mmc_host_remove(host);
 	if (cell->disable)
 		cell->disable(pdev);
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 2cb3f951c3e2..ad8f3e902daa 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1257,9 +1257,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
@@ -1283,9 +1285,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ)
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 
-	if (!host->native_hotplug)
-		pm_runtime_get_sync(&pdev->dev);
-
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
 	mmc_remove_host(mmc);
@@ -1294,7 +1293,10 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	tmio_mmc_release_dma(host);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (host->native_hotplug)
+		pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index e09336f9166d..8f7bf138408b 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -629,7 +629,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	host->clk_disable = uniphier_sd_clk_disable;
 	host->set_clock = uniphier_sd_set_clock;
 
-	pm_runtime_enable(&pdev->dev);
 	ret = uniphier_sd_clk_enable(host);
 	if (ret)
 		goto free_host;
@@ -647,12 +646,11 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	pm_runtime_put(&pdev->dev);
 	return 0;
 
 free_host:
 	tmio_mmc_host_free(host);
-	pm_runtime_disable(&pdev->dev);
-
 	return ret;
 }
 
@@ -660,9 +658,9 @@ static int uniphier_sd_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

