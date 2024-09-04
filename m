Return-Path: <linux-mmc+bounces-3702-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF996C159
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2024 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A98B1F260BA
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CAA1DC19C;
	Wed,  4 Sep 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T8QWD1Uk"
X-Original-To: linux-mmc@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3821DC07C
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461720; cv=none; b=l2pEzuqFmQdM5+IMLKCpOuze3nN+ETcC5XteB+D9ERCAFUoI27T9BXiT5+iIRQC0ZjZ92rLukn/p3HHS/4n1madUgdDjro9RHuaV3C1nUyg1Ij4NqRlniu/QtpqxMM/jPDu8BzTl7pafd6/4TvynU/4SC29J96mQiWy7jhYt5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461720; c=relaxed/simple;
	bh=n6mFPkbpt9/MmbyoZvr7mR9azOlTGUnWIgISnuOgMPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+En+isqI4oa3TMZJY9SQV57y6Ig+aRvW8zXD7YsccqYfoU6sq2ukNfnbqoVNo2pZx08pAKIKrleaeYb2GDgECA0Zjg5QIP88DzfD/7dALtISLdGv/mXssTeTIPLuH3Y3N7pA/mBHKgYlvFe/IcVpGg/xsqaDikYpaKUHdiMS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T8QWD1Uk; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461719; x=1756997719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n6mFPkbpt9/MmbyoZvr7mR9azOlTGUnWIgISnuOgMPw=;
  b=T8QWD1UkG0E5maxciM5iLyS0ggTuGKZGWv7IbQrAZCcFNXceIpEim+Yk
   OkiZZeT5RtdhKnGD/rlOF3+fS7AhgRXCu4WbimC5gybRYMxZlYraFiNTJ
   eCzY1E24+v2TeHT0zIPmG1fdKykfYiWrAvefRfVGUqrnM+mkXrdftb5jJ
   gWgvaJXjihzfdcWril4Pnf127dz/Wt73gtTgOw2OMzr+nnmx0JPG9t1GS
   JmFnB7qFBRm+LSqeNPmnajxP6pvB3iTgeak+YK+i3+/0a4ZceN+pcPna5
   9+dMBkAW5ytXhFfSQG09Q1NZvOGPdiF7ntOCw9pDj2SJ5BVmhPmZVx2tC
   Q==;
X-CSE-ConnectionGUID: yH4xL9fPTUeIhB50fjo+ng==
X-CSE-MsgGUID: 4ZIa23EaTZuQKm1J1ZoYMw==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26723686"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:12 +0800
IronPort-SDR: 66d866b3_GDghXbSV7vQO/avgeZYWH9ovWHgxFDJ/sYPE5hN9iwxRKZw
 0PUzHFs4X29T+xuurLBtwzDuXCJuYkqjXY7cvNA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 06:54:59 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:11 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 6/9] mmc: core: Add Ext memory addressing for erase
Date: Wed,  4 Sep 2024 17:52:53 +0300
Message-Id: <20240904145256.3670679-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06f63fbaadfb..8d9f2c44d2a2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1645,8 +1645,14 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_START;
-	cmd.arg = from;
+	cmd.arg = from & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = (from >> 32) & 0x3F;
+		cmd.has_ext_addr = 1;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1660,8 +1666,14 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_END;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_END;
-	cmd.arg = to;
+	cmd.arg = to & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = (to >> 32) & 0x3F;
+		cmd.has_ext_addr = 1;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1


