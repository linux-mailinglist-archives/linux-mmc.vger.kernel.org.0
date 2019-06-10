Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69C3BC3F
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbfFJSzK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 14:55:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56058 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388765AbfFJSzK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 14:55:10 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so757031ita.5
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OQiFS4mzZNpmchUtzhYv2GneN1IZGSv7wacJrf6EtE=;
        b=hNHkuWRDqlR3Q3TDaxHRzI06RqOjj75TOm4O2BEcyfY0AOdiydlwK2wHdT4xm6B8iT
         c2OTYhCNwn6/48JaeFcoPisRPJk2Ypw6FzF9hwTd17Lq9FURyXB6uxvutuGxuGi/aMDV
         bBmb3wHsiLbhCsSUfuqYYVT6vmhgQccim0vyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OQiFS4mzZNpmchUtzhYv2GneN1IZGSv7wacJrf6EtE=;
        b=egunQ9wVW7zgwIGOYMyhicU2jgNxFp2FJj6mr5OyHlyE4XODonsYsEhawHLr/ga/bQ
         QgmexcXn4V++1wSAW3l/RprsuMOcqMMA/NAxeQcLa/jGdBGR+Sfzw8CIre86UCncUIb6
         UCEQCq+GL7wusU1aF2LuJJAJiNYsZVKeDoeFxhWlnxWs7z7+QdjoSPLj2K2WYlVfbXA+
         S4isZ+enikQ8GNFG2pErPsEPvjgRUAREvpxqnLU8KD04WCu1RK+m6aFhTqibUaWZcMVV
         aDpcPzVaFk6EncYgl7ChJ8QxxBYAbeHYaDe3StDMAEMwmdMTBFR4v21Lhaid2/kCUdkj
         Ektw==
X-Gm-Message-State: APjAAAUdHZgF6Mp0wcGxLymRTDfdJO1g1fBawbrf6lJgFQ/p/tzZeLJy
        peOlzAilmF/p2kEUrbqC9G/gHYl6zBw=
X-Google-Smtp-Source: APXvYqwKv/qZm4110xGTzg1+th2td34sNn7y93waDnRsw7ju3/C0X2SG909IBDR3rPJdGyr5tvxhSA==
X-Received: by 2002:a24:1dd5:: with SMTP id 204mr16517482itj.180.1560192909650;
        Mon, 10 Jun 2019 11:55:09 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id d7sm3581954iob.67.2019.06.10.11.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:55:09 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date:   Mon, 10 Jun 2019 12:53:53 -0600
Message-Id: <20190610185354.35310-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
References: <20190610185354.35310-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The value is referring to SDHCI_HOST_CONTROL, not SDHCI_CTRL_DMA_MASK.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

