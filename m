Return-Path: <linux-mmc+bounces-4247-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E89995151
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E79B2A507
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF51DFE0A;
	Tue,  8 Oct 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLw0WCLo"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060F1DFD80
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396387; cv=none; b=C9snsJuK/OlDONzi7URFRUqP21n3P77lpTnOcr12r+VpaQBYAgRUsyVB4S9rcW87Yo/WMCU9AXyg9NNFtD0SbbWpTQrPo2zy9QxDqnbReemcX+l9iImbwQbX7hJYVrHQNloU5kxARBSnGs07e+jHVSJdCOrM/vzfI3QlgUS2lTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396387; c=relaxed/simple;
	bh=/wepMDnYlUXv/rY1mPSzvHM7+ihzA4MTCC5rPo7Ip/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvsUfyO1HN4hluHbtTqi8UIA3rMucg04wLbB6bBBfEoQb0qj4bQnAkPkivCNSwEL5kTgkrU6M8w6WZ7ziw3FZCJJ3vO0ktefQvl+3ylbkjak2xe1/EinxoHfTMAO4RWjZGaxDZ01+5Fth5PTAPXvG49LQyH8JLoRAQDySxz7xGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLw0WCLo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a995f56ea2dso277753266b.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728396384; x=1729001184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yby2pAJQGQQ4BLv4UmAUtT0Ab6F1CguJYAAc/ZeZG0w=;
        b=tLw0WCLoPQHxxiQuwwQ0WhpfssYnZZcvNplOc99RT0ZW4EvaYM/6v3hZny3mYQg+3b
         3d6mJ0qrMMySwH6zFYwI6CQSwxspMQ4b9sVbBxsPJTc7N5s5NnrTxIFbM77PpHG+HcgI
         3BrMAwAvg4hEoc2cZW01E5oPJbimXbaDPAAnEeiA6U1gHlK9+HdM7ivadlQJG6nkO9Qm
         1CUvD43Pc7aLAWlXpTKuEUnsZkRGVI3bNGLQ4O7fcilhaLqiQ1uYrrTiReHZinIamRJD
         mEMN9ajaJ6u19/YXPV9ScsLYjWQV1ohi68cdrecV702/7u/sHcubbB8Jmj6XL0C7Wr2o
         r2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396384; x=1729001184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yby2pAJQGQQ4BLv4UmAUtT0Ab6F1CguJYAAc/ZeZG0w=;
        b=FTwiYSZehTXudo9bhkvWBBP3Pu5lzFygQ4tqsCE8n4VlRAdkYiJLgWl3mNwhHjvaVo
         cNLyW/CAeg22dt9BPg11wyKp6IiEYR2NgkAAg5la0MvklX9zRer5B0W+qQivadrBilkB
         bQ3hvUz+iYrEsVv+uFUM99HH9DmdZrdAEaDIkgnlb/ZnwDmjzGt28XKg8PifhoJhIoOe
         gbzqZ8EfRaMRrCm3XaifVvfI7XX4/nfkvq7ImVDplYslrI4bB8MswcP4pWDwYk0aRnZy
         gWKB4tk/HJq+VuQj1ytLHmMuBmRFtSjlp+q775xEQfxA/i01g4/bPqGKmMzfaC7YXmW3
         Ykcw==
X-Forwarded-Encrypted: i=1; AJvYcCXIBsA0o9D225BEyedlCS43nN3sZDreCdJ2k6eRAiYcfvrBvwtmjXUFgJPAxCXdjtBSDe8BQf0MB5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWk2oDKNciIAUFN4N1CzGGpEoZTwy58CNCYNeUAS7EuvanU4W
	UD5Tvv7aL5zJ6ht7xLVyNsOa/9aHP475Mz2Zr2DlA62cKTfjuXBrPsFim+GvjEAel+pt0GjX44z
	J
X-Google-Smtp-Source: AGHT+IHSb8VGy5xIfpBZZPl9Eg1HcJczEG/WofH8sxPb3vzyCLZuxljudG0QqV6qpmiODgrsijvVbw==
X-Received: by 2002:a17:907:84d:b0:a86:799d:f8d1 with SMTP id a640c23a62f3a-a991c0282c1mr1567397366b.47.1728396384159;
        Tue, 08 Oct 2024 07:06:24 -0700 (PDT)
Received: from [127.0.1.1] ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f50fcd4sm320714266b.171.2024.10.08.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:06:23 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 08 Oct 2024 17:05:56 +0300
Subject: [PATCH 2/4] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-x1e80100-qcp-sdhc-v1-2-dfef4c92ae31@linaro.org>
References: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
In-Reply-To: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=/wepMDnYlUXv/rY1mPSzvHM7+ihzA4MTCC5rPo7Ip/s=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnBTxWwyk7TwbA5VUIJ5PUThgEa8mxtt9XCkq4c
 ofkaO5coZKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwU8VgAKCRAbX0TJAJUV
 Vo/ZEADHyqy72IV9raRErouS/AvseAOcY+Wbl+sIu7CIqhnz9cDRNfVhr41QISlYCaHEWlD1wmn
 qcO3qf421jus28seiJRAYuahUiww4Lw8V/aO+HHR+miZTPQNie8TpGqSgPxFOuPt8UDYEd+JJkK
 3mM9IbtGTx3Q6ZLXtADSCN7hHP+mCfgBdnCSidge5z2FvQ2mQmLJ09DXEuvhoEbVGQj2S/Qj4qU
 ocQOLTOiMB4Lz4nQJ1OP5UMOzulCVlYl+VuRUzQm8dPO3t7+oNt+U+MR6igmr39sog/NC8T6MrS
 pCrtfDohZu52++PDSrMZtaCytVUudKehriGjq/P1iS0v2ZvmhjWctOjQhJ3a98tP83x70KqXy/1
 3PtBjuw9Ebt46Wc8mmwKPGtWIUB6AfhnDunPIgf0hdMmK8Mpwef+iWOobtnTaNyugZjJgGQ6CxO
 DguFMv2nNQ7gF0tIzh0sUYZIxQtxM/UoZ3dT2Aq4fm8n0dNuHHTlo297bCxcw3g8pqWMM6LF9Oq
 q+fIdportGOYGHNJslX9aeCUF/+TUgg1h/k1BS9FiDk+IZV0GVzRnq1kTA2dcB02L7VfG/xfszb
 jnROt4MQqMFj617VZKMyL0u3uZ2MyswMTgb6+c5QKmsbTWfCcOTYaXzF62LRa2hbc67msk/yUFo
 6Rthsv2WE46H9KA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Describe the two SHDC v5 controllers found on x1e80100 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 108 +++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a36076e3c56b5b8815eb41ec55e2e1e5bd878201..b835fd87b977ae81f687c4ea15f6f2f89e02e9b1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3880,6 +3880,114 @@ lpass_lpicx_noc: interconnect@7430000 {
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
+			/* Forbid SDR104/SDR50 - broken hw! */
+			sdhci-caps-mask = <0x3 0>;
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
+			/* Forbid SDR104/SDR50 - broken hw! */
+			sdhci-caps-mask = <0x3 0>;
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


