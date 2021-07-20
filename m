Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A53CFD2D
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Jul 2021 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhGTOdK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Jul 2021 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhGTOLY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2021 10:11:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A093C05BD1A
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jul 2021 07:43:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f30so29587891lfv.10
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jul 2021 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbN53T14Om4XknjkJRRVEnLWblLyHxtME7moXS4dvr8=;
        b=tlOG8c948eVNBqB5DFbLF1JTo1JHNM+WESED4vAIJ0j9Tr9Kn+rfZa/ImxE4Zldh7e
         8izJwYmxskV71iIv8NJSH6ZvcBLSYCwbdyZG9qw32PCu/z+XMVPYe93voY1/lHu3nHQP
         sgriZwFWtZvAAy49neXdcLaPqzB+Fbx2zuFmYgBDpq8IPyW8G7ZwNgQAqS9rsPfNjMJx
         D2gLslwsyfrPkPf3pZWFFZ8mU267MOw/t7UEcMfaeTa0i5G5IeeTsgxCadu4X3idVVMf
         xN0mVgSENErsiijghiUBl+Va0Mibjo8dLQNXWmCe2coM3PVCdBPBVIReSszb6FtU/+J3
         joxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbN53T14Om4XknjkJRRVEnLWblLyHxtME7moXS4dvr8=;
        b=V5JH66GN+CHIYr58xUGraVal3I0pMzKgL61FNHbm9TqRbs31Nf0wB/bW0D6PAwbzT9
         7wArygD/KzXw130CECukB7ID8PxDuDHBYoewL30mx152+lGMRPCTG6/FuAR3li4NwAXk
         f0kLZLRZZcBDhWGArLsjOEcnYUOk7o6a+fbKly8A1A0CDROcfJ4tmCqU+DblE6OzpUpX
         cHeGKwcDoGyiAt4ocNbKS4vKSXtHXJbT1VWEvPGpWb4cwIv/qtBHbfdpa/jGa4hImrly
         MXJW9wcw+lf6g19NlSKn8pd50zoXAXHuUdestfgg71/Q1mciy2tr8pkYzLIbu+qMrs/+
         JGMg==
X-Gm-Message-State: AOAM533BL5fjrbviNOvnywRFbGAKqP6tp6pFTgiRtGiEE69Xs5VoZeih
        cQcJ6UHd2+gMu4MURsTStBXuxdlIpFVD6A==
X-Google-Smtp-Source: ABdhPJzy9iOAFQqSn9ImdQm0c07+kEoyTOFN9XM67N75/kdIayCJfde4b2bt+IHSdnu5AkeS+yaYeA==
X-Received: by 2002:a05:6512:92d:: with SMTP id f13mr21954565lft.186.1626792200415;
        Tue, 20 Jul 2021 07:43:20 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g14sm1536550lfv.213.2021.07.20.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:43:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org,
        phone-devel@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>,
        Stephan Gerhold <stephan@gerhold.net>, newbyte@disroot.org
Subject: [PATCH v3] mmc: core: Add a card quirk for non-hw busy detection
Date:   Tue, 20 Jul 2021 16:41:15 +0200
Message-Id: <20210720144115.1525257-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some boot partitions on the Samsung 4GB KLM4G1YE4C "4YMD1R" and "M4G1YC"
cards appear broken when accessed randomly. CMD6 to switch back to the main
partition randomly stalls after CMD18 access to the boot partition 1, and
the card never comes back online. The accesses to the boot partitions work
several times before this happens, but eventually the card access hangs
while initializing the card.

Some problematic eMMC cards are found in the Samsung GT-S7710 (Skomer)
and SGH-I407 (Kyle) mobile phones.

I tried using only single blocks with CMD17 on the boot partitions with the
result that it crashed even faster.

After a bit of root cause analysis it turns out that these old eMMC cards
probably cannot do hardware busy detection (monitoring DAT0) properly.

The card survives on older kernels, but this is because recent kernels have
added busy detection handling for the SoC used in these phones, exposing
the issue.

Construct a quirk that makes the MMC cord avoid using the ->card_busy()
callback if the card is listed with MMC_QUIRK_BROKEN_HW_BUSY_DETECT and
register the known problematic cards. The core changes are pretty
straight-forward with a helper inline to check of we can use hardware
busy detection.

On the MMCI host we have to counter the fact that if the host was able to
use busy detect, it would be used unsolicited in the command IRQ callback.
Rewrite this so that MMCI will not attempt to use hardware busy detection
in the command IRQ until:
- A card is attached to the host and
- We know that the card can handle this busy detection

I have glanced over the ->card_busy() callbacks on some other hosts and
they seem to mostly read a register reflecting the value of DAT0 for this
which works fine with the quirk in this patch. However if the error appear
on other hosts they might need additional fixes.

After applying this patch, the main partition can be accessed and mounted
without problems on Samsung GT-S7710 and SGH-I407.

