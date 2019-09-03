Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB0DA6B3C
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfICOWr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40962 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfICOWp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id j4so13036961lfh.8
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNF5KDT4NEO2S6l4e9LzOtvZky1MgilMfLbdgvOUK14=;
        b=BgIkoA6S9HEs9gXOS1K2J8v1hct1nLo6iRbl+eWQRpwvWRAnL1gvf+6nlbSL6YQA3L
         YP0IzSVlJneAEtl8OLa9/CxAxpo1o1UsJgnOMYY2+Zi4BENlVOUxJ1C4U9RQXv43lRDA
         Mz84ak/0jeQjZANy0DnEaYTuPY760zFCzRlpLRpdw40SCH9Llqye34JP95vSzumbnnZS
         Zl2imszSl55QYmDXEmgLQ9Dg/rJzzHYX38Ck6g9OKS68zEeA4dAh3UGChi8gTj+nVrn9
         2zFV28zKr4MoIj3TQjSFs0sV4I1qy2pFogTq2GA7SqZOvrq66YCj9MZziPPTklnjOHlO
         Lb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNF5KDT4NEO2S6l4e9LzOtvZky1MgilMfLbdgvOUK14=;
        b=Mwv1a2NBHwu44G/ZW4XnKnweAWzNkhP1iWZNRStWZA9gJ6r5T64rN9CH7aiBkYBlZf
         UAmdmkbEbVF/xK2H7WxpL4BAB/Hj8zIdSbq5kRkN/olPJy8i32eRX8x11dM+/AWzQ9Q1
         BAzp+bTrcK3epQyhzGVSkEJZ+L3xhp2r+4a6TXgcZNhGwmYJOYjWXwys7u4sZsOS6K69
         ekbFQTqSAkYq3w6lPb1usLZ1KDz3DCGST2z68Uhl5HzofpDZeD77bPA1k0U8ULIF2IpX
         Z+stxGq5PqzYzdVj5W2pynS0udIUDNId/oz1usAnGeZDL2jPjdWjve59dyUG+uXlLF1R
         WELA==
X-Gm-Message-State: APjAAAUAUP1hhX8+//oTPYeFJc9ED+8E7yjCDH6I7a5BfkXTFBCTmgla
        z6a4HfvybycrCfh26/WhmFgNIvZ8XGQ=
X-Google-Smtp-Source: APXvYqyEEebdpTgfyZ3xa8X0pagg//6S5aVso4T3Lot6sSeBRjWR2Wwn14JGYYaV9PjJ35e0VWgv9Q==
X-Received: by 2002:ac2:4c2f:: with SMTP id u15mr20191218lfq.174.1567520562816;
        Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mmc: core: WARN if SDIO IRQs are enabled for non-powered card in suspend
Date:   Tue,  3 Sep 2019 16:22:03 +0200
Message-Id: <20190903142207.5825-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make sure SDIO func drivers behaves correctly during system
suspend/resume, let add a WARN_ON in case the condition is a non-powered
SDIO card and there are some SDIO IRQs still being claimed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8dd8fc32ecca..c557f1519b77 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
+
 	/* Prevent processing of SDIO IRQs in suspended state. */
 	mmc_card_set_suspended(host->card);
 	cancel_delayed_work_sync(&host->sdio_irq_work);
-- 
2.17.1

