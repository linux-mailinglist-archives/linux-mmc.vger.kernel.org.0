Return-Path: <linux-mmc+bounces-90-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB067EC7E4
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F321F27CEE
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DE433AD;
	Wed, 15 Nov 2023 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtQDoCm1"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E7433AA
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 15:51:58 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A95210C
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:56 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so7234172276.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063516; x=1700668316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5je3CHo1tuObxFhsj7HCVNtEJLqQI+QRpnvtFQU188=;
        b=XtQDoCm1MmcQbeqvgViZYV49Krzd7z0mafyn0RQyL3ViO9EV92K52U+5Tb8tdWLNja
         JGrtSsytTY0eT8V8f3YxZd8iiUZ3LtB9dBaua26iCUHx9ZC3BQXTm8cr4STjVGaWYSNB
         E/6Jq2LPjik/xbquZrJzu0iM3xyvghDg97ZOES6AXSMLVWSR+27Knmz1UzkmK3839Foe
         WhrM9dwYek+Fai9c5bKkdTeeGrqizW/5oMyexauTolrUFeMrhays2pqjtv6/hzC6kbRV
         dUvR2T4PLANEg2TaCi4exwCcOdQDH2NlPjLFCop7LMl8aJnHfCnEiMixeBmg6CcTFnHp
         PkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063516; x=1700668316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5je3CHo1tuObxFhsj7HCVNtEJLqQI+QRpnvtFQU188=;
        b=lEKee7UiFDpxJCE26SwbHCcwJGSJG6vAoR2t4ZzGJjILnbRUKdaWaxk6s2ElmTuwJN
         Ur4oWOCh4rydZvVzNy2NutRL1LSs9cT7+lGrKPJhfMkQMfiq7/RVnx1Ld671n916YZAT
         ntdVdmAjycpfJKtvscvOiHoOpUS6f0Fz20SEUkqmPuePJawHGOMUQt9DI8Acd9Sp+Ln7
         1KjrjeUWc5xlwEZ7eBmx/tRKT9YqMccErMpytbWTlL/fOcC6OMyHC6mV6wi3X85wkeN0
         JaiCoxYK96CgoKCdUa6weQUqX/Ck3rEaJeGnZmhDT+MW8LQKwiwpd4POhxNRwQmWLCBp
         U8Kw==
X-Gm-Message-State: AOJu0Yzt8REqecMFf/wQWIU7Fy9S1eoRBAAPi7VmUWLw92vq71ryd2fI
	f5rJ3rAWKAO99ng01KZle0OrKn1vd/nrsbwxyg3UCA==
X-Google-Smtp-Source: AGHT+IFzzO3NZ/5bQpxO81qmz5mqu7aqHq/qjLLklbYg9lW1M5RYGuiD7psN6OQiO7cBfDSq3hrdkp3jL3Z6I8OLrsU=
X-Received: by 2002:a25:687:0:b0:daf:81e5:d2fa with SMTP id
 129-20020a250687000000b00daf81e5d2famr9742559ybg.33.1700063516075; Wed, 15
 Nov 2023 07:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108141637.119497-1-yann.gautier@foss.st.com>
In-Reply-To: <20231108141637.119497-1-yann.gautier@foss.st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Nov 2023 16:51:20 +0100
Message-ID: <CAPDyKFqJbrNQXqb4+ZLE1L+C8hxGRCuwVgPoGMu1she3+pMzrQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmci: stm32: add SDIO in-band interrupt mode
To: Yann Gautier <yann.gautier@foss.st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	linux-mmc@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>, 
	Ben Wolsieffer <Ben.Wolsieffer@hefring.com>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Christophe Kerello <christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Nov 2023 at 15:18, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 and Ux500
