Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A53DC05E
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfJRIxT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 04:53:19 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37235 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfJRIxT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 04:53:19 -0400
Received: by mail-vs1-f66.google.com with SMTP id p13so3529207vsr.4
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFGj7CW4hdUtWSJdWVNaVmZMeTl6mFJ/pi0dDaNSBNI=;
        b=Mue1fKqhFIuquMu+rQdYue5Ab10+aIYtB6Q9/0NGn6yqBrOgXLgFxSg9NHgyKSbFSE
         P/wYniqUzElGGRUAv73GH8vxgzAqIkRFcXnKtK9ERXdptaI+2SGSIs/jXswG4speKbto
         lvoSDiJeqxjuzOzIefrZ/deo7u6TdlJP7VTwxZFuteA/G4mV3V/aqdXyku3K8eU9Xoif
         xAyZGXgX2NNhi62LjQKANeErNlNX/Za8ktqBzNRyqHutbskgjId182FjA9IqnNqFz+zm
         ZXV01E9q9XPvlg0rZAq3Q2UEHuoAvj3+8z07VtkHMPYeXNncwhRl6aFysiNItkIHFYs1
         L2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFGj7CW4hdUtWSJdWVNaVmZMeTl6mFJ/pi0dDaNSBNI=;
        b=lgpuojF87vWIKcuDCxhXfCJQQ35LrWisrPxSxvfeV6QpGjhSYxr5rrmY/BygkaPmxi
         hlqdixouTvT52LWPVen2vnq6WrKQokrJ2IYkg7kneaHbZgIYMVFJDtXTVEFwsuX6cWI2
         934fJ3OH0t7LZmJYd8dP+8Ii/PmSiWj1pzBfsL0BmXlJSL4c6AF6xqdFfDEe53j9UElB
         0qYF3WUFaoiAEJ065YOmtiZbKi0fmP8trHiDyhIp6eNnLBqLXXvgF+Xnsf+Uj4kzOq/D
         guUacEQofgPXqSPYdKeHhgRTpxC07+cbNr0CVvarJDUw2IOYfYO2mlDmc16iBVe2EdFc
         L8MQ==
X-Gm-Message-State: APjAAAVjgeiTJs1P2WQo4AMOxi0wLAV76b1iTq/xjtBBftsfSKRWiFzY
        wOTInfVscz33wReqs5ZHJY8zRCqgNLO+TrbN+3wdsw==
X-Google-Smtp-Source: APXvYqxx1CtlN+u0DoDjVeLLVdh/4lNPYBI0SFJLfPUK/RX16/kP5dPKuMLW2YkmIBl0ktGJ57HLSuHmNeIqxg0/6RQ=
X-Received: by 2002:a67:ebc2:: with SMTP id y2mr4733668vso.191.1571388797894;
 Fri, 18 Oct 2019 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com> <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 10:52:41 +0200
Message-ID: <CAPDyKFo9juNmf6hrcBjzOprS6GwzAPBq8y3ReGu=ry+MdxT9Bg@mail.gmail.com>
Subject: Re: [PATCH 6/6 v2] MMC: JZ4740: Add support for LPM.
To:     Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, syq@debian.org,
        Linus Walleij <linus.walleij@linaro.org>, armijn@tjaldur.nl,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 12 Oct 2019 at 07:19, Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>
> add support for low power mode of Ingenic's MMC/SD Controller.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

I couldn't find a proper coverletter for the series, please provide
that next time as it really helps review. Additionally, it seems like
you forgot to change the prefix of the patches to "mmc: jz4740" (or at
least you chosed upper case letters), but I will take care of that
this time. So, I have applied the series for next, thanks!

I also have a general question. Should we perhaps rename the driver
from jz4740_mmc.c to ingenic.c (and the file for the DT bindings, the
Kconfig, etc), as that seems like a more appropriate name? No?

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 44a04fe..4cbe7fb 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -43,6 +43,7 @@
>  #define JZ_REG_MMC_RESP_FIFO   0x34
>  #define JZ_REG_MMC_RXFIFO      0x38
>  #define JZ_REG_MMC_TXFIFO      0x3C
> +#define JZ_REG_MMC_LPM         0x40
>  #define JZ_REG_MMC_DMAC                0x44
>
>  #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
> @@ -102,6 +103,12 @@
>  #define JZ_MMC_DMAC_DMA_SEL BIT(1)
>  #define JZ_MMC_DMAC_DMA_EN BIT(0)
>
> +#define        JZ_MMC_LPM_DRV_RISING BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_1NS_DLY BIT(30)
> +#define        JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY BIT(29)
> +#define        JZ_MMC_LPM_LOW_POWER_MODE_EN BIT(0)
> +
>  #define JZ_MMC_CLK_RATE 24000000
>
>  enum jz4740_mmc_version {
> @@ -860,6 +867,22 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
>         }
>
>         writew(div, host->base + JZ_REG_MMC_CLKRT);
> +
> +       if (real_rate > 25000000) {
> +               if (host->version >= JZ_MMC_X1000) {
> +                       writel(JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY |
> +                                  JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4760) {
> +                       writel(JZ_MMC_LPM_DRV_RISING |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4725B)
> +                       writel(JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +       }
> +
>         return real_rate;
>  }
>
> --
> 2.7.4
>
>
