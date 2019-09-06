Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2FAB169
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 05:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392215AbfIFDwz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 23:52:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45312 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392213AbfIFDwy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 23:52:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so3369600pfb.12
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 20:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EBpVgRZKtjnDtjrwrB9mrGRM/gKC++RB5oNke1k5+K0=;
        b=WlFs3zRfTQzKlu/iTvwfrRb3LuO9bpKb7bMRAP3fFRCTTBU+Kpu/QJmmZ2wV7wARkt
         ikgPokG0OUliflF0l2MBe+3TRb/midzsick+m+wP93enWtA/Ol0+RdyoH7u/3oT8rTJs
         WOhrOW+CZAKbT1i2Xx8LF1n4RbR12BrxQ/OPXBxqyHPEzukJPwXycPHN1FjkKTEqiFQE
         l4nuN02Ats9HX8x21emOXHkoOmAlhjwdKErjdpHYQl1M5rJrbt9i2IYm+vkzx51s1/N1
         BO3QYiec+jkUxUM9/7YGWrHy9s0t1H6YSs0T7lerdoPRUpjp7JD4Wmo+wP6LIlZIyqYL
         76Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EBpVgRZKtjnDtjrwrB9mrGRM/gKC++RB5oNke1k5+K0=;
        b=dPj5YdfqNOyME7joqQneaM6uxNcPkkLKuDzSY386Hg9OZEUBg8KiUNrrYUi/Mb+cbS
         BA16C2ezrsUmxTT+NFDYajD2TXrxnQuFvmxBuXPk0b+pjfdELvdKFwQhBmjpaYwurv1r
         s/hvyqxS9td/E3CB6iCoRo3LWzb2WCwDBKrOKe2JV2U9HNh6JyIhxPmbH/KkT99xGFdJ
         TQob7cmDUvn5qagR25xCENb+lbnEBHiKwwlgCr+7RG6z05Q6r1iPHNkZcB19NkF7Pa9d
         HxAzjtquQPpfFSV+LYvZ2t08JPkyqGPRNzLlVpGQj21kH3Vb2srKvUIbHMIT10oMJd3Q
         l1+A==
X-Gm-Message-State: APjAAAWkCb2MaNpevlvOfvqpPLGefGA1fwSSZFJdcK2XfCVvK4AVrQ7t
        y9Imjo/W54zravCWplhm/XCPzw==
X-Google-Smtp-Source: APXvYqz6scEQcTixXjaqz+eoiijc1YqpN5TaS+1+WrsoKjcmFWwBZjtEFDUbOwnWqgOA+WbuQPOWug==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr7339960pjz.140.1567741973694;
        Thu, 05 Sep 2019 20:52:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: host: sdhci-sprd: Add virtual command queue support
Date:   Fri,  6 Sep 2019 11:52:01 +0800
Message-Id: <c8cb69b48dd8b6317a9e53e87c5669fbfbeedc30.1567740135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add virtual command queue support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e2a12c3..851e947 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_VIRTUAL_CQHCI
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 19a2104..ff4886a3 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -515,6 +516,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct cqhci_host *cqv_host;
 	struct clk *clk;
 	int ret = 0;
 
@@ -625,6 +627,17 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	cqv_host = devm_kzalloc(&pdev->dev,
+				sizeof(*cqv_host), GFP_KERNEL);
+	if (!cqv_host) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = cqhci_virt_init(cqv_host, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -685,6 +698,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	cqhci_virt_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -713,6 +727,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	cqhci_virt_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

