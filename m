Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EEFFAB59
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 08:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKMHxr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 02:53:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42887 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHxr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 02:53:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so1420317ljc.9
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdgX+5FPEMWeumBP/L3Kn2WDPUqpVI0CqS6oiSh3P9Y=;
        b=M9EqRpo1YzQAw5Aym/f7V7i0nozQekQgxJy2pHprR9394Ue0aGkBZ4MEUzkIIHM5e6
         +xUdZ2OTmgebD8Jty7okqQ5c0AtB5DtY1xpjB7kyqOsdOot8FldKF/oQErIe5kKofk5t
         rJSwBW9vG4vEoGBgDOIF4J+2etTtudbHqgveR6kUm1unZ7adMRHUpN+CGvcbYHraILGk
         eCnHbWJiCmGaou9IxkcmljPnxOYfpFBq/rvwMmAb+dEJUbQTHW1s2epGkbwn/Y4rVaJK
         hCY49JaBTyZurxQkHobOioY6fZmHrdpOFXhgotVutGIHEt2tBLktTF/2+c6yev/nq9Zz
         saXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdgX+5FPEMWeumBP/L3Kn2WDPUqpVI0CqS6oiSh3P9Y=;
        b=BRyprP8CA1nR9Tna10hnmfXleSaUjFLFaeZCxoXnNUGWUFjcA5vgp8s+HgGpveZuH3
         iQTy+goKJ2rfCN11pq4oppa8hODetQS527p9DrTb+Io/cINAK7foEH/+6BYZhS7ziWpi
         t9QKSwgmHzqyxPMfS4T4WNZpbl9nDhEWPUY/0oUokWvFuOj3XDQsGJkMkf4T5qIcCkI6
         tvd84/r7wKw/pNYR77HpBXWM93Ai65wGiI/TU7l+vrzB5NIOGI/d6kiegKSe6a0hWG1a
         PTQchADnh1iQq9cqpE+3HyfMqQegRZ2aU9fjcWWAZJmTz9pgStDA/ROddLgDG25kmYkm
         hNBA==
X-Gm-Message-State: APjAAAUGfvFQYbd03TPWkk76neZ5zRI3SH5B65C+1Qrlb/0wY2QndoRQ
        01t5m6pECSYI09wBKc4amM+O/w==
X-Google-Smtp-Source: APXvYqxI9u3EcltksVbByILLSxmRN8q0bV2Stmj6PhBTWtyi4NXy3X/Je6aFtgys22hZnZtegZkhCQ==
X-Received: by 2002:a2e:4703:: with SMTP id u3mr1385526lja.126.1573631623982;
        Tue, 12 Nov 2019 23:53:43 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id j10sm610110lfc.43.2019.11.12.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 23:53:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] mmc: mmci: Support odd block sizes for ux500v2 and qcom variant
Date:   Wed, 13 Nov 2019 08:53:33 +0100
Message-Id: <20191113075335.31775-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191113075335.31775-1-linus.walleij@linaro.org>
References: <20191113075335.31775-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This is something like the 5th time this patch is posted,
so let's try to fix this now, once and for all.

For the ux500v2 variant of the PL18x block, odd block sizes are
supported. This is necessary to support some SDIO transfers
such as single bytes. This also affects the QCOM MMCI variant.

This will work fine for PIO using IRQs: SDIO packets are
accepted down to single bytes and the transfers go through
just fine.

This patch has proven necessary for enabling SDIO for WLAN on
PostmarketOS-based Ux500 platforms.

This patch is based on Ulf Hansson's patch
http://www.spinics.net/lists/linux-mmc/msg12160.html

Ulf noted on an earlier iteration in:
https://marc.info/?l=linux-mmc&m=140845189316370&w=2

"There are some prerequisites of the data buffers to supports
any block size, at least for ux500. (...) The conclusion from
the above is that we need to adopt mmci_pio_write() to handle
corner cases."

This points back to a discussion in 2012. The main point was
made by Russell in this message:
https://marc.info/?l=linux-arm-kernel&m=135351237018301&w=2

