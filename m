Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C46BA1D2
	for <lists+linux-mmc@lfdr.de>; Sun, 22 Sep 2019 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIVK1D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 06:27:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35190 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfIVK1D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Sep 2019 06:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eArbgkqKLnGP2v0N+CicPD9Z+1s3Q97jmJoE/ZAPBsA=; b=IKoD7BlH53dx3fT4aFHS2UHtMo
        HGQOTifCBSmrQdObUC+sW0ELUdms1I6zzQZnu5+KK2OOFC0RSF1giLWKFpygj0GKfDVaCenEjnIjS
        VJN4YnrJoXhd9pSa9eO0WJuut/3ZrHWrvLdmFCxS88D4TgRsFpyVdK86KMVjUw9CilVvCrQel6x5Q
        k8e4wh5VfRaNgkyT0K0TQKW/dFCxnKitDWUKqB7fHqVtMMTT7pCVyIEElppgfDvn4HQGjz6wElj9r
        Zl77+NwItD6mh2D9BpXjcCbj8lBqgBThI5bVlJgMQ2I1L1yyh9rw+P4TlLwPbPt90HysjVJbNqL9j
        QQub2s7A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33942 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iBz4v-0006SI-PQ; Sun, 22 Sep 2019 11:26:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iBz4v-0008MV-4k; Sun, 22 Sep 2019 11:26:53 +0100
In-Reply-To: <20190922102341.GO25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] mmc: sdhci: improve ADMA error reporting
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
Date:   Sun, 22 Sep 2019 11:26:53 +0100
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ADMA errors are potentially data corrupting events; although we print
the register state, we do not usefully print the ADMA descriptors.
Worse than that, we print them by referencing their virtual address
which is meaningless when the register state gives us the DMA address
of the failing descriptor.

Print the ADMA descriptors giving their DMA addresses rather than their
virtual addresses, and print them using SDHCI_DUMP() rather than DBG().

We also do not show the correct value of the interrupt status register;
the register dump shows the current value, after we have cleared the
pending interrupts we are going to service.  What is more useful is to
print the interrupts that _were_ pending at the time the ADMA error was
encountered.  Fix that too.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/mmc/host/sdhci.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..0f33097c55ec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2855,6 +2855,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	void *desc = host->adma_table;
+	dma_addr_t dma = host->adma_addr;
 
 	sdhci_dumpregs(host);
 
@@ -2862,18 +2863,21 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 		struct sdhci_adma2_64_desc *dma_desc = desc;
 
 		if (host->flags & SDHCI_USE_64_BIT_DMA)
-			DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
-			    desc, le32_to_cpu(dma_desc->addr_hi),
+			SDHCI_DUMP("%08llx: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    (unsigned long long)dma,
+			    le32_to_cpu(dma_desc->addr_hi),
 			    le32_to_cpu(dma_desc->addr_lo),
 			    le16_to_cpu(dma_desc->len),
 			    le16_to_cpu(dma_desc->cmd));
 		else
-			DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
-			    desc, le32_to_cpu(dma_desc->addr_lo),
+			SDHCI_DUMP("%08llx: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    (unsigned long long)dma,
+			    le32_to_cpu(dma_desc->addr_lo),
 			    le16_to_cpu(dma_desc->len),
 			    le16_to_cpu(dma_desc->cmd));
 
 		desc += host->desc_sz;
+		dma += host->desc_sz;
 
 		if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
 			break;
@@ -2949,7 +2953,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			!= MMC_BUS_TEST_R)
 		host->data->error = -EILSEQ;
 	else if (intmask & SDHCI_INT_ADMA_ERROR) {
-		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
+		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
+		       intmask);
 		sdhci_adma_show_error(host);
 		host->data->error = -EIO;
 		if (host->ops->adma_workaround)
-- 
2.7.4

