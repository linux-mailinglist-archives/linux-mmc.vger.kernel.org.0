Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2980C99305
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfHVMNw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 08:13:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39118 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbfHVMNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 08:13:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id y62so3675376vsb.6
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnNdhyeFpKuZ+guKHLB3wj1svopkcsXHTZItdvkozEM=;
        b=fWA7YmlE1GNyLXzanu8PKo85MLK8JezTftcsbvVG0IMq+EG7H6yZL9ecYiAosOKAFL
         QaxMps8z06IDVrk4pw6eVTdU22hFWAGXScOfVYjSHFlbB5vuYRjfU7fZ8j2HwfHX3jLE
         Ax4OsYu2MkeJrooj07WDp4wKv/18/0a59AkfDfGuCJsloWnw6IykNnp5cfyvpWEGoRDw
         oNpHOHa+9PeVtB3A5++0kn+N5HCOtHMLmzVMRFG4/AtqUTvctTbm6tmmDFSVG67xuqOd
         ux3oZWpaPwoHaUtjjClJiEGEr2UFD6VGictB948+p9yf4urBNdv6ETiKXhW7beGVBVNs
         EIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnNdhyeFpKuZ+guKHLB3wj1svopkcsXHTZItdvkozEM=;
        b=Y5NPvzJhcPosmBoo2yK7UynXUxzGXpDKcn54uTHYXQRe10jjDngStLuAiday2fFPaL
         CW9EG6/lAiqs9LSGDbkF9JrPYWv0/Wve34l2cq5HPcX7rdUAcv+rf8+nT52/N61+xr0k
         qeapm7BGHwcdqBhVgI/ePjgIasa6e3NZZe4DGZLhbd8Nf1U6ZI2gk7BtrsOMN1XynGk8
         BOdEQtEaAXldSAOjMofKPzxuYcjwPsIE/H52yzpyBY0aV7cXgosRm7lpRvaVKr0xjnUT
         mrRMeS8w3rDBqWBVvRp3UtaBOtJM8Fat2Ip0Tj6E5UEA5ZHGed2fxLAyj4R5dHd0HGr6
         U+MA==
X-Gm-Message-State: APjAAAU8lsF0gG1zziI3000R9E1r1E6CnBzdNlq1gS2GtE0T0xklmwAn
        ejm4JGy0r5RfctfenOVUx/35X0q8WUD7BW2FeRWRsA==
X-Google-Smtp-Source: APXvYqxKSKCkurBSFZFRPOCl+UKsXCIJtILz+mNhnPTGpuI8fBm7g8xQ+t0Wda0p9fcGtKyCF1TWCTuCzEPSdY+riIw=
X-Received: by 2002:a67:e287:: with SMTP id g7mr23854220vsf.200.1566476027453;
 Thu, 22 Aug 2019 05:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190810121608.24145-1-paul@crapouillou.net>
In-Reply-To: <20190810121608.24145-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:11 +0200
Message-ID: <CAPDyKFowvV=O_3Xg8j9nH7szb91Dd1heUt7nK0acRanZL68zsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Code cleanup
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 10 Aug 2019 at 14:16, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Fix wrong code indentation which made the code hard to read, and fix
> return with value in void function.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index ffdbfaadd3f2..59f81e8afcce 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -186,9 +186,9 @@ static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
>                                      uint32_t val)
>  {
>         if (host->version >= JZ_MMC_JZ4780)
> -               return writel(val, host->base + JZ_REG_MMC_IREG);
> +               writel(val, host->base + JZ_REG_MMC_IREG);
>         else
> -               return writew(val, host->base + JZ_REG_MMC_IREG);
> +               writew(val, host->base + JZ_REG_MMC_IREG);
>  }
>
>  static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
> @@ -820,14 +820,14 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
>                         del_timer(&host->timeout_timer);
>
>                         if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
> -                                       cmd->error = -ETIMEDOUT;
> +                               cmd->error = -ETIMEDOUT;
>                         } else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
> -                                       cmd->error = -EIO;
> +                               cmd->error = -EIO;
>                         } else if (status & (JZ_MMC_STATUS_CRC_READ_ERROR |
>                                     JZ_MMC_STATUS_CRC_WRITE_ERROR)) {
> -                                       if (cmd->data)
> -                                                       cmd->data->error = -EIO;
> -                                       cmd->error = -EIO;
> +                               if (cmd->data)
> +                                       cmd->data->error = -EIO;
> +                               cmd->error = -EIO;
>                         }
>
>                         jz4740_mmc_set_irq_enabled(host, irq_reg, false);
> --
> 2.21.0.593.g511ec345e18
>
