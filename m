Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B9539217
	for <lists+linux-mmc@lfdr.de>; Tue, 31 May 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiEaNux (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 31 May 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbiEaNup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:50:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F115EBC5
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d26so13180932wrb.13
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdLebb0hcqumk+5oPRll761fGotaeHJ+s+cQnmwt1xo=;
        b=vvDy6XluCcZHIaiVjMTo9e2czawjGc4AH938vW1pCzEcW7kbxITyawjphD4EV/7vDN
         evc04Bbu01AxfCOacWkePRVHGvLcgU8FjxYfGe28i3qOevr+sFvsloQ5zQnu1MiWNtp9
         wBAa00iDuFO00vXE9tuUDKf+8yFB7Otyji9C0BH4UBBYCvCPLHIvMPlNpnE1di8tMbcv
         Yc3nn94Mngd8+f5An0MCY5JQ+c6oCIWT0W/aF9xDx91B2zFOMxYepU0t+P9d7IR/dHqb
         dD/UeFvwFgVP7F8Ff+5GEwn+qJd5uucYG3s47GiUoWky06YiKrLkNXu/2bqq0KlPsqHJ
         X7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdLebb0hcqumk+5oPRll761fGotaeHJ+s+cQnmwt1xo=;
        b=JK5tT4UN61FBJLtxST2Kxy4xf+NY5NuvuRnnJUJX7jr4Qq4KUFFfV357EBbdVQWQTJ
         iamLBiTkb5eiDwyuO6ADtrKbN1dsMkjdw6Uxo4zIPxzLeEVrUEvcp5IMxvXxtkGOHoG/
         2FD6smPj2TqJkV+qykIkFUbXmPr8aGt0kTFAvy8p6kOlzQ7uRtTvuTB58kWFPf3USpc1
         Wf2Obm1Xmz/trixbipdqGaSIhKmciYHkkJ6MlanFjwmMn1JywENpZ7bIVvn3T/tfGN5a
         KQ3gzqGhikGlpZkmjJz6Jki8mzN9FP2KEL90BdXhzw7/IGsjSsfJFGpYiSdS/2Lr7Y2l
         Ny9g==
X-Gm-Message-State: AOAM531Kd0CsuohzxYoqtLLi/4kkShoP5YhftrbBy3N7ONP5IQd+Iicy
        MQTNhvwSdKqM4I7aHHg94Uefow==
X-Google-Smtp-Source: ABdhPJzwij5huFbgeVoSJeVbVzYQRkcylviSsOwOJ7GzYS2+JjN4sQ22PXZUOKuNArAQHL/NOyjV9Q==
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id 8-20020a056000154800b0020fc4e3637amr40373733wry.513.1654005041269;
        Tue, 31 May 2022 06:50:41 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 02/17] dt-bindings: memory: add mt8365 SoC binding documentation
Date:   Tue, 31 May 2022 15:50:11 +0200
Message-Id: <20220531135026.238475-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MediaTek SMI bindings for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 ++++++
 .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index a98b359bf909..e1029ac99ab4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -46,6 +46,11 @@ properties:
           - const: mediatek,mt7623-smi-common
           - const: mediatek,mt2701-smi-common
 
+      - description: for mt8365
+        items:
+          - const: mediatek,mt8365-smi-common
+          - const: mediatek,mt8186-smi-common
+
   reg:
     maxItems: 1
 
@@ -130,6 +135,7 @@ allOf:
             - mediatek,mt8192-smi-common
             - mediatek,mt8195-smi-common-vdo
             - mediatek,mt8195-smi-common-vpp
+            - mediatek,mt8365-smi-common
 
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index c886681f62a7..815d87fc64a0 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -32,6 +32,11 @@ properties:
           - const: mediatek,mt7623-smi-larb
           - const: mediatek,mt2701-smi-larb
 
+      - description: for mt8365
+        items:
+          - const: mediatek,mt8365-smi-larb
+          - const: mediatek,mt8186-smi-larb
+
   reg:
     maxItems: 1
 
@@ -78,6 +83,7 @@ allOf:
             - mediatek,mt8183-smi-larb
             - mediatek,mt8186-smi-larb
             - mediatek,mt8195-smi-larb
+            - mediatek,mt8365-smi-larb
 
     then:
       properties:
-- 
2.36.1

