Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD953F42F7
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Aug 2021 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhHWBXe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Aug 2021 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhHWBXd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:23:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7722C061756
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:22:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w5so33482327ejq.2
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYDJcPk27eaOYzRvmn3VXjqVNS8Lwk0NBihSR+O45KM=;
        b=nZYLHHjr5VkmwGK7MDgQNkIuvR9b708LZrDPVpVfiOfCaOsZc67/GF0ZTFXAn1YfFR
         8QXLJ/bFLIE3ey2RE7gNjmdtcjSFVy1YeHyAfMIpxs8eI6tj7IZeS1Ax2rLB/DJ9u6eV
         cXCZIVmYemvhIbpyY4uzErf646Afut7PXBc6rC5QVTSjlDevFOwEAf3zp4uS95DzziGp
         7lvKI3WBx4lSQgMFaofLbL+q1oYtmxSS+9AI8V+XN9CCs6NYICElUYvZLqpAg7SsS4Mv
         tSaLsbwGa4Gb2+cGjFUH0D+Z7l4iIepsGKUNbUeJKsWhQDYnTpT7ltRBncOVF8fQQp43
         WN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYDJcPk27eaOYzRvmn3VXjqVNS8Lwk0NBihSR+O45KM=;
        b=L8aD6kC8Khd8kzlXnBqSsiRkWLxPAREdlG0tvKa7Imo1a+/qtlWa3wBCvDch0hCC9r
         tTAOjrwIDWt8Qlspkd0OdngYZ8/ElGjk9OkxtJmY/8GYGtOdO2FJPpIeQQmCS/rM8I6M
         v6BycAnyQ8TTkJG64VKAWWDX4lJzX6oFn4qbPIRgtaK1CkSFpAB1DwYPXXd0JpaEdqy9
         cv6saz06q0WKYJ+A2KQNfyfGpSlnoBUtazCOfF8I0k29y3iHcoIh2DsQpRxrACEjkO+T
         NL310/tzUJtt9m2znbWqt3hICUgqhoiajOGal+eJCxPW7GHh/0ztJ3n1++mv3F3dh+1C
         +fvA==
X-Gm-Message-State: AOAM533JAAPvOrnnbI8rvKSR1F2Qy5N4i87tIpQHQ6zxo7/Yjwm+xmj5
        PVSSqJWF3e+HLHRN3alm3/vne2eH4FWikFD4jk/Haw==
X-Google-Smtp-Source: ABdhPJw6n+mH08Xf6OE4yaoX37ooGQf1hGFMgsgeCuMYD5FoyBZzpgVOJVBPL9zW75eYcv5s/Is2jMQ3RdsUuC5Q3Gs=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr1428510ejb.174.1629681770527;
 Sun, 22 Aug 2021 18:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-2-brad@pensando.io>
 <CAHp75VczOyiD+F9MDqdZdZGhAFF5Kh5U7CAmTj+i-Fy7KZsEog@mail.gmail.com>
In-Reply-To: <CAHp75VczOyiD+F9MDqdZdZGhAFF5Kh5U7CAmTj+i-Fy7KZsEog@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:22:39 -0700
Message-ID: <CAK9rFnyu5ZutLGM+OFAANOfcrC5OSVjcaoy_rbq0m+WafDhqoA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpio: Add Elba SoC gpio driver for spi cs control
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Andy,

On Mon, Mar 29, 2021 at 3:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
[...]
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Pensando Elba SoC SPI chip-select driver");
>
> It's funny, you told it can't be a module and you add a dead code. Be
> somehow consistent, please.

Yes the code was not consistent with statement that the module cannot
being loadable in my reply.  I had not used builtin_platform_driver()
previously.  The updated patchset will be changed to this for the
driver.

-module_platform_driver(elba_spics_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Elba SPI chip-select driver");
+builtin_platform_driver(elba_spics_driver);

where drivers/gpio/Kconfig could be changed to this

--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -241,10 +241,8 @@ config GPIO_EIC_SPRD
          Say yes here to support Spreadtrum EIC device.

 config GPIO_ELBA_SPICS
-       bool "Pensando Elba SPI chip-select"
+       def_bool y
        depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
-       help
-         Say yes here to support the Pensando Elba SoC SPI chip-select driver

Regards,
Brad
