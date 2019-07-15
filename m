Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B466993D
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfGOQmh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 12:42:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40084 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfGOQmh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2019 12:42:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so11481140lff.7
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2019 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dp5F9BRn6xjrJQrJavuPjkm0wkNhqKMjc1pUUm8YKQI=;
        b=QWMzKFmameXZURZ1ASykm+hB9PEaUS9hRkNFBRzPeRFOAdV+17GmLneT/JQfKIAEkH
         RSOI35ZVaerr7dafTC1ZKshPt360PQweoaC7Vm+L9796/2Xz5oyXeerJbpz8KmNMGzTY
         6VFR0mFzkpPr0tIDRVa40up+XiaJQpBdlSUqpPf/nMyQVUU6VeJws6VAeuzliq3rI5OG
         UsmlHA/uBlKBoAlxc0dcfbn22vAJXMNRxR8TwUtbjWEBDik+lCqTkBFusk6BWv6naNGE
         zOL/BAiBj+4x62944j136/A3NFcmHM2V+VUuVvc3EFPhc1Jdx4ouH3cHZnefjYtZKAyX
         /tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dp5F9BRn6xjrJQrJavuPjkm0wkNhqKMjc1pUUm8YKQI=;
        b=R3d8mh/sm0FgfRL+PD2iGQWWV3J8xab2QSykw7yO14o1nPu7I3YUZAjcKTUet9T/r1
         sTWfkjb+sgbFLkRyAlUNcMygHsutVRLOb2kDrCvXTAjWgip9wMqtx5pVxfTzhy3iBMP/
         LaIuei26rCq4AXFF+bCVzWy/6dYuqClYNcCjwN5UVkais3nwrlibMVxkc6uRq0SjTXsQ
         hU0iphxF6lq2ttHZ3JpZqzx4TBLVzFwbLK8aK5GeowYvssXQrGpVrbnu8Odc+jJzCztB
         fUcDeYgTTgcf6F0+xdebATLRH17BVK5oe/gW4vOJSrbBcpsUI/OXKPvjxxi2Yh58rOtK
         mJxQ==
X-Gm-Message-State: APjAAAWvnmFIMQtw1t9F+zMEJA2WeDLCTdL1RNFfuOvn7hSFXfE4vKnL
        94JPmRKJ9m8EBbg0mpUqysBevpU46V4=
X-Google-Smtp-Source: APXvYqzuzD2TZI8BeubLbcQrscbda2jI2V57z+gir3IBFP8/ZI/a562T8OygrX9VBTcKTTbMcLb60Q==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr9545054lfj.109.1563208954852;
        Mon, 15 Jul 2019 09:42:34 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id m17sm3248782lji.16.2019.07.15.09.42.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 09:42:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: mmci: Clarify comments in the code about busy detection
Date:   Mon, 15 Jul 2019 18:42:30 +0200
Message-Id: <20190715164230.27348-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The code dealing with busy detection is somewhat complicated. In a way to
make it a bit clearer, let's try to clarify the comments in the code about
it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5f35afc4dbf9..94e7ba368cca 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1222,19 +1222,30 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
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
+		 */
 		if (host->busy_status &&
 		    (status & host->variant->busy_detect_flag))
 			return;
 
 		/*
 		 * Before unmasking for the busy end IRQ, confirm that the
-		 * command was sent successfully.
+		 * command was sent successfully. To keep track of having a
+		 * command in-progress, while waiting for busy signaling to end,
+		 * store the status in host->busy_status.
+		 *
+		 * Note that, since the HW seems to be triggering an IRQ on both
+		 * edges while monitoring DAT0 for busy completion, but the same
+		 * status bit in MMCISTATUS is used to monitor both start and
+		 * end of busy detection, special care must be taken to make
+		 * sure that both start and end interrupts are always cleared
+		 * one after the other.
 		 */
 		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
@@ -1248,19 +1259,17 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
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
+		 * sent and the busy status isn't set, it means we have received
+		 * the busy end IRQ. Clear and mask the IRQ, then continue to
+		 * process the command.
 		 */
 		if (host->busy_status) {
 
@@ -1506,14 +1515,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
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

