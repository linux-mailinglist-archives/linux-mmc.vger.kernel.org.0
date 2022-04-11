Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E284FB875
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Apr 2022 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbiDKJyG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Apr 2022 05:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345016AbiDKJxM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 05:53:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C94198E;
        Mon, 11 Apr 2022 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649670652; x=1681206652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=i/ljBsm2MD9nNiXlMhM5SAGKdRLtBR+dGXw5lsuABgE=;
  b=w3U0bygSIeN40QIFOXYESB0GQx5A6VhfrdFu+0bLD0oAKgULgH0XnyKR
   ysH6avxAbjaBZ9L/bcOtub1Sbqc8ZWuwhpKtSnVstvcWKewyfeZOD8HJV
   /4MpLq2VGU6izE2W7JnMmwm+Kzy6j73WILD01seUMbvJh+X9Y6i8Jw2Xh
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:51 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 02:50:49 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:27 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 82DCC3A9B; Mon, 11 Apr 2022 15:20:26 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 6/7] ARM: dts: qcom: sdx65: Add support for TCSR Mutex
Date:   Mon, 11 Apr 2022 15:20:14 +0530
Message-Id: <1649670615-21268-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add TCSR Mutex node to support Qualcomm Hardware Mutex block
on SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index f50a8a4..210e55c 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -137,6 +137,12 @@
 			status = "disabled";
 		};
 
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01f40000 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
 		sdhc_1: sdhci@8804000 {
 			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
-- 
2.7.4

