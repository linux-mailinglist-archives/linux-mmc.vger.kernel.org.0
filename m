Return-Path: <linux-mmc+bounces-358-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1A8080CD
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Dec 2023 07:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FAE1F21328
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Dec 2023 06:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17243134D6;
	Thu,  7 Dec 2023 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VNDOLM4u"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB67D7E;
	Wed,  6 Dec 2023 22:35:48 -0800 (PST)
X-UUID: d6cc320894ca11eeba30773df0976c77-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1Upr25vEguertkhwfGF+tea8+auuicN+7Yo0Ew+WXUc=;
	b=VNDOLM4uq5kOIFzxKkumbHtgXBYuLh9E8Zm6FzSSDoOQpT8w6gLv8cfhuzVnhxPbzCyGSkv2dma4IMWqBCiuLajiNeYhuLq+rtlHzKO+rZWqsGHYQVUifP6YzpdBNZ0ZEtSkEiB4lasqRVEliiEkMFDofmhSY752IdQBv+VLFHM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:eba906a8-d548-4db8-b82f-4e39ebeed144,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:0beae4bc-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6cc320894ca11eeba30773df0976c77-20231207
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1076372996; Thu, 07 Dec 2023 14:35:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 14:35:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 14:35:37 +0800
From: Axe Yang <axe.yang@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Wenbin
 Mei" <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Axe Yang
	<axe.yang@mediatek.com>
Subject: [PATCH v4 0/2] mmc: mediatek: add support for 64-steps tuning 
Date: Thu, 7 Dec 2023 14:35:33 +0800
Message-ID: <20231207063535.29546-1-axe.yang@mediatek.com>
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
X-TM-AS-Result: No-10--7.560700-8.000000
X-TMASE-MatchedRID: gUuz9Ogq75XyTBeqcpWTVjPDkSOzeDWWc3ewuwbSaG74JyR+b5tvoMIZ
	XeWgC5H4MNtd4b5keZYEoCN5ygO+keG9zoNFX6PtcFEiuPxHjsXizg6lQ0NagVwpnAAvAwazYjN
	VHAF7/x2VMlcqqHWd7aBVvEjzNBpCHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDWCtu
	rRWuLXZFTRjqgjX5vkHnbm84W0zu1SxdSdZ8QKZ+kY/8nj1oos
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.560700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9B3128BC62A2FEE6AE006376D6BA995C3A25A8BBC567435E09939EC57DB75A0F2000:8
X-MTK: N

Change in v4:
- for SD/SDIO, tune 64 steps by default
- reduce some breaks to improve code readability

Change in v3:
- use BIT_ULL() instead of BIT() to avoid potential left shift operations
  that could cause exceed boundary problem on 32-bit platforms

Change in v2:
- move the change made to document to the front
- change mediatek,tune-step dts property type to enum for better scalability

Axe Yang (2):
  dt-bindings: mmc: mtk-sd: add tuning steps related property
  mmc: mediatek: extend number of tuning steps

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   9 +
 drivers/mmc/host/mtk-sd.c                     | 158 ++++++++++++------
 2 files changed, 119 insertions(+), 48 deletions(-)

-- 
2.18.0