> variants.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> It is not enabled by default on Ux500 variant as this is unstable and
> Ux500 users should use out-of-band IRQs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Updates on v3:
> * remove variant ops enable_sdio_irq & sdio_irq and use common
> functions (mmci_write_sdio_irq_bit() & mmci_signal_sdio_irq())
> * enable datactrl_mask_sdio during probe if relevant and keep it
> enabled in mmci_write_datactrlreg().
>
> Updates on v2:
> * rename use_sdio_irq to supports_sdio_irq and change it to bool
> * use common code for ux500 and stm32 variants
>
> ---
>  drivers/mmc/host/mmci.c | 69 +++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/mmci.h |  2 ++
>  2 files changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e967cca7a16f..b790c3c3c8f9 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -273,6 +273,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(12, 5),
>         .stm32_idmabsize_align  = BIT(5),
> +       .supports_sdio_irq      = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
>         .busy_detect_flag       = MCI_STM32_BUSYD0,
> @@ -300,6 +301,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(16, 5),
>         .stm32_idmabsize_align  = BIT(5),
> +       .supports_sdio_irq      = true,
>         .dma_lli                = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
> @@ -328,6 +330,7 @@ static struct variant_data variant_stm32_sdmmcv3 = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(16, 6),
>         .stm32_idmabsize_align  = BIT(6),
> +       .supports_sdio_irq      = true,
>         .dma_lli                = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
> @@ -421,8 +424,9 @@ void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
>   */
>  static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
>  {
> -       /* Keep busy mode in DPSM if enabled */
> -       datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
> +       /* Keep busy mode in DPSM and SDIO mask if enabled */
> +       datactrl |= host->datactrl_reg & (host->variant->busy_dpsm_flag |
> +                                         host->variant->datactrl_mask_sdio);
>
>         if (host->datactrl_reg != datactrl) {
>                 host->datactrl_reg = datactrl;
> @@ -1762,6 +1766,25 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static void mmci_write_sdio_irq_bit(struct mmci_host *host, int enable)
> +{
> +       void __iomem *base = host->base;
> +       u32 mask = readl_relaxed(base + MMCIMASK0);
> +
> +       if (enable)
> +               writel_relaxed(mask | MCI_ST_SDIOITMASK, base + MMCIMASK0);
> +       else
> +               writel_relaxed(mask & ~MCI_ST_SDIOITMASK, base + MMCIMASK0);
> +}
> +
> +static void mmci_signal_sdio_irq(struct mmci_host *host, u32 status)
> +{
> +       if (status & MCI_ST_SDIOIT) {
> +               mmci_write_sdio_irq_bit(host, 0);
> +               sdio_signal_irq(host->mmc);
> +       }
> +}
> +
>  /*
>   * Handle completion of command and data transfers.
>   */
> @@ -1806,6 +1829,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                         mmci_data_irq(host, host->data, status);
>                 }
>
> +               if (host->variant->supports_sdio_irq)
> +                       mmci_signal_sdio_irq(host, status);
> +
>                 /*
>                  * Busy detection has been handled by mmci_cmd_irq() above.
>                  * Clear the status bit to prevent polling in IRQ context.
> @@ -2042,6 +2068,35 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> +static void mmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       if (enable)
> +               /* Keep the SDIO mode bit if SDIO irqs are enabled */
> +               pm_runtime_get_sync(mmc_dev(mmc));
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       mmci_write_sdio_irq_bit(host, enable);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       if (!enable) {
> +               pm_runtime_mark_last_busy(mmc_dev(mmc));
> +               pm_runtime_put_autosuspend(mmc_dev(mmc));
> +       }
> +}
> +
> +static void mmci_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       mmci_write_sdio_irq_bit(host, 1);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
>  static struct mmc_host_ops mmci_ops = {
>         .request        = mmci_request,
>         .pre_req        = mmci_pre_request,
> @@ -2317,6 +2372,16 @@ static int mmci_probe(struct amba_device *dev,
>                 mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>         }
>
> +       if (variant->supports_sdio_irq && host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
> +               mmci_ops.enable_sdio_irq = mmci_enable_sdio_irq;
> +               mmci_ops.ack_sdio_irq   = mmci_ack_sdio_irq;
> +
> +               mmci_write_datactrlreg(host,
> +                                      host->variant->datactrl_mask_sdio);
> +       }
> +
>         /* Variants with mandatory busy timeout in HW needs R1B responses. */
>         if (variant->busy_timeout)
>                 mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 34d9897c289b..a5eb4ced4d5d 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -331,6 +331,7 @@ enum mmci_busy_state {
>   *            register.
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @dma_lli: true if variant has dma link list feature.
> + * @supports_sdio_irq: allow SD I/O card to interrupt the host
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>   * @dma_flow_controller: use peripheral as flow controller for DMA.
>   */
> @@ -377,6 +378,7 @@ struct variant_data {
>         u32                     start_err;
>         u32                     opendrain;
>         u8                      dma_lli:1;
> +       bool                    supports_sdio_irq;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
>         bool                    dma_flow_controller;
> --
> 2.34.1
>

