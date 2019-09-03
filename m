Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB527A6B4B
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfICOXM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:23:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35185 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfICOWl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so7659747lfl.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jh5yAZhoAj5RycS/TnID5yrHbMp2QKGAFD93Hw0bAOI=;
        b=cELaEzNikSOlmreYq+cxGTxRpffSojGMN41csSVqIGCzJKNrr/a7hyJZ1SLbsRfp9q
         TpymGj9OO6h9wE5NxjGDLLSXxMZrciULGZE/Uq12zZkxx64h+9Zbixi/10lgQN8iEjjb
         cwl5rNwuq4hziY7vSlAgWzQ9STjxeVV+o56PhVA5S6KfApTp0LM1Nsy/5QbDRfhCeDnb
         a2GFjq3E0Da9kDGLDMKInpKxhyaTS+yTbe5Ja/BRBnp3bh9jqXqisysukIUCNUer0Gvm
         M65mWyyyc4/+2nuttKsZ2TjFCbhLcPbkGqr+nS9ANXQndoauAkU+K3MpcuABubjSWSyL
         2haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jh5yAZhoAj5RycS/TnID5yrHbMp2QKGAFD93Hw0bAOI=;
        b=WUkx68BuDW78lwx9cOxcADSG36yZWRimhovRYy0NXdQG3mjLHQ22jDbu1LbUFa7G8j
         Bjdh5DEE1F79LbXrWPbHy5Vil1bl7QtSHQ0rodpUj99NyT+azpXZmXLJ6vktGGWrjjsM
         Iumwj0g7Ys3ZFu1Y9RmGFYVPjdWhSZ3K//Naf9H11Rg9SxlrcC1YO9mpRMo9SRT1sCyG
         J0R5W8vAmi6PVyQrw1CoWlJ7NOG0QrFyoy43CW2KLIvLan9NKyvJbSgbeMONQZ8twL/t
         GsYodCtjLmyg7HjpRYk7hR0t6jzx0VAukaLYOKK6JYLaw+enHhhFBPQkGFfDSKQsJcAU
         tMNw==
X-Gm-Message-State: APjAAAXqjxDospoXnv+2V72T1ZEQDjbwkdjHRLiCy6TqNav1avsic5G0
        k1Sai9/f7281NlUR5U3Ou3nLjqFqtTI=
X-Google-Smtp-Source: APXvYqx500m4vzr+UFCeYKz2c0FMSfasvwBbVgJxSTzvqlZDtcVpzL2mXRCD90OhISPXEiSC4VxOew==
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr21404817lff.48.1567520558740;
        Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
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
Subject: [PATCH 04/11] mmc: core: Move code to get pending SDIO IRQs to a function
Date:   Tue,  3 Sep 2019 16:22:00 +0200
Message-Id: <20190903142207.5825-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

To improve code quality, let's move the code that gets pending SDIO IRQs
from process_sdio_pending_irqs() into a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[Ulf: Converted function into static]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..f75043266984 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,34 @@
 #include "core.h"
 #include "card.h"
 
+static int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
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
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +77,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
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
-- 
2.17.1

