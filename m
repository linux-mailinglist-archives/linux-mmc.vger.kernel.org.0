Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9608E59A793
	for <lists+linux-mmc@lfdr.de>; Fri, 19 Aug 2022 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350978AbiHSVOa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Aug 2022 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiHSVO3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 17:14:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639A90180
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:14:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so7040695edd.13
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bRAqf/rrC4BijRq9DtmS6iekCP1lTeD+37Vq8/7jSNs=;
        b=La/gmQV78ir0WJJOxMQg7TAIsEajXETRBHYkya2mWVELQ9rczUYWEZLrWpC9qVxlz+
         YykR9M0WL3FD/3jFoXz9NGTj0aJSyeNq7bY8ctydKkulVC1XYxcG0JbJrPcnf2wd1+sM
         hTxmqQyRUOHjOB1lmEYI+GdQGcJal/UrLntJVFoNwHtp62ByOY3+fwIAwiR1pwWulhn6
         kQqyROqNRDga1bj+fpe616em8NA5nRyX8nLsqLuZR/aO1WJSoNINmJ3aaD6gZ+SUcAGK
         27af8ctX/CdNFh/hmWEWkImaZMsyAnOZX5qkxIcv+L6PEUo3cP8BxD+GOAkds+UTuHJb
         /mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bRAqf/rrC4BijRq9DtmS6iekCP1lTeD+37Vq8/7jSNs=;
        b=7J9abQhL5oJdRvsX1vtHd8XtnJryMyg8Si+BX2q6Mvtvt7DhBHlrLt1G62wucG32L0
         DhPY8kZBTrhEAaYgxhrIxqctBZ3VV2pWDHaHDV1ViCkwSFsRvpZDsstxqyIckXffYgBB
         VKlQX20WmiF73IWo0lS0lHgx5SgSSnDz21+3vanqMB8CTpvu8qHXR969GRr5WrOxmPlf
         lp4ScWtjfAjUqchtUA1SG2p8VoxAD8YeBo1qVivsSdrPlsS2ZLHnViqM4+8yYYrChHxs
         WlDIQFRUA2Mhttw6fhe2BiFpSXVVV0sb6/DGUvPH+q4Wua1kZKHwm5tfstq50qDxUnKk
         9SPQ==
X-Gm-Message-State: ACgBeo1Oby6W4bUGItfUrIKIjKpdpzg3dlItPlDYdLDNgORCQhwkYYQa
        2Wd3LCoMH0oS9nZeab2OtIw=
X-Google-Smtp-Source: AA6agR5buxwANzNAa4uGpk849x7skznNFJyzw1cjqtbQgnYofu4XsUaamL+wkhag4SCS+kQMnkE08Q==
X-Received: by 2002:a05:6402:358a:b0:43d:aa71:3033 with SMTP id y10-20020a056402358a00b0043daa713033mr7439672edc.248.1660943665859;
        Fri, 19 Aug 2022 14:14:25 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ac:3600:6819:de7b:5db7:493? (dynamic-2a01-0c23-c5ac-3600-6819-de7b-5db7-0493.c23.pool.telefonica.de. [2a01:c23:c5ac:3600:6819:de7b:5db7:493])
        by smtp.googlemail.com with ESMTPSA id kx10-20020a170907774a00b00730cc173c6asm2826316ejc.43.2022.08.19.14.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 14:14:25 -0700 (PDT)
Message-ID: <a185b4e9-f238-c2e6-0847-79cd8265844a@gmail.com>
Date:   Fri, 19 Aug 2022 23:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH v2 2/2] mmc: meson-gx: add SDIO interrupt support
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
In-Reply-To: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add SDIO interrupt support. Successfully tested on a S905X4-based
system (V3 register layout) with a BRCM4334 SDIO wifi module
(brcmfmac driver). The implementation also considers the potential
race discussed in [0].

[0] https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJDhjLkajBHgW3zHasvYYri77NQoDpiW-BpKgkdjtOyg@mail.gmail.com/

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 76 ++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 9a4da2544..58b7836a5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -41,14 +41,17 @@
 #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
 #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
 #define   CLK_V2_ALWAYS_ON BIT(24)
+#define   CLK_V2_IRQ_SDIO_SLEEP BIT(25)
 
 #define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
 #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
 #define   CLK_V3_ALWAYS_ON BIT(28)
+#define   CLK_V3_IRQ_SDIO_SLEEP BIT(29)
 
 #define   CLK_TX_DELAY_MASK(h)		(h->data->tx_delay_mask)
 #define   CLK_RX_DELAY_MASK(h)		(h->data->rx_delay_mask)
 #define   CLK_ALWAYS_ON(h)		(h->data->always_on)
