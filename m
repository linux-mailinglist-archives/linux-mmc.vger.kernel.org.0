Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0674F33
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jul 2019 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGYNXT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 09:23:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46031 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYNXT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 09:23:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so37643226oib.12
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwM2+qYHt0UEBA6UJDkeQDcGwUyIPjkorh2VTV9IDzw=;
        b=UpD8rDzoKa7CF0RszwEp2yu+B1fDuQVKouFsCxQnA5dTxpou+Ba3K9lVpz2jMPqq/1
         sxeFNJK6Sf38cQGqrVLHeAQfBsqpgOTYVX12hsupalkh+KnDYymBDvqA/45etUsKBwvZ
         0Ab4Z822WfZQm+okMa5x6zu0rnY+sVZpRjGRLe4ekSilG1jJLTHwNCG57S00SQJ5TMeq
         FkIBGCDmkRRu2QfHuvfH0DHb8rHjKJn2RvtTKU2M76OnXw1kYCVoK5OQljlokqn7EnmN
         6P5kJri4WNNlZJ+Uj/pSGWD+8m6are5chNBp4JvdEWWOhAaKh9LZB24sZiuH7WT7DHK/
         kCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwM2+qYHt0UEBA6UJDkeQDcGwUyIPjkorh2VTV9IDzw=;
        b=nGSKC378JG+IUws+i0C4YtYSzfMJ1d0XYllrT/NnS18vKQuTwsQ2idn4zUBm9VzAca
         aNLiP2btqWYvFCHxb+dfWTz3zICgxJz83lh5a9gZf7BzpT6w/HBsvb0mfhEHOQgF2HZz
         3GbpJbVeGuaqLdzGYGVEREkr1r9dSl3Qhi3fQiNEHOwNKQZeLoYWpvWN0mtCzG98p9d+
         5PlA0jOkHjAq43Utg+AXkhI7PbsvIYPmCBAt7kqoUTppUnmorVQFByt9a124wL+m6fWl
         FaJq7YmGPUFRUUZvZBYA7nNSG0Of0wAoLl4JAPUXvLKwE6gI1j4o2HGsdpFB8yed6E4S
         /gKQ==
X-Gm-Message-State: APjAAAVCgw4ZdvrijQQrAQpxa3AAjGjS3+Vzbvh6RCYQytjz1wt29Nrx
        Z47KApD1PsqB/mi44bW9PqoIU/gVu+/+74Xup/NRst1Q
X-Google-Smtp-Source: APXvYqypjRf2awMQdztO7PYDu9Rw91aR4GcRmWVCqGbM344Dbhlb0mEkUpz8ySSDsEuabMZWkpRRW0tnWgt9tzqllw0=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr33137975vkk.36.1564060526687;
 Thu, 25 Jul 2019 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190725151748.1a59b1ba@xhacker.debian>
In-Reply-To: <20190725151748.1a59b1ba@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:14:50 +0200
Message-ID: <CAPDyKFpwOaa-8GxkWnXoyoC8nLyGMGE8moyEJr4a7TVBSiw6mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to
 simplify code
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Jul 2019 at 09:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> devm_platform_ioremap_resource() wraps platform_get_resource() and
> devm_ioremap_resource() in a single helper, let's use that helper to
> simplify the code.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d268b3b8850a..11ecff9e998d 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -118,12 +118,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> -       struct resource *iomem;
>         void __iomem *ioaddr;
>         int irq, ret;
>
> -       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +       ioaddr = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ioaddr)) {
>                 ret = PTR_ERR(ioaddr);
>                 goto err;
> --
> 2.22.0
>
