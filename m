Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE0B72F2
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 07:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfISF7O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 01:59:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37342 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISF7O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 01:59:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so1240301pgg.4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Sep 2019 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=zhv8Kx6vvUW/d7G+xYSAYrOmmvnaIbwd5gC9xnntdZLFNYJheYP9yad0XegrdSLaYV
         FtKxwxRKzxKYC4cFofV9qglatWamCIw3rEpnNjS0uryaWYo45+5Rw+d5lJxVCkVLJ5Wc
         2wXinXW/OoaLp01TuCXoSq2LscxafvxxPk2bS9f0KBg7u1JsG8aMPP10DhprooMDraD/
         4YzvzVdEFJ+kNxQWJxHZ+k1MGbvj7v5FQlxHVrroq49RsqSNgQYEtpOi0P13IKDJUzd7
         4Etzw54ergkoDmwiYVi9WpizuooEBTikcZPYopkAMZEHYgzlieRUZaJRucZFYHLFU2YB
         LaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=mRFef+gMKmbPQuI0nFlr1hHCZnp3PFwkGBaTSGhi8rzH8uH08J9PLHnlYNo2GV+BMc
         9FN+0T7VGpYglf3/Z/rOXQn9Wcf9Ha1qLzLkjFUC6DURJrpUMaeTXSE9G6dHfvjf0idk
         1hZT70rkpurHzVXyhYPL5klJzGWKR0jMS774rcZPVsEpvcf355LNdx2sX+Qc815aaOJD
         7h0urGE7lgFX50EDkRlG0MqhwVNRSO9qQVbPFUwNW3EipO4H0JhNr80me2guysX5goF/
         mzn+Z8Xb8mUKVwOCoJo04ACd3IFDHnuzjrhFOdUY6Up04gknf81NNu56rOF3nx4mpg8i
         nMKw==
X-Gm-Message-State: APjAAAW9ZpSHAf86/V50uEyN2s9LW5DdwjGTiWw7f9SU3kLNcIMvSqz6
        6xMCzMoms7hcuvbWWUghtQol+A==
X-Google-Smtp-Source: APXvYqxdLkUiH/diHMsr4vp4ZRs5ubOYFJhyRIGXzQnn3NjsJUKcnzmVMxnsRlXvrREIPR/ZYLBTog==
X-Received: by 2002:a17:90a:1b46:: with SMTP id q64mr1858748pjq.76.1568872753745;
        Wed, 18 Sep 2019 22:59:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c127sm9666027pfb.5.2019.09.18.22.59.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 22:59:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Thu, 19 Sep 2019 13:58:46 +0800
Message-Id: <ae58746cc2a8cd1810662b189c11a237539ba2a8.1568864713.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
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

