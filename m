Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B450D96F98
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfHUCks (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:40:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39031 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfHUCks (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:40:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so471761pln.6
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=66HDQRzZHdTqJMzuH6Ul2StzM+H88/d/kw2iTDPPxiw=;
        b=IEJF5hUtFv+y59Inx8n1xsEI0wZhB+RMvwdTwBQEdA27ffmbh2cr4lEkXcrFjtzAyo
         ZakWSuBTFoOP6BSvKmpi8PFPHY8Hkd3B46AFxHMPz2qPRgWvcgJPfkyWXJoAsoDkopa9
         QMKBVl/HjnyAyzfnMla8jkO/81dxcLtkjIuoHzs4opQn5HknuO0ckgRYFSnhI+op4kHb
         o3XVP+PpfhdbMQ41zImtOVlBZ0NpC3tQ4ZTTfA8u3omIQ06Ly+c2QxWzSof5Qyh1DNfD
         b1h5TuSeMBgRZMaOdKtOedjKed2gPlhbAVkhlJqJu8vNJQrupu7WV9+uSeITUoATjX9k
         E2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=66HDQRzZHdTqJMzuH6Ul2StzM+H88/d/kw2iTDPPxiw=;
        b=CJkvcMmCrsvuMUwkBfshiezmPohy+3/PgTxD2pm8GUPQUeWVpzHfUSu0s9SCX/ZGAi
         UpI00pfTW+2qhm/KQaUW7C0j3bXZF895OmPCeOr6ULWl3opNVvH9QHCgVJ/iiT8eI2sL
         G6FA1DZ3EFBcorRnkC7ddd7rwdn5sjwURxuOVO4E0Uk8gtvYoNdX6shr5dem/uV3MWy5
         kiqSyw8SniHNTLoXaDK20o/mOYw0wuJfcj3v2kPbxHnRi1hHSPsNrE08IzLCYfUwUwZC
         tBqIolUYytLiVd0SQ9wqZo6FGF+paQy8AorBYAS1eyLub0CBlPZJsgSCroSPjofj5BMF
         AFig==
X-Gm-Message-State: APjAAAUXQ0AueGWWkX36BnHXR3ZQKGGojrFIHZyFrF0J83FFdDFtDEqL
        hVLtj00rlmzflL9ZiRyjeuss
X-Google-Smtp-Source: APXvYqw4z1lUeLa7hhwNhxLpxYMtmgc2ZQdhZdONdZIKJ46sgEl2aFe3EpqIHVClUxJqKgthgh+yVg==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr32091053plo.267.1566355247485;
        Tue, 20 Aug 2019 19:40:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
Date:   Wed, 21 Aug 2019 08:10:09 +0530
Message-Id: <20190821024014.14070-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/mmc/owl-mmc.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
new file mode 100644
index 000000000000..f7eff4c43017
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/owl-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SD/MMC/SDIO controller
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    const: actions,owl-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: mmc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    mmc0: mmc@e0330000 {
+        compatible = "actions,owl-mmc";
+        reg = <0x0 0xe0330000 0x0 0x4000>;
+        interrupts = <0 42 4>;
+        clocks = <&cmu 56>;
+        resets = <&cmu 23>;
+        dmas = <&dma 2>;
+        dma-names = "mmc";
+        bus-width = <4>;
+    };
+
+...
-- 
2.17.1

