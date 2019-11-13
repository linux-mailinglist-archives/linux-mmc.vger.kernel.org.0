Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E51FAB5A
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 08:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfKMHxt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 02:53:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43315 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMHxt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 02:53:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so1410297ljh.10
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8pRSrNjPJIG3QeAtwUZocUyaeikI+vC5l6O+U96lQw=;
        b=v4Oyosu3WiO5hfa96SAV/hmdVCPlCP/p6Hqm+7l1Wv1ykkepsTzPEhEK05HQVeJ9p8
         UoNDHpr1vmm5//p9cfaDUfOE+87sXevogKJ/PluCRJil50DDo3/w0jjhxZB+3I9QspEs
         YiXTvFllQVXiX5S2NyobNj/aZiQ7I4b0IFAufRygReJh8sGRvjFM36vZwKqzCqZByjGY
         xbqJ8nQUBRM1LZ0NopFf4bt0B1W7yDlBKAUbIUonf+A+HeUWLoj3Sm/EyB4VDnO1uZNP
         rSTC2hMY+LjBBjOOn/z4m3IPsP2DPmfB8RT0Xx17FhMiMUnzm+8P+KbPkYgRzrMEjhfI
         eBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8pRSrNjPJIG3QeAtwUZocUyaeikI+vC5l6O+U96lQw=;
        b=MHtdDg6jrk7ui+MOv4dRHSWZmkjWwGewvkLkT3u/y+iyYFl2yurLKFcKVDl3VSQK8w
         xcOmSnKBo9TMRmnQmEjElE8ESs/WZ/u7+WX8ew5vAVnV87h97lc98vLHdvQWdGcGDmaH
         71FeOnf2n2uhFitJs/R6bDYv3kPp17OL+lzX6j4aiWAeBLIwbjKPFLY8LlWS1UYACVhj
         OpGFS1SHulEjrsx0qDh5p9CUuORpltHnA/RltUPNbeYX1jt26xISOKNRTaQrY1qcsRpm
         5XdvceeljULr7R5g58pzcjYnGT3xu3yDaB4Ks6VxWMeU5Gcm90ahTMyoJbk89ZMKYI/U
         m90Q==
X-Gm-Message-State: APjAAAVUW7BfSovxeAMJFk9PHiMApYvEEMwVtQ82o0VsEPyEBwvZOxx3
        58KaapMp1q1vHp8HA1IRCtV7sQ==
X-Google-Smtp-Source: APXvYqyrkxS30gjbtF0r8GgTAsQTlssm51WKkDZ3hz77IJ0JJm4ESdusnZp+VRTdcRljSfMtR5ZBLQ==
X-Received: by 2002:a05:651c:1a1:: with SMTP id c1mr1530078ljn.23.1573631626433;
        Tue, 12 Nov 2019 23:53:46 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id j10sm610110lfc.43.2019.11.12.23.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 23:53:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/3] mmc: mmci: Bail out from odd DMA on Ux500
Date:   Wed, 13 Nov 2019 08:53:34 +0100
Message-Id: <20191113075335.31775-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191113075335.31775-1-linus.walleij@linaro.org>
References: <20191113075335.31775-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Ux500 (at least) can only deal with DMA transactions
starting and ending on an even 4-byte aligned address.

The problem isn't in the DMA engine of the system as such:
the problem is in the state machine of the MMCI block that
has some features to handle single bytes but it seems like
it doesn't quite work.

This problem is probably caused by most of the testing
being done on mass storage, which will be 512-bytes aligned
blocks placed neatly in pages and practically never run into
this situation.

On SDIO (for example in WiFi adapters) this situation is
common.

By avoiding any such transfers with a special vendor flag,
we can bail out to PIO when an odd transfer is detected
while keeping DMA for large transfers of evenly aligned
packages also for SDIO.

Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v3:
- New patch in v3 after discussion with Ulf
---
 drivers/mmc/host/mmci.c | 21 +++++++++++++++++++++
 drivers/mmc/host/mmci.h | 10 ++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3ffcdf78a428..a08cd845dddc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -185,6 +185,7 @@ static struct variant_data variant_ux500 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.only_long_aligned_dma	= true,
 	.init			= mmci_variant_init,
 };
 
@@ -219,6 +220,7 @@ static struct variant_data variant_ux500v2 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.only_long_aligned_dma	= true,
 	.init			= ux500v2_variant_init,
 };
 
@@ -829,6 +831,25 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (data->blksz * data->blocks <= variant->fifosize)
 		return -EINVAL;
 
+	/*
+	 * Handle the variants with DMA that is broken such that start and
+	 * end address must be aligned on a long (32bit) boundary for the DMA
+	 * to work. If this occurs, fall back to PIO.
+	 */
+	if (host->variant->only_long_aligned_dma) {
+		struct scatterlist *sg;
+		int tmp;
+
+		for_each_sg(data->sg, sg, data->sg_len, tmp) {
+			/* We start in some odd place, that doesn't work */
+			if (sg->offset & 3)
+				return -EINVAL;
+			/* We end in some odd place, that doesn't work */
+			if (sg->length & 3)
+				return -EINVAL;
+		}
+	}
+
 	device = chan->device;
 	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
 			   mmc_get_dma_dir(data));
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c7f94726eaa1..e20af17bb313 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -307,6 +307,15 @@ struct mmci_host;
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @dma_lli: true if variant has dma link list feature.
+ * @only_long_aligned_dma: it appears that the Ux500 has a broken DMA logic for
+ *	       single bytes when either the transfer starts at an odd offset or
+ *	       the final DMA burst is an odd (not divisible by 4) address.
+ *	       Reading must start and end on an even 4-byte boundary, i.e. an
+ *	       even 32bit word in memory. If this is not the case, we need to
+ *	       fall back to PIO for that request. For bulk transfers to mass
+ *	       storage we are almost exclusively dealing with 512-byte chunks
+ *	       allocated at an even address so this is usually only manifesting
+ *	       in SDIO.
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
  */
 struct variant_data {
@@ -350,6 +359,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	u8			dma_lli:1;
+	u8			only_long_aligned_dma:1;
 	u32			stm32_idmabsize_mask;
 	void (*init)(struct mmci_host *host);
 };
-- 
2.21.0

