Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED0434C58
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfFDPet (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 11:34:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfFDPet (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 11:34:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h1so16328853wro.4;
        Tue, 04 Jun 2019 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Drpmks9Nadt8eEMrC4hxDy5or3+S1vc4/WSq1uRgeVA=;
        b=EeKpfr2NEBbLg79euWAguBeDxYejmlTQPs2nwZ4ROCsjtEvuxBKaysPov51PGtXb9m
         VKPwaU2qoWdmvD/nvcgpQzfBGLXpO0/mMOlqV3d88XtAclAkMiWbUAgThInufefmz5IR
         /p2807h4pzJPKs0yuC3bbIjOeOhLrdD1rRw1p88yeoMCwmbPUEJjqG63FWMfngwRS/Oc
         oXugNwa2k2M8XuLrFAsXiLSlVWoNqEqOBOQai4c1QVUlrWmbvyLHNeyNxz3dR74QVJyh
         92B8iZwJPyY4ZOe/gTeT6+Xb4DheOj0Y1XC+HMdaQVCEBgaxXpcLjSUXSvB1IzuXfWNo
         FoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Drpmks9Nadt8eEMrC4hxDy5or3+S1vc4/WSq1uRgeVA=;
        b=T0gipifpa8S0PlL+2JQf2YsqsV8PHAtrfcEU3+9Irw+8UpAR6UIPr5x4ImtvP39CMG
         FH9/RMOReKbbRqJiyMsXiSVGmWbNPdJXIA1rDonYPFAeL013bzBJjSyauk58c6bqdwlh
         tEfnkbkVwZqsAp7Vgwvz6kob5XRMbGR/KI9QwUMk/89H0djwIeNHwpPo3e1NrdNa3KYM
         oFQxMrguLdYfb+8Ths0kP8bevZdYGDxvO1O2dEOrXeqX4Ok7xh2jg5yJgqguFMHKxxPW
         EqtumE4CBPmje/i0gm26OCjwUQ749/bpzCr4j71BXm6EaOZtrV2fxifCBh1w/DWqTLyA
         4bXg==
X-Gm-Message-State: APjAAAWBhFuZgVeWWA8hoduL6lF11I+dB3rcWXsBh97kqQYW+HfnBScN
        jMKNumv5+H1tDOoIKKaQLY4=
X-Google-Smtp-Source: APXvYqxLC0ekWFwzusI53pYkvWLKTovC7av1usZ+yyEKDtMROHOdA57mqcwfNvrILFJxFnGzkCnyQA==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr21054490wrq.28.1559662487881;
        Tue, 04 Jun 2019 08:34:47 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a125sm15526336wmf.42.2019.06.04.08.34.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 08:34:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] sdhci: tegra: Do not log error message on deferred probe
Date:   Tue,  4 Jun 2019 17:34:46 +0200
Message-Id: <20190604153446.22857-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Recent changes have made it much more probably that clocks are not
available yet when the SDHCI driver is first probed. However, that
is a situation that the driver can cope with just fine.

To avoid confusion, don't output an error when this happens.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 10d7aaf68bab..8a6a51bc038b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1550,8 +1550,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
-		dev_err(mmc_dev(host->mmc), "clk err\n");
 		rc = PTR_ERR(clk);
+
+		if (rc != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get clock: %d\n", rc);
+
 		goto err_clk_get;
 	}
 	clk_prepare_enable(clk);
-- 
2.21.0