IIUC this pertains to this code (now gone from the patch):

  if (data->sg->offset & 3) {
      dev_err(...);
      return -EINVAL;
  }

This hit Stephan as he noticed that DMA (DMA40) would not work
with the MMCI driver, so this patch combined with disabling
DMA would do the trick. That way we don't toss unaligned
accesses at the DMA engine as SDIO apparently tends to
do. (This is not a problem when writing ordinary block device
blocks as these are always 512 bytes aligned on a 4-byte
boundary.)

As Ulf notes, odd SG offsets like this should be handled
by the driver even if we run it in DMA mode. I conclude
it must be the duty of the DMA driver to say NO to SG
offsets it cannot handle, or otherwise bitstuff things
around to avoid the situation.

So as a first step make sure errors are propagated upward
from the DMA engine, and assume the DMA engine will say no
to things with weird SG offsets that it cannot handle, and
then the driver will fall back to using PIO.

It might be that some DMA engines (such as the Ux500
DMA40) do not properly say no to sglists with uneven
offsets, or ignore the offset altogether resulting in
unpredictable behavior. That is in that case a bug in the
DMA driver and needs to be fixed there. I got the impression
that the Qualcomm DMA actually can handle these odd
alignments without problems.

(Make a drive-by fix for datactrl_blocksz, misspelled.)

Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Repost with the inclusion of other patches.
ChangeLog v1->v2:
- Specify odd blocksize field to 1 bit (:1)
- Specify that STMMC supports odd block sizes
- Collect Stephan's test tag
---
 drivers/mmc/host/mmci.c | 20 ++++++++++++++++----
 drivers/mmc/host/mmci.h |  6 +++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c37e70dbe250..3ffcdf78a428 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -168,6 +168,7 @@ static struct variant_data variant_ux500 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -201,6 +202,7 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -260,6 +262,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datacnt_useless	= true,
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
+	.datactrl_odd_blocksz	= true,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.init			= sdmmc_variant_init,
 };
@@ -279,6 +282,7 @@ static struct variant_data variant_qcom = {
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -447,10 +451,11 @@ void mmci_dma_setup(struct mmci_host *host)
 static int mmci_validate_data(struct mmci_host *host,
 			      struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
+
 	if (!data)
 		return 0;
-
-	if (!is_power_of_2(data->blksz)) {
+	if (!is_power_of_2(data->blksz) && !variant->datactrl_odd_blocksz) {
 		dev_err(mmc_dev(host->mmc),
 			"unsupported block size (%d bytes)\n", data->blksz);
 		return -EINVAL;
@@ -515,7 +520,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
 
-	host->ops->dma_start(host, &datactrl);
+	ret = host->ops->dma_start(host, &datactrl);
+	if (ret)
+		return ret;
 
 	/* Trigger the DMA transfer */
 	mmci_write_datactrlreg(host, datactrl);
@@ -872,9 +879,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
+	int ret;
 
 	host->dma_in_progress = true;
-	dmaengine_submit(dmae->desc_current);
+	ret = dma_submit_error(dmaengine_submit(dmae->desc_current));
+	if (ret < 0) {
+		host->dma_in_progress = false;
+		return ret;
+	}
 	dma_async_issue_pending(dmae->cur);
 
 	*datactrl |= MCI_DPSM_DMAENABLE;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 833236ecb31e..c7f94726eaa1 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -278,7 +278,10 @@ struct mmci_host;
  * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
- * @datactrl_blksz: block size in power of two
+ * @datactrl_blocksz: block size in power of two
+ * @datactrl_odd_blocksz: true if block any sizes are supported, such as one
+ *		      single character, as is necessary when using some SDIO
+ *		      devices.
  * @datactrl_first: true if data must be setup before send command
  * @datacnt_useless: true if you could not use datacnt register to read
  *		     remaining data
@@ -323,6 +326,7 @@ struct variant_data {
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
+	u8			datactrl_odd_blocksz:1;
 	u8			datactrl_first:1;
 	u8			datacnt_useless:1;
 	u8			st_sdio:1;
-- 
2.21.0

