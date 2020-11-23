Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40B32C0FD3
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Nov 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbgKWQHx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Nov 2020 11:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbgKWQHx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:53 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA4C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:52 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id e127so1586585vkb.5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THkIK27BZf78hxdnE1IQKA4fD1WbWFcexMw8JNVMB+U=;
        b=Mq3/zrmuE0QTaYQrurBP5tIVw/v7Czw4g8COZlpPyu0SbgUqnf3cFJ977ctpwBj940
         mlmuBJaSthMdE0j+Ltk2gWI+SyeAV7awrxrYGd3/2my8NYS2ZnWTbtNf5tcBagAexGok
         lSnpnsSNAUkRFwoZQUD+tH+m/AgQDNdV3hDjAO/uQn3i1CzwDOY08m4dgBCInwEJI6KC
         wNsTVBpnx+pd4cBvKKYSXcFJ0wW1wp/iYTeERUEynIDxVTP0JtpBovlBz73hCdSH0aNB
         xOH8ib8Tcx2vwh+qz8wH1qyW7lkwYcvhcnDOqol2wj9270UOvptyuND1mxh2Os+zyotx
         kcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THkIK27BZf78hxdnE1IQKA4fD1WbWFcexMw8JNVMB+U=;
        b=R9KqdQzt2An05t2uTJKfHQdIwrkLOBoT7K5xJbh1GUa9xPMkGRq/WrO3It0b+aGlT+
         PEMpQptPbnylLGMlAAHncntVgiipyTRbnJkkWffMiD+WHPGvV9c3Ws0VHwCNON8dbBtB
         LvHxsohRcs6sKPJXq6dcZku5PX6U0pYhb/1tQiTm5t8Vw21f65g4k+rAlgURzmoRkhUJ
         dd/DYVIK2Qi7F2pVhqJGdXb5aKJaIgOndV3+E3DicPdT6mJ53BsWCzgrKDpB8eN7bW1O
         ajuUsEzgsky83o6OFu+4W+VnOZTsWvnEkgAHapHSWotyIAOLp++1zZGcvPggiqcUYEpb
         5otQ==
X-Gm-Message-State: AOAM530F0TlBJkmNnib/O5A5YVt3tPTzv6SXxpCYmQ7WioDOweTKNhtH
        x3cmwFriIo0r9SipcOWUQxydycj1VcQGuzyfPLgZfg==
X-Google-Smtp-Source: ABdhPJwoFa1ahODSdW+Pnsfz1C2W1aBbG8Aw+Fo43/+tE+Yo9G/GC3ZD0XghWPAGQxyXD//X+RjsmVovghxAVd/UyTI=
X-Received: by 2002:a1f:5e0b:: with SMTP id s11mr533043vkb.8.1606147672185;
 Mon, 23 Nov 2020 08:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20201120074846.31322-1-miaoqinglang@huawei.com>
In-Reply-To: <20201120074846.31322-1-miaoqinglang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:15 +0100
Message-ID: <CAPDyKFqnram9LrgtLP8k-HncBYXKR3HRprfMZPyxqrpZKztTSA@mail.gmail.com>
Subject: Re: [PATCH] memstick: fix a double-free bug in memstick_check
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 Nov 2020 at 08:44, Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> kfree(host->card) has been called in put_device so that
> another kfree would raise cause a double-free bug.
>
> Fixes: 0193383a5833 ("memstick: core: fix device_register() error handling")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index ef03d6faf..12bc3f5a6 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -468,7 +468,6 @@ static void memstick_check(struct work_struct *work)
>                         host->card = card;
>                         if (device_register(&card->dev)) {
>                                 put_device(&card->dev);
> -                               kfree(host->card);
>                                 host->card = NULL;
>                         }
>                 } else
> --
> 2.23.0
>
