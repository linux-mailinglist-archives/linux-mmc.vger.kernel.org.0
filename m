Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65659EE0ED
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 14:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKDNXF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 08:23:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43225 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDNXF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 08:23:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so6663627ljh.10
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2019 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vg2dkF/2Ifi7G+ZcSBBl+nfqJx6J0UT9qBXqtWzzGRw=;
        b=QzEiccYQSDuMK2DgIFIezyexmyQOpxPdN2M47H0clKJStHoVH1bChOXtVPrJZGgmT3
         U1MQ8S8DrUZUJAIcc7NQtBikrQtNkTZAqCmZrYIDIK1L9NdEi29WmldPpx/Av1DDnDuS
         yXDXKpxFu8brtz1ejSioWZBvhJY+u8RxTLl6xz1yd65+jNxzGzL6hUcIV6SmxGQRP2uH
         UlhrZ/Y5RwJ5ML6UyNhyJSUF+BdEDsCEsWtL/1DlnIb8/gHEHvAu7IZoSdXVVzC04m9P
         u9RPh73zpoDA2t/PzbAVWVXBQMwu+405m875bil+4rC1ILPOCCrQKKtC5T85d1MQgaF6
         ICTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vg2dkF/2Ifi7G+ZcSBBl+nfqJx6J0UT9qBXqtWzzGRw=;
        b=lYos9rf/oQTjoRh2fu/O4V0YqzoBqxCoadcbKypZL8ZpbeGGBYBbKEPwKGINbd+FpG
         NM1mpZO3ReoZkdQPJcE+7K9ZhXRijUviGMhCJVhoD8w1mZ+fYXKCdsOOsmeU1gGwoUTc
         e7E9KbmWx0/vEAgDmdNfsPQRajN0CfgQCw/1xr7RMaqzv7Gby8m4O3YHcl0lDK/oMA2o
         gOND5xm4qK89eLOAn2YodT26CIBtFEOUlE1aIiMp66PF6B08N515zRoeiQnK/Z4pxcwT
         KVDvZuoW/mUETCVafmFXc2o1XFZsOXK4Njj3IugrRIbbLEGBOnNU8S0l3Fs33BqXEYSo
         EJAA==
X-Gm-Message-State: APjAAAUSiXWaLGlWirDZHmy8radQ5KBPUg9ee37nHzU2KklU6Dd1AECM
        LvECuDFYBpzmbdy68hdFWxSKFYCcl/g=
X-Google-Smtp-Source: APXvYqyr2DlrYIUmXxRcozCzuzKS2AReVQ05zDr4H4OrG0lgYHBfH5ZWUAhu7NyPOjJ0wbVwf3dlYA==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr13779760ljo.80.1572873783018;
        Mon, 04 Nov 2019 05:23:03 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f5sm6480538ljn.24.2019.11.04.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 05:23:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Mark vub300 mmc driver as orphan
Date:   Mon,  4 Nov 2019 14:22:59 +0100
Message-Id: <20191104132259.32500-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tony's email address from elandigitalsystems.com has bounced for a long
time. Let's update MAINTAINERS to mark the driver as orphan as to reflect
the situation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fc3ff3cb23..be6a6539103b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17456,10 +17456,8 @@ S:	Maintained
 F:	drivers/hwmon/vt8231.c
 
 VUB300 USB to SDIO/SD/MMC bridge chip
-M:	Tony Olech <tony.olech@elandigitalsystems.com>
 L:	linux-mmc@vger.kernel.org
-L:	linux-usb@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/mmc/host/vub300.c
 
 W1 DALLAS'S 1-WIRE BUS
-- 
2.17.1

