Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32F5CB504
	for <lists+linux-mmc@lfdr.de>; Fri,  4 Oct 2019 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfJDHcD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 03:32:03 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41561 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfJDHcD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2019 03:32:03 -0400
Received: by mail-vk1-f195.google.com with SMTP id 70so1249697vkz.8
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2019 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVytQ6A3tTisR1ULpXMOIRybJEGZDUtvdOmD9DnopCg=;
        b=C8JB+TC+kB4mKkTJPAwV30/g8qH+Q2Rbi7ZXggpkXCzqx+82UlZAzrmwcEAQBxCqMu
         Mc2fnKRbSyCJuaW+0cBE8xuwD0J9lZiieiEyNJGUuzoYhCOsunr3pDP7hJ4C+ObJnlAf
         BDpWgUAKkIM0ac6msYQp3b8xxdmu+s+M9kOg4T49xW0XlPUh5vYlZzYV2iTGn5ulA5yX
         zYmGTBBxBwHX3DxZN9CckiDh06FMUDkgovwbcd7PME3A0c1vINmrykqLG7lHX0S1SwmH
         k2m4DIKRTdDOIpm9igT+MD1Gf9XL1WrCXfdP6aAQauKEmrMMV8ErCJh7P+mPLtZQpL5e
         vKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVytQ6A3tTisR1ULpXMOIRybJEGZDUtvdOmD9DnopCg=;
        b=qLxyfjZ110p03WzmJXBRGaL/Jq2Z0WzjE8HIALHmdXgLY+aIy+9sNm6omSSrh3iq2I
         wgcz1mpUyAeVeq949C/bYwiqVzkxL2r2Wmif5LUWm+BWTrX1ZuCM12hzKzBGHz2E+36b
         1OwPLxxvbwlqYLn8UsQOmvKFW6DpVT4o8s2CdUZ9trnPPnW66V6dKjqeDYdfAzSxOF83
         Tn6JFYLRDjUhvDANoux/5a3nJvIwA4UZ/9yzy7Tcb6eg9gS4xxlW/WHQ9CT1zs7yuAZL
         u8Mib72/gZRA01iHVTnoYOWewilaeU6PuVK8vrabdORRHySshDMH2uLPtkJSfsluYx2e
         k96g==
X-Gm-Message-State: APjAAAWVkk5oOgohzMoWYk5D2y07N1MlOBvaCIW/s8bCL9nqUaaykQPR
        cekccRc3tB91TlS5XG6FWnKKecjNOoWxSLpbfmwRLQ==
X-Google-Smtp-Source: APXvYqyNhph+V8Gq7CcOU6+NtJDoMHEN6TfbQMSX+TjO85GhZ3NmPooNVwlZTydlQBkeiafQprpWuruMc0iiqhtlh1g=
X-Received: by 2002:ac5:c3c3:: with SMTP id t3mr7144964vkk.59.1570174322012;
 Fri, 04 Oct 2019 00:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <20190905122112.29672-4-ludovic.Barre@st.com>
In-Reply-To: <20190905122112.29672-4-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Oct 2019 09:31:25 +0200
Message-ID: <CAPDyKFqbEzYpNty8u_QuSDfLgPoiTMZS2Bx4GbzfX-Y9TqXJTg@mail.gmail.com>
Subject: Re: [PATCH V6 3/3] mmc: mmci: sdmmc: add busy_complete callback
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 14:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds a specific busy_complete callback for sdmmc variant.
>
> sdmmc has 2 status flags:
> -busyd0: This is a hardware status flag (inverted value of d0 line).
> it does not generate an interrupt.
> -busyd0end: This indicates only end of busy following a CMD response.
> On busy to Not busy changes, an interrupt is generated (if unmask)
> and BUSYD0END status flag is set. Status flag is cleared by writing
> corresponding interrupt clear bit in MMCICLEAR.
>
> The legacy busy completion monitors step by step the busy progression
> start/in-progress/end. On sdmmc variant, the monitoring of busy steps
> is difficult and not adapted (the software can miss a step and locks
> the monitoring), the sdmmc has just need to wait the busyd0end bit
> without monitoring all the changes.

