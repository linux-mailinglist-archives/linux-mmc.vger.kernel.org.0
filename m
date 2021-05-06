Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4539E37560B
	for <lists+linux-mmc@lfdr.de>; Thu,  6 May 2021 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhEFO7l (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 6 May 2021 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhEFO7l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 10:59:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E69C061574
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 07:58:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p12so7456210ljg.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82Mp/+3WiDiX0+TFdKaDBvNV5KTPMZG8BPbOyDcjQEo=;
        b=Hfeq2mPTtjJcg4XLGumY1HeGkmZp7vTnsf8ptjdjVyfbfVoChqCpfWdWAyyc10l/lX
         TxSSni46a86kKQc2v8mfXyUBFob+vdfUhDWwERSIJE5KgN5oHMzx/YlCfCOC7PXmtDGv
         liwv/n2QfLNI+MWE+6kg38Y52VyiBBuNVfN3LlRnFDSPyhiviDbH+xI7ykeXFDB04an7
         QH8Cdy+e3hpOaMO9WV2pPSzXedbnlr/rvNKW1gg1ZLKzMnHj1XZf8BXJXFSYqH8enxmu
         Duj7IlwYWRP41oAUyJJ0m7KYsIGYGZlLsYNqKMIOWYuANq2QpVMgbo307MZN72Xl1XUs
         heEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82Mp/+3WiDiX0+TFdKaDBvNV5KTPMZG8BPbOyDcjQEo=;
        b=YHkNFaHKaHhYy90JsyJR2TQ8/C6VxHHCBvmhh058FrY8AhlrjfNijsX5xsnmbJ/XpZ
         PKXzdkyICk4g7khurm5R9ZjJhew0yUwWMySBn7NGH5O/aw22PnG/yXUvBMuIBg9iMsjD
         rsZC+5bpji0u2uM8lxgq5YuYxxVObfHG73xwmGbDqfVAvuYmSwUBTGzKfy6A1Zvmn4CR
         O0CGwLHLzYYQLR36zaEAQ9jzk42I0aEkAi3REhDKaMbfC/Dgh0QxRKDRbxckZKjFKmIJ
         jqSediueTq0H+YD0/o1jFjvKEAi5ADoXbvsN4Vb6dpyY0MW5hgL1qnTXCYB5Yh+5dhts
         MbDw==
X-Gm-Message-State: AOAM532p608fhR6zlPyLa25pOYzeqaTbtw2UOXFnUzTaIf11Kk5JPIQ/
        eMZLLcmPNY8d3GKpYug4SvteRbsysRMz3gDZ
X-Google-Smtp-Source: ABdhPJydchd1pmp2rGfbHH/jeQdqsrTGtFFsDh++WDcg8vT9ARXlabU2aXYLJVWd+CZNAnOqlqk/FQ==
X-Received: by 2002:a2e:9f49:: with SMTP id v9mr3688514ljk.44.1620313120233;
        Thu, 06 May 2021 07:58:40 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g24sm968774ljl.44.2021.05.06.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:58:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
Date:   Thu,  6 May 2021 16:58:29 +0200
Message-Id: <20210506145829.198823-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506145829.198823-1-ulf.hansson@linaro.org>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In SD spec v6.x the SD function extension registers for performance
enhancements were introduced. As a part of this an optional internal cache
on the SD card, can be used to improve performance.

The let the SD card use the cache, the host needs to enable it and manage
flushing of the cache, so let's add support for this.

Note that for an SD card supporting the cache it's mandatory for it, to
also support the poweroff notification feature. According to the SD spec,
if the cache has been enabled and a poweroff notification is sent to the
card, that implicitly also means that the card should flush its internal
cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
requests is sufficient.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c |  1 +
 drivers/mmc/core/mmc_ops.h |  1 +
 drivers/mmc/core/sd.c      | 98 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |  1 +
 4 files changed, 101 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index af423acc4c88..3c58f6d0f482 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -456,6 +456,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 		err = R1_STATUS(status) ? -EIO : 0;
 		break;
 	case MMC_BUSY_HPI:
+	case MMC_BUSY_EXTR_SINGLE:
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index c3c1d9c2577e..41ab4f573a31 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@ enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
 	MMC_BUSY_ERASE,
 	MMC_BUSY_HPI,
+	MMC_BUSY_EXTR_SINGLE,
 };
 
 struct mmc_host;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 760aa86bd54d..773444853607 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -67,6 +67,7 @@ static const unsigned int sd_au_size[] = {
 	})
 
 #define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
+#define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
 
 struct sd_busy_data {
 	struct mmc_card *card;
@@ -1287,6 +1288,94 @@ static int sd_read_ext_regs(struct mmc_card *card)
 	return err;
 }
 
+static bool sd_cache_enabled(struct mmc_host *host)
+{
+	return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
+}
+
+static int sd_flush_cache(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u8 *reg_buf, fno, page;
+	u16 offset;
+	int err;
+
+	if (!sd_cache_enabled(host))
+		return 0;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/*
+	 * Set the Flush Cache bit in the performance enhancement register at
+	 * 261 bytes offset.
+	 */
+	fno = card->ext_perf.fno;
+	page = card->ext_perf.page;
+	offset = card->ext_perf.offset + 261;
+
+	err = sd_write_ext_reg(card, fno, page, offset, 0x1);
+	if (err) {
+		pr_warn("%s: error %d writing Cache Flush bit\n",
+			mmc_hostname(host), err);
+		goto out;
+	}
+
+	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
+				MMC_BUSY_EXTR_SINGLE);
+	if (err)
+		goto out;
+
+	/*
+	 * Read the Flush Cache bit. The card shall reset it, to confirm that
+	 * it's has completed the flushing of the cache.
+	 */
+	err = sd_read_ext_reg(card, fno, page, offset, 1, reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading Cache Flush bit\n",
+			mmc_hostname(host), err);
+		goto out;
+	}
+
+	if (reg_buf[0] & 0x1)
+		err = -ETIMEDOUT;
+out:
+	kfree(reg_buf);
+	return err;
+}
+
+static int sd_enable_cache(struct mmc_card *card)
+{
+	u8 *reg_buf;
+	int err;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/*
+	 * Set the Cache Enable bit in the performance enhancement register at
+	 * 260 bytes offset.
+	 */
+	err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
+			       card->ext_perf.offset + 260, 0x1);
+	if (err) {
+		pr_warn("%s: error %d writing Cache Enable bit\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
+				MMC_BUSY_EXTR_SINGLE);
+	if (!err)
+		card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
+
+out:
+	kfree(reg_buf);
+	return err;
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -1442,6 +1531,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	/* Enable internal SD cache if supported. */
+	if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
+		err = sd_enable_cache(card);
+		if (err)
+			goto free_card;
+	}
+
 	if (host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
@@ -1694,6 +1790,8 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 	.hw_reset = mmc_sd_hw_reset,
+	.cache_enabled = sd_cache_enabled,
+	.flush_cache = sd_flush_cache,
 };
 
 /*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2867af0635f8..74e6c0624d27 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -196,6 +196,7 @@ struct sd_ext_reg {
 	u8			page;
 	u16			offset;
 	u8			rev;
+	u8			feature_enabled;
 	u8			feature_support;
 /* Power Management Function. */
 #define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
-- 
2.25.1

