Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72611512E11
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Apr 2022 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiD1IVm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 28 Apr 2022 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343988AbiD1IVi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2022 04:21:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8798F68
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:18:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p18so4608820edr.7
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6ObuNAUe3IapWBmxguwLTs3rzFOyELI4KMoy84mKI8=;
        b=vr0zLoeA8qcFRf/JF23LpbGRsMu27mS7NCLPTNl3IvUo61ZTGf6537v3BckD5UxY5S
         FPySCLSrRh3TZgIv52RFXuA0i/xq9EfOxXuxySq46tzEm07FU7zqRE+0IdpsEWFo7WSp
         H9FidhtJkAr0DNDmViKD/zBj5Tm9aUygAWUEGiqswUyYv3oV2fnRjtk1BK0uF38t33TY
         w3MJx9ocF0bKKBLK8H/c5BQXwa+QvCJ9iaUHRYYyn9v4NblTQ9g/rPSGiywuSoVJmMN5
         ca5xnSneLSPqCm2/2tL231d97m5OIvb+eW6p83QtxzZbPi9k9GCCYQGo4MbizD3ffNKf
         997A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6ObuNAUe3IapWBmxguwLTs3rzFOyELI4KMoy84mKI8=;
        b=56OAI4+SY3haKmvz1An0f34jJ655djE0JwPbee3PF36+tUYsJJ9MYggsl0zD63UhTd
         AVGY3eZ/xT3CMbXito2hukGR+MRMAneJZYIwDNcY98kIx0wOLqoSkv7Xg0q077+PiaQN
         DwPOSV0NSZAXo+lkTd+B1fi+PUfyX93R6J/BI+Ssjb5JVAeW/p1anvpZhDIQkCuPWq0Z
         I1XSMCKgBbjkMCYmygVTBvmgS7YRepE6o7WkgAwJkQoLLX08Vz3O2vl/fJ56ipF0qknr
         wswJPvNyncTT7WdhhVYQ4DgHIZZywlBmqjTAvQ3pibQKK2X3GqYCuZFY4NGXLpDJwBD+
         jTYQ==
X-Gm-Message-State: AOAM533OBt5o71CQPOWUdPMSjrGwPoHF4kt3tXNKo9WRRq+2++DVqs0k
        R6TGsy5lK1VK32a7oR1IszdXGQ==
X-Google-Smtp-Source: ABdhPJxRc96budO9H6KzxrRujkg8tG5V8iP+QoQrMj/hHOqWwyAH2FSFFYOUoqdy55WJbz8RAXpq3Q==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr34698212ede.327.1651133901498;
        Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm8007744ejj.88.2022.04.28.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: mmc: brcm,sdhci-brcmstb: cleanup example
Date:   Thu, 28 Apr 2022 10:18:17 +0200
Message-Id: <20220428081817.35382-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cleanup indentation and order of entries in example DTS.  The most
important when reading the DTS are compatible and reg.  By convention
they are usually to first entries.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index 54a0edab5f8c..b672202fff4e 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -65,15 +65,15 @@ unevaluatedProperties: false
 examples:
   - |
     mmc@84b0000 {
-      sd-uhs-sdr50;
-      sd-uhs-ddr50;
-      sd-uhs-sdr104;
-      sdhci,auto-cmd12;
       compatible = "brcm,bcm7216-sdhci",
                    "brcm,bcm7445-sdhci",
                    "brcm,sdhci-brcmstb";
       reg = <0x84b0000 0x260>, <0x84b0300 0x200>;
       reg-names = "host", "cfg";
+      sd-uhs-sdr50;
+      sd-uhs-ddr50;
+      sd-uhs-sdr104;
+      sdhci,auto-cmd12;
       interrupts = <0x0 0x26 0x4>;
       interrupt-names = "sdio0_0";
       clocks = <&scmi_clk 245>;
@@ -81,6 +81,11 @@ examples:
     };
 
     mmc@84b1000 {
+      compatible = "brcm,bcm7216-sdhci",
+                   "brcm,bcm7445-sdhci",
+                   "brcm,sdhci-brcmstb";
+      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
+      reg-names = "host", "cfg";
       mmc-ddr-1_8v;
       mmc-hs200-1_8v;
       mmc-hs400-1_8v;
@@ -88,11 +93,6 @@ examples:
       supports-cqe;
       non-removable;
       bus-width = <0x8>;
-      compatible = "brcm,bcm7216-sdhci",
-           "brcm,bcm7445-sdhci",
-            "brcm,sdhci-brcmstb";
-      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
-      reg-names = "host", "cfg";
       interrupts = <0x0 0x27 0x4>;
       interrupt-names = "sdio1_0";
       clocks = <&scmi_clk 245>;
-- 
2.32.0

