Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E866A6B4C
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfICOXN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:23:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44663 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfICOWk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id y4so6137723lfe.11
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0NvqeeJAxqM9LsjMwddoa5m6zhHcHlw9n+K/8LgxXIo=;
        b=Dr8gEgTBXp1w4VtAi4Mg6OCCy2rvOuKA2OxrnTOj+lxUU6Y5Zr/e/LiMXo9c/gTVMj
         dimHRhhs+yp1gkbZp4z0mztJjWrv3WJBlxkhrla8bsYlzwEUe4f1j3+POiAD3wnTTDu0
         ZXSwSUnivY32b9fKF7b3hLCaNRrkTSAK5o/qkfMGdNnVK6jI/byKgyQLIFIy00GkkTiB
         uPgncVJ8PHuhJVF+6MiyqQbwg2bwS+dUntVWLDg+RUJc61GM/Bm5LkB+XtwrREL0QX0R
         VIcIjvZ6WYdM4CJ6ZIHN0AugBpHZS696oD4v4XD1agn/DGhqtNf2KkEuLA+Gw6HZccSl
         ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0NvqeeJAxqM9LsjMwddoa5m6zhHcHlw9n+K/8LgxXIo=;
        b=Cq+SyENQX7BwjZJgluv2iRi5AacPRt0BMHAa5yrFtNbazpToylgRu2RXevcUQUOMUf
         N56TP1P/tvieVu4dG6TlBNPBGzpdOn7gPybpA/6VdMJjGsIJYuq/V3TzLHEHjB7+l4Hr
         ImPDzp7l2XFAGZgtJOekjEUedYJqcINw/uWH8CJVaCFMraAqLlwtwW6CTZZFeXe3fQhM
         2uSzCIb0Z1ZMY7lIzsYBjzoD9Q7x/Se4cJraQNX8GyqWRw2jur6JT4GUfn/T8BMzhFoH
         2NYjMh04XanDegpiSPT1OEXMPeGwBeq8oRLkyZ5CWh9BcrIPmGapTBUt+B5xUIn7G0BO
         mhyA==
X-Gm-Message-State: APjAAAXKbh/YX4AddI7AiJ4FUxS9O0hUZcg99754LwswrcSTdPoX1JaB
        U7jt1z+5Yw2o4jN0M4XA05zSc4k+6Y4=
X-Google-Smtp-Source: APXvYqweF7JPxx3cnV/NebwZQV+1f/Ir2g4Sh+rI5IK4GEBLjBEWnZeSOmycdTJye0f6h/XH6sRvAw==
X-Received: by 2002:ac2:5485:: with SMTP id t5mr18239629lfk.27.1567520557351;
        Tue, 03 Sep 2019 07:22:37 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:36 -0700 (PDT)
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
Subject: [PATCH 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Tue,  3 Sep 2019 16:21:59 +0200
Message-Id: <20190903142207.5825-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
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
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6946bb040a28..669ea0668159 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
+
+	if (sdio_irq_enabled(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
-- 
2.17.1

