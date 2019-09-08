Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588C6ACC11
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfIHKc6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:32:58 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46899 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfIHKc6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:32:58 -0400
Received: by mail-vk1-f194.google.com with SMTP id s28so357812vkm.13
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX3KqjL4fKpxNJSQAl68andrMAZ0zFQA7utOvXr90Wk=;
        b=c04Ea7Qd/zMKT/FcbxFqguzMDiyky5hl4KTgVxYklu0gvxwcYx9WE7wEZOM7bJ3q+T
         LpLB04fsPXAQGKS7ORsUyao+D9Ck/clQqS4zXpFn/MU9UZR94Z/MNfiW4kShbHjWnF2i
         VHF9l48x7V4MhX+e++ks14gtSiiDwTUwFRNKh2+8M27ZHd/db64VmIvFtq0a7uQvlGii
         2YuySmS+2dFEs5XirH5TuhCAvqRlBtRheiUbAGGBINaarTGq6VFq1I1yN4JHmIgR889R
         iblEZexgIi9vJAXzXuIsetwC501NJImDYFMCDS/vnHP+FuwuSu5iCcWzFDWKIJzq7pyT
         V5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX3KqjL4fKpxNJSQAl68andrMAZ0zFQA7utOvXr90Wk=;
        b=XjTSPsUM9ekfX+LVE7n8vrUYQ9k2jqxPcnmknHMTlUfVH9A+4krfm43PZiR5Etbf46
         Z2Q4L97+GvVKuvuvU21IXOvYLz7WUNFbMUhyJBspmkV7Oljlk9Rqj4JvepX4OH3A/TSx
         t96xbjHieCIqroH1PP52HlPCAzayXzF2/2jMLc8LRsqGDHyOtwiTZoQVCxQaXzVjWUhy
         KJiaOxda9CuCaJKdCliYpNHMxRJA9mDI3Ox30yH+1ye7cldoFmrQvx7xM/bW5TuqooYK
         KMGkf/aaAgKCr9Qfp3C9803wUne+RdurFIj4dwcH0urU3/5ahaMFoSQB2jeo+jVGlj3L
         5z4g==
X-Gm-Message-State: APjAAAXqiOlE+KmYhSkMMxhWMzf/8hvgB1gSIsblf/x8YdIshcmHUx0z
        69YtzLR4d21/9xTdz3/8ZisR0GoDolACpp6y9MFReA==
X-Google-Smtp-Source: APXvYqx6AtGiyvrIbxIWnNr0Pg+dtCTgbgAuq/Fhl9QAovGWe1AuWd8I7KV41uSYL4a46U13t4KwGpG64r4f7TfJw2E=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr8536398vkb.4.1567938777211;
 Sun, 08 Sep 2019 03:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <1567928752-2557-1-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1567928752-2557-1-git-send-email-wahrenst@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sun, 8 Sep 2019 12:32:21 +0200
Message-ID: <CAPDyKFpdZnQaH9NfTsmFk2pjREL_pv6netQjwubMzrkXAOg6hA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: bcm2835: Terminate timeout work synchronously"
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 8 Sep 2019 at 09:46, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The commit 37fefadee8bb ("mmc: bcm2835: Terminate timeout work
> synchronously") causes lockups in case of hardware timeouts due the
> timeout work also calling cancel_delayed_work_sync() on its own.
> So revert it.
>
> Fixes: 37fefadee8bb ("mmc: bcm2835: Terminate timeout work synchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7e0d3a4..bb31e13 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -597,7 +597,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
>         struct dma_chan *terminate_chan = NULL;
>         struct mmc_request *mrq;
>
> -       cancel_delayed_work_sync(&host->timeout_work);
> +       cancel_delayed_work(&host->timeout_work);
>
>         mrq = host->mrq;
>
> --
> 2.7.4
>
