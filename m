Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BAA8D54
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfIDQqe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 12:46:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46402 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbfIDQqe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 12:46:34 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so45571330iog.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6PQChr54NunkxihDMye6FCURG8qhb6MXYTPYLf20E=;
        b=H0X+MvWDHojkg7TT7Xot1qI0sbKDDh+0kTRrCI64n7tiK6nAekYYZScTs+PW9ur4M3
         y5LrEdMAcvWCMikZlTpp+hb7m4Wm46KtTmTwI1q60BfVnWvy1wHA+ITLpzg8OOcFLRFv
         Tgo3T2Vc2th20yxDlG8pocaWB/FTfRNxoOUh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6PQChr54NunkxihDMye6FCURG8qhb6MXYTPYLf20E=;
        b=jKco9E/h3bBdcEdtI54TUGuLnCe7xFAJbrgmQLZ1tAASOQKD5C3BZ2b6eukspdafYd
         rW7H0+SLt1kDCNeTrgJY+arY+6uWdAiwDhfmUAJMx46zxuhxPbl5dJpuvcXxnYyn41K3
         UOsIAikychRZNGxZWb7/YwrQ9jg293RgB7GI8d3i915xaWr1S4RMxpbyVN6e0hPsmjGu
         KXFbpRev5+m0MTyJakOYJ7jWZdgFHQ9ZCTSO6/CAfVifbbTExdMdMWSY46Bw8ijdjezw
         PVONinO7suqIdGYVXw/IOorSisGwRLezMrozcUWZeAi2SHx5T1qr7NQbhTDdH0mnPX9B
         HUaQ==
X-Gm-Message-State: APjAAAUS0qm4K8k84mxLbevBg9FsAGxEVsiy9wkD1oQnJ6D191HD/iD2
        GL8/F0SXJQZnSmdDIdlxsSy0sg==
X-Google-Smtp-Source: APXvYqxH+igDQlLwSM5qwDu5hhMtLDs0wMevf1p5TljXXr4s3NH7/317yTaHiUtRf1xU7RSCb1b5oA==
X-Received: by 2002:a05:6638:1e5:: with SMTP id t5mr6265540jaq.79.1567615593561;
        Wed, 04 Sep 2019 09:46:33 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id l186sm2126395ioa.54.2019.09.04.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 09:46:32 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci: Check card status after reset
Date:   Wed,  4 Sep 2019 10:46:24 -0600
Message-Id: <20190904164625.236978-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In sdhci_do_reset we call the reset callback which is typically
sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
controller will clear the IRQ mask. If during that 100ms the card is
removed there is no notification to the MMC system that the card was
removed. So from the drivers point of view the card is always present.

By making sdhci_reinit compare the present state it can schedule a
rescan if the card was removed while a reset was in progress.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
Sorry this took me so long to send out. I tested out the patch set on
5.3-rc5 with multiple devices.

This patch was proposed here by Adrian: https://patchwork.kernel.org/patch/10925469/#22691177

 drivers/mmc/host/sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..b0045880ee3d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -337,8 +337,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
+	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+
 	sdhci_init(host, 0);
 	sdhci_enable_card_detection(host);
+
+	/*
+	 * A change to the card detect bits indicates a change in present state,
+	 * refer sdhci_set_card_detection(). A card detect interrupt might have
+	 * been missed while the host controller was being reset, so trigger a
+	 * rescan to check.
+	 */
+	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
+		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
 
 static void __sdhci_led_activate(struct sdhci_host *host)
-- 
2.23.0.187.g17f5b7556c-goog

