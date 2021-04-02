Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE735289E
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Apr 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhDBJYo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Apr 2021 05:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhDBJYn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 05:24:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACD2C0613E6;
        Fri,  2 Apr 2021 02:24:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h13so4863694eds.5;
        Fri, 02 Apr 2021 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smSLIWgrt6LaAWdFlFKcCtxvqHy+yybtDXpMF0l7jLs=;
        b=GEBTOZl7SQok09JWekPVeHl0QIx9T7hcP85fDZrxwgqKWzXtINf0ICSYW1nzLAJNAX
         bKYArkNplHRGa5U3rZ6TgJyZwaqdw8Ou0WF4Sokz8zdM2JvcynySrI1A7uWupR4+0rP/
         ZxSqhpmYn7woS4cTxXw7GlxB+Z0tYiu4ILUnrP4k75RRhj0pBIxnnnwuhd+2LM9aTny0
         pgNrNziTTWymuAeQJnZu/CAABTINxLQnpI/ND7pQV+JHhK/6P7ExW3MGo8fKoW04axh8
         Kawf7DK4aInO9hJb09iaPKg04Fgwd4ZJrs6b7yHfvNER/6e3Vy0R863iAb5f0WMLX53v
         KF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smSLIWgrt6LaAWdFlFKcCtxvqHy+yybtDXpMF0l7jLs=;
        b=LtW9jbLzo28JnU346C4r0XJLhtiRHq9ATTAvlYYK1ogYi04Eebr+MjpcMoN15NmVMo
         DGJu17VXbPC49yZPtiPlp+byGBGa9FNlY7HknSKgVa9usIQcJCkDWF+IE74gbW6BxqyG
         nOvJf+UNUTiEaw44UPARxLIWHSBHBGREit1its2GxT9CJU8y0a0iC0jXPdjZrRNx9mM1
         EAgoHFYfeOkHMYa6apJYgKpbJ/M69C8QncaPVG/39rKv8WiRvWnAJbDlynm9jyjUKGGd
         bma70PyA6vja/5S8ek/KcXrlJ15vC+Lc9rCXIbz+SDAT401VYBuluKaCV/NmpQm8v67N
         dSJw==
X-Gm-Message-State: AOAM533/VMFPuULCPKdUt8FVzpakps6+VuMMJly2uv7C/25JJpIDnw02
        gtu8TFpxdLvEHUpog2Ms7cQ=
X-Google-Smtp-Source: ABdhPJyPx/fuGmjHfbQqK/PksVcVAnhJTyEDpEXMax11X2GS9DCp+Ir9H1m7IU+OuN+TIus5a3vvaA==
X-Received: by 2002:aa7:df14:: with SMTP id c20mr14530508edy.197.1617355481214;
        Fri, 02 Apr 2021 02:24:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id d16sm247990ejo.85.2021.04.02.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:24:41 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 2/2] mmc: core: Let sanitize not retry in case of timeout/failure
Date:   Fri,  2 Apr 2021 11:24:32 +0200
Message-Id: <20210402092432.25069-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402092432.25069-1-huobean@gmail.com>
References: <20210402092432.25069-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Not any commands need to retry in case of timeout/failure.
Currently, the sanitize command is issued by the IOCTL interface,
and once its timeouts, the user normally decides to retry or not .
Just blindly retry three times sanitize in the driver, it doesn't
help sanitize retry succeed in the end, on the contrary, it only
makes the user feel sanitize timeouts after 12 minutes.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c   | 13 +++++++----
 drivers/mmc/core/mmc.c     | 47 ++++++++++++++++++++++----------------
 drivers/mmc/core/mmc_ops.c | 19 +++++++--------
 drivers/mmc/core/mmc_ops.h |  4 ++--
 4 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8bfd4d95b386..9778093d7006 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -836,7 +836,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_PART_CONFIG, part_config,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (ret) {
 			mmc_blk_part_switch_post(card, part_type);
 			return ret;
@@ -1007,7 +1007,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
 				 card->ext_csd.boot_ro_lock |
 				 EXT_CSD_BOOT_WP_B_PWR_WP_EN,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (ret)
 			pr_err("%s: Locking boot partition ro until next power on failed: %d\n",
 			       md->disk->disk_name, ret);
@@ -1058,7 +1058,8 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 					 card->erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
-					 card->ext_csd.generic_cmd6_time);
+					 card->ext_csd.generic_cmd6_time,
+					 MMC_CMD_RETRIES);
 		}
 		if (!err)
 			err = mmc_erase(card, from, nr, card->erase_arg);
@@ -1100,7 +1101,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				 arg == MMC_SECURE_TRIM1_ARG ?
 				 INAND_CMD38_ARG_SECTRIM1 :
 				 INAND_CMD38_ARG_SECERASE,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err)
 			goto out_retry;
 	}
