Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2180713995
	for <lists+linux-mmc@lfdr.de>; Sat,  4 May 2019 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfEDL5a (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 4 May 2019 07:57:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34125 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfEDL53 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 May 2019 07:57:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so3950453lfi.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 May 2019 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiyRbo1iY86Hzj/M9NZN8C2mes9fddgxbrKTHjW5zE0=;
        b=W0szkNx1iiyxaYo8r6H+St058PnaetwCUo33soDQrFpJNn2nwOQZViAv0yG6Jp8b9u
         WF5/8XtnKzKxUtXTnumQKyxDDpBg6G2CGj4R1OwPPplj5AALmSzM0uGmB1wKsvxJ4Jvo
         MJu7NY1TsgYZ1GMYFSObLA6vNZME2YaOUZUG8MiYoeYSiLLQfSiKn95Misgn7KsYDOt4
         81MMkMF4RsA0BGrpniw7QgTuLH1u9wA901MM/Dms2rGRvKDWMZDxY/H5fymZVHtm1Br4
         p4RVdIx2XBmJd03DXbZepO8zjHgxyrIvDVijCZun7O0h3yBHGh3xHil2eyswqh56PAqR
         TSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiyRbo1iY86Hzj/M9NZN8C2mes9fddgxbrKTHjW5zE0=;
        b=Nlb17fYWrBwmoPOaWVvQTyVpbryl90fH1JMh1drzZ2QEnx2YayW6L3SNvdtjmulIFF
         /wy3jrUEFmzz3/birpB/VLS/ZQ7qDJU23+UJI8W0cEn9AdJUhE9fV/371BLTgFLalHw/
         PHncOc4vwFXNxbnfT+yJHpHeVbE82dKp4Pk0iGhP7DVDSBxc9xqPfjwJncrMLY+g/BCa
         5fhhK822NJ2GZfhjc0J0H0z7zsnul4o4XdOHnETC+coUAOpXyKlKkwVCzKxghccfadV9
         7EL/ohiFvTzjug7WeqrE3oWLidB7vWEQfgwi4jnVSpmbfcPSBPf8xk0/Kbw00it+1r9M
         wBuA==
X-Gm-Message-State: APjAAAVe05uENTcbCj3nrwt53cEUMHtur0PDWyP6GzaNE8lDORq8uzUZ
        oW6MCKClyo4mEq0DBvT8zcrvXojArqTtAYxdt8/DWg==
X-Google-Smtp-Source: APXvYqxBCbcM80t0WxfKywlZ3nTrDenba3/3wHSY5uq0o0NQn4HQaeszpvwzuYZERdQCXLNLqfPGCxXO+VVUTUB/cBc=
X-Received: by 2002:a19:f001:: with SMTP id p1mr8317318lfc.27.1556971047580;
 Sat, 04 May 2019 04:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190503233526.226272-1-dianders@chromium.org>
In-Reply-To: <20190503233526.226272-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 May 2019 13:57:15 +0200
Message-ID: <CACRpkdagZCpFJmZ7+-DAQBD7mg5Zs4+mrT3uByXKoGYTS5yERg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Fix memory leak in blk-mq when cleaning up
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        groeck@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
        drinkcat@chromium.org, Ming Lei <ming.lei@redhat.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, May 4, 2019 at 1:35 AM Douglas Anderson <dianders@chromium.org> wrote:

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

Looks correct to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
