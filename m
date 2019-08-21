Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4255A97E46
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfHUPME (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 11:12:04 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46531 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHUPME (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2019 11:12:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id y19so892284ual.13
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2019 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUMyKmJFhJ8oTWIBnmh9h4xPbHSeyt+KYpO0csce9Vw=;
        b=p57AVHdrU8LfAaO/4NQmp0YIV883u9A8oGuT/0lTO7/d4yTozP4vrREUAo2fI8/pj2
         vEn74Rko9yvRQ9coD3NOupudItJn3WYTGHBBfQXQULGin9kh7MEtzY+SHNGLakUOCv0k
         4cozTYytIb5OgF9m1WLvYkaNO4AhCJS2E5VpwkDg1qZLuXk7tVjLkRDBVxrrwXWvORuR
         gao3tJwvIRb4/k7Jh7aIo/CvpqhUnJwyVpwD3AJ2cRUg7s9/2v+7s3aok1QFdpCrlx0g
         xy2ouNnQc404zM+tBGJ5KiZaMpZ6h6tFDQ51/1r/AD0oKX2rzrSZT7sI7inLKb9YKZd2
         5Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUMyKmJFhJ8oTWIBnmh9h4xPbHSeyt+KYpO0csce9Vw=;
        b=sALqUXcC4+zyLt1YmyGYkqRLwZGIK4kR4YRlHmlPYzT5QB/Jo2vE6y16DtLRUAYNoI
         d0Whr1ZZczrTymxG1ZOquveCWtO8I87fXUlGG7jWGC0q2k5vivMk+NUeKxhdTyUqqoUM
         WpZIIIOoaP8HTBWbkViEZJ6RkaGbjRWUZleA5fZ/rP+YW8Aw1oUsAxr/AFRpiTO8hKQD
         ML/5sSnF1dzYdlzV677c2+lLV6U2teYdBNugosFz4wzf9AITGYe7heOs2h3zJQIgRPvp
         wlr/dGYB45c6HIkyXRjx0X6xlyDh25PLs67un3xj0L/y8eJLq6pekTn7H9EW3whOY1Wk
         QcKQ==
X-Gm-Message-State: APjAAAWnbfo3Zpl6PXHtEC6suAn+6nUMXcx/te9DR2SgVSjU/kKJmICs
        A5ej8thAaQB+uESAOc8BC/j6s69JjeIcoydiw1+2lw==
X-Google-Smtp-Source: APXvYqw34PGFc2KHJjhX+a05krD1HACjX8OPE7xB0ac6ZvKB1Qz8kd0HLiAoOnxVFURF2PdMhEaxVX6FeRNAWBSilJQ=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr2757092uar.104.1566400322137;
 Wed, 21 Aug 2019 08:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com>
In-Reply-To: <20190820114229.11948-1-ja.kaisrlik@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 17:11:25 +0200
Message-ID: <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     ja.kaisrlik@gmail.com, Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Chaotian Jing

On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
>
> From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
>
> This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
>
> Turns out the patch breaks initialization of Toshiba THGBMNG5.
> [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> [    1.648988] mmc0: error -84 whilst initialising MMC card

For exactly this reason, when getting CRC errors on the first attempt,
doing a retry makes little sense.

I have looped in Chaotian who has some more details about the problem.

In any case, Jan, what HW and mmc controller are you using?

>
> Signed-off-by: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 74e4364bc9fb..09113b9ad679 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -564,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         if (index == EXT_CSD_SANITIZE_START)
>                 cmd.sanitize_busy = true;
>
> -       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>         if (err)
>                 goto out;
>
> --
> 2.20.1
>

Kind regards
Uffe
