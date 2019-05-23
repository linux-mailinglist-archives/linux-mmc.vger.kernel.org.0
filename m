Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340702805E
	for <lists+linux-mmc@lfdr.de>; Thu, 23 May 2019 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfEWO77 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 23 May 2019 10:59:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfEWO76 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2019 10:59:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so6674137wrt.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 May 2019 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CssnNRfqQDe95aEHLIDwNrxoMm4Qr1zdDx/8yvm4qr8=;
        b=REOaV5SsGZnknVjXNHI1+w/KigvMYFqry/bQQI5clubnG+/RkWUFG/ltDAyrO4zkDH
         c77lz+ZH9APatZ8RBKfqZIrQu6VUfGLvuNAfXebV7VcJq0pdvlNCsyc1vYPkRZn5Z45u
         2RLB+M9VXCmNsKrfoShvy6RVSnqq5FoHPvGXyFNWVwSPoutqYs4IInrK2K5u60CYCeyx
         /OOz32VPGeF+hV8c9HwrzIXhievnXkU76cLyiI5nnx49ZFl3HkF9Qdx/uqVIY6MKNnFa
         p6yzQku7tHyyS/MUqo1UMfav8fcHGO1INv8DrGX9vjXdZRQkAqTzCcRFRfOP+0Q7ScDv
         1CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CssnNRfqQDe95aEHLIDwNrxoMm4Qr1zdDx/8yvm4qr8=;
        b=rvEWx7gYCmywTyxRdB6NhBikWL2heRw4bOpaBkwJ62y8BdxTrBl2W8ckHpTS3Z5UAc
         fGIxXp/mhVeDrPAp3R+ON6iaGzLumh0tpR6q4X+ObwGQmjB407HQy2ffeBfWES01/59i
         sK+S8yCwn0gLO15EO3mVKGmaxY7Nv71Qi77tYdm1Qlwn77GaIZioPdUGYBooQzQlp963
         PFsUBYUl3PpQQqVkI6oNdW86qnTq1H+ThZKaWeKRL1PQjEl2fLIMOEiKj8Gn8HLRnDfp
         Id0Hs2qKAwka4Zd3mPWZpz4ZwnELvVrqpL4PPOmoNwYX9HknKaKqFl5y8raYVpJfuKpU
         12vA==
X-Gm-Message-State: APjAAAUQHbvswtlfHY8owknOrLJ/XcEDD69TmSAYU6Wc+Fucmvm6G/+R
        LOzb7Fa7ZUbUt0dJSEGmslJlnWNlmP4=
X-Google-Smtp-Source: APXvYqx/uuRO0IHEqvTfUgTvkFrAj21iMWd3FOVHEIJ7N9kr8gaNKLRjtE6H+YJHuIRDbZsfcx4ktQ==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr1327464wrw.65.1558623597101;
        Thu, 23 May 2019 07:59:57 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o11sm14429930wrp.23.2019.05.23.07.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 07:59:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] mmc: meson-gx: fix irq ack
Date:   Thu, 23 May 2019 16:59:50 +0200
Message-Id: <20190523145950.7030-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

While cleaning the ISR of the meson-gx and acking only raised irqs,
the ack of the irq was moved at the very last stage of the function.

This was stable during the initial tests but it triggered issues with
hs200, under specific loads (like booting android). Acking the irqs
after calling the mmc_request_done() causes the problem.

Moving the ack back to the original place solves the issue. Since the
irq is edge triggered, it does not hurt to ack irq even earlier, so
let's do it early in the ISR.

Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6ef465304052..cb3f6811d69a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -873,6 +873,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
+	/* ack all raised interrupts */
+	writel(status, host->regs + SD_EMMC_STATUS);
+
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -919,9 +922,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	/* ack all raised interrupts */
-	writel(status, host->regs + SD_EMMC_STATUS);
-
 	return ret;
 }
 
-- 
2.20.1

