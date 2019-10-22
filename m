Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BECDFD6A
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfJVF7q (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 01:59:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46550 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfJVF7q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2019 01:59:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so9248384pgu.13
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q+dD7SDiYlVD6Sc0bdXrYVpCbKQT7CpksShngsf10n4=;
        b=jzHW8+vI149qZcAXl1BLh2d+7rAiaEf9Xsk0ubikjui60VmrzoYYeviqFT9nGhoNBV
         DFcjnknB1Yr6EiMvXFKQBPJwDG78HAl2Hs2UL76QRE0O5Fn0sKnJKO8mFXX0BTu7X2sA
         2EGMVMi3OKTTut6Z3KKELGJ/UhSIXu5aZeWzf6/maX+4mWezfiVUvJYxZDkkFzajFiyh
         QHjgK1XJNzHDw1xKeHJ8QjvCL5Qmn3382s8jl7uTEcKunf04VAfqM130s0y2Un/VVfxZ
         iQDT6ORcSeMA+m1LKNJM1yqy9zg+kKcBqAjr77lOT6B4Q8NbXBVjd2gOEaeWYcFUQ738
         WPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q+dD7SDiYlVD6Sc0bdXrYVpCbKQT7CpksShngsf10n4=;
        b=RQeCDTYfGz0hqK2rUsiDLav/F1KRXlSDV+zRhrdSbAtNtLvZg1okKHXEolDUbvRwZV
         VAhxCMntjZJuAMltsZTvn4rHt2JPxx26qyI4y4d0N4chgyGD1zu0csTIOUdukTwbi7kN
         EE/EMBrhYWJEsAKqdUyvn/Ki4sSbYR3xnQGAVgm8LLxnLAkPK5mAxHd7IhVf3gLEFTfQ
         pLFhVMSzTkKuzK626F3TsjYAjTCAuDd+bbfmz6FJMK0hF0Gu+5MIp/eJuKSzqf1jVUkD
         te5tWr2awfJmt8yfww5iYClnLqAeaXZsOwcVYBtzJg6tyPw3vnDmtqnnPYfYHEs8FxFb
         qTUw==
X-Gm-Message-State: APjAAAXvmlJoqHj4qsjg2EKxlFQ58E99TryaaNcd7ePMXh8jc3knZyjO
        6V5iqOyaBkmamMVGX+w3flCI2A==
X-Google-Smtp-Source: APXvYqxWqMoE7Zc5hBZAsKL+4NXEKEeXcoJ7Y9lVhAztGr2igC+ApnyhnAGtASxMu7pCbmtK4WZ8NQ==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr713579pfl.165.1571723985443;
        Mon, 21 Oct 2019 22:59:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g35sm16568061pgg.42.2019.10.21.22.59.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 22:59:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Tue, 22 Oct 2019 13:58:56 +0800
Message-Id: <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
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
index b056400..850241f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3157,7 +3160,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
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
index 0ed3e0e..d89cdb9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -644,6 +644,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

