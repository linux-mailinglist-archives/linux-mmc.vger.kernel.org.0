Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15DAA0CA9
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Aug 2019 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfH1Vqc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Aug 2019 17:46:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfH1Vqb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2019 17:46:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so595940pfc.13
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2019 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCwVhN3TQcmkE8hUu5j/xXpSd3e+tR68wtM9AGyuN8I=;
        b=N44nBGxrlYmGHY/VHkORJaIABSxU1jeAY9jAGawh7CIGY7odHwcBx9N70jrNAcvLpn
         0+TJTJqDHKSf60Q0IZJJc5VsRI4LnTxI+OyNTR04yAQc0a4hsNaqGliWtt0rX+5R8EGR
         I72+o+Ouh/tw51hui+hN0cBvc4CzTz87rrX+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCwVhN3TQcmkE8hUu5j/xXpSd3e+tR68wtM9AGyuN8I=;
        b=LsUIKMsWEjZ0KUGx81xnjuXtnLarFemTmsSnognsOBEH6U1iJv8+Eqq7tC6nfnXUV+
         0hpXbOTDEfHytGsE1vWA1Zw7vMh1akM7A+ompFn9inJvgypVm9XzInBC7on/4t+8V5PH
         Bn1CsBleeE5pKDwxZ3PWTsIqZqa4prcB82oxndDXH8gZG4CTyYOXsndyDiPAnuf78xiD
         xY6kiCT6fhAWsBe3fOOABNqWtu93VurqpM4UkRVeM13Kua9ghRDLRGHVoJdKfNpEUxRB
         kVwkl4nHrBwYOIEG8wub1G0t5eVKs+ZdlOPz0YCkagEEI6WavWhkyAP/bq3LjjVhxWZ0
         l+aA==
X-Gm-Message-State: APjAAAUfm0vDRzb87U2tH/oDu4JyL1duZxe4kZ5h1fcjSe9aczoyngCZ
        RFMtyUoZ4HxM6Tm7NUfK4ylTsA==
X-Google-Smtp-Source: APXvYqzWktWMbbvGLUFv293hEVPQ2VUXcidEA8NYcb5z2+vP7fXFWdkHSvP3Vi5wbZnpkVlZTGQz+A==
X-Received: by 2002:a65:6081:: with SMTP id t1mr5380570pgu.9.1567028790706;
        Wed, 28 Aug 2019 14:46:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a17sm357605pfc.26.2019.08.28.14.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:46:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts on resume
Date:   Wed, 28 Aug 2019 14:46:20 -0700
Message-Id: <20190828214620.66003-2-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828214620.66003-1-mka@chromium.org>
References: <20190828214620.66003-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With commit 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs
when the card is suspended") SDIO interrupts are dropped if they
occur while the card is suspended. Dropping the interrupts can cause
problems after resume with cards that remain powered during suspend
and preserve their state. These cards may end up in an inconsistent
state since the event that triggered the interrupt is never processed
and remains pending. One example is the Bluetooth function of the
Marvell 8997, SDIO is broken on resume (for both Bluetooth and WiFi)
when processing of a pending HCI event is skipped.

For cards that remained powered during suspend check on resume if
SDIO interrupts are pending, and trigger interrupt processing if
needed.

Fixes: 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs when the card is suspended")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/mmc/core/sdio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8dd8fc32ecca..a6b4742a91c6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -975,6 +975,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 static int mmc_sdio_resume(struct mmc_host *host)
 {
 	int err = 0;
+	u8 pending = 0;
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
@@ -1009,6 +1010,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Allow SDIO IRQs to be processed again. */
 	mmc_card_clr_suspended(host->card);
 
+	if (!mmc_card_keep_power(host))
+		goto skip_pending_irqs;
+
+	if (!sdio_get_pending_irqs(host, &pending) &&
+	    pending != 0)
+		sdio_signal_irq(host);
+
+skip_pending_irqs:
 	if (host->sdio_irqs) {
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
-- 
2.23.0.187.g17f5b7556c-goog

