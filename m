Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4F73126
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbfGXOJM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 10:09:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35963 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfGXOJL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 10:09:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so31402636vsc.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu225xqfPN2/rLvfSwAsEyzbhQbRUYBKagHgr6BRdsY=;
        b=QyZ2HwJpThM1hA/UrkoCrMIzIG1qKdbxY22knQQ6jxvlptPvYfpn/ryUOMMQn8eIhA
         AC3LnHEkrVN5bI1nJ0thtUrgSKSGzTVwtdDypWV/ILV8M+LY27M+POFs7fT1Y1FAux6y
         n5e83tSvhWJURpzxfWwdhmaiSaLuirPtbrz66wDsPj/I6IsUhr4h/Y7oxSjQJ2ZSdOTa
         8E3tmXjCaipnHIW/zQf/E0FmjEYsP2Zc4TyCHaczJpoZtU4g4m0Llb3u+TSyJ2v43wBF
         95VsWEolqVKTuSeVcf0xALB10xPazd6MCw22nAWZ01zUiGzuaSu+1dC4iDVTv21g6aft
         lPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu225xqfPN2/rLvfSwAsEyzbhQbRUYBKagHgr6BRdsY=;
        b=D2ETC3VQt/P/bRhywJjdlwfSZJG4J65IOLoaA+lMWjIV6Sb2NADnnzRIhg1Fwlp21p
         Ri/4+e26Kq9+4gaG0BOkMCTNNLYCpFTBdan4RxiAgD1PJPSlnsH45baKpRAWWrtbWMPi
         3Qzfqh9h9qWrfC4VAvREn4+n3iVeXeh0hAF5dM/bEpibXTC5So+5M4B9PXlJYTCz9TAO
         hLTTYaRX+C4950K2HBQ1XOKFsr4k+MADygFZr1Qj7mzL3O91iW/72tVlXehITYHJZsRf
         TJfNz7FQLtGP+/juUZVB+1r36R1KDTdbfQjZe9iQlhmeqLhrQwsVQ+HBHA54m6ztSFej
         aVOQ==
X-Gm-Message-State: APjAAAVD+HhKjCMelo+sLAcyDoZ9ndi9mW/X6oPhXc1tc0M/OJYcF4g/
        Xi9PjBXjo8ZgCG9h/i8RrUS0LQFCT90d9LGvpmZ7jA==
X-Google-Smtp-Source: APXvYqxssmW5IGjzFz7Uo+wZjJeNnk8rwQp/G0i5AYPNWrc/17j2TjRxyzFkW1UAR4ii57bMU5HGHANrJsgPGutsiDg=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr51771554vsp.191.1563977350961;
 Wed, 24 Jul 2019 07:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net> <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 16:08:34 +0200
Message-ID: <CAPDyKFqrbwJ9G0Za+U2FCBB=GKpMZdXesQAHZ+8v8T0fCusmiQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] dt-bindings: sdhci-iproc: Add brcm,bcm2711-emmc2
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

On Mon, 22 Jul 2019 at 07:56, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Add a new compatible for the additional emmc2 controller
> on BCM2711 and clearify usage.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> index fa90d25..09d87cc 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> @@ -6,10 +6,12 @@ by mmc.txt and the properties that represent the IPROC SDHCI controller.
>  Required properties:
>  - compatible : Should be one of the following
>                "brcm,bcm2835-sdhci"
> +              "brcm,bcm2711-emmc2"
>                "brcm,sdhci-iproc-cygnus"
>                "brcm,sdhci-iproc"
>
> -Use brcm2835-sdhci for Rasperry PI.
> +Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
> +bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
>
>  Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
>  restricted to 32bit host accesses to SDHCI registers.
> --
> 2.7.4
>
