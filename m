Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8E7312A
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfGXOJR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 10:09:17 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41067 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfGXOJQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 10:09:16 -0400
Received: by mail-ua1-f67.google.com with SMTP id 34so18503129uar.8
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdowrW6eyNVzCqnH+sg3YSjrdgr1LJmVf+XLhM5jeyg=;
        b=pwEwK7MPcChPu9C2pgvwXHbNp4lYkdiz64ftQlzrwykiOBpvbyyikwX0ULt30tK0pk
         cO9CV5Fd0M3pj1ubA8+2aQc0+X9d5H0EWedskNUZAb8wxxM3YuZtCvalUTwesVaQAtWJ
         3IlDQXCcBxDARDS7oPGjqX8Yyc6hQ/gmukMIh2FXdt2wnOCDhZYiXNmF6Hzv0s0UBjB1
         jgglhUJ5t5UWaEfhHbG1hkFtPiaQjRYPttLecdm9UNAkrEZzib1JS4EsHjnAV4AH2OTU
         jkbxbYVJ1RtcfuVKg3papWe5ahI+0bRsF7r9ostG+lOGen5hzJ11B7dX5Ue27sHZBUEl
         1a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdowrW6eyNVzCqnH+sg3YSjrdgr1LJmVf+XLhM5jeyg=;
        b=YkUX/p9IKBCNlRVcWdG1cMvzxpMiXQagk1Ishj/xa+WHLvvq80oHI9h6QRiafQHYxi
         0eQSDULuYNPDzk1NygBVP2rx4OXq/mF/mwALsnWrnFJ9fGYQOIUBQ4J5hIrUEUJk8OTO
         4d+mORo6lgZI5CSDmPht7u6zUY68bAy32GuK33JWwrWmVcAPynWVLLwnBVUyxnHoPPIY
         fksax23R59dpEiPMdCxCqRu0iQaj8Zi1jc7I02XPMc6v5oRfzf301r1nkGixIPW72uuC
         rx6bSutyrmnaQP3wrvtOzKAPpmplIkbdi1CMC4KHZPCY/PNX+Xa0Spdl88vJVPiKQgTF
         BW6A==
X-Gm-Message-State: APjAAAWYPPno/YE+2k0rHW+IXq0dJCEhBTxtO74BGW6Fnh0Zv/Gx+uCG
        6Pp8ymDDTziwCBOMagAJsW+4BP/NrDZVGr9LW+1VRg==
X-Google-Smtp-Source: APXvYqwjP39LUP2n3wdv5p52VBWs/GbHFu/JeG/78KmrgvExwdDggNiwDfpKMMkZfKek8Eg0guVJMJcDtZtti1/q8U0=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr51915486uad.15.1563977355332;
 Wed, 24 Jul 2019 07:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 16:08:38 +0200
Message-ID: <CAPDyKFoJgiSQOYTiNHidr99tDe1QmuASfj0sJ=H7Ot1tb9mcBg@mail.gmail.com>
Subject: Re: [PATCH 10/18] mmc: sdhci-iproc: Add support for emmc2 of the BCM2711
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Jul 2019 at 08:24, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The additional emmc2 interface of the BCM2711 is an improved version
> of the old emmc controller, which is able to provide DDR50 mode on the
> Raspberry Pi 4. Except 32 bit only register access no other quirks are
> known yet.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 2feb4ef..2b9cdcd 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -261,8 +261,17 @@ static const struct sdhci_iproc_data bcm2835_data = {
>         .mmc_caps = 0x00000000,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> +       .ops = &sdhci_iproc_32only_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm2711_data = {
> +       .pdata = &sdhci_bcm2711_pltfm_data,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>         { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> +       { .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
>         { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>         { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
>         { }
> --
> 2.7.4
>
