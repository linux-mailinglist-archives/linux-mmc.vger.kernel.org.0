Return-Path: <linux-mmc+bounces-191-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E67F6C8C
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 08:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBAF0B20C44
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16C4C8C;
	Fri, 24 Nov 2023 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="swSfnQct"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60FCD41;
	Thu, 23 Nov 2023 23:08:52 -0800 (PST)
X-UUID: 4e54f2168a9811ee8051498923ad61e6-20231124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=biIA5nolcnycLWZaSMxodwzv1zZqXFegizuysjjQ1Dg=;
	b=swSfnQctm2+GAjYGziawP3gw9yMH2HjcJnJaUHep5nmPXrsmypZrZfEiTNZ1D2Zrgd+L19Ale+grtzUK2D2eQyMALGUXBwR/4st9AzibgEbSeUWmhI8LkVH2UmJ8H8aRA0AjG4gUGO7bdQrYb5hM74ZqKHp60uc3zT+dFAqg7Nw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:a47b03b3-735e-440d-8dd2-864a67b2550d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:406fc395-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4e54f2168a9811ee8051498923ad61e6-20231124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1227275916; Fri, 24 Nov 2023 15:08:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 Nov 2023 15:08:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 Nov 2023 15:08:41 +0800
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
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 0/2] mmc: mediatek: add support for complete clock cycle tuning
Date: Fri, 24 Nov 2023 15:08:37 +0800
Message-ID: <20231124070839.12484-1-axe.yang@mediatek.com>
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
X-TM-AS-Result: No-10--4.394300-8.000000
X-TMASE-MatchedRID: tiRXYRqWr+s9S3IiQd+eNQUNJ/OP1hfdTJDl9FKHbrmdohxAwFG9tKPF
	jJEFr+olKE0Je8DR/D4CU1PRf9o2s90H8LFZNFG7doMssNsUwYV3W1qHy8N3b+43JwG7OOXNPDY
	iTTu2WpE5YJpG/jXVlKC1Q6bYV6FwaaeeX2Q5bK9+HGPweyal2mGdUezV59DHQZpgl3CshRSeqD
	9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.394300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E95754AC5D9D43F15DE16F73CCF87387CB93DDE3ED625A8CFDA9C6099A14A6B92000:8
X-MTK: N

Add support for 64-steps tuning for better calibration result.
In the past, msdc driver only tune 32-steps and may not achieve the
globally optimal sampling delay.

Axe Yang (2):
  mmc: mediatek: add support for 64-steps tuning
  dt-bindings: mmc: mtk-sd: add 64-steps tuning related property

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   8 ++
 drivers/mmc/host/mtk-sd.c                     | 133 +++++++++++++-----
 2 files changed, 105 insertions(+), 36 deletions(-)

-- 
2.25.1


