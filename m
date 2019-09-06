Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE321AB16A
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 05:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbfIFDw7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 23:52:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42827 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404469AbfIFDw6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 23:52:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so2671128pgb.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+Qa6FN4bybUWpL4Kw6U5VKtqicdkV7LDgiUgYM+LUYg=;
        b=uxSBN916hJwbA+vDDyLagwrLfwSaXLXvaXvT7/GTQRAnzOsCH+WDXs7QncMqgzLmyF
         y27gY2CoyiyQUPwpQGgqGY7xxPWrlVRjXUHMiTVZIVaFCFgroupu/GPS5I9tho3uYkVu
         YZnGJ1zDf3f2JB4R8y5x3qpb5Ych0HA5/0wGnDtMqlHI2Zi/It8lL+pKtNubEnu5BMId
         NDZh9X9bJctDYxCIRQIFR9QDuLO+3outSSYq4rk0LROg2ALEJ/zbABXB6DRIxE2S07tx
         Z2Bntybcl/W7gKM4knG+5bCVyOZ8yt4pODOwEfBvb9y0MB+8LqFcucZ3iK1w+Vzhknt7
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+Qa6FN4bybUWpL4Kw6U5VKtqicdkV7LDgiUgYM+LUYg=;
        b=VnHX8VtSLMh5rgyrRTpymnT7rwjt7NpnrlVB29w7jgq/mFAYDABOvebPZ/bsoMP9uU
         oEsEKxk9+FvFqZbRxL7BVS+qo0eDVZwRRj91lns4hPGa86mJKsL/Wv6U7NvTj3VW14H3
         seMyNx7Lk+AryyfQq9cwVPjQsO6pzSwhL98pf5ULzOUON4xwyAzeDxqB7egPYst+MKcg
         u/EURqRe0r60b9Z0makcXBbEqD+7JJcyLc8tMe36WXVJVdOeytQzTU7j6Hqg8Db5Y2gq
         Y/6Nbagh+LMvkfZrzGeA/q+qh7acHyMXkUKr7JhO+qpCtKap0/3WY+XeTF1rTl/DTv18
         3QUQ==
X-Gm-Message-State: APjAAAWthpS7qKu+4rJJ2vdHBYYBMpFzmEEkK8+rRuySJpXoag3D6U8J
        EDmoun/y33K2ipe5hGNk4CB+1w==
X-Google-Smtp-Source: APXvYqyp3IrbhUseZOadAuJ9eNKifK2EkmY8dSVlptCa+kQ7p2PqkkuEr7vYQE2iIP+uLJv8tOCWUA==
X-Received: by 2002:a63:4522:: with SMTP id s34mr6154076pga.362.1567741977816;
        Thu, 05 Sep 2019 20:52:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
Date:   Fri,  6 Sep 2019 11:52:02 +0800
Message-Id: <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add cqhci_virt_finalize_request() to help to complete a request
from virtual command queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4e9ebc8..fb5983e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "cqhci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (!cqhci_virt_finalize_request(host->mmc, mrq))
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (mrqs_done[i] &&
+		    !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
-- 
1.7.9.5

