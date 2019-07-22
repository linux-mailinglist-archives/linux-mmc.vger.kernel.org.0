Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4406FE92
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfGVLN2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 07:13:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47061 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfGVLN2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 07:13:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so22048306lfh.13
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fG5xC73GGxW5G93GYyScyfvWRfK/bWju5nJg9wNvhj0=;
        b=hQRAVZoA01fNr0kY3FNMK4mFMbLXNHDkQAiENNQG19awT/pJ4bkfZZZOxhzknmFckF
         JNVfoizAPvo4dg7eqA2rU8m+D6qBKqKD5yMzqTsxnFjNdkiqwCK/l2a6uel+K5Rq5Eli
         n6YyJ5GQXCMWmPQ+8WjT374l+mVLFgqpafdxxEBSeFjjCJ9IXNaQn7q7+5stllYXNY6D
         nH1a8HUK6DbBN0eWkzmPJ/tED9GYNwmCFhZAi4tsD1DL6OXRRWGebb8YMRRa/c+4Al+j
         6YbmyeZXaie0APkca+szFO7n0y81LpOf1g3pJ53g8NzxYFIPFcZYGi2w0w9KtRnfeMcg
         52mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fG5xC73GGxW5G93GYyScyfvWRfK/bWju5nJg9wNvhj0=;
        b=d6BeEqmK97w3sGI1g86IS+uurFw4hoNjw0QY61Tiif5ORd4mxMoJHj3vTDZZWF1mQc
         Vibajw6KYi/O0Pc1KNdn2VRK3NIrEL/JpH9aA7WvoPsOkWwN3BP79xnMKwLQi6IbFWVg
         b++WLRhL1mMh39bPqz+Nn2Hu3LZLZTGok1FcFGAox+As0kVDqDV4G4vGdwCS9geK0dfg
         JvX1aGRcmCxo1ejgsQmE2q1R23ThcSzHJKV40cFTjhsPtr2AXhvGcOnI7KVfvs6u7NJp
         s63dmJXLOIi1scHYd0lpTtBnO5HWot7ltru3IpuXsi1h1byzIMnXYePS9bfv1muz7SiZ
         SGkQ==
X-Gm-Message-State: APjAAAVW0iiYsE1FKN0dvHnJ+PW5mxrCwWqC5tupjNo5CDPIfRf+PTaS
        B1Y7JyHoEvwL66PL4zg5O8SeMMsYtgc=
X-Google-Smtp-Source: APXvYqxVBiNqYkyXndKZebCMenmpVV0KmIatd3Y/abjK9aHRBLjtprV96p7SX8xvc+bWenRy4A98yw==
X-Received: by 2002:ac2:456d:: with SMTP id k13mr30805093lfm.77.1563794005029;
        Mon, 22 Jul 2019 04:13:25 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v15sm5992660lfd.53.2019.07.22.04.13.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 04:13:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] mmc: mmci: Clarify comments and some code for busy detection
Date:   Mon, 22 Jul 2019 13:13:17 +0200
Message-Id: <20190722111317.20177-1-ulf.hansson@linaro.org>
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
the code a bit more robust, but also a bit easier to understand.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Squashed patch 1 and patch 2.
	- Keep the re-read on the status register, but explain why it's needed.
	- Move the clearing of the busy start IRQ at the point it's delivered.

---
 drivers/mmc/host/mmci.c | 63 ++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 356833a606d5..d3f876c8c292 100644
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
+		/*
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
 		if (host->busy_status &&
-		    (status & host->variant->busy_detect_flag))
+		    (status & host->variant->busy_detect_flag)) {
+			writel(host->variant->busy_detect_mask,
+			       host->base + MMCICLEAR);
 			return;
+		}
 
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

