Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A82A6B41
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfICOW5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44682 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfICOWt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id y4so6138208lfe.11
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oRUCHCrSXAlVd+d5h26u6KUeDoevWOErPZA9CCjpQxk=;
        b=cuSTDxro2oT3broDfM4Vhr93npdKcTrzQwf/hurN/LzTaOclC+JagWmOYz8XhLpzp1
         WQfMy9rnaUZWsyQJ2l0461oXe37BJnCpWuYs2kyrijCXRdsx7onpMgb3djgBof//Yh6k
         TE7eq/LEiVO1FXLbK6yNgRwFuzlA8aZOe1WBgrM2i/W1seNF+h/tBzhoyQKVAb0XfH9x
         siDR1HffQVdt+yQmle0S3R6LFECw7C5/ni/D5ULuKwwCKg/MGpyU+NJaIhY+WcM6uNxw
         V5c/yQAX+33zQRNvcNGYfO3vCrMHdFTlGzCDKZtpZET7N3SUkhWtkU2A5MMP8Z0NmHvk
         /a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oRUCHCrSXAlVd+d5h26u6KUeDoevWOErPZA9CCjpQxk=;
        b=dbirAdFawwj+Y6H7Gy9ivqUtemnn4D4vAnFfSJhhKUYCQFsZ5imUkywu1Tpq1MRobH
         qPrSu+KY2fczu8Kzd7YJSc8YItQptmKL9sM4MwJQQ1IAYvlvzKawUYGC4v73aRSMtI94
         EqPuzwJtBRTYm8BNANHe6229AzWT9HmOEngiDXOF97zIxExXvr6puu/ym+6erVhWEsGB
         4GfQMadS4/lje6cKvNI6S+Yd/mjNR0a5/NV/Oy1DSW+tspVy2G6DghryAxj8jNuO2WaA
         YdKCZexkArls+9Rj/NK7JdYIEeAvuThH1T7YuFxrz/lFPm9gBmoQFPet+XiCJE4+Yb+T
         qrVg==
X-Gm-Message-State: APjAAAV3dofE8hcIcE1NUQy2K5Vwd66qoXZLK0t+ECSldyg5QQGpso5O
        yjG/OHWX5t5xJQD+w7IUyRY4ThcOdVg=
X-Google-Smtp-Source: APXvYqxulXC0EVgK6/kIKcgM16qMgDbBItv63++f/7a5797d7tuL/bpKNSln0qr1e0rf25vagSHLrQ==
X-Received: by 2002:a05:6512:499:: with SMTP id v25mr16750469lfq.30.1567520566370;
        Tue, 03 Sep 2019 07:22:46 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] mmc: sdhci: Drop redundant code for SDIO IRQs
Date:   Tue,  3 Sep 2019 16:22:06 +0200
Message-Id: <20190903142207.5825-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nowadays sdhci prevents runtime suspend when SDIO IRQs are enabled.

However, some variants such as sdhci-esdhc-imx's, tries to allow runtime
suspend while having the SDIO IRQs enabled, but without supporting remote
wakeups. This support is a bit questionable, especially if the host device
have a PM domain attached that can be power gated, but more importantly,
the code have also become redundant (which was not the case when it was
introduced).

Rather than keeping the redundant code around, let's drop it and leave this
to be revisited later on.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 34 +++++++++++++-----------------
 drivers/mmc/host/sdhci.c           |  2 +-
 drivers/mmc/host/sdhci.h           |  5 -----
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 776a94216248..1c988d6a2433 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1666,12 +1666,10 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	if (!sdhci_sdio_irq_enabled(host)) {
-		imx_data->actual_clock = host->mmc->actual_clock;
-		esdhc_pltfm_set_clock(host, 0);
-		clk_disable_unprepare(imx_data->clk_per);
-		clk_disable_unprepare(imx_data->clk_ipg);
-	}
+	imx_data->actual_clock = host->mmc->actual_clock;
+	esdhc_pltfm_set_clock(host, 0);
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
@@ -1695,15 +1693,15 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	if (err)
 		goto remove_pm_qos_request;
 
-	if (!sdhci_sdio_irq_enabled(host)) {
-		err = clk_prepare_enable(imx_data->clk_per);
-		if (err)
-			goto disable_ahb_clk;
-		err = clk_prepare_enable(imx_data->clk_ipg);
-		if (err)
-			goto disable_per_clk;
-		esdhc_pltfm_set_clock(host, imx_data->actual_clock);
-	}
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto disable_ahb_clk;
+
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_per_clk;
+
+	esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 
 	err = sdhci_runtime_resume_host(host, 0);
 	if (err)
@@ -1715,11 +1713,9 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	return err;
 
 disable_ipg_clk:
-	if (!sdhci_sdio_irq_enabled(host))
-		clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ipg);
 disable_per_clk:
-	if (!sdhci_sdio_irq_enabled(host))
-		clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_per);
 disable_ahb_clk:
 	clk_disable_unprepare(imx_data->clk_ahb);
 remove_pm_qos_request:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2a9be044448a..a7df22ed65aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3046,7 +3046,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	spin_lock(&host->lock);
 
-	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
+	if (host->runtime_suspended) {
 		spin_unlock(&host->lock);
 		return IRQ_NONE;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cf3d1ed91909..8effaac61c3a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -753,11 +753,6 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
-static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
-{
-	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
-}
-
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.17.1

