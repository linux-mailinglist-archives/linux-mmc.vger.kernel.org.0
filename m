Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23605ACBFB
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfIHKMq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:12:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36754 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfIHKMp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id l20so9898497ljj.3
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njwNwAwc6r0dkq3naz0El9lnBpKIVIeF99HX8Xzv4dE=;
        b=WY/PSxE68qVV9583kfNBuDbYuUpdPB+qveDxNuOd0xhevC45Z2dpWbWg3WoA4MjpAG
         Mc9TplI8Vz7PzhC8BF/Masppqn+si9//Kow3TlGfcY3MXI/nmOJMNP8gA3KmIZoqOyEv
         WRWSc7+aH7p5jqfiO7PUYleEHDNP5OlQo2NV4lTY5JOJ1SAb9YdoAKs7JHsuNWC+G6yl
         3wu8eSlKNQCSxPPgGe9++aKJ0jjfBSO64Tua3fD7kXXfo/dGaAaKpCefSg2Sugel94e4
         An5JKrcuaZG80RHNmKuTLeH/Dbhc/c845T38mjOOJc9x5QuWwooeWNoF19P63Iw7IzGV
         8dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njwNwAwc6r0dkq3naz0El9lnBpKIVIeF99HX8Xzv4dE=;
        b=jR45zxKMatXPIWD/oEoRYQJztuvN0+vtApD7xZ9eApFTwj+UiKHNdK/7As1+jSFnHZ
         CZpF3lrKVy9moUrSWpUSVU+Z0L3LwxuGP1SaCCvtkMS2Hpa4G7eeuDRkhQQmXo9vGBnE
         ccmt/pJH+9BEHsbwi9qAx77iWSMk+awNVTmAAZ1mcFFmRmsVH5gwcOtrMU3mVbgdSzlr
         Ga1SWISFoz5R1sk3s5aXZGeYI/KaftBfc0djmNC61P0yu0rlWNkcH40To3dYWuYZDfxI
         l22u6a0qqnOhdyRDMw0Z9hBrRh2ONtHGDVfzkNMHIIKh/enMcoQSXWS0t+53MJe/cVa9
         oUwA==
X-Gm-Message-State: APjAAAVCnVfM6hZdLLtZgy92IJSeeSafPwTQvFN1WVOH2rXXTNE5mtoJ
        PwMoYiZuWBLUi/SXjM/Tm1Exk2i0iKjCKA==
X-Google-Smtp-Source: APXvYqw5LzDY8B2YTdCvLHuC2pxw+qjmoU1Z7hBcb+FHPXc+nj5c8+wJj+AdAqhGC00CKThlLHZ02Q==
X-Received: by 2002:a2e:1415:: with SMTP id u21mr12369659ljd.22.1567937563298;
        Sun, 08 Sep 2019 03:12:43 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:42 -0700 (PDT)
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
Subject: [PATCH v2 01/11] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Sun,  8 Sep 2019 12:12:26 +0200
Message-Id: <20190908101236.2802-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To avoid each host driver supporting SDIO IRQs, from keeping track
internally about if SDIO IRQs has been claimed, let's introduce a common
helper function, sdio_irq_claimed().

The function returns true if SDIO IRQs are claimed, via using the
information about the number of claimed irqs. This is safe, even without
any locks, as long as the helper function is called only from
runtime/system suspend callbacks of the host driver.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Renamed function to sdio_irq_claimed().

---
 include/linux/mmc/host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..a9d52a4d5041 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
 
+/*
+ * May be called from host driver's system/runtime suspend/resume callbacks,
+ * to know if SDIO IRQs has been claimed.
+*/
+static inline bool sdio_irq_claimed(struct mmc_host *host)
+{
+	return host->sdio_irqs > 0;
+}
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
2.17.1

