Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA9EC9B7E
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfJCKBw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:01:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33191 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfJCKBv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:01:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id p13so1306903vso.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFDz/TY4taQUzdivp2uhhp2+MARTcyK0IBv0Du5TK2s=;
        b=uqSNDSn/JLAR34x+guZaYMpDq4TElfRKkHGCYKGhNePvM0SnjNGMa0VMl3jN5QVYiG
         9jBgksE/27bDxJT4b2GwYGScLnvpABKCkG0LA8BnhcZQrmp2zxh1NK+YNsaJPAqEJciG
         EgL0NO+1ZxIfxRolhUe56b7kgITFMDj1m/vR1s/eZ0SuULuxbGfcsmS6w64d+82HG0u4
         DZYb+5l1/F2TPlNEHkh+/L/4xfmH+hyJlTg1VN0ZrjF1QjSuDrMgHKS1ONcEKpeg5sj2
         TMZe2UhcneGYB3l18O6f0CaqrDSqMto9TF165WOe1WiWm396BpL42ilN+hjX+pLLwwLq
         pRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFDz/TY4taQUzdivp2uhhp2+MARTcyK0IBv0Du5TK2s=;
        b=JB8T9S3vQ6UVV/aAeN7EOw+jTfXG6kU0YfioasnZ8y0z4mT5dAvh3C/O2qj3pYXUod
         tur2RA0Q2SK3v+zx/fgyZI6c/41+27Kg/v9Nd9ti/oHTSZBf0rUzmCTC7rvXlxB0iH75
         d0Oox/10eMHTDQKk/d+ZNxGIhe3orwVTfCPIGTk/LzYK+WQJjoN+pJ9UHvwzI4lI9opF
         qwJHDwKesU64iaKE76e/iIMBwzO43KRd/jS8DnpIwK8MJ4TfTLt9R6qlEYx0We2/NBrY
         r58nDCTA5HZ86S+3I9TJdSRa74Rc0UlTUo80pPCCNOFpIAfPO5+0Welu14gGRGrvyjgr
         7D4Q==
X-Gm-Message-State: APjAAAXwLwRQj8Y+Sm732L4+6LGBhYMKTpgthHIyF9jNLdq8ZsrDOzed
        DAutSGSMDohg06uN7LkLWtGhWfoayodoPXE7Gq5gGw==
X-Google-Smtp-Source: APXvYqxI8ZjwXNgQcX5BTsmzQOL7OxBf6LkFujm61Mkc0rVB1TJKuP0kN3cL0YPgP1kYeTX4gE6Y9Hc1+NZnaTuz2tE=
X-Received: by 2002:a67:784:: with SMTP id 126mr4664591vsh.35.1570096910669;
 Thu, 03 Oct 2019 03:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-7-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:14 +0200
Message-ID: <CAPDyKFoDhtXwzsEzh2tST96VQHqu2PKHq4F=Zs__mqA1=AVaTQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC
 driver and binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add MAINTAINERS entry for Actions Semi SD/MMC driver with its binding.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c31e6492b601..d13138330b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1375,6 +1375,7 @@ F:        drivers/clk/actions/
>  F:     drivers/clocksource/timer-owl*
>  F:     drivers/dma/owl-dma.c
>  F:     drivers/i2c/busses/i2c-owl.c
> +F:     drivers/mmc/host/owl-mmc.c
>  F:     drivers/pinctrl/actions/*
>  F:     drivers/soc/actions/
>  F:     include/dt-bindings/power/owl-*
> @@ -1383,6 +1384,7 @@ F:        Documentation/devicetree/bindings/arm/actions.yaml
>  F:     Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
>  F:     Documentation/devicetree/bindings/dma/owl-dma.txt
>  F:     Documentation/devicetree/bindings/i2c/i2c-owl.txt
> +F:     Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
>  F:     Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  F:     Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> --
> 2.17.1
>
