Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276BB2A7F52
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Nov 2020 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgKEM7k (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Nov 2020 07:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgKEM7k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:40 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D8BC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:39 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id f7so693612vsh.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcYVD8LEqXgQj8+4xZ30P3SoEK5SbThnfnXSJjWjj9U=;
        b=q3c0CcJWW3Yp5+fRoMt39iQyOeS16ql9LOwD6JST77IzqGimB6hDkQmKyGf9q07dTg
         Hiv+5YhxhzPXf5zPBDdkaM98jkridKcrZVGRWsHcSEG8cAA9nnrzQpuMWQCIhURAkpv5
         SyeiQ8ROkWtj1hNvnIhruS6z7NQS2PLw5lhj/eQr49u4UzlIlknlMdbbTgxd82qksol4
         kUU4EEH9npzfO5NN6gZYdvCvxFt73b3ETOwxUFtcsWRu5zWFjf8W2psR8TcD/t/FU213
         sEt7c6kLwi/agHhLjDtqM6LUD0OOyvK4flWQoFDxHV0e8ZJ5Yl9EaD6Df+kltIk6Ux1Q
         K2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcYVD8LEqXgQj8+4xZ30P3SoEK5SbThnfnXSJjWjj9U=;
        b=nNVMc3ySAfWCcllb3/CJvtvajszLS/w/0mzh2Psla6rKvzBZZcXVylxpowUnHkVBdS
         psIdZnFP3qOFZ+YhU2WDuBTOv9AlWe8kic8XTMqqXxmxqlX0GzvffySF9hlCtIHwWskT
         btgFWxRAQWURiNRCz2zUjdKGkfHMG/42oPZG8yh5Xl791P0VZjTVY/4TrUJY6kjyFR1b
         3rPI2t7r8MD/7OWOTKHxs0TybtrQxDU2ZKdpG0b+mdVv3kA+iB9YCgtLM8X+c3HpsOJ1
         qnC3PjERNrs8kEonQwQgbDsJlVIHNo8dZqsKA9uA/DjvAdHaKzl7bxJl/2OvnhIOOBrM
         vwgw==
X-Gm-Message-State: AOAM532yEzmXPdGc1amFB/PlN8jx5jGcouxRqZ4uxXa9WutJMcKUYJnV
        mbXHEJysRPQzNBlJLpYoBcgSRiLjs6v7UvE/vvrNbQ==
X-Google-Smtp-Source: ABdhPJyCXPYThdRo5a7gJehCWV1WQyzo/STXalTghHHdtLgldG1yVsd5Ox8OKcIRoIGYwJGamQ0szslq9j9NbWuiT5Y=
X-Received: by 2002:a67:310d:: with SMTP id x13mr1036122vsx.19.1604581179098;
 Thu, 05 Nov 2020 04:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20201031152708.2146690-1-trix@redhat.com>
In-Reply-To: <20201031152708.2146690-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:02 +0100
Message-ID: <CAPDyKFphxHnrWmdG3DoTEX9MpS+23ZwjKK3xny4_UWdpTbUzDQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 31 Oct 2020 at 16:27, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 90cd179625fc..2a757c88f9d2 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -290,7 +290,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
>                 default:
>                         s = ", (R? response)";
>                         break;
> -               }; s; }));
> +               } s; }));
>         host->cmd = cmd;
>
>         switch (mmc_resp_type(cmd)) {
> --
> 2.18.1
>
