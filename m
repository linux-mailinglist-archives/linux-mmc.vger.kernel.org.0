Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E83FE750
	for <lists+linux-mmc@lfdr.de>; Thu,  2 Sep 2021 03:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhIBBxp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 Sep 2021 21:53:45 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56190 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233144AbhIBBxo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2021 21:53:44 -0400
X-UUID: 6cdc9a93eecf4555a14a8115400b7434-20210902
X-UUID: 6cdc9a93eecf4555a14a8115400b7434-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1494491133; Thu, 02 Sep 2021 09:52:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 09:52:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 09:52:40 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
Date:   Thu, 2 Sep 2021 09:52:36 +0800
Message-ID: <1630547557-1573-2-git-send-email-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630547557-1573-1-git-send-email-wenbin.mei@mediatek.com>
References: <1630547557-1573-1-git-send-email-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add hs400 dly3 setting for mtk-sd yaml

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index e866e98..08aaa4aa 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -119,6 +119,13 @@ properties:
       If present, HS400 command responses are sampled on rising edges.
       If not present, HS400 command responses are sampled on falling edges.
 
+  mediatek,hs400-ds-dly3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      HS400 DS dly3 delay setting.
+    minimum: 0
+    maximum: 31
+
   mediatek,latch-ck:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
1.9.1

