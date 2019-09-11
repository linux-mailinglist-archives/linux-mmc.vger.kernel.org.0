Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9AAFC3C
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfIKMJa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 08:09:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfIKMJa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 08:09:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so24235311wrx.5
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o7ho9r/iGAZKzQvAqY97r1IQvfNPAaA5ba/IicHvJwY=;
        b=hbCKQv4py8zWlw03EKgXl+QThGu53cVPGc8fO4vQ7/CX0yf/KLp4ExowJzXLbBZ/e/
         3xOS8KJIrctJKezc458qBgahXgbvhMyQnRXNIpBUKyUdLhST6KaTmUh4vduaWSHtc4By
         Y9T+uW8NUp8MAFRXVroJkKRzzUSJ23TigHPCU1AEL3SUguyPLsVOsY1p8gLGUeRteVC3
         ceDfFRVmplx7J/u6kv9utEj0K3xVPVGjZwaQ3PoKUDSZ3GSYgJnclMVPhICpzOzARL9N
         gu42UYqMYWmM76Ea1iecVl6+IjbYNQ9CBPCvPKgefKrsecEmcqqvseRF8qM8sNSkhuIr
         tZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o7ho9r/iGAZKzQvAqY97r1IQvfNPAaA5ba/IicHvJwY=;
        b=YBr97z0PwfdnOz9PdVdtegGG96KE5b6uVYd7xX2gdrUnzUpWpYOcP+TldW/leHlgQR
         BCf92q/Np+OIs+LEBq+9JXyAeqH9ekgOHilPOpgI6EspM1Vv6NrOhleDIS9wmiWjE2Zv
         xa/oWaNlMEpyWwvfctlYNdPZ5Zidf9o4PCCTKq/S1IHh7OBTYF9UQoh+DKVhxFb4ibkb
         qpE4VL5sdl1TMplyG/PxMghGUc3t5nHXCkB+DPMAYTens533wQPLHFVE5wMgJBnLA1Sh
         KXssehkeBefRJHNRqYe+O4l/E34hQCpZpiCBr0IEFGPc+daxuJkImRhx6h/edKUOTgXE
         uBRg==
X-Gm-Message-State: APjAAAX7ybGNX9lxj3VtpBJwjC6cA52aM//HvaF7Ss5JZZNG0HCrkjqY
        0MSdK5UY+tAPvNa26KuoruhstAXQxBSdhA==
X-Google-Smtp-Source: APXvYqxe6ABFSX/fr9kAyogvKjvlUZiuw+kj/+U6iGNWVgjD3zHmuy8L8HzR76Xsw3m0waD0JpWu5w==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr29734798wrq.129.1568203766000;
        Wed, 11 Sep 2019 05:09:26 -0700 (PDT)
Received: from localhost.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id n7sm20135743wrx.42.2019.09.11.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 05:09:25 -0700 (PDT)
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
Subject: [PATCH v3 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Wed, 11 Sep 2019 14:09:20 +0200
Message-Id: <20190911120920.9026-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means msdc_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().

This means during system suspend/resume, the register context of the mtk-sd
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the mtk-sd driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the mtk-sd driver, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Fix the code to do the restore in msdc_restore_reg().

---
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6946bb040a28..189e42674d85 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2435,6 +2435,9 @@ static void msdc_restore_reg(struct msdc_host *host)
 	} else {
 		writel(host->save_para.pad_tune, host->base + tune_reg);
 	}
+
+	if (sdio_irq_claimed(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static int msdc_runtime_suspend(struct device *dev)
-- 
2.17.1

