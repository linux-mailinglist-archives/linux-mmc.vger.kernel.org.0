Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22E11AE04
	for <lists+linux-mmc@lfdr.de>; Sun, 12 May 2019 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfELTsQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 12 May 2019 15:48:16 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:35056
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfELTsQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 May 2019 15:48:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 96A873FE87;
        Sun, 12 May 2019 21:41:31 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KzJUfElXu4ny; Sun, 12 May 2019 21:41:31 +0200 (CEST)
Received: from jerusalem.timesys.com (host87-8-dynamic.4-87-r.retail.telecomitalia.it [87.4.8.87])
        by sysam.it (Postfix) with ESMTPSA id 2C7C23FE86;
        Sun, 12 May 2019 21:41:31 +0200 (CEST)
From:   Angelo Dureghello <angelo@sysam.it>
To:     adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH 2/3] mmc: sdhci: add quirks for be to le byte swapping
Date:   Sun, 12 May 2019 21:41:24 +0200
Message-Id: <20190512194125.7091-2-angelo@sysam.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512194125.7091-1-angelo@sysam.it>
References: <20190512194125.7091-1-angelo@sysam.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some controller as the ColdFire eshdc may require an endianness
byte swap, becouse DMA read endianness is not configurable.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
---
 drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 97158344b862..317dcfb4bb4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2592,6 +2592,18 @@ static const struct mmc_host_ops sdhci_ops = {
 	.card_busy	= sdhci_card_busy,
 };
 
+static void sdhci_be_to_le(char *buff, u32 length)
+{
+	int i, size = length >> 2;
+	u32 *buffer = (u32 *)buff;
+	u32 temp;
+
+	for (i = 0; i < size; i++) {
+		temp = *buffer;
+		*buffer++ = __le32_to_cpu(temp);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Request done                                                              *
@@ -2647,6 +2659,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
 						host->bounce_addr,
 						host->bounce_buffer_size,
 						DMA_FROM_DEVICE);
+
+					if (host->quirks2 &
+					    SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP)
+						sdhci_be_to_le(
+							host->bounce_buffer,
+							length);
+
 					sg_copy_from_buffer(data->sg,
 						data->sg_len,
 						host->bounce_buffer,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d6bcc584c92b..38fa69678cec 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -486,6 +486,13 @@ struct sdhci_host {
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 
+/*
+ * On some architectures, as ColdFire/m68k, native endianness is big endian,
+ * and the dma buffer is filled in big endian order only (no other options).
+ * So, a swap is needed for these specific cases.
+ */
+#define SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP		(1<<19)
+
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 	char *bounce_buffer;	/* For packing SDMA reads/writes */
-- 
2.20.1

