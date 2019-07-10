Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59BE61E0B
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Jul 2019 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfGHL4d (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jul 2019 07:56:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43425 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfGHL4c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2019 07:56:32 -0400
Received: by mail-vs1-f68.google.com with SMTP id j26so8002741vsn.10
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2019 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ8W16JFocd/InfO/cTB4TM+C2DG5Zh65kAxr22aAgw=;
        b=vydbS4JFbSJNqkIOFQ0D5/ZnJvmP882sgm8pA2xzk4cuTgDSOkGzTVrCU7NlK1CHgj
         SeVTb2hAwwAVEHoWdfMjszU5gR1i2vAC2ytmDeRkD2DQKevdCkwkhTxdJ9DAuA4OOLXc
         L+DiEDMXIDsVRF69tivAPriiX+mLRJJP/F8BJW7Zrm3c7XAoM2S5mMdB3x103YBx6qjU
         ET0hAMjxwDXYy06Z1sfWreTdzOc+cLHtOD6sBYmBa32KhbFzUOvw5S8HtpwULzfxhAlz
         VBLQItAy3bYqRK1eGWBrim8oTn+dzLA2lyHEbtogg8vL9deO78/vilh9C+dvly2mEJGF
         H4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ8W16JFocd/InfO/cTB4TM+C2DG5Zh65kAxr22aAgw=;
        b=NOryiMN5ZoYFtkcyBCuzG8QvMtB3N2Of7kSTm8sIitCMwrEVXJhgf2UHgra+42WQqj
         Pw4aVT99TLhQ2QRmk+XZ+HvnaTI1hSavoiLIWUbaam9ePyrPrMq/w3WsYAKDtplsI2X+
         W6P/OSBOQw1ZluLf1VbJS24oIsCCt9jhN0Psb1P2sgomWPkLaaRJm3cUoAcrSYdq37zS
         AmFOzLVjtMEnnE/96WlYQHQjOxu9EZApDpabxvAXU3iAsT2/qnDKvuu9hZ8AFsvoIL04
         ZjiNKYKuYnXIllzSU1a4qDKCZ007fhiqhufI2NyDX3XL/9SSEdzaJwYuCPLJYs9VKJRH
         7kvA==
X-Gm-Message-State: APjAAAVYC4RQB9MKhq6Bwy2j6nADyN/8dUkxqR83Ax685aL/KKbE/ZYC
        LFGtz2JvOurZ64XmKGADUSOYiLlOGxo8DrPYVkjCCw==
X-Google-Smtp-Source: APXvYqzidSJWbMyu5YA4UU0sFo+5kRhKxrroJqRjJoabzcjT+jV61fswOw7eZKxNfepxVIMJc+BMC7osp4ifP26Gdx4=
X-Received: by 2002:a67:8709:: with SMTP id j9mr10023670vsd.35.1562586991328;
 Mon, 08 Jul 2019 04:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
In-Reply-To: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:55 +0200
Message-ID: <CAPDyKFrcB3Pqe+yiz4T5mL5wQ-2bATyO3aE+hy4T2Ueeu22g1Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: fix mutex while in spinlock
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        vinod.koul@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 1 Jul 2019 at 17:01, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> mutexes can sleep and therefore should not be taken while holding a
> spinlock. move clk_get_rate (can sleep) outside the spinlock protected
> region.
>
> Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5fc76a1993d0..9cf14b359c14 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         int wait_cnt = 50;
> -       unsigned long flags;
> +       unsigned long flags, xo_clk = 0;
>         u32 config;
>         const struct sdhci_msm_offset *msm_offset =
>                                         msm_host->offset;
>
> +       if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
> +               xo_clk = clk_get_rate(msm_host->xo_clk);
> +
>         spin_lock_irqsave(&host->lock, flags);
>
>         /*
> @@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>                 config &= CORE_FLL_CYCLE_CNT;
>                 if (config)
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>                 else
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>
>                 config = readl_relaxed(host->ioaddr +
>                                 msm_offset->core_dll_config_2);
> --
> 2.21.0
>
