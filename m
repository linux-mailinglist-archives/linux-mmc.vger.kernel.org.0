Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46AA6B4E
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICOXT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:23:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39831 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfICOWi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so13050121lfk.6
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SADru+zeJoUa6Kq7NgE3oCMhDB2qphP6ONJw4NgANKU=;
        b=OFHtfa4wufhXWOWb3kQTUHd0i9YHGWH7vS4YpuePByo1apgcQx0qPn5D2rDAPelA2Z
         c9AFN0rmRl04Af4morxrZ3mOH/6uAa5o24p5hlLofES39wmRTB39cuKWKsxsRbwOPueA
         DWKNvjHA7bcEZ1WnlxtbCacM07rt3dqTsZp4a0qXvTQeCR28W5+16F2Hu7sZslGhNe+2
         /aLGk/irsE8VSg2imBO3LXorORY3s5UnmKKS0pZ1Wf/Tcs/Byda5X4A+tL6KlvEDpHqt
         vHpl86saT3X7iGXCPgRyUtq7iDDP1IjtuQWaqjKo5k1t5UqNlEovBQ6B26wBM3t7/M3q
         dWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SADru+zeJoUa6Kq7NgE3oCMhDB2qphP6ONJw4NgANKU=;
        b=V5m+XQsxtNoZZdOPpaqNUw/Tz0Qt2Esk0Nh0m6ypg3YFfFY8V5nOTn/vBvL9vi4Xcl
         gE6Ej7mVgTlNhatMDKPiPL0CM2W9HkMPNvxsGdrvcUYr0ghWxGK1tYP/6yMu3kOjZbKW
         1Asa9m419YC/FzdTHu2SugzmtUEBgPAYwBmOiuoy6RtRNvTNdMHkKeg+Rf8vJYQ8T1LT
         sqfkYQbTe0+prvWcDihjZHuIvPbcCO/f2FiWYYOeKLpToP1VokAoSiimMrYw+cx2Iue6
         LHPk4YEKvGJuvVPGZUKbpxJK7Sv4mCJnEcY3pc2HVwHJbdSkiZc5YNf6AXRK/XePeElS
         3VGw==
X-Gm-Message-State: APjAAAVaf/iBfh1PQ6a3JZgWVkU54O1Kn0Li5AJvh/6hpbZLvvqd8wz7
        Xe2J0iW2aBK+lZcWr/rfL4DL2TQzZmk=
X-Google-Smtp-Source: APXvYqx/2ml75qZUvcITEBML+/VXCJWVUP/iHChuBbmOfuQX/0u72UoOykubRwkl0ub8F7RLyPaLPA==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr451699lfi.81.1567520556123;
        Tue, 03 Sep 2019 07:22:36 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:35 -0700 (PDT)
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
Subject: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
Date:   Tue,  3 Sep 2019 16:21:58 +0200
Message-Id: <20190903142207.5825-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means dw_mci_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().
This means during system suspend/resume, the register context of the dw_mmc
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the dw_mmc driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the dw_mmc driver, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index eea52e2c5a0c..f114710e82b4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
 	/* Force setup bus to guarantee available clock output */
 	dw_mci_setup_bus(host->slot, true);
 
+	/* Re-enable SDIO interrupts. */
+	if (sdio_irq_enabled(host->slot->mmc))
+		__dw_mci_enable_sdio_irq(host->slot, 1);
+
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-- 
2.17.1

