Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4759695261
	for <lists+linux-mmc@lfdr.de>; Mon, 13 Feb 2023 21:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBMUzi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 Feb 2023 15:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBMUzh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 15:55:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B36520061
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 12:55:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a3so1003108ejb.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h71rh2NdA7AAe41pj7U6WEWqOutWxSI6LUAz6cTwVgE=;
        b=wrOoDRsiteNkUT99P3k6Y0Gj60kd69+7dJScOym+mFq0B0u7eyR4T8/kEJBCGaQub8
         ZwhdSt5/TayMoP87QfHdQKhje3bDI+YTVcCEvmfff6f76IiZdNlCkV3+fUDJkp/aahlO
         bMPEgB9aO5VIeC3gtv7CqBctFRt/EZZccyBievEg8D+mE1s7IbtLaB7If051Y3I6rk/8
         SSjDvTdUPYKu0UdvABHWHi/WpOjIUN7+tf0npYwSjusMp1zSUHbPFC+6FJrgzv6Qs+LG
         npJnfuKsGFnFe3rCyo4eM1iVcWDLzAB+uphABS4zZaNo9XqVBwAFufyf8o5rQM5Dp0jl
         6Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h71rh2NdA7AAe41pj7U6WEWqOutWxSI6LUAz6cTwVgE=;
        b=PeIqdoNgT2zITDgGzYl2aWqHNm5X/bSkf4CmNYe3QF6P3l0t72MltvSDPybH860CFl
         KZoDhgaqPwPs6BIZ5ltgQ5OMC8C7Zo33DQihLfMfE+mNos7pzO9l82prPMZ9FL8hwy7q
         EALS/4m7ivcOkPTR8WKoFwxzp0xvgoENiZ/kcZCTysKKvXO8gSsm0idKZFQV5sWKjM5G
         DUR/GNqJIEtrDU6HvMnEudEoBGYiqbRmwlq6t3bIPmFPxFwecdeKV11y3tLX5jDAdKk5
         W6SuaVoTmY7taaH91H5t0y8MM68SZ1M52tlnKSIaC//Yl2Jh1RVPyEnHoHjq0vFxhkns
         HkQQ==
X-Gm-Message-State: AO0yUKX4FlyCApkUKjpUITzptnSdIwsPqsi/P1GjqSfUWwR6mZmkGqq9
        Qs0tcZijDqhaA9ZL0mrE/+a04A==
X-Google-Smtp-Source: AK7set/mgbeDR8stEW5tYLlSqNnL/HGcw1K8a5dnghIRudlBNufn1h38xJRRemgi3TL3l7gp7GsmrA==
X-Received: by 2002:a17:906:616:b0:878:4a5e:3a56 with SMTP id s22-20020a170906061600b008784a5e3a56mr297113ejb.15.1676321734615;
        Mon, 13 Feb 2023 12:55:34 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c61-20020a509fc3000000b004acbe0b36d2sm3458299edf.6.2023.02.13.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:55:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Allow 1 icc path
Date:   Mon, 13 Feb 2023 21:55:29 +0100
Message-Id: <20230213205529.2104120-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Some SoCs (like msm8998) only have a SDHC<->DDR path. Allow this case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 01f77a77987c..64df6919abaf 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -127,11 +127,13 @@ properties:
       phandle to apps_smmu node with sid mask.
 
   interconnects:
+    minItems: 1
     items:
       - description: data path, sdhc to ddr
       - description: config path, cpu to sdhc
 
   interconnect-names:
+    minItems: 1
     items:
       - const: sdhc-ddr
       - const: cpu-sdhc
-- 
2.39.1

