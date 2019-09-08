Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEAACBF5
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfIHKNR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:13:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43775 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfIHKMz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id q27so8231301lfo.10
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBQNfgH478Agi6Qq65UuCm0AdFgtpDY1/4Ukd7tPN04=;
        b=Mcwgjbdp32PK8AZUMsmSzkK40Pkz9/HfpmUTEvkfaXJir+M1fqFP9wGs7zB3qW+3by
         X5GgXP39/Npz/F+rDuxpX5aPchObiqqORL9ZlkuVhbpwB+GFTVF7lub61Evi0KKMCezt
         Dqw6YkxkDH/JmWHtRO/poQ31ezNS6Psl/exogXW7T0ppn4elIzW2We2net4M5m9JGbHu
         g3aACABD48I4MJnMvQk/ClIIG2b67EDRyRtu1/O5m8QGdNBfBol/CPk5DbIfeeHSs8Ap
         2nqZDZM+ZAlZEhT9VcPp+fUkBFIMMBx4t5RzmA0fGreFt8Pje7ZKBQ8S/7rcd5abLAY0
         0pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBQNfgH478Agi6Qq65UuCm0AdFgtpDY1/4Ukd7tPN04=;
        b=ScGhUDBnn1HP4j7XakrjSC+gvAIEVQnrwzFOw1LKrs8BMixI7yl1ksmEPfvACw6Nvg
         Cn2qCeorD9w7E1jih3OWgqQRsZ9KNcLdCPo5a4Qv5OXdPAce3BUOTPXbZKOn2JEhFQyf
         jVg87BZEsLpydYAmdLlLCEWaq26ACDa9v+FqSR21vjTjJ2OIbsqx/f0OBbTxa1+ZhIaH
         sektrcyjJdG+bSKO7T6HtWxpoxrtZ4SV50uIsfhWR5zikFav2re7AOV3xgvg5dWR87rx
         3kosQUIZuzKz1FXP/HH8xsOKm8CZQ4ceht5FLEMgMeSzmVgv9TFBFzw/OKIRfdxzmLdT
         tksA==
X-Gm-Message-State: APjAAAXcdp028l9cYb2drG3ZKVwSyXBGyQM6j3AzhSmZxHaFfJ+vu538
        O+rSaIm6cztaSQqMxJxkkvbew+9swG8HMg==
X-Google-Smtp-Source: APXvYqwAZcqc8OF77Bx7ciHC787UfAzR/Jk/8p6iWyWeRbk6Ie4qBOLjOvzlPaRvFZEofbuug/3pUQ==
X-Received: by 2002:ac2:4a82:: with SMTP id l2mr12357581lfp.85.1567937573894;
        Sun, 08 Sep 2019 03:12:53 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:53 -0700 (PDT)
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
Subject: [PATCH v2 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date:   Sun,  8 Sep 2019 12:12:34 +0200
Message-Id: <20190908101236.2802-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..efa6cda8c991 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2163,8 +2163,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1

