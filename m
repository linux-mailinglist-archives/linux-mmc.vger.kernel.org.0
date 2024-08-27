Return-Path: <linux-mmc+bounces-3548-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA0960A1A
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2024 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23A51F21223
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2024 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904071B29D5;
	Tue, 27 Aug 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kd+06baz"
X-Original-To: linux-mmc@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E51B3F33
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761564; cv=none; b=oG6hZ7OVOJmNyAT5gh6mQLKiuSmzabWUBN66yWkkZ9XiSY+yob8C51RNnhbKh74f35WoJoApz+8VLmTUoLfLrrc2eZZKYBSHiGEIG9oED5JHnCX5ZzEQDZFVvweaa3uIFW30L8T0hn8gwTlw4fmzb4i/FMtwxhCHUlfMk0nWjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761564; c=relaxed/simple;
	bh=rLk22sRGccB3KUKwz+2I87l5+mNkveFfoXrTJFrpWgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvEdTj2DkA4aVyxPGsDf7BLmvV14PjUn4n+DisEEQtxRsAjx0EWZXxrWQniI/QEYr3PBG4oCU/i4sbfzcEEoBjnHkdrCEuJnDJMq5sAn3L+2goDe8wuFESOR5O+k9TVDof2tfMliwAoZSt9LhGnhOay1zuyNjsbWGzfXEzQEz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kd+06baz; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761562; x=1756297562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rLk22sRGccB3KUKwz+2I87l5+mNkveFfoXrTJFrpWgs=;
  b=Kd+06bazgxnf54cdpG2gdcmDYiJ5yE350si3H4eEWPU+C97RRQjGNKwb
   +iSjfybgfMpnMXPHXhaoJ7Oj8iZ2cu2h3RCe7oYKWwCM3vFx4hSPNZvVC
   e+oLP1Vw14fuSsnbvQPCUqxlqR4bh6s6VHWPWzFKnx3F52Gi1BtXi0Qyt
   mOi+oFkeuupS223zb45S4eWkqNJDNIJlSfPoj98mivobkCDb4UxBwQrDf
   n1qhxaEBL0SmQryxSIKBTQ2REUVyOLKr9XRneKXh8887ygO1ZqX20Afsv
   1wVMLthdCtd4WmIjwXp/MADHG2EFzUZVzOaVCNuywvYSrFNlvbC8Sw70T
   A==;
X-CSE-ConnectionGUID: 0EGnSVfFTEy7h0/qm9JSGA==
X-CSE-MsgGUID: M7IaJyi/QOKmz+7vjFFNfQ==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="24660678"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:26:01 +0800
IronPort-SDR: 66cdb7c6_4fYeP9JLP+XNqPUO3ZZxMKC9LCB8GWm5rFtwZBIaYCGiabo
 7/NO4NuveZjxko8n4vSHCHvSQM2ILxTN/v8qMXA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:25:58 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:59 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 5/9] mmc: core: Allow mmc erase to carry large addresses
Date: Tue, 27 Aug 2024 15:23:38 +0300
Message-Id: <20240827122342.3314173-6-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing for SDUC, Allow the erase address to be larger beyond a 32 bit
address.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c |  6 ++++--
 drivers/mmc/core/core.c  | 33 ++++++++++++++++++---------------
 drivers/mmc/core/core.h  | 16 ++++++++++++----
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 713b22eced72..0484d7031c0c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1154,7 +1154,8 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr;
+	unsigned int nr;
+	sector_t from;
 	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1209,7 +1210,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int nr, arg;
+	sector_t from;
 	int err = 0, type = MMC_BLK_SECDISCARD;
 	blk_status_t status = BLK_STS_OK;
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..349e5c578da5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1598,8 +1598,8 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
 		return mmc_mmc_erase_timeout(card, arg, qty);
 }
 
