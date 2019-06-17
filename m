Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AA490F8
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 22:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfFQUK2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 16:10:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34492 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfFQUKZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 16:10:25 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so24267506iot.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmQHqjhHBWJi9EwLf/CG1WJEE+QuCC5/BPgepbsr0cM=;
        b=H/fRfIgOLxZAjL30Tf02SNyuVL4rKUnrX2bKgFBJyd5IQUZx1ZP6q7691JqcjyC9nS
         ++sCnwMqLy/QpEj+7Hi7jU5SjniVAjL78+/q92CgC7hs/S7yVAkyhXYXlfSH69K6ZbzC
         a5AjFLd56W7UgJEv9EIhkxSJcgspEV81Jgn30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmQHqjhHBWJi9EwLf/CG1WJEE+QuCC5/BPgepbsr0cM=;
        b=SpjO9ZLZJoGIo/MDvgkfew7jZ8QSwp358p3SsADifnPQxwOkIMul52BN+bjijaYYlv
         LXy8E1hR5iBxLDANG9MkCWME2N319duf6sabjR4tWn+1ozJnqlv6hHO87+B/1bOgiMqB
         I2/M7m7zlrZRNgRI1oG2xsDU+Zn20WGJNkD8NO9gY/fzH5UWzb0+CIUqPOsCaw7NghYy
         ppRXIuTcIOje0fstRhhdnyCIU1rjrbljtQHfTTlFxF0xIkZDGlclHN4H+RTLn3oO6eu7
         dlzrHpEZbdr9A1rWevT8EkJqir6I+wPu4RiP9aejDCyI/eA/TzqehbRwBwHDdpuIBIgI
         HGiA==
X-Gm-Message-State: APjAAAWnGUuyGDwQ8K+EHwKGlb9yp0SHN4kF5UkCa+cxwQSq3aEXZ1zy
        l9F8sStWbHGdJulpYMNggX3Q3+i8r6U=
X-Google-Smtp-Source: APXvYqwODDA3bqD50Y83iVab01joUoo1S7LoKNsRIrKC1JdP7WoFgOUSHbQOduVooAcoh4huWj9+dg==
X-Received: by 2002:a6b:b257:: with SMTP id b84mr63639506iof.137.1560802224611;
        Mon, 17 Jun 2019 13:10:24 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id s6sm9199236ioo.31.2019.06.17.13.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date:   Mon, 17 Jun 2019 14:10:14 -0600
Message-Id: <20190617201014.84503-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
of SDHCI_CTRL_DMA_MASK.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb3..89fd96596a1f7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -89,7 +89,7 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_ADMA3	0x18
-#define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_CDTEST_INS	0x40
 #define  SDHCI_CTRL_CDTEST_EN	0x80
 
-- 
2.22.0.410.gd8fdbe21b5-goog

