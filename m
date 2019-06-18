Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C649F65
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfFRLlX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 07:41:23 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34083 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfFRLlX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 07:41:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id c4so5598043uad.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQoQXU36/dw2ELM3Q6zDyetx272SKVny+29nLzscHfI=;
        b=fo+3Je70K5KaadBZSBfgPBjco8zkz6lNCCXu0v8MYisdAiYne9FCCx+1hyH/63ZAjx
         Px2bIH9dUgyX+wduVZaFmqhqWT830epz23vSHr6/FrC+sz7yfscC9Is7QXIoVtXYX7Qi
         nSnjjInjPpmmM5ugWm2Akp7gSnaG4E4lK6i2yrVmHI8hOgTJgzj56pj9jPis3ZI3jFXY
         cL28CW7ah3Da+WvSvEbUrZg5eTEpomAYxrXlsgT/y7kR/NIKAuSsq6WDZsybp/YGwnTF
         Yijrq+smWwBHd/CEUtJMeME/5dTkN1KdYZ4cq1hO2+XWAUL1PwzhrwJRcmRurS3rG4hN
         xpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQoQXU36/dw2ELM3Q6zDyetx272SKVny+29nLzscHfI=;
        b=OkqhOa528SkumGCvPUH4UEeMlw3qLce1BmmoFKZv98ilU0l8xRZICjGOUrPDG6k8EP
         9mTtRIBPUEqorCOF6toBwy+ShTeJ1erE89r/cJTPRvb1KKsALiA37754WclO5l7sM9pB
         /EVUVDcibhaIssPzGuJTbMlJyI8Qi3wSw4jBEmgzVwhUV3d+SOZCyY2hDtAFLvvasnx6
         GxFKMFUEBYtoOZZOSe7HeWLYPicg9uJD1Xp/GlHlUIkC7nL0Zm8HLOaljjGbkL5IVFNM
         9SM9oOCuZT2vW0iDOx/LGm/kz8yTNAWc2AHDDCywxEi/o+VHWsUEnHJ0VI5Tj962Uox6
         IrWA==
X-Gm-Message-State: APjAAAUV/oXlccwXJa6vg8pP2T7BMtoUm+vMICbXqZI5MFUZ2nsMJ1Ps
        ujwFUo3rb/5niyOQ/hhNDv3b+O5ynDJKVkEc/cTGow==
X-Google-Smtp-Source: APXvYqzdHEQdTiTLv3Glm+LbKbv3D3N4+YwdHnM3jpqtUai2CvBDqzladjw7HId0sYMpKBpd18UbKVX7h7FGVFIoEMQ=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr14804703vsc.200.1560858082474;
 Tue, 18 Jun 2019 04:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190617201014.84503-1-rrangel@chromium.org>
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jun 2019 13:40:45 +0200
Message-ID: <CAPDyKFom1q33iOmxHp1pbzcDuE3FxYAoBXWupAe97RwUx0BBXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The O2Micro controller only supports tuning at 4-bits. So the host driver
> needs to change the bus width while tuning and then set it back when done.
>
> There was a bug in the original implementation in that mmc->ios.bus_width
> also wasn't updated. Thus setting the incorrect blocksize in
> sdhci_send_tuning which results in a tuning failure.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b29bf4e7dcb48..dd21315922c87 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>                 current_bus_width = mmc->ios.bus_width;
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
>                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
>         }
>
> @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         sdhci_end_tuning(host);
>
> -       if (current_bus_width == MMC_BUS_WIDTH_8)
> +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>                 sdhci_set_bus_width(host, current_bus_width);
> +       }
>
>         host->flags &= ~SDHCI_HS400_TUNING;
>         return 0;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
