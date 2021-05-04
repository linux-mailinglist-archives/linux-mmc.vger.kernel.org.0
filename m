Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24662372DC3
	for <lists+linux-mmc@lfdr.de>; Tue,  4 May 2021 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhEDQOQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 May 2021 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhEDQN5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:13:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43DC06134A
        for <linux-mmc@vger.kernel.org>; Tue,  4 May 2021 09:12:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y9so6839313ljn.6
        for <linux-mmc@vger.kernel.org>; Tue, 04 May 2021 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyxXmo/h/dfhEx4WikBIp+kaYZCmt7Npv/WLTwwg9eE=;
        b=B/8bDkEWNw9lcVCx0PtUoNt7PqWM7Aqe72ivfqWbaPh/eRdVEWPCMbeBiURN09vtPv
         eaLYG1oyLwLPVMdxeXNeKPyW05JULHoQwN3dH6snp0j1X19uxyrqUwx6HaVGZBoMD9xu
         nFmncr3Kqjzwlcv+yI2wJkwzznLVr11iLd/je9Z99ASGJ4voNXdXTYGdTFevulbCj1z9
         fxiI3xiIaZktMJ9K2TUEi7421g/Zer+60ExIyh+lQH5B/govXJXoc51+OAFt02P/PtUW
         j5NIOgCMyKbHK7fcgHnLaMOdwTCSqJnuHfZCe/mKb19n8PFe4YugrbhJVmK8W6qWGXBN
         iS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyxXmo/h/dfhEx4WikBIp+kaYZCmt7Npv/WLTwwg9eE=;
        b=VTEnde/HHRD21NTDXg53u294tbECFeDN8S/MERGuyYRlxeb+V8tB+8H4D8tJN5vj31
         yOmHmRQdeRO14tCsmNbtRuBnGtWxK6KsIbzsjUBsNvtuslvvuIk9pjCkyx1yTbdB8HcU
         F54RbaV38mbL/9dc/r2uck61FHdT+ameSO7Wf8gzIKshXaPy+nOds+06XsyGDponDZH5
         eWFsatdClMO+oso3H9zcJk18Wb6855i0uOP7JbhDwMznlp6N4gOIoRAIo4jKL/Kvf4h8
         UMYxKapMwEcAsHt9LZ+r0PwEVp3fs2PgSKiJOQw1/Rc957SBHVn2mYcMZzLSCeJ70vmP
         48gg==
X-Gm-Message-State: AOAM531/vlivmw5N9p2NQAyrlVoDwZo0/xhNlmqGUp/7QN6E8ZK+3AA4
        f5EsGnn1xDqP2o2jaPls8HckE1tTr+6iHF/Y
X-Google-Smtp-Source: ABdhPJzDqhFP0LwJ32oqCrgAn+o3dx2QbgOiI/z/xlyYdNewtvYHfnYoBbUK3lz6+2cgvEPXHgckJA==
X-Received: by 2002:a2e:a544:: with SMTP id e4mr18016480ljn.452.1620144774558;
        Tue, 04 May 2021 09:12:54 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mmc: core: Add support for Power Off Notification for SD cards
Date:   Tue,  4 May 2021 18:12:22 +0200
Message-Id: <20210504161222.101536-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rather than only deselecting the SD card via a CMD7, before we cut power to
it at system suspend, at runtime suspend or at shutdown, let's add support
for a graceful power off sequence via enabling the SD Power Off
Notification feature.

Note that, the Power Off Notification feature was added in the SD spec
v4.x, which is several years ago. However, it's still a bit unclear how
often the SD card vendors decides to implement support for it. To validate
these changes a Sandisk Extreme PRO A2 64GB has been used, which seems to
work nicely.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c  | 136 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/sd.h |   1 +
 2 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 702d7c1a0aec..760aa86bd54d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -66,6 +66,13 @@ static const unsigned int sd_au_size[] = {
 		__res & __mask;						\
 	})
 
+#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
+
+struct sd_busy_data {
+	struct mmc_card *card;
+	u8 *reg_buf;
+};
+
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
@@ -996,6 +1003,66 @@ static bool mmc_sd_card_using_v18(struct mmc_card *card)
 	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
 }
 
