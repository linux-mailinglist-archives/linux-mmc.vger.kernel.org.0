Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91BCEACBFC
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfIHKMr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:12:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33862 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfIHKMq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:12:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id h2so3372101ljk.1
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+P+cYx230fGzdea2f5uH2L1U7ubNclgEZwd45XPj+c=;
        b=MuIWFNy4Uu/WuQujI3WpAnPQN7hQjKKrIACQtyJmDl9F1BuOgykCmjH6TEkGxO5kO0
         1r697iLCtkg0JGaT6SPeg/4Z6qdddHsW02ee6t2vqK1f2ou42EqQ4LblJy7Vmj1t5iV2
         rUB+qTGNpoR9VM08EoU+/of9I3Zr+iY2+i2RSikrhZPEp551ZDnIW0kYxmZiwR5TL6Qp
         zArFDlzIksZN+FzgPGi9LAWJP/GMEV71AfbGi9N+RX4poRuYhEYHcApF3n6Ol7k7Le6B
         NGiDjUxneaOf1lHy5+ShuMbBz7pktD3jf7bDJIzNGJDOHYEo73Qn0+13/WlyCvNWm3C0
         DFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+P+cYx230fGzdea2f5uH2L1U7ubNclgEZwd45XPj+c=;
        b=M6l6qYaXVsfcED+Mbm89Qva2vWdh7gGbcvZi75zNI4QIryYMveIW3o6WZiNSvh7IBn
         Vnz8HWzlH4ODg0Cvf2B4VGne4XEU7jdJAUI1YaCJybD78XMVxMruO96i7DA9hPSdl/Pj
         le+JPnywmAUq238eYQwpsnufKpWK+IraVAoZo+LiVcBR5Sy0BxFz3atkyXurF+trk06n
         0souhOHeyUavNQq7mPHWhbEPczQRPvIfcr26rNbaeA90jJAW1Wx15chuVFTsPE+psPw+
         sl5WNgmSBZV2pogYIhxG2+IIulxONYI2I86tWCL8nLhh3g2pW1jEi0OGXgFn2nKkikbw
         aMOw==
X-Gm-Message-State: APjAAAVWRr04Tbsk+2cdcLrYcxF5ls+2f8wmQd02VHIL6tQOEdRNsJxV
        boP7up9WQboQbAEwMK1RzE4jaLYON8BjWw==
X-Google-Smtp-Source: APXvYqyeDghhAOKZpDvXuAhHjLZvljJG/Qs1XijQtmIcegh9WgeMYfGtbWrv7shtlHbwygv65v7kKQ==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr8211035ljk.152.1567937564569;
        Sun, 08 Sep 2019 03:12:44 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:43 -0700 (PDT)
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
Subject: [PATCH v2 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
Date:   Sun,  8 Sep 2019 12:12:27 +0200
Message-Id: <20190908101236.2802-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
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

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index eea52e2c5a0c..79c55c7b4afd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
 	/* Force setup bus to guarantee available clock output */
 	dw_mci_setup_bus(host->slot, true);
 
+	/* Re-enable SDIO interrupts. */
+	if (sdio_irq_claimed(host->slot->mmc))
+		__dw_mci_enable_sdio_irq(host->slot, 1);
+
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-- 
2.17.1