+#define   CLK_IRQ_SDIO_SLEEP(h)		(h->data->irq_sdio_sleep)
 
 #define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
@@ -135,6 +138,7 @@ struct meson_mmc_data {
 	unsigned int rx_delay_mask;
 	unsigned int always_on;
 	unsigned int adjust;
+	unsigned int irq_sdio_sleep;
 };
 
 struct sd_emmc_desc {
@@ -174,6 +178,7 @@ struct meson_host {
 	bool vqmmc_enabled;
 	bool needs_pre_post_req;
 
+	spinlock_t lock;
 };
 
 #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
@@ -430,6 +435,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
 	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
 	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
+	clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
 	/* get the mux parents */
@@ -934,32 +940,54 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 	}
 }
 
+static void __meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	u32 reg_irqen = IRQ_EN_MASK;
+
+	if (enable)
+		reg_irqen |= IRQ_SDIO;
+	writel(reg_irqen, host->regs + SD_EMMC_IRQ_EN);
+}
+
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
 	struct mmc_command *cmd;
-	struct mmc_data *data;
 	u32 status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
 
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
-	status = raw_status & IRQ_EN_MASK;
+	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
 
 	if (!status) {
 		dev_dbg(host->dev,
 			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
-			 IRQ_EN_MASK, raw_status);
+			 IRQ_EN_MASK | IRQ_SDIO, raw_status);
 		return IRQ_NONE;
 	}
 
-	if (WARN_ON(!host) || WARN_ON(!host->cmd))
+	if (WARN_ON(!host))
 		return IRQ_NONE;
 
 	/* ack all raised interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
 
 	cmd = host->cmd;
-	data = cmd->data;
+
+	if (status & IRQ_SDIO) {
+		spin_lock(&host->lock);
+		__meson_mmc_enable_sdio_irq(host->mmc, 0);
+		sdio_signal_irq(host->mmc);
+		spin_unlock(&host->lock);
+		status &= ~IRQ_SDIO;
+		if (!status)
+			return IRQ_HANDLED;
+	}
+
+	if (WARN_ON(!cmd))
+		return IRQ_NONE;
+
 	cmd->error = 0;
 	if (status & IRQ_CRC_ERR) {
 		dev_dbg(host->dev, "CRC Error - status 0x%08x\n", status);
@@ -977,12 +1005,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 	meson_mmc_read_resp(host->mmc, cmd);
 
-	if (status & IRQ_SDIO) {
-		dev_dbg(host->dev, "IRQ: SDIO TODO.\n");
-		ret = IRQ_HANDLED;
-	}
-
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
+		struct mmc_data *data = cmd->data;
+
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
 		if (meson_mmc_bounce_buf_read(data) ||
@@ -1125,6 +1150,27 @@ static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return -EINVAL;
 }
 
+static void meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	__meson_mmc_enable_sdio_irq(mmc, enable);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (!mmc->sdio_irq_pending)
+		__meson_mmc_enable_sdio_irq(mmc, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
@@ -1134,6 +1180,8 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.execute_tuning = meson_mmc_resampling_tuning,
 	.card_busy	= meson_mmc_card_busy,
 	.start_signal_voltage_switch = meson_mmc_voltage_switch,
+	.enable_sdio_irq = meson_mmc_enable_sdio_irq,
+	.ack_sdio_irq	= meson_mmc_ack_sdio_irq,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
@@ -1237,7 +1285,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_init_clk;
 
+	spin_lock_init(&host->lock);
+
 	mmc->caps |= MMC_CAP_CMD23;
+
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
 	if (host->dram_access_quirk) {
 		/* Limit segments to 1 due to low available sram memory */
 		mmc->max_segs = 1;
@@ -1328,6 +1382,7 @@ static const struct meson_mmc_data meson_gx_data = {
 	.rx_delay_mask	= CLK_V2_RX_DELAY_MASK,
 	.always_on	= CLK_V2_ALWAYS_ON,
 	.adjust		= SD_EMMC_ADJUST,
+	.irq_sdio_sleep	= CLK_V2_IRQ_SDIO_SLEEP,
 };
 
 static const struct meson_mmc_data meson_axg_data = {
@@ -1335,6 +1390,7 @@ static const struct meson_mmc_data meson_axg_data = {
 	.rx_delay_mask	= CLK_V3_RX_DELAY_MASK,
 	.always_on	= CLK_V3_ALWAYS_ON,
 	.adjust		= SD_EMMC_V3_ADJUST,
+	.irq_sdio_sleep	= CLK_V3_IRQ_SDIO_SLEEP,
 };
 
 static const struct of_device_id meson_mmc_of_match[] = {
-- 
2.37.2


