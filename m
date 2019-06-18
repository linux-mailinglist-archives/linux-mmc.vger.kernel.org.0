Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327AB4A034
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRMFZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 08:05:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42190 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRMFZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 08:05:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so12828670lje.9
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bg8QqDQoZIq/5wmDEJaOxBNPAWkAsd1tFZ5D6LNidQw=;
        b=qr2S0sjS3RepdjF6+LNucEQ3iBw2UY5MT5ExudDZ46nwwFLC/H/Ii11UDx/nXGoNrn
         VDJI+lrkLjfWCL57AXv11MyrxiyACQIpA6S7tzjDBHIYowtcxwbdv7J+QTMVGOf8ey8B
         HGI9JoMqtX4x9kGSEVTSfdqlw6gnM01bhfCzO4lXAu+Mh8tdr78T0S5ZX4uvYZG/8UNT
         t8JJZbXDtpULS5us5eyZ031XoqIdxi6oj0ZTtZL3CVWon2e6x+mYj2hTUTVGoQ8KDrIV
         wDjIlAm9KycrMKXdeF+gMkbScOg4LHoSwlrH3wXuFX0+PEdAXp/UTbKRuLe8CYcdCtTa
         qspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bg8QqDQoZIq/5wmDEJaOxBNPAWkAsd1tFZ5D6LNidQw=;
        b=f+EmF6z5H61jIPNdgocICIJcTxyyVF4N4tlU2j+1zsVxCPU39MkJvQz/zB33MU+X7T
         FHOhwY8QBsUb+E+OtPx5kPDqRKcNjshTJq/hGobjP8WZDmMi1wv+hL1OrfS9PBq8Scx7
         eJ05gxLgAIEfbcNNHR900V8pxzKpSyL4DjVy0VAStiHUlgwSth5L5C5/PhCtjpeDEoqQ
         2sqJDQnFvN20G8eVwBNzRTAQ+8Mnyypg38lSDUXnY42xRMu3AWGOAu/GlohHyahf+flJ
         dPGHDSyIuKxJl3SjoiD454r7k2Vmto//NgSU+goR4h3Z7ffWGGW4+pHTrXUrM+bS6iy0
         pT/A==
X-Gm-Message-State: APjAAAXSsf58vteO4JKweWPFLWlhRBMflmefPxuudRyCQXuHmFUcIm0Y
        5oZvGhh0tysjfcNowHWrkc7BvszQ4ow=
X-Google-Smtp-Source: APXvYqwAJpLDxl74LqLKNXFGb626+sV0+gyjztdfmoze+z1tsfu4A8ry8bv7JaM4GJBlfeJLDKfMDQ==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr22437486ljk.93.1560859522947;
        Tue, 18 Jun 2019 05:05:22 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id r11sm2849691ljh.90.2019.06.18.05.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:05:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] mmc: core: Prevent processing SDIO IRQs when the card is suspended
Date:   Tue, 18 Jun 2019 14:05:17 +0200
Message-Id: <20190618120517.23123-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Processing of SDIO IRQs must obviously be prevented while the card is
system suspended, otherwise we may end up trying to communicate with an
uninitialized SDIO card.

Reports throughout the years shows that this is not only a theoretical
problem, but a real issue. So, let's finally fix this problem, by keeping
track of the state for the card and bail out before processing the SDIO
IRQ, in case the card is suspended.

Cc: stable@vger.kernel.org
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Respect error code in mmc_sdio_suspend(), pointed out by Doug.

---
 drivers/mmc/core/sdio.c     | 13 ++++++++++++-
 drivers/mmc/core/sdio_irq.c |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d1aa1c7577bb..712a7742765e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -937,6 +937,10 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	/* Prevent processing of SDIO IRQs in suspended state. */
+	mmc_card_set_suspended(host->card);
+	cancel_delayed_work_sync(&host->sdio_irq_work);
+
 	mmc_claim_host(host);
 
 	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
@@ -985,13 +989,20 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		err = sdio_enable_4bit_bus(host->card);
 	}
 
-	if (!err && host->sdio_irqs) {
+	if (err)
+		goto out;
+
+	/* Allow SDIO IRQs to be processed again. */
+	mmc_card_clr_suspended(host->card);
+
+	if (host->sdio_irqs) {
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
 			host->ops->enable_sdio_irq(host, 1);
 	}
 
+out:
 	mmc_release_host(host);
 
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 931e6226c0b3..9f54a259a1b3 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -34,6 +34,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	unsigned char pending;
 	struct sdio_func *func;
 
+	/* Don't process SDIO IRQs if the card is suspended. */
+	if (mmc_card_suspended(card))
+		return 0;
+
 	/*
 	 * Optimization, if there is only 1 function interrupt registered
 	 * and we know an IRQ was signaled then call irq handler directly.
-- 
2.17.1

