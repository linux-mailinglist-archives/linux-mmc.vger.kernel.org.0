Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461CD11EFD9
	for <lists+linux-mmc@lfdr.de>; Sat, 14 Dec 2019 03:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLNB75 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Dec 2019 20:59:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29808 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfLNB74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2019 20:59:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576288795; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HZ2+FORy0LJouWVTz5kp4Nj+EV5Rk3gE2y6r8T20LU0=; b=I/V8n0RKDl4Gb5Yw/Crn3cBGQVID47MsjrwzKy8pffrqVBBxsYX4P1iKLjwdnS6IwTmLffhE
 Z60d9YcDNj7rxx7Aspr7DRIUG/FgAv6/p7WOz0mUPmUW4ry6FKnrET/8SrXIfLMh2pIZT6ZF
 Mjd1kH1ULc9gvbZ+e7CVz+1/RjY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df440eb.7f45213a97d8-smtp-out-n02;
 Sat, 14 Dec 2019 01:54:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24AC2C447A2; Sat, 14 Dec 2019 01:54:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C742EC433CB;
        Sat, 14 Dec 2019 01:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C742EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH V2] arm64: dts: qcom: sc7180: Add nodes for eMMC and SD card
Date:   Sat, 14 Dec 2019 07:24:34 +0530
Message-Id: <1576288475-7606-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sdhc instances for supporting eMMC and SD-card on sc7180.
The regulators should be in HPM state for proper functionality of
eMMC and SD-card. Updating corresponding regulators accordingly.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---

This depends on the patch series (dt support for sc7180):
https://lkml.org/lkml/2019/11/8/149
Also depends on documentation commit 2078158 (Present on mmc-next)

Changes since V1:
	- Updated the regulator min, max voltages as per
	  eMMC/SD-card voltage requirements
	- Enabled IOMMU for eMMC and SD-card.
	- Added pull and drive strength to SD-card cd-gpio.
	- Incorporated review comments by Matthias Kaehlcke.
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  47 +++++++---
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 148 ++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 189254f..b6d4dc1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7180.dtsi"
 #include "pm6150.dtsi"
@@ -101,9 +102,9 @@
 		};
 
 		vreg_l12a_1p8: ldo12 {
-			regulator-min-microvolt = <1696000>;
-			regulator-max-microvolt = <1952000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13a_1p8: ldo13 {
@@ -143,9 +144,9 @@
 		};
 
 		vreg_l19a_2p9: ldo19 {
-			regulator-min-microvolt = <2696000>;
-			regulator-max-microvolt = <3304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 
@@ -189,9 +190,9 @@
 		};
 
 		vreg_l6c_2p9: ldo6 {
-			regulator-min-microvolt = <2696000>;
-			regulator-max-microvolt = <3304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7c_3p0: ldo7 {
@@ -207,9 +208,9 @@
 		};
 
 		vreg_l9c_2p9: ldo9 {
-			regulator-min-microvolt = <2952000>;
-			regulator-max-microvolt = <3304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l10c_3p3: ldo10 {
@@ -400,3 +401,25 @@
 			bias-pull-up;
 		};
 };
+
+&sdhc_1 {
+	status = "ok";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
+	vmmc-supply = <&vreg_l19a_2p9>;
+	vqmmc-supply = <&vreg_l12a_1p8>;
+};
+
+&sdhc_2 {
+	status = "ok";
+
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
+	vmmc-supply  = <&vreg_l9c_2p9>;
+	vqmmc-supply = <&vreg_l6c_2p9>;
+
+	cd-gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 666e9b9..16de9b8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -182,6 +182,32 @@
 			#power-domain-cells = <1>;
 		};
 
+		sdhc_1: sdhci@7c4000 {
+			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x7c4000 0 0x1000>;
+			reg-names = "hc_mem";
+
+			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+					<&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+
+			iommus = <&apps_smmu 0x60 0x0>;
+
+			bus-width = <8>;
+			non-removable;
+
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-hs400-1_8v;
+			mmc-hs400-enhanced-strobe;
+
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x6000>;
@@ -897,6 +923,128 @@
 					function = "qup15";
 				};
 			};
+
+			sdc1_on: sdc1-on {
+				clk {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_off: sdc1-off {
+				clk {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc2_on: sdc2_on {
+				clk {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				sd-cd {
+					pins = "gpio69";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			sdc2_off: sdc2_off {
+				clk {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				sd-cd {
+					pins = "gpio69";
+					bias-disable;
+					drive-strength = <2>;
+				};
+			};
+		};
+
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+			reg-names = "hc_mem";
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+					<&gcc GCC_SDCC2_AHB_CLK>;
+			clock-names = "core", "iface";
+
+			iommus = <&apps_smmu 0x80 0>;
+
+			bus-width = <4>;
+
+			status = "disabled";
 		};
 
 		qspi: spi@88dc000 {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
