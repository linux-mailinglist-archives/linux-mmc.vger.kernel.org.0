Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAF2B5A1
	for <lists+linux-mmc@lfdr.de>; Mon, 27 May 2019 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE0MnP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 May 2019 08:43:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38324 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfE0MnP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2019 08:43:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so16809031wrs.5
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2019 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkQUEAAflpHSvleM8C2ksBIOQ078CZvnw80T6no6FBM=;
        b=cYhyX4RGU9ybatqZrlhu3awpU2uOva/ELw1S70I45twlrgLduhdjSDILCuC1PttuTt
         2nJtnJ9EI1+Gte7SaOiKxGN6NlhBzVGUL/5GqcRDlaxjzVt1dbTrMC4fozegF+qfUKor
         +q0HRs8ETsnOjl7w716PMmPAjFsl/TiWsfwRaZiNDXc6w0i+Czz02dK5G84tDs+GVikX
         jODGgnVwh2bNYkz7WTgyPYzc+Zr7ismMmQAxkXvj+QGfdB6q9znUmShuol85jBjPktLe
         gDlNW94XN1zObeIe3AbZ8iqc/xCSY2QCXpFaa2hZGh+54GiHebZMHEanOIok7LxAmBZF
         S9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkQUEAAflpHSvleM8C2ksBIOQ078CZvnw80T6no6FBM=;
        b=BlIvTIfNH3n7fzOXZMhu6DuLZRkQHQv4s9RLY+rwFs6PNoMt4nbYpmdnoFVSdlhM3A
         8vgMWDdSf2eDjw6YmNPIRG3U3aLvXtUJG1vL5wZfwecN/t94ycNpVko+w4IpN+rWs+uS
         bYbr4QILnx7pSqE66IIQz3OWb/xYQ/aehGcaKcLANrwPlON/VfAOP/cVeO7NPlXUz9fe
         qimIRMLnAJvnxty8x9uvkTsEkE1Wh40N/H212iX393WPq2MQt4qnATTvnaA9VqgqvfOW
         Ty30RQ1sc5K7l1e9Fp2v4pmk/kbwQjPE/NCsvdCwQw/x4LLaY6Ce5IzaX1YKGSXF8QGl
         tTxw==
X-Gm-Message-State: APjAAAUgNdrhRSju0fIItJMrafagbvh3JL+9ZndvhY2DnDi8V95FHrzj
        Vw4MATKy4zADMy9uVOomx0XfDQ==
X-Google-Smtp-Source: APXvYqwAZ8oF5h4lEBmdEoFJmg6fDQVHoyhJjYPqNt6yYmssL7+UTOhCpj7xzXiyMOi5Jk9dkPKd0A==
X-Received: by 2002:adf:8385:: with SMTP id 5mr658932wre.194.1558960993541;
        Mon, 27 May 2019 05:43:13 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: g12a: add SDIO controller
Date:   Mon, 27 May 2019 14:43:07 +0200
Message-Id: <20190527124307.32075-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
add the port A (SDIO) pinctrl and controller nodes and mark this specific
controller with the amlogic,dram-access-quirk property.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 9f72396ba710..d1a3da9d0b2e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -202,6 +202,30 @@
 						};
 					};
 
+					sdio_pins: sdio {
+						mux {
+							groups = "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_cmd",
+								 "sdio_clk";
+							function = "sdio";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdio_clk_gate_pins: sdio_clk_gate {
+						mux {
+							groups = "GPIOX_4";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -566,6 +590,19 @@
 			};
 		};
 
+		sd_emmc_a: sd@ffe03000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe03000 0x0 0x800>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,dram-access-quirk;
+		};
+
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.21.0

