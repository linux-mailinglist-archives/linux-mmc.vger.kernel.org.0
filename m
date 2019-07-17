Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA26B483
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfGQC3G (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 22:29:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44034 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGQC3G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 22:29:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so10022883pfe.11
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6tx+Qq2PicIrG+dzO2uxG2U4IUaoivU08tFcHg3bC90=;
        b=ry0p9a7B2piOJHxaJ0socATSfRMNBTtIqUgTg5L4WuZvJ3jd4fJPIPE3p5X3X7RZpA
         C+iQ1I/xyZUE5fdUDDBJIqL0jGSEnIOBYR5HsNLijGTvF0DlyD54RZS4bmG2LDEV/gM5
         7/3iA54FuRXD1C7egezt9LJR+k70q1DPHU3AT6Poh32nFg1Rz/lEi2gy5imzUkjrCOZG
         DeBl5gdMy2PeWJPP1bCYqnrsd+Nw3RaTEFkdkatxut4xTE9FR2rQPQm1nXl2uQ43ZfAO
         /CSwXHJt1AzSkk0j11Vx/q2mAapucXAJ8aOVspukpDstG95Ta/4wHpn7fNLDKTdjuFER
         65lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6tx+Qq2PicIrG+dzO2uxG2U4IUaoivU08tFcHg3bC90=;
        b=qtMnVQ9GMZM8pZx8geiLu5SrisLzywEkPTLm5BcyzGQxjiusB1TOQqOP9saUOidW2P
         UN1bmwvYWSxp/4asXqMXjvVkRXONvuNF36bQW9FUqlfibYxyW9aHSRBdVGu7vVACWoB0
         xm/RPfXGiO0eLotg5BRBfQa5r1zoUbH+1AzOicCG8cmdpfEhAEzfm6aPLaPxedEcqeAF
         2v+T0oCfCOuQg2qQoLYrJImh1xn7NoFW3/PQCkolaIT2JmB3XPb2Ue7u9hcZ4wWoC/Nd
         zvR98JEW42WJnPKj1dtj+8cAq6kv3jcxznhCOZlKykPLGuuaHoDrDhQzIEDhRNKQdSh9
         NWPw==
X-Gm-Message-State: APjAAAWyuvVImmqoDVQ0CPfE18NOaZSPa9LZtjzVduX9Mq3GqdOn3B1f
        60+uEauucagX12aaMPXasGKII9jeTTUl1Q==
X-Google-Smtp-Source: APXvYqzJUSsTFD+M6lu8qyQuwXWk/dbBc0xWO16evdYBd8ztZlEEBzYZbVK/a0ncpzVDnkTlo0phfA==
X-Received: by 2002:a63:5402:: with SMTP id i2mr10860876pgb.414.1563330545351;
        Tue, 16 Jul 2019 19:29:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm26906104pfn.99.2019.07.16.19.29.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 19:29:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming
Date:   Wed, 17 Jul 2019 10:28:52 +0800
Message-Id: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, which will cause Spreadtrum host controller work abnormally after
resuming.

Thus for Spreadtrum platform that will not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, adding a specific reset operation that adds one condition to validate
the power mode to decide if we can do software reset for all or just reset
command and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changess from v3:
 - Use ios.power_mode to validate if the card is power down or not.

Changes from v2:
 - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().

Changes from v1:
 - Add a specific reset operation instead of changing the core to avoid
 affecting other hardware.
---
 drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 603a5d9..94f9726 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * When try to reset controller after runtime suspend, we should not
+	 * reset for all if the SD/eMMC card is not power down, just reset
+	 * command and data lines instead. Otherwise will meet some strange
+	 * behaviors for Spreadtrum host controller.
+	 */
+	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
+	    mmc->ios.power_mode == MMC_POWER_ON)
+		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+
+	sdhci_reset(host, mask);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = sdhci_sprd_reset,
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
-- 
1.7.9.5

