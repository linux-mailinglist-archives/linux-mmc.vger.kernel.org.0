Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D6504FA2
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Apr 2022 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiDRMBX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 18 Apr 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiDRMBW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 08:01:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7D1A3BD
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s17so1325766plg.9
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1BOU4wLrBlTMYDjgnWwiu/JosONym0WOrkivxHT0F8=;
        b=BVo5/yyPQK1ZmYphBw/Z+c/T5P1m4lYGyHmUSSpcfQgSRHkRZb9CQRyaNG/NFx+9k5
         zME2wnF0D/eD2ZMkqG5PEkKESKVa9nyPmPO71hofyT9vigLBkv5t5BvOckHFI0AfRg/f
         04b76T4l4L8P2IcByGGIrTQDbZnibqUEDPCWOAKNAlhVIgtJ17LmqhHXaYEULZb68qdX
         OtGuP/8velVjcWx8H1paQ7IOGAGmXF1MyWpJNxCwkOJ05GnNB4GVWWskmwYYuFNv6N+z
         TNrYNtV1f+0P3MkKv+2V7v6psvH8YEfI7UjAoKpYjWLohpIDbzOGO82quaNciuOG9mPZ
         ENYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1BOU4wLrBlTMYDjgnWwiu/JosONym0WOrkivxHT0F8=;
        b=4KQJXqkpRz1XjLNw8mBaM7/ZNxdwcIQ/ZfLS8Q+FsvMQCxVzWhh2mOz6fuyjVsqQwo
         q8OVE4c+95L1At3FZpktYv4DQ17S7AIE8Zy2qbaQDrB6g6jWDbcdoCczP9Y7t3XuBGVq
         nF5S3Nm0Iob4P0saWW94sYCCi4t1aV+5lYZoVLn2OOYnz6DQHRBsgeYFf9M21k0S5BNx
         X7pJftWSyGGKj0wffuUhfYl/Xjggzn3x+S/qNfTn+jJCv1N3a2HsD8cINeagAeChuMIU
         TZ8cZA4GGMAApfsqtu74+X7+hR64LJkzqWkKIpEW6wYzTvuQ4F11D7vpAfclhS20fxvk
         5F+g==
X-Gm-Message-State: AOAM530or6JcQYlv3yVBWrapZAvZC4Mz0nZsEoTxGjPJM4eaScGRHmSS
        mt7250vE3So4/g6r0M9oUIY=
X-Google-Smtp-Source: ABdhPJzJ8gQuWQDxQgjuZ06+7OLvICkYFOI2c56zfhUeWeZo1k11CHvVqO7+VWCsxaSR2fQIyXDZ6A==
X-Received: by 2002:a17:902:ec8e:b0:158:fefd:a2c2 with SMTP id x14-20020a170902ec8e00b00158fefda2c2mr4341136plg.85.1650283123186;
        Mon, 18 Apr 2022 04:58:43 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm12409749pfc.101.2022.04.18.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:58:43 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        Tim.Hsieh@genesyslogic.com.tw
Subject: [PATCH V4 2/6] mmc: core: Prepare to support SD UHS-II cards
Date:   Mon, 18 Apr 2022 19:58:29 +0800
Message-Id: <20220418115833.10738-3-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Updates in V4:
 - Re-based, updated a comment and removed white-space.
 - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.

Update in previous version:
The SD UHS-II interface was introduced to the SD spec v4.00 several years
ago. The interface is fundamentally different from an electrical and a
protocol point of view, comparing to the legacy SD interface.

However, the legacy SD protocol is supported through a specific transport
layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
SD card to be managed in a very similar way as a legacy SD card, hence a
lot of code can be re-used to support these new types of cards through the
mmc subsystem.

Moreover, an SD card that supports the UHS-II interface shall also be
backwards compatible with the legacy SD interface, which allows a UHS-II
card to be inserted into a legacy slot. As a matter of fact, this is
already supported by mmc subsystem as of today.

To prepare to add support for UHS-II, this change puts the basic foundation
in the mmc core in place, allowing it to be more easily reviewed before
subsequent changes implements the actual support.

Basically, the approach here adds a new UHS-II bus_ops type and adds a
separate initialization path for the UHS-II card. The intent is to avoid us
from sprinkling the legacy initialization path, but also to simplify
implementation of the UHS-II specific bits.

At this point, there is only one new host ops added to manage the various
ios settings needed for UHS-II. Additional host ops that are needed, are
being added from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/Makefile  |   2 +-
 drivers/mmc/core/core.c    |  17 ++-
 drivers/mmc/core/core.h    |   1 +
 drivers/mmc/core/sd_uhs2.c | 289 +++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |   7 +
 include/linux/mmc/host.h   |  19 +++
 6 files changed, 333 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 6a907736cd7a..15b067e8b0d1 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_MMC)		+= mmc_core.o
 mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
-				   sdio_cis.o sdio_io.o sdio_irq.o \
+				   sdio_cis.o sdio_io.o sdio_irq.o sd_uhs2.o\
 				   slot-gpio.o regulator.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..fc3d8d61a97c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2230,6 +2230,18 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}
 
