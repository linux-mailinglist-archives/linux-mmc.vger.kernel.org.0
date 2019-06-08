Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49A23A1B3
	for <lists+linux-mmc@lfdr.de>; Sat,  8 Jun 2019 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFHTyI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 8 Jun 2019 15:54:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39433 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfFHTyI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2019 15:54:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so3031572pfe.6
        for <linux-mmc@vger.kernel.org>; Sat, 08 Jun 2019 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XpMZFRZzyjrvKa6MiNS3nj5D2wr/GZuHVNnpChhgBew=;
        b=tnwLNtQSWIcN1GWkYya6TEicR1plRzZSpEhodiIXgdFONkHoZSMV6CN56vul1iLXg6
         aatOECCTQ6kM4mlLc+7OpK023jqNzPi02mnXhH4qTeMHyVQdNGnMcFCEBwxmZS5l9EMN
         Z5ccLf/J2Y8D7jBYEdhO4HUXAVpkdxkXgH9qBCfRwSMqTbwt8JfQeWBKNqZZudc94g/L
         nSm7oMQL/qqR5gWYXJ7ePsO98hxehnFpGvWiNobjsuruf082YMIlNnwas+njWmBf+u3C
         scAEpJvz9Lg00u7aIk5PxfhqN+uzXL+ARfOR3MRotfO0Ouc+s96M/XJp1Vf1dMO58A0G
         u3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XpMZFRZzyjrvKa6MiNS3nj5D2wr/GZuHVNnpChhgBew=;
        b=O7ibbtLAmrOgxqSGkq0Q9A2HcVaZeTFGM2hhzbu4tdSW0T0zri4nzk5e0gynbu0KM3
         qlhkk+VfZOdibxVth++PB9e5tKkgXWlKMIUZxUVRcCFosQ/1+7MMDNgmeXCKaNC6NV0e
         Tt0+PJ8UnUaefs/WYp6qmcASSKeln57TrchiTH9fKhGABkp5KgPj7QXTaDm9kOO8j8s3
         qebTFpLEREF4KK9UwbZXMA6gN+GhZUUH/gTLhl4O6pYz1s4DCdYZPxSVVNYCos5/sRyj
         NNV0W6Xpon+WghzBN9ohXrbcEPLe1Z+irHQwNGLTcwRfh2uejdsmH0uHUTY1GTLUd4Q5
         rPAg==
X-Gm-Message-State: APjAAAVcLHQTgFiTI9sAi84UNx7aTXvbX5F7Q4Up4yfsxtdKRsA2pPzP
        Fjx3Wh16gmBhzPM7pTeSwFbn
X-Google-Smtp-Source: APXvYqzv6fejPrj7wJ/aQHxyLJUur6M3xTxJLG3IDcac6YVSTdsseFEOFSZ14VVA2do49rHCjgbMag==
X-Received: by 2002:a63:84c1:: with SMTP id k184mr6683151pgd.7.1560023647269;
        Sat, 08 Jun 2019 12:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:54:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/7] arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
Date:   Sun,  9 Jun 2019 01:23:14 +0530
Message-Id: <20190608195317.6336-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
Owl SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
Since there is no PMIC support added yet, fixed regulator has been
used as a regulator node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/actions/s900-bubblegum-96.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 732daaa6e9d3..3b596d72de25 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -13,6 +13,9 @@
 
 	aliases {
 		serial5 = &uart5;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
 	};
 
 	chosen {
@@ -23,6 +26,14 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reg_3p1v: regulator-3p1v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -241,6 +252,45 @@
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
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3p1v>;
+	vqmmc-supply = <&reg_3p1v>;
+};
+
+&mmc2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_default>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	bus-width = <8>;
+	vmmc-supply = <&reg_3p1v>;
 };
 
 &timer {
-- 
2.17.1

