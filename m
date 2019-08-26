Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368349D54B
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfHZSCe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 14:02:34 -0400
Received: from mail.overt.org ([157.230.92.47]:46155 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbfHZSCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Aug 2019 14:02:34 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 232283F246;
        Mon, 26 Aug 2019 13:02:32 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566842552; bh=XPUCkVPr2Rlf7Rklio9IAxD5TQTAnPmAr0qzAzAwYtU=;
        h=From:To:Cc:Subject:Date:From;
        b=OSA3LOKls/8ralTJB4ctpws14KNMrSt6B2QIv/K5lakeb5U46V34H50JBhQY63ZuI
         yR0Rn3k+u1PLfr802sZ2r4A5EWPpn9Fa3iCbs4t3pEgoIJOJSN5AtjPaOYP+IF4FE3
         KA8sstjE8pU7VgQbUhDeYACyRxq8Bnu808CzBsabkCduUeNpTeEvh38NbXseIp3wfH
         5cSz++KVh3MiLssLj4WWkq9ZXUQr755axK3DvwFuBjPj8X02nmqOIsC//Zj/PgIVuH
         ROEw1SJ+5+ATMoRh3TD3Cr9KHVZbyannd17C1ZtFTcdayiCOCK2YUHqJFB3k8NOJBn
         IFypRZrag2egg==
From:   Philip Langdale <philipl@overt.org>
To:     linux-mmc@vger.kernel.org
Cc:     Philip Langdale <philipl@overt.org>
Subject: [PATCH] mmc: rtsx: Don't attempt to use 'Low-Voltage' VDD for SD cards
Date:   Mon, 26 Aug 2019 11:02:22 -0700
Message-Id: <20190826180222.15960-1-philipl@overt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There have been multiple reports of failures for newer SD cards
with Realtek readers using the rtsx_pci_sdmmc driver in recent
months, including myself.

One common theme was that Sandisk A2 cards all failed while older
cards worked fine. The first reports in bugzilla showed up in late
2018 corresponding with the availabilty of these cards.

After some false starts, what I realised was that these new cards
have bit 7 set in OCR which means they claim to support the 'Low
Voltage Range' for VDD. This is an incompletely defined concept
in the SD spec - in fact, there is no precise voltage associated
with the 'Low Voltage Range'. We have to go to the MMC spec to
see that it is 1.65-1.95V.

So, I believe there is currently no legitimate way for an SD
card to operate in the low voltage range, and a card that claims
support by setting bit 7 is simply wrong, although technically
not out of spec. Because the spec doesn't cover how to handle a
card that sets this bit, we really need to act as if the bit is
not set and do normal VDD initialisation.

And, in fact, this is exactly what happens in the sdhci driver.
By default, it elides MMC_VDD_165_195 for SD cards, and there is
core logic that allows different values of ocr_avail for SD and
MMC (and SDIO, even).

As such, an equivalent change should be made in the two rtsx
drivers (pci and usb) to explicitly set ocr_avail_sd, leaving
out the low voltage range.

There's a valid question about whether this elidation should be
moved into the core logic, so that we never try and bring up an
SD card in the low voltage range, for all host controllers.

For now, at least, I'm going to punt on that question and use
the existing infrastructure to fix the driver I can test.

I considered setting ocr_avail_sdio as well, but I noted that
the sdhci driver does not do this implicit elidation in that
case, and so didn't want to make the change blindly; I am not
in a position to test it.

Needless to say, after this change, the Sandisk A2 card works
correctly.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201447
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=202473
Signed-off-by: Philip Langdale <philipl@overt.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++++
 drivers/mmc/host/rtsx_usb_sdmmc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index bd50935dc37d..ff78b2abfe8b 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1342,6 +1342,10 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->f_min = 250000;
 	mmc->f_max = 208000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
+	/* MMC_VDD_165_195 is not really defined for SD cards. Ensure we
+	 * never attempt to initialise a card with the bit set in OCR.
+	 */
+	mmc->ocr_avail_sd = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 81d0dfe553a8..590c7c4c189b 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1311,6 +1311,10 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->f_min = 250000;
 	mmc->f_max = 208000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
+	/* MMC_VDD_165_195 is not really defined for SD cards. Ensure we
+	 * never attempt to initialise a card with the bit set in OCR.
+	 */
+	mmc->ocr_avail_sd = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
-- 
2.20.1

