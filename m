Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56F96F9D
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfHUCk7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:40:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40305 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfHUCkz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:40:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so470152pls.7
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=AF45FZq/9GIa/RSGGKlY6M1BOYxvVfJ8bVFO2XKZAlJlRX5GB0czlvwCPkIeIgwm9p
         UyN4cOdOloa9yDmFhlq1R5MG4iChc172UUytA9c9inXamtyPkvH/CSwCw4jfBfUvlvfA
         e5XDXtcy91HNpqIJFPlD3F03JPLqaXcTgbSQ27OZ1FaHyr6psIkXoD0N3RlelwlvJNBu
         8jldz8zyPQ7qy+gWZAqr41/t+K+fTg8eg/cbKE4SYJOMgxzAqMz7EBGKzuEyg54qutcs
         HdwSeLjzb5I82RRg9ZDXsGKgvK9Z1yElT9k+/YJutOhW2OAfWEU3d2Nk0zkslnkPlMXX
         Y6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=SusdCf+u6U0PikjKl460bre5dhYedudaZLalPfJ4DkHeASrH91zPKG5gj9b9V9LuHS
         /YIF9PPgZnP9Fh7UiNcfP/Nck4GJjwXZ3iJQLokwg/upTQUiI8XpgGEXEBwVSQcik+/l
         U9IZ8AbP7EaSs/GFWFHkFc7f08ZEN5NRjV1JMY5CeDzeKoARbsleAY3go6tR5h5aANn6
         L3LGpjOFlIjQIc8D8aLH59D+Px7TeuGySCJvaTP1JU5oN+FAlRze3w3HfV58nzUKCO5O
         CSYXgV6Xn8NrLoB4sc7d4RoUpNnx9M4WqbwMmc885xx8IHpXHjFZ9dWsiY7d4mQ2RkIC
         LRZg==
X-Gm-Message-State: APjAAAUY7i1of2Mcry5hgHsbctnuIt9A77nMMB04EZfoeDT1++CReB9n
        ctFO3EXwI2VUyr3uWoo9sZl3
X-Google-Smtp-Source: APXvYqzX351Wmm+kwzgjdUdao7XB7TObisEn5eBl3G9W2w+85A6ymPIpsyrlpxme8Ye0ZdI8AdGnmg==
X-Received: by 2002:a17:902:f217:: with SMTP id gn23mr31247981plb.21.1566355254909;
        Tue, 20 Aug 2019 19:40:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] arm64: dts: actions: Add MMC controller support for S900
Date:   Wed, 21 Aug 2019 08:10:10 +0530
Message-Id: <20190821024014.14070-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MMC controller support for Actions Semi S900 SoC. There are 4 MMC
controllers in this SoC which can be used for accessing SD/MMC/SDIO cards.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index df3a68a3ac97..eb35cf78ab73 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/actions,s900-reset.h>
 
@@ -284,5 +285,49 @@
 			dma-requests = <46>;
 			clocks = <&cmu CLK_DMAC>;
 		};
+
+		mmc0: mmc@e0330000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0330000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@e0334000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0334000 0x0 0x4000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@e0338000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0338000 0x0 0x4000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc3: mmc@e033c000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe033c000 0x0 0x4000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD3>;
+			resets = <&cmu RESET_SD3>;
+			dmas = <&dma 46>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.17.1

