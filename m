Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413754E065
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Jun 2019 08:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFUGNB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 Jun 2019 02:13:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42390 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFUGNA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jun 2019 02:13:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so2450514plb.9
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ImM7LoJ0g/LV9Msk8fC9rkqyN6ipnuYryn1oHdAjw90=;
        b=IsSBjGrF+DN7QHmXac43Ny79aaDEhysk2zRkeDW43Wox0gAQlxq2jhbf6FPNlZ0Ivg
         W5dXPLPd/Gl+e6zZvdKMuSxCqWPSObH8X+6Ftomh0xUVUeY9bJW8JlShqfj7hcs/Efjb
         WCJhUx6hG8j/IV54/quUx/94bk1d6jXYUvkajSza2zunVxXSy+NIClWkeztrxvb4bGIA
         M0VGYyvy930CJIehNbG1vyrmufkJ6KudfaIw/VvW8p0aT4auVM1Gfc1eLZmKefZGqdyb
         fWgl0VC4cT8ipH3uf17ndRAQsBWPklzGRQaHexZTkF7/F/oKNyfwQgR8BLi5BzlZwF2r
         ADDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ImM7LoJ0g/LV9Msk8fC9rkqyN6ipnuYryn1oHdAjw90=;
        b=Krd0D2PZ53+fYSAPFDLMve6ghXYpq/4tsCJNNjirW2UWPa4eAL5OhN6h18tr6c6T0P
         UfB0u4fBjdU0Uuj9qdUlO9QImdc+ZxLTW8eutl78PoWP1czuerWT3r0q5m0SbxK3z4L0
         sEtN92ztDxgVgiJtR3GpalDtmtoIfIQ0jxO9/VtLW7Gz536eAedVFazWHVkA3KqGVGs6
         IIm4lMTjSb2YMxreLMeXwhhewFWGNdeHQvi8oywtKJXWd/gG3cpBLF+JmhN+l5raRiFv
         YZ7unMl3A5LRYYP6509zrno7t9um5Spo2+BqXk3jJeaTJL7iXg5Lv6n4VEEqs3nN3fDR
         j0ug==
X-Gm-Message-State: APjAAAVs7ydTTb1DQvDKLwJditFOcc0oRzliOZoXB+mJTY/0lBeGuC8y
        m2R1ABH/0d/DisFhgA8zq4XouaqZvzSdAA==
X-Google-Smtp-Source: APXvYqz898MP1cNZToQJ6foRRP/YHqudKpgx1HQy2pqhLZm61bx9cEa7MCexGOqYuMmbmiHTN0ANag==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr69912736pls.72.1561097579911;
        Thu, 20 Jun 2019 23:12:59 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:59 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci-sprd: Add pin control support for voltage switch
Date:   Fri, 21 Jun 2019 14:12:33 +0800
Message-Id: <db6d2b2d6170fd2409916c5c41b857f4bc587a15.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For Spreadtrum SD card voltage switching, besides regulator setting,
it also need switch related pin's state to output corresponding voltage.

This patch adds pin control operation to support voltage switch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 8b23c88..6ee340a 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -72,6 +73,9 @@ struct sdhci_sprd_host {
 	struct clk *clk_sdio;
 	struct clk *clk_enable;
 	struct clk *clk_2x_enable;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_default;
 	u32 base_rate;
 	int flags; /* backup of host attribute */
 	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
@@ -405,6 +409,8 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	int ret;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -416,6 +422,37 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	if (IS_ERR(sprd_host->pinctrl))
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_uhs);
+		if (ret) {
+			pr_err("%s: failed to select uhs pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+
+	default:
+		/* fall-through */
+	case MMC_SIGNAL_VOLTAGE_330:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_default);
+		if (ret) {
+			pr_err("%s: failed to select default pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+	}
+
+	/* Wait for 300 ~ 500 us for pin state stable */
+	usleep_range(300, 500);
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
 	return 0;
 }
 
@@ -504,6 +541,23 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
+	sprd_host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(sprd_host->pinctrl)) {
+		sprd_host->pins_uhs =
+			pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
+		if (IS_ERR(sprd_host->pins_uhs)) {
+			ret = PTR_ERR(sprd_host->pins_uhs);
+			goto pltfm_free;
+		}
+
+		sprd_host->pins_default =
+			pinctrl_lookup_state(sprd_host->pinctrl, "default");
+		if (IS_ERR(sprd_host->pins_default)) {
+			ret = PTR_ERR(sprd_host->pins_default);
+			goto pltfm_free;
+		}
+	}
+
 	clk = devm_clk_get(&pdev->dev, "sdio");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-- 
1.7.9.5

