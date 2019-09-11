Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFEAFD84
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfIKNPS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 09:15:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42072 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfIKNPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 09:15:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so11500208pgb.9
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=oOzx4iKT8AsUYK46/eoTaeYiT1jKbTwBB3LS2rh+omq4KknlrU4boetTyKuqTe47Ng
         ZPC/cisMt6KXFjGBcEoB1CTYqWQgVbuIvRjjOAlr5bl67oH4qgVXAUdC5gr7KCji77jT
         FHX7s5pY2hRKvzUpmt517zPlFGsBxAJ6qSM3ctXCvqE8ACPgD815DrbbPV5v3DMVrizQ
         CVRuB0HlWCzGKCFXrs5ijPj5Lad2R1jJtcXW/RS1hvt6NfLprx02d8hSMwONiFF6N8pR
         nXUvjQzs6VqZZpFuhOiu9h42svKfP4fhMFInUfJp4TvjDqRvGr83IubmszUW4y7Rb2sl
         ns+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=THjs2/1AspBGh8aZOtlBPiMWJAbYlC3Wd09Ly9qBoOvW1CNipgec0p24ui/p7h/M/Y
         MjvAgUXVjVMMztGYmV217mnL13F9ohdex/EF5n5/7gvxRsawckZrDQh7mrtJhySg12kJ
         U/jXzsaFPQ+lAT4zsYKp0IqlWzuginkIX0DEv7yWbLffjTsDw8/7P7s3x1MccrXT9rU8
         YNh/CKFRDzXK6qaWUtyWUJKqgfc5TLN1X5QylEFXZ21KEoadg/9UlflUz0HbsF4HeTw5
         krPk1eYAHBZiU5No4ucpV1t+LQ96falTE0TgEvYTPPRBayghvpDxkRl2kQtPWB4DnUqq
         FTzQ==
X-Gm-Message-State: APjAAAUaif2yHk8Qtzhn8yl74TXhzhDa6ukgeDHroPsqJRRVIEhkmc8I
        8OK11a9qLVUtAtfbjBmd42csjA==
X-Google-Smtp-Source: APXvYqyz0f/JCciYHanh62R64szRSCDQjL2XiMkuzjgbIN/GVa48zSSdr2B/2dKutLtYsDeX8RodwQ==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr5496801pjq.18.1568207716409;
        Wed, 11 Sep 2019 06:15:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm6420120pgr.43.2019.09.11.06.15.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 06:15:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Wed, 11 Sep 2019 21:14:42 +0800
Message-Id: <b1407f39cd8c73bca9d4e0eff05d5f5e18a78d27.1568206300.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   12 ++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aa..b2c8695 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2710,7 +2710,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3133,7 +3136,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (!mrqs_done[i])
+			continue;
+
+		if (host->ops->request_done)
+			host->ops->request_done(host, mrqs_done[i]);
+		else
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 902f855..e9a476f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -643,6 +643,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

