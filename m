Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4176FB3DF0
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Sep 2019 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfIPPq2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Sep 2019 11:46:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44778 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfIPPq2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2019 11:46:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so49772pls.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2019 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkOxPRaPbuf2u6O5EgSQilbhBs4SLuHStjl2F1LwBbA=;
        b=fDPJlRmmgIKRQu7QCJ3d1Kb5Fym9YQrGLxIh/dIN3cAXauC78bXRhNcXqn74YNPDuF
         XGwPyevw1I44l8G1G37uXqHnV6+psOCpszvbIq2UeEVsX23BNHJ9Fus9TKIhU76evWgz
         XP8gfq+FKoamM07ZDJqK9wWNFXBOJEcOCX1x0R7JFHB7y3F4T5/yhQ3mRGYwmAlMrdVi
         noZlQdjE4nwMbPTPLk2X87xZrzL76qnuLvJiAMyIu61ONdAHJOpEIyyqQWL+nN6MT1p3
         KgKxiWYVbZUQegIR/bddVubqiIRIK3d7wzXWi69Eq50qsquOpeE8sBlo29BHxQp/Jqhr
         nzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkOxPRaPbuf2u6O5EgSQilbhBs4SLuHStjl2F1LwBbA=;
        b=DnH1MX5gV1BYJ0s4L4uesFG2d992Gm15OpbZGjuBf36a+RVrxLo1U2fieWhfapBg63
         Efsb1IdnEH2plNjc7LQoH6UigNGNfYtVtR49JVDge2Unhqb4Sx3VpzcVolp63qc2dlKm
         EP0SoewYOaQY7LQZwGJ0TdwrIduKV3j9IUekKwutlIZKdpJf7Y41yO0f3oVQWqjDpZJi
         1zMdOtUo00EEKOR71OGsM4JpJYVeTF9i27B0Q1szC1oRW3A2y3S2w/PgpcrKkwCSE287
         I+HdCsafY7UFd9FQMPpRylL8iwLWv7DWJ/54pLTRS2OQmIYgLoWSCgxJ/xVL1+Head1N
         pqxQ==
X-Gm-Message-State: APjAAAVfQnLtybrWBdPASNbu9K3BATKSP2jYKtd3JmbEh+JrBf/j2VLx
        aiUR7w6HcakNRLrMN8ZmsPE8
X-Google-Smtp-Source: APXvYqwG8QYB0xH19JOO6JX58tqc6H/Nw8aRpTCGSdpSDatwlC/PKSBX6+O66kwvZzS1XRP3joG+Ug==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr487701plk.132.1568648787774;
        Mon, 16 Sep 2019 08:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
Date:   Mon, 16 Sep 2019 21:15:41 +0530
Message-Id: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/mmc/owl-mmc.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
new file mode 100644
index 000000000000..12b40213426d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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

