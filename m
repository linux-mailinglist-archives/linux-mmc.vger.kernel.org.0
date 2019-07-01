Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8723108
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfETKMv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 06:12:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbfETKMt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 06:12:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so6502930plb.7
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tBhcNYJtRLrxmBnBaA1yOUVcPiTzc/ssEh1mPTrnJ9A=;
        b=LyscKN3AqfXVoetIgjkoE69HYU9HnAi1xdi1PsWubJiP8Qrv8OJyrz1r2HMdsL4FBb
         lQn9hJZO7LhXiuRReQ8WMnJHmvQGs73mt7wOAguu18mV051cJZf2rpUwMXUW0v5M7sX9
         TvQolobA/OMQm2Qf0tBTfekBPWmgcCL6eG6yRhsfz2miwtlncfd8UJe5AxOATOoorLtg
         aKfpmc+QwDJvg2iLFU3gYYgI8aETuhnyGo4OvUdSKWAbXe9XZgN9iZW4BWb7f5B1mwcL
         Oq/7pqCRe+GigkPGu0MRkAyzZbtoql9Vlz0TruCFPEe35lqvZ5iuPcuIhdBuBcBlUgv3
         +2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tBhcNYJtRLrxmBnBaA1yOUVcPiTzc/ssEh1mPTrnJ9A=;
        b=FUQtWZDbykGETBhYI/4JdWNk+v69uey+cAs5w8+jQNDp2mq1ChBL1sCGS+KCJweh92
         aGIVIvY1mxGidlRwcJXQvqz3AI01VKeFwgiTWz7WY7VfQkgDKAOmPL2a0ttIB3UX2Et8
         44noe24pRJvJKUs09dyJfNExHYNQJeUb66xAx9wNvR4P4T90Kn9UuAhXtpkmXCUdqOqK
         hfby4b9YGpODQ86YXnGW7aBD/8DwO1clyqAbZKetE4FJBSAzJEhAJzNk495uIcFZMA2K
         XzEIUah9sw49RQ3uuy20LcI+CCT/QQchJWZrR+VHyFSfPs3Zkt6sCFShmMIE0w7S7bLh
         epBg==
X-Gm-Message-State: APjAAAVoXfufP4FIsfylQdEyDq56IZW5lRxdKp8LFdXbMcAOanKo6tpl
        30/wQZA+N5VTYEHLF2nMg0H4xQ==
X-Google-Smtp-Source: APXvYqyFiTD5jg2bS8KMLdnLigkZ1ZpgDu8OSnk/Yqe5VY5FLXMLHH0OVIJRSmVdYEuPei5O7fmmFQ==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr21102932plb.177.1558347169203;
        Mon, 20 May 2019 03:12:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 6/9] mmc: sdhci-sprd: Enable PHY DLL to make clock stable
Date:   Mon, 20 May 2019 18:11:59 +0800
Message-Id: <270e86bf6b1ce138e40830fb63c9bcf150440426.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For the Spreadtrum SD host controller, when we changed the clock to be
more than 52M, we should enable the PHY DLL which is used to track the
clock frequency to make the clock work more stable. Otherwise deviation
may occur of the higher clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index edec197..e6eda13 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -22,6 +22,13 @@
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
 
+#define SDHCI_SPRD_REG_32_DLL_CFG	0x200
+#define  SDHCI_SPRD_DLL_ALL_CPST_EN	(BIT(18) | BIT(24) | BIT(25) | BIT(26) | BIT(27))
+#define  SDHCI_SPRD_DLL_EN		BIT(21)
+#define  SDHCI_SPRD_DLL_SEARCH_MODE	BIT(16)
+#define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
+#define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
+
 #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
 #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
 #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
@@ -56,6 +63,7 @@
 #define SDHCI_SPRD_CLK_MAX_DIV		1023
 
 #define SDHCI_SPRD_CLK_DEF_RATE		26000000
+#define SDHCI_SPRD_PHY_DLL_CLK		52000000
 
 struct sdhci_sprd_host {
 	u32 version;
@@ -200,9 +208,33 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	}
 }
 
+static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
+{
+	u32 tmp;
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp |= SDHCI_SPRD_DLL_ALL_CPST_EN | SDHCI_SPRD_DLL_SEARCH_MODE |
+		SDHCI_SPRD_DLL_INIT_COUNT | SDHCI_SPRD_DLL_PHASE_INTERNAL;
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp |= SDHCI_SPRD_DLL_EN;
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+}
+
 static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	bool en = false;
+	bool en = false, clk_changed = false;
 
 	if (clock == 0) {
 		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -214,9 +246,19 @@ static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
 			en = true;
 		sdhci_sprd_set_dll_invert(host, SDHCI_SPRD_BIT_CMD_DLY_INV |
 					  SDHCI_SPRD_BIT_POSRD_DLY_INV, en);
+		clk_changed = true;
 	} else {
 		_sdhci_sprd_set_clock(host, clock);
 	}
+
+	/*
+	 * According to the Spreadtrum SD host specification, when we changed
+	 * the clock to be more than 52M, we should enable the PHY DLL which
+	 * is used to track the clock frequency to make the clock work more
+	 * stable. Otherwise deviation may occur of the higher clock.
+	 */
+	if (clk_changed && clock > SDHCI_SPRD_PHY_DLL_CLK)
+		sdhci_sprd_enable_phy_dll(host);
 }
 
 static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
-- 
1.7.9.5

