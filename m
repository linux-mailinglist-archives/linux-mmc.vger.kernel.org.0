Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B992C1D0
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE1IyA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 04:54:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32915 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfE1Ixu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 04:53:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id y6so12299308vsb.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4G+l4mcQrcJ5qtZW6jc8KFsMyVDywMQYRArpXTfxYg=;
        b=tGECAGiPY1UuVhhFiwLy6P8iG6nVZk12EpEIcRNzG6CiaE3ifWSH6hn9CvJ/yPbuRH
         prjlRm3EK4unEciaob+gcP0fWjzUoN2f3+iZ0mo+Qr7o/w0mjtYaWibqnX2djvdAGzQv
         SNwf0Qks57cLHDlHc1Dc9qvLhKzCeC7/YSQ+6jlak7oSA/z/bn64DHZuvEefiz2eZHB3
         Ki9BwVPb2Ak/nHL07CYzGWC3Lg7W9tSELSDgruRfA5vMt2GdVxKnZMNpkPZa9kQ12IdA
         15MVVR5nxU/gGW2dyeH1QiRffO/hUXlsf8oJJGlo6pE2PlKjiKr8TI22h9ZvPqrqgFwt
         Soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4G+l4mcQrcJ5qtZW6jc8KFsMyVDywMQYRArpXTfxYg=;
        b=QrwJiUUlrF5/Ch/w75fHE2x8hdyCPKgt5YyCaQrloU/o5dKvpR/aFaH5wHqDUL+lV/
         HNjTw58P7TAgd3gyY+lL2Rp3wowrWfWcOaiJJCtc0ZlgE3gDuATI99V+whiYWL8GnYkW
         qiNYCN8orY5ivreP7miwi3apyp3F13RomK4qM0LmblJYxZ9D+oK615evoOCgKDn04Qv4
         AFcgKMUXcltGmZqLOuT6Z+WA0ZZWNaGwzGVWtDd/ur6Qss1qd9FxU4dyq4CZnkN+/Sma
         zlWFpWBepM6Y4s5sYFIZm+NPqo/t4Jz8n1OTmVPwF/jLh++AKGVUpEEulEhx8uhKD/2X
         30Fg==
X-Gm-Message-State: APjAAAV3akEG0sJny24eJTQkmw2ZYyBBjLtJFpehK9WmJMLh1mvU8j4g
        Kgmjye2vXyhw51/Ex1rxXmnATdeisD2FqagKthFxJN3Y
X-Google-Smtp-Source: APXvYqxCX1kq8IMvJ2XL6aA1Xt7bJkiRLIqoaVEpeh5q5WYZWsTZObdSaGb4POyhb1VFmyJ/LSM95o9nZoIKDfpxd70=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr71328310vso.34.1559033630071;
 Tue, 28 May 2019 01:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190527124307.32075-1-narmstrong@baylibre.com> <20190527124307.32075-3-narmstrong@baylibre.com>
