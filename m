Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895A13BC36
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 20:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfFJSya (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 14:54:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38321 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbfFJSya (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 14:54:30 -0400
Received: by mail-it1-f193.google.com with SMTP id e25so740229itk.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daXs+Zg5JpwmvESTwSzf5RK4ZRVQCRqGZBkG95Vym1M=;
        b=XOsFbF7g+awpsBdgzHfH8P/28fJNJjNhXimq9Up5pVmSfDU0fwNM5F6pLhQXpGc8GG
         TMRbaNyazBpfStpSX+zSD4so0HCQ7ThrF3MTUSoYZ95pjUD+l4b+du8psedaFbjddUeD
         yX/zDbgHnGzN9ud6eAaHJDmEWr/3jP4vtx4Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daXs+Zg5JpwmvESTwSzf5RK4ZRVQCRqGZBkG95Vym1M=;
        b=m2fI2TDiGZsRvXe/TZS/UufVkEWYqwXlyb6DKVxaS3672M5gYQ/gDvdUl7kzMNTRY0
         aNFfOiP/Y4JE8OSJOCjoqcJ4ZCvvBKquBi8uspjoHqdXeSRA9TDnNemR7rBynYzPa+ME
         /U01rHbYpGNgYv9rEfl+KJ6y6WazH/KQEOTyXsgUL1s30Mj5byUloDpAHPGOmn8pFx5J
         kFbMiK1e8FmbRZfJj/aiWaUore7pL7i7Zoh0D0wm8xAElvMfcQwsY5BurUPKKCq/FUR5
         rDQShuKRFjy5ssffmcZjSNnLOJpFcIv5ZPY6Mkq4+zoVqLaLq3Ja3eYIKQCcD70SH6Z/
         9ZwQ==
X-Gm-Message-State: APjAAAWOhDtTOxQLO3TJMxvJvSe6TbUuzbRy1o0Om+TPtAH3DXqFyo37
        w824/t6NRQPXoAIhAJ9EcBOOGeG/j30=
X-Google-Smtp-Source: APXvYqxsczNm4XKbk5o9HtKx57BlZ6zZ8Ncz/ayRFUvobSV3RUF/A0TzU7Di7woJOM4m1Sgqdb6jRw==
X-Received: by 2002:a24:2b0f:: with SMTP id h15mr12121916ita.99.1560192869752;
        Mon, 10 Jun 2019 11:54:29 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t133sm4107359iof.21.2019.06.10.11.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:54:29 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date:   Mon, 10 Jun 2019 12:53:51 -0600
Message-Id: <20190610185354.35310-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
Without this patch the block size would be set incorrectly when the
bus_width == 8 which results in tuning failing.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index b29bf4e7dcb48..dd21315922c87 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
 		current_bus_width = mmc->ios.bus_width;
+		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
 		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}
 
@@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_end_tuning(host);
 
-	if (current_bus_width == MMC_BUS_WIDTH_8)
+	if (current_bus_width == MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
+	}
 
 	host->flags &= ~SDHCI_HS400_TUNING;
 	return 0;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

