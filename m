Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B4736136
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jun 2023 03:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFTBkO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Jun 2023 21:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTBkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 21:40:13 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933A9124
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 18:40:11 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6109B846E6;
        Tue, 20 Jun 2023 03:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687225209;
        bh=mGFylNXmBgS3Ansdp/xJADFx5JACPSvHXx1so6QPs08=;
        h=From:To:Cc:Subject:Date:From;
        b=uhZFOYU+BDEiJ847MsQSCYsSXWP765JBjjv32DTxtzR5JTcxgD/YS9deJgZygV2YV
         D/98MOT2Kxa6LmwENNzxPfZ+YIdLopM+BBwFckShQdzdb6mYdyonV9NlivE/IftBtU
         GqNDqd1Ztjg7lFFji7Fx9AM4oPRJvXetPBS0P8qhbGoGJkPXnMMe0z37PxGXzaBAbV
         uQltceHcMtSeAvW8IbpgbDPR4ppQOZw6zcmcjS8DyC5T5sT0h+GW+A+fDGZR6TH6Pv
         IkOBveLTEj9tjcMI722UcgVufyp20SYmyEBUh9oogu4JJ/WCPh5EdqvTT8TDneVj7v
         BIxOPYtq8nerQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Brian Norris <briannorris@chromium.org>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Liang He <windhl@126.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Xander Li <xander_li@kingston.com.tw>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019
Date:   Tue, 20 Jun 2023 03:39:56 +0200
Message-Id: <20230620013956.111275-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This microSD card never clears Flush Cache bit after cache flush has
been started in sd_flush_cache(). This leads e.g. to failure to mount
file system. Add a quirk which disables the SD cache for this specific
card from specific manufacturing date of 11/2019, since on newer dated
cards from 05/2023 the cache flush works correctly.

Fixes: 08ebf903af57 ("mmc: core: Fixup support for writeback-cache for eMMC and SD")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Brian Norris <briannorris@chromium.org>
Cc: ChanWoo Lee <cw9316.lee@samsung.com>
Cc: Liang He <windhl@126.com>
Cc: Seunghui Lee <sh043.lee@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Xander Li <xander_li@kingston.com.tw>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/card.h   | 30 +++++++++++++++++++++++-------
 drivers/mmc/core/quirks.h | 13 +++++++++++++
 drivers/mmc/core/sd.c     |  7 ++++++-
 include/linux/mmc/card.h  |  1 +
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index cfdd1ff40b865..4edf9057fa79d 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -53,6 +53,10 @@ struct mmc_fixup {
 	unsigned int manfid;
 	unsigned short oemid;
 
+	/* Manufacturing date */
+	unsigned short year;
+	unsigned char month;
+
 	/* SDIO-specific fields. You can use SDIO_ANY_ID here of course */
 	u16 cis_vendor, cis_device;
 
@@ -68,6 +72,8 @@ struct mmc_fixup {
 
 #define CID_MANFID_ANY (-1u)
 #define CID_OEMID_ANY ((unsigned short) -1)
+#define CID_YEAR_ANY ((unsigned short) -1)
+#define CID_MONTH_ANY ((unsigned char) -1)
 #define CID_NAME_ANY (NULL)
 
 #define EXT_CSD_REV_ANY (-1u)
@@ -81,17 +87,21 @@ struct mmc_fixup {
 #define CID_MANFID_APACER       0x27
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
+#define CID_MANFID_KINGSTON_SD	0x9F
 #define CID_MANFID_NUMONYX	0xFE
 
 #define END_FIXUP { NULL }
 
-#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
-		   _cis_vendor, _cis_device,				\
-		   _fixup, _data, _ext_csd_rev)				\
+#define _FIXUP_EXT(_name, _manfid, _oemid, _year, _month,	\
+		   _rev_start, _rev_end,			\
+		   _cis_vendor, _cis_device,			\
+		   _fixup, _data, _ext_csd_rev)			\
 	{						\
 		.name = (_name),			\
 		.manfid = (_manfid),			\
 		.oemid = (_oemid),			\
+		.year = (_year),			\
+		.month = (_month),			\
 		.rev_start = (_rev_start),		\
 		.rev_end = (_rev_end),			\
 		.cis_vendor = (_cis_vendor),		\
@@ -103,8 +113,8 @@ struct mmc_fixup {
 
 #define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
 		      _fixup, _data, _ext_csd_rev)			\
-	_FIXUP_EXT(_name, _manfid,					\
-		   _oemid, _rev_start, _rev_end,			\
+	_FIXUP_EXT(_name, _manfid, _oemid, CID_YEAR_ANY, CID_MONTH_ANY,	\
+		   _rev_start, _rev_end,				\
 		   SDIO_ANY_ID, SDIO_ANY_ID,				\
 		   _fixup, _data, _ext_csd_rev)				\
 
@@ -118,8 +128,9 @@ struct mmc_fixup {
 		      _ext_csd_rev)
 
 #define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
-	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
-		    CID_OEMID_ANY, 0, -1ull,				\
+	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY, CID_OEMID_ANY,		\
+		   CID_YEAR_ANY, CID_MONTH_ANY,				\
+		   0, -1ull,						\
 		   _vendor, _device,					\
 		   _fixup, _data, EXT_CSD_REV_ANY)			\
 
@@ -264,4 +275,9 @@ static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
 }
 
+static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 29b9497936df9..bf7fb72ab8b57 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -100,6 +100,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
+	 * This has so far only been observed on cards from 11/2019, while new
+	 * cards from 2023/05 do not exhibit this behavior.
+	 */
+	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
+
 	/*
 	 * Some SD cards reports discard support while they don't
 	 */
@@ -209,6 +218,10 @@ static inline void mmc_fixup_device(struct mmc_card *card,
 		if (f->of_compatible &&
 		    !mmc_fixup_of_compatible_match(card, f->of_compatible))
 			continue;
+		if (f->year != CID_YEAR_ANY && f->year != card->cid.year)
+			continue;
+		if (f->month != CID_MONTH_ANY && f->month != card->cid.month)
+			continue;
 
 		dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
 		f->vendor_fixup(card, f->data);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 72b664ed90cf6..99ff6e754017a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1170,7 +1170,7 @@ static int sd_parse_ext_reg_perf(struct mmc_card *card, u8 fno, u8 page,
 		card->ext_perf.feature_support |= SD_EXT_PERF_HOST_MAINT;
 
 	/* Cache support at bit 0. */
-	if (reg_buf[4] & BIT(0))
+	if ((reg_buf[4] & BIT(0)) && !mmc_card_broken_sd_cache(card))
 		card->ext_perf.feature_support |= SD_EXT_PERF_CACHE;
 
 	/* Command queue support indicated via queue depth bits (0 to 4). */
@@ -1306,6 +1306,8 @@ static int sd_read_ext_regs(struct mmc_card *card)
 
 static bool sd_cache_enabled(struct mmc_host *host)
 {
+	if (mmc_card_broken_sd_cache(host->card))
+		return 0;
 	return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
 }
 
@@ -1366,6 +1368,9 @@ static int sd_enable_cache(struct mmc_card *card)
 	u8 *reg_buf;
 	int err;
 
+	if (mmc_card_broken_sd_cache(card))
+		return 0;
+
 	card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
 
 	reg_buf = kzalloc(512, GFP_KERNEL);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c726ea7812552..daa2f40d9ce65 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -294,6 +294,7 @@ struct mmc_card {
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
+#define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.39.2