Fixes: cb0335b778c7 ("mmc: mmci: add busy_complete callback")
Cc: stable@vger.kernel.org
Cc: phone-devel@vger.kernel.org
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Reported-by: newbyte@disroot.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on v5.14-rc1
- Reword the commit message slightly.
ChangeLog v1->v2:
- Rewrite to reflect the actual problem of broken busy detection.
---
 drivers/mmc/core/core.c    |  8 ++++----
 drivers/mmc/core/core.h    | 17 +++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  4 ++--
 drivers/mmc/core/quirks.h  | 21 +++++++++++++++++++++
 drivers/mmc/host/mmci.c    | 22 ++++++++++++++++++++--
 include/linux/mmc/card.h   |  1 +
 6 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 95fedcf56e4a..e08dd9ea3d46 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -232,7 +232,7 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	 * And bypass I/O abort, reset and bus suspend operations.
 	 */
 	if (sdio_is_io_busy(mrq->cmd->opcode, mrq->cmd->arg) &&
-	    host->ops->card_busy) {
+	    mmc_hw_busy_detect(host)) {
 		int tries = 500; /* Wait aprox 500ms at maximum */
 
 		while (host->ops->card_busy(host) && --tries)
@@ -1200,7 +1200,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 	 */
 	if (!host->ops->start_signal_voltage_switch)
 		return -EPERM;
-	if (!host->ops->card_busy)
+	if (!mmc_hw_busy_detect(host))
 		pr_warn("%s: cannot verify signal voltage switch\n",
 			mmc_hostname(host));
 
@@ -1220,7 +1220,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 	 * after the response of cmd11, but wait 1 ms to be sure
 	 */
 	mmc_delay(1);
-	if (host->ops->card_busy && !host->ops->card_busy(host)) {
+	if (mmc_hw_busy_detect(host) && !host->ops->card_busy(host)) {
 		err = -EAGAIN;
 		goto power_cycle;
 	}
@@ -1241,7 +1241,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 	 * Failure to switch is indicated by the card holding
 	 * dat[0:3] low
 	 */
-	if (host->ops->card_busy && host->ops->card_busy(host))
+	if (mmc_hw_busy_detect(host) && host->ops->card_busy(host))
 		err = -EAGAIN;
 
 power_cycle:
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 0c4de2030b3f..6a5619eed4a6 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -181,4 +181,21 @@ static inline int mmc_flush_cache(struct mmc_host *host)
 	return 0;
 }
 
+/**
+ * mmc_hw_busy_detect() - Can we use hw busy detection?
+ * @host: the host in question
+ */
+static inline bool mmc_hw_busy_detect(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	bool has_ops;
+	bool able = true;
+
+	has_ops = (host->ops->card_busy != NULL);
+	if (card)
+		able = !(card->quirks & MMC_QUIRK_BROKEN_HW_BUSY_DETECT);
+
+	return (has_ops && able);
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 973756ed4016..546fc799a8e5 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -435,7 +435,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	u32 status = 0;
 	int err;
 
-	if (host->ops->card_busy) {
+	if (mmc_hw_busy_detect(host)) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
@@ -597,7 +597,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * when it's not allowed to poll by using CMD13, then we need to rely on
 	 * waiting the stated timeout to be sufficient.
 	 */
-	if (!send_status && !host->ops->card_busy) {
+	if (!send_status && !mmc_hw_busy_detect(host)) {
 		mmc_delay(timeout_ms);
 		goto out_tim;
 	}
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index d68e6e513a4f..8da6526f0eb0 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -99,6 +99,27 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Some older Samsung eMMCs have broken hardware busy detection.
+	 * Enabling this feature in the host controller can make the card
+	 * accesses lock up completely.
+	 */
+	MMC_FIXUP("4YMD1R", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	/* Samsung KLMxGxxE4x eMMCs from 2012: 4, 8, 16, 32 and 64 GB */
+	MMC_FIXUP("M4G1YC", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	MMC_FIXUP("M8G1WA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	MMC_FIXUP("MAG2WA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	MMC_FIXUP("MBG4WA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	MMC_FIXUP("MAG2WA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+	MMC_FIXUP("MCG8WA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_HW_BUSY_DETECT),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 984d35055156..3046917b2b67 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -347,6 +347,24 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	return busy;
 }
 
+/* Use this if the MMCI variant AND the card supports it */
+static bool mmci_use_busy_detect(struct mmci_host *host)
+{
+	struct mmc_card *card = host->mmc->card;
+
+	if (!host->variant->busy_detect)
+		return false;
+
+	/* We don't allow this until we know that the card can handle it */
+	if (!card)
+		return false;
+
+	if (card->quirks & MMC_QUIRK_BROKEN_HW_BUSY_DETECT)
+		return false;
+
+	return true;
+}
+
 static void mmci_reg_delay(struct mmci_host *host)
 {
 	/*
@@ -1381,7 +1399,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		return;
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
-	if (busy_resp && host->variant->busy_detect)
+	if (busy_resp && mmci_use_busy_detect(host))
 		if (!host->ops->busy_complete(host, status, err_msk))
 			return;
 
@@ -1725,7 +1743,7 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
 	struct mmci_host *host = mmc_priv(mmc);
 	u32 max_busy_timeout = 0;
 
-	if (!host->variant->busy_detect)
+	if (!mmci_use_busy_detect(host))
 		return;
 
 	if (host->variant->busy_timeout && mmc->actual_clock)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 74e6c0624d27..525a39951c6d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -280,6 +280,7 @@ struct mmc_card {
 						/* for byte mode */
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
+#define MMC_QUIRK_BROKEN_HW_BUSY_DETECT (1<<3)	/* Disable hardware busy detection on DAT0 */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
-- 
2.31.1

