Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9296FD3
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHUC47 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:56:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40219 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfHUC47 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:56:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so409278pfn.7
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=66HDQRzZHdTqJMzuH6Ul2StzM+H88/d/kw2iTDPPxiw=;
        b=aKTJdh30JIXBTw+ZFVGZlJzdRWNv7l1fM+StfGdVO0DHSKcWe5jWVLZy14aSfn8yot
         BlvL+Nto8bJzZRnp0hAwvuvU34fBwFZpJ+lfOIrhvtI4e6ZVmqIfnmpKeZMkE7LQ7/3t
         QjKSvBL/57DtT0MoW+mLZrFirYCFU8qIYXUw7NbkW++y+02jffPKAsjjHZiMliaa5jxD
         cBm+pxrWAGdHUlOdZ9F+T+ANfvYDGKsM0rzXyzDMmNwZO8aFk2LQCuvjSdwwqeUn3mmZ
         OZUIgWYnEKoMBhCwyPREevg7N//jCL0PYpbPeIhvLVBRud4h5RN+umbMX2rgdGNPXbb4
         1hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=66HDQRzZHdTqJMzuH6Ul2StzM+H88/d/kw2iTDPPxiw=;
        b=U2o33Zegf5qTuC7s52UcoVGqbm1t1rlvv5HFaHJl0j4gsu3nnXTyiNx/NB7/AjPZLo
         i1ep3UYn2B5UZy1M4CVNsTwefVVuOVqPQbORkGwx950rLLm/RfB1InOBngFuq0VpNhcW
         J0dK51L6guL7tBYfGaaJGg7hQezOFptHJMGM0SYpV5g7pdcsCHhIqPIE2YO64hET19T9
         qaQKVeDT0giGU5adymgTufiFKqSWgb0m7cTasY3tsoK3BKDYsSZzHoH/PCz55DwgxKf6
         yCFUeQOsBwchbAVNer19RM/DIc7xCh2unHk5PonV7RXh5Gy3kaoaLNQ5SLh6IQNx2jro
         lWlA==
X-Gm-Message-State: APjAAAURpSnqN3+UrGpnDupsvEtmFKicOwSR+w1yZrvuJq3i7Ms+yk1T
        4ZopFpoAPmsowBNbWfTk2AELNiGOoQ==
X-Google-Smtp-Source: APXvYqwer5wKLVbBsWvw1dMjBaoBkf/H8r3O/zuyjNWugui5wsd7UiAhiOHW2jYRLbOQgRtZEC+AyQ==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr27532480pgt.337.1566356218309;
        Tue, 20 Aug 2019 19:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:56:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
Date:   Wed, 21 Aug 2019 08:26:24 +0530
Message-Id: <20190821025629.15470-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

