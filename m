Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D939EA09
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfH0NuM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 09:50:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41543 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfH0NuM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 09:50:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id m62so13425416vsc.8
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTZR6LdKwcSbwfdwn93BfaDLAmGJGXIkCRnUZoJwcDs=;
        b=GTwmQzoFH+Tg9fKVZzfHe1WUyzKv1Pp5M6yGaUKuQYsscw4ybLHFf6AYfABE+HhDW2
         lvRV+wDzGtNmqV+SW8P/Ydpuj6VzRJ3V/NUGTiLSdkDTdO19tI08aecQo6a0ak8Uxz5p
         ZdCRCkWPYZepPS5r45I4qde4kPqs5XU2tDMK2PpVHbF+YCL6OsL+S4w9/ghPjKAiA1vE
         rLI2zhF//RHBqNm5xd82kQ5ZzTL1ZkXm0gEVszqeB5lp8C7BlKWOroqGH3p7py8vhHcU
         15UAVgSh1rt/XjgCBlHcok6zHQXNsxkDChbwxs6ItwvW+e2mjpFi2knd/ZvHqEpJPm8/
         6m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTZR6LdKwcSbwfdwn93BfaDLAmGJGXIkCRnUZoJwcDs=;
        b=gTrSnAX40Bcp3ZMD8oBkZqI1qUXOr3Y622uq0bQuHtlYidRNa280vozRktJTLTUBtq
         PVjsX13HFyJjU2w8Y7W+0ycTXDnxqMRLW8nDTfl0Lzz7trkE4+BeHwczCKuF0ewZlWir
         Pe0LxYUkUeF88/mFfJk5zIuq2LEoK0A6+rsS42vr24wESSWh8CXxdFAu3zjNQpkSsBBm
         37Jjof6GA7TZlZY0A6NIpvhRvs9Omfvlmmw3fLwn2YUwKAH3j67W7w1s24fT8DWuLE6Z
         piI5t7Kutu9sc2ZkxGXdJQwaJ1ZbhBGIo8j6vQX3Zo0csnGg/ZLSQ+c2bCKW5cavzom/
         FvEw==
X-Gm-Message-State: APjAAAXB1GtnTun/QuUY3n1LbN5wxR6EgLnIIL+3CJtAeiXnBvyymE3x
        3bKynAGqc6zNsI9wRCq3LUU6Va854ILJMEgzmqxnrg==
X-Google-Smtp-Source: APXvYqxVAesgRp6go5fs5U5yCFtV9GAgU3Q6uXxLRPmT/g0zU/qhN39QHXlMiw6eTwbtXMYJIlbDKJyZBtiSgueVLDE=
X-Received: by 2002:a67:347:: with SMTP id 68mr13732654vsd.35.1566913811087;
 Tue, 27 Aug 2019 06:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <1566628264-3289-1-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1566628264-3289-1-git-send-email-wahrenst@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:49:35 +0200
Message-ID: <CAPDyKFo6cWqRkJg=aoVzjHiR_Q6CWHe4et7QimWeWVZyLntQ9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: Take SWIOTLB memory size limitation into account
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 24 Aug 2019 at 08:31, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Make sure the sdhost driver doesn't use requests bigger than SWIOTLB
> can handle.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applies for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7e0d3a4..7ec0d95 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1314,7 +1314,7 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>         }
>
>         mmc->max_segs = 128;
> -       mmc->max_req_size = 524288;
> +       mmc->max_req_size = min_t(size_t, 524288, dma_max_mapping_size(dev));
>         mmc->max_seg_size = mmc->max_req_size;
>         mmc->max_blk_size = 1024;
>         mmc->max_blk_count =  65535;
> --
> 2.7.4
>
