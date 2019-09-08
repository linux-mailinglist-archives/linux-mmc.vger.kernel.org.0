Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A4ACBF4
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfIHKNP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:13:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44932 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfIHKM6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id y4so8232987lfe.11
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w96KtsEyQIf1hGAVsd0wnGyK35jZHwym8BrQsTbnec=;
        b=fLGdd4+BgfMFa2gyfbBQXvCUukG5s+sE/ms976Wf2QRgaMPYjEzEyWGYVWAPY5Grdr
         +3vSvz+rJQTCMmu7qd+DM0m5dasetQHBbMpOWzIkE9yWH5udVAC+2qjqKuYd4Tu0we5M
         ErE26ZXoCKnSk2fSQcsXmvVyB7XdJ9FSieot7Hn9AFLkUeTjA5vLWjPpeC7KwlEgiCYZ
         1FLHq+8xlEXxx+A1TOko8hMSDhfTmSyXxjigJ7MS9muhjwiHEGZ6mOGwKIVJhhbQv6eY
         vNf0aIlnQpAOBPJNpHdlV5HFzUuGa4nltukhJbeoiWL1T+FPuAnF65iVfkOHI28c4WXR
         1CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w96KtsEyQIf1hGAVsd0wnGyK35jZHwym8BrQsTbnec=;
        b=ZQIrnKWu/85gepkuX7wNEs9k34JJ4dKlMCzHUBusN/zWHZ85G38ybdylsR17eViPRQ
         2hCg7p6V0dpf5H9x2rd7x7ytNubdBJ3gceaJwFATBO340/4g89L3ahUo9FKWYZRv6mJh
         Ycu6kBsNYzpHbo6EZqE7eKIudgdPAfPVkK048mVttEQb+dGE6Sh6+eQ5D9orW9db4k2l
         u86GXzzOGijucC/H3drwGLOHrcggpD2FW10eNAY4NyXwM2e7NGTg+X2XLO4TIXSEvDAt
         RG4f0xNWdWIRY57MUDez2kbrJ+haAD/fuzaxzV23V4zy+TycHt4W7BAQ+pUPBY49xPHH
         7KNA==
X-Gm-Message-State: APjAAAUuIzU/WFy9d7HrBrr0bkM/FZNOpaR9DcNrd31UDiZ+qeT8X65f
        gdMScXbRUPMAE6IC0YCFxwTNvisXx3vyJQ==
X-Google-Smtp-Source: APXvYqxC+7Ix/scWWeDIi59L/pZevcfUOeJNswESUdyorlg79fmFVsljPaZy8gFr/5NJfCk+RW/2fg==
X-Received: by 2002:a19:3fd1:: with SMTP id m200mr12542682lfa.18.1567937576585;
        Sun, 08 Sep 2019 03:12:56 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:55 -0700 (PDT)
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
Subject: [PATCH v2 11/11] mmc: sdhci: Convert to use sdio_irq_claimed()
Date:   Sun,  8 Sep 2019 12:12:36 +0200
Message-Id: <20190908101236.2802-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of keeping track of whether SDIO IRQs have been enabled via an
internal sdhci status flag, avoid the open-coding and convert into using
sdio_irq_claimed().

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 7 +------
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4c4285387b47..4b297f397326 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2144,11 +2144,6 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		pm_runtime_get_noresume(host->mmc->parent);
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (enable)
-		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
-	else
-		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
-
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -3382,7 +3377,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 	host->runtime_suspended = false;
 
 	/* Enable SDIO IRQ */
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
+	if (sdio_irq_claimed(mmc))
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