+	/*
+	 * Ideally we should favor initialization of legacy SD cards and defer
+	 * UHS-II enumeration. However, it seems like cards doesn't reliably
+	 * announce their support for UHS-II in the response to the ACMD41,
+	 * while initializing the legacy SD interface. Therefore, let's start
+	 * with UHS-II for now.
+	 */
+	if (!mmc_attach_sd_uhs2(host)) {
+		mmc_release_host(host);
+		goto out;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		unsigned int freq = freqs[i];
 		if (freq > host->f_max) {
@@ -2251,10 +2263,13 @@ void mmc_rescan(struct work_struct *work)
 
 void mmc_start_host(struct mmc_host *host)
 {
+	bool power_up = !(host->caps2 &
+			 (MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_SD_UHS2));
+
 	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
 	host->rescan_disable = 0;
 
-	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
+	if (power_up) {
 		mmc_claim_host(host);
 		mmc_power_up(host, host->ocr_avail);
 		mmc_release_host(host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index f5f3f623ea49..2d80afc95e58 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -81,6 +81,7 @@ int mmc_detect_card_removed(struct mmc_host *host);
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
+int mmc_attach_sd_uhs2(struct mmc_host *host);
 
 /* Module parameters */
 extern bool use_spi_crc;
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
new file mode 100644
index 000000000000..800957f74632
--- /dev/null
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * Support for SD UHS-II cards
+ */
+#include <linux/err.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include "core.h"
+#include "bus.h"
+#include "sd.h"
+#include "mmc_ops.h"
+
+static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
+
+static int sd_uhs2_set_ios(struct mmc_host *host)
+{
+	struct mmc_ios *ios = &host->ios;
+
+	return host->ops->uhs2_set_ios(host, ios);
+}
+
+static int sd_uhs2_power_up(struct mmc_host *host)
+{
+	host->ios.vdd = fls(host->ocr_avail) - 1;
+	host->ios.clock = host->f_init;
+	host->ios.timing = MMC_TIMING_SD_UHS2;
+	host->ios.power_mode = MMC_POWER_UP;
+
+	return sd_uhs2_set_ios(host);
+}
+
+static void sd_uhs2_power_off(struct mmc_host *host)
+{
+	host->ios.vdd = 0;
+	host->ios.clock = 0;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.power_mode = MMC_POWER_OFF;
+
+	sd_uhs2_set_ios(host);
+}
+
+/*
+ * Run the phy initialization sequence, which mainly relies on the UHS-II host
+ * to check that we reach the expected electrical state, between the host and
+ * the card.
+ */
+static int sd_uhs2_phy_init(struct mmc_host *host)
+{
+	return 0;
+}
+
+/*
+ * Do the early initialization of the card, by sending the device init broadcast
+ * command and wait for the process to be completed.
+ */
+static int sd_uhs2_dev_init(struct mmc_host *host)
+{
+	return 0;
+}
+
+/*
+ * Run the enumeration process by sending the enumerate command to the card.
+ * Note that, we currently support only the point to point connection, which
+ * means only one card can be attached per host/slot.
+ */
+static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
+{
+	return 0;
+}
+
+/*
+ * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
+ * commands and by parsing the responses. Store a copy of the relevant data in
+ * card->uhs2_config.
+ */
+static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Based on the card's and host's UHS-II capabilities, let's update the
+ * configuration of the card and the host. This may also include to move to a
+ * greater speed range/mode. Depending on the updated configuration, we may need
+ * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
+ *
+ * In the final step, let's check if the card signals "config completion", which
+ * indicates that the card has moved from config state into active state.
+ */
+static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
+ * commands/requests to be backwards compatible through the legacy SD protocol.
+ * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
+ * be set through a legacy CMD6. Note that, the power limit that becomes set,
+ * survives a soft reset through the GO_DORMANT_STATE command.
+ */
+static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Allocate the data structure for the mmc_card and run the UHS-II specific
+ * initialization sequence.
+ */
+static int sd_uhs2_init_card(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	u32 node_id;
+	int err;
+
+	err = sd_uhs2_dev_init(host);
+	if (err)
+		return err;
+
+	err = sd_uhs2_enum(host, &node_id);
+	if (err)
+		return err;
+
+	card = mmc_alloc_card(host, &sd_type);
+	if (IS_ERR(card))
+		return PTR_ERR(card);
+
+	card->uhs2_config.node_id = node_id;
+	card->type = MMC_TYPE_SD;
+
+	err = sd_uhs2_config_read(host, card);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_config_write(host, card);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_legacy_init(host, card);
+	if (err)
+		goto err;
+
+	host->card = card;
+	return 0;
+
+err:
+	mmc_remove_card(card);
+	return err;
+}
+
+static void sd_uhs2_remove(struct mmc_host *host)
+{
+	mmc_remove_card(host->card);
+	host->card = NULL;
+}
+
+static int sd_uhs2_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+static void sd_uhs2_detect(struct mmc_host *host)
+{
+	int err;
+
+	mmc_get_card(host->card, NULL);
+	err = _mmc_detect_card_removed(host);
+	mmc_put_card(host->card, NULL);
+
+	if (err) {
+		sd_uhs2_remove(host);
+
+		mmc_claim_host(host);
+		mmc_detach_bus(host);
+		sd_uhs2_power_off(host);
+		mmc_release_host(host);
+	}
+}
+
+static int sd_uhs2_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_shutdown(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_hw_reset(struct mmc_host *host)
+{
+	return 0;
+}
+
+static const struct mmc_bus_ops sd_uhs2_ops = {
+	.remove = sd_uhs2_remove,
+	.alive = sd_uhs2_alive,
+	.detect = sd_uhs2_detect,
+	.suspend = sd_uhs2_suspend,
+	.resume = sd_uhs2_resume,
+	.runtime_suspend = sd_uhs2_runtime_suspend,
+	.runtime_resume = sd_uhs2_runtime_resume,
+	.shutdown = sd_uhs2_shutdown,
+	.hw_reset = sd_uhs2_hw_reset,
+};
+
+static int sd_uhs2_attach(struct mmc_host *host)
+{
+	int err;
+
+	err = sd_uhs2_power_up(host);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_phy_init(host);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_init_card(host);
+	if (err)
+		goto err;
+
+	mmc_attach_bus(host, &sd_uhs2_ops);
+
+	mmc_release_host(host);
+
+	err = mmc_add_card(host->card);
+	if (err)
+		goto remove_card;
+
+	mmc_claim_host(host);
+	return 0;
+
+remove_card:
+	mmc_remove_card(host->card);
+	host->card = NULL;
+	mmc_claim_host(host);
+	mmc_detach_bus(host);
+err:
+	sd_uhs2_power_off(host);
+	return err;
+}
+
+int mmc_attach_sd_uhs2(struct mmc_host *host)
+{
+	int i, err = 0;
+
+	if (!(host->caps2 & MMC_CAP2_SD_UHS2))
+		return -EOPNOTSUPP;
+
+	/* Turn off the legacy SD interface before trying with UHS-II. */
+	mmc_power_off(host);
+
+	/*
+	 * Start UHS-II initialization at 52MHz and possibly make a retry at
+	 * 26MHz according to the spec. It's required that the host driver
+	 * validates ios->clock, to set a rate within the correct range.
+	 */
+	for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
+		host->f_init = sd_uhs2_freqs[i];
+		err = sd_uhs2_attach(host);
+		if (!err)
+			break;
+	}
+
+	return err;
+}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f975875102..610577d531c3 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -211,6 +211,11 @@ struct sd_ext_reg {
 #define SD_EXT_PERF_CMD_QUEUE	(1<<4)
 };
 
+struct sd_uhs2_config {
+	u32			node_id;
+	/* TODO: Extend with more register configs. */
+};
+
 struct sdio_cccr {
 	unsigned int		sdio_vsn;
 	unsigned int		sd_vsn;
@@ -315,6 +320,8 @@ struct mmc_card {
 	struct sd_ext_reg	ext_power;	/* SD extension reg for PM */
 	struct sd_ext_reg	ext_perf;	/* SD extension reg for PERF */
 
+	struct sd_uhs2_config	uhs2_config;	/* SD UHS-II config */
+
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
 	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
 	struct sdio_cccr	cccr;		/* common card info */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7afb57cab00b..765469de8650 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -63,6 +63,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_HS400	10
 #define MMC_TIMING_SD_EXP	11
 #define MMC_TIMING_SD_EXP_1_2V	12
+#define MMC_TIMING_SD_UHS2	13
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -91,6 +92,10 @@ struct mmc_clk_phase_map {
 	struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
 };
 
+struct sd_uhs2_caps {
+	/* TODO: Add UHS-II capabilities for the host. */
+};
+
 struct mmc_host;
 
 struct mmc_host_ops {
@@ -126,6 +131,17 @@ struct mmc_host_ops {
 	 */
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
 
+	/*
+	 * The uhs2_set_ios callback is mandatory to implement for hosts that
+	 * supports the SD UHS-II interface (MMC_CAP2_SD_UHS2), while the
+	 * callback is unused for the other cases. Note that, the struct
+	 * mmc_ios is being re-used for this as well.
+	 *
+	 * Expected return values for the uhs2_set_ios callback are a negative
+	 * errno in case of a failure or zero for success.
+	 */
+	int	(*uhs2_set_ios)(struct mmc_host *host, struct mmc_ios *ios);
+
 	/*
 	 * Return values for the get_ro callback should be:
 	 *   0 for a read/write card
@@ -377,6 +393,7 @@ struct mmc_host {
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */
 #define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */
+#define MMC_CAP2_SD_UHS2	(1 << 9)	/* SD UHS-II support */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
@@ -403,6 +420,8 @@ struct mmc_host {
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
 
+	struct sd_uhs2_caps	uhs2_caps;	/* Host UHS-II capabilities */
+
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
-- 
2.35.1

