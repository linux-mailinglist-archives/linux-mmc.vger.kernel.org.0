Return-Path: <linux-mmc+bounces-287-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF267FE906
	for <lists+linux-mmc@lfdr.de>; Thu, 30 Nov 2023 07:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D971F20EFA
	for <lists+linux-mmc@lfdr.de>; Thu, 30 Nov 2023 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAC1DDC6;
	Thu, 30 Nov 2023 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fhPwC85u"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8410D1;
	Wed, 29 Nov 2023 22:15:28 -0800 (PST)
X-UUID: d6e794a48f4711eea33bb35ae8d461a2-20231130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=REy94AAJaYZvG1e+Q5y3StrQOPyjWjRYey4f+drmRhg=;
	b=fhPwC85u8D326GTWBeE7bQgC3BnqjiVWIU102xlISgYEhJcVchI6OGEEx0yg+cXg1XjY3od6l9rPUFbo1lCAeLAqwf67KtxeqDd5vPz7Bw+NhG4ZogJ0XIiAtNMbWEUbY9EQ2zCSi8CUkO3yud38L9OvGB0oe4wuAN/8kVAOafo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:1e01d35d-b305-4a7e-8c11-86ef31006baa,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:abefa75,CLOUDID:6bec1efd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6e794a48f4711eea33bb35ae8d461a2-20231130
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1862298506; Thu, 30 Nov 2023 14:15:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 Nov 2023 14:15:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 Nov 2023 14:15:18 +0800
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
	<axe.yang@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: mmc: mtk-sd: add tuning steps related property
Date: Thu, 30 Nov 2023 14:15:12 +0800
Message-ID: <20231130061513.1296-2-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130061513.1296-1-axe.yang@mediatek.com>
References: <20231130061513.1296-1-axe.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.084500-8.000000
X-TMASE-MatchedRID: wDTc/wNgEcN3dXZvIJVkUOw8wbnnSw8bHg7k13K467J0TRq4bcxmH3Im
	l2BIvAJu7p17JCLIX7cfSuixqQMLLLvhKf49TtYAbBu6+EIezdyZf5btvM85Abv408/GP5HqfmK
	fyen8+8qrarPPtIvi4m9yZj3aufb5HxPMjOKY7A8LbigRnpKlKWxlRJiH4397+ruzfpzKUonZFO
	k4V7qu28n1qJ08wLl8oSFuOnQmBmi6NfM7QpaIJg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.084500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D519890939F3F44D9AA4CDBFC8AA06CF8DF45DCDC5A358483C9D762ED3BE9DEA2000:8
X-MTK: N

Add 'mediatek,tuning-steps' setting. This property will give MSDC
a chance to extend tuning steps up to 64. With more tuning steps,
MSDC may achieve a more optimal calibration result, thus avoiding
potential CRC issues.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 3fffa467e4e1..c532ec92d2d9 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -145,6 +145,15 @@ properties:
     minimum: 0
     maximum: 7
 
+  mediatek,tuning-step:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some SoCs need extend tuning step for better delay value to avoid CRC issue.
+      If not present, default tuning step is 32. For eMMC and SD, this can yield
+      satisfactory calibration results in most cases.
+    enum: [32, 64]
+    default: 32
+
   resets:
     maxItems: 1
 
-- 
2.25.1


