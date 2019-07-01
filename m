Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F09480F9
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFQLgB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:36:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34167 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfFQLgA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:36:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so5895359vsd.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSqieASavyS4hAmtN+rUBOJEe/7rLoXSKUZrznGx70k=;
        b=Wd26W2riDHjXKZhtVVDjaHoRTCo3KoqecNJUxQy7SdCiyicfZtJoeym4YslYZT5z8v
         58FAKGSTKivZqRWpfOAzDJ4Pr9XgSsidHnKMLgqKgyZvBC52+7FTVUkntYHFZ+f6bjuY
         l89inADrQtD0oHbROqE0XItxwIjwx5CpmrjJGpVRGKB9buM78uT9I97VIelAf7DlT2lT
         IrzctmCvBIV/jHMH0bbeLC2q10Al44VCam3QbtG3HOlv/RZPBUVtPIS6wgTpwhZ1yJUg
         L+g4CPHP/OQwONR3R31FLXGfe0NaHXDBM42kCPs+TNNlXRODzovt82/ksNWfvBBhB3S4
         fLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSqieASavyS4hAmtN+rUBOJEe/7rLoXSKUZrznGx70k=;
        b=rzOF5uKvGA06LjQ3UQvyqfyrjUhEA23nrRirnwRsBZ5xQlNQQ0/GehoiMYCS1o8qZc
         Gk9Zm5yz0ABjTFHRT75ZCvCT+2D9jG92WbK/4WPv66qJcFGhVVrzMfTL9X18O+ip4NvY
         EwgBIdUvn+kPjZkZAKCYtB8k7QVhiSJ24Otts/ZY8x5f6AQlIZrMcs/DXbcNYT9bTTfd
         2LG4E2APo7j9hSB4Y8wmUo6Niqf4Jl1ejGnR/KL4cbPEzLbHlLaPUfBFbIuaLt61ILM4
         JXAPRIezmM07IIjK9PQJRrry1Cs0J8BTv32EbzIA/FwkmGjySwr+FySH0ECOYyyu1uGd
         3B+A==
X-Gm-Message-State: APjAAAWrnBKeBz0zegWnxdpOnTYkzUn8+EwWSw2rWnS3KAw5TxqjLRl2
        Ph4tMJI+BoxixWMaajwW3oCa+IC4GQeroy9F9NnUCA==
X-Google-Smtp-Source: APXvYqwea4hF3OfO89ZgAeSGr7Xa0nI6gfa9nK3JhRJFHcuT+oslVZoDfXzz+JPqCiNXWQ9lxrEmy511Wc3ZPMRiQug=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr11500943vsc.200.1560771359908;
 Mon, 17 Jun 2019 04:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190614082954.39648-1-yinbo.zhu@nxp.com> <20190614082954.39648-2-yinbo.zhu@nxp.com>
In-Reply-To: <20190614082954.39648-2-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:23 +0200
Message-ID: <CAPDyKFrS94QhxT4mrF_=uSaMTLcJL6wZBj7N12Gq+o772oN4Ug@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1028a
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Jun 2019 at 10:28, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yangbo Lu <yangbo.lu@nxp.com>
>
> LS1028A used 1/2 periperhal clock as one reference clock.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index c56c7d413a09..4dd43b1adf2c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1048,11 +1048,12 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>                 /*
>                  * esdhc->peripheral_clock would be assigned with a value
>                  * which is eSDHC base clock when use periperal clock.
> -                * For ls1046a, the clock value got by common clk API is
> -                * peripheral clock while the eSDHC base clock is 1/2
> -                * peripheral clock.
> +                * For some platforms, the clock value got by common clk
> +                * API is peripheral clock while the eSDHC base clock is
> +                * 1/2 peripheral clock.
>                  */
> -               if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
> +               if (of_device_is_compatible(np, "fsl,ls1046a-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,ls1028a-esdhc"))
>                         esdhc->peripheral_clock = clk_get_rate(clk) / 2;
>                 else
>                         esdhc->peripheral_clock = clk_get_rate(clk);
> --
> 2.17.1
>
