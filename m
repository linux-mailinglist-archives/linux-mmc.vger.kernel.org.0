Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F323047C6
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Jan 2021 20:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbhAZF4q (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Jan 2021 00:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbhAYSmF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 13:42:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A769B206FA;
        Mon, 25 Jan 2021 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611600035;
        bh=G16sIENRX9EMyT17x8UvaimcQGeqHoMJpMYb9LmaK3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxXvobahmBexVbR80EMa8QXk0stwHxVUyECEStOVYqjbcx0CMuqD0ME0i+boBzAdw
         2zPKXSM6mf1nOeVSR4iqUFsLJQPqDF++ogzs/uFCTdYnXGCAXCP8sviUuPMsKSJutq
         k31ny/cXGIsXjd+TxLdhJ9WWRDvfUE1G1zehMv+ctAuYNnwJU2Bxe7aDIp2roLQXOu
         t/Q4+2Lhp6s5xBksAaCe0Y9EqM2sKVh6JbI8S7AXfmp5MFcQL4M6o6NlnKGFKfDeBi
         cpgJxXXo0YUbkRYgmm0ggQc3oxZnxgdOTNbw8vorLY41IVkIy6dcmLn4sS8RDNe4HS
         1BT2mCzktY4yg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH v6 9/9] arm64: dts: qcom: sdm630: add ICE registers and clocks
Date:   Mon, 25 Jan 2021 10:38:10 -0800
Message-Id: <20210125183810.198008-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125183810.198008-1-ebiggers@kernel.org>
References: <20210125183810.198008-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add the registers and clock for the Inline Crypto Engine (ICE) to the
device tree node for the sdhci-msm host controller on sdm630.  This
allows sdhci-msm to support inline encryption on sdm630.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 37d5cc32f6b62..afb3d20c31fa0 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -808,8 +808,9 @@ spmi_bus: spmi@800f000 {
 		sdhc_1: sdhci@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
-				<0x0c0c5000 0x1000>;
-			reg-names = "hc", "cqhci";
+				<0x0c0c5000 0x1000>,
+				<0x0c0c8000 0x8000>;
+			reg-names = "hc", "cqhci", "ice";
 
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
@@ -817,8 +818,9 @@ sdhc_1: sdhci@c0c4000 {
 
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 					<&gcc GCC_SDCC1_AHB_CLK>,
-					<&xo_board>;
-			clock-names = "core", "iface", "xo";
+					<&xo_board>,
+					<&gcc GCC_SDCC1_ICE_CORE_CLK>;
+			clock-names = "core", "iface", "xo", "ice";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on &sdc1_rclk_on>;
-- 
2.30.0

