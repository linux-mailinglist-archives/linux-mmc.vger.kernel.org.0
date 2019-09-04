Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD25A8D56
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfIDQqi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 12:46:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34237 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDQqh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 12:46:37 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so45740593ioa.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BM6pxRzc9IZitNAzk5af/DmUwUUWyKkwjAttI9Bp0s=;
        b=A7BtxuCSvbKKSEcL0GJCf9Ph8dzwh9vRXZRA2B/HdNFpgZNHLf96gFpkLFsLLszJmc
         W6tOiSaoHwnTIg30Fnb64vCHx6OPnSLRW9ZqB2g8cf+cEogIFgOkW6gIqH8DyNzuY9Ue
         oF/4gXVf+MAkxMcckJPJKvOGtPRHEYAuYRrqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BM6pxRzc9IZitNAzk5af/DmUwUUWyKkwjAttI9Bp0s=;
        b=KhjE9b4IMv4cV814ABVkpVbJ+mWtxC3IxPQ2TP/gItgkRRxy4urIOMALOZOd0Z6Dt+
         mcUmDDpuclyd+i6ykqptJatJIR2MnZ8RwYSyim6HUDu/EAXr2tjB1Y8vYmT/+vd+e/xk
         pvTcceTkgI5NZoAscd1jdUJMkSKe7PM67EtlAKueBdRwB0JefCM4gqFEpSH0sDlQEBto
         2LrrwOKhl/qS0ka+4UEj7UFpgOFK8qfCN+XwmqiN1u+DIHvpYsS0S9A5GlK9om1yl05n
         zyEmigIhXbO/6gE2QaAYY2FghlH0/M9waHqgoN5q7ytga8lGwgrWbhmXMbK0HnEGjo71
         AlAQ==
X-Gm-Message-State: APjAAAV/YRo5WxpcwBJ2acjBGJBWEOxTtWFmhQGDYPGXB3z2uEjuL6YE
        aEIb8MiatpIlfRE6QuKO/QEeeA==
X-Google-Smtp-Source: APXvYqy3gvo/TxNI4EHirZ362AB0g09Kqxz/Iy/AapnWUbtnKGchWU456LQFqmOPTi0R5R24n/Saww==
X-Received: by 2002:a5d:8957:: with SMTP id b23mr9219353iot.291.1567615597000;
        Wed, 04 Sep 2019 09:46:37 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id o3sm13641860iob.64.2019.09.04.09.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 09:46:36 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Date:   Wed,  4 Sep 2019 10:46:25 -0600
Message-Id: <20190904164625.236978-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
References: <20190904164625.236978-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

AMD SDHC 0x7906 requires a hard reset to clear all internal state.
Otherwise it can get into a bad state where the DATA lines are always
read as zeros.

This change requires firmware that can transition the device into
D3Cold for it to work correctly. If the firmware does not support
transitioning to D3Cold then the power state transitions are a no-op.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
This is just a resend of https://patchwork.kernel.org/patch/10925467/


 drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7d06e2860c36..84931ebe0c93 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/mmc/slot-gpio.h>
@@ -1590,11 +1591,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+static u32 sdhci_read_present_state(struct sdhci_host *host)
+{
+	return sdhci_readl(host, SDHCI_PRESENT_STATE);
+}
+
+void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 present_state;
+
+	/*
+	 * SDHC 0x7906 requires a hard reset to clear all internal state.
+	 * Otherwise it can get into a bad state where the DATA lines are always
+	 * read as zeros.
+	 */
+	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
+		pci_clear_master(pdev);
+
+		pci_save_state(pdev);
+
+		pci_set_power_state(pdev, PCI_D3cold);
+		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
+			pdev->current_state);
+		pci_set_power_state(pdev, PCI_D0);
+
+		pci_restore_state(pdev);
+
+		/*
+		 * SDHCI_RESET_ALL says the card detect logic should not be
+		 * reset, but since we need to reset the entire controller
+		 * we should wait until the card detect logic has stabilized.
+		 *
+		 * This normally takes about 40ms.
+		 */
+		readx_poll_timeout(
+			sdhci_read_present_state,
+			host,
+			present_state,
+			present_state & SDHCI_CD_STABLE,
+			10000,
+			100000
+		);
+	}
+
+	return sdhci_reset(host, mask);
+}
+
 static const struct sdhci_ops amd_sdhci_pci_ops = {
 	.set_clock			= sdhci_set_clock,
 	.enable_dma			= sdhci_pci_enable_dma,
 	.set_bus_width			= sdhci_set_bus_width,
-	.reset				= sdhci_reset,
+	.reset				= amd_sdhci_reset,
 	.set_uhs_signaling		= sdhci_set_uhs_signaling,
 };
 
-- 
2.23.0.187.g17f5b7556c-goog

