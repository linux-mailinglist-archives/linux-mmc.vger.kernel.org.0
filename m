Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D463F747F
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Aug 2021 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhHYLnU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 25 Aug 2021 07:43:20 -0400
Received: from smtp1.axis.com ([195.60.68.17]:58774 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhHYLnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Aug 2021 07:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629891754;
  x=1661427754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pnDCS9LO85um9r3L/+JpcPWish798PmLV+vnNCGgXic=;
  b=mUIa2K0Jl0Z4cUsvZl8fHoC45nZ3XSRzRIBb5JcAtHhfkbOXfOMfyOH/
   GgAmo7sIfa2BILaTqCvH7xq6yM/YoqSue6lyropsyUbL0xfcPES1oESi2
   hf4CiNaid2qgN9MgWK+UCt+JueJ7WQ7rYccUzVSoDFOJUZ1WXbpZm9acQ
   o7e+PEjKuZIq1QE/6HE2et4ezRhRYI5EqtAapc3e8ZAEMwn2z6IZGty19
   +HJHHYXs08kClvpR7JaA+V3MENqTdLMosCbnkILXFHgPvoAOXwVZwsjKX
   OAYLzbqBNbxs+CVkR+vkiYlCoZ4Ya7OUMjuPUhpDW19IbXLk58ck2N1uf
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Only inject fault before done/error
Date:   Wed, 25 Aug 2021 13:42:13 +0200
Message-ID: <20210825114213.7429-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The fault injection function can set EVENT_DATA_ERROR but skip the
setting of ->data_status to an error status if it hits just after a data
over interrupt.  This confuses the tasklet which can later end up
triggering the WARN_ON(host->cmd || ..) in dw_mci_request_end() since
dw_mci_data_complete() would return success.

Prevent the fault injection function from doing this since this is not a
real case, and ensure that the fault injection doesn't race with a real
error either.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..380f9aa56eb2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1802,10 +1802,15 @@ static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
 
 	spin_lock_irqsave(&host->irq_lock, flags);
 
-	if (!host->data_status)
+	/*
+	 * Only inject an error if we haven't already got an error or data over
+	 * interrupt.
+	 */
+	if (!host->data_status) {
 		host->data_status = SDMMC_INT_DCRC;
-	set_bit(EVENT_DATA_ERROR, &host->pending_events);
-	tasklet_schedule(&host->tasklet);
+		set_bit(EVENT_DATA_ERROR, &host->pending_events);
+		tasklet_schedule(&host->tasklet);
+	}
 
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
@@ -2721,12 +2726,16 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
+			spin_lock(&host->irq_lock);
+
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
 			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
+
+			spin_unlock(&host->irq_lock);
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-- 
2.28.0

