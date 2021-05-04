Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F05A372DBE
	for <lists+linux-mmc@lfdr.de>; Tue,  4 May 2021 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhEDQOM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 May 2021 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEDQNy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:13:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1ADC06138A
        for <linux-mmc@vger.kernel.org>; Tue,  4 May 2021 09:12:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x19so14127816lfa.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 May 2021 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TugmmnMP6RDSPp2L8UfvdmsSklrTobWCwgxHv2Rsq4s=;
        b=x7LwYTyyiO5EtiSTP/BPjhP9eQrFZqFYpQLS2CmnQjKkQZw4od7tGy8UXuFTWYv1LQ
         1Axih3agolSFgjjMtieA8LhbmKveLqqkx5XbcK+qoBgaBQB8Km0sjqPpvYzXMF9aHi2f
         JhAqdotYH9n0s1TDaRyNsaE8b/1ATss11DSsIgcD26G4DjKvY2baR2fT9odGyuA6LTcl
         340q7sfFGMR7IgOHASR52aooO9vkXQOFFBJY61X/SRRV6toD1cPUn5AVW9Pe7pzT1rTW
         jXcUO9592B8NdUvOJ0SUPZVCNjvtKn+MYADQ62S3NIHlCRxN472YCmfEQRyefBJqiy5M
         F47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TugmmnMP6RDSPp2L8UfvdmsSklrTobWCwgxHv2Rsq4s=;
        b=lh88ulsuZ6O5gQHcHb0r7xG6hbOEJrY3qPAcxE2Lgr+jl599RhI87DeqyfXL0eHLtO
         VKkMUFvCwG0DLcmq6Vz3B3PuV0rc7hskBLtqRTm73mPCRjFH/UAGnAMbTv3ZQ1EpqODr
         sWIzQ0gJSLFHbPXxoN9NbAe5HAw4TvOhdO8ZPujxhWe3p0J2AmA6BLye+FEfoLyefKtj
         kYcKC0VBIqecSmb0+glZamrVy9Q1hAHAsd41OkCYn+hMN5QH9ni1W+/zlOKGKjMTuOxG
         UYaf4sGo7rqMZ4VivZXL/YxtZQ6zcZlPsasrC4rcMk56diWTqchLMii2nwe1vR8vftvm
         2myA==
X-Gm-Message-State: AOAM531ARED+PCIDRUSna316V+dOOm8wuIgX84mwmO8205VjW8qOkAMP
        A4HMdaou1IMRaO7tveSKKeV55YRybKk9tDe9
X-Google-Smtp-Source: ABdhPJwRcHKF0j+XAEQinX49FLpArbd5Qu9pJndUnwAUxs9SZ+chNoCiFzzPoZIAt3hnQZ4HTmyIXw==
X-Received: by 2002:a19:48d3:: with SMTP id v202mr15024111lfa.315.1620144772586;
        Tue, 04 May 2021 09:12:52 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] mmc: core: Read performance enhancements registers for SD cards
Date:   Tue,  4 May 2021 18:12:21 +0200
Message-Id: <20210504161222.101536-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In SD spec v6.x the SD function extension registers for performance
enhancements were introduced. These registers let the SD card announce
supports for various performance related features, like "self-maintenance",
"cache" and "command queuing".

Let's extend the parsing of SD function extension registers and store the
information in the struct mmc_card. This prepares for subsequent changes to
implement the complete support for new the performance enhancement
features.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  7 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cb5e8b2fc32f..702d7c1a0aec 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1058,6 +1058,55 @@ static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
 	return err;
 }
 
+static int sd_parse_ext_reg_perf(struct mmc_card *card, u8 fno, u8 page,
+				 u16 offset)
+{
+	int err;
+	u8 *reg_buf;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	err = sd_read_ext_reg(card, fno, page, offset, 512, reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading PERF func of ext reg\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	/* PERF revision. */
+	card->ext_perf.rev = reg_buf[0];
+
+	/* FX_EVENT support at bit 0. */
+	if (reg_buf[1] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_FX_EVENT;
+
+	/* Card initiated self-maintenance support at bit 0. */
+	if (reg_buf[2] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CARD_MAINT;
+
+	/* Host initiated self-maintenance support at bit 1. */
+	if (reg_buf[2] & 0x2)
+		card->ext_perf.feature_support |= SD_EXT_PERF_HOST_MAINT;
+
+	/* Cache support at bit 0. */
+	if (reg_buf[4] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CACHE;
+
+	/* Command queue support indicated via queue depth bits (0 to 4). */
+	if (reg_buf[6] & 0x1f)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CMD_QUEUE;
+
+	card->ext_perf.fno = fno;
+	card->ext_perf.page = page;
+	card->ext_perf.offset = offset;
+
+out:
+	kfree(reg_buf);
+	return err;
+}
+
 static int sd_parse_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
 			    u16 *next_ext_addr)
 {
@@ -1102,6 +1151,10 @@ static int sd_parse_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
 	if (sfc == 0x1)
 		return sd_parse_ext_reg_power(card, fno, page, offset);
 
+	/* Standard Function Code for performance enhancement. */
+	if (sfc == 0x2)
+		return sd_parse_ext_reg_perf(card, fno, page, offset);
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 03a862e93594..2867af0635f8 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -201,6 +201,12 @@ struct sd_ext_reg {
 #define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
 #define SD_EXT_POWER_SUSTENANCE	(1<<1)
 #define SD_EXT_POWER_DOWN_MODE	(1<<2)
+/* Performance Enhancement Function. */
+#define SD_EXT_PERF_FX_EVENT	(1<<0)
+#define SD_EXT_PERF_CARD_MAINT	(1<<1)
+#define SD_EXT_PERF_HOST_MAINT	(1<<2)
+#define SD_EXT_PERF_CACHE	(1<<3)
+#define SD_EXT_PERF_CMD_QUEUE	(1<<4)
 };
 
 struct sdio_cccr {
@@ -305,6 +311,7 @@ struct mmc_card {
 	struct sd_ssr		ssr;		/* yet more SD information */
 	struct sd_switch_caps	sw_caps;	/* switch (CMD6) caps */
 	struct sd_ext_reg	ext_power;	/* SD extension reg for PM */
+	struct sd_ext_reg	ext_perf;	/* SD extension reg for PERF */
 
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
 	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
-- 
2.25.1

