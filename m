Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972E6FC844
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNOAo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 09:00:44 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42381 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfKNOAo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 09:00:44 -0500
Received: by mail-vk1-f193.google.com with SMTP id r4so1473684vkf.9
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJUZgKfy2YSWGNuA2+MgdU+Nr8ygHAVvjPLQAD+YtDs=;
        b=Um9OcmrFedBxkdzVXkY2EtsXLNyskuS4YLklz4fMGWFnU+aiTFGvjT8HDml+M1ErlU
         fsS2HvnmMPNZaNx6nyozf0V53f0VFp6xcqjCO4j/SyTSgEV9iAZTihxeQ7PGyd40EuHI
         OGz9A8awTDEhr1M6aH8bcBqUsMGiHgm5h+0V1RUhWC11o6vNM9h2zQrntTdVYVL1M3Bi
         hGaYX+MdnaFWX2GO5NxAwLqTuwWz0rIophmlgo4k9FYQyL4ySZg8VtdTMLPk4AS4wTA6
         3AnLRIeEb6T64QF23YubjnKP0+NtmPoxHR7Du0y3xfiCBv8QQcETgLbxDir5/+in1E5+
         f+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJUZgKfy2YSWGNuA2+MgdU+Nr8ygHAVvjPLQAD+YtDs=;
        b=Q++aUyYUiWbClYI5Cdml5d21AwI7AQuTpyULuXqvZbmsMFV2aE+ITyGRrbtbsg0r+q
         st0EIJWlwSS60e6GtkuNfaDwZiIFKMvMykEV6XeWZ/izyDXq8e+3NYq6GQ/Yqn71vY+3
         +xXWWT6XkApUpApz8Ra4Hhuh/YWdShrmSjXHHEBvPlrCphynzCtzZgcuweiXJA2D5nu0
         D927c7YPMeKSaa+6+EBQ+XN7D7Xa/NSv8KyhFJ3IrJl4MbEgDEnjrMdtjyWAxh4RmID2
         sDnDUjDArLzXalIzo6KSEzXooh+3xhZRvhs3Jd0gsPTOAivN59Entbur5VfGq+r2ZJZr
         vj8A==
X-Gm-Message-State: APjAAAUCFhtHGzX47hmAmgEkGwTjXmvmbeQ14Ssgf5WBy5aUSLaveE4J
        Tfy7bZIByGNwOjAqTk6xnui1y2W/xaX6FERro2OfhQ==
X-Google-Smtp-Source: APXvYqxglOLg8xzv1EZ/UOAGOFLRVXU+F1KB1IDk6i8iCyI7W7PmXp6Hxwdfvs1NSaryF11w4xB1Cg/GYOTyEXWRt/c=
X-Received: by 2002:a1f:fe0a:: with SMTP id l10mr5151920vki.59.1573740043247;
 Thu, 14 Nov 2019 06:00:43 -0800 (PST)
MIME-Version: 1.0
References: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 15:00:07 +0100
Message-ID: <CAPDyKFrrzNXxYywPW8cAZN86jBPoOFWt295o9ANm+0BrF4dehg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
To:     Eugen.Hristev@microchip.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 13:59, <Eugen.Hristev@microchip.com> wrote:
>
> From: Eugen Hristev <eugen.hristev@microchip.com>
>
> The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
> HS200 is set in the driver.
> The driver needs to enable just this flag, not rewrite the whole quirk set.
>
> Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied for fixes, adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 496844a..5fe6684 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(&pdev->dev);
>
>         /* HS200 is broken at this moment */
> -       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +       host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.7.4
>
