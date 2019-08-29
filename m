Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80A9A1B89
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2Nei (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 09:34:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46941 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfH2Nei (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 09:34:38 -0400
Received: by mail-ua1-f65.google.com with SMTP id y19so1133481ual.13
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myzI27sykV+zo5/dyKkwt+i0fBKy0tEQwbx8qgbiivk=;
        b=N7M4UQV8t0QuilwfFtdruFEzIG5shKxRkBaHaMgXjqwqA4fu/fILvPFr4feiK0lX1k
         9ultv4ASPWMuzxE5OtXqSTXeVfSIUrpvvhKeQAurtn8rLZi8jQYqRO5rgTPqjkPpp5o4
         ky1MBd6owGPYLDpDWvHnuDm1aSv6ArVxTHJyW/3znmEqusHW4zS1tlmZ8ZxlZXUty1Rf
         RfN+9eyc9I8qB26y84LtImsalRxNi3jEUy0JTY0ZY8sqiWRxcSs/921OaA7/F8jZIeEE
         C7ra4idz39kX1gREZqxWqE8iNQOxmcPiSFf3slsN3K4yE7BrLTbmGYDwtzItVpxtv+MZ
         SB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myzI27sykV+zo5/dyKkwt+i0fBKy0tEQwbx8qgbiivk=;
        b=HBfcxTzuwIiuZwsD1YLcWGxaQtJ8amiurevDbe/MEFnsJ1A6iqK7gAklEoWBEPg2DN
         Jl5xIMOTB++fki9iWZ3+wR65MgEs/4cwLEDNUDQ6MGGLDnvKNLoP2iV7zMRcUdsei8jd
         qxD//Va8xvE6HQdGY7vAqos6hco7ZYnswxC52juVrDxTm5XMkA+oTLY3Zs+elINJG4Eo
         kwhLjn50XnnRXTLmid7GQecaNiLsxqrYRyBYfTNMUddV82BTBM0R8zUApp8KqpUwUZlY
         4UxtKxeru1M4g/mseL4+3zy15GcqMIW6Db26YSMFwggplkgUD22lIjihsT7ZFo6uz5/B
         JZ7A==
X-Gm-Message-State: APjAAAVcxCFSD3UgGNxAQwxI1Pp/LSnCCirlt+NKytCBcVVtPgC0hfbP
        sJDOE5gNhq2MU2lHL2z37BRFv9ZyU6F+XDIjrC6fYw==
X-Google-Smtp-Source: APXvYqzSozKBOdyF5FSAQOenVWGBNZ/ynRjEmx/hVZHhTe53zn4LHdPDSnVRlhjp+YZ0oclxFR0tqhuQs/rgNRdoPoE=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr4819436uae.15.1567085677038;
 Thu, 29 Aug 2019 06:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190829104928.27404-1-yamada.masahiro@socionext.com> <20190829104928.27404-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190829104928.27404-2-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:34:00 +0200
Message-ID: <CAPDyKFo9B6pDTcyoK-APicu+WcroCrjA7niHzd3DZH-7qkoZ_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: constify references of parameters to __sdhci_read_caps()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> __sdhci_read_caps() does not modify *ver, *caps, or *caps1.
>
> Probably, the caller of this function will want to constifythe
> parameters passed in.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..08cc0792c174 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3565,7 +3565,8 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
>         return ret;
>  }
>
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +                      const u32 *caps, const u32 *caps1)
>  {
>         u16 v;
>         u64 dt_caps_mask = 0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 902f855efe8f..81e23784475a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -738,8 +738,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  }
>
>  void sdhci_card_detect(struct sdhci_host *host);
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
> -                      u32 *caps1);
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +                      const u32 *caps, const u32 *caps1);
>  int sdhci_setup_host(struct sdhci_host *host);
>  void sdhci_cleanup_host(struct sdhci_host *host);
>  int __sdhci_add_host(struct sdhci_host *host);
> --
> 2.17.1
>