@@ -1118,7 +1120,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
 					 INAND_CMD38_ARG_SECTRIM2,
-					 card->ext_csd.generic_cmd6_time);
+					 card->ext_csd.generic_cmd6_time,
+					 MMC_CMD_RETRIES);
 			if (err)
 				goto out_retry;
 		}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..fac6a0f768c1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -932,7 +932,8 @@ static int __mmc_select_powerclass(struct mmc_card *card,
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_CLASS,
 				 pwrclass_val,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 	}
 
 	return err;
@@ -1029,7 +1030,8 @@ static int mmc_select_bus_width(struct mmc_card *card)
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_BUS_WIDTH,
 				 ext_csd_bits[idx],
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err)
 			continue;
 
@@ -1068,7 +1070,7 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1100,7 +1102,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
 			   MMC_TIMING_MMC_DDR52,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1168,7 +1170,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1197,7 +1199,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 EXT_CSD_DDR_BUS_WIDTH_8,
-			 card->ext_csd.generic_cmd6_time);
+			 card->ext_csd.generic_cmd6_time,
+			 MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1210,7 +1213,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1256,7 +1259,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1272,7 +1275,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   0, false, true);
+			   0, false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1287,7 +1290,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1371,7 +1374,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1390,7 +1393,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 val,
-			 card->ext_csd.generic_cmd6_time);
+			 card->ext_csd.generic_cmd6_time, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1405,7 +1408,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1470,7 +1473,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time, 0,
-				   false, true);
+				   false, true, MMC_CMD_RETRIES);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
@@ -1698,7 +1701,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (card->ext_csd.rev >= 3) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_ERASE_GROUP_DEF, 1,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 
 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -1729,7 +1733,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONFIG,
 				 card->ext_csd.part_config,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 	}
@@ -1741,7 +1745,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_OFF_NOTIFICATION,
 				 EXT_CSD_POWER_ON,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -1801,7 +1806,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (card->ext_csd.hpi) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_HPI_MGMT, 1,
-				card->ext_csd.generic_cmd6_time);
+				card->ext_csd.generic_cmd6_time,
+				MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 		if (err) {
@@ -1825,7 +1831,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
+				EXT_CSD_CACHE_CTRL, 1, timeout_ms,
+				MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -1975,7 +1982,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, 0, false, false);
+			notify_type, timeout, 0, false, false, MMC_CMD_RETRIES);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ccca067db993..433034acbbe3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -532,12 +532,13 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@timing: new timing to change to
  *	@send_status: send status cmd to poll for busy
  *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
+ *	@retries: number of retries
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err)
+		bool send_status, bool retry_crc_err, unsigned int retries)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -563,7 +564,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
 	    (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
-
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 		  (index << 16) |
@@ -577,7 +577,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
 
-	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, retries);
 	if (err)
 		goto out;
 
@@ -609,10 +609,10 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms)
+		unsigned int timeout_ms, unsigned int retries)
 {
 	return __mmc_switch(card, set, index, value, timeout_ms, 0,
-			    true, false);
+			    true, false, retries);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
@@ -951,7 +951,8 @@ void mmc_run_bkops(struct mmc_card *card)
 	 * urgent levels by using an asynchronous background task, when idle.
 	 */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
+			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS,
+			 MMC_CMD_RETRIES);
 	if (err)
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
@@ -972,7 +973,7 @@ int mmc_flush_cache(struct mmc_card *card)
 			(card->ext_csd.cache_ctrl & 1)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
-				 MMC_CACHE_FLUSH_TIMEOUT_MS);
+				 MMC_CACHE_FLUSH_TIMEOUT_MS, MMC_CMD_RETRIES);
 		if (err)
 			pr_err("%s: cache flush error %d\n",
 					mmc_hostname(card->host), err);
@@ -991,7 +992,7 @@ static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 		return -EOPNOTSUPP;
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ_MODE_EN,
-			 val, card->ext_csd.generic_cmd6_time);
+			 val, card->ext_csd.generic_cmd6_time, MMC_CMD_RETRIES);
 	if (!err)
 		card->ext_csd.cmdq_en = enable;
 
@@ -1028,7 +1029,7 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	mmc_retune_hold(host);
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
-			 1, timeout_ms);
+			 1, timeout_ms, 0);
 	if (err)
 		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 1ed0d0375780..1d74017d32e8 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -39,9 +39,9 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err);
+		bool send_status, bool retry_crc_err, unsigned int retries);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms);
+		unsigned int timeout_ms, unsigned int retries);
 void mmc_run_bkops(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
-- 
2.25.1

