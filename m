Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AE6B76AC
	for <lists+linux-mmc@lfdr.de>; Mon, 13 Mar 2023 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCMLwZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 Mar 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCMLwV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Mar 2023 07:52:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E15DCB0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 04:52:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p26so7749306wmc.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/iRgjlk53W5s/2WrzKk9K78Dk4NAb9bQJtm5scffb0=;
        b=U64G7bcQbVV62DxuWYoa5TCo8dbf7ZJ9qrbC/4S69dsjgDmZkUEUpU9pjKqIbN9ka0
         S23CQMod3RrfD/lKpZH7BevB26+CSdw7XnZhCRqKWr5ZiTV4eRw2vcv2ljOTGWiEvez5
         DRVWnk7PR7iHs/uDgTxn/phPFaNYJrnWWIe/6XBUVPFRfHeVScOZ17It2G/IzX+7DR1z
         O3qNvy4TPVk5S0PaH6H2OI4FAaWFHXID/hSKnBWpOZMNEaL1NfoJnPLcr8UGJjTRs+DZ
         gl8+zC8t/JKQm//RF2r/40e2D1T8DvNCCC/E0q0DiXkvwlI1+x8zL+zkjHowZr3A2Rq8
         b00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/iRgjlk53W5s/2WrzKk9K78Dk4NAb9bQJtm5scffb0=;
        b=7EPGzlb+AMNXONpr/sIcNdL302KhLnGXrFprjeqUyfO4SMEiR4opBxLDmLcIJC1UEq
         IE/ixBs/dZlyfqQj4zvduQMgdRtcflwoxpL6LtTFlxnuqSg07h9dUyfuOKg0Jqjr1GcS
         YRzintrhFFETgo6sRAlSwz/wV/J2PvdhwLA4Z49+FnEmgFP+/kFHlJdJN/dS5tIbwT+U
         T+5Mgmq8r/K+O7b84Sd11vxBm7LmX/bbNoHAKlIto7EBoD1bHhUs0Ikp9G8sbLGQjoL3
         /qxNhmIMU5qYrT3a8q4l05iqiVHIOkdi+XTh/MftjNOR693mGYGO5/ZY5Fmu1sMKOU8u
         edvA==
X-Gm-Message-State: AO0yUKVmvCIKyfW+etao2e7Q++lWBHq1enCot9WEShDkpYOW3nF69X9N
        g5r8HtazHO9O1KIz539YhzKmSA==
X-Google-Smtp-Source: AK7set9G4RL9qumkBcr8GAjKgUR4RVYeQijlOH4eeN7ldAfhMsrw6HSQEVTv7SplISM+dZ5TlXczQA==
X-Received: by 2002:a7b:c7c6:0:b0:3db:2858:db84 with SMTP id z6-20020a7bc7c6000000b003db2858db84mr10154103wmk.34.1678708330228;
        Mon, 13 Mar 2023 04:52:10 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003e21dcccf9fsm8801090wmn.16.2023.03.13.04.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:52:09 -0700 (PDT)
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
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [RFC PATCH v3 1/7] dt-bindings: crypto: Add Qualcomm Inline Crypto Engine
Date:   Mon, 13 Mar 2023 13:51:56 +0200
Message-Id: <20230313115202.3960700-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313115202.3960700-1-abel.vesa@linaro.org>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
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

Add schema file for new Qualcomm Inline Crypto Engine driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * moved the file to crypto dir
 * added soc specific compatible
 * dropped top level description
 * renamed node to crypto and dropped label in example

 .../crypto/qcom,inline-crypto-engine.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
new file mode 100644
index 000000000000..92e1d76e29ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/qcom,inline-crypto-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. (QTI) Inline Crypto Engine
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8550-inline-crypto-engine
+      - const: qcom,inline-crypto-engine
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
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+
+    crypto@1d88000 {
+      compatible = "qcom,sm8550-inline-crypto-engine",
+                   "qcom,inline-crypto-engine";
+      reg = <0x01d88000 0x8000>;
+      clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+    };
+...
-- 
2.34.1

