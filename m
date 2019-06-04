Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5077B34178
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfFDIPg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:15:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40142 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfFDIPa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:15:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so9893381pgm.7
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dER5z7AUiZqvyewGFEgnTI66kajUzFaGGa3MWKBcALw=;
        b=vB+Hs12ydRRg7xKl2y5pq42c9TjetjyW0KPP4CLQt1K5QD8u1082ngypqoz/11y6pf
         HsTDlpjOvwfLUalvg4uG96nQ2MLMmkyHNeAodvBKqe1k6KliNxZtqwgdUPx1nRVCDaLS
         d/gpsoMpSCfGI5CUCM+4zoY7lZ6mNNLD4jXkaJ21sHDJsdpjn0SIxSCt9tqmtkfOofB7
         RqQpd+nyHy8bd1NIy3azycy35bMkxl7stgprnj3dhXBUQy7smuGvkPvmCPP9+IRlqzDl
         nw7NJ48xznSFJhLrRThp2Bn4mrOl4dcFT4lxs6ckloBL3l1TfCRU8gfHKoeqhcD/oe+G
         fhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dER5z7AUiZqvyewGFEgnTI66kajUzFaGGa3MWKBcALw=;
        b=KsycEC9ALprpPkn587VL6D0NopVvdGonHy6+UzRetL3xpae9JdqTmEsfYhUEAI/IAN
         TdzSAw+d2AaqyU1c7dJe0EMYHHuNjswmH2PVDXrVHrcCfpUAv3bpuVIAay0qZidy6MZe
         LCdSTnEWSbZtV6W+oRK4P30VJa0fDXxM5ygCtGHcaB5XkJcIe96LiJ5PZlkfoKWGpWAS
         Q6PiwgOdTXWPADcvq5Tizf840qY77T1MCZMp5wxL0kcU3Wno29qzpDSSXL5OeyNcJzsT
         1/dPWlN+/7lXx1DtVkkZU8PqWJUmcZCwOnvub9zJq3lvPOq+MrmmLPmSpAAicgtchV2b
         5DCw==
X-Gm-Message-State: APjAAAWTl5sE9QtayKLqy4xwfQx+tBoCYlX417MFZYuVDbgk1UJ4rZZM
        LaTugzB22wzxYPj4NZ8VjEkirA==
X-Google-Smtp-Source: APXvYqwm5O/KPp7XNf1fWqY832/e4ZO4cZ+12EaAKnp9jkR2KI4E6QiX8CcY/sQ9R+DjpbaetygTiw==
X-Received: by 2002:a17:90a:1a84:: with SMTP id p4mr35971999pjp.15.1559636129484;
        Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: sprd: Add Spreadtrum SD host controller support
Date:   Tue,  4 Jun 2019 16:14:29 +0800
Message-Id: <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add one Spreadtrum SD host controller to support eMMC card for Spreadtrum
SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 4bb862c..79b9591c 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -130,6 +130,34 @@
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
 			};
+
+			sdio3: sdio@50430000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x50430000 0 0x1000>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable", "2x_enable";
+				clocks = <&aon_prediv CLK_EMMC_2X>,
+				       <&apahb_gate CLK_EMMC_EB>,
+				       <&aon_gate CLK_EMMC_2X_EN>;
+				assigned-clocks = <&aon_prediv CLK_EMMC_2X>;
+				assigned-clock-parents = <&clk_l0_409m6>;
+
+				sprd,phy-delay-mmc-hs400 = <0x44 0x7f 0x2e 0x2e>;
+				sprd,phy-delay-mmc-hs200 = <0x0 0x8c 0x8c 0x8c>;
+				sprd,phy-delay-mmc-ddr52 = <0x3f 0x75 0x14 0x14>;
+				sprd,phy-delay-mmc-hs400es = <0x3f 0x3f 0x2e 0x2e>;
+				vmmc-supply = <&vddemmccore>;
+				bus-width = <8>;
+				non-removable;
+				no-sdio;
+				no-sd;
+				cap-mmc-hw-reset;
+				mmc-hs400-enhanced-strobe;
+				mmc-hs400-1_8v;
+				mmc-hs200-1_8v;
+				mmc-ddr-1_8v;
+			};
 		};
 
 		aon {
@@ -272,4 +300,11 @@
 		clock-frequency = <100000000>;
 		clock-output-names = "ext-rco-100m";
 	};
+
+	clk_l0_409m6: clk_l0_409m6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <409600000>;
+		clock-output-names = "ext-409m6";
+	};
 };
-- 
1.7.9.5

