Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001DD71838
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfGWM2Q (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 08:28:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGWM2P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 08:28:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so40781879lje.12
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6ezilMvH/w5kf4PPHpJm8BaFG4qv6hP7m8ahOV8pd/Q=;
        b=FiVK1evcjuM8wXacVwRZvfAeYahx220WKcjBmFZTGgu4yWjhaDXvhI9/PDtqJsUgkt
         AzAP1PxUwYWwq7wnYTnKCKo9orOjnr8YZPlDIvu09q3L6ydUx48uv+PRz9LUrc2Ce6mo
         SueBcUMFdgWxEh04YY1uqRboCzmIAWcBi57BPAUjS9QPMQIpDzjhPlZM4Tf32L8L8b0f
         dooTbUbdwo9flHuK6wxuVch+1FvtY1P2q0DUw3JRt0xCraXn5bTiGehcCcfreG1moCBz
         l51VASPDyDdWAh/RQp7yh0GYbT95ugfgUGptIFuKGGrBklWTbYNg24jGQu89rbqFmx2b
         TBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ezilMvH/w5kf4PPHpJm8BaFG4qv6hP7m8ahOV8pd/Q=;
        b=ak1YjlN/E2EosixiLuDMdMXm6NkkL/tbmFAoobYWzK3pm+SDH8AXB/ctYcV4cQW0Lg
         zr6nhtGXNIjBFfKZdwMS4DhvUbHAFfsj9Vi5lTjMQkeAQS6cKVmkw9GnEvsN97W/8hbO
         XTamBB0QdyU1FLb8nlbhmBrBOG3pG+adXRDdoMT6IpscLv2DagizL9mMTKpvlGbY7zRA
         aSzxaWDHP1sv8HNICOG0HjM90kftiaFMQvR6o01RIWQgA7membKKSdSyCgK7t3PkU8q4
         MIJN4PtfTv8yoXxLHwwkm8+T+r8wgW+vLutzoq8La3Wv79so8TH7KgJvyfoKbmR0MXlA
         P0cQ==
X-Gm-Message-State: APjAAAUVqK43XudB30vuvzc8Gbk6Zay0okFqYVZZcbceN62bfAvRL5vp
        NVoNIWsa28G/DZ/DnJiKBnaCxU5PgcA=
X-Google-Smtp-Source: APXvYqz4w8yuR150ig5RvdNxLtFsIjwP/sIfc4ufbRFnna+PbGlDGxmtRQ7eP0XEC2EjMck5XAHWIw==
X-Received: by 2002:a2e:94cb:: with SMTP id r11mr37468986ljh.212.1563884893149;
        Tue, 23 Jul 2019 05:28:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 25sm7979971ljn.62.2019.07.23.05.28.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:28:12 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3] mmc: mmci: Clarify comments and some code for busy detection
Date:   Tue, 23 Jul 2019 14:28:09 +0200
Message-Id: <20190723122809.17509-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The code dealing with busy detection is somewhat complicated. In a way to
make it a bit clearer, let's try to clarify the comments in the code about
it.

Additionally, move the part for clearing the so called busy start IRQ, to
the place where the IRQ is actually delivered. Ideally, this should make
the code a bit more robust.

Finally, to improve understanding of the code and the sequence of the busy
detection, move the corresponding code around a bit in mmci_cmd_irq().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Move some code arround to make it even more clear how the busy
	detection works. Updated the changelog accordingly.

---
 drivers/mmc/host/mmci.c | 69 ++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 356833a606d5..4c35e7609c89 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1222,47 +1222,58 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
 		return;
 
-	/*
-	 * ST Micro variant: handle busy detection.
-	 */
+	/* Handle busy detection on DAT0 if the variant supports it. */
 	if (busy_resp && host->variant->busy_detect) {
 
-		/* We are busy with a command, return */
-		if (host->busy_status &&
-		    (status & host->variant->busy_detect_flag))
-			return;
-
 		/*
-		 * We were not busy, but we now got a busy response on
-		 * something that was not an error, and we double-check
-		 * that the special busy status bit is still set before
-		 * proceeding.
+		 * Before unmasking for the busy end IRQ, confirm that the
+		 * command was sent successfully. To keep track of having a
+		 * command in-progress, waiting for busy signaling to end,
+		 * store the status in host->busy_status.
+		 *
+		 * Note that, the card may need a couple of clock cycles before
+		 * it starts signaling busy on DAT0, hence re-read the
+		 * MMCISTATUS register here, to allow the busy bit to be set.
+		 * Potentially we may even need to poll the register for a
+		 * while, to allow it to be set, but tests indicates that it
+		 * isn't needed.
 		 */
 		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
-			/* Clear the busy start IRQ */
-			writel(host->variant->busy_detect_mask,
-			       host->base + MMCICLEAR);
-
-			/* Unmask the busy end IRQ */
 			writel(readl(base + MMCIMASK0) |
 			       host->variant->busy_detect_mask,
 			       base + MMCIMASK0);
-			/*
-			 * Now cache the last response status code (until
-			 * the busy bit goes low), and return.
-			 */
+
 			host->busy_status =
 				status & (MCI_CMDSENT|MCI_CMDRESPEND);
 			return;
 		}
 
 		/*
-		 * At this point we are not busy with a command, we have
-		 * not received a new busy request, clear and mask the busy
-		 * end IRQ and fall through to process the IRQ.
+		 * If there is a command in-progress that has been successfully
+		 * sent, then bail out if busy status is set and wait for the
+		 * busy end IRQ.
+		 *
+		 * Note that, the HW triggers an IRQ on both edges while
+		 * monitoring DAT0 for busy completion, but there is only one
+		 * status bit in MMCISTATUS for the busy state. Therefore
+		 * both the start and the end interrupts needs to be cleared,
+		 * one after the other. So, clear the busy start IRQ here.
+		 */
+		if (host->busy_status &&
+		    (status & host->variant->busy_detect_flag)) {
+			writel(host->variant->busy_detect_mask,
+			       host->base + MMCICLEAR);
+			return;
+		}
+
+		/*
+		 * If there is a command in-progress that has been successfully
+		 * sent and the busy bit isn't set, it means we have received
+		 * the busy end IRQ. Clear and mask the IRQ, then continue to
+		 * process the command.
 		 */
 		if (host->busy_status) {
 
@@ -1508,14 +1519,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * We intentionally clear the MCI_ST_CARDBUSY IRQ (if it's
-		 * enabled) in mmci_cmd_irq() function where ST Micro busy
-		 * detection variant is handled. Considering the HW seems to be
-		 * triggering the IRQ on both edges while monitoring DAT0 for
-		 * busy completion and that same status bit is used to monitor
-		 * start and end of busy detection, special care must be taken
-		 * to make sure that both start and end interrupts are always
-		 * cleared one after the other.
+		 * Busy detection is managed by mmci_cmd_irq(), including to
+		 * clear the corresponding IRQ.
 		 */
 		status &= readl(host->base + MMCIMASK0);
 		if (host->variant->busy_detect)
-- 
2.17.1

