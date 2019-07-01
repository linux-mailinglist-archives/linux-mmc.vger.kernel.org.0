Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457DC13686
	for <lists+linux-mmc@lfdr.de>; Sat,  4 May 2019 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEDAUx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 20:20:53 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45029 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfEDAUx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 20:20:53 -0400
Received: by mail-yw1-f68.google.com with SMTP id j4so5672125ywk.11
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u1LS+6EqPde0F+xVFBLFStY6rhD6RydqN/kGWzKQf0=;
        b=YU9EPwrhmmXadyeroskbASOXBwkuSiVpsxM5r1tpL1zoFYO1+XqiRm2a8HecWWAg3I
         bEct98nox4aXDJUtojb/NYqyUZ2z2prwd7BJf3DJH33w4na4cFh85CYofQWnvVRx+Iod
         0rLrYWhcO5VjwnuJCMLlhljGSuT1p4svq95TJ9mHiumO2IlzByTI5loZX+kgdexEsUZ6
         Dpsmpd0UL9DTn2EBBY3dOd8p4w/8MwdS5mRUtrtfueN/d/lbdfgRE4wgyu+1nwXUFcyu
         4HSdcjoayXzP2/PvhBYDs9pMFZYAncBgEli0wIDFBEltwRQFZyNSN4a4tbidhjH9MA79
         YjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u1LS+6EqPde0F+xVFBLFStY6rhD6RydqN/kGWzKQf0=;
        b=mpIRitk+263We0QHwnXHf1Zvto1uL2loKO4u2Jmz6vn/QkjELCau0q++SpY9MvCXJP
         g3ysUHt3P8vJgK9F55kbeXzTTQ+K3Xq/EcZY0W1hOJgAqHM5Yxmx7miVroPPSvEUPnRF
         0+ZtISIJp0c2ppTz4UXSu/fqUDO8ddl7K3e3hNkN6SH8jruFKyvgzvIEyWHiVdq+I8ar
         lQ25//Jnw6ikj2qqmXonfN8u1CXevCCo5s942uE9Ghm1qSRYdvhoA3bdbMss98C8lZkT
         cI/IuWiAIwCTvCYWoWP5yKpP8Q6suFvdWeUZPS3dqgJW36TzLyjv338GvYZTWn0DyahO
         kOCQ==
X-Gm-Message-State: APjAAAVSpPr/IX2amNxHOUdN6bzA2CpkPyuO9V3sQRapzVdB2RmT0PNH
        hEzfzeHLJJBMOs83Ly+iOvOD9eM7U5HNOfmxO7vLaw==
X-Google-Smtp-Source: APXvYqxZ0MJdyv3RZ5UYVNcpudMiD1zPtDVQBqLz9kFWv+/GAVLknMFUquuDlVBi73oSm4fBY/9sovp3rLwLQ8Vtbnc=
X-Received: by 2002:a81:5a0b:: with SMTP id o11mr9041234ywb.444.1556929251923;
 Fri, 03 May 2019 17:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190503233526.226272-1-dianders@chromium.org>
In-Reply-To: <20190503233526.226272-1-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 3 May 2019 17:20:41 -0700
Message-ID: <CABXOdTdsB82EGn_9ZTQCS2TfcNSR6Mq5J9WjGYbdrKOPsd-jzg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Fix memory leak in blk-mq when cleaning up
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 3, 2019 at 4:35 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> If I run the following on rk3288-veyron-minnie (a 2GB machine)
>
>   cd /sys/bus/platform/drivers/dwmmc_rockchip
>   for i in $(seq 1 3000); do
>     echo "========================" $i
>     echo ff0f0000.dwmmc > unbind
>     sleep .5
>     echo ff0f0000.dwmmc > bind
>     while true; do
>       if [ -e /dev/mmcblk2 ]; then
>         break;
>       fi
>       sleep .1
>     done
>   done
>
> Then I start OOMing somewhere between iteration 200 and 250.  Using
> kmemleak, I see reports like:
>
> unreferenced object 0xe39c5580 (size 64):
>   comm "kworker/1:0", pid 17, jiffies 4294821091 (age 96.952s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ad19d10a>] __kmalloc+0x1ec/0x2dc
>     [<a28614c3>] blk_mq_alloc_tag_set+0x27c/0x2bc
>     [<0955ae01>] mmc_init_queue+0xa8/0x2a8
>     [<5102b986>] mmc_blk_alloc_req+0xf8/0x2d4
>     [<f1c2214f>] mmc_blk_probe+0x4a8/0x6c0
>     [<0dfdd9d5>] mmc_bus_probe+0x24/0x28
>
> It's pretty clear that we're missing a call to blk_mq_free_tag_set().
> Let's add it.
>
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Nice one.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/mmc/core/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..09071e13282e 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -480,6 +480,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>          */
>         flush_work(&mq->complete_work);
>
> +       blk_mq_free_tag_set(&mq->tag_set);
> +
>         mq->card = NULL;
>  }
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
