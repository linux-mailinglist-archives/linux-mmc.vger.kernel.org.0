Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5C6F8177
	for <lists+linux-mmc@lfdr.de>; Fri,  5 May 2023 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjEELRW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 5 May 2023 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjEELRP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 07:17:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55EA1A4A5
        for <linux-mmc@vger.kernel.org>; Fri,  5 May 2023 04:17:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eed764a10cso1855502e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 May 2023 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683285424; x=1685877424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5G0cJUf9U5b39gQ8vAQOCiDix67GOEadK5YgCw6Yxo=;
        b=wxs0KBb51JuDnKAnoY/S3edUOYpY0H+SPYPDCze+MDOmb+fhTmA3ahW60qWs3AFnGH
         911gSlgSQEIzfQrJNnyKGa+PIe4bRd37U3qtqFPteIbRsyciY/cK+yMtEC/Is+6SlPiT
         WzEk5CTi7zst9SHIN/RzA6eYw7YYUHtyEYpa74TZC8pADhZhnC7DPfnp3wVbIQTMseYU
         DH0dWhGbt6ebD65TshcXAeX5Sb03CIaruIKr4kdzJ367KRYBIWCjHIa1roMUnEG/TbcL
         Qn1UkafJOEws6GtC5zpWOLbyq+Q82+2okDwrx8beJPqcP6cpQoX6Gf4eUGoaBcdMxFh2
         4dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683285424; x=1685877424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5G0cJUf9U5b39gQ8vAQOCiDix67GOEadK5YgCw6Yxo=;
        b=WqM/u6JRZd33eotsMLqjT372ULbe6YIhzsdyARVQ8Ssf/eqJNBdDWJs6FHsOBCAp5S
         RKxb3gSfP5TPjfnC4PyFJWqOLRSvHAFzde/PXTZnr5MkukuxF/9N0EPS0TtgKLguQ+yw
         qgSZoqTbw1c1/Xd7cJkceEr0gClwIaRJZfDY7COtm/4grapnLGHKIk5uArt3uYVYwG3H
         IlTGBHn0PgF4so1YW43HoDWoQnfuwliJnw3A63XyL0HC+G1IRTG6dC7lzS/2NElZGnoB
         CMu34U6U8iGGHmASERp8cD0vFayJw5nfdP/qb8kCrU2qUIySH8bdYzk/2a8/vpYg9uJe
         hyOg==
X-Gm-Message-State: AC+VfDwEj31/lX9ddg/1eRRKf/8xWhz2pfFEoAgugA/1yTmMRYInnPV3
        k753n/TQbyCCJZGnmqDciu+OAw==
X-Google-Smtp-Source: ACHHUZ6pmyzS8g8EM3kWs/gqLNsNok0orHUrp/XlT9ma+BM9xCZKgxMO8JuAoLy0oCneRC+SXNvWow==
X-Received: by 2002:ac2:5d65:0:b0:4d8:8ad1:a05f with SMTP id h5-20020ac25d65000000b004d88ad1a05fmr456312lft.48.1683285423744;
        Fri, 05 May 2023 04:17:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b004edbf013fe7sm251665lft.49.2023.05.05.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:17:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 05 May 2023 13:16:57 +0200
Subject: [PATCH v3 3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org>
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
In-Reply-To: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The platform devices on the Nokia 770 is using some
board-specific IRQs that get statically assigned to platform
devices in the boardfile.

This does not work with dynamic IRQ chip bases.

Utilize the NULL device to define some board-specific
GPIO lookups and use these to immediately look up the
same GPIOs, convert to IRQ numbers and pass as resources
to the devices. This is ugly but should work.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-nokia770.c | 57 ++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index dc37ea30bbcf..27bd5522e1de 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -6,7 +6,7 @@
  */
 #include <linux/clkdev.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <linux/kernel.h>
@@ -250,19 +250,25 @@ static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 
 static void __init nokia770_cbus_init(void)
 {
-	const int retu_irq_gpio = 62;
-	const int tahvo_irq_gpio = 40;
-
-	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
-		return;
-	if (gpio_request_one(tahvo_irq_gpio, GPIOF_IN, "Tahvo IRQ")) {
-		gpio_free(retu_irq_gpio);
-		return;
+	struct gpio_desc *d;
+	int irq;
+
+	d = gpiod_get(NULL, "retu_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get CBUS Retu IRQ GPIO descriptor\n");
+	} else {
+		irq = gpiod_to_irq(d);
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+		nokia770_i2c_board_info_2[0].irq = irq;
+	}
+	d = gpiod_get(NULL, "tahvo_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get CBUS Tahvo IRQ GPIO descriptor\n");
+	} else {
+		irq = gpiod_to_irq(d);
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+		nokia770_i2c_board_info_2[1].irq = irq;
 	}
-	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
-	irq_set_irq_type(gpio_to_irq(tahvo_irq_gpio), IRQ_TYPE_EDGE_RISING);
-	nokia770_i2c_board_info_2[0].irq = gpio_to_irq(retu_irq_gpio);
-	nokia770_i2c_board_info_2[1].irq = gpio_to_irq(tahvo_irq_gpio);
 	i2c_register_board_info(2, nokia770_i2c_board_info_2,
 				ARRAY_SIZE(nokia770_i2c_board_info_2));
 	device_create_managed_software_node(&nokia770_cbus_device.dev,
@@ -275,8 +281,25 @@ static void __init nokia770_cbus_init(void)
 }
 #endif /* CONFIG_I2C_CBUS_GPIO */
 
+static struct gpiod_lookup_table nokia770_irq_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		/* GPIO used by SPI device 1 */
+		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for retu IRQ */
+		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for tahvo IRQ */
+		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
+			    GPIO_ACTIVE_HIGH),
+	},
+};
+
 static void __init omap_nokia770_init(void)
 {
+	struct gpio_desc *d;
+
 	/* On Nokia 770, the SleepX signal is masked with an
 	 * MPUIO line by default.  It has to be unmasked for it
 	 * to become functional */
@@ -288,6 +311,14 @@ static void __init omap_nokia770_init(void)
 
 	software_node_register_node_group(nokia770_gpiochip_nodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
+
+	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
+	d = gpiod_get(NULL, "ads7846_irq", GPIOD_IN);
+	if (IS_ERR(d))
+		pr_err("Unable to get ADS7846 IRQ GPIO descriptor\n");
+	else
+		nokia770_spi_board_info[1].irq = gpiod_to_irq(d);
+
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_serial_init();

-- 
2.34.1

