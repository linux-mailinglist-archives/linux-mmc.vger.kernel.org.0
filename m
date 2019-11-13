Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB3FAF47
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKMLGJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 06:06:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41918 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMLGJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 06:06:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id 190so1054471vss.8
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJaWJq5k2HeWMfmEz5h2tfRMLcDgwNb/j1tpanIFHeg=;
        b=reMipTUHHUvl6DLFz6DNrznoZq/7ZwhF69nEBi0i/WBCJbo830//ZSAXjmBAsBJtGY
         LEtPL45xmCV22Jkfsbf8IrUQRL51aV3ZM4vei5K4rubAcoe2CQ4UBTt585FcZcgAkXqK
         gYn/1kQoVT56AdKLXVMueRZ3eJ1vdA7fU58YpeOMUCG0t8U0d4F+yqwsclPhkzlNHE0Q
         h5qV1WfSxyB2kqL6/eVP1yqjVHpWC7rT4mcJkt4ghSuFP64TCBjPtlTyKnmNQ40GfOOK
         9R0LQ62adsupoa3G5FugI1BsLjbIKSAGr/iV6Fh+951OC71ZdlYKkCNbH4DnmanjSYNC
         vaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJaWJq5k2HeWMfmEz5h2tfRMLcDgwNb/j1tpanIFHeg=;
        b=WZ1NCkyMJa6tALcXLfDgUzcvD0ytTNjQPRlfqYrKHVMLsjISyK7/usSoJn4jUP06q1
         LWOGh+ctwl9yyrlqn+44uhOFMOZRix9032sZzzVw2nChoQSqIBhhFBzvCblFNVX6SJpl
         GG3qMZ4qYgJo+hrNzuPS51m55DvkVzK8X8rjjJcsDnfXfIphjQEHSrNo3OUUTnKCNOjl
         JmYahoFinF2cnr38+4rh8GzeOYAXuxEtaEhax5FS+Q3uhrXnLtAYd0ambMzgW+T6969l
         qOrPKXnHr13vzFg99XzMkZLu4uYe8EIlhVq+tm50jjvHinJoMgCGq6F2uYdltnKSexnf
         jKNA==
X-Gm-Message-State: APjAAAV7rCPuYesV4Hq7hVEDsiZfJ/k9bQrigCq+Z3B0x8dkfvH02ceT
        l6wkiB39hde2l69bazladmRg9b+vQfetdhXCFlus6Q==
X-Google-Smtp-Source: APXvYqyM8m6SwthjY5MbFjIC7eACqSc4lPJRUF262Rafj4rS8/g7Tfz0FPSs1BdFd7/ZxiqGc2DVAwYhNf4PpzlIjxo=
X-Received: by 2002:a67:2087:: with SMTP id g129mr1426791vsg.191.1573643167475;
 Wed, 13 Nov 2019 03:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20191113075335.31775-1-linus.walleij@linaro.org> <20191113075335.31775-2-linus.walleij@linaro.org>
In-Reply-To: <20191113075335.31775-2-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Nov 2019 12:05:31 +0100
Message-ID: <CAPDyKFqx-0J0ck-hyeJsX8LrOP+BWiS6PihLd1Y3EMoXX+qYiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Russell King <linux@arm.linux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 08:53, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This is something like the 5th time this patch is posted,
> so let's try to fix this now, once and for all.
>
> For the ux500v2 variant of the PL18x block, odd block sizes are
> supported. This is necessary to support some SDIO transfers
> such as single bytes. This also affects the QCOM MMCI variant.
>
> This will work fine for PIO using IRQs: SDIO packets are
> accepted down to single bytes and the transfers go through
> just fine.
>
> This patch has proven necessary for enabling SDIO for WLAN on
> PostmarketOS-based Ux500 platforms.
>
> This patch is based on Ulf Hansson's patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
>
> Ulf noted on an earlier iteration in:
> https://marc.info/?l=linux-mmc&m=140845189316370&w=2
>
> "There are some prerequisites of the data buffers to supports
> any block size, at least for ux500. (...) The conclusion from
> the above is that we need to adopt mmci_pio_write() to handle
> corner cases."
>
> This points back to a discussion in 2012. The main point was
> made by Russell in this message:
> https://marc.info/?l=linux-arm-kernel&m=135351237018301&w=2
>
> IIUC this pertains to this code (now gone from the patch):
>
>   if (data->sg->offset & 3) {
>       dev_err(...);
>       return -EINVAL;
>   }
>
> This hit Stephan as he noticed that DMA (DMA40) would not work
> with the MMCI driver, so this patch combined with disabling
> DMA would do the trick. That way we don't toss unaligned
> accesses at the DMA engine as SDIO apparently tends to
> do. (This is not a problem when writing ordinary block device
> blocks as these are always 512 bytes aligned on a 4-byte
> boundary.)
>
> As Ulf notes, odd SG offsets like this should be handled
> by the driver even if we run it in DMA mode. I conclude
> it must be the duty of the DMA driver to say NO to SG
> offsets it cannot handle, or otherwise bitstuff things
> around to avoid the situation.
>
> So as a first step make sure errors are propagated upward
> from the DMA engine, and assume the DMA engine will say no
> to things with weird SG offsets that it cannot handle, and
> then the driver will fall back to using PIO.
>
> It might be that some DMA engines (such as the Ux500
> DMA40) do not properly say no to sglists with uneven
> offsets, or ignore the offset altogether resulting in
> unpredictable behavior. That is in that case a bug in the
> DMA driver and needs to be fixed there. I got the impression
> that the Qualcomm DMA actually can handle these odd
> alignments without problems.
>
> (Make a drive-by fix for datactrl_blocksz, misspelled.)
>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

