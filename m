Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6496FDE
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfHUC5O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:57:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34966 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfHUC5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:57:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so447670pgv.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nH4eH2+AdUUr/ixPubTt3rBpS2s2N2X/tbfYHc3R6f8=;
        b=NzIE7mdVgSIAHWMqUqg85Bd+qBzRmk+eoh7D8r8/UzsJf6/QsENDneugo79OHjjPdR
         tjqVPCPR745uewAAywtYkic8SFdG8LxHzikI7v/WfbYEMF5HxpPP6HWHbJGoKFawBK6Q
         9GdBLOtze6PIjxOBcmSYDNGavDbiM2nr90nauo+B0bXTPMhvfv2m/SECTPhpA1VaGL0d
         PLxSyGXfacd2C5jtZPQPUodeub6K5KSeJo2fOPin1PKKvYhsCjscZF3bM9Kni3tiY2LZ
         Oj1t2U/yC15pQE+MJ6u9UbqBRqKfjpehJEM6roL2O1OFDSjZ7KorZFTYvXIPSDe7Rw1+
         2HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nH4eH2+AdUUr/ixPubTt3rBpS2s2N2X/tbfYHc3R6f8=;
        b=eG9hS9TDLm1C4PLbj+9Y65HokbaEV98lsQLgIwjapBzMh2mU4By4TghsHVUu2tatk2
         JPAaBDOEvtW0LPkz/AAaANRg9GQq6rq5zPp39goPd/fB0SYJc4EdhkPLjH4yrYNvbOVp
         F8HodcAOh0ory303Zv8i6JLu6EWvt6OMTI4t5fXR4CN+XZjxrRdII0/2zX75EdapesPQ
         5kuhQMNIaZJr2dQ3Ma8ZdISj6/Bfq0YbIAnaRNDf2crYhJf0o9HQNcCIeA3+XCSM7lyw
         SoCIzmIomV5/voKqEloeHnWsMVMGBFyKj+hC4YA/NrPNMnwGIVCcXtzCpBOqgs7zbHiE
         UfPg==
X-Gm-Message-State: APjAAAUQdAJmJu43vVT+FN0gIlrX+HNESxdX4kE5eCyPJXT2Of/++/Wg
        QcAcqHUAiiIyJEWz7XOeSsp9
X-Google-Smtp-Source: APXvYqwSVVucV3Ju8A6hU2FYsz3QIbT3ac07Qf8VXg6Vwfyd+8xdo85p39D+jrzsgq9fZuPbF3tbeA==
X-Received: by 2002:aa7:946d:: with SMTP id t13mr34202729pfq.121.1566356231203;
        Tue, 20 Aug 2019 19:57:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:57:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/7] arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
Date:   Wed, 21 Aug 2019 08:26:26 +0530
Message-Id: <20190821025629.15470-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
S900 SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
Since there is no PMIC support added yet, fixed regulator has been
used as a regulator node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/actions/s900-bubblegum-96.dts    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 732daaa6e9d3..59291e0ea1ee 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -12,6 +12,9 @@
 	model = "Bubblegum-96";
 
 	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
 		serial5 = &uart5;
 	};
 
@@ -23,6 +26,24 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	vcc_3v1: vcc-3v1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -241,6 +262,47 @@
 			bias-pull-up;
 		};
 	};
+
+	mmc0_default: mmc0_default {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+	};
+
+	mmc2_default: mmc2_default {
+		pinmux {
+			groups = "nand0_d0_ceb3_mfp";
+			function = "sd2";
+		};
+	};
+};
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&sd_vcc>;
+	vqmmc-supply = <&sd_vcc>;
+};
+
+/* eMMC */
+&mmc2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_default>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	bus-width = <8>;
+	vmmc-supply = <&vcc_3v1>;
 };
 
 &timer {
-- 
2.17.1

