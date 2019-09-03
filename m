Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84580A6B46
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfICOWs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36521 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfICOWr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so1939179lff.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUKvWKooE3Nr2LfWI7qknPBybhkMjg8O69FVSs9vXkc=;
        b=IyCgQPw2ykZcke64WeocrNRFfaD/9n4LX7jp4OolaJu1chstHr8JQY7az9MsM2LHfu
         8LnV9+FB2P45atdwxzfs9q/98aYbBbqFB5/0BxMEdS//a2gDnHY/GYf8z0Qp5EBNSK85
         IIJ7o+AfG0+am8hlLHi+fYcB7rdS3ni89UoSdaaIUQ7vTBikpGzly3mo3OcRApe7OwGQ
         twMGIlge9iU3ldpxwXFOFGJcklC/73gUGANUrHanqOveSb0DgprvK6HLjkK2NFnak9YP
         X3XrGDU2OW5ywt4hKN45BGBzSvIzXn5Pspth/FugIwTE4wJW1Otk2zU2/sS0ea0xxdFt
         askQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUKvWKooE3Nr2LfWI7qknPBybhkMjg8O69FVSs9vXkc=;
        b=oA64/SwlFAkJb7IfMQ+5rKfdYDKt76zfYxeTK9n14HFbifAXPsrSyAmWKfxka2RhWT
         i+LpPho/8gZCqYPl3VnM0pZbdklL5PhEtmmZohUKTzeaBctB/B8mSoe+LCOZadgzKFUY
         zMvHVALxJ1aadX+FaxFRyo/r5l1IGyGrfOTLdKpnL6Ns6/uI/CDAVPpMZ6qq4QDurSIx
         GhA0wPN3unKSx5e7rFzNqMxqLk586m4NnoDPuYQ/oeR1SSYTpdyfjKvcNZ3XSoWh9eqO
         QpWALl+RcgfpKJuDQTYHO0PskQxLYgmL8+ZyByPKlKJRhvlTyPRDTZYbWz/YYzQsb5+X
         iNHw==
X-Gm-Message-State: APjAAAXIdBaNxPJMl+vFzNsOoZoz7Cq9MIz+0yeAqJP98ZErYRu/zGTe
        09+E9nSGmgA/UMmBnJEQW4mU8eQD3WA=
X-Google-Smtp-Source: APXvYqxdOyp0rTA+keK8Vz0OkfEJsyNPg/rV68LgoYLikCASTYSTPK8ZKcshiuJ0b1rvVD46hW0z+g==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr4772155lff.103.1567520565203;
        Tue, 03 Sep 2019 07:22:45 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:44 -0700 (PDT)
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
Subject: [PATCH 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date:   Tue,  3 Sep 2019 16:22:05 +0200
Message-Id: <20190903142207.5825-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c1ebc26846db..2a9be044448a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2161,8 +2161,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1

