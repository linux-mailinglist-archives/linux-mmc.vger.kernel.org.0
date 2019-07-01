Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8502A3BC3D
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfFJSzF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 14:55:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35160 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388781AbfFJSzF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 14:55:05 -0400
Received: by mail-it1-f194.google.com with SMTP id n189so770429itd.0
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQMhD/I3Y/XjJlDvubFbz6WnQ+Gl+pIyjaq6A0eWHVw=;
        b=Emfxz6RY6w4czebKElQtlB10YASnT8iWdQGOGp5SE0x45AofJTF1UyNsWWCuBsQjW5
         AaE90CsW7B+edHf6Hr5Ft6VbCu/bCscAC9k2L5NI+KrT/ipthSMMxbGdGy5FtDJnhzf9
         LIc+nBiUlpKf7+hN8T5yZK+JOhAhURg8/Pa8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQMhD/I3Y/XjJlDvubFbz6WnQ+Gl+pIyjaq6A0eWHVw=;
        b=oKeXNcrs2VwhVjFZz5JM0EGuuG2WGKfwAUtsEVF7liSvfaW7w7EGdcr452vJkxA3U2
         WP5zLnIT8gGy+QCkknEYaDKihOjqOntrLkHYpqxNHnP51kK4yGeoRo56M8PPJmdva55i
         JJk3cyzYFZ8X2huQ9+E+gQGM2E6d4+nHBO8CfruytTAj69+KT9j89evAK+24u0Y3F850
         wdgrF0eidIP5d4ozxmCaxvoCQnt6MitBsL4Kth1DdFGu5u2rdNTnISS+N/nV49oWAhLQ
         XMqA4VzoI/VbvngRuiqnQa7l5ZjGd4UsUqZHe8wpjbSUj2cpVSHH2K/XsxauBMZMEoup
         rARg==
X-Gm-Message-State: APjAAAVvVHWl9B7vP567R0nKLprvp7pqmn/e8cHQaJNMhPqeWnlGXbhW
        ANKe4wjWhfgd0TfqZ1ItYQUoInyy2y0=
X-Google-Smtp-Source: APXvYqxJNfXV5i5V6uCmFvPs3vnRHn3+3uGvUWKJPHMZzmWz1MeUuxrppe7rrcjxVS3l3hqi0W8cDw==
X-Received: by 2002:a24:7cd8:: with SMTP id a207mr14906744itd.68.1560192904769;
        Mon, 10 Jun 2019 11:55:04 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id r69sm175876itc.11.2019.06.10.11.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:55:04 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Mon, 10 Jun 2019 12:53:52 -0600
Message-Id: <20190610185354.35310-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
References: <20190610185354.35310-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The O2 controller supports 8-bit EMMC access. mmc_select_bus_width()
will be used to determine if the MMC supports 8-bit or 4-bit access.

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

 drivers/mmc/host/sdhci-pci-o2micro.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index dd21315922c87..07bb91cbdf1f8 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -395,11 +395,16 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

