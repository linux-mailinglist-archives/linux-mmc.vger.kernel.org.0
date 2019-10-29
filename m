Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5EE7FD9
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Oct 2019 06:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfJ2Foa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Oct 2019 01:44:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41261 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfJ2Fo3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2019 01:44:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id p26so4589916pfq.8
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2019 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=83cwCYPV9/yZeBbO6OKSaXzRco+5H2vE0myUuYv1K0w=;
        b=i8xCDqqFLqESmBlE8SMdB2SxgTpUiuigZdOv0dF6UhQTdT6DMVdtGscyfJylUALb7W
         7Zglap20Z8e2SmfrgB1wZd9azPS9aS8aBUBMQgynNmALQJXJt9W5INUkJqb9e4eSTV6p
         6fvxAv+stC2iqsbGAkPd/UF0U5dLDEvZg8Z6SQpSmjv4cdE08Lu1wm+9XYhImDV05vRC
         8dTOovwOTr11L8O+L05/HFmwtCnH8qactHO4IAAZO+qqTmXg0vMqFoldW1WA5uwmwbDG
         yKNDBvCPKO+GcALdGc/IOmyoB1yDDWuB7jPWsJAv7vTM6y7RTMiDlWHFe9uu7imtI5Yw
         P4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=83cwCYPV9/yZeBbO6OKSaXzRco+5H2vE0myUuYv1K0w=;
        b=BOKSFf50xBX9QkLJeTXUeg35ZKgGZRfK09ud7ZEK1MCz9L1tTLH5ObBMMU2+p60Ysu
         0rTKVd6eLicKMq6/OSo83NB6LvKx2YUtvEUZgGPDaDT3ZN6On/P+tZqUXzShVLMxd+xk
         ja3UuwVQ52ABoP0Zzi6UcsDjknugJ4b0xwnbrVIKee3gXFNeFKzFXgZ2/9l8AB6j2EsL
         trs/FqvqML1vdotFgQ1WR5c88/57sWwbKNHXKeAjBdrnDxX9eca2Ye6dkCH9qOdlBvv2
         P3/rTFyjRtJPkU7T4u3xLd725FhKRVO6Zpdaugzc5kwj6NQK9NtOsLLsLuFL+y96ZMsc
         ERNw==
X-Gm-Message-State: APjAAAXm5OcpzEhohzMm1kIJlSz16GcbF+JlYXcubKnaYOtoy7pbP4tN
        VIviRkWydJtTCNrq3dtltvD/ZQ==
X-Google-Smtp-Source: APXvYqzlVTtjMkZYH884apun00NdfUZQrmTCJsGS4o8nNnHmnNLJAZrYIxHbcnoD93W1IKCzNLqzCA==
X-Received: by 2002:a63:1a46:: with SMTP id a6mr24146910pgm.3.1572327868852;
        Mon, 28 Oct 2019 22:44:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm12026231pfi.113.2019.10.28.22.44.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 22:44:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to complete data requests if needed
Date:   Tue, 29 Oct 2019 13:43:22 +0800
Message-Id: <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
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
that we will always to defer to complete data requests if the sdhci_request()
can not be called in interrupt context for some host drivers, when using
the host software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..9cf2130 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 {
 	struct mmc_data *data = mrq->data;
 
-	return host->pending_reset ||
+	return host->pending_reset || (host->always_defer_done && data) ||
 	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
 		data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d89cdb9..38fbd18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -533,6 +533,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool always_defer_done;	/* Always defer to complete data requests */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.7.9.5

