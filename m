Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6C23115
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfETKNE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 06:13:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35269 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbfETKNC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 06:13:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so1124800plo.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ap6Go4OzNxJ532m09L3XvGYt1ETDxtVIslcDJHxqhh8=;
        b=dg9voSlkL9Tcl87q88SNV55S8GA0JmQ0duHA+37dyzDY6OcpNFosrqe5mS3YzRmQOK
         KPzF/tT9V0EzWBhy2zsLMNsoshKCx2xZyxd4iwz9E9Z+2nn92gIHu5ZHF9a2rvSKpInj
         ca0v4q6NwLwD/s3f1bL/W4RAqzlQCYCkHWlRExJXrGi1L4hv02Om0lUPuSKo3CmzH1mz
         d34F0kjxLbephXWC09QvmFZSnEu6Ekd6KSVve5DHXWh8KKISDCiIzD1Vjtqw0xlrah4s
         Fmbp7jB3XlkVoe7T9o5bHTcpAiwbDpZHyq8FlWAt8RUnDgGdDJmKqnmM8+kdwtqJT8jL
         8bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ap6Go4OzNxJ532m09L3XvGYt1ETDxtVIslcDJHxqhh8=;
        b=cfFmtLi4L6tsnWaYQPXUS8AvUdRpP/4Fgxi1nNJap8vFD/Ct2qEOPoKXV417zWPTIi
         pmL89tPsxq3fdQDFH5zl4VbWMSwVE8zVAuAKl4qVPcAJDC7Umr7LGtIL2bY4oL13GfSw
         F9hTBvdrcoD3a2dWHFf1Y7He5akSq9Wegorfe5LSn/w0GshFrEQzaSEizivO15/3OUhp
         PavoUGBA9jlwq0DzAk9F79oyGGtOl8i1C2vP4TgioI4BBXNWKF4zpBSceJrNebqYuyAo
         trEObfO5F2DeCjS9V1M9dLxyrePhi4pitaDg7nOxNn9WfLIu4LQOPbLJsKMXHynSY3uw
         h8kA==
X-Gm-Message-State: APjAAAUhWDqVbqxkcLghQvrV3jLsO4qvwwByw7BThmfQJ7sTWd8x8O6V
        K2qOt2QW5eWe0cCcsXdB6rdfoI7I1R6Z2A==
X-Google-Smtp-Source: APXvYqz/VZ5IYWao7ZtNYoD6jisYi4sIXfq0npMXqR3qxjBzeqk+s2PVbN80bOiH+xksI9cdfVZ8gQ==
X-Received: by 2002:a17:902:bb06:: with SMTP id l6mr16803820pls.78.1558347182324;
        Mon, 20 May 2019 03:13:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:13:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: sprd: Add Spreadtrum SD host controller support
Date:   Mon, 20 May 2019 18:12:02 +0800
Message-Id: <7fc6cd63966bda900b07ac9b2156e313a6f2ac17.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
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
index b5c5dce..86ec2b0 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -168,6 +168,34 @@
 				vdd-supply = <&vddusb33>;
 				sprd,vdd-voltage = <3300000>;
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
@@ -310,4 +338,11 @@
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

