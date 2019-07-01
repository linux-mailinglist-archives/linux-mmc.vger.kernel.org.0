Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977A55BEF0
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jul 2019 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGAPBc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jul 2019 11:01:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40330 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAPBc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2019 11:01:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so16302708wmj.5
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jul 2019 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIXpnZYD0H/d3NqVWEXP706dKN7k+XEZCaQ0ZxH8464=;
        b=ShgvQlkjJOhVGKdERs2kjRZrm8SgyU9V8shTDKruNYEn5BrO6mtB1ONdNYXLWT1wXk
         q88Lqm4My/pOTwGUx9EO7KHalnVaIRuUsC2dItCptPW7CUZfdZGxh/bybgki+EyygNh7
         LHMIGHYXI4/ZSYd/FpnPsHXMuH1Gak5/8h1qLjKXUWD7yAYxOLxU/Z+ly5Y/AEPmHLuY
         YDFuTKwd3sgviBatQLLlCYdS6JVQJ5D4J6x1l485gzeqhu0k2/0xO0kZfREJtxFEqNpR
         vTU4wBCXh9jeTTz76Yp2yjskWYKQHOu0a8hywEef5jRtkcGZx/juHQ/77ZbnlWI45p1y
         Hv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIXpnZYD0H/d3NqVWEXP706dKN7k+XEZCaQ0ZxH8464=;
        b=uEqoISzhc9auYG0qflibA6ZO+TZ9aawKc+e/Mh06j4R+QOce0jrUqPmLsgGPl+zLR9
         4GFfcHAAx2NRPj7418JgKlktcglM1iE/3EB48qh7MHhFdr+iFgrLqRpJCrnomzy8nImz
         rERqJ1EbB10lCE9sGXb3zNEceo6LGKJugA/z6jK5APB2f6kBQU2oUMMrCBhE1gEJSRUA
         R3BAnXJSUp5aGMTP+r81GsOyvTbKSIVPQRV4R71uVdOorfROWjBf2w9sxY/p7v8eOE+m
         pXPjKsrluDtMRIlwQjkjiXQCoCIzd6lLgAXNsi59oIGpuoFKWfW56qH3lUBKh4TgETBZ
         yBxw==
X-Gm-Message-State: APjAAAUIltPRYqrDgsATZi/7rL8XACf7vg7VQ3UunEBgron8TjP1Wh2T
        58gY+njVRWbB2bsSNCuaSTmqdA==
X-Google-Smtp-Source: APXvYqzRyoFA+U3EOfx7h9B+QCUQi8PP7JKNZhiA5pvk5g5tW/eupIOCHWrVuLk8dBgKkCQQaanNwA==
X-Received: by 2002:a1c:9dc4:: with SMTP id g187mr16003141wme.86.1561993289850;
        Mon, 01 Jul 2019 08:01:29 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id r12sm11638593wrt.95.2019.07.01.08.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 08:01:29 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        khasim.mohammed@linaro.org, vinod.koul@linaro.org
Subject: [PATCH v2] mmc: sdhci-msm: fix mutex while in spinlock
Date:   Mon,  1 Jul 2019 17:01:25 +0200
Message-Id: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mutexes can sleep and therefore should not be taken while holding a
spinlock. move clk_get_rate (can sleep) outside the spinlock protected
region.

Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5fc76a1993d0..9cf14b359c14 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int wait_cnt = 50;
-	unsigned long flags;
+	unsigned long flags, xo_clk = 0;
 	u32 config;
 	const struct sdhci_msm_offset *msm_offset =
 					msm_host->offset;
 
+	if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
+		xo_clk = clk_get_rate(msm_host->xo_clk);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	/*
@@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 		config &= CORE_FLL_CYCLE_CNT;
 		if (config)
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
-					clk_get_rate(msm_host->xo_clk));
+					xo_clk);
 		else
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
-					clk_get_rate(msm_host->xo_clk));
+					xo_clk);
 
 		config = readl_relaxed(host->ioaddr +
 				msm_offset->core_dll_config_2);
-- 
2.21.0

