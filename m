Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07FAACBEF
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfIHKMz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:12:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42456 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfIHKMy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9872195lje.9
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IS0lVdK7iQppkNRcA/eyYIxzfqUhjc4kqGnbAO0Nu8w=;
        b=XFSAECu6eOchqjUmGfyiFNgZMWo+bvmAT0zhqDXFcxcLzZrltHNIhcmRSv6/JryE1v
         O7KAHIvW8AEktgkrl5abCIN6g137fTZuN4+UmVwn4Dj2e2sNi9d2vV/hsiwPd60aQTFH
         XvqkGnJe7W7dOLIGZdBWH4Hh8IqcxzSxuI6G+wN6mcnHoOlW2p6DxoTimAa2YJiDD9gc
         j3GVp5WR9XwBthfZyvCewUxTDky7uxpl5uaHcw0fRYk5TMEe4Mdm00mLfgPWbaVLnGc9
         kLxXihevliSWwN6eOghy0521aMhpFk72hI395y5Jn7kPWbXKLcP4MaCBH2xufp3mlztK
         VoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IS0lVdK7iQppkNRcA/eyYIxzfqUhjc4kqGnbAO0Nu8w=;
        b=g3BJ8PT5m/uE4mwStYV9SlvzebYSw6ilqtr3IIk+RbSAH2dzo4PFr0UMqEi/l2iqNH
         6CcEmc3dHKNnQQi7WcqxcTHtlUT6Cn9okiHGiclE0c1uNJtVYWN3YsSnahvCqaJfVzkw
         0VZVH5JcnMk0UwJiXaLhXM5MaZKl7Ri7KGUQ1XzULzdEFYh5mdHvNH8DOEuCubNzgmkX
         kg7z1Rb8rDg8HZS+wLBnl6V93Sj0el8Eu12990GXGszN5ijcFs7XFgrTbiY+FvK94Tig
         71cSOMpqy59HYyrR7HGzOyqppZQiRyg+VAvu7kKz1spM7u3TiiTSqgltMoWnR1nRAL3O
         ++xw==
X-Gm-Message-State: APjAAAV4vn7genpHRhY6jV4Q7NOFRescT2t1rDKDHQmwH0kBV0Oyv+uz
        tdXXsPWUo1w6CJWDdhyMaajPts/ygAi6Xw==
X-Google-Smtp-Source: APXvYqzGa5ufeqoMMCyIUrEeU7LqbusZnxDO1ItjP4toDSXg19lvkKmBEh9+NqDHY2u1hfysc1HBJg==
X-Received: by 2002:a2e:b1c4:: with SMTP id e4mr12099214lja.101.1567937572577;
        Sun, 08 Sep 2019 03:12:52 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:52 -0700 (PDT)
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
Subject: [PATCH v2 08/11] mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
Date:   Sun,  8 Sep 2019 12:12:33 +0200
Message-Id: <20190908101236.2802-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
behaviour. Some problems have been taken care of so far, but more issues
remains.

For example, calling the ->ack_sdio_irq() callback to let host drivers
re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
which may not be the case during system suspend/resume. This may lead to
that a host driver re-signals the same SDIO IRQ over and over again,
causing a storm of IRQs and gives a ping-pong effect towards the
sdio_irq_work().

Moreover, calling the ->enable_sdio_irq() callback at system resume to
re-enable already enabled SDIO IRQs for the host, causes the runtime PM
count for some host drivers to become in-balanced. This then leads to the
host to remain runtime resumed, no matter if it's needed or not.

To fix these problems, let's check if process_sdio_pending_irqs() actually
consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
->ack_sdio_irq() callback.

Additionally, there should be no need to re-enable SDIO IRQs as the host
driver already knows if they were enabled at system suspend, thus also
whether it needs to re-enable them at system resume. For this reason, drop
the call to ->enable_sdio_irq() during system resume.

In regards to these changes there is yet another issue, which is when there
is an SDIO IRQ being signaled by the host driver, but after the SDIO card
has been system suspended. Currently these IRQs are just thrown away, while
we should at least make sure to try to consume them when the SDIO card has
been system resumed. Fix this by queueing a sdio_irq_work() after we system
resumed the SDIO card.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Queue a sdio_irq_work() rather using sdio_signal_irq().

---
 drivers/mmc/core/sdio.c     | 2 +-
 drivers/mmc/core/sdio_irq.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c557f1519b77..26cabd53ddc5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			host->ops->enable_sdio_irq(host, 1);
+			queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
 	}
 
 out:
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index d7965b53a6d2..900871073bd7 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,7 +115,8 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		host->ops->ack_sdio_irq(host);
+		if (!host->sdio_irq_pending)
+			host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
-- 
2.17.1

