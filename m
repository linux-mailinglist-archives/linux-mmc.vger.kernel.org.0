Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A021A4A57F
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfFRPfF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 11:35:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33389 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfFRPfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 11:35:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so42569ljg.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5yGWy1zg49aN6GRQcjrcvmt09k7bH4XaHWBtn+q+0o=;
        b=AWfQY563Cs6uiHCgDXOpnzfIB2jQtUS5c6tpfPq29tpIfFizbAppk6XyIVk2RMlaTd
         7+dC5QsO1m26GUKss71/vufkrvTa6mefUC9SVswE69DbA/qjMljtULHmdahqzG12tD/1
         gDjTojlfzA35GC0wJPOEF0fo4LyRhD5Ttdnadxgih0SlfJMLCboztBD/M7oDADoZ46HC
         azW0fOhpOhQVB4ow/QQzNqLmMwZEH7wSDnHVahmgI/AZMRYqz33g7YXzQlhWJe1851Fd
         fnntnOxtg0CfuKdvljr5cRxXgbrTHeMWI9l4VDnkqPeFKNfZgIlgbR3wWEtKXqlEdW/5
         b8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5yGWy1zg49aN6GRQcjrcvmt09k7bH4XaHWBtn+q+0o=;
        b=iwc6ZNRUboklsK7C4S++wINxKMx5RTCI5yu3kMqKYbpk/UoTogg/mj6tznvE2i+fmX
         5pi17vLZLss12nkKSSmuL2Q4nmFt9gUr1F/l8q3fqldanlfsT6k7XqK8GcGwF9FPBS4W
         v3WmtUzzrhjqB7OHXRE4sdXgy4UNRVDzpFQkbUBOVnRv09oas5viSwcgZnl+xqVKwuSu
         /oWX+HZewuFsDXiYa3VOf2T6tgh32BrSwKDUzADxOJ93B9OPjqGU5DiunkuDNniHVNsy
         ACVjtg21fB079xqzH/SozVi8SHxcGrPSopFZUZ9Kb/O0TcC4cBCQ6zqmPZ/aYIUancwQ
         bJdQ==
X-Gm-Message-State: APjAAAWU79HF5qjrNCOx1ZQCbQ9qYGx+zgClar2QPQPvB7dDk7JC+ZA/
        pACeEbWsp3otqZiyc6DOC9JfGilsJgA=
X-Google-Smtp-Source: APXvYqyWp6/pWGfLpGS9IcidD8xSifQetpMr76o4NJS07T91XQmhf98xQaZZrtNOcwj2DZQia2ZQng==
X-Received: by 2002:a2e:9198:: with SMTP id f24mr17460634ljg.221.1560872102934;
        Tue, 18 Jun 2019 08:35:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:35:02 -0700 (PDT)
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
Subject: [PATCH 3/7] mmc: sdio: Move comment about re-initialization to mmc_sdio_reinit_card()
Date:   Tue, 18 Jun 2019 17:34:44 +0200
Message-Id: <20190618153448.27145-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The comment in mmc_sdio_power_restore() belongs in mmc_sdio_reinit_card(),
which was created during a previous commit that re-factored some code. Fix
this by moving the comment into mmc_sdio_reinit_card().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b3303b7d9956..29f86c1e9923 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -820,6 +820,23 @@ static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
 {
 	int ret;
 
+	/*
+	 * Reset the card by performing the same steps that are taken by
+	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
+	 *
+	 * sdio_reset() is technically not needed. Having just powered up the
+	 * hardware, it should already be in reset state. However, some
+	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
+	 * meaning that a reset is required when restoring power soon after
+	 * powering off. It is harmless in other cases.
+	 *
+	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
+	 * is not necessary for non-removable cards. However, it is required
+	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
+	 * harmless in other situations.
+	 *
+	 */
+
 	sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_send_if_cond(host, host->card->ocr);
@@ -1013,23 +1030,6 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	/*
-	 * Reset the card by performing the same steps that are taken by
-	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
-	 *
-	 * sdio_reset() is technically not needed. Having just powered up the
-	 * hardware, it should already be in reset state. However, some
-	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
-	 * meaning that a reset is required when restoring power soon after
-	 * powering off. It is harmless in other cases.
-	 *
-	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
-	 * is not necessary for non-removable cards. However, it is required
-	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
-	 * harmless in other situations.
-	 *
-	 */
-
 	ret = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
-- 
2.17.1

