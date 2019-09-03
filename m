Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630F6A6B48
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfICOXF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:23:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37776 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfICOWn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id t14so16265826lji.4
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEFp+hq6WF76ZDQD++03UfUz54PPaJzLtrNfLK0kmKc=;
        b=rAhNS1CG/SmhFG+9WpuAZAeuPWOmk3PRWJElNLoXN9FlAYJrC5d2tMGtSLKAzzr6aX
         M6RoloYPdbqO7f5KwLApFXL+4m6Bk52g/kRO26+PDT6sL6QjdkhUhNAlS/6BUor2GIw9
         L9o7YJEmuiMYtKfrqR+2Ryk2eKnBqa02t4dRxFRR1EMsKXIt8npFYRpTLyGUypZVdH9z
         AbwkoOLM+mUoCkGcJjfZFqVq4Ll6oXSS/5PGsQexGh5kQ2u8yJScqJKun/W57FppaC2V
         Fyd+KYGI6mXusxA9Gfyyo7L8okOZ+fwTC9VNxuYyKTKc841K7x6ArZGR+e/EomnDuygF
         tY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEFp+hq6WF76ZDQD++03UfUz54PPaJzLtrNfLK0kmKc=;
        b=aKsPVQ/IV3lalYvMRkiT7B7ymlSP3EOtvttSFxiKHSvO3c7KXZI/0+lOT+l7SDE3Xa
         +96CKTQfT3QWd5MDMRh+TAshfAavsgQ+WuQ5GVEcMh77a+8AwWxadwd+J0AHaf5CqEQM
         EcQlE6V2Nt1w1WK9KlJt5a2u5gZm1AEBGmcEKIgWk/ueHGVCKbD0PLh/D17pAXwGZ4St
         DKGxPfe5KJCL9AdGBwAjCa5XJmTqujWrMoISJaDdu2R/4CdDRLi3RMxhebjTvyXej+tn
         Rb1CXXuMAS6UPsQPBsNCdgH8NuBZoqyoQ72gOswU7UZWyiO606kQwi5OcLYKrcC/MXks
         1hvA==
X-Gm-Message-State: APjAAAXlriHac4YgWVcGwI8g4lqw4ycrjGPcHE0+yqXzBWbxYx0mn4aK
        9OSiseSn3o++RtjwEjw/bBc/eq47vh8=
X-Google-Smtp-Source: APXvYqwW7bKtefLZcTuxAgXstvnr8V4cg5OryM4fdGNKnmzlZIkWikBetS9faCFtCgLjjSTO6ycVQw==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr8923823ljs.148.1567520561447;
        Tue, 03 Sep 2019 07:22:41 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:40 -0700 (PDT)
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
Subject: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
Date:   Tue,  3 Sep 2019 16:22:02 +0200
Message-Id: <20190903142207.5825-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
the ->ack_sdio_irq() is already mandatory, which was not the case for those
host drivers that called sdio_run_irqs() directly.

As there are no longer any drivers calling sdio_run_irqs(), let's clarify
the code by dropping the unnecessary check and explicitly state that the
callback is mandatory in the header file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 include/linux/mmc/host.h    | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0962a4357d54..d7965b53a6d2 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		if (host->ops->ack_sdio_irq)
-			host->ops->ack_sdio_irq(host);
+		host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0a565c7ff1..ecdc1b0b1313 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -128,6 +128,7 @@ struct mmc_host_ops {
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
 	void	(*ack_sdio_irq)(struct mmc_host *host);
 
 	/* optional callback for HC quirks */
-- 
2.17.1

