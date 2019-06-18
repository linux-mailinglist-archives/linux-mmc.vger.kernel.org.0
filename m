Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE74A585
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfFRPfK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 11:35:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37592 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfFRPfJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 11:35:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so14911ljf.4
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esuXjtqW4uUKLJzIZfGaOG3mfIeuD1RYtSgNoLM7wQI=;
        b=tbu1o1Zd9clAqV903WpQWYeICZSQRtZDs4H7OVK9VyaTFqToYWJlF/kdv1qtyf+gTm
         HLfE13sD46FlxWNViy5vu/o1sQwXqVlA4tcHSu7qJ3v78Sw0NMDTlBP+q6870RGOqhGR
         Q5hMDdhjWXBX5T1ShnsUPaouX+8VWG2kzJwQepTbaPEMw7mubSy2SkjLuyA4bYYTlF+B
         A2ThCYTnSd8MqrYRlnJewRkh6ABvjOfdzZVtaqCa2ejuZ0Tss52HfLky1AhjaX9YQzJY
         GHyZZJXNckhFYDA0//onqdJnF1zar0IDTBnCQaIYuPZzRAvTDcG1jmqFlVUMpFZ63IUN
         5IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esuXjtqW4uUKLJzIZfGaOG3mfIeuD1RYtSgNoLM7wQI=;
        b=etgYDrXkGzQ0bj2oqNGNS7fLSidBCLC+Vy3GcOGidzO9yPGhaQRITBAbAuC0LV1W2K
         izOwmGVBtDHHhL7iS6rHj+oajJ1dIAqS+P9yiMH3/VvLy0KLTax93BF4fxY2FHjejnt8
         omjyZTaWNKfKof1/wxMY/OpukmpTvoxZnKzBm5hSFnidGpJJhPqyC2125RAwx/ozeqYO
         wJmNximZv+o+OcN2dZNMw0zQdme/MPAFmyLtaYR0J6SYfgwj7pQ7on9sb3peq695n1PH
         VlKnL4/hmKv9ZAC9Gj34RYZwGd+MLa11ctZpRhdF57bVm+dCcHFqr6gyLT7LUyGRGX0d
         d1iQ==
X-Gm-Message-State: APjAAAV5qtW98P0qMSjt0OFvaCUo9G1TzLPcwqRs+DxJnv3qhFd8HSFC
        EEMPpMuZhXYWPBFsvcYr5ySniLhYjtQ=
X-Google-Smtp-Source: APXvYqzWCTCYLUP+kCD+dCmIrRcVn73QgqU3WoKH776UKBay5LzF5cbfo9Q30OOIi8UtbKbirsyevQ==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr155663ljj.160.1560872107526;
        Tue, 18 Jun 2019 08:35:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:35:07 -0700 (PDT)
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
Subject: [PATCH 6/7] mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
Date:   Tue, 18 Jun 2019 17:34:47 +0200
Message-Id: <20190618153448.27145-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The "powered_resume" in-parameter to mmc_sdio_reinit_card() has now become
redundant as all callers set it to 0. Therefore let's just drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 945416c53b56..0bf603670f61 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -816,7 +816,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
+static int mmc_sdio_reinit_card(struct mmc_host *host)
 {
 	int ret;
 
@@ -845,8 +845,7 @@ static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
 	if (ret)
 		return ret;
 
-	return mmc_sdio_init_card(host, host->card->ocr, host->card,
-				  powered_resume);
+	return mmc_sdio_init_card(host, host->card->ocr, host->card, 0);
 }
 
 /*
@@ -1000,7 +999,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-		err = mmc_sdio_reinit_card(host, 0);
+		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
@@ -1026,11 +1025,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_sdio_power_restore(struct mmc_host *host)
-{
-	return mmc_sdio_reinit_card(host, 0);
-}
-
 static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 {
 	/* No references to the card, cut the power to it. */
@@ -1048,7 +1042,7 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 	/* Restore power and re-initialize. */
 	mmc_claim_host(host);
 	mmc_power_up(host, host->card->ocr);
-	ret = mmc_sdio_power_restore(host);
+	ret = mmc_sdio_reinit_card(host);
 	mmc_release_host(host);
 
 	return ret;
@@ -1057,7 +1051,7 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
 	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sdio_power_restore(host);
+	return mmc_sdio_reinit_card(host);
 }
 
 static int mmc_sdio_sw_reset(struct mmc_host *host)
@@ -1069,7 +1063,7 @@ static int mmc_sdio_sw_reset(struct mmc_host *host)
 	mmc_set_initial_state(host);
 	mmc_set_initial_signal_voltage(host);
 
-	return mmc_sdio_reinit_card(host, 0);
+	return mmc_sdio_reinit_card(host);
 }
 
 static const struct mmc_bus_ops mmc_sdio_ops = {
-- 
2.17.1

