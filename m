Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C60F5E72
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Nov 2019 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKIKbB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 9 Nov 2019 05:31:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40567 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfKIKbB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Nov 2019 05:31:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so8808097ljg.7
        for <linux-mmc@vger.kernel.org>; Sat, 09 Nov 2019 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Irawu8SRoNtzmKfb3mCNZp3oXWFM6rn9ptozR56UkwA=;
        b=ZFczlxVJpHEkN6j+5EYvSNhGZMycMzimX6bbksHznbxmkE6ALM4OpnnZdIJ3gJlBYM
         1rqArbEMRDznWCxXDoHRuoV5ui7IfChnVNy3fiuWgy4Wj6YYEZknpqJ9wqcZXcLRBDQp
         jWGaYpbwcgu7AQvC0Yv3OtvZ2/gCFvWRNdxqBLLFgpmzPGaGXGN6rJssKwAXyx27xLAw
         7ysXH8byqmGHuIVhBJ8Altmvvbk5FMHSJw7OHwHsKUIRo9HyatT7nsYAHcFYGSPYc5Zp
         8lwMBrZHWPuHJq+krl63Bmgouor7LRcz+W5cGNfsGCZzJZL8/BNIW7HUW/IygBeXjgxH
         ngow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Irawu8SRoNtzmKfb3mCNZp3oXWFM6rn9ptozR56UkwA=;
        b=OBlq2oTc3m/nIBlx9fO/DQLN1omckuuRIEe8nAmUV/u3fk3P1NShp3WusnFSAEO9rS
         N3Yi7oMOInAU4IwohaJXOZa+lz0RZkx+vHkQU7kuIBnWNNi27nEJkRqcattFFWQc3r16
         50ox6oqFCIFctQLfwQimWWeLaD1A+mBlliBNFQz/ckS06dtr79t9+1dI9GbCAnHIByu6
         HlKy2wpI4BJcqjZWnE0p5HoRLv42W0Yt1D/XrWJb16lZgKw/k1aE/FUUCKaYP89Juop2
         I9xk0qosKf7uJVM+Y1QkfPRHEYtb9ERJFJBnnZs2OlWlVttaIV7Q2xmx1L7gJqlUOTNb
         yrvw==
X-Gm-Message-State: APjAAAXi2zgtBAdNqblIPDHwuYo5CMKGLs5ArHlDa5N5ytuZn6CxFueS
        7TxtoN6XgprklsPmByL3zmJ5C4yooso=
X-Google-Smtp-Source: APXvYqxIoztXOQ6EZI33BdfF0jjZWB8NBuswW97qLqIH/zyK5sFRmGHkxaqCaf1Q9H5zKjEZOviDaw==
X-Received: by 2002:a2e:2a05:: with SMTP id q5mr9924181ljq.170.1573295458900;
        Sat, 09 Nov 2019 02:30:58 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z3sm343927lji.36.2019.11.09.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 02:30:58 -0800 (PST)
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
Subject: [PATCH v2 2/3] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date:   Sat,  9 Nov 2019 11:30:45 +0100
Message-Id: <20191109103046.26445-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109103046.26445-1-ulf.hansson@linaro.org>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
scanning only once for non-removable cards. Therefore, it's also not
possible that we can have a corresponding card bus attached (host->bus_ops
is NULL), when we are scanning non-removable cards.

For this reason, let' drop the check for mmc_card_is_removable() as it's
redundant.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..6f8342702c73 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/*
-	 * if there is a _removable_ card registered, check whether it is
-	 * still present
-	 */
-	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
+	/* Verify a registered card to be functional, else remove it. */
+	if (host->bus_ops && !host->bus_dead)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
-- 
2.17.1

