Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A0DF12F
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfJUPVh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 11:21:37 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43794 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUPVh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 11:21:37 -0400
Received: by mail-ua1-f66.google.com with SMTP id k24so3908939uag.10
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvOcHe5sgnM2Ih10HPGzGtz2+0bgk7nxRpCIIRNQM7A=;
        b=woqRl8XYxFpkzjzJqhbqZ/o37KeoHSE0zn/+EdUQU4kQK467JyEQRZgquspYLySMJZ
         vCMxtniRWFfq8PVlZ9OGFFzdq97rjpzYh2Im6/ZIWGl0l35q9u2nYtQ5qwKUF7FS4wL7
         2P0Kj/jEd3jg7Ez+ToqzRJnuVTDh8d3UGFwF8JzCSQDbp3qtYPyET4z/jfS7ij6tJ/hf
         7GL4CWrXtUAiwDnyu7Ne2DqOG71Tws7noIZu7fb3BkqnZcwLLw0UoXtQrahfr6Jjm7pn
         eNodA3bDqT/zML97urY/UvCPJ49M4R8UgiqBKA69H/qeXbtrLLspLWYcCBKJrcF67F5G
         dokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvOcHe5sgnM2Ih10HPGzGtz2+0bgk7nxRpCIIRNQM7A=;
        b=YVBQUuvdwe7wlK22RXeDlu6cIxzRfOkUYIml8l3tVaDNzDuSZgJBD07c4EwcWNEpl+
         tM8Rm/7/WZO3zRBG34uMlCDpKdC3MqOXpRlWa5hRGtJjBMxeG3HamV5ifki4FYYBlt7/
         AYIuN7bnsto1Qzi8F5hgwqEnD8BXxcx0QpL6KKSbhes99A8jrn/1V2YiR2XETM9ZHA39
         4lfxyf5r4QoTzrsBaiFQHeOVNRxfmqsY38hSf5xMhEiT0+lcoNoIlNhKqIhuX4aK5fQH
         xtNLCyeH9RYQpzAZQ4GAWyIqTZxYItJUKoMYdVMlu7c2KDuHZAxUVcNdz67sFhKnGoDF
         zK/A==
X-Gm-Message-State: APjAAAXVoRP3clOfc7QPnvHuY3GnuCV6PGtWvJSE47KcOxprB3Vr5iBO
        xj7Y0AIi+qexJRxk7isfr78ffRk+DO92B3dMOZa8hw==
X-Google-Smtp-Source: APXvYqzhMXR2NneFdAKl7YDt/OnBvYSd12yNpMMH2svyTHRBphhTEAUOoTgn9L00HK1pOKlkytzxjOdn37raM4VctCE=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr6180177uao.104.1571671295461;
 Mon, 21 Oct 2019 08:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191021143742.14487-1-geert+renesas@glider.be>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 17:20:59 +0200
Message-ID: <CAPDyKFr5H5x9LRjvVsDbNoGgZx-EnZGgUD9fEt=esN8HumNDHQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] debugfs: Add and use debugfs_create_xul()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Oct 2019 at 16:37, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> The existing debugfs_create_ulong() function supports objects of
> type "unsigned long", which are 32-bit or 64-bit depending on the
> platform, in decimal form.  To format objects in hexadecimal, various
> debugfs_create_x*() functions exist, but all of them take fixed-size
> types.
>
> To work around this, some drivers call one of debugfs_create_x{32,64}(),
> depending on the size of unsigned long.
> Other driver just cast the value pointer to "u32 *" or "u64 *",
> introducing portability bugs or data leaks in the process.
>
> Hence this patch series adds a debugfs helper for "unsigned long"
> objects in hexadecimal format, and converts drivers to make use of it.
> It also contains two cleanups removing superfluous casts, which I added
> to this series to avoid conflicts.
>
> Thanks for your comments!

The mmc changes looks good to me. I guess we could funnel via Greg's
"debugfs" tree?

In such case, feel free to add my ack for the mmc changes.

Kind regards
Uffe

>
> Geert Uytterhoeven (7):
>   debugfs: Add debugfs_create_xul() for hexadecimal unsigned long
>   mac80211: Use debugfs_create_xul() helper
>   net: caif: Fix debugfs on 64-bit platforms
>   mmc: atmel-mci: Fix debugfs on 64-bit platforms
>   mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
>   mmc: dw_mmc: Fix debugfs on 64-bit platforms
>   mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call
>
>  drivers/mmc/host/atmel-mci.c   | 10 +++++-----
>  drivers/mmc/host/dw_mmc.c      | 10 +++++-----
>  drivers/net/caif/caif_serial.c |  4 ++--
>  include/linux/debugfs.h        | 10 ++++++++++
>  net/mac80211/debugfs_sta.c     | 17 +++--------------
>  5 files changed, 25 insertions(+), 26 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
