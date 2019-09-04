Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70100A7BBA
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfIDGc5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 02:32:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36053 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfIDGc4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 02:32:56 -0400
Received: by mail-ua1-f66.google.com with SMTP id n6so2957931uaq.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pX/GIsxIbo847f+9FXL/2KTOJZD24+9rFmb5WYj6XnM=;
        b=ehRWcBqW/GnnrlLMZcxZ1viX7IZQO1jEB4mYsM9rvT1aBiuak1bsc24ghhQdY1flE3
         vPA2jiJUTn1TxryfeBlRjQ3Zwbs1C3Dunqzz4HZkyEiMl97AvEVyCVEaWjU6YE7yaZKk
         QFgRRsxbYODVVkXzkzv884LEQiuC6CBl0EzykoH6XDI3YiF6P/FItLJb/RwWZ3WBjEm+
         xgLWF+y9fqqIfJu3KwOf92/Px/4TcUs8f/18B1U+7F+oX/+glyXDhD/ZyW6QeKN+5uAF
         8okc6Lt6HMfjAbzd6/HPu9e0mzp/NiTRYkXmdgRsh9M2sq8qaAnaSsbXJHXkYvE0oeO/
         u+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pX/GIsxIbo847f+9FXL/2KTOJZD24+9rFmb5WYj6XnM=;
        b=N32Z9aUMZaKsQwqSdXxWaWCzOI/eI8xJW18uHYZYlJkBeQGxbV/YK58aA+ttDKYcEA
         wmOtYlP9/gJ+o1cxwGKJ9T4p++Dlcg5cJJt/VJlS+a6qxJa+978OyZGRSWnp2fujLDI3
         VpFbp7ocuZJSh6F9cajaCSKew0rPOSqvruasgCTYVpPWHUShO6aeAEebxvOielPXCxRY
         V9Xk1oHWmAHM9CikDkakyc1IqdPE6+YJqpdE8GJ65xx3Ozjt/y7Uc2yWJzSWHkkHDnFu
         1JlyaE1dT8jcOpGfY3GA+XLNcK6dkowIecb/RfF+JYOt7SCHl/22/tQDO/IzdMdz/014
         d3sQ==
X-Gm-Message-State: APjAAAVs9YqXVpObiLFmir+l/i3VZxcV7eNvVx/313sOmsn7CW0W/Hrc
        1iyEjYHuKzxerWY+OBzJTs+JETO2oVutf1FhaxQdXXce
X-Google-Smtp-Source: APXvYqxLkO4gsK7ntkEBpo/NFXtCvWaI2cOa5+E0oSaexWzXKH/CEQPs/hLtZQ5zTm1z1/mU8QRSrIfhVXyy42mFJDY=
X-Received: by 2002:ab0:6601:: with SMTP id r1mr5047079uam.100.1567578775596;
 Tue, 03 Sep 2019 23:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190904022120.4174-1-andrew@aj.id.au>
In-Reply-To: <20190904022120.4174-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 08:32:18 +0200
Message-ID: <CAPDyKFqj84wm4hHTv4xWMOXpBBi5mkBB8BXJgNFb7-c_YtzpCg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-aspeed: Depend on CONFIG_OF_ADDRESS
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 04:20, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Resolves the following build error reported by the 0-day bot:
>
>     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
>
> SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Depend on
> CONFIG_OF_ADDRESS to ensure the driver is only built for supported
> configurations.
>
> Fixes: 2d28dbe042f4 ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2 was a series of 4 patches, three of which were applied leaving this build
> fix to be reworked. The v2 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1156457/
>
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0f8a230de2f3..3a52f5703286 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -157,7 +157,7 @@ config MMC_SDHCI_OF_ARASAN
>  config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on OF
> +       depends on OF && OF_ADDRESS
>         help
>           This selects the ASPEED Secure Digital Host Controller Interface.
>
> --
> 2.20.1
>
