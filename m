Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0850BA6B3D
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfICOWu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43340 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfICOWt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id q27so13010120lfo.10
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRD8RZZIfXxFxN/71F8TIreo7M10o8NGOL7lgd4hWxU=;
        b=J2D/ecsnkgDBU3gX4LMmTKbcJzk+6AjL8rx/Kjm2RA4Bpf1HLq5ZgxMvD4ooI7jbeO
         zwhtp/FEBOzXdDLSlByqRUC7VRwxF7xMgMlFf8m3RBZp0N4JgWe4fKxVyM+k7iJeNNVs
         bAeM/QQG8qs2PRoUhRDyHPrG61sV8f/dbndWhARzYr8iTyzTndoEVITYJ3HGDLRhI8G/
         y3AWhLCI5OH9dZhYXg9X0sNfVNxMmjDANlm6XZU0Ghpuh+vDOEIXvyy92DalwjAe6bmL
         cLWVuDUK77glbB9x7RX+KX0jaoVqvuxsr59YmZhPhBOwIkIPdiQE44IOBox/NVJpOHXz
         jQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRD8RZZIfXxFxN/71F8TIreo7M10o8NGOL7lgd4hWxU=;
        b=YHFGMV1t+ZvGJ/vzy++BSP3iwV7W+GO/4Qc38ovEek/IzNE03lsG2SZKgdUUm0Kou3
         GtIiEgzBDNRLhxYiv38eQfUeyY1MpqrEt2MaUjD4DWXdKdVatW0X97ovo41mJrAcoZNh
         rRCkbygEzuvNdel1YRJDja5J//ri0C9mrQ4xI1UBxepqHENihatgJJenGnfdCiHAFLlv
         bFyi1Q7C/+cLJ7byLS1WRPnMVh4L9BIFV0DtHzy/+KSAVO4BVdOUsYcyFUnZ7F7eanrW
         uIaLVd+tHs4gNEjg6LJhaY2a+5EA6OSKC/uf9CCWLBzihvnTqeKk12/q70h5uxEmSjnH
         1ebg==
X-Gm-Message-State: APjAAAU8RbsRbHc7iW+dzfzhu49hPv2oOnozp3jaA/J+IcKp77aaBpAO
        iWtusJHkQ2zExwIBwthIv6Ar8yASals=
X-Google-Smtp-Source: APXvYqzSHG0+TZa6KjRS808SzcPkET5qRVkq972VhJ8Mj2w5fbGg73wGEtlGxYnVldeA484PW/gp4A==
X-Received: by 2002:ac2:514c:: with SMTP id q12mr7287750lfd.145.1567520567815;
        Tue, 03 Sep 2019 07:22:47 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:47 -0700 (PDT)
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
Subject: [PATCH 11/11] mmc: sdhci: Convert to use sdio_irq_enabled()
Date:   Tue,  3 Sep 2019 16:22:07 +0200
Message-Id: <20190903142207.5825-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of keeping track of whether SDIO IRQs have been enabled via an
internal sdhci status flag, avoid the open-coding and convert into using
sdio_irq_enabled().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 7 +------
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7df22ed65aa..4b4db41aec50 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2142,11 +2142,6 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		pm_runtime_get_noresume(host->mmc->parent);
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (enable)
-		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
-	else
-		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
-
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -3380,7 +3375,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 	host->runtime_suspended = false;
 
 	/* Enable SDIO IRQ */
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
+	if (sdio_irq_enabled(mmc))
 		sdhci_enable_sdio_irq_nolock(host, true);
 
 	/* Enable Card Detection */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8effaac61c3a..a29c4cd2d92e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -512,7 +512,6 @@ struct sdhci_host {
 #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
-#define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
 #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
-- 
2.17.1

