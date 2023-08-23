Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA678558F
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Aug 2023 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjHWKkm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Aug 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjHWKkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Aug 2023 06:40:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBE11F;
        Wed, 23 Aug 2023 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692787239; x=1724323239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nEnU6HQgTr+OJ96k6iL1taeaSIGfTBc0qkVnXIG9DNE=;
  b=dUV9TeYzqZ96SLpLMM1vLHPX31vmO3nq3sOCAmHN1/cSfddhbWzTQm8S
   eBWzgn0cBqqOmpnRxMXGI8EP/8mB6JsBZipZiZdLTFAk6tEcDGY7BzAvt
   vhBFr9JHZz+METAe61cdqjyh5E13/r5QidIRybRenrOBvZokTkEqtfGFe
   OnrZeSEoJt+NhzDwyNghNPXm3hOTeCtvVI1XJV0HseK6yR7f7KFTirsaT
   4EG6fk3Y3fhOINLMDBeg9O0K7qDSwu4oBq+o5cRvnSl6lpSJIyHbV79AF
   WO1vnf4UxuyXqAIuPM1sim2CTMp3GcDpBhms3Lq+dnTBcgCZ920Pckz2i
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="869520"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 03:40:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 03:40:39 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 23 Aug 2023 03:40:33 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v5 1/3] mmc: atmel-mci: Convert to gpio descriptors
Date:   Wed, 23 Aug 2023 16:10:08 +0530
Message-ID: <20230823104010.79107-2-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replace the legacy GPIO APIs with gpio descriptor consumer interface.
To maintain backward compatibility, we rely on the "cd-inverted"
property to manage the invertion flag instead of GPIO property.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 77 +++++++++++++++++-------------------
 include/linux/atmel-mci.h    |  4 +-
 2 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 1f89d02c4685..892d29fed9ec 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -11,14 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
@@ -387,8 +387,8 @@ struct atmel_mci_slot {
 #define ATMCI_CARD_NEED_INIT	1
 #define ATMCI_SHUTDOWN		2
 
-	int			detect_pin;
-	int			wp_pin;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
 	bool			detect_is_active_high;
 
 	struct timer_list	detect_timer;
@@ -636,7 +636,10 @@ atmci_of_init(struct platform_device *pdev)
 			pdata->slot[slot_id].bus_width = 1;
 
 		pdata->slot[slot_id].detect_pin =
-			of_get_named_gpio(cnp, "cd-gpios", 0);
+			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+					      "cd", GPIOD_IN, "cd-gpios");
+		if (IS_ERR(pdata->slot[slot_id].detect_pin))
+			pdata->slot[slot_id].detect_pin = NULL;
 
 		pdata->slot[slot_id].detect_is_active_high =
 			of_property_read_bool(cnp, "cd-inverted");
@@ -645,7 +648,10 @@ atmci_of_init(struct platform_device *pdev)
 			of_property_read_bool(cnp, "non-removable");
 
 		pdata->slot[slot_id].wp_pin =
-			of_get_named_gpio(cnp, "wp-gpios", 0);
+			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+					      "wp", GPIOD_IN, "wp-gpios");
+		if (IS_ERR(pdata->slot[slot_id].wp_pin))
+			pdata->slot[slot_id].wp_pin = NULL;
 	}
 
 	return pdata;
