Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E20DAEE0
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437358AbfJQN6B (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 09:58:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37907 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437329AbfJQN6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 09:58:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so2676533ljj.5
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2019 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnxS2XcZzdmlSU7FWbs0spB90/BTPVuxJl5GN2SI/co=;
        b=LATakpY7OV1xSLKlXscaDeuX8qO2K20YfT4oZdMmUy4lt6LTHrt8mzvOSRQFx2X6F7
         YBfZ2gv+CnJFNq9l4xoiYuOdFs3HtO6jZwP7PrpwEoN/oipWcUhv0sWI9yl5jOoBZ1wB
         mYBlnkIEEUcSbWz2QyjAdanz29kpRSBdnI87Eu//eSD07Z+29lqLAbxXyDDvBMmK8I33
         VCBoxtduq36x8yIJ+AnUM6do3Ij9mUSb0XdcY0VTaJlbv9CM0ItuQCrUcprjFnxQVn9+
         9cI8DcfPTCuEGO2ZsJ8bgijSt9qwKh16MqxVvZgxoYmOdiSNHVIICpu51UjtvMrrkCus
         c7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnxS2XcZzdmlSU7FWbs0spB90/BTPVuxJl5GN2SI/co=;
        b=Sn29HyNs66Erb/FOGCcugYjhKkYINxKrtAay6327zoMyRccR3RlNAWavrC4XW2EjW8
         FC7IzbzGGZ38/Jkn6avkHpdF9n+fJpjLexzciNIdpqyMOQZSa2SP1HWJiuUtZp60p0wD
         xx0znuDPZTVmhZKy8jwEO6bSmjQ0gY3ViJn05URj7JwkoR19lmGYxjnxSa5F9Jy6uwQG
         5zkOZwabP6BdooZ639UfoINHk1QIhEnxzGPdgESZPJXn1TqMfqL05S4oLYCRLT0xNPC6
         Zws5cRw+J+RUZDvpnrvBoSoszbbLArpKz8x6fhHrh5e4lfrdvRf3RPw45jogh5UCzLjs
         rS7g==
X-Gm-Message-State: APjAAAX9OsAP6zRqhVa1+MlrjxL153eG4qMN3tCRgY8dP3EW/EOrN/A/
        zIyBUDAV9LMcWpLBR1Kik9DS4lCUtP0=
X-Google-Smtp-Source: APXvYqw3vvsTZvTtxmCVOnu1swpXk54GoLGrxLXWlh71VuyIjZ7b3hcGeCd4vUWQTzz2BawLP8n5jw==
X-Received: by 2002:a2e:9848:: with SMTP id e8mr2699331ljj.128.1571320676674;
        Thu, 17 Oct 2019 06:57:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm975088lji.62.2019.10.17.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:57:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
Date:   Thu, 17 Oct 2019 15:57:39 +0200
Message-Id: <20191017135739.1315-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017135739.1315-1-ulf.hansson@linaro.org>
References: <20191017135739.1315-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It have turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, via mmc_hw_reset. This because there may be
multiple SDIO funcs attached to the same SDIO card.

To solve this problem, we would need to inform each of the SDIO func in
some way when mmc_sdio_hw_reset() gets called, but that isn't an entirely
trivial operation. Therefore, let's instead take the easy way out, by
triggering a card removal and force a new rescan of the SDIO card.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |  3 +--
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sdio.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6f8342702c73..39c4567e39d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
 	mmc_bus_put(host);
 }
 
-static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
-				bool cd_irq)
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
 {
 	/*
 	 * If the device is configured as wakeup, we prevent a new sleep for
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 328c78dbee66..575ac0257af2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
+			bool cd_irq);
 int _mmc_detect_card_removed(struct mmc_host *host);
 int mmc_detect_card_removed(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 26cabd53ddc5..5d7462c223c3 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1050,8 +1050,15 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
-	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sdio_reinit_card(host);
+	/*
+	 * We may have more multiple SDIO funcs. Rather than to inform them all,
+	 * let's trigger a removal and force a new rescan of the card.
+	 */
+	host->rescan_entered = 0;
+	mmc_card_set_removed(host->card);
+	_mmc_detect_change(host, 0, false);
+
+	return 0;
 }
 
 static int mmc_sdio_sw_reset(struct mmc_host *host)
-- 
2.17.1

