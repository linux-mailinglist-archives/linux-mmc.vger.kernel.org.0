Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73805571E63
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Jul 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiGLPJl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Jul 2022 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiGLPJV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 11:09:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8781BFAE1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 08:02:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bf9so14372192lfb.13
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeR3DFLgzM8qo6wNayqmpjIsz3WLvihoJpHEg++lMwQ=;
        b=cHtxZBN53KqaaF99bN6sBOFjotvE88Ii8x8gdQNe6QNOjfXQ2vj15EjV37z3fklU8X
         jAgYEFflUP9x99z1gV2vYgMwUrqpQeEQ9XQ5p45ffgpQFdqRxinhSlg7opiajfVJJbi3
         zPFnroZbjjrReouhkmqycGT36ACNVfYqqsqTj9pBOlm0QKQj6SKxQJ2DKgcZRgRZ0eRb
         CIrKFWKfiggAMSBQPoyd502u3WetuLNAlz6GrO9uyDLEL612bU2g4jmdi5Sh0vPtTDJ4
         UmOtyzen3vI9YGiOFgpR4fN9ikniVKG0xI7F5zoYnZ6LZz+55Bg+abLRM3IdQWvZcsMd
         vOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeR3DFLgzM8qo6wNayqmpjIsz3WLvihoJpHEg++lMwQ=;
        b=xbjNo3kok4VQoRwB5ju6Dq83ueZH0PO+zjvyFeWWD1wWSxbKeJoZpXRaOldL6GYy68
         DXKGwD03tkGX78POj0i5OUQ34WRPQXnuO6KUUTIDMxIQvQlR7rwCpQ0LhCPi1KU5CDwo
         T0xYyKOo5bvH7zCkhtsJ0OxTcK2bCQn93T2zLrwy++0Sv33ZIA80h9smvobbl21zB/bE
         wpZGHEoQrAFeBL4dqLH587/VsPk2DoOikdVCEHf7m+QB+5bKQWRgGpgLHb+bVWQC3Wfr
         fs5JHsrmu2hqcgoFBf5TbLY7SZAQLm9XjlTVw98BaPNkE6wbUyYZ4cIdsbsrvVFJPBpU
         hSsw==
X-Gm-Message-State: AJIora/TUIY8On5KVjIxxfayCmU3oMiBvyyQEIsetgbERqlwk6byBPxe
        i2oO1ZDgONLAASb8HClBXL8qGw==
X-Google-Smtp-Source: AGRyM1sgMwtb/vMeSl0IGd0qOGshKzGkSHsqTQLPg/s8WeGU9SsAxVKlgMD2HFmn/2J4/1Gi3pjGsA==
X-Received: by 2002:a05:6512:239c:b0:489:cc5c:177e with SMTP id c28-20020a056512239c00b00489cc5c177emr11600310lfv.645.1657638163762;
        Tue, 12 Jul 2022 08:02:43 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 4-20020ac25f44000000b0047f9614203esm2224649lfz.173.2022.07.12.08.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:02:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: add MSM8998
Date:   Tue, 12 Jul 2022 17:02:17 +0200
Message-Id: <20220712150219.20539-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
References: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a MSM8998-specific SDCC compatible, because using only a generic
qcom,sdhci-msm-v4 fallback is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 31a3ce208e1a..0853d0c32dc7 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,msm8992-sdhci
               - qcom,msm8994-sdhci
               - qcom,msm8996-sdhci
+              - qcom,msm8998-sdhci
           - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
       - items:
           - enum:
-- 
2.34.1

