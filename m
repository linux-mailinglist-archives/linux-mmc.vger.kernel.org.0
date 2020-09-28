Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6227ABD9
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Sep 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1KeX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Sep 2020 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgI1KeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 06:34:23 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55693C0613CE
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:23 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e23so453509vsk.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjY5fl6HDUc2l2AlN3kkW97cFvPBmXB5YCuUUeD53nc=;
        b=dwxgsAPacWj3Zit0Jujndz7E4Df0ipLAkZz/tcbg9k5eGQTht5hufz6yk0diRTvxvb
         lZ8KElcdi6kMTNq0CjpUnjaq4PhxXJr/9OTAFbwTrVjJ5ALLe2q5DybPo0EKN4JZzY3o
         H3qdGoIxtuLpyHrZ7/b/mgL79+jtxo4t2UjEzLwK5S7Dcnb2npoKHR5D/hkRyEMzpnNC
         IqUiW4KTf5mxsScegxgKFyUPFkA/VI1BLgsR7sZURdfySkLe1e4O9E9FXcpW3PZd3Ldy
         TcoIlzVUhm58zR8KJ0O8bp5i/vinc1kA/o1YGBXZ5gduFfRFCDQlKnpEXdhedTW3RXOY
         Dl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjY5fl6HDUc2l2AlN3kkW97cFvPBmXB5YCuUUeD53nc=;
        b=W/YlOjxbXvGEkQLBXjhKP9IF1TL/U4L/9JsmeoEEl/UA61z2W7o7+1tYCoGViLR97G
         kAUUqz2h3T3wxvcK5zMD/UzMB1glu9A689NAJEFxbkf/hfs6gYAASpvNVNjaKdRvf1Pp
         p0+DgQRSa4hcN0eDy6avvC7cxcp8heCrqrlw1s0qsLZuDh9ID4l8FRBzwngBvNALU2vf
         unXFa3GwghgrPKffzMLi5k22Rx81ThFIte0VahGJ+EapcqGkD3Z+SMXXpioGTxDG95b1
         4i5wAwE4j/P0Ds7mKRXu+ebK9Pgi0H3DUZBK3SJNJIJQY40eG18zAV0ufwZTeXzdYmyR
         zaKA==
X-Gm-Message-State: AOAM532lM0ngj2881kGhnbWJ9JBb3RmifVi8bSoeF9GoLCl9GqltVhQN
        Wscl/1nWSc4YbHjprfknnl5+bWBVbROZqmP0SW5CPw==
X-Google-Smtp-Source: ABdhPJwgHSw05IQH/Ec+pjLgUHnUYITQ5+QWCFsMcaLoHkMxNOjsErxsHQw3gDiApRWk/zhYp3IVUl4BPWGQM7owzww=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr5011637vsp.34.1601289262461;
 Mon, 28 Sep 2020 03:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200925084952.13220-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200925084952.13220-1-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:33:45 +0200
Message-ID: <CAPDyKFpRs1xSMj5UmV1PW_9sQBVNUABySxg-e4y+m7Sn4fYsPQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Skip allocating card when removing host
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "open list:SONY MEMORYSTICK SUBSYSTEM" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Sep 2020 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> After commit 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power
> management"), removing module rtsx_usb_ms will be stuck.
>
> The deadlock is caused by powering on and powering off at the same time,
> the former one is when memstick_check() is flushed, and the later is called
> by memstick_remove_host().
>
> Soe let's skip allocating card to prevent this issue.
>
> Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 4 ++++
>  include/linux/memstick.h         | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 693ee73eb291..ef03d6fafc5c 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -441,6 +441,9 @@ static void memstick_check(struct work_struct *work)
>         } else if (host->card->stop)
>                 host->card->stop(host->card);
>
> +       if (host->removing)
> +               goto out_power_off;
> +
>         card = memstick_alloc_card(host);
>
>         if (!card) {
> @@ -545,6 +548,7 @@ EXPORT_SYMBOL(memstick_add_host);
>   */
>  void memstick_remove_host(struct memstick_host *host)
>  {
> +       host->removing = 1;
>         flush_workqueue(workqueue);
>         mutex_lock(&host->lock);
>         if (host->card)
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index da4c65f9435f..ebf73d4ee969 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -281,6 +281,7 @@ struct memstick_host {
>
>         struct memstick_dev *card;
>         unsigned int        retries;
> +       bool removing;
>
>         /* Notify the host that some requests are pending. */
>         void                (*request)(struct memstick_host *host);
> --
> 2.17.1
>
