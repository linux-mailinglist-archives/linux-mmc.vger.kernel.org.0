Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691B96A2F9
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfGPHcH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 03:32:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44402 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbfGPHcH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 03:32:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so8657212pfe.11
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zOcXf+Yup6KDytTzhDDKQd6MumsmlbHo+80axgIu+P8=;
        b=bn2FUNsDp/FM23FVLi0j3ltxm4ji09nqcz8zAfrUDZJ3McckeYVEq42J4/AGbkf9PB
         fPiRWFHJ0GnYlLDN4by5JpcESl1nsMSeSbEyfwivrzNfb8KlFfZ3LmyW1oez6SE/fvcQ
         iNNuL+Ba2FRWDx3xklFG7+yGOYSMDuWrzil5F+WFbdbSXHxfRblle0YUa1Di7lSAhJql
         poF3DHIPl5uCbvEticSQxcECZ+zZeYtbSAqFsAK3U0/sFAFdRj7tyHWl49k6wcUXDAKC
         6BBjmaTF4UCOI5WXsoBYfsqhUduHvvLnt0h5NsD37VVqBv1l+ZnD4YWLAHUfso0cBPV3
         6L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zOcXf+Yup6KDytTzhDDKQd6MumsmlbHo+80axgIu+P8=;
        b=L8ONEYUCNEXMs/GEb7iKZ004L33gXx+D2Pb3ERWq0w7CyO64pFbAvmGNvAQ6r9zgWs
         SzMMJAZ9/N0gse+FxY+XYAA2IF+7xvM2tnZRIyI12MaETpDg68cnd0PSL9oNealvM0/U
         413tEjYywDbRGLp287t2hXotGnsqKBXG+oJiTPdxA5QcRhCZn4TpdTmaLHdKaSuUOA2s
         qJNnmdRGjPEI1qSBrDd+seMhM+TrJ4N/Z1HbfnIxXJkCZwgs+OWDlEML50ZhxNYfvsMO
         DG0hCUmRgqv9OUtFJljUxkx9XymRUVnz53oy0OTjOx1UeFcblEqKgOZ2hJwZTR888hjm
         DpEw==
X-Gm-Message-State: APjAAAVc68Asdq5TGHrieHF4tNm2fjfEbELLSj9b8CV9q3vL/ax2dWuo
        hGLkfzUB/Pt1ZwtesYFXGh9cgg==
X-Google-Smtp-Source: APXvYqx9TCJ4SDkya2Qx7LmTveP2LZU35Q1NJ+XB9fmogkukOIrR62ycL9co6GCA08I2Zg48lp0CMQ==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr31566087pgc.437.1563262326469;
        Tue, 16 Jul 2019 00:32:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c8sm25793852pjq.2.2019.07.16.00.32.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 00:32:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: host: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming
Date:   Tue, 16 Jul 2019 15:31:39 +0800
Message-Id: <b9cba2452c0166ef2fa69514d6ac8fbe7ee02883.1563259454.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, which will cause Spreadtrum host controller work abnormally after
resuming.

Thus for Spreadtrum platform that do not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, adding a specific reset operation that add one condition to validate
the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
just reset command and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add a specific reset operation instead of changing the core to avoid
 affecting other hardware.
---
 drivers/mmc/host/sdhci-sprd.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 603a5d9..174b566 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -373,6 +373,42 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
+{
+	struct mmc_host *mmc = host->mmc;
+	ktime_t timeout;
+
+	/*
+	 * When try to reset controller after runtime suspend, we should not
+	 * reset for all if the SD/eMMC card is not power down, just reset
+	 * command and data lines instead. Otherwise will meet some strange
+	 * behaviors for Spreadtrum host controller.
+	 */
+	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
+	    !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))
+		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+
+	/* Wait max 100 ms */
+	timeout = ktime_add_ms(ktime_get(), 100);
+
+	/* hw clears the bit when it's done */
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+			break;
+		if (timedout) {
+			pr_err("%s: Reset 0x%x never completed.\n",
+				mmc_hostname(host->mmc), (int)mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -381,7 +417,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
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

