Return-Path: <linux-mmc+bounces-302-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88248001DD
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Dec 2023 04:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9202C281684
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Dec 2023 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574D17E1;
	Fri,  1 Dec 2023 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EUXqhj3u"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCA1715;
	Thu, 30 Nov 2023 19:05:59 -0800 (PST)
X-UUID: 8a19255c8ff611eea33bb35ae8d461a2-20231201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=V6tB0+EPwP58rkLDk+28AFubYUauyeii7M29/hehUYs=;
	b=EUXqhj3uGctZF3i91gdn8mOboWsOnN6J6tyIByRU+WKNYkL4ecVR+03r4CFLodOSgzyoBY1aSL3fCI4NQvAtxJbi+sZ/+qj47FRlmGkSKno1ZpdaHHSy4iNnRBLuo7br753QWL9t2aUqLwTaxmfE7fndrBHEftMlxM/sBeGuHBU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:f00c2943-cb6d-4268-8306-ef309c913e9e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:abefa75,CLOUDID:72b228fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8a19255c8ff611eea33bb35ae8d461a2-20231201
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 110085834; Fri, 01 Dec 2023 11:05:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Dec 2023 11:05:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Dec 2023 11:05:51 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
	<matthias.bgg@gmail.com>, <mengqi.zhang@mediatek.com>,
	<wenbin.mei@mediatek.com>
CC: <yangyingliang@huawei.com>, <adrian.hunter@intel.com>,
	<avri.altman@wdc.com>, <vincent.whitchurch@axis.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] mmc: core: Add HS400es support in retune and initialization flow
Date: Fri, 1 Dec 2023 11:05:47 +0800
Message-ID: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.374400-8.000000
X-TMASE-MatchedRID: u+tUW9pLem+E9zgVMk3pXlz+axQLnAVBesw8RnBRGwos/uUAk6xP7COq
	qvcT7F2IzPzCmwZdi63lN7ZYHc5mSoHcC7KYYAdE4pdq9sdj8LW6hgVvSdGKo9+SMh5eC/5eX9O
	/HRQux9fi8zVgXoAltsIJ+4gwXrEtwrbXMGDYqV+i5u/VvsFaHVKff8AdaJ4QWCFsQ87yaDPHOM
	6xNrBNq9wOJnkbFuha6cT8eWH2891TL0wCs6Mukdps4qxiIeUJBloh3ZuLeBtvBeUWxunLtaMnT
	JRI0XInfXwUEm1ouDzLDYxFC1/7rn6GdNk4NWmA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.374400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 55110CD927814B2C0F23ADD29D1383873685FB918AEEA5574DE1D7E2BCFF1A092000:8

In HS400es mode, when we enter mmc_retune(), we will be forced to
the HS400 mode instead of HS400es mode. So we decided to add support
for HS400es in the mmc_retune() process.

Additionally, during the initialization to the HS400es stage, add
hs400 tuning as an optional process.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
---
 drivers/mmc/core/host.c | 11 ++++++++++-
 drivers/mmc/core/mmc.c  | 10 +++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..4bddbbb3d539 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL(mmc_retune_release);
 int mmc_retune(struct mmc_host *host)
 {
 	bool return_to_hs400 = false;
-	int err;
+	int err = 0;
 
 	if (host->retune_now)
 		host->retune_now = 0;
@@ -194,6 +194,15 @@ int mmc_retune(struct mmc_host *host)
 	host->doing_retune = 1;
 
 	if (host->ios.timing == MMC_TIMING_MMC_HS400) {
+		if (host->ios.enhanced_strobe) {
+			if (host->ops->execute_hs400_tuning) {
+				mmc_retune_disable(host);
+				err = host->ops->execute_hs400_tuning(host, host->card);
+				mmc_retune_enable(host);
+			}
+			goto out;
+		}
+
 		err = mmc_hs400_to_hs200(host->card);
 		if (err)
 			goto out;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 705942edacc6..9760eea2c104 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1823,7 +1823,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		if (err)
 			goto free_card;
 
-	} else if (!mmc_card_hs400es(card)) {
+	} else if (mmc_card_hs400es(card)) {
+		if (host->ops->execute_hs400_tuning) {
+			mmc_retune_disable(host);
+			err = host->ops->execute_hs400_tuning(host, card);
+			mmc_retune_enable(host);
+			if (err)
+				goto free_card;
+		}
+	} else {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
-- 
2.25.1


