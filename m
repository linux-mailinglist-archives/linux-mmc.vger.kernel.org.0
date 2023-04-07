Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531116DABC4
	for <lists+linux-mmc@lfdr.de>; Fri,  7 Apr 2023 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjDGKvy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 Apr 2023 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbjDGKvB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 06:51:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BBB444
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 03:50:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so21545276wmq.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680864649; x=1683456649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrRjNsG8dDfUlp/X2GO5GwvyXP0i6VtlSWcC/Gq+Hfw=;
        b=ACLLbGt1OwOJODwmJx3o9oqj4zdQCSTqLWYpDlrLRPGcUtSuQ2BIq77jDcko9hab2y
         K9tRxzUIOUPeh7QIE3eh/i4YpA1xMj7MthRtDnfbfgcTINE/LjPYIlL7jWNmGWtUP4Bg
         hIY3gVYC/jqzqi+OW8ndbQP34DMJ+st1RV72Kn/+oIuf7wzzIuIBeW0SVpn+CA4fAMjc
         nghoLDnfWj5p1FNVzXMhhZAPOe4B4h3ROK6slK1a/ofnandvCN4c6Hh7IdGpj4/GqIXP
         uH65XyzgTZwBBOucxUUsxi8OJIgS2VscOWoSud2xrWPpsY7OMDf3tVWxMh+0Ta7mT9oR
         51mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680864649; x=1683456649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrRjNsG8dDfUlp/X2GO5GwvyXP0i6VtlSWcC/Gq+Hfw=;
        b=8BexQIYunQNua+Ygas9uGWBsm5wCRyvlc9oSlivNgXLIWqOk/e/8fbyO1F8wjafcMB
         FErDKZdHYh7dUs0d4N3FLj4C+ioe8srSgWDCNNoa1rHJue5/rO07a2YYcpWJ0ghBvHiH
         U9bMYc4S8cO4cSmHKM1sQ3U7q4vgtSuDxheuuXR60+o5tEdZRGFWwcmfKyVIIU0x2he4
         NuUErzIshbM8bsFL3/3dDQemw0KZsLSkrMujEQLWDf/bduUbH7MCMi/a2oxTp1hcSQJa
         wg16Al9avNvfwGpuKxRTpHWNs0Zzdfj6Kfmxk4zsI1UR5Op9oLnmY8fUgbp97njjScwo
         QuTg==
X-Gm-Message-State: AAQBX9fsXhgmDhrq38Du+KIBuR8gMWzoigV8OGIkTdljWN6w7WfeFLEV
        po1SC0EPvCUzYBU0C6+ddMPvMw==
X-Google-Smtp-Source: AKy350b+BQmOqnJesne4N7aX08ZqsSt65sdWZN8Zm9m42DxDMwORLJyYI4kYhyz/J7olP9fEoxiVhA==
X-Received: by 2002:a7b:c7d9:0:b0:3ee:d7f:6676 with SMTP id z25-20020a7bc7d9000000b003ee0d7f6676mr1081052wmk.11.1680864649116;
        Fri, 07 Apr 2023 03:50:49 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b003ede6540190sm8131909wmq.0.2023.04.07.03.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:50:48 -0700 (PDT)
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
Subject: [PATCH v6 6/6] arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node
Date:   Fri,  7 Apr 2023 13:50:29 +0300
Message-Id: <20230407105029.2274111-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407105029.2274111-1-abel.vesa@linaro.org>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for UFS ICE by adding the qcom,ice property and the
ICE dedicated devicetree node. While at it, add the reg-name property
to the UFS HC node to be in line with older platforms.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v5 is here:
https://lore.kernel.org/all/20230403200530.2103099-7-abel.vesa@linaro.org/

Changes since v5:
 * Dropped the reg-names property from UFS node as it was not needed and
   makes the bindings check fail

Changes since v4:
 * none

Changes since v3:
 * none

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d252658c73dd..2b3a721292b6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1932,9 +1932,18 @@ ufs_mem_hc: ufs@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>;
+			qcom,ice = <&ice>;
+
 			status = "disabled";
 		};
 
+		ice: crypto@1d88000 {
+			compatible = "qcom,sm8550-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
-- 
2.34.1

