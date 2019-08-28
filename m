Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD73A0CA7
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Aug 2019 23:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfH1Vqa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Aug 2019 17:46:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38700 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfH1Vqa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2019 17:46:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so412875pga.5
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMRVgNLfEWpj9ovY+tZTMFZ0giKQ7iTixMD9u9pTY5g=;
        b=QHSaO6N1MxmnkJMyGtKgOxaFY5l/j7VNF5hjzO5D6E4XZUPwlNRfJqVTohwXZeX4qB
         chCp93cIf1pb9alFldQg82rbRV08PjzibPT84disJENWbvr/Qil4fC2Fr9rLAfx2rX2C
         eQUVh6GYmMSJA9U9bQLhTKhsDrn0wwDyIKEGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMRVgNLfEWpj9ovY+tZTMFZ0giKQ7iTixMD9u9pTY5g=;
        b=J+bi3FEpBgVdx5F9QYCvaRf3N/ctSSr0ZZv6phpw/4OBRNQJYWrk4lyYh2VWaaPiRl
         tN4gRF3+UF2Z79jVx0SMfBxCKFxn3C++1BHmv6q0DgFMhjt1k3Py3B5PcwXFKBQlMLxt
         5e33QQA6z7Je+yA+XiQ6d4S4RjbwRGcuAIDtt/uKMNwtGEeQAfMIgzaIXYch0rnUGu/Z
         U+0ieykrUPwAjdcVUI9Nvpz/COaEcBDeFfajzpc0+jaaIiuNBKUIxVtLHxB7Xpfwe5ga
         t+Ly3VDjPPDNt2wKqVukdcp3ajQXfrsAqQWPHlRwORlFI0AGTtdPCHrXxMaalsUvg9W4
         M5lg==
X-Gm-Message-State: APjAAAXc53Czh7oqoLn2cwD3gsqGBic9C38YoFZmm41qpsQ3C08rPEhk
        rOBd387y3lPrWmxpehGOOa2eGw==
X-Google-Smtp-Source: APXvYqxO+lvLRFTlHRNGooSNlV/N4475zrCkgNKWk9GVoYJXBdfQxRmh9ssT5WYDJEFzTTAl5fQ6OA==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr5444915pgr.308.1567028789499;
        Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a4sm352975pfi.55.2019.08.28.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a function
Date:   Wed, 28 Aug 2019 14:46:19 -0700
Message-Id: <20190828214620.66003-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move the code to get pending SDIO interrupts from
process_sdio_pending_irqs() to a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
 include/linux/mmc/host.h    |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..fedc49901efd 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,35 @@
 #include "core.h"
 #include "card.h"
 
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
+{
+	struct mmc_card *card = host->card;
+	int ret;
+
+	WARN_ON(!host->claimed);
+
+	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
+	if (ret) {
+		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
+		       mmc_card_id(card), ret);
+		return ret;
+	}
+
+	if (*pending && mmc_card_broken_irq_polling(card) &&
+	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
+		unsigned char dummy;
+
+		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
+		 * register with a Marvell SD8797 card. A dummy CMD52 read to
+		 * function 0 register 0xff can avoid this.
+		 */
+		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 		return 1;
 	}
 
-	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
-	if (ret) {
-		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
-		       mmc_card_id(card), ret);
+	ret = sdio_get_pending_irqs(host, &pending);
+	if (ret)
 		return ret;
-	}
-
-	if (pending && mmc_card_broken_irq_polling(card) &&
-	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
-		unsigned char dummy;
-
-		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
-		 * register with a Marvell SD8797 card. A dummy CMD52 read to
-		 * function 0 register 0xff can avoid this.
-		 */
-		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
-	}
 
 	count = 0;
 	for (i = 1; i <= 7; i++) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..7ce0e98e3dbd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 }
 
 void sdio_signal_irq(struct mmc_host *host);
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);
 
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
2.23.0.187.g17f5b7556c-goog

