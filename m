Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78565B97A
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jul 2019 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfGAKxW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jul 2019 06:53:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfGAKxW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2019 06:53:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so15377342wmj.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jul 2019 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQRgtdqFvFQnOaqF03WKbmLwzJnjU6e4GX4WQg9aUEE=;
        b=XJ+3tS+jL/QjdpOVjmp9BRCWLIHz7jZljZJh7Fk4FhpGWcTVlTSkYNHz2DdPmF614d
         j3tuBbpzQ/YBEE5k2uAQtGq1s3l2zabF05npx29UbYwSEf9fzQYjgbBmIAcMdumAUmf0
         +1J93W9T/JNQK4pBCyL8QfR52JZYX9HYPGwzSYc4Xii3t71r/gcO5TtoJBnXZTSXXJXj
         1HJUVCFvmOTivPBU5JVmOr83+0ilNL7A63SWRRU9zM94C36jvCfiMxcwjLXa7WEvq7gc
         twjPXeIVOYOtqmGpLRBvni6eMsQR6Gz5rufMhPbhMpYqQ/1bnYtK4f0k6BhTikF4x21+
         AeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQRgtdqFvFQnOaqF03WKbmLwzJnjU6e4GX4WQg9aUEE=;
        b=du5SCac7W6E1YFwn2a2ZXO0dkkYp6booEqIYrUwzB+uFm+iw1Gd+7Hv4KTucBT07ht
         r7MOJpdDwrpLIl5Pn4noPaYbYEOEZoM7uQpTCT8J4Pb0RD6snrBwAafVD629YII5EAKR
         Hsh0j+LM6T4qxQEdDJ2UykUX8rQnQQNbcUaJO3RLQUrsdQFvq8yj/g5oFRVCpKiCQEbI
         skTFITPIXDn2Bz4erk0lhfV1VYZwDbWw4UV7s1kVIdTnEL63pt9tJc3uN07jk9nPvdew
         R7OTUg+7xVyQNjXn+c0vwxtipIlGevYBy7IARvCS8v/QKbTPqMilCJ92ETDHtpb0fDUn
         +HlA==
X-Gm-Message-State: APjAAAVKoUrdKbUxSE6QG9/eycJEec/x9JeRQYw50GM6ybRS/yMDWkxv
        FhaSvkKV5hw4uMlqiDI1aeYXlQ==
X-Google-Smtp-Source: APXvYqzJjbWlOiQousy1pzRxgrhvnrnX7mi2poCoEZm9lqei0E+ibL7N9E8kRbCeMA5zupykF95tsg==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr17433129wme.95.1561978400374;
        Mon, 01 Jul 2019 03:53:20 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id x11sm9353525wmi.26.2019.07.01.03.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:53:19 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, adrian.hunter@intel.com,
        agross@kernel.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        vinod.koul@linaro.org
Subject: [PATCH] mmc: sdhci-msm: fix mutex while in spinlock
Date:   Mon,  1 Jul 2019 12:53:16 +0200
Message-Id: <20190701105316.19419-1-jorge.ramirez-ortiz@linaro.org>
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

This regression was introduced with commit
     Date:   Mon Nov 21 12:07:16 2016 +0530
     mmc: sdhci-msm: Update DLL reset sequence

     SDCC core with minor version >= 0x42 introduced new 14lpp
     DLL. This has additional requirements in the reset sequence
     for DLL tuning. Make necessary changes as needed.

Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
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

