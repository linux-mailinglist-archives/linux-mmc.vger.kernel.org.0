Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16751A6B3B
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfICOWr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40402 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfICOWq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id u29so13018791lfk.7
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fqo5mVILkGtSq0rdVWivMfGJMV/aCWEQdU0YePivD14=;
        b=tRNkWdgIeGlIeHF31vEECt46I4epYMs40YdMzeIjjLXwGWZIOSybZkB58seaPdpX8t
         sK4/S6ZL8nQNC+J05IX8ZtuSmXyvtt4moyYsM6VWqgOFZ1xR35BzuIqvZ7vjDpWCs5xp
         PIAQST0jb5AsjNJQATqgg23HbTVCPPPvTseizJwniLgedXlUXZ7/GNmioOl27/gpuJiI
         RC9FHbBTq3rVTg6D0l9Dy5+FCNvqJcO/ak28h5+VWbDCHYUCbke2VEaZtBxPufmI7Xi8
         49v5d80bi3w3XilNwMLbgLiM+D5CqG1T8vuyDsdzb8zxrZLyM6IeLXKFzsEYf7MOP3hL
         z2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fqo5mVILkGtSq0rdVWivMfGJMV/aCWEQdU0YePivD14=;
        b=m5eixvTR3rzKecGDdqnyUnIMnpnu4wkjo4ynEPSeuaVL2Ajeo4BY0lLNppFfv3G3ZW
         HctXo5z9mAlcoB2T9xqIh/kP/X3FH3cmg1b0pfjxMUGqNued5ZIUMxcWfNJvyL6he+ld
         ysi7nqVsP78eb0E9ELxWbKejVFM3v/nIH9t7elGiX8QHCDpd8KwvAGCTiqXM75bZOya9
         ReblTzsi99m4haZl6Lsre7hj4n4W8CAzUj4rezM/d0hxU0sj+5sJJKkMsbG1UOEpwYpU
         Zm8O890mnhoH8ltY6YjBn1eyCTbotq/KvMhEVrGGNzOY5MoTwDGladbrwarQ2g62jNQN
         Ck8g==
X-Gm-Message-State: APjAAAVuOxZXnSxexMLeJAdql3TRgks0k1M7uTUGkcP9SSqsK/yHiZqo
        PtYikAziPpgs1vLwdF2jJKvdyNcLdus=
X-Google-Smtp-Source: APXvYqzhx0C8QVyDdtmnXTBzvrkQ/qix4A9PLncU3OxOKzlPKzY1ZMxbBJXHsY8c8skjXFT0ebn0Iw==
X-Received: by 2002:a19:f204:: with SMTP id q4mr6969539lfh.29.1567520564028;
        Tue, 03 Sep 2019 07:22:44 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:43 -0700 (PDT)
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
Subject: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
Date:   Tue,  3 Sep 2019 16:22:04 +0200
Message-Id: <20190903142207.5825-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
behaviour. Some problems have been taken care of so far, but more issues
remains.

For example, calling the ->ack_sdio_irq() callback to let host drivers
re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
which may not be the case during system suspend/resume. This may lead to
that a host driver re-signals the same SDIO IRQ over and over again,
causing a storm of IRQs and gives a ping-pong effect towards the
sdio_irq_work().

Moreover, calling the ->enable_sdio_irq() callback at system resume to
re-enable already enabled SDIO IRQs for the host, causes the runtime PM
count for some host drivers to become in-balanced. This then leads to the
host to remain runtime resumed, no matter if it's needed or not.

To fix these problems, let's check if process_sdio_pending_irqs() actually
consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
->ack_sdio_irq() callback.

Additionally, there should be no need to re-enable SDIO IRQs as the host
driver already knows if they were enabled at system suspend, thus also
whether it needs to re-enable them at system resume. For this reason, drop
the call to ->enable_sdio_irq() during system resume.

In regards to these changes there is yet another issue, which is when there
is an SDIO IRQ being signaled by the host driver, but after the SDIO card
has been system suspended. Currently these IRQs are just thrown away, while
we should at least make sure to try to consume them when the SDIO card has
been system resumed. Fix this by calling sdio_signal_irq() after system
resumed the SDIO card.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c     | 2 +-
 drivers/mmc/core/sdio_irq.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c557f1519b77..3114d496495a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			host->ops->enable_sdio_irq(host, 1);
+			sdio_signal_irq(host);
 	}
 
 out:
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index d7965b53a6d2..900871073bd7 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,7 +115,8 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		host->ops->ack_sdio_irq(host);
+		if (!host->sdio_irq_pending)
+			host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
-- 
2.17.1

