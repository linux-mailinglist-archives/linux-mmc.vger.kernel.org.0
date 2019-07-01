Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B38E0BD
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfD2KpQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:45:16 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40140 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfD2KpP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:45:15 -0400
Received: by mail-ua1-f67.google.com with SMTP id u34so1457987uau.7
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7gYtkBUOPSLv5k145jA7GYbd8ECOPvHhL9iGTr636I=;
        b=REEy4gm9xyMYbOdHYdCvOmm7vnZyiUb5EaRfeMyl+x3d55eCmnA7TZLoapypFxIcYU
         3cCiY7IWQkqxILzRwSKSt4JzzmB2S0eiKLWeA8yej3B9i92HoKdcfwalt98wocnVgj03
         +O7WwpTCGmf21LIKaTP5u9TqlFZCod1vp5F+FitshF8m8amHduYET+Y1XTvNvh0VVXir
         DCoIqusd5S/rM88BeW+L740a0LxiekzIlyTbCVbF0QCBBEQm//QeRWt75RScoZLgxX+2
         7TFqyxbNZzYYDZiRt5U/u26j2/ZgPn7dG/HtEfYaT9JQtOdy5wwyxJBNbsI1tXv6JASk
         YGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7gYtkBUOPSLv5k145jA7GYbd8ECOPvHhL9iGTr636I=;
        b=s4axGuBTEzP/gT7bQVMGNllF7lpFi9Dx0Oq+R88tOghkLqyDWOeuaLf4oTGoeHRE1G
         /mtwB0flhJvUpQ8y3mHocMMrEwktk2+PJ/ljkn7IIHAEH4cUtXbwTl/MzV7iCW0vXPtT
         eTCfUlYUUAmpveH5JSdciS92mkv9o8UBp/3A5K/sJ+IXCU2aCbiD7L0u8eV556K+sXoR
         ZcyPgGFsHaHTAgGH087H7A+9PXmk+/z1gtOP5lQ8tyfJxnycPiv9MaZ9jnkXa3a1lawx
         p198r1hVI4bLiy3pUyxjliEuwR8cEJCM0kGq/+rFfRON6ZJ8UXpi0Uhmn4wWi0IJZp4B
         pG0g==
X-Gm-Message-State: APjAAAUEf0RcjZQonDS+8MZIGRWfzuZMKNaUQhqBcd1WfRpJkLw5LUwn
        G93Mn9noVK5mA+VhMltL0preEBy8wgPzAknZAaq9AA==
X-Google-Smtp-Source: APXvYqyoVysFFYfkvez3o3QNevz4TfKGfpa11v2MQNm1z+VzGayWpSsj88VnbGsZRi070xCmuHQQNe0FuHgUaZmpg4s=
X-Received: by 2002:ab0:2a53:: with SMTP id p19mr4955459uar.100.1556534715006;
 Mon, 29 Apr 2019 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190416075845.GA15615@amd>
In-Reply-To: <20190416075845.GA15615@amd>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:38 +0200
Message-ID: <CAPDyKFrORt9P1f2NmZRQkwY353K2jicRueWxY-aKVO9oTG_qOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix warning and undefined behavior in mmc
 voltage handling
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Apr 2019 at 09:58, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> !voltage_ranges is tested for too late, allowing warning and undefined
> behavior. Fix that.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..b3fa9c9 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>         int num_ranges, i;
>
>         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> -       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!voltage_ranges) {
>                 pr_debug("%pOF: voltage-ranges unspecified\n", np);
>                 return 0;
>         }
> +       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!num_ranges) {
>                 pr_err("%pOF: voltage-ranges empty\n", np);
>                 return -EINVAL;
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