In-Reply-To: <20190527124307.32075-3-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:14 +0200
Message-ID: <CAPDyKFpWsScFY6oYqRmR=RUNnzeoCn1Vk7h-Nj3aisSOYh-a9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: meson-gx: add dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 May 2019 at 14:43, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
> the data from DRAM, leading to a broken controller.
>
> But each MMC controller has 1,5KiB of SRAM after the registers, that can
> be used as bounce buffer to avoid direct DRAM access from the integrated
> DMAs (this SRAM may be used by the boot ROM when DRAM is not yet initialized).
>
> The quirk is to disable the chained descriptor for this controller, and
> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
>
> The performance hit hasn't been evaluated, but the fix has been tested
> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 70 ++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index c5a8af4ca76b..bcf1789d26b6 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -129,6 +129,9 @@
>  #define SD_EMMC_TXD 0x94
>  #define SD_EMMC_LAST_REG SD_EMMC_TXD
>
> +#define SD_EMMC_SRAM_DATA_BUF_LEN 1536
> +#define SD_EMMC_SRAM_DATA_BUF_OFF 0x200
> +
>  #define SD_EMMC_CFG_BLK_SIZE 512 /* internal buffer max: 512 bytes */
>  #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
>  #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
> @@ -168,6 +171,8 @@ struct meson_host {
>         unsigned long req_rate;
>         bool ddr;
>
> +       bool dram_access_quirk;
> +
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_default;
>         struct pinctrl_state *pins_clk_gate;
> @@ -232,11 +237,20 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
>  static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>                                         struct mmc_request *mrq)
>  {
> +       struct meson_host *host = mmc_priv(mmc);
>         struct mmc_data *data = mrq->data;
>         struct scatterlist *sg;
>         int i;
>         bool use_desc_chain_mode = true;
>
> +       /*
> +        * When Controller DMA cannot directly access DDR memory, disable
> +        * support for Chain Mode to directly use the internal SRAM using
> +        * the bounce buffer mode.
> +        */
> +       if (host->dram_access_quirk)
> +               return;
> +
>         /*
>          * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
>          * reported. For some strange reason this occurs in descriptor
> @@ -1049,6 +1063,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         host->dev = &pdev->dev;
>         dev_set_drvdata(&pdev->dev, host);
>
> +       /* The G12A SDIO Controller needs an SRAM bounce buffer */
> +       host->dram_access_quirk = device_property_read_bool(&pdev->dev,
> +                                       "amlogic,dram-access-quirk");
> +
>         /* Get regulators and the supported OCR mask */
>         host->vqmmc_enabled = false;
>         ret = mmc_regulator_get_supply(mmc);
> @@ -1146,9 +1164,16 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto err_init_clk;
>
>         mmc->caps |= MMC_CAP_CMD23;
> -       mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
> +       if (host->dram_access_quirk) {
> +               /* Limit to the available sram memory */
> +               mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
> +               mmc->max_blk_count = mmc->max_segs;
> +       } else {
> +               mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
> +               mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
> +                               sizeof(struct sd_emmc_desc);
> +       }
>         mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
> -       mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
>         mmc->max_seg_size = mmc->max_req_size;
>
>         /*
> @@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
>          */
>         mmc->caps2 &= ~MMC_CAP2_HS400;
>
> -       /* data bounce buffer */
> -       host->bounce_buf_size = mmc->max_req_size;
> -       host->bounce_buf =
> -               dma_alloc_coherent(host->dev, host->bounce_buf_size,
> -                                  &host->bounce_dma_addr, GFP_KERNEL);
> -       if (host->bounce_buf == NULL) {
> -               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> -               ret = -ENOMEM;
> -               goto err_free_irq;
> +       if (host->dram_access_quirk) {
> +               /*
> +                * The MMC Controller embeds 1,5KiB of internal SRAM
> +                * that can be used to be used as bounce buffer.
> +                * In the case of the G12A SDIO controller, use these
> +                * instead of the DDR memory
> +                */
> +               host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
> +               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
> +               host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
> +       } else {
> +               /* data bounce buffer */
> +               host->bounce_buf_size = mmc->max_req_size;
> +               host->bounce_buf =
> +                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
> +                                          &host->bounce_dma_addr, GFP_KERNEL);
> +               if (host->bounce_buf == NULL) {
> +                       dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> +                       ret = -ENOMEM;
> +                       goto err_free_irq;
> +               }
>         }
>
>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> @@ -1183,8 +1220,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         return 0;
>
>  err_bounce_buf:
> -       dma_free_coherent(host->dev, host->bounce_buf_size,
> -                         host->bounce_buf, host->bounce_dma_addr);
> +       if (!host->dram_access_quirk)
> +               dma_free_coherent(host->dev, host->bounce_buf_size,
> +                                 host->bounce_buf, host->bounce_dma_addr);
>  err_free_irq:
>         free_irq(host->irq, host);
>  err_init_clk:
> @@ -1208,8 +1246,10 @@ static int meson_mmc_remove(struct platform_device *pdev)
>
>         dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>                           host->descs, host->descs_dma_addr);
> -       dma_free_coherent(host->dev, host->bounce_buf_size,
> -                         host->bounce_buf, host->bounce_dma_addr);
> +
> +       if (!host->dram_access_quirk)
> +               dma_free_coherent(host->dev, host->bounce_buf_size,
> +                                 host->bounce_buf, host->bounce_dma_addr);
>
>         clk_disable_unprepare(host->mmc_clk);
>         clk_disable_unprepare(host->core_clk);
> --
> 2.21.0
>
