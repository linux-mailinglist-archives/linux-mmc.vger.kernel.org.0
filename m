Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C61700A9
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfGVNKf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:10:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46024 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfGVNKd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:10:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so17628980pgp.12
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5gE1kPucNU7X7KwlYwjXGQ4fueRicQdt9vfmEisPxts=;
        b=ph38PZ7Y9AtcECthPxVps5SsED9G6pKFmujg75ViiaOlYhdOPrBAJNn3tK6eiAa3fh
         DYzCb+S90IgJSetgzH9n0FctUAsoMgjHHzBMRDmIXw+MmJA6YL2MkZQR9L1QS+lDn19T
         gXxtoBimqBUIzr54st7Pd8Gkld7+xryX1jgRYuNqSUIQT4k7wQ4hWhc+NLiQXaI8dAdT
         QCK4ickkpiZUQqfaoWf5SR/LH7iDKx/D9UEL8UY946rrspmBDIrP/AjPDRQFS+pTid1M
         FI/0L1JRYZg9zfIoL2D0b3KheG8D04BAptY/xQNx9+WSKUlsR6pbvVzjGCv2iLHk1HZy
         K5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5gE1kPucNU7X7KwlYwjXGQ4fueRicQdt9vfmEisPxts=;
        b=OCHpVbQH9UiiLCZgIxb70zVVxtl6akptXmM7Y/BTCjjgKyR2F1SmMyGu+uHYUMQ5vs
         pTDxEHfAgQSLUWHQ9ojcsHsZpYupbyADS7qFV11QLKVdIvPoHAqQ2rTD7yAWB6RzY2sK
         iA+6tFzsiYzmPez5HcuurLkz/igbHU7B92euuuu1mwDCr0Ewk7ePUzwZ9y9e0G0DF599
         a4oJIDPtSWnZ3lk5fUlUtBvUIGOG+ZCYuxYqJhD6YrcCTrywrE1BFjL8OIzsq0f2WsfG
         I7Y3Ahd2/NFcEEbUy6bfM9YgKnTKgBHtWxNvBUPII4G0VTZoulmRrvSGWbSGdT5ZV5YQ
         itkA==
X-Gm-Message-State: APjAAAWkrlBNYkGNGf2dsgnX5aMtAgNWlqFcHHCOxwsP0n4MscGGMRWw
        CYQ7OO/I9xQgGF15TtYljeSKfaBChHErIA==
X-Google-Smtp-Source: APXvYqzRhLjIapIqH0UMUrEoXd56afqIa+SxEOgoehkHR9Jquyty05DcnJnGC+qh3AYMXetDdtvHpw==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr76886330pjv.95.1563801033086;
        Mon, 22 Jul 2019 06:10:33 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 7/7] mmc: host: sdhci-sprd: Add MMC packed request support
Date:   Mon, 22 Jul 2019 21:09:42 +0800
Message-Id: <8331abb05ff0587f01093884cc2ba4f0d2a377cc.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable the ADMA3 transfer mode as well as adding packed operations
to support MMC packed requests to improve IO performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a1..44ea3cc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_PACKED
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 80a9055..e5651fd 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -524,10 +524,18 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_USE_ADMA3_SUPPORT,
 	.ops = &sdhci_sprd_ops,
 };
 
+static const struct mmc_packed_ops packed_ops = {
+	.packed_algo = mmc_packed_algo_rw,
+	.prepare_hardware = sdhci_prepare_packed,
+	.unprepare_hardware = sdhci_unprepare_packed,
+	.packed_request = sdhci_packed_request,
+};
+
 static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -642,10 +650,14 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
-	ret = __sdhci_add_host(host);
+	ret = mmc_packed_init(host->mmc, &packed_ops, 10);
 	if (ret)
 		goto err_cleanup_host;
 
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto err_packed;
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -653,6 +665,9 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		__func__, host->version);
 	return 0;
 
+err_packed:
+	mmc_packed_exit(host->mmc);
+
 err_cleanup_host:
 	sdhci_cleanup_host(host);
 
@@ -680,6 +695,7 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	struct mmc_host *mmc = host->mmc;
 
+	mmc_packed_exit(mmc);
 	mmc_remove_host(mmc);
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
@@ -702,6 +718,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_packed_queue_stop(host->mmc->packed);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -730,6 +747,7 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host);
+	mmc_packed_queue_start(host->mmc->packed);
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

