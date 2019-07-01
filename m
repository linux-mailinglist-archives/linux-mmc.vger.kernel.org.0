Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60C23105
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfETKMq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 06:12:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46083 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbfETKMp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 06:12:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so6489600pls.13
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FYWsY1+N4H7CLwGBpVFg0VRy5BIrNigGYHZlus/sqGQ=;
        b=ip83O75NZLwCKECGfM8b6w+f/ukjta4M9JaLc+MNN/r+BiHh5U+c3obLbGmXR368fc
         QbjaUkbxGFqa7LV7Z0H0ItwU8gJwB4r5wNeOPOYY/s+jYld1d4r87HmHtf94EhINLOI5
         5dRx8h7+EELboXqiAQTsz3r8c0GVbrj35Bf5fuZOCmENS9jfE/F3GeumyIQ8Q18azMoB
         W1o8N49xYJkVv1nNphy7+SDWOFwWoiVNXHp5Hj2+2m42U4U9SryKWswV8BoJtrBxR09c
         9NeG53QxHzarkWRexNeHOXVUs8hZ+/o5qwGEoBYLMpyEyHJHZdifvWvdDR91wF3dUSrn
         qjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FYWsY1+N4H7CLwGBpVFg0VRy5BIrNigGYHZlus/sqGQ=;
        b=ixVqbKqO5szuQUIalrTwp5y0gwotvGTkdVAmpN9y19F3wrOK6RZe+wJTHHozZb8wW0
         +hVXmJMpUS/SzRP3jfoIkVmygmLwBNQtabybNFWm3M6ucoGUOPTbh7tPlU/L687PgMj8
         SHhGyuFHHFut7DD3GFBIvoRAylpBTx5hyVmB+m/Z2OhRVbwu5aWaBoBYFy0ojbZJrqOz
         +Yp4auz7R9vwjh1kgi7CWqVlK9cGqmnXftbo7UWSotjJ9p25vxwjumB5pNRUodc/7xhD
         hcl19aAOpyXiybjusYo5WD1i3DpUTboBfI1qQ9Kwr2+nMES8HL+v9teCPIKRpdEDC6UT
         tlXw==
X-Gm-Message-State: APjAAAWpDpDbFegh5wHe37y6etm8g09P9VzkQJ2eQ82xZVgdi6MuhFLs
        oniAvvuDCpJVKP5OiKi6q7idFg==
X-Google-Smtp-Source: APXvYqyLvXs0KyuJLGO/nRkJOE9g/rrJIqJslXBXRu3KGM87Ilo86/Rxhvc+xOflJPm5UjVip5uFmw==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr1223581pls.112.1558347165145;
        Mon, 20 May 2019 03:12:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 5/9] mmc: sdhci-sprd: Add HS400 enhanced strobe mode
Date:   Mon, 20 May 2019 18:11:58 +0800
Message-Id: <20349e8ebd4c1ec64fb5f8cdd9e094d0c1732855.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add HS400 enhanced strobe mode support for Spreadtrum SD host controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