To me it's a bit of the opposite as you describe it above. The legacy
variants suffers from a somewhat broken HW that generates also a
"busystart" IRQ. For the stm32_sdmmc variant, it's more clean/correct
as only a busyend IRQ is raised.

Maybe you can rephrase the above a bit to make that more clear somehow.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c             |  3 +++
>  drivers/mmc/host/mmci.h             |  1 +
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 38 +++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e20164f4354d..a666d826dbbd 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -260,6 +260,9 @@ static struct variant_data variant_stm32_sdmmc = {
>         .datalength_bits        = 25,
>         .datactrl_blocksz       = 14,
>         .stm32_idmabsize_mask   = GENMASK(12, 5),
> +       .busy_timeout           = true,
> +       .busy_detect_flag       = MCI_STM32_BUSYD0,
> +       .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>         .init                   = sdmmc_variant_init,
>  };
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 733f9a035b06..841c5281beb5 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -164,6 +164,7 @@
>  #define MCI_ST_CARDBUSY                (1 << 24)
>  /* Extended status bits for the STM32 variants */
>  #define MCI_STM32_BUSYD0       BIT(20)
> +#define MCI_STM32_BUSYD0END    BIT(21)
>
>  #define MMCICLEAR              0x038
>  #define MCI_CMDCRCFAILCLR      (1 << 0)
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 8e83ae6920ae..bb5499cc9e81 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -282,6 +282,43 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
>         return datactrl;
>  }
>
> +bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> +{
> +       void __iomem *base = host->base;
> +       u32 busy_d0, busy_d0end, mask;
> +
> +       mask = readl_relaxed(base + MMCIMASK0);
> +       busy_d0end = readl_relaxed(base + MMCISTATUS) & MCI_STM32_BUSYD0END;
> +       busy_d0 = readl_relaxed(base + MMCISTATUS) & MCI_STM32_BUSYD0;

I have found some potential optimizations, but I leave it to you to
decide what to do with my comments.

*) You could avoid to read registers upfront, if that be skipped
because of checking a known error condition. For example:
"if (!host->busy_status && !(status & err_msk))" - would tell if it's
even worth considering to unmask the busyend IRQ.

**) Reading MMCISTATUS twice in row seems a bit silly, why not read it
once and store its value in a local variable that you operate upon
instead.

> +
> +       /* complete if there is an error or busy_d0end */
> +       if ((status & err_msk) || busy_d0end)
> +               goto complete;

From here, you may end up writing to MMCIMASK0 and MMCICLEAR, even if
you didn't unmask the busyend IRQ in first place.

> +
> +       /*
> +        * On response the busy signaling is reflected in the BUSYD0 flag.
> +        * if busy_d0 is in-progress we must activate busyd0end interrupt
> +        * to wait this completion. Else this request has no busy step.
> +        */
> +       if (busy_d0) {
> +               if (!host->busy_status) {
> +                       writel_relaxed(mask | host->variant->busy_detect_mask,
> +                                      base + MMCIMASK0);
> +                       host->busy_status = status &
> +                               (MCI_CMDSENT | MCI_CMDRESPEND);
> +               }
> +               return false;
> +       }
> +
> +complete:
> +       writel_relaxed(mask & ~host->variant->busy_detect_mask,
> +                      base + MMCIMASK0);
> +       writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);
> +       host->busy_status = 0;
> +
> +       return true;
> +}
> +
>  static struct mmci_host_ops sdmmc_variant_ops = {
>         .validate_data = sdmmc_idma_validate_data,
>         .prep_data = sdmmc_idma_prep_data,
> @@ -292,6 +329,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>         .dma_finalize = sdmmc_idma_finalize,
>         .set_clkreg = mmci_sdmmc_set_clkreg,
>         .set_pwrreg = mmci_sdmmc_set_pwrreg,
> +       .busy_complete = sdmmc_busy_complete,
>  };
>
>  void sdmmc_variant_init(struct mmci_host *host)
> --
> 2.17.1
>

Other than the comments above, which are plain suggestions for
optimizations, the code looks correct to me!

Kind regards
Uffe
