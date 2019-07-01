Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7522480F2
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfFQLfs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:35:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39804 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfFQLfs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:35:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id n2so5886283vso.6
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rdj5y7WUhCyxuRRSk61DK/G2r8mbCnRcx9QGkbHiSrE=;
        b=ahERndKw2GY6JLEmRsjtiw3oDqIj+mYbgL6lSV96YnKupRUkausE5qwiHJqwzfXqWL
         v8zneB63ByCBnkQMtgj9MX/cVJ2Ta1DLnfwalFQbkq7fNAWQX2RWu17yMWsbI7u00bmI
         FgLTp2YvgADDyXx/WXcH96Ux4+qlE1/Kzl4Ckt96KdZ/Nhtm6zpTCbqbiuQYtslkfgQX
         G1HN8/KI8qxPB7aNZ9FhbpRkO+7vv1f48hCSkyTFAUfz/hUI70RfXJWI7aWkgiCrUg16
         e2vvJ2hSh9nDfyS4CZA0XmB3CH3x8cpWGUqB32GFVxNJcF5WQZ0bDvgvl7SCqRiUQa6j
         bBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rdj5y7WUhCyxuRRSk61DK/G2r8mbCnRcx9QGkbHiSrE=;
        b=lISTx+565csth5iIyXKUnaI5GPGDfDwQCbiipHBC9VF1xBHhrjHg4pEXIwzBpvDO//
         YUOb5S77JEXp+4IxRZDyrt9/qQEbqJ0kSjETfA+a9GzKO1jj6gnTV1QO+nqkB8GC6+u+
         LErV/szn+JSVCiOjHES3ynnBvC9fbTCcCR/y8jGx4AGB6ImT05+Fj0PYV3d+O0CSLY8j
         8sdDUD4bWLj9gmaPMx9wp4RPxwLMTrr5P1ieqAPlcFQiwghN9eyQo7Ksx4KclKe2SioQ
         hoWnQgXNb6NOCzcLZEdnRwpKD4iTCNLcJBShq3voCCsWYsq9RXq5bGjDvUDhvP7/tb21
         VGwA==
X-Gm-Message-State: APjAAAUyjY1kN+xqj9yUzNfhz4coFd86+DFtBY5pigKZ3AyNCaa+N+rg
        bzcSeACx+m/iUv2FsJZk0SUC43hn9oXTK085Nj7E9w==
X-Google-Smtp-Source: APXvYqzzGaGuVCedyz80q6rNgp0f0P5Uq2ofFroB+k9lv/ume7i4twtBuzApD3RlCd+N9qQ92YfAsRGk0Fjz+dYV07U=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr10488350vsp.191.1560771347027;
 Mon, 17 Jun 2019 04:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:10 +0200
Message-ID: <CAPDyKFo5zpoRFMG6U_Y2uMk0qCyypW-Ui1Kha5t9_Rher4CDkw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
To:     Jjian Zhou <jjian.zhou@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Mao <yong.mao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 13:04, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> SDIO IRQ is triggered by low level. It need disable SDIO IRQ
> detected function. Otherwise the interrupt register can't be cleared.
> It will process the interrupt more.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index c518cc2..fa7d420 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1383,24 +1383,25 @@ static void msdc_request_timeout(struct work_struct *work)
>         }
>  }
>
> -static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
>  {
> -       unsigned long flags;
> -       struct msdc_host *host = mmc_priv(mmc);
> -
> -       spin_lock_irqsave(&host->lock, flags);
> -       if (enb)
> +       if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> -       else
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> -       spin_unlock_irqrestore(&host->lock, flags);
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       }
>  }
>
>  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  {
> +       unsigned long flags;
>         struct msdc_host *host = mmc_priv(mmc);
>
> -       __msdc_enable_sdio_irq(mmc, enb);
> +       spin_lock_irqsave(&host->lock, flags);
> +       __msdc_enable_sdio_irq(host, enb);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         if (enb)
>                 pm_runtime_get_noresume(host->dev);
> @@ -1422,6 +1423,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 spin_lock_irqsave(&host->lock, flags);
>                 events = readl(host->base + MSDC_INT);
>                 event_mask = readl(host->base + MSDC_INTEN);
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> +                       __msdc_enable_sdio_irq(host, 0);
>                 /* clear interrupts */
>                 writel(events & event_mask, host->base + MSDC_INT);
>
> @@ -1430,10 +1433,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 data = host->data;
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> -               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> -                       __msdc_enable_sdio_irq(host->mmc, 0);
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                         sdio_signal_irq(host->mmc);
> -               }
>
>                 if ((events & event_mask) & MSDC_INT_CDSC) {
>                         if (host->internal_cd)
> @@ -1572,10 +1573,7 @@ static void msdc_init_hw(struct msdc_host *host)
>         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>
>         /* Config SDIO device detect interrupt function */
> -       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> -               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> -       else
> -               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> @@ -2103,7 +2101,12 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>
>  static void msdc_ack_sdio_irq(struct mmc_host *mmc)
>  {
> -       __msdc_enable_sdio_irq(mmc, 1);
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __msdc_enable_sdio_irq(host, 1);
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static int msdc_get_cd(struct mmc_host *mmc)
> --
> 1.9.1
>
