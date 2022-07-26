Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E74580F59
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Jul 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiGZIpp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Jul 2022 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiGZIpn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2022 04:45:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C62AE06
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 01:45:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so14981783pjj.5
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyOOkD+eRbzSyetXYFfpw0k4gfFU2yiJ20e/GWk7olk=;
        b=X7vIiDhSLybQdcdrocjp2PDtEI9FAfSfkt/GXXlm4Zq/NT2ao/naZ1esoCW9iPs4LK
         SGlmzljGdXxTJjAxwE8hTZYvO3lcpxl/vz51eedoNV3wF7QLgpuk8AxL/mG/0al1EiAf
         YIACUX/TNOOLxiePT/3J4xQU/fas/m/5SN0cpELonIwUzewB4HMd2AoS5+2URULeUeaP
         r/4XThUPpUjIqQCm6/vYuLVspxYEWMyU3EvsaDYydWOkEIEhFGwT/RHKrtOFdQZBaGZc
         9AqERj1aHC/cECI4jGRdcZxd/Q5VCLkxJ81p20pIjVuIOf9SqqVjbeoZO/Ldo7OIWx/e
         8RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyOOkD+eRbzSyetXYFfpw0k4gfFU2yiJ20e/GWk7olk=;
        b=LpBX/fOAJixOaGfO/+CNYA5Fs4pqEejrZLYaxTdxZuLFmlgkbqh9OeDO2HB0kcwh6N
         CuMyTs2Z6n4/RG1UsCL/kYZ+9PBBxUXVLisLNVpA41HMxv1pA0Hk6J+N8r2onD/0tOpj
         UptA3aoLJy1ouI+/0+iUJXIhAk5tG+sdWTXYYELcpGfKZ6Nm/L0HNbKrtV6mILaeAO7t
         GfafcuofukfsCSf3WvxUJTXSVtrCjDzu+WrEKq7EhtJXXrqJpwqDhP9fhRHCHLQLcSo/
         9WwdBqHk5Qyk9f+dk3ZM6hlEE2xgs80hvIa8XGUXYGEWREzB7RGxRX7kB+1fW/q+M7ZV
         vYlQ==
X-Gm-Message-State: AJIora+hxXUbxfX2xunNIABjtePbIL5g/DzrKwUa+PhwsG4uD/q3IfXI
        QOCYna9RZvCJ+/PwKJjg4Ke42OnIQCQ4/cFT
X-Google-Smtp-Source: AGRyM1tImQ0our/59COnOeI0PSnlKWT0efVS/MN9w29JmZjyd9OsYz0Z2+TKak57pzx+1Gq4ZXhjew==
X-Received: by 2002:a17:90a:4216:b0:1f2:70ed:1116 with SMTP id o22-20020a17090a421600b001f270ed1116mr16168424pjg.89.1658825141232;
        Tue, 26 Jul 2022 01:45:41 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id d4-20020aa797a4000000b00528c16966casm11450560pfq.174.2022.07.26.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:45:40 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Subject: [PATCH v2] dt-bindings: mmc: Set maximum documented operating frequency as 384MHz
Date:   Tue, 26 Jul 2022 14:15:20 +0530
Message-Id: <20220726084520.2895454-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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

As Ulf noted in [1], the maximum operating frequency
documented in the mmc-controller device-tree bindings
should be updated to the maximum frequency supported
by the mmc controller(s).

Without this fix in place, the 'make dtbs_check' reports
issues with 'max-frequency' value for ipq8074 sdhci node:

  arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
   max-frequency:0:0: 384000000 is greater than the maximum of 200000000

[1]. https://www.spinics.net/lists/kernel/msg4442049.html

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220725180916.2850228-1-bhupesh.sharma@linaro.org/
 - Rebased on linux-next/master

 .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index ff5ce89e5111..802e3ca8be4d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -88,11 +88,18 @@ properties:
     default: 1
 
   max-frequency:
-    description:
-      Maximum operating frequency of the bus.
+    description: |
+      Maximum operating frequency of the bus:
+        - for eMMC, the maximum supported frequency is 200MHz,
+        - for SD/SDIO cards the SDR104 mode has a max supported
+          frequency of 208MHz,
+        - some mmc host controllers do support a max frequency upto
+          384MHz.
+      So, lets keep the maximum supported value here.
+
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 400000
-    maximum: 200000000
+    maximum: 384000000
 
   disable-wp:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.35.3

