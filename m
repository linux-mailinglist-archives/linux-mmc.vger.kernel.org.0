Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E944FA6F
	for <lists+linux-mmc@lfdr.de>; Sun, 14 Nov 2021 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhKNTjn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 14 Nov 2021 14:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbhKNTjN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Nov 2021 14:39:13 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45105C0613B9;
        Sun, 14 Nov 2021 11:36:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so30851248ljc.0;
        Sun, 14 Nov 2021 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ih+LeOQIGJjC7liZ7ONCl8Okef0duyrFbhQsj2+Cwt8=;
        b=fqnz7gRM9XFyJ8/gAYaD5IvrTMTabqI9+dTGPIHLwZ5imhVU6Oe3gDlNrFg3umkQem
         PnfHdIh7xWtLWwvaAI3AYV/B2Bm6krKWy3dxUZbs740ceerJMnyLcJLqoWLoad9MhON8
         gob2Z8KOSce1vnsB+e7SlD/iCCv7vaaGvVafDhqWs+9IShFI/WiDzr4+/b4Lz/uhjAaN
         4E+W5Pg8gAHkdXlFmI5EO4+HmmQbfzMONkNMtLMEefayOpm1HDN8qi3AA09z5BaeBVd1
         TYvoXo45oqXPi4C6fbI5h0wPiUcEX163pFemtuXUUAtVFAtGTYQrwUymqOpRqoJPSDcn
         jnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ih+LeOQIGJjC7liZ7ONCl8Okef0duyrFbhQsj2+Cwt8=;
        b=PcCKuxVUoZsTzgUST6V6tXkhg/CVmgOPxXfZwB4kkekKGrI5kIpy8comL7hGSGIoKT
         uoO2wTZ0dI05DOOHfN6aw1pTlEsxMIRfEHesN0OiKhueIQpaS4zrLg6W3DX+VApwi+br
         6PtzzcAZGI6p3nRhiTukxD/wY2PqJ13Di/TTU7qVIeZ7Yt0WaH10F+KS/3YQ1VT3Tp+q
         raMB4frG3IIoV7Md/GsgEirArK9oksnV9Zvkv9yatGvF6nVpPuL9PbJwfZWuHjN3xsw2
         9GHsA6Yu+RvJxVPIQS7LcMk3qqzLFYSBD/+O1rV0QCbC7YkofiqKyZNeZM4DQlMB3Tmn
         fK2w==
X-Gm-Message-State: AOAM532KUv7avtxu7swD1qH5Ccz3t5afj+M/umBjThP1rP8G/2HipmdD
        KzJ4/SqJ+AErJ3fvYjUURSc=
X-Google-Smtp-Source: ABdhPJw/QXUaRFPnlQ4MQefs8M2RlyES1ThVB8MZgeQJaiCzjV8KNy0xCBwMad/1YHGrVLQWC2ioeg==
X-Received: by 2002:a2e:bf1c:: with SMTP id c28mr34288466ljr.150.1636918576682;
        Sun, 14 Nov 2021 11:36:16 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v15 21/39] mmc: sdhci-tegra: Add runtime PM and OPP support
Date:   Sun, 14 Nov 2021 22:34:17 +0300
Message-Id: <20211114193435.7705-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SDHCI must be resumed using
runtime PM API in order to initialize the SDHCI power state. The SDHCI
clock rate must be changed using OPP API that will reconfigure the power
domain performance state in accordance to the rate. Add runtime PM and OPP
support to the SDHCI driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 81 +++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a5001875876b..6435a75142a6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/mmc/card.h>
@@ -24,6 +26,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
 
+#include <soc/tegra/common.h>
+
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -760,7 +764,9 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	unsigned long host_clk;
+	int err;
 
 	if (!clock)
 		return sdhci_set_clock(host, clock);
@@ -778,7 +784,12 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	 * from clk_get_rate() is used.
 	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
-	clk_set_rate(pltfm_host->clk, host_clk);
+
+	err = dev_pm_opp_set_rate(dev, host_clk);
+	if (err)
+		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
+			host_clk, err);
+
 	tegra_host->curr_clk_rate = host_clk;
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
@@ -1705,7 +1716,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 				   "failed to get clock\n");
 		goto err_clk_get;
 	}
-	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
 	tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
@@ -1716,15 +1726,24 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		goto err_rst_get;
 	}
 
-	rc = reset_control_assert(tegra_host->rst);
+	rc = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (rc)
 		goto err_rst_get;
 
+	pm_runtime_enable(&pdev->dev);
+	rc = pm_runtime_resume_and_get(&pdev->dev);
+	if (rc)
+		goto err_pm_get;
+
+	rc = reset_control_assert(tegra_host->rst);
+	if (rc)
+		goto err_rst_assert;
+
 	usleep_range(2000, 4000);
 
 	rc = reset_control_deassert(tegra_host->rst);
 	if (rc)
-		goto err_rst_get;
+		goto err_rst_assert;
 
 	usleep_range(2000, 4000);
 
@@ -1736,8 +1755,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 err_add_host:
 	reset_control_assert(tegra_host->rst);
+err_rst_assert:
+	pm_runtime_put_sync_suspend(&pdev->dev);
+err_pm_get:
+	pm_runtime_disable(&pdev->dev);
 err_rst_get:
-	clk_disable_unprepare(pltfm_host->clk);
 err_clk_get:
 	clk_disable_unprepare(tegra_host->tmclk);
 err_power_req:
@@ -1756,19 +1778,38 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	reset_control_assert(tegra_host->rst);
 	usleep_range(2000, 4000);
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(tegra_host->tmclk);
 
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
+
+	clk_disable_unprepare(tegra_host->tmclk);
 	sdhci_pltfm_free(pdev);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
+static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_tegra_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_prepare_enable(pltfm_host->clk);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_tegra_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1783,17 +1824,22 @@ static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(pltfm_host->clk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		sdhci_resume_host(host);
+		cqhci_resume(host->mmc);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int __maybe_unused sdhci_tegra_resume(struct device *dev)
+static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
-	ret = clk_prepare_enable(pltfm_host->clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
@@ -1812,13 +1858,16 @@ static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 suspend_host:
 	sdhci_suspend_host(host);
 disable_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	pm_runtime_force_suspend(dev);
 	return ret;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
-			 sdhci_tegra_resume);
+static const struct dev_pm_ops sdhci_tegra_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend, sdhci_tegra_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
+};
 
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
-- 
2.33.1

