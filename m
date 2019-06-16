Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E9476CE
	for <lists+linux-mmc@lfdr.de>; Sun, 16 Jun 2019 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFPUsb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 16 Jun 2019 16:48:31 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:46964
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfFPUsb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 16 Jun 2019 16:48:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 869504044F;
        Sun, 16 Jun 2019 22:48:29 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wyTvBUjkRMnO; Sun, 16 Jun 2019 22:48:29 +0200 (CEST)
Received: from localhost.localdomain (host54-236-dynamic.0-87-r.retail.telecomitalia.it [87.0.236.54])
        by sysam.it (Postfix) with ESMTPSA id 186C33FE84;
        Sun, 16 Jun 2019 22:48:29 +0200 (CEST)
From:   Angelo Dureghello <angelo@sysam.it>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH v2 2/3] mmc: sdhci: add quirks for be to le byte swapping
Date:   Sun, 16 Jun 2019 22:48:22 +0200
Message-Id: <20190616204823.32758-2-angelo@sysam.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190616204823.32758-1-angelo@sysam.it>
References: <20190616204823.32758-1-angelo@sysam.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some controller as the ColdFire eshdc may require an endianness
byte swap, because DMA read endianness is not configurable.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
---
 drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..f56ae6f153d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2600,6 +2600,18 @@ static const struct mmc_host_ops sdhci_ops = {
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
@@ -2655,6 +2667,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
index 199712e7adbb..be08ff1a8c6f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -482,6 +482,13 @@ struct sdhci_host {
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