-static int mmc_do_erase(struct mmc_card *card, unsigned int from,
-			unsigned int to, unsigned int arg)
+static int mmc_do_erase(struct mmc_card *card, sector_t from,
+			sector_t to, unsigned int arg)
 {
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
@@ -1630,8 +1630,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	else if (mmc_card_sd(card))
 		qty += to - from + 1;
 	else
-		qty += ((to / card->erase_size) -
-			(from / card->erase_size)) + 1;
+		qty += (mmc_sector_div(to, card->erase_size) -
+			mmc_sector_div(from, card->erase_size)) + 1;
 
 	if (!mmc_card_blockaddr(card)) {
 		from <<= 9;
@@ -1700,18 +1700,19 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 }
 
 static unsigned int mmc_align_erase_size(struct mmc_card *card,
-					 unsigned int *from,
-					 unsigned int *to,
+					 sector_t *from,
+					 sector_t *to,
 					 unsigned int nr)
 {
-	unsigned int from_new = *from, nr_new = nr, rem;
+	sector_t from_new = *from;
+	unsigned int nr_new = nr, rem;
 
 	/*
 	 * When the 'card->erase_size' is power of 2, we can use round_up/down()
 	 * to align the erase size efficiently.
 	 */
 	if (is_power_of_2(card->erase_size)) {
-		unsigned int temp = from_new;
+		sector_t temp = from_new;
 
 		from_new = round_up(temp, card->erase_size);
 		rem = from_new - temp;
@@ -1723,7 +1724,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
 
 		nr_new = round_down(nr_new, card->erase_size);
 	} else {
-		rem = from_new % card->erase_size;
+		rem = mmc_sector_mod(from_new, card->erase_size);
 		if (rem) {
 			rem = card->erase_size - rem;
 			from_new += rem;
@@ -1756,10 +1757,12 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  *
  * Caller must claim host before calling this function.
  */
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr,
 	      unsigned int arg)
 {
-	unsigned int rem, to = from + nr;
+	unsigned int rem;
+	sector_t to = from + nr;
+
 	int err;
 
 	if (!(card->csd.cmdclass & CCC_ERASE))
@@ -1780,7 +1783,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		return -EOPNOTSUPP;
 
 	if (arg == MMC_SECURE_ERASE_ARG) {
-		if (from % card->erase_size || nr % card->erase_size)
+		if (mmc_sector_mod(from, card->erase_size) || nr % card->erase_size)
 			return -EINVAL;
 	}
 
@@ -1804,7 +1807,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	 * and call mmc_do_erase() twice if necessary. This special case is
 	 * identified by the card->eg_boundary flag.
 	 */
-	rem = card->erase_size - (from % card->erase_size);
+	rem = card->erase_size - mmc_sector_mod(from, card->erase_size);
 	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr > rem) {
 		err = mmc_do_erase(card, from, from + rem - 1, arg);
 		from += rem;
@@ -1863,12 +1866,12 @@ int mmc_can_secure_erase_trim(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_secure_erase_trim);
 
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
+int mmc_erase_group_aligned(struct mmc_card *card, sector_t from,
 			    unsigned int nr)
 {
 	if (!card->erase_size)
 		return 0;
-	if (from % card->erase_size || nr % card->erase_size)
+	if (mmc_sector_mod(from, card->erase_size) || nr % card->erase_size)
 		return 0;
 	return 1;
 }
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 37091a6589ed..fc9d5e9620b1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -116,15 +116,13 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
-		unsigned int arg);
+int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 int mmc_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
-			unsigned int nr);
+int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
@@ -199,4 +197,14 @@ static inline int mmc_flush_cache(struct mmc_host *host)
 	return 0;
 }
 
+static inline unsigned int mmc_sector_div(sector_t dividend, u32 divisor)
+{
+	return div_u64(dividend, divisor);
+}
+
+static inline unsigned int mmc_sector_mod(sector_t dividend, u32 divisor)
+{
+	return sector_div(dividend, divisor);
+}
+
 #endif
-- 
2.25.1


