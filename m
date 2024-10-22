Return-Path: <linux-mmc+bounces-4441-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5869AA048
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2024 12:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CA81C21E86
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450E19B5B8;
	Tue, 22 Oct 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcXjZj/H"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29571957E7
	for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593987; cv=none; b=AH8Y2rNsCUQwuu6x9XRLUhTtKobh23Dk/de1YmnTBXTopqMA3IuBoqW79Hd4vkcaJMjzERjM8rjRYywIirU7WXQf9PEjZV2o5eEc/qKuTu5/JDTyuf6kcXeufcAlL5bDzObrvsME2ut9BVsBJrx3P3Q3gHzh84Zy1eGy3mGJ2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593987; c=relaxed/simple;
	bh=4VkCpW8QDcAjyN11pnkcHCM7wZTUs/xHfXdy554thg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwqLt1V0IkhkB5dxdteQMo6FLzCuZ3AlzJvuAQ8QhlwCUMgpvo+Fa3KyrzU/0gTWPtyPCo36MUjbBz33EEZCNahemPIy8g/aeOOZDz78wv7Nh8K+Iohrc2SjenXu5Z391j6xwzotp5D2t7oQFQPKrg823Ua5eASzgm146RFs5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcXjZj/H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so34973095e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729593984; x=1730198784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Pr5xKcTInMzCbHb8CZQ01ukvXjYk9ophuY57YiAzNc=;
        b=xcXjZj/HRLn0zuo3TNhqCaogbMjzDP6bmUZoiybYe00ToE0AmxdW8DUztbxv9bHgxC
         lwePCzCn9HeLAARIQSkaEB6XPO6igh4PeynVP7pcc+RO4bZLXczBD7GbOS0yVx+7Q34w
         tpoxTGmBZAE6CG+QqK4/lRonViJ+CJfNHDFEfEjIEvD/lwY/CAgw0FQnwH3M2ssp3pTf
         zPnatsAnSeTgW4i9ARRGtS5ap4/DuFKHgCXQkl6clb7zJxFVqslipdaLKwog0U+hqD04
         k1EsbOeNmy81aHfocPcI5S/Xb82jSpsfVGoVI8DysZqD3Scw0J3DqrwGKOl2110yxlOi
         MCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593984; x=1730198784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pr5xKcTInMzCbHb8CZQ01ukvXjYk9ophuY57YiAzNc=;
        b=OIIutDDs44HIZHp9oPKz+z69GkhVDiAKrDQ8+o4FAQuqPCjw5qqs4C37fejHODZkHK
         i/u0FifmV+1mcBOErwuUgb+dUBwAoHQ3pqJNHGEwOVALjRgnHADlwlgjPeX8qT9pP8nb
         m4vC/nwauPB6Pw9Cjdfnk/GQz/9bEchiQEUT/eDZ+Hj/eNnsqJoeFnudp1dpuPfMkLI2
         RDNf4rdskVvBmwNKJ0U151e5t3l2lDCq9EBRmKNR4EqnoEiAOHjcF9642EiYV1aF5PGI
         Pcjxd8jjYCtswGoKYdmF/JL2c+FeiemUfTVKtmjLFf46QBr7NGFJ8nbG777baNmwUiGl
         r4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+wxYzvRiIugQ6YsWswQF8QngqEXBsBgnAiEpZJFPGHZZe5BjyZSVGYGeUeVF8GF7O3N9T/mAXW78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxclP9qAWXHweaGzYcICwuE2dLWCtUlkw75Ef+zV3nIJETlTJ5t
	iZWAk/5DIS1xXETZh3u9lL0xMN1sEz6lNXZoNelbyVzVUwSTNBSS1FqRB+FfE6o=
X-Google-Smtp-Source: AGHT+IEsaC2eZFfrXeNE1tDR6XsrsilNtdnVYP8BgfTjCu/2CthN+sAy+qcy7xEnUJWF4B/czSgKXw==
X-Received: by 2002:a05:600c:3b10:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-4317cb0971cmr15795465e9.31.1729593984032;
        Tue, 22 Oct 2024 03:46:24 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37e1asm6351943f8f.20.2024.10.22.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:46:23 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 22 Oct 2024 13:46:08 +0300
Subject: [PATCH v3 1/3] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-x1e80100-qcp-sdhc-v3-1-46c401e32cbf@linaro.org>
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
In-Reply-To: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4VkCpW8QDcAjyN11pnkcHCM7wZTUs/xHfXdy554thg0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnF4J5qyAUVYH/Dph0+LJeRucmSPTn0Rbt2b+EK
 rNvaek0ZYGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxeCeQAKCRAbX0TJAJUV
 VhG5EACAOGslh9f0qDBV/ozVScFaAXUGGn8xPIFIDk3/Rf7PlIu0tS80f557ZwnTD4XzoDKajJp
 ykDUKiR+nRiKCIEMcBb8FNy7ugrzsI7cBDAv6ilPKn97lo1kDVftFIOtXlJ3qxnRXro3cL6S3ry
 GJgbImKqwUqKmRMv7qedCz9wUDgNMYPIhCP5eYd0fxieUivTcxqrASCsbNHPpUbvVZdXUwegfQE
 DoQWXX2bDFhqhctoCw4SaiD0HJ99FNDKLLnWHXz5EPTABtDX+HjKzaPozai1viDP1VZCmz/oG/H
 MT223oOeUg2SMRv4pxy2dD/qGouMK/eJ1i5rLVIY1mAqeOI9dxQRYzqXlLUvegMwduLhTS9jPqX
 UewBvApR/iBHMMRfCXGRpApHobZF/8e46G7J5a9c41t7W9/eAv3c/alTyR0fpUugu8jGy9RVYzh
 QFPpzI1JcuH6e4T366DElha8fAgOxVDLFUTWE3nklQ1eLiWtXxkIkWsy16S+6+VqFYjUQe+YP+Z
 XjMuqxAdodNCa0vYAp8ifL9yBn4TAsexrS70Y9Jw2JCqtq0zeOuF/mO3VM7nZkYtiGAU4vg8SgN
 795F/AP7HsR1DN6Dpb0XsmURLL82mNkmnG3d0sxVcD4DOHqyAOLh2Pqmx7DlRMvllKQyFNnakfn
 zmTS41M7qSm7grw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Describe the two SHDC v5 controllers found on x1e80100 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 0e6802c1d2d8375987c614ec69c440e2f38d25c6..2d0befd6ba0ea11fdf2305d23c0cd8743de303dc 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3887,6 +3887,108 @@ lpass_lpicx_noc: interconnect@7430000 {
 			#interconnect-cells = <2>;
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x520 0>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
+		sdhc_4: mmc@8844000 {
+			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08844000 0 0x1000>;
+
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC4_AHB_CLK>,
+				 <&gcc GCC_SDCC4_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x160 0>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc4_opp_table>;
+
+			interconnects = <&aggre2_noc MASTER_SDCC_4 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_4 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc4_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_2_hsphy: phy@88e0000 {
 			compatible = "qcom,x1e80100-snps-eusb2-phy",
 				     "qcom,sm8550-snps-eusb2-phy";

-- 
2.34.1


