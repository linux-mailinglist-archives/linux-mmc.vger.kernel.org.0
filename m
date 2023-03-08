Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057C6B0DF0
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Mar 2023 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjCHQAP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Mar 2023 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjCHP7j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Mar 2023 10:59:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F9C888E
        for <linux-mmc@vger.kernel.org>; Wed,  8 Mar 2023 07:59:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1454482wmq.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Mar 2023 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ8aIz9t0aLGHjU78b+1MO8VlG74MrpHDrDdP0IoFxE=;
        b=kNVwnyOHFMA2dBrvf6FnfAmtDpkoJKqzc7WN1vHQIa8vvhIFpnIiO4Xq/zs9N734jm
         nDFLoCRxxBmcMRzR3w8FwPvnFVBzB9UH58w8eWoRCcbAGbAdfSSxvdHxOTycnf2MxONV
         zyC4Udpp2uSkaTN7Ke3dmO+3PTZ2TYGZbs5kN9dB2bQe7RxM+MWRkWPHuYQ1I1foBD9a
         9rLZVRT01bGADeaYtqIg7SDrt3/d+yWbHMXdXOyBqSuiyOvYl4wzA+3EhtGb5MclNXjm
         llEMohE+0PupigeFjWYfi2/JTb337RNKy1svSKMDPHpbL13bc8DLAkLC3q2AkQK6fiZC
         SBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ8aIz9t0aLGHjU78b+1MO8VlG74MrpHDrDdP0IoFxE=;
        b=PNd4sb0eC93Nq8AFgSUkI5/Sb7Vln3WFXQ/kugZiWkVPv+s1Xzb3bxbb5QT1wOL3W0
         30OjsvKcsuVnWxCiS6du2087YFH7s6MWZLhEs8uwQtbnB1tHJITT43vwcb49c1FZwBHC
         lCuQn2rb0YGJbDVWiSljBiamqTdDTxx2HBLpc14hz4+pAT6SREnMuL6PsLp0Y1wcjtOU
         OCNDUUF+aRWOLHqsrIz/IpJmn8aRQFJRiNQbXCaI82jLBLqyVRIoz7mCG+cOYjKWaAbn
         7yuPvEY8PV+A8NNKzQ6TG7HBodfPllLTTh9ngmEnaS/iY5reUyFT9vzHTLpwBbhJG1So
         mTUA==
X-Gm-Message-State: AO0yUKVkv37I11cLfRdbfl5aIDVWbyxtd0/X04bSPgt8K4lja6jayatA
        QpR72xX6wsz/Av00lUwoUOnfEQ==
X-Google-Smtp-Source: AK7set8XZ6ax52uCKkdt4Lojgscli6I7DOws3DctW0l7riV/gkBkFAPeh5Z5CMMmIBlU9yHrFDbqhg==
X-Received: by 2002:a05:600c:3549:b0:3eb:55d2:9c4c with SMTP id i9-20020a05600c354900b003eb55d29c4cmr13505124wmq.16.1678291148732;
        Wed, 08 Mar 2023 07:59:08 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:08 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 1/7] dt-bindings: soc: qcom: Add schema for Inline Crypto Engine
Date:   Wed,  8 Mar 2023 17:58:32 +0200
Message-Id: <20230308155838.1094920-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add schema file for new Qualcomm Inline Crypto Engine driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch was not part of the v1.

 .../soc/qcom/qcom,inline-crypto-engine.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml
new file mode 100644
index 000000000000..359f80dd97cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,inline-crypto-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. (QTI) Inline Crypto Engine
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  Inline Crypto Engine
+
+properties:
+  compatible:
+    enum:
+      - qcom,inline-crypto-engine
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+
+    ice: inline-crypto-engine@1d88000 {
+      compatible = "qcom,inline-crypto-engine";
+      reg = <0x01d88000 0x8000>;
+      clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+    };
+...
-- 
2.34.1

