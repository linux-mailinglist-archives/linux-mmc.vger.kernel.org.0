Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776142A264
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Oct 2021 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhJLKkK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Oct 2021 06:40:10 -0400
Received: from muru.com ([72.249.23.125]:43736 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236018AbhJLKkK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 12 Oct 2021 06:40:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id ABFF88127;
        Tue, 12 Oct 2021 10:38:38 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 6/6] mmc: sdhci-omap: Configure optional wakeirq
Date:   Tue, 12 Oct 2021 13:37:50 +0300
Message-Id: <20211012103750.38328-7-tony@atomide.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012103750.38328-1-tony@atomide.com>
References: <20211012103750.38328-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Configure optional wakeirq. This may be optionally configured for SDIO
dat1 pin for wake-up events for SoCs that support deeper idle states.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -12,8 +12,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sys_soc.h>
@@ -117,6 +119,7 @@ struct sdhci_omap_host {
 
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
+	int			wakeirq;
 	bool			is_tuning;
 
 	/* Offset for omap specific registers from base */
@@ -1360,6 +1363,25 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 
 	sdhci_omap_context_save(omap_host);
 
+	/*
+	 * SDIO devices can use the dat1 pin as a wake-up interrupt. Some
+	 * devices like wl1xxx, use an out-of-band GPIO interrupt instead.
+	 */
+	omap_host->wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+	if (omap_host->wakeirq == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_cleanup_host;
+	}
+	if (omap_host->wakeirq > 0) {
+		device_init_wakeup(dev, true);
+		ret = dev_pm_set_dedicated_wake_irq(dev, omap_host->wakeirq);
+		if (ret) {
+			device_init_wakeup(dev, false);
+			goto err_cleanup_host;
+		}
+		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	}
+
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -1387,6 +1409,8 @@ static int sdhci_omap_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 	sdhci_remove_host(host, true);
+	device_init_wakeup(dev, false);
+	dev_pm_clear_wake_irq(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_sync(dev);
 	/* Ensure device gets idled despite userspace sysfs config */
-- 
2.33.0
