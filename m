Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702B7DC347
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442498AbfJRK7F (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:59:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46938 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442496AbfJRK7E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:59:04 -0400
Received: by mail-vs1-f68.google.com with SMTP id z14so3703170vsz.13
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tni646pGbvRi6tG884NgqaXPsDZfvRsu3le+zg6U7NY=;
        b=VfrWEc+UPGhpJH5fu/FNXtKAqp0bXqeDPFACowzEefNZ5zLtQzHkw+xZos8Ay7Bheo
         3yR1EtxX5qGKRdGcvw/rBZxrrbWc/uABpPzYGgPes0QHryGGXhlQ6B71AXvDDl9h30AT
         B9IG/QNY+xQJO+ADY8LsAiZa/Xn04u3HZSlwKq3j0McxeoD9RyST3TRSxjAblSOhow6m
         54nACDW5Ag/W/7qvH26U7wz5pdzpH8oYrKUup98DqvksL8PdIITSWOt8b4uaWHTWMJgF
         gghDxGv5iPBJTNxv7k9vq89C6JKGckPAW6V9f7YmcUK6XJzhv3NrucPcQbeQg+a7NKUa
         5AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tni646pGbvRi6tG884NgqaXPsDZfvRsu3le+zg6U7NY=;
        b=TjLmY1IV4wAItJjXxFORLvH14zDta9gYAGNKuKVKp4Kt8v3jvstVEDIHjO/Z7yWNuX
         k1+NEw3R0mlyJ0CvtJnCOQ+/21caKAfYGbfcJEiYw2MQoHRr1n7a9bATiZOy6PLuB+h+
         yrkd5JDx20ilv4s3+xUB/4KYdM0jnudw17AdPXIMQRBezC6D2wma8+he9TS6caFFU5xD
         TMw/TzxrwgRXAqCcAm4HyX3uJSTjl57cHDcvXmSwbE30UOb28GV9x4l6mwu3gKxx2q3W
         ZDlPDGPRvMIx12SvjdhZuS1Gv1k7FZESMg3pMY30fK/+/TMRVkWFAcfH7c1zR3GYP1Qn
         /tbg==
X-Gm-Message-State: APjAAAWuJqehO3/C7UZc6J2tdKhiB12J5df/gAZOCwi+i6V5YUPQF0FJ
        d6ppnduXIuKz7LiZ9oW61et8LQhC1qyQKGuOS4jaDQ==
X-Google-Smtp-Source: APXvYqwT9HIEtXhd36+Y0n3RLEWWZSoIkbijxLPnhyiL+bV3YQ//L1TyRMcHOhW3o0/UChzraPW1Awf2Y7Mq/QFe09k=
X-Received: by 2002:a67:ad0e:: with SMTP id t14mr4277823vsl.35.1571396342758;
 Fri, 18 Oct 2019 03:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191010105230.16736-1-faiz_abbas@ti.com>
In-Reply-To: <20191010105230.16736-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:26 +0200
Message-ID: <CAPDyKFo=00NzUUs45bokScp2XUBRaEEvtr4PHWVSXk3x7zV3iQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Oct 2019 at 12:51, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> According to the App note[1] detailing the tuning algorithm, for
> temperatures < -20C, the initial tuning value should be min(largest
> value in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in
> LPW is (max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len)
> itself. Fix this implementation.
>
> [1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf
>
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 41c2677c587f..083e7e053c95 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -372,7 +372,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * on temperature
>          */
>         if (temperature < -20000)
> -               phase_delay = min(max_window + 4 * max_len - 24,
> +               phase_delay = min(max_window + 4 * (max_len - 1) - 24,
>                                   max_window +
>                                   DIV_ROUND_UP(13 * max_len, 16) * 4);
>         else if (temperature < 20000)
> --
> 2.19.2
>
