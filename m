Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9384438F8
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Nov 2021 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKBW7z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 2 Nov 2021 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhKBW7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2021 18:59:47 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA28C061205;
        Tue,  2 Nov 2021 15:57:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gh1so600402qvb.8;
        Tue, 02 Nov 2021 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9xKbMNLb2iOaREpVdAjFb0Duqq69CgGwRHhxD3gHX4=;
        b=qOgXs75c4JAmiwkc7Co1j5ImQmLayRRLHi1S2NYzPNP+xbA4TndvyLpL+pNLdpQP45
         0kD48MUuhqtVmdeRG9a310Ec9EEg6uZ4lI+WeGpQBJD9PgML8s6i3PM2sxOLisb/w4JB
         6WZP7mO3m3qP95a4gqgtPELZBZ5di3GT1XM4RLNJ0HavyELNZwDCec/RCVJ5hIZNKO7Y
         gVF9EPnPVbDqiDBD7BZSg+vcJw/HKKPs1+8zlSH+O8nWyUBn3wchOflIB9aA2YR0lSyf
         x9upOv0TmWXKbEdG7NEVZCMkCnrUActaxWzTQOiBqxgLyc3tFBN8E1Tj2exEGfdTzkSm
         x80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9xKbMNLb2iOaREpVdAjFb0Duqq69CgGwRHhxD3gHX4=;
        b=h4kSeDG5Afolju+LQw+dAEdtGsnN0ZTweg9cbWdSEzDoCqxnl4OqVeSIZx44nsfy+L
         3FDA655GKGXf8QHC1/dEMHLhhV8DfZq5HjgecAsCtC7l3SjMqJ6stQASSHBlb0DZe4N6
         fzdTOFe1vSgqMryPGcIeCEHwjp9NBjL7ORGHlsM9roubJQygys1kQmDRZvL2vd8pfMbI
         Uo/i1OEn+nUsct3yjo3KinY0F+8fFHNEXLf8UHrcs9+BpuIM0agA9PtB7SvO70tduxwN
         vjuE3ZZ75BLqjOciUn67OjpQlmmGyvYE8gWZYfJMYXhoJ9YCgxQ02iIigOcaIpZ+HKic
         VbRw==
X-Gm-Message-State: AOAM530glZ7zkiaCExkBA+ETe7PQfwOL9b8U7Pi1Jdty5S3Dg/3z6j8v
        DyhHZ0QxOkRevZeBXd7M2aA=
X-Google-Smtp-Source: ABdhPJx7PRAS1wxUKZ4XlI22D36H5anBa3Gwnben6vQk/rLUhk2rLuP3JSqPkeuWg4z3Spq143Z8Aw==
X-Received: by 2002:a05:6214:27cd:: with SMTP id ge13mr6659218qvb.40.1635893830814;
        Tue, 02 Nov 2021 15:57:10 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id v19sm351222qtk.6.2021.11.02.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 15:57:10 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 04/13] pinctrl: freescale: Add i.MXRT1050 pinctrl driver support
Date:   Tue,  2 Nov 2021 18:56:52 -0400
Message-Id: <20211102225701.98944-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102225701.98944-1-Mr.Bossman075@gmail.com>
References: <20211102225701.98944-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

Add the pinctrl driver support for i.MXRT1050.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Nothing done
---
 drivers/pinctrl/freescale/Kconfig             |   7 +
 drivers/pinctrl/freescale/Makefile            |   1 +
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c | 349 ++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1050.c

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 21fa21c6547b..8bdafaf40b29 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -173,6 +173,13 @@ config PINCTRL_IMX8ULP
 	help
 	  Say Y here to enable the imx8ulp pinctrl driver
 
+config PINCTRL_IMXRT1050
+	bool "IMXRT1050 pinctrl driver"
+	depends on ARCH_MXC
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imxrt1050 pinctrl driver
+
 config PINCTRL_VF610
 	bool "Freescale Vybrid VF610 pinctrl driver"
 	depends on SOC_VF610
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index c44930b1b362..565a0350bf09 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
 obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
 obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
+obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
diff --git a/drivers/pinctrl/freescale/pinctrl-imxrt1050.c b/drivers/pinctrl/freescale/pinctrl-imxrt1050.c
new file mode 100644
index 000000000000..11f31c90ad30
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-imxrt1050.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020
+ * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-imx.h"
+
+enum imxrt1050_pads {
+	IMXRT1050_PAD_RESERVE0 = 0,
+	IMXRT1050_PAD_RESERVE1 = 1,
+	IMXRT1050_PAD_RESERVE2 = 2,
+	IMXRT1050_PAD_RESERVE3 = 3,
+	IMXRT1050_PAD_RESERVE4 = 4,
+	IMXRT1050_PAD_RESERVE5 = 5,
+	IMXRT1050_PAD_RESERVE6 = 6,
+	IMXRT1050_PAD_RESERVE7 = 7,
+	IMXRT1050_PAD_RESERVE8 = 8,
+	IMXRT1050_PAD_RESERVE9 = 9,
+	IMXRT1050_IOMUXC_GPIO1_IO00 = 10,
+	IMXRT1050_IOMUXC_GPIO1_IO01 = 11,
+	IMXRT1050_IOMUXC_GPIO1_IO02 = 12,
+	IMXRT1050_IOMUXC_GPIO1_IO03 = 13,
+	IMXRT1050_IOMUXC_GPIO1_IO04 = 14,
+	IMXRT1050_IOMUXC_GPIO1_IO05 = 15,
+	IMXRT1050_IOMUXC_GPIO1_IO06 = 16,
+	IMXRT1050_IOMUXC_GPIO1_IO07 = 17,
+	IMXRT1050_IOMUXC_GPIO1_IO08 = 18,
+	IMXRT1050_IOMUXC_GPIO1_IO09 = 19,
+	IMXRT1050_IOMUXC_GPIO1_IO10 = 20,
+	IMXRT1050_IOMUXC_GPIO1_IO11 = 21,
+	IMXRT1050_IOMUXC_GPIO1_IO12 = 22,
+	IMXRT1050_IOMUXC_GPIO1_IO13 = 23,
+	IMXRT1050_IOMUXC_GPIO1_IO14 = 24,
+	IMXRT1050_IOMUXC_GPIO1_IO15 = 25,
+	IMXRT1050_IOMUXC_ENET_MDC = 26,
+	IMXRT1050_IOMUXC_ENET_MDIO = 27,
+	IMXRT1050_IOMUXC_ENET_TD3 = 28,
+	IMXRT1050_IOMUXC_ENET_TD2 = 29,
+	IMXRT1050_IOMUXC_ENET_TD1 = 30,
+	IMXRT1050_IOMUXC_ENET_TD0 = 31,
+	IMXRT1050_IOMUXC_ENET_TX_CTL = 32,
+	IMXRT1050_IOMUXC_ENET_TXC = 33,
+	IMXRT1050_IOMUXC_ENET_RX_CTL = 34,
+	IMXRT1050_IOMUXC_ENET_RXC = 35,
+	IMXRT1050_IOMUXC_ENET_RD0 = 36,
+	IMXRT1050_IOMUXC_ENET_RD1 = 37,
+	IMXRT1050_IOMUXC_ENET_RD2 = 38,
+	IMXRT1050_IOMUXC_ENET_RD3 = 39,
+	IMXRT1050_IOMUXC_SD1_CLK = 40,
+	IMXRT1050_IOMUXC_SD1_CMD = 41,
+	IMXRT1050_IOMUXC_SD1_DATA0 = 42,
+	IMXRT1050_IOMUXC_SD1_DATA1 = 43,
+	IMXRT1050_IOMUXC_SD1_DATA2 = 44,
+	IMXRT1050_IOMUXC_SD1_DATA3 = 45,
+	IMXRT1050_IOMUXC_SD1_DATA4 = 46,
+	IMXRT1050_IOMUXC_SD1_DATA5 = 47,
+	IMXRT1050_IOMUXC_SD1_DATA6 = 48,
+	IMXRT1050_IOMUXC_SD1_DATA7 = 49,
+	IMXRT1050_IOMUXC_SD1_RESET_B = 50,
+	IMXRT1050_IOMUXC_SD1_STROBE = 51,
+	IMXRT1050_IOMUXC_SD2_CD_B = 52,
+	IMXRT1050_IOMUXC_SD2_CLK = 53,
+	IMXRT1050_IOMUXC_SD2_CMD = 54,
+	IMXRT1050_IOMUXC_SD2_DATA0 = 55,
+	IMXRT1050_IOMUXC_SD2_DATA1 = 56,
+	IMXRT1050_IOMUXC_SD2_DATA2 = 57,
+	IMXRT1050_IOMUXC_SD2_DATA3 = 58,
+	IMXRT1050_IOMUXC_SD2_RESET_B = 59,
+	IMXRT1050_IOMUXC_SD2_WP = 60,
+	IMXRT1050_IOMUXC_NAND_ALE = 61,
+	IMXRT1050_IOMUXC_NAND_CE0 = 62,
+	IMXRT1050_IOMUXC_NAND_CE1 = 63,
+	IMXRT1050_IOMUXC_NAND_CE2 = 64,
+	IMXRT1050_IOMUXC_NAND_CE3 = 65,
+	IMXRT1050_IOMUXC_NAND_CLE = 66,
+	IMXRT1050_IOMUXC_NAND_DATA00 = 67,
+	IMXRT1050_IOMUXC_NAND_DATA01 = 68,
+	IMXRT1050_IOMUXC_NAND_DATA02 = 69,
+	IMXRT1050_IOMUXC_NAND_DATA03 = 70,
+	IMXRT1050_IOMUXC_NAND_DATA04 = 71,
+	IMXRT1050_IOMUXC_NAND_DATA05 = 72,
+	IMXRT1050_IOMUXC_NAND_DATA06 = 73,
+	IMXRT1050_IOMUXC_NAND_DATA07 = 74,
+	IMXRT1050_IOMUXC_NAND_DQS = 75,
+	IMXRT1050_IOMUXC_NAND_RE_B = 76,
+	IMXRT1050_IOMUXC_NAND_READY_B = 77,
+	IMXRT1050_IOMUXC_NAND_WE_B = 78,
+	IMXRT1050_IOMUXC_NAND_WP_B = 79,
+	IMXRT1050_IOMUXC_SAI5_RXFS = 80,
+	IMXRT1050_IOMUXC_SAI5_RXC = 81,
+	IMXRT1050_IOMUXC_SAI5_RXD0 = 82,
+	IMXRT1050_IOMUXC_SAI5_RXD1 = 83,
+	IMXRT1050_IOMUXC_SAI5_RXD2 = 84,
+	IMXRT1050_IOMUXC_SAI5_RXD3 = 85,
+	IMXRT1050_IOMUXC_SAI5_MCLK = 86,
+	IMXRT1050_IOMUXC_SAI1_RXFS = 87,
+	IMXRT1050_IOMUXC_SAI1_RXC = 88,
+	IMXRT1050_IOMUXC_SAI1_RXD0 = 89,
+	IMXRT1050_IOMUXC_SAI1_RXD1 = 90,
+	IMXRT1050_IOMUXC_SAI1_RXD2 = 91,
+	IMXRT1050_IOMUXC_SAI1_RXD3 = 92,
+	IMXRT1050_IOMUXC_SAI1_RXD4 = 93,
+	IMXRT1050_IOMUXC_SAI1_RXD5 = 94,
+	IMXRT1050_IOMUXC_SAI1_RXD6 = 95,
+	IMXRT1050_IOMUXC_SAI1_RXD7 = 96,
+	IMXRT1050_IOMUXC_SAI1_TXFS = 97,
+	IMXRT1050_IOMUXC_SAI1_TXC = 98,
+	IMXRT1050_IOMUXC_SAI1_TXD0 = 99,
+	IMXRT1050_IOMUXC_SAI1_TXD1 = 100,
+	IMXRT1050_IOMUXC_SAI1_TXD2 = 101,
+	IMXRT1050_IOMUXC_SAI1_TXD3 = 102,
+	IMXRT1050_IOMUXC_SAI1_TXD4 = 103,
+	IMXRT1050_IOMUXC_SAI1_TXD5 = 104,
+	IMXRT1050_IOMUXC_SAI1_TXD6 = 105,
+	IMXRT1050_IOMUXC_SAI1_TXD7 = 106,
+	IMXRT1050_IOMUXC_SAI1_MCLK = 107,
+	IMXRT1050_IOMUXC_SAI2_RXFS = 108,
+	IMXRT1050_IOMUXC_SAI2_RXC = 109,
+	IMXRT1050_IOMUXC_SAI2_RXD0 = 110,
+	IMXRT1050_IOMUXC_SAI2_TXFS = 111,
+	IMXRT1050_IOMUXC_SAI2_TXC = 112,
+	IMXRT1050_IOMUXC_SAI2_TXD0 = 113,
+	IMXRT1050_IOMUXC_SAI2_MCLK = 114,
+	IMXRT1050_IOMUXC_SAI3_RXFS = 115,
+	IMXRT1050_IOMUXC_SAI3_RXC = 116,
+	IMXRT1050_IOMUXC_SAI3_RXD = 117,
+	IMXRT1050_IOMUXC_SAI3_TXFS = 118,
+	IMXRT1050_IOMUXC_SAI3_TXC = 119,
+	IMXRT1050_IOMUXC_SAI3_TXD = 120,
+	IMXRT1050_IOMUXC_SAI3_MCLK = 121,
+	IMXRT1050_IOMUXC_SPDIF_TX = 122,
+	IMXRT1050_IOMUXC_SPDIF_RX = 123,
+	IMXRT1050_IOMUXC_SPDIF_EXT_CLK = 124,
+	IMXRT1050_IOMUXC_ECSPI1_SCLK = 125,
+	IMXRT1050_IOMUXC_ECSPI1_MOSI = 126,
+	IMXRT1050_IOMUXC_ECSPI1_MISO = 127,
+	IMXRT1050_IOMUXC_ECSPI1_SS0 = 128,
+	IMXRT1050_IOMUXC_ECSPI2_SCLK = 129,
+	IMXRT1050_IOMUXC_ECSPI2_MOSI = 130,
+	IMXRT1050_IOMUXC_ECSPI2_MISO = 131,
+	IMXRT1050_IOMUXC_ECSPI2_SS0 = 132,
+	IMXRT1050_IOMUXC_I2C1_SCL = 133,
+	IMXRT1050_IOMUXC_I2C1_SDA = 134,
+	IMXRT1050_IOMUXC_I2C2_SCL = 135,
+	IMXRT1050_IOMUXC_I2C2_SDA = 136,
+	IMXRT1050_IOMUXC_I2C3_SCL = 137,
+	IMXRT1050_IOMUXC_I2C3_SDA = 138,
+	IMXRT1050_IOMUXC_I2C4_SCL = 139,
+	IMXRT1050_IOMUXC_I2C4_SDA = 140,
+	IMXRT1050_IOMUXC_UART1_RXD = 141,
+	IMXRT1050_IOMUXC_UART1_TXD = 142,
+	IMXRT1050_IOMUXC_UART2_RXD = 143,
+	IMXRT1050_IOMUXC_UART2_TXD = 144,
+	IMXRT1050_IOMUXC_UART3_RXD = 145,
+	IMXRT1050_IOMUXC_UART3_TXD = 146,
+	IMXRT1050_IOMUXC_UART4_RXD = 147,
+	IMXRT1050_IOMUXC_UART4_TXD = 148,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc imxrt1050_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE0),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE1),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE2),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE3),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE4),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE5),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE6),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE7),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE8),
+	IMX_PINCTRL_PIN(IMXRT1050_PAD_RESERVE9),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO00),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO01),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO02),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO03),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO04),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO05),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO06),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO07),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO08),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO09),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO10),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO11),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO12),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO13),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO14),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_GPIO1_IO15),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_MDC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_MDIO),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TD3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TD2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TD1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TX_CTL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_TXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RX_CTL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RD1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RD2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ENET_RD3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_CLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_CMD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA4),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA5),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA6),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_DATA7),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_RESET_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD1_STROBE),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_CD_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_CLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_CMD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_DATA0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_DATA1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_DATA2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_DATA3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_RESET_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SD2_WP),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_ALE),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_CE0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_CE1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_CE2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_CE3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_CLE),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA00),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA01),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA02),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA03),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA04),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA05),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA06),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DATA07),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_DQS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_RE_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_READY_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_WE_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_NAND_WP_B),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXD1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXD2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_RXD3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI5_MCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD4),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD5),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD6),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_RXD7),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD1),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD2),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD3),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD4),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD5),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD6),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_TXD7),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI1_MCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_RXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_RXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_RXD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_TXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_TXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_TXD0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI2_MCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_RXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_RXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_RXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_TXFS),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_TXC),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_TXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SAI3_MCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SPDIF_TX),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SPDIF_RX),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_SPDIF_EXT_CLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI1_SCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI1_MOSI),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI1_MISO),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI1_SS0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI2_SCLK),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI2_MOSI),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI2_MISO),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_ECSPI2_SS0),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C1_SCL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C1_SDA),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C2_SCL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C2_SDA),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C3_SCL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C3_SDA),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C4_SCL),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_I2C4_SDA),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART1_RXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART1_TXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART2_RXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART2_TXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART3_RXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART3_TXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART4_RXD),
+	IMX_PINCTRL_PIN(IMXRT1050_IOMUXC_UART4_TXD),
+};
+
+static const struct imx_pinctrl_soc_info imxrt1050_pinctrl_info = {
+	.pins = imxrt1050_pinctrl_pads,
+	.npins = ARRAY_SIZE(imxrt1050_pinctrl_pads),
+	.gpr_compatible = "fsl,imxrt1050-iomuxc-gpr",
+};
+
+static const struct of_device_id imxrt1050_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imxrt1050-iomuxc", .data = &imxrt1050_pinctrl_info, },
+	{ /* sentinel */ }
+};
+
+static int imxrt1050_pinctrl_probe(struct platform_device *pdev)
+{
+	return imx_pinctrl_probe(pdev, &imxrt1050_pinctrl_info);
+}
+
+static struct platform_driver imxrt1050_pinctrl_driver = {
+	.driver = {
+		.name = "imxrt1050-pinctrl",
+		.of_match_table = of_match_ptr(imxrt1050_pinctrl_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = imxrt1050_pinctrl_probe,
+};
+
+static int __init imxrt1050_pinctrl_init(void)
+{
+	return platform_driver_register(&imxrt1050_pinctrl_driver);
+}
+arch_initcall(imxrt1050_pinctrl_init);
-- 
2.33.1

