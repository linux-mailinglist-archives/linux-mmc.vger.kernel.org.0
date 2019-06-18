Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531314A57A
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfFRPfC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 11:35:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34894 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRPfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 11:35:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so9640102lfg.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXFe8l122poOCFrcN8cZI3D2EE1Nc366dY+GJ8RNKw4=;
        b=VBR0Zcst/y6Zg7oIQ4mCiOZS9J4Gla0OUrgxhrMyHzEX3xyIlkxoYPJ5WnVcOwRdPe
         xWKodz+F4ubwZAi3LVLAOmbh3sGvqYCT4fb7hu9NqFdIV8folFmY/Iw2nC4vj+54N0DQ
         3rhY0tHUiuUUPz7ADBDPvIzCWmjyiTTvPnzP5PYVyo8DOLizYbCzaRYXvaKR3Jds24pY
         83Z6HVJhtk3eDVKic08lSLmasQr0e3102/hWgIOKrkdAMHO6PgYjuDAvRZJs9o6iJFSR
         mcjHJjyR26i8a4mjI/ZXNE4cTrnxyN94674N5liojrdPmAoewMaZorggNXMMnPNLjTDh
         EVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXFe8l122poOCFrcN8cZI3D2EE1Nc366dY+GJ8RNKw4=;
        b=Mfhn1/wJADX5GgbZIwz0h893mREyGqcZitO3WaEOb2gcASw/75ZsF1ItpK3KO1kg1R
         +46o48wTz2EK8xMcbkMcM1l1TrM+no0dO9VC5BdtB0Vp2bBAkMWtxT2Gu8TeBscus45G
         u0iAW+vTzCo4iQWw2dg6SHWH9KY9Gc+rQfciZHC5mPGcBO8DHqhbRVTtFLxME6aI+vi+
         o5Sjz32hr0P1/qFKFUfgea/Sv4N6ZYMB3+iLhPYz1pb1qfAz4ZRu9muC1iCxwlZe4ix6
         1UnrL08/Q5jCCOEEYpS0ky6iP7HF5//C/5oWvLrJlWLSnr0NuPX89A9GaqNFAlkYW2xy
         I4/g==
X-Gm-Message-State: APjAAAX7lesvLINvyVeL7Tt+iz2FqAnTNRvv1KhI4Pq32vfWnAT1qT/g
        pRkRPzMYyydj6c0Lys+x3FF9VpV3HF4=
X-Google-Smtp-Source: APXvYqyOREFdkP4FC4HW7yzVMISId5ZhI6EQ+UQ/bNuv27HzdT0y6uvxlbXF6tdziRwwwuG91a5bpw==
X-Received: by 2002:a19:750b:: with SMTP id y11mr21457683lfe.16.1560872099899;
        Tue, 18 Jun 2019 08:34:59 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:34:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] mmc: sdio: Turn sdio_run_irqs() into static
Date:   Tue, 18 Jun 2019 17:34:42 +0200
Message-Id: <20190618153448.27145-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All external users of sdio_run_irqs() have converted into using the
preferred sdio_signal_irq() interface, thus not calling the function
directly any more. Avoid further new users of it, by turning it into
static.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 include/linux/mmc/host.h    | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 9f54a259a1b3..0bcc5e83bd1a 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -92,7 +92,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	return ret;
 }
 
-void sdio_run_irqs(struct mmc_host *host)
+static void sdio_run_irqs(struct mmc_host *host)
 {
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
@@ -103,7 +103,6 @@ void sdio_run_irqs(struct mmc_host *host)
 	}
 	mmc_release_host(host);
 }
-EXPORT_SYMBOL_GPL(sdio_run_irqs);
 
 void sdio_irq_work(struct work_struct *work)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ecb7972e2423..a9b12322c775 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -504,7 +504,6 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 		wake_up_process(host->sdio_irq_thread);
 }
 
-void sdio_run_irqs(struct mmc_host *host);
 void sdio_signal_irq(struct mmc_host *host);
 
 #ifdef CONFIG_REGULATOR
-- 
2.17.1

