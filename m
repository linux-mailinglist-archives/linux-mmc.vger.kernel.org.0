Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658C4F6F1B
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Nov 2019 08:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKKHf2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 02:35:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfKKHf1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 02:35:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so10073748pfn.11
        for <linux-mmc@vger.kernel.org>; Sun, 10 Nov 2019 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=i6cJtP2GLYXrWSbffAAlWqbiBaFJmvg9QhFIx0JCR4w=;
        b=fDhq0K+/Rn0iuKKs10LO1snJBg6va0XLJdJa4Bz/h7Q5iuKxXTGigB77w3v0ezUGv7
         wN9k5uqyPodAtGkyVOPY1YOlstq2rqxsBmFs+7tsqE/tF95NyFrwW0NiWsFmcMGxuSN6
         7Xb7zSaRRZhZylx+27eHpbgWmeIuJJnbcxODRj7yqS8s6p6QeUUvcHiAsWaB9fQQviHo
         Hr4Xjv7NOWumj6n+AstBAJWIR3KJv8kWTHv8S9I8HlkSk1pAQnxR46/Cf6MoevHFfc+F
         3B1CnqUYgyBVz60ZWMH/yaITJlVlDcDZ0zSZYP4AMXYEp4bRi42ls1WEsp+JLbcS/OFP
         PgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=i6cJtP2GLYXrWSbffAAlWqbiBaFJmvg9QhFIx0JCR4w=;
        b=uGHa/RWuiZJYI1R1Nh79n3KYU48vIbk3j41X5Ogn7S5lA2PfHGdKSmrFaTzKugx0P8
         +b7YKiUxdQNKIJh32HbwqvfJqGj9xJjVpmRRJEtY5oHtvMdijzg1QNuppMDNIyDxabdF
         kYkpEuyNXEfS0XzpK79YUPvG1WNnerL8TOjZIzVoBC87EvINTC1gWm+xaSFIFvA3djlz
         RwHoszG4T7USpeI0O4GtXRf+sQQ07jVBWvdoogF9nOlNJ/KGPtN4eVmzuo+SdT9i5xBi
         eburvr4hQGlJO4qfSNMe8Dxo4wEP04GX1YzwquK4/yUVVA0M4A1DSYlOHKF506wTv0hL
         AelA==
X-Gm-Message-State: APjAAAVQ+2Wx+OwHyGUSdqhI/R7u73elpcyoTUHZe9jkretwBxiCRJL9
        N8dZ+2hMp7ccxx4ogdUIP2lAng==
X-Google-Smtp-Source: APXvYqxhkLmLWJIsYD/Z+DW+fx4kiGR/RMpy3gFQqLneqDDfgIkGQ1rke5EWhKSBQiwaHoVDNlzJGg==
X-Received: by 2002:a63:9a12:: with SMTP id o18mr26772073pge.379.1573457727181;
        Sun, 10 Nov 2019 23:35:27 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c184sm17345285pfc.159.2019.11.10.23.35.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 23:35:26 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] mmc: host: sdhci: Add a variable to defer to complete requests if needed
Date:   Mon, 11 Nov 2019 15:34:00 +0800
Message-Id: <119d3285ab610967b43f7c822dfdc0ebb8d521cb.1573456284.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When using the host software queue, it will trigger the next request in
irq handler without a context switch. But the sdhci_request() can not be
called in interrupt context when using host software queue for some host
drivers, due to the get_cd() ops can be sleepable.

But for some host drivers, such as Spreadtrum host driver, the card is
nonremovable, so the get_cd() ops is not sleepable, which means we can
complete the data request and trigger the next request in irq handler
to remove the context switch for the Spreadtrum host driver.

Thus we still need introduce a variable in struct sdhci_host to indicate
that we will always to defer to complete requests if the sdhci_request()
can not be called in interrupt context for some host drivers, when using
the host software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..4bef066 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 {
 	struct mmc_data *data = mrq->data;
 
-	return host->pending_reset ||
+	return host->pending_reset || host->always_defer_done ||
 	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
 		data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d89cdb9..a73ce89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -533,6 +533,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool always_defer_done;	/* Always defer to complete requests */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.7.9.5

