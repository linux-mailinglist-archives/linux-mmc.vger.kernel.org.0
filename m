Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1233608BCB
	for <lists+linux-mmc@lfdr.de>; Sat, 22 Oct 2022 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJVKnF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 22 Oct 2022 06:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiJVKmb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 06:42:31 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AC57E03;
        Sat, 22 Oct 2022 02:59:38 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id A6AC25FC59;
        Sat, 22 Oct 2022 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666429537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdAcqBn0H2JqQ0pdVG6sZ5NnqpXSrOBaSZ51qSReaUY=;
        b=ffNyPhHhNS1WwHLjXME0VKXh2X6Xacb3lp9yewBaHF4KzYvsjOmjhUDK04d2Mo+J3FRAvm
        lS+XLcSoJZ/yCirUEt8QFbaA5VRDmXKLHnCta019IzHYIoLTrGl6heiL9vEP2H9UF5TLWI
        hjhVtgpcN81G4ekx+iHQCfqRHcVmrg4=
Received: from frank-G5.. (fttx-pool-80.245.73.148.bambit.de [80.245.73.148])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id CDCCD407B2;
        Sat, 22 Oct 2022 09:05:36 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: mmc: Add compatible for Mediatek MT7986
Date:   Sat, 22 Oct 2022 11:05:26 +0200
Message-Id: <20221022090530.16265-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022090530.16265-1-linux@fw-web.de>
References: <20221022090530.16265-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ab4bd667-2f47-4413-a414-67051bd144ff
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
Platform.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index d8e1e2e9adf2..3cbf0208f1b4 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -23,6 +23,7 @@ properties:
           - mediatek,mt6795-mmc
           - mediatek,mt7620-mmc
           - mediatek,mt7622-mmc
+          - mediatek,mt7986-mmc
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
-- 
2.34.1

