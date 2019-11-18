Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9F1002BB
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Nov 2019 11:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfKRKnx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 18 Nov 2019 05:43:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43008 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKRKnv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2019 05:43:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so9435298pgh.10;
        Mon, 18 Nov 2019 02:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8h6y9nD1dzZk0UihTZ6wfJ2fK7y1DSqr/4indhHzA8w=;
        b=BMOvCekSdtAePq+8AqRCgWbrRhwXqHgX3wGpIcn7fAo1URMc79egXw0Id0y1X5K6h8
         FPyoK16p58JiHivTyCHoWLTJ6NhOb9gQFYrhn1ckoxUmpiWzHmnK5u1TlS+zl0FpoXGu
         hEc2aFafDYyleR5HGsCfwQ1vwJp1DZuYGkK5QS66q9gzPpnKRDin+cQmTuih/in5jndV
         kiaHx3FncMQT13qnumqk0+VLV1vH1rJ0GNpiVz7Ju1oGtB1puNtjHcc5ytzMqIgoTGFs
         WGL1sUZ5ZozgTHRx3u/TyX/oFFyEVzob0U3q3Qy0Wx/A48M2jvuinSmH/ZAN1FZvRaNQ
         10Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8h6y9nD1dzZk0UihTZ6wfJ2fK7y1DSqr/4indhHzA8w=;
        b=aS1Y7k01Lol6/MWpSkD4dVLda5XEOh51L4Xf6FobTFIt6/qP2+pdY6nREw5H36bIeN
         ZznqNfYiukRTRoM8vUPjCvd+vFrKyNLUotqezyEYIr/yI6sRWJOWd2sjfkbEWPdC52xQ
         s04OhXmaz8LRoWpDnZDxPf2A7aY862PVn1Aww5+ouJXkcL9P4662Lia7UcqyJdWpFt4q
         fE97Go2naxCSi6xC6VsRh1qBZ5eOzwlaEt2iHhPGHfyf/xTjtpNFZhzORBIMk3RUU00T
         pm9MJ0BSd/454bmcXGGfgtXL6AKLtQdPGp49aNwhdVygdDutpXKrzuXLyriyQ3pigpdi
         Jdzw==
X-Gm-Message-State: APjAAAWIYZ+gsZXr70NA5DyrLYyz4mADV+uwqrFJjAlop9i8wQzRQPEs
        +XgLgOuZsuYZIuj82HuB9gM=
X-Google-Smtp-Source: APXvYqzz4uP8TT97I7KEpeMul5GnZGCPKncj5MX9tG2VK44MQeCgMzHEX5058TxdcC6NR25Q3bG1jg==
X-Received: by 2002:a65:628f:: with SMTP id f15mr31181395pgv.91.1574073830784;
        Mon, 18 Nov 2019 02:43:50 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c13sm19343905pfo.5.2019.11.18.02.43.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 02:43:50 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] mmc: host: sdhci: Add a variable to defer to complete requests if needed
Date:   Mon, 18 Nov 2019 18:43:21 +0800
Message-Id: <0199b93bad45b7f1dc7751844ac8031b316b2fed.1574073572.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

When using the host software queue, it will trigger the next request in
irq handler without a context switch. But the sdhci_request() can not be
called in interrupt context when using host software queue for some host
drivers, due to the get_cd() ops can be sleepable.

But for some host drivers, such as Spreadtrum host driver, the card is
nonremovable, so the get_cd() ops is not sleepable, which means we can
complete the data request and trigger the next request in irq handler
to remove the context switch for the Spreadtrum host driver.

As suggested by Adrian, we should introduce a request_atomic() API to
indicate that a request can be called in interrupt context to remove
the context switch when using mmc host software queue. But this should
be done in another thread to convert the users of mmc host software queue.
Thus we can introduce a variable in struct sdhci_host to indicate that
we will always to defer to complete requests when using the host software
queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
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

