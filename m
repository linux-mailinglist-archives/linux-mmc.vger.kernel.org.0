Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDDA34169
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFDIPO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:15:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34684 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfFDIPM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:15:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so3696677plt.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1vxV7xw/5L8i8m4bOyu5pRBcqwZ6n7yFKBRMfko8eAg=;
        b=yF/IS8w7PJss7KY8M0Wgdbhr4VXw0eZdXylHTkYXpnzppT6cn89MSsaQKKrjC+DtQN
         1GtV+NlutX5shDQlf1LrHQXLzThmo4n0NLbMGxqY8RmRnIiR6hfvu8BJoPrg/+oUZHxB
         +S7jPtfHSDhI+jm1xYZlszQMW6y3F3wkCVj1Hun96siKj9lKc/AhwLiKhSEEM/la8VKX
         /dexH7LLGORAMf8idnkuxH74+l9ygl2Kvoz/7surXaj1r61Kubiw+dqSgEGF2t3/gI7E
         zvccHnVXEs90BwkkWUltHssENapZM1r1qHYnT69sGzuHWmyUp9oo0FJhRwKFmJ0zJhcL
         3ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1vxV7xw/5L8i8m4bOyu5pRBcqwZ6n7yFKBRMfko8eAg=;
        b=UBAzOcQoxoRdLSKmgGiHEJ+aIBi38gsBIasWZj4Q6Ebi6AlzMC0y+j1/f+SaqtIZsq
         pAC4XWDmkq+NAiBgjRC78zauOhddDEe1IVgTNiXU1k/h43EeKKX6aEasjFCZbYDumoSo
         tP+jK4prasFPhkRuiXrfgvptbw+YD7hzFr673CYzArSxtofZuzfvAaWgCYjlgV3gSx0f
         XeVimADQC250Cdu7tYuFiKMoFSLM6uWRoS3ATV7AliuK2kAwE6IpapYB9Bk95cDrRozo
         9O4tSIg7NoawTN02hYWIAE6/19/XKHNjYb28omr6Bj8O0jU50DU6czWlX0y/nZYZclbK
         adCg==
X-Gm-Message-State: APjAAAXKV9tz7BjfhBR/u9oqGZuGVRYmkjT3wFYSUon1gRJhU6yRCVHp
        09G4KY08oqSFSm2zXpKDkE+nPA==
X-Google-Smtp-Source: APXvYqx5tr7hLBSr2deQxAafI0cRVbDGcHrT9nSSxEdJBYE9hB3oMoE89I4R2+wZwZkLmlk0Mk2HWg==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr27683709plb.27.1559636112034;
        Tue, 04 Jun 2019 01:15:12 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 5/9] mmc: sdhci-sprd: Add HS400 enhanced strobe mode
Date:   Tue,  4 Jun 2019 16:14:25 +0800
Message-Id: <e1a8f70c1a393e110677b447e5fd1f25667546b8.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add HS400 enhanced strobe mode support for Spreadtrum SD host controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d91281d..edec197 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -41,6 +41,7 @@
 /* SDHCI_HOST_CONTROL2 */
 #define  SDHCI_SPRD_CTRL_HS200		0x0005
 #define  SDHCI_SPRD_CTRL_HS400		0x0006
+#define  SDHCI_SPRD_CTRL_HS400ES	0x0007
 
 /*
  * According to the standard specification, BIT(3) of SDHCI_SOFTWARE_RESET is
@@ -132,6 +133,15 @@ static inline void sdhci_sprd_sd_clk_off(struct sdhci_host *host)
 	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
 }
 
+static inline void sdhci_sprd_sd_clk_on(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ctrl |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+
 static inline void
 sdhci_sprd_set_dll_invert(struct sdhci_host *host, u32 mask, bool en)
 {
@@ -325,6 +335,26 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 ctrl_2;
+
+	if (!ios->enhanced_strobe)
+		return;
+
+	sdhci_sprd_sd_clk_off(host);
+
+	/* Set HS400 enhanced strobe mode */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	ctrl_2 |= SDHCI_SPRD_CTRL_HS400ES;
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	sdhci_sprd_sd_clk_on(host);
+}
+
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
@@ -346,6 +376,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->dma_mask = DMA_BIT_MASK(64);
 	pdev->dev.dma_mask = &host->dma_mask;
 	host->mmc_host_ops.request = sdhci_sprd_request;
+	host->mmc_host_ops.hs400_enhanced_strobe =
+		sdhci_sprd_hs400_enhanced_strobe;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_ERASE | MMC_CAP_CMD23;
-- 
1.7.9.5

