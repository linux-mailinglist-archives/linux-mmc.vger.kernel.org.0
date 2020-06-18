Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A881FF08A
	for <lists+linux-mmc@lfdr.de>; Thu, 18 Jun 2020 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFRLdg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 18 Jun 2020 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgFRLdc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2020 07:33:32 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192AC0613ED
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2020 04:33:31 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q10so1340214vka.4
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2020 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcyaUt9jsFKoDrB0iHqT52BIOcGZ2PhDMAyP/GQazFU=;
        b=dIy/fFM5111uF/2yacq3RUFi3A66/nmGqYGnv9q0gVfnFgF65iI4FoxjLo8vvCpShj
         MIClFCqbQvIYjZlmcmwtrWYt37ginZcMB0FuuxAOGocZBE5xBEQaSRqkWriM7z/3sFq8
         hNoD4qxlab0LYWvi9A9t0rO8CBUvr76jTTyoN5xnOFeg8Lwh75Ga2XSzjN9xAG8LGWLa
         QgBJPyzMbxO9ZVw7VD2NCErJLkqPG1faROjJshcT5EYpQt3E2lOkRocFR8JF53ZsqFbT
         3j9cWYJiQzg/qxSh+sXQgDUa4VEsXpafXr2cJ0lh1UwFUcjB+bBQI3qwzIHNcnuV3CUK
         qJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcyaUt9jsFKoDrB0iHqT52BIOcGZ2PhDMAyP/GQazFU=;
        b=DItLDMOPmZJOxW8QQFpKLqO423psgTT72K8fMCTEUyuSLhAZ79z9p1bvevTPt5jUZq
         yN7XyH+84NHPHFHVJesZ4r1kRN2LGCfgE9qjUNcfN62g2tSVChZWAtnNiPWpYqBMoOTU
         sk5MZMG34lm9FEvT6MsFa1L2WDm3tyP1VQ9S3iANZ3Oqq+eYqR0R0+XMsYCti2L24FU7
         EuDLeDMAYcTzOvuXblq5UbYnguu2J+w+l5R0TSZt+VQHYcwbkhnFPrPhTukcxdvNObhh
         WKR/HXsOoMaxpCgpUBSnhX0nhW2+mo7nlDpcE2UcWz2LjJ/IARrpACw9Trmfpp5ZzUre
         IK6g==
X-Gm-Message-State: AOAM531QeLaunq6iSrRmepBV0TjRfB+kGgmtDczrIIC2Nw9EVD1XLIJv
        vIusE0kzR/yyOB0mQoZtVPmO/c505cbHDg73hF2VHw38ib0=
X-Google-Smtp-Source: ABdhPJwHP4F41MKOPOId687NKciLjzCjDFQ33iXwCp0DAOdYUNLays2paZeOw0n8+eT5/dio4m3s6XBXf+J6iIKTrzE=
X-Received: by 2002:a1f:c103:: with SMTP id r3mr2738693vkf.25.1592480010666;
 Thu, 18 Jun 2020 04:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200618165207.512dc59f@xhacker.debian>
In-Reply-To: <20200618165207.512dc59f@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jun 2020 13:32:54 +0200
Message-ID: <CAPDyKFpGB2-hOJ=Y=1y9N1CnkPPpoArHM-1K+9Wk9C2uMuRwOg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: pwrseq: Fix syntax errors in device
 tree examples
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 at 10:52, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> A ";" is missing in the pwrseq dt examples, fix them.

Rather than fixing old docs, how about converting them to the yaml format?

Kind regards
Uffe

>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt   | 2 +-
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt | 2 +-
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> index 3d965d57e00b..c4fb06bf0bc2 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> @@ -22,4 +22,4 @@ Example:
>         sdhci0_pwrseq {
>                 compatible = "mmc-pwrseq-emmc";
>                 reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> -       }
> +       };
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> index 22e9340e4ba2..8204374546e1 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> @@ -13,4 +13,4 @@ Example:
>                 compatible = "mmc-pwrseq-sd8787";
>                 powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
>                 reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
> -       }
> +       };
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index 9029b45b8a22..bcbe8e947459 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -28,4 +28,4 @@ Example:
>                 reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
>                 clocks = <&clk_32768_ck>;
>                 clock-names = "ext_clock";
> -       }
> +       };
> --
> 2.27.0
>