@@ -1508,8 +1514,8 @@ static int atmci_get_ro(struct mmc_host *mmc)
 	int			read_only = -ENOSYS;
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 
-	if (gpio_is_valid(slot->wp_pin)) {
-		read_only = gpio_get_value(slot->wp_pin);
+	if (slot->wp_pin) {
+		read_only = gpiod_get_value(slot->wp_pin);
 		dev_dbg(&mmc->class_dev, "card is %s\n",
 				read_only ? "read-only" : "read-write");
 	}
@@ -1522,8 +1528,8 @@ static int atmci_get_cd(struct mmc_host *mmc)
 	int			present = -ENOSYS;
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 
-	if (gpio_is_valid(slot->detect_pin)) {
-		present = !(gpio_get_value(slot->detect_pin) ^
+	if (slot->detect_pin) {
+		present = !(gpiod_get_raw_value(slot->detect_pin) ^
 			    slot->detect_is_active_high);
 		dev_dbg(&mmc->class_dev, "card is %spresent\n",
 				present ? "" : "not ");
@@ -1636,8 +1642,8 @@ static void atmci_detect_change(struct timer_list *t)
 	if (test_bit(ATMCI_SHUTDOWN, &slot->flags))
 		return;
 
-	enable_irq(gpio_to_irq(slot->detect_pin));
-	present = !(gpio_get_value(slot->detect_pin) ^
+	enable_irq(gpiod_to_irq(slot->detect_pin));
+	present = !(gpiod_get_raw_value(slot->detect_pin) ^
 		    slot->detect_is_active_high);
 	present_old = test_bit(ATMCI_CARD_PRESENT, &slot->flags);
 
@@ -2236,9 +2242,9 @@ static int atmci_init_slot(struct atmel_mci *host,
 	dev_dbg(&mmc->class_dev,
 	        "slot[%u]: bus_width=%u, detect_pin=%d, "
 		"detect_is_active_high=%s, wp_pin=%d\n",
-		id, slot_data->bus_width, slot_data->detect_pin,
+		id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
 		slot_data->detect_is_active_high ? "true" : "false",
-		slot_data->wp_pin);
+		desc_to_gpio(slot_data->wp_pin));
 
 	mmc->ops = &atmci_ops;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
@@ -2274,31 +2280,24 @@ static int atmci_init_slot(struct atmel_mci *host,
 
 	/* Assume card is present initially */
 	set_bit(ATMCI_CARD_PRESENT, &slot->flags);
-	if (gpio_is_valid(slot->detect_pin)) {
-		if (devm_gpio_request(&host->pdev->dev, slot->detect_pin,
-				      "mmc_detect")) {
-			dev_dbg(&mmc->class_dev, "no detect pin available\n");
-			slot->detect_pin = -EBUSY;
-		} else if (gpio_get_value(slot->detect_pin) ^
-				slot->detect_is_active_high) {
+	if (slot->detect_pin) {
+		if (gpiod_get_raw_value(slot->detect_pin) ^
+		    slot->detect_is_active_high) {
 			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
 		}
+	} else {
+		dev_dbg(&mmc->class_dev, "no detect pin available\n");
 	}
 
-	if (!gpio_is_valid(slot->detect_pin)) {
+	if (!slot->detect_pin) {
 		if (slot_data->non_removable)
 			mmc->caps |= MMC_CAP_NONREMOVABLE;
 		else
 			mmc->caps |= MMC_CAP_NEEDS_POLL;
 	}
 
-	if (gpio_is_valid(slot->wp_pin)) {
-		if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
-				      "mmc_wp")) {
-			dev_dbg(&mmc->class_dev, "no WP pin available\n");
-			slot->wp_pin = -EBUSY;
-		}
-	}
+	if (!slot->wp_pin)
+		dev_dbg(&mmc->class_dev, "no WP pin available\n");
 
 	host->slot[id] = slot;
 	mmc_regulator_get_supply(mmc);
@@ -2308,18 +2307,18 @@ static int atmci_init_slot(struct atmel_mci *host,
 		return ret;
 	}
 
-	if (gpio_is_valid(slot->detect_pin)) {
+	if (slot->detect_pin) {
 		timer_setup(&slot->detect_timer, atmci_detect_change, 0);
 
-		ret = request_irq(gpio_to_irq(slot->detect_pin),
-				atmci_detect_interrupt,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"mmc-detect", slot);
+		ret = request_irq(gpiod_to_irq(slot->detect_pin),
+				  atmci_detect_interrupt,
+				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				  "mmc-detect", slot);
 		if (ret) {
 			dev_dbg(&mmc->class_dev,
 				"could not request IRQ %d for detect pin\n",
-				gpio_to_irq(slot->detect_pin));
-			slot->detect_pin = -EBUSY;
+				gpiod_to_irq(slot->detect_pin));
+			slot->detect_pin = NULL;
 		}
 	}
 
@@ -2338,10 +2337,8 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 	mmc_remove_host(slot->mmc);
 
-	if (gpio_is_valid(slot->detect_pin)) {
-		int pin = slot->detect_pin;
-
-		free_irq(gpio_to_irq(pin), slot);
+	if (slot->detect_pin) {
+		free_irq(gpiod_to_irq(slot->detect_pin), slot);
 		del_timer_sync(&slot->detect_timer);
 	}
 
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index 1491af38cc6e..017e7d8f6126 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -26,8 +26,8 @@
  */
 struct mci_slot_pdata {
 	unsigned int		bus_width;
-	int			detect_pin;
-	int			wp_pin;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
 	bool			detect_is_active_high;
 	bool			non_removable;
 };
-- 
2.25.1

