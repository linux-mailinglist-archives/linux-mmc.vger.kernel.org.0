Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD4490F4
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfFQUKZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 16:10:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46842 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfFQUKX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 16:10:23 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so24031930iol.13
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrP+dwORO9Xg4aec0HaWAympb2e/AJiy4gVQT0weYII=;
        b=Tt1rc+ZS5s3ESXw6Ayk3cPGD+JH2l1u+D6wOwC5cLjeRxfOgt3UjNysh5Us5d6LYYe
         XlJsJRNBimN64BpEFyyZLbCFstqRfDhXhIXa9gQHIR54lo/sfhzrEfhDfaxZjmjcNQDO
         OCC2H/nYzkpPawyo5nqdZza510JsZElQZDl9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrP+dwORO9Xg4aec0HaWAympb2e/AJiy4gVQT0weYII=;
        b=sEVrpLnMSEFvNRD2wlWOLpkors5J+qagN64uXhfub2wauU/4q9mS9jfKktGRxaPNBg
         EttlogOgRz59uWZd8wAMw3v+DYkZJQLGohvcwk4t4FdUbBiXORMeTVS/L1/HKy7rU0VZ
         jytNnv78pC4JQpTj1U9BrOX2GJUeGiq3f9p1FxbgJKmbW+/dirEcuA7/wjXuKdHeZiaM
         4GjwFfnREz9tUUz3qjsabGp3AM+sv3lrmt3FUZ4rvZgw+OUGUvYAtKQsvEgiehB4lpcc
         NP8KnvUNLy+e3aqZ1S2DQ2qSflK/A9sK1JXemI23KKs1eT6ZqFf85UUtvTdjaeP1lC+L
         tBOg==
X-Gm-Message-State: APjAAAUBPOcqMJQXbyI2h8z8ESpDCnuCeukLTvkugVBM23PxuvKVBaYs
        mUEdlDmOIpv/oT7ldJMkFCgmqc8/TJo=
X-Google-Smtp-Source: APXvYqygMJgeWzK1ojHPxZex1M+4XMd9/xaXnVY9vsSh+ib4eptOyhNbzhCuBUjV952+Zzqj8lC6DA==
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr694917iob.249.1560802222714;
        Mon, 17 Jun 2019 13:10:22 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id e26sm11047672iod.10.2019.06.17.13.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:22 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Mon, 17 Jun 2019 14:10:13 -0600
Message-Id: <20190617201014.84503-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The O2 controller supports 8-bit EMMC access.

JESD84-B51 section A.6.3.a defines the bus testing procedure that
`mmc_select_bus_width()` implements. This is used to determine the actual
bus width of the eMMC.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I tested this on an AMD chromebook.

$ cat /sys/kernel/debug/mmc1/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Before this patch only 4 bit was negotiated.

 drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index dd21315922c87..9dc4548271b4b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
-	u32 reg;
+	u32 reg, caps;
 	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
+
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+
+	/*
+	 * mmc_select_bus_width() will test the bus to determine the actual bus
+	 * width.
+	 */
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
-- 
2.22.0.410.gd8fdbe21b5-goog