There is no need to keep my authorship of the patch, it's very much
different than the original. I would rather replace it that with a
suggested-by tag.

> ---
> ChangeLog v2->v3:
> - Repost with the inclusion of other patches.
> ChangeLog v1->v2:
> - Specify odd blocksize field to 1 bit (:1)
> - Specify that STMMC supports odd block sizes
> - Collect Stephan's test tag
> ---
>  drivers/mmc/host/mmci.c | 20 ++++++++++++++++----
>  drivers/mmc/host/mmci.h |  6 +++++-
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..3ffcdf78a428 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -168,6 +168,7 @@ static struct variant_data variant_ux500 = {
>         .cmdreg_srsp            = MCI_CPSM_RESPONSE,
>         .datalength_bits        = 24,
>         .datactrl_blocksz       = 11,
> +       .datactrl_odd_blocksz   = true,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
> @@ -201,6 +202,7 @@ static struct variant_data variant_ux500v2 = {
>         .datactrl_mask_ddrmode  = MCI_DPSM_ST_DDRMODE,
>         .datalength_bits        = 24,
>         .datactrl_blocksz       = 11,
> +       .datactrl_odd_blocksz   = true,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
> @@ -260,6 +262,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .datacnt_useless        = true,
>         .datalength_bits        = 25,
>         .datactrl_blocksz       = 14,
> +       .datactrl_odd_blocksz   = true,
>         .stm32_idmabsize_mask   = GENMASK(12, 5),
>         .init                   = sdmmc_variant_init,
>  };
> @@ -279,6 +282,7 @@ static struct variant_data variant_qcom = {
>         .data_cmd_enable        = MCI_CPSM_QCOM_DATCMD,
>         .datalength_bits        = 24,
>         .datactrl_blocksz       = 11,
> +       .datactrl_odd_blocksz   = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 208000000,
>         .explicit_mclk_control  = true,
> @@ -447,10 +451,11 @@ void mmci_dma_setup(struct mmci_host *host)
>  static int mmci_validate_data(struct mmci_host *host,
>                               struct mmc_data *data)
>  {
> +       struct variant_data *variant = host->variant;
> +
>         if (!data)
>                 return 0;
> -
> -       if (!is_power_of_2(data->blksz)) {
> +       if (!is_power_of_2(data->blksz) && !variant->datactrl_odd_blocksz) {

This is too early in the series. You need to deal with the DMA and pio
issues, before releasing this constraint.

In other words, I would rather split this patch in two pieces. One
patch dealing with dma submit error path, placed first in the series
and another patch that adds the odd block sizes variant and releases
the constraint, which should comes last.

Makes sense?

>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported block size (%d bytes)\n", data->blksz);
>                 return -EINVAL;
> @@ -515,7 +520,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
>                  "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
>                  data->sg_len, data->blksz, data->blocks, data->flags);
>
> -       host->ops->dma_start(host, &datactrl);
> +       ret = host->ops->dma_start(host, &datactrl);
> +       if (ret)
> +               return ret;
>
>         /* Trigger the DMA transfer */
>         mmci_write_datactrlreg(host, datactrl);
> @@ -872,9 +879,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
>  int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
>  {
>         struct mmci_dmae_priv *dmae = host->dma_priv;
> +       int ret;
>
>         host->dma_in_progress = true;
> -       dmaengine_submit(dmae->desc_current);
> +       ret = dma_submit_error(dmaengine_submit(dmae->desc_current));
> +       if (ret < 0) {
> +               host->dma_in_progress = false;
> +               return ret;
> +       }
>         dma_async_issue_pending(dmae->cur);
>
>         *datactrl |= MCI_DPSM_DMAENABLE;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 833236ecb31e..c7f94726eaa1 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -278,7 +278,10 @@ struct mmci_host;
>   * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
>   * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
>   * @datactrl_mask_sdio: SDIO enable mask in datactrl register
> - * @datactrl_blksz: block size in power of two
> + * @datactrl_blocksz: block size in power of two
> + * @datactrl_odd_blocksz: true if block any sizes are supported, such as one
> + *                   single character, as is necessary when using some SDIO
> + *                   devices.
>   * @datactrl_first: true if data must be setup before send command
>   * @datacnt_useless: true if you could not use datacnt register to read
>   *                  remaining data
> @@ -323,6 +326,7 @@ struct variant_data {
>         unsigned int            datactrl_mask_ddrmode;
>         unsigned int            datactrl_mask_sdio;
>         unsigned int            datactrl_blocksz;
> +       u8                      datactrl_odd_blocksz:1;
>         u8                      datactrl_first:1;
>         u8                      datacnt_useless:1;
>         u8                      st_sdio:1;
> --
> 2.21.0
>

Kind regards
Uffe
