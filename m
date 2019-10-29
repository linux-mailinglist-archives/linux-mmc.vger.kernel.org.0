Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C650E922A
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Oct 2019 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfJ2VhT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Oct 2019 17:37:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36229 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfJ2VhT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2019 17:37:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so296382ljj.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2019 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJruxtgNJ4GNBihbGcdoSjPmlvVwOIZwKStvYBv9GAc=;
        b=R/Nydz0bfH1D6eKCTI9kjJXJe+Xnb82P2jHMnlvpt16310ldhqiUQfF1isJj7oR2/O
         ifFk35s/fuUGgDvvx7E5qNe49izvMbaOo7JWTrfy0Azn/UN+tzNssd67ByWczRtNJ//+
         /LVd1zgKbgpROS1ZIODCx+C11rIIxi35TLJpq4QomZxaEq906oFTPWdprdLwAPHOs2F9
         mMh7YU/9iGqTny0v4dJWpX/EuBEN11Cd/ua06RSiGoVScxMHL4OoqSl8gpV/jo2FHZek
         GnvDPBmeK3hbUW1FKLdPCTwh1EPCxM9HNoGI1OyhsF4y6u0wEUfV9fo85b7lKLbYYF00
         WXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJruxtgNJ4GNBihbGcdoSjPmlvVwOIZwKStvYBv9GAc=;
        b=B16woyVkdVjfDDFZkJ65/AvcAsAMrL4+kmlp14/NCnSkX0g5iF51pJx2MqavI5THfT
         swhTM2o+Dcat4bSi8p5gOlELUEi+DYJT2rD5rqwWrIh0qDpWPd4rjLKgtisjA5gor9A7
         3zCgZrycFnXJoL/rbd05Ejyr/yWpWlQv/f08h7k0LsRAKVoj3pgR75oDIbltHo/qBEHy
         qczVGmAtf1fCV/pQmXAmDys+4mmsbIh966M3L1gJZfdNouicvXVkF4ZH7J4CFwUD0jGi
         0s+A6H9j8yzk81wvKP/Qk5ahMZvLNiSME2L6UZfakl3pRldFd6ZEwP+dPZ9hI0w2O49x
         19Kw==
X-Gm-Message-State: APjAAAV2TB5Kj5F+XZm/Z7zRYp8RWgkyoSWFOfo/Z1d3OewtJH58m/Im
        KvudTwRaN9MxzldtFe+/oTAOK/zSocaPrw==
X-Google-Smtp-Source: APXvYqyXvZxj7Ztba+0O/M4+iaSmCzMIMq78m1uo9s7BZvCnB3PXRhGlk24XNOOVs4kY7A4VpxFSBw==
X-Received: by 2002:a2e:8852:: with SMTP id z18mr4232238ljj.230.1572385035599;
        Tue, 29 Oct 2019 14:37:15 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id o11sm61405lfl.48.2019.10.29.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:37:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: mmci: Support odd block sizes for ux500v2 and qcom variant
Date:   Tue, 29 Oct 2019 22:37:08 +0100
Message-Id: <20191029213708.17878-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ludovic: are you using your MMCI derivative for SDIO?
Can you check if the flag for odd lengths should be
set on the late ST derivatives as well?
---
 drivers/mmc/host/mmci.c | 19 +++++++++++++++----
 drivers/mmc/host/mmci.h |  6 +++++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c37e70dbe250..459969f410b2 100644
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
@@ -279,6 +281,7 @@ static struct variant_data variant_qcom = {
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -447,10 +450,11 @@ void mmci_dma_setup(struct mmci_host *host)
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
@@ -515,7 +519,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
 
-	host->ops->dma_start(host, &datactrl);
+	ret = host->ops->dma_start(host, &datactrl);
+	if (ret)
+		return ret;
 
 	/* Trigger the DMA transfer */
 	mmci_write_datactrlreg(host, datactrl);
@@ -872,9 +878,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
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
index 833236ecb31e..4c4aa0a258fa 100644
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
+	u8			datactrl_odd_blocksz;
 	u8			datactrl_first:1;
 	u8			datacnt_useless:1;
 	u8			st_sdio:1;
-- 
2.21.0

