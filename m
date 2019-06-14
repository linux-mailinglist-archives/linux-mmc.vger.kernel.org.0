Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65C45923
	for <lists+linux-mmc@lfdr.de>; Fri, 14 Jun 2019 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfFNJrb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 14 Jun 2019 05:47:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37893 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfFNJra (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2019 05:47:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id j2so724974uaq.5
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2019 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTK6glBPsz+2c5s1UM+u1mPbwUZRam6/XPlur2ZEtiY=;
        b=HPMHUIQdfdoOM0SDvI3sEr6kDCZmo3ittCV4pWVgYCuhj/g133nGW30tKHco9ZZ5rU
         gUHMwgjIVbEmt0wnvkJeQW2boDKtayXRBXS7Pq71cohgA+FkmRAkswIpbcjGHuh6W8mk
         hxsRCiHsqLhR7e0MKcnIuTB9H8OaGbMW+rRRt32mNRnXt+iul9wWIQyohIRf4nuOsduE
         BXiAv5Y7RnoKW3HdNFZ4Mxr9wcOUuOJaYBVr7cZMPBLK67bS+my4/grmh2rY9me/aeLn
         jlsCHo9rYElEr9pQVMIKq+8cPMmszf4ToaQVGKVIWHRjFJitOCxtIliXkKnSC+vwD0+o
         Gd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTK6glBPsz+2c5s1UM+u1mPbwUZRam6/XPlur2ZEtiY=;
        b=l1O+A8x9d4geIVjJFKgUeoVEjcnpuqGpkItbNfEvIpmQNwtOywQGpyvgA34GkZB8+1
         pGnf6tGmudGduICx/zW3N+xZtpBJaPExLExWs7qhZD79yZUWpr+xKR09IyxGPeHFrVnP
         JJrdD5XLysogSofHgtJe/6KXom5JoFNfgd7mFCr4dsR6N90v3pPD1CXI/I9OR9oF8Ajs
         kzkGXHZPmI9LMn3vVy2Oe7I0LY16i4FelEbYzy7BkSqB/sAL74dTdBofjsdPwjoNWq5t
         ki6i+dHdqcxaZq+o8K3jjaIYVZQXkB6xdkW0QfgttHwYvhcvP/edDSF2U/Je3A+AOGAt
         9Ibg==
X-Gm-Message-State: APjAAAVTt57Wa7ysplz8O8GExbPK6Se1X80P9v63GdY0t/5/Fp2qr+Pw
        Bumm8oHOrIObKykJJJWxLFCZfwZ8W4HnWkUGaguV2A==
X-Google-Smtp-Source: APXvYqwEVgKDbhvEOENA1sMGmEeMCk5a+6br+06u+T6+nPm6VgkH/bVzBGVaU7nnHL0NMG98KmSPpYmqqpRQ7ET6Mec=
X-Received: by 2002:ab0:2705:: with SMTP id s5mr9263458uao.104.1560505649842;
 Fri, 14 Jun 2019 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jun 2019 11:46:52 +0200
Message-ID: <CAPDyKFrXU4bpKeB7Aa15j2nHqUCn-bk+YKn9_vkznmi+PS8H7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
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

On Fri, 14 Jun 2019 at 07:26, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
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
> ---
>  drivers/mmc/host/mtk-sd.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index c518cc2..29992ae 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1389,10 +1389,12 @@ static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         struct msdc_host *host = mmc_priv(mmc);
>
>         spin_lock_irqsave(&host->lock, flags);
> -       if (enb)
> +       if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> -       else
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);

Rather than clearing SDC_CFG_SDIOIDE in the irq handler, you need to
do it here. As otherwise when the mmc core calls
host->ops->enable_sdio_irq() to disable the SDIO IRQ, it may stay
enabled.

> +       }
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> @@ -1422,6 +1424,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 spin_lock_irqsave(&host->lock, flags);
>                 events = readl(host->base + MSDC_INT);
>                 event_mask = readl(host->base + MSDC_INTEN);
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> +                       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

As stated above, I suggest you move this into __msdc_enable_sdio_irq()
and thus call that function from here instead. Well, that doesn't work
as is, because of the spin lock, so you rather need to make a
sub-function of __msdc_enable_sdio_irq, that don't take/releases the
lock.

I hope that was clear. If not, I can post a patch to show you what I mean.


>                 /* clear interrupts */
>                 writel(events & event_mask, host->base + MSDC_INT);
>
> @@ -1572,10 +1576,7 @@ static void msdc_init_hw(struct msdc_host *host)
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
> --
> 1.9.1
>

Kind regards
Uffe
