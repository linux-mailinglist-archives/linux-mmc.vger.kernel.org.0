Return-Path: <linux-mmc+bounces-800-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03408844A84
	for <lists+linux-mmc@lfdr.de>; Wed, 31 Jan 2024 22:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0E01F2387D
	for <lists+linux-mmc@lfdr.de>; Wed, 31 Jan 2024 21:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDA3C68A;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="viutQ6d7"
X-Original-To: linux-mmc@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938363BB26;
	Wed, 31 Jan 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737849; cv=none; b=Abmk8E0RDiTaI/6Jsu2wcYk9aeJC+vGV/OoxWu5lkFvSB7JX083c6/9iqC6CN3LaLy4m6SZnny7aAfAyb7EhNxlPSPDHDZD1TWDNv7bhncaKJeBdBOMkGA84zUZagbnICyxcoJhNiPIUyC/9fyy2I07RIabxCwoNb7WD9wVN7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737849; c=relaxed/simple;
	bh=ozx45uWxrCAD8biJznKOg2fUHzpp5yBKaZqmNT8jl1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTBCRNzakk+FT6+cNDyKzakVhvwXvHYW7tFhDdeyBHjO7Y9nF3gwo39x34PeSUm85wWbnpp1ofLj4Qt3jUjz652RdAeUjPhvnpGREONlP9oG4+UViqKo/1MNFikZgEpVBWR0LW9RgwQvTYwciT0NvGWhEHpJgNfgQHIihKL001Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=viutQ6d7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoj8F002565;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=ugnovuvILABZ0ZJFtTH/+SVuzpvHAsjEQKW9wrwBvaw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=viutQ6d7YCgZYwyzXztPCGg1CIbZjAGorBC4CM9MQW5UjBq0xaV1b2o+haR1pX5+0
	 I6ZekY5JgXKthnKIKQcKKzsDKtgc/MtCgDvrbkrD17Wi8f1Ia+TM7fqUSq/QQkGJlA
	 yJrxXzk06/PufxnmCjGwHeU0j2MjJN2Kgd11OoCo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLojuB006411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig3062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 1/5] mmc: sdhci_am654: Add tuning algorithm for delay chain
Date: Wed, 31 Jan 2024 15:50:40 -0600
Message-ID: <20240131215044.3163469-2-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131215044.3163469-1-jm@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently the sdhci_am654 driver only supports one tuning
algorithm which should be used only when DLL is enabled. The
ITAPDLY is selected from the largest passing window and the
buffer is viewed as a circular buffer.

The new algorithm should be used when the delay chain
is enabled. The ITAPDLY is selected from the largest passing
window and the buffer is not viewed as a circular buffer.

This implementation is based off of the following paper: [1].

Also add support for multiple failing windows.

[1] https://www.ti.com/lit/an/spract9/spract9.pdf

Fixes: 13ebeae68ac9 ("mmc: sdhci_am654: Add support for software tuning")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 128 +++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d659c59422e1..a3798c9912f6 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -149,10 +149,17 @@ struct sdhci_am654_data {
 	int strb_sel;
 	u32 flags;
 	u32 quirks;
+	bool dll_enable;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
+struct window {
+	u8 start;
+	u8 end;
+	u8 length;
+};
+
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
@@ -290,10 +297,13 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
+	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
-	else
+		sdhci_am654->dll_enable = true;
+	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
+		sdhci_am654->dll_enable = false;
+	}
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
@@ -408,39 +418,117 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX 31
+static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+			  *fail_window, u8 num_fails, bool circular_buffer)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	struct window pass_window, first_fail, last_fail;
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	int prev_end_fail = -1;
+	u8 i;
+
+	memset(&pass_window, 0, sizeof(pass_window));
+	memset(&first_fail, 0, sizeof(first_fail));
+	memset(&last_fail, 0, sizeof(last_fail));
+
+	if (!num_fails) {
+		itap = ITAPDLY_LAST_INDEX >> 1;
+	} else if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_err(dev, "No passing ITAPDLY, return 0\n");
+		itap = 0;
+	} else {
+		for (i = 0; i < num_fails; i++) {
+			start_fail = fail_window[i].start;
+			end_fail = fail_window[i].end;
+
+			if (i == 0) {
+				first_fail.start = start_fail;
+				first_fail.end = end_fail;
+				first_fail.length = fail_window[0].length;
+			}
+
+			if (i == num_fails - 1) {
+				last_fail.start = start_fail;
+				last_fail.end = end_fail;
+				last_fail.length = fail_window[i].length;
+			}
+
+			pass_length = start_fail - (prev_end_fail + 1);
+			if (pass_length > pass_window.length) {
+				pass_window.start = prev_end_fail + 1;
+				pass_window.length = pass_length;
+			}
+			prev_end_fail = end_fail;
+		}
+
+		if (!circular_buffer) {
+			if (ITAPDLY_LAST_INDEX - end_fail > pass_window.length) {
+				pass_window.start = end_fail + 1;
+				pass_window.length = ITAPDLY_LAST_INDEX - end_fail;
+			}
+		} else {
+			pass_length = ITAPDLY_LAST_INDEX - end_fail + first_fail.start;
+			if (pass_length > pass_window.length) {
+				pass_window.start = last_fail.end + 1;
+				pass_window.length = pass_length;
+			}
+		}
+
+		if (!circular_buffer)
+			itap = pass_window.start + (pass_window.length >> 1);
+		else
+			itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+		if (itap < 0 || itap > ITAPDLY_LAST_INDEX)
+			itap = 0;
+	}
+
+	return itap;
+}
+
 static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 					       u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
-	u32 itap;
+	struct window fail_window[ITAPDLY_LENGTH];
+	u8 prev_pass = 1;
+	u8 fail_index = 0;
+	u8 curr_pass, itap;
+
+	memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);
 
 	/* Enable ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
 			   1 << ITAPDLYENA_SHIFT);
 
-	for (itap = 0; itap < ITAP_MAX; itap++) {
+	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
 		sdhci_am654_write_itapdly(sdhci_am654, itap);
 
-		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
-		if (cur_val && !prev_val)
-			pass_window = itap;
+		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
-		if (!cur_val)
-			fail_len++;
+		if (!curr_pass && prev_pass)
+			fail_window[fail_index].start = itap;
 
-		prev_val = cur_val;
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
+
+		if (curr_pass && !prev_pass)
+			fail_index++;
+
+		prev_pass = curr_pass;
 	}
-	/*
-	 * Having determined the length of the failing window and start of
-	 * the passing window calculate the length of the passing window and
-	 * set the final value halfway through it considering the range as a
-	 * circular buffer
-	 */
-	pass_len = ITAP_MAX - fail_len;
-	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
+
+	if (fail_window[fail_index].length != 0)
+		fail_index++;
+
+	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					  (sdhci_am654->dll_enable ? true : false));
+
 	sdhci_am654_write_itapdly(sdhci_am654, itap);
 
 	return 0;
-- 
2.34.1


