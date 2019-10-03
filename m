Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1863C9B93
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfJCKCY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:02:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45414 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbfJCKCY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:02:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id j5so679699uak.12
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOSpNy+f7VfEti+UMkQ6EpXD+06Um2caF49vqJkGTIU=;
        b=mNFS4WZ5+nNrYnXE1BleojBJ2+Rbdf9JROYEgt4+yTQ6sosZS+zXZ7jEQyr/21qOHo
         ZRca6pstZgoYwO9BQ0/ncegqwZbZUFaHeWkGiKx0arLsP5XWU3VfktsAcQBwl/+2OTM2
         T9fEF6txKviVOAZgqdT5cgh+OjZ1LTAVTWFvUUx3k/hAo3IVDbE644ZWgpBEWNJabXCm
         HmdLWMsm8FfT24M62fOYITbUDCYADpoBUhUrotqLgKqJ0MRVD4cY3KDvWH863ehV1Iow
         Qs0qP+hrlw6y63wOaXkYg+NNKTxg1wjNZojN4iHAc4C9OB9alV/dPJaeEnxrYlm+L9fj
         AWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOSpNy+f7VfEti+UMkQ6EpXD+06Um2caF49vqJkGTIU=;
        b=kMIWj+EuhdrUfNuxMXhZzQY0VI3wC80liO9Bx0ockEuNupUGgFWEyHN6/bGJ7/NdXy
         xh643kZeNxxwq20l4dZE1H5rUXV4e6GFoezitgZZ071/MzU82Bl2S52qGZeu/YKSBqCp
         dO+T1CnvDshlAwr5NoUzXI1riGsmPbhL86LTFKIn2w9SzupJN7ErDFqQsGKzWWzW04sG
         08OjVDldFPaN3tXZ/V89V0L+ca3t6qAGw50Cc4Td1+YQSxNL4z2bWcEN2n8y5ngCzWVd
         OeH43I++qdHJtZ9U6oP+g5ThF4bkiSGztfU2JX3mtrHbBFi99OOEKJMpfR8duk9SeTM/
         dnhg==
X-Gm-Message-State: APjAAAUuwgUWF7yTA02g0S3/S5Dd1Ulh7XjyrmPgeDc3/s+lXCZIT9fM
        Rp3/n+Is7cHKzEd1q5vpbiZO2NXvECleNuaWDMzPmQ==
X-Google-Smtp-Source: APXvYqy1kKchXz+oPn0n/cgFca4K27JNgGB2h8SdeZvE8qZywL3z2hE+b/iLMb85HvQngCIZt5pFcC7UNWQtn0HAkug=
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr4434046uar.104.1570096943050;
 Thu, 03 Oct 2019 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
In-Reply-To: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:47 +0200
Message-ID: <CAPDyKFpHdOGqSTDd95m=NjcE+vkW_p=61UFFegJ9QX8j3UdB0g@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium-octeon: Use devm_platform_ioremap_resource()
 in octeon_mmc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Sep 2019 at 14:28, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 14:20:34 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-octeon.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 22aded1065ae..916746c6c2c7 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -148,7 +148,6 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *cn, *node = pdev->dev.of_node;
>         struct cvm_mmc_host *host;
> -       struct resource *res;
>         void __iomem *base;
>         int mmc_irq[9];
>         int i, ret = 0;
> @@ -205,23 +204,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>
>         host->last_slot = -1;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[0] is missing\n");
> -               return -ENXIO;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->base = (void __iomem *)base;
>         host->reg_off = 0;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[1] is missing\n");
> -               return -EINVAL;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->dma_base = (void __iomem *)base;
> --
> 2.23.0
>
