Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C56F3A1AF
	for <lists+linux-mmc@lfdr.de>; Sat,  8 Jun 2019 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfFHTyA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 8 Jun 2019 15:54:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41252 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfFHTyA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2019 15:54:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so2087321plr.8
        for <linux-mmc@vger.kernel.org>; Sat, 08 Jun 2019 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=ZNKNnaGMGaVgsB6saqzXNbHdwK8ecK6V2qujeJjPKUCupMTaia18tRB0i/FPAK/pkf
         OEC2brPo4UrZ9vfr16jMQ7EnvyVggKNxCUtStO9sYqtv3PhOCGuadaM9WNiSDFZ7j+wL
         zG0Ks9wObN0WE5cFRSlxIQO6dQIkLKEjDPzaejITPtby0RkQThH7DupHWMaikg4YSRQ3
         GbM5KUHn3hnMlOWykzGHgP7CsEFzfrHckSR0gHAhI0mFvHkm0V5qCDZ6WguyfTTkynEi
         IZ+OSsMJPRRO2t/8ahMNjnE7Pj2hZAm0hFc04R0C2Cl8MbMEu3mbV1+cS2u991t2NY0m
         gA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=ookm0SjTfGSIHsWeGsIxxzsCGBIYuihsase1DcJv2IpTYvJoVWlPMWo7/aPVODXTVl
         wChe2j689FzeBpGy8eV3CV65MMv/PG+lw1HNy+EsY2KBU7OEwB5KlG5RPDIm2RYDCMh/
         U1SbwkbXOcVcX+GZ9bKvfL+0qNPqhWbuk7lSuQst3Dz69LIECb6P4cF7OBRC5/WqVyg9
         F6ek5cUTKips79xFPmAFOA2QwCjflFwqRzlwiM2wn+EtsVc5VszaVXPjkdLszLgn+kC+
         MX+d3KFlBAGdmpJAVWLH4/TkGMZPwJWP25Rkhcu2OJcTjuOcm6ctr52etuoCIFHqxqTQ
         ninA==
X-Gm-Message-State: APjAAAUc+2KKViAtiGldPuLTuMKTpDnAI8OnlBUw+L6FeZi7Jr0aWXAk
        kHqVhMYyHGJeB262Qso3JwR9
X-Google-Smtp-Source: APXvYqwO3rDHNYyUT1Kr24rYJRbr7NKX6U1twjbeEsyT5midgPAgdhhTi8J34jwrPiO0WZSiOhujhQ==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr33440069plc.186.1560023639563;
        Sat, 08 Jun 2019 12:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:53:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/7] arm64: dts: actions: Add MMC controller support for S900
Date:   Sun,  9 Jun 2019 01:23:13 +0530
Message-Id: <20190608195317.6336-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
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

