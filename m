Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A609ACBFE
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfIHKMs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:12:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33666 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfIHKMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id d10so8261482lfi.0
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xyicSoe6hBPX50Bq7X1NmDZdoCyXZNomcUNAFE37PKY=;
        b=Edn66P4SYLLch2VlatADxUAdLd0tfPrivUo4T6tVpdrp6UL1oMk62JvZ/hUJkvl87r
         Y4Rm76XwOcNH2VYEBygULdW5dVpM0jJkgDrgRJ3tLHe0DbyD+VC17UKw8QcWIoEhLW6g
         UxzARtbao3FE7GweeUr4Qonq+zdqyH5yT9dMcyQ1L2uBx0oU/N8x9O8wa1/WcKH5sb9d
         9/HHhGHe1Lb5zmI73R/bjlpLVEaAc/mzChuooMB7S9eV3mxlP4d21X0xNbO8k6ssorLY
         I6whMaBA6Wswcg0rkCzfsWxj+NH2NnWVUScQXOlFfJOwxwNbJgeZyOXxMOyxOgKhTBsk
         GmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xyicSoe6hBPX50Bq7X1NmDZdoCyXZNomcUNAFE37PKY=;
        b=rcxfcBTPHTNzdeMHnXDGaBEww5BQpgQnS8RfrG0DLVnSLHM0gGkVoxfqtvqon7qGlq
         8d6Bg0yIHJSDtfvjbwv+n7I5Uyoro8TNMpRJFwC0ZINdICU4NVRpK9hW9owRe8XtQZQn
         ZpMpZ+95RM2DtRUl9LG5JUsCQeiBnU4luZ/SPb3IRWGOTn0bajEtvG9Hpi01J299T+AQ
         9s5ouv0RbqAVCXOkQCpL/+M7XBkGbTLPRyselrDYJUIZga5JS5Mlf/nlpymbUQn22cJy
         TmNMEXv3rCdx8v3Wu0E4f8sSv6LVDbI95OYqRrHPuFoo9sbwn5rvoU6YFOfM43YHr1FG
         Q1iQ==
X-Gm-Message-State: APjAAAVkEZlCbq2N0lfbFdJYznpuGaB48HEbB09i2o1jpuyPxSo+ywHV
        eoFVzzAikRPwXi455qC/80DxPnYzaAE7Ow==
X-Google-Smtp-Source: APXvYqx9rsoHVDfNzT1ZVdZm1qIiEGkOqHceJPLVcgXZDKXrF+hMW6kC9XtCo2PmnIfoI33u7rdyTA==
X-Received: by 2002:ac2:508b:: with SMTP id f11mr12898573lfm.153.1567937565846;
        Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
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
Subject: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Sun,  8 Sep 2019 12:12:28 +0200
Message-Id: <20190908101236.2802-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
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
index 6946bb040a28..ae7688098b7b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
+
+	if (sdio_irq_claimed(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
-- 
2.17.1

