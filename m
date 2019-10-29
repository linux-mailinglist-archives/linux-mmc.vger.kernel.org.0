Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354E5E7FD5
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Oct 2019 06:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfJ2FoV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Oct 2019 01:44:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732103AbfJ2FoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2019 01:44:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so8735608pfp.5
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2019 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ILB8a88XETD+WUMe0JJMqsMts/FAHmPFp1FBBYuuKZE=;
        b=gmuv+cyr7iHWELt6YHpGGTGNrHr/dSHU9vseTrEDPPehaRYVKqTt12YSkaQPzUpXq8
         44+HvgIGJjd1BkTc0S/DKdleOZJ54mGsJK2dM1a1Fk5K0jfNOWLHQzNKe4iJnuVsr555
         bnvFspkeCwM92tzJVGBV/M66crEo5mN+6MJ96Q4VhbofCEfXXYbz/bgzbMoo0bMWPGSP
         UO/KHyK5aadFe1VjRIfLnekNaW9j3tq5JClHAWTCVMZbBmSQM3Dkp7XaNeRmu3fEcSNC
         taTNxGVCKrpg6PEvzUrGkoX6Nf2sHFTsQriiGQKngj4wI8ZBSyTwFO7/Sctgf2jCvkhM
         roZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ILB8a88XETD+WUMe0JJMqsMts/FAHmPFp1FBBYuuKZE=;
        b=Za7CdpMdyAxb1jDj30qmcVtNm7Cyp25+tBtiVuomKzfx8T71L85n/28Du0fTjCDfq+
         0DafNFVpN+bgWdcyhqJYiCWY6DvNW1ciKtj8f5p4mpOAivfheTpFfwDmeoDFWGAkMMfw
         pkAE1LSXNLLi246MY44s4WbgZQXuNZalKW6LtrwzRIJ4hqyBAzrsQ484LUko7Zxswi8I
         p8ZhFYsRU8wYY4wDFuux8asqH4Y2LVM7EGJWB3uT8U7ZGq0Qe9DmureMhsdse0tbSnkb
         q4nJSHm1CC0G6sS1QfW1hnmK2FTELIttLrbfqXmNE0nLkiSwRc3HD85yAQmvOMfU69AD
         7ldA==
X-Gm-Message-State: APjAAAUCOWtoyaxj1ORyNZtjiJ+2x8YXiQpf0rhvaWauXtjbbwldvO7G
        pIsboNjNTlB5hsymBkySVqPYvQ==
X-Google-Smtp-Source: APXvYqyPPHm5XF9bxrf61bI+js4+CByrcSZPpfqGx35wLWdoZg8RFBMyPlxEtMBNKJGkwprrNo+6Ug==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr4000686pjp.74.1572327860555;
        Mon, 28 Oct 2019 22:44:20 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm12026231pfi.113.2019.10.28.22.44.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 22:44:19 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Tue, 29 Oct 2019 13:43:20 +0800
Message-Id: <94603120e6431f0ce35af78935bfe7dddda4850b.1572326519.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
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

