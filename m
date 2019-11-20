Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389F5103A89
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 13:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfKTM7c (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 07:59:32 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38404 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfKTM7c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Nov 2019 07:59:32 -0500
Received: by mail-ua1-f68.google.com with SMTP id u99so7742672uau.5
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2019 04:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuqJ0vbClL23gGoYcppi0FrFy7e9Hz/yNcjMSMNBxqE=;
        b=dYP/0q1UJs+hkupL0Ks33xZa/oPu9OOQ/1POhchabco+MYLW/OVqUGMujUfpI5uX/Z
         guc95gIHgm0ENwks6ezoHMtNBDv5NpD4kZOt3rckVtc2TNrFfHdbtpCHIzg2WdJrYaXH
         /xSfomvFi7E/T0tCpoUNe3K5d8eLKhwMpXTlLq8hD5ihVf1MmjEnX8Zrc+Q4dl9OF8vp
         voHqwV0OwDc47bzLAoCx81iHGZpBIJjGrkq9aPtBI615OOd+WVm9zHE2PC2D1k+vGxR4
         4PUF1/lLiew7UxLBcxzFkhUWuY57TX2Ka8I2YZ+NgeOlXACnlaJC6D7tFhA87pTU3x45
         HmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuqJ0vbClL23gGoYcppi0FrFy7e9Hz/yNcjMSMNBxqE=;
        b=CjQ0LIYIAlixNBnDUhVVSoc/r9Ka4iQurNb0Sk4Wi9uN3vlL+oq3tYTyLl/weDzeSC
         KNQMkD8iiH+J8z0W2O/9ucqKHqLFSFqIrTaGK7C90FX3nOs0Bto4Z6Xy8OZICJBduNPq
         Z0olELEZ1fi66Ur0LAmyqIq4WTxF0i9SYR9CiAucNCDDTUvRt6JFnF5Z87slTMbqbwPP
         iCkEXso8/Op1pSe7pxq91a4E73L2Prrq2m2CsGlLcKyzF5MLm5wcASD8ig43UrRDSPGe
         Pi47ad8RGDC4bfNYlx43Tq2WxFX1H7XZg22/c4kWDZ4k9YfR61pApKxBhYZv+nJWWU3X
         Gxrw==
X-Gm-Message-State: APjAAAWCbcW9er7hDt6r4jzN4q2Px0ynbQnPm6Xt3b9Bp/Ae12hI3Jos
        A1xw74PrvGncB/kOLGsmNMHC+yPYLrqd2EDcwyR3sQ==
X-Google-Smtp-Source: APXvYqzczwcqmzJh3GjUqnWFQGP/+Gp7RUJwV58YrFcSe+bfPCganPSc0GYA3NZbmUkPuarP338JjoXHT98NVoW0E1U=
X-Received: by 2002:ab0:2042:: with SMTP id g2mr1511287ual.19.1574254771069;
 Wed, 20 Nov 2019 04:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20191118104646.3838-1-i.mikhaylov@yadro.com> <20191118104646.3838-3-i.mikhaylov@yadro.com>
In-Reply-To: <20191118104646.3838-3-i.mikhaylov@yadro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:58:55 +0100
Message-ID: <CAPDyKFoz3ipYBGR-6ubfqhtQVG9h16axoHNdSoo+OyNgKRs2Tw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-aspeed: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. The read_l
> callback is used for inverted card detection.
>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied for next, updating the changelog according to Andrew's comments, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..c9c1bb722368 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -159,6 +159,7 @@ config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
>         depends on MMC_SDHCI_PLTFM
>         depends on OF && OF_ADDRESS
> +       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the ASPEED Secure Digital Host Controller Interface.
>
> --
> 2.20.1
>