+static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8 page, u16 offset,
+			    u8 reg_data)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+	u8 *reg_buf;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	/*
+	 * Arguments of CMD49:
+	 * [31:31] MIO (0 = memory).
+	 * [30:27] FNO (function number).
+	 * [26:26] MW - mask write mode (0 = disable).
+	 * [25:18] page number.
+	 * [17:9] offset address.
+	 * [8:0] length (0 = 1 byte).
+	 */
+	cmd.arg = fno << 27 | page << 18 | offset << 9;
+
+	/* The first byte in the buffer is the data to be written. */
+	reg_buf[0] = reg_data;
+
+	data.flags = MMC_DATA_WRITE;
+	data.blksz = 512;
+	data.blocks = 1;
+	data.sg = &sg;
+	data.sg_len = 1;
+	sg_init_one(&sg, reg_buf, 512);
+
+	cmd.opcode = SD_WRITE_EXTR_SINGLE;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	mmc_set_data_timeout(&data, card);
+	mmc_wait_for_req(host, &mrq);
+
+	kfree(reg_buf);
+
+	/*
+	 * Note that, the SD card is allowed to signal busy on DAT0 up to 1s
+	 * after the CMD49. Although, let's leave this to be managed by the
+	 * caller.
+	 */
+
+	if (cmd.error)
+		return cmd.error;
+	if (data.error)
+		return data.error;
+
+	return 0;
+}
+
 static int sd_read_ext_reg(struct mmc_card *card, u8 fno, u8 page,
 			   u16 offset, u16 len, u8 *reg_buf)
 {
@@ -1446,21 +1513,84 @@ static void mmc_sd_detect(struct mmc_host *host)
 	}
 }
 
+static int sd_can_poweroff_notify(struct mmc_card *card)
+{
+	return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
+}
+
+static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
+{
+	struct sd_busy_data *data = cb_data;
+	struct mmc_card *card = data->card;
+	int err;
+
+	/*
+	 * Read the status register for the power management function. It's at
+	 * one byte offset and is one byte long. The Power Off Notification
+	 * Ready is bit 0.
+	 */
+	err = sd_read_ext_reg(card, card->ext_power.fno, card->ext_power.page,
+			      card->ext_power.offset + 1, 1, data->reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading status reg of PM func\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+
+	*busy = !(data->reg_buf[0] & 0x1);
+	return 0;
+}
+
+static int sd_poweroff_notify(struct mmc_card *card)
+{
+	struct sd_busy_data cb_data;
+	u8 *reg_buf;
+	int err;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/*
+	 * Set the Power Off Notification bit in the power management settings
+	 * register at 2 bytes offset.
+	 */
+	err = sd_write_ext_reg(card, card->ext_power.fno, card->ext_power.page,
+			       card->ext_power.offset + 2, 0x1);
+	if (err) {
+		pr_warn("%s: error %d writing Power Off Notify bit\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	cb_data.card = card;
+	cb_data.reg_buf = reg_buf;
+	err = __mmc_poll_for_busy(card, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
+				  &sd_busy_poweroff_notify_cb, &cb_data);
+
+out:
+	kfree(reg_buf);
+	return err;
+}
+
 static int _mmc_sd_suspend(struct mmc_host *host)
 {
+	struct mmc_card *card = host->card;
 	int err = 0;
 
 	mmc_claim_host(host);
 
-	if (mmc_card_suspended(host->card))
+	if (mmc_card_suspended(card))
 		goto out;
 
-	if (!mmc_host_is_spi(host))
+	if (sd_can_poweroff_notify(card))
+		err = sd_poweroff_notify(card);
+	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 
 	if (!err) {
 		mmc_power_off(host);
-		mmc_card_set_suspended(host->card);
+		mmc_card_set_suspended(card);
 	}
 
 out:
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 43bfc5c39ad4..6727576a8755 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -31,6 +31,7 @@
 
   /* class 11 */
 #define SD_READ_EXTR_SINGLE      48   /* adtc [31:0]             R1  */
+#define SD_WRITE_EXTR_SINGLE     49   /* adtc [31:0]             R1  */
 
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
-- 
2.25.1

