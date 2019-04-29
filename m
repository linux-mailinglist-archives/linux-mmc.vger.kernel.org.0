Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F543E0C0
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfD2KpZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:45:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36882 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfD2KpU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:45:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id w13so5596528vsc.4
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wB2+v3/4hkcBVeYj+nJ1UzqbRgscjCwCH+YTA2DMZj0=;
        b=iyYPuGrdsCUJR/ZnjBsPUA7Go9ASgVCQ8XKFFn2YCC6ZH6l0ckxJlvSAr48YzBNA7e
         LcB5m7LMEl0aIOsU2ASoqhPISs6hy/B99ySRxaxiwwEa1+v+KjlDFovzr7Ou/hvH89WL
         a7u8E2j9EPxcfnTWLrzLPQ+B1TNjs4MkVQxi3EJSXo1/wpUR927GlN2Sy9fCXN4AqjJc
         0vzUnmlHEC3Rx0IkBsWWB/M8lojyphshst9zHBy8A4UGcImfhgQNdPE4pmGjd2y9ruW4
         AYPisn8ktuhzf3hzL1/89BZa9OxZrkfzEf5danbEKbHuES+B7EIiys3IAl72IAFLIkSu
         BSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wB2+v3/4hkcBVeYj+nJ1UzqbRgscjCwCH+YTA2DMZj0=;
        b=jb9vssM0kzQ01U/qq1ywR4CdYVOmSHA3//dBc+7ZIK6H/s/O7/S/XKa/cL1Mv3t4SF
         dU0EbjyHyzOhTWXYUqU2VwoO032uRyDr9u37OP4gVJK3oWflx23yLCpPVmK0dEvhj58/
         EiVWh3GKmYbhLKp7D17QVwp7Xj7wpAjtdSA5Tu0sNvB/tayb5hObMpJl9cwp4g4TZqEu
         KRQyr709uT4EGYVqr7qr7PZp1NW5KupNsQ16+HgGS4X8T/OcRqRS8aLtgxE1sl28rOdY
         9y5bQdw4RB8W2nX45/QVApg/QnPQBd1LjXGCoin5+eF6EfHN5mqDgxe5JIfJCE231Jv/
         hSGg==
X-Gm-Message-State: APjAAAXA+mi2flT5lfJozI3xvZfvYy+J5GGw7r9zali2IP/hCbIMccSx
        aaDQokjp6HAXbBOGJ7y2/epKQdHNMFThvRaFiw3s4A==
X-Google-Smtp-Source: APXvYqymRPDSSufJF3SbnW2uPcsgG5wvChEANEaK22L/+zbcwghy0/+HFZt+0hsoiIiH9eE38CvA5mYB+RpR4pXdGbw=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr32153672vso.165.1556534719759;
 Mon, 29 Apr 2019 03:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:43 +0200
Message-ID: <CAPDyKFpsB4JJwNhDA139_=bKoWeJ7vxX+3BRBFbpc_P4xkeEUA@mail.gmail.com>
Subject: Re: mmc: core: fix possible use after free of host
To:     Pan Bian <bianpan2016@163.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tony Lindgren <tony@atomide.com>,
        Mathieu Malaterre <malat@debian.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Apr 2019 at 10:29, Pan Bian <bianpan2016@163.com> wrote:
>
> In the function mmc_alloc_host, the function put_device is called to
> release allocated resources when mmc_gpio_alloc fails. Finally, the
> function pointed by host->class_dev.class->dev_release (i.e.,
> mmc_host_classdev_release) is used to release resources including the
> host structure. However, after put_device, host is used and released
> again. Resulting in a use-after-free bug.
>
> Fixes: 1ed21719448("mmc: core: fix error path in mmc_host_alloc")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..f8ac567 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -429,8 +429,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> -               ida_simple_remove(&mmc_host_ida, host->index);
> -               kfree(host);
>                 return NULL;
>         }
>
> --
> 2.7.4
>
>
