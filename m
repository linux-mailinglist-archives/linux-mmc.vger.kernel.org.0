Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73359E0BC
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfD2KpM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:45:12 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34803 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfD2KpM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:45:12 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so2201188ual.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGC6AGDjXIuIbU4z7HkoYZrn/cwawo87a4SSH9Abb78=;
        b=xLOrCcJzj91A+NOHvQa7ghsv8g2L0dEGj4h9o2jX8IjPIxEngGA5S4p/Yr0U5PU9wj
         D6NxOfHhNFGJRTSo2agXvVoazO7a7xW40y3wtx/TBG6tOSluz8MbziHNvDRsZJfNW3K2
         hOnk3TLIt50BW44jlTkwezvvHBQsTTB1p0uKwlY+K/fZGenGawemBM7kU0AUudA3RdSZ
         h58zRKKdJL7WfnrnPwE1NQ9Bxhaz9pziWuBMLUt49TOFwpCuy8CHcSzaKVOQ3+M+2oz9
         SazUc2YdvFA64I8pPQRKRHF8eEf/YduuYr+wk5lIpFXhE4rOpFRuURIDu8AkEWySOcl/
         +9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGC6AGDjXIuIbU4z7HkoYZrn/cwawo87a4SSH9Abb78=;
        b=j+RxBSIR2GH6Y7ZA8IF2Iau+QjB20FQTYTXDah5lcZTU6hF0NZXXLggx2OgTppbpu/
         fVeo5uqBdANXV2/Y8Y+43Zk7yMOGuRRMVfluKe2cJoK/XJEtZe5PWrpFV61yyl1Maznb
         MJqmNG+SIxo/jHwm6MHPaNuRnEht3tf4IL1MQk4DLjn4K5iNoGs6pzv5DbT/9bbUVIsT
         OstxX4aLVp+RQOpLhjHz/y0ehxVVoCXG4MCKpfpqPFBoUH9dlZwzKcMRbAwwjOpM5EgK
         UXQttGBiYBZUXYAqaRD8gCaAVUbrqBnnH+IjMkunZtw6tWoNrvVxomISqCpeTQJumyBL
         Qa4w==
X-Gm-Message-State: APjAAAUJqHM/n9Z3yvsxZqJofUFiTUa1h8X22W68YIpGIyDOL+1vGWUR
        0z7zQJsdCGydMK/ZqaADu9jBOWavPyK7O2Jpvw/WoA==
X-Google-Smtp-Source: APXvYqzj7uB8StJJ3VuLJOvrvSF20zuJ2jBN0x3Qk7rpkBT0HH+gff/aM3QC6wsIcGYVMs2OeTC9eaooaRlLytpRTAA=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr31014225uan.129.1556534711091;
 Mon, 29 Apr 2019 03:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <1554807906-9704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1554807906-9704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:35 +0200
Message-ID: <CAPDyKFpKw84x6+gTrQoAavkF4uVURxsTZ6zK1S9r08+HF_HNkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: retry CMD1 in mmc_send_op_cond() even if
 the ocr = 0
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Apr 2019 at 13:09, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> According to eMMC specification v5.1 section 6.4.3, we should issue
> CMD1 repeatedly in the idle state until the eMMC is ready even if
> the mmc_attach_mmc() calls this function with ocr = 0. Otherwise
> some eMMC devices seems to enter the inactive mode after
> mmc_init_card() issued CMD0 when the eMMC device is busy.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied for next, thanks!

Let's get some test coverage of this before we decide if this a
material for stable.

Kind regards
Uffe


> ---
>  Changes from v1 (https://patchwork.kernel.org/patch/10874619/):
>  - Revise the comment on the source code.
>
>  We can reproduce this issue if:
>   - we add no-sd and no-sdio property into sdhi2 node of salvator-common.dtsi,
>   - the renesas_sdhi driver is kernel module,
>   - Using a Salvator-XS board that has Samsung eMMC device,
>   - enter suspend and exit it,
>   - and then insmod renesas_sdhi_{core,internal_dmac}.ko.
>
>  After that, the following error happened and any partitions are not detected.
>   mmc1: error -110 whilst initialising MMC card
>
>  I tested this patch on:
>   - M3-N Salvator-XS with a Samsung eMMC device,
>   - M3-W Salvator-X with SiliconMotion eMMC device,
>   - and M3-W Starter Kit with Micron eMMC device.
>
>  drivers/mmc/core/mmc_ops.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index c5208fb..a533cab 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -184,11 +184,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>                 if (err)
>                         break;
>
> -               /* if we're just probing, do a single pass */
> -               if (ocr == 0)
> -                       break;
> -
> -               /* otherwise wait until reset completes */
> +               /* wait until reset completes */
>                 if (mmc_host_is_spi(host)) {
>                         if (!(cmd.resp[0] & R1_SPI_IDLE))
>                                 break;
> @@ -200,6 +196,16 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>                 err = -ETIMEDOUT;
>
>                 mmc_delay(10);
> +
> +               /*
> +                * According to eMMC specification v5.1 section 6.4.3, we
> +                * should issue CMD1 repeatedly in the idle state until
> +                * the eMMC is ready. Otherwise some eMMC devices seem to enter
> +                * the inactive mode after mmc_init_card() issued CMD0 when
> +                * the eMMC device is busy.
> +                */
> +               if (!ocr && !mmc_host_is_spi(host))
> +                       cmd.arg = cmd.resp[0] | BIT(30);
>         }
>
>         if (rocr && !mmc_host_is_spi(host))
> --
> 2.7.4
>
