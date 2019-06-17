Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3D490F2
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfFQUKV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 16:10:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37593 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfFQUKV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 16:10:21 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so24217313iok.4
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zhz2d9XJe8nX7yclD2KabSz2ABSlxKrOqshNsQUbLNs=;
        b=Y6+XH3rTuBpT3/+zGSEve8N2Cd4liXJXGlvGeJlSlgjF4gvKqhNYNQxq4gH2UmWvyX
         JRm4nzTjgugm66g7l1Ku3kx7AtyeUDOjqK0/t+VGLauGNDrRYHMgRW4cdQWrRGcBinuJ
         IJ2ILz0XYXRMpBMaqMofa8CyfHQqrj4BGtpAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zhz2d9XJe8nX7yclD2KabSz2ABSlxKrOqshNsQUbLNs=;
        b=UOWLaPcOR2XhGQnElyJynId7A5ufG/j7FC9LNWVd2gu7w0nMt1wAYW/BDx7UBnK1xH
         HCwnOI7UqZmkAIIvbz6XBv1ToGndFxRAQM6pNsjaKvtrtOG2uL651/TD3LA4guSIh5JH
         RLftPn6HQRUeYZ5f+x0GoSLVi/x+7xmXLNWQw0wCYWQohgDGvpHPxg+/9fQyc0xOkutQ
         1/k7nvPevYCMZbnWMsvAtiFO5gyW4vAkDf5JImBOjLnwLyGUCI5zN2hPPfNsGN3z4mt6
         229+s4tFkSTrYBmCWoLe+jVvQdVu2Hyjrf8f2/SeJKnAsaNMj+2GPc528PN8SxjDOmfR
         KpQg==
X-Gm-Message-State: APjAAAWihHUZc4CtqaOt5hXrNK7Ioo19lBOe6gh5hsgmYIQ0pWut7cUf
        ZIi2P76HdW9men4VH+Ng6YkVPc/Yb+o=
X-Google-Smtp-Source: APXvYqyvSFVPICXlZ5qOrdYqNCjoeODwgIZegCYh7Y1Z/RNaw1BomNUYMBee5d7BAhV7K2HU9ro+EQ==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr18399719ios.227.1560802220123;
        Mon, 17 Jun 2019 13:10:20 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id b6sm9755978iok.71.2019.06.17.13.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:19 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date:   Mon, 17 Jun 2019 14:10:12 -0600
Message-Id: <20190617201014.84503-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The O2Micro controller only supports tuning at 4-bits. So the host driver
needs to change the bus width while tuning and then set it back when done.

There was a bug in the original implementation in that mmc->ios.bus_width
also wasn't updated. Thus setting the incorrect blocksize in
sdhci_send_tuning which results in a tuning failure.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.22.0.410.gd8fdbe21b5-goog

