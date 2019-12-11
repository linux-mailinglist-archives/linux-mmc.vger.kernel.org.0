Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B637811A182
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Dec 2019 03:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLKCk7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 10 Dec 2019 21:40:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:49101 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfLKCk6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Dec 2019 21:40:58 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Xh4m5tZ8zr8;
        Wed, 11 Dec 2019 03:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1576032056; bh=2BKpvhlj6oD5VT84hyCgsMikUKEOtDXi13iL2FgPGJ4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=cHE9lspkR9HZMXFL8xn2Qdj9P411LmykVfs5OpZegEp5BbBwYxGkMZ0wksLlHaZFX
         zBOq3Qj3tP6jFCqsm+uqVtS5daRIshXocBIn539m6OKmSN3yZfzbKEb9WHznMpWish
         7hoEjP3beQuQKkIf6mIH+pVNZsa3cKF95qqJJfVXKNw7kYznSz4IfDf/aRw8qcJlqb
         lAUianzK9QU1N8jhOHBTuG0um1uLv8lVcpCrt/TGppT+3dF6eXcEQF7gnUcCDjxgyR
         b+buP9wKZ3B4dyygzn6MDq0a3YeLaR7YuUhB+34ArrdAv/3SBZvyq6yqKUlAmtSJll
         Y3wmGT4CzROOQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Wed, 11 Dec 2019 03:40:56 +0100
Message-Id: <db189b715596d63caf8c6a088bddc71dd69a879b.1576031637.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1576031636.git.mirq-linux@rere.qmqm.pl>
References: <cover.1576031636.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/4] mmc: rework cd-gpio handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There are a few places around the code that invert inverted and possibly
inverted CD line. That's really confusing. Squash them all into one
place in mmc_gpiod_request_cd(). MMC_CAP2_CD_ACTIVE_HIGH is used
analogously to WP line: in GPIO mode it is used only at probe time to
switch polarity, for native mode it is left as is.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpio/gpiolib-of.c    | 17 -----------------
 drivers/mmc/core/host.c      | 21 ++++-----------------
 drivers/mmc/core/slot-gpio.c | 17 ++++++++---------
 3 files changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index b0b77e52e261..8310da48ba01 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -104,23 +104,6 @@ static void of_gpio_flags_quirks(struct device_node *np,
 				 enum of_gpio_flags *flags,
 				 int index)
 {
-	/*
-	 * Handle MMC "cd-inverted" and "wp-inverted" semantics.
-	 */
-	if (IS_ENABLED(CONFIG_MMC)) {
-		/*
-		 * Active low is the default according to the
-		 * SDHCI specification and the device tree
-		 * bindings. However the code in the current
-		 * kernel was written such that the phandle
-		 * flags were always respected, and "cd-inverted"
-		 * would invert the flag from the device phandle.
-		 */
-		if (!strcmp(propname, "cd-gpios")) {
-			if (of_property_read_bool(np, "cd-inverted"))
-				*flags ^= OF_GPIO_ACTIVE_LOW;
-		}
-	}
 	/*
 	 * Some GPIO fixed regulator quirks.
 	 * Note that active low is the default.
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b3484def0a8b..e655dc1b5b85 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -175,7 +175,6 @@ int mmc_of_parse(struct mmc_host *host)
 	struct device *dev = host->parent;
 	u32 bus_width, drv_type, cd_debounce_delay_ms;
 	int ret;
-	bool cd_cap_invert, cd_gpio_invert = false;
 
 	if (!dev || !dev_fwnode(dev))
 		return 0;
@@ -218,10 +217,12 @@ int mmc_of_parse(struct mmc_host *host)
 	 */
 
 	/* Parse Card Detection */
+
 	if (device_property_read_bool(dev, "non-removable")) {
 		host->caps |= MMC_CAP_NONREMOVABLE;
 	} else {
-		cd_cap_invert = device_property_read_bool(dev, "cd-inverted");
+		if (device_property_read_bool(dev, "cd-inverted"))
+			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 
 		if (device_property_read_u32(dev, "cd-debounce-delay-ms",
 					     &cd_debounce_delay_ms))
@@ -232,25 +233,11 @@ int mmc_of_parse(struct mmc_host *host)
 
 		ret = mmc_gpiod_request_cd(host, "cd", 0, false,
 					   cd_debounce_delay_ms * 1000,
-					   &cd_gpio_invert);
+					   NULL);
 		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
 		else if (ret != -ENOENT && ret != -ENOSYS)
 			return ret;
-
-		/*
-		 * There are two ways to flag that the CD line is inverted:
-		 * through the cd-inverted flag and by the GPIO line itself
-		 * being inverted from the GPIO subsystem. This is a leftover
-		 * from the times when the GPIO subsystem did not make it
-		 * possible to flag a line as inverted.
-		 *
-		 * If the capability on the host AND the GPIO line are
-		 * both inverted, the end result is that the CD line is
-		 * not inverted.
-		 */
-		if (cd_cap_invert ^ cd_gpio_invert)
-			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 	}
 
 	/* Parse Write Protection */
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 582ec3d720f6..303e825ecfd8 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -19,7 +19,6 @@
 struct mmc_gpio {
 	struct gpio_desc *ro_gpio;
 	struct gpio_desc *cd_gpio;
-	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
 	char *cd_label;
@@ -80,13 +79,6 @@ int mmc_gpio_get_cd(struct mmc_host *host)
 		return -ENOSYS;
 
 	cansleep = gpiod_cansleep(ctx->cd_gpio);
-	if (ctx->override_cd_active_level) {
-		int value = cansleep ?
-				gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
-				gpiod_get_raw_value(ctx->cd_gpio);
-		return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
-	}
-
 	return cansleep ?
 		gpiod_get_value_cansleep(ctx->cd_gpio) :
 		gpiod_get_value(ctx->cd_gpio);
@@ -194,10 +186,17 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			ctx->cd_debounce_delay_ms = debounce / 1000;
 	}
 
+	/* override forces default (active-low) polarity ... */
+	if (override_active_level && !gpiod_is_active_low(desc))
+		gpiod_toggle_active_low(desc);
+
+	/* ... or active-high */
+	if (host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
+		gpiod_toggle_active_low(desc);
+
 	if (gpio_invert)
 		*gpio_invert = !gpiod_is_active_low(desc);
 
-	ctx->override_cd_active_level = override_active_level;
 	ctx->cd_gpio = desc;
 
 	return 0;
-- 
2.20.1

