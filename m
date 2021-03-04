Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FFA32D447
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Mar 2021 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbhCDNjA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 4 Mar 2021 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbhCDNiy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 08:38:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E873C061761
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 05:38:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 18so34662764lff.6
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sy4nEQi288EJ0M7NsP9fNgE7Qbg6ZfSce++n7QC7VuE=;
        b=HDEyZwrEB46msqvh9yZL6EIpSxJmqDcC7gwO0qmA5ppFeUZZynGA6jUe7EyfCmsk8Q
         rcBnKK1vNt9y/wlSP7cHt9bjTpe55w38EsfRix7wkpzfpiWxwAsFdAyMlNpRS2Vvh6w3
         fawXFbtO/97KGmx+9feW42Ya5GUueAsIb/TRpTlmNJ5s6egRp9BtUOyo0gqFaq+xdPEV
         T1zZT8nF1Ni3+X79Dae5i7HiscmcOz6U3D2PZKXsvPFXricPI9lr/5a9b1eetyEuexsL
         QYuoLhT95aAs2djBuEz3/JU7g7CqeaarcznXmDsFvDWyfCEJvHFKCp3bOPwouJhVFNPf
         XRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sy4nEQi288EJ0M7NsP9fNgE7Qbg6ZfSce++n7QC7VuE=;
        b=Cn9VwqAm+t5sG1xvxNXWxWu3rs0F+6+i7OfEK+0u1kIh7yXk8V0FFaf6CZvJRqmJCM
         3jscaycOeku5BTKBGSNYgRVhrh0rbGtwpzl6P2akEtrz9sm+iiNLouMMKbGFYUA0peV3
         boOiLiS+fzBJIsLUzGh2mvKjdOXRYH0mE9cOrTZf1bPgYZ72xOdaB+qet9PITba+Vwig
         /ynGq65b8neCcsbOAXifW181TkmpKN837BxjPDjZAEwM5p/G7kW+c4VmkpZYDABnm+QC
         z6Qvdbbqm/5noaXIKQvsbhqqd9loWLR29JTowv1XFplQqDbKkkEzknDQLvo1HxRyBlkx
         2dpA==
X-Gm-Message-State: AOAM532INGHDpnomZODFk/7hATjlZXvW1eb91IzDOSc/1MWAVDMIbbpp
        1cY3Sz5T1LWkJa7/q1Eord6e+vE03xCK9NyUknz4tw==
X-Google-Smtp-Source: ABdhPJzFb3M5KKDc0P6vzgQhF75tV/IB16cKzRo83AG6u77j3RQ1zLFiwZGnOCt2xN7WcZZR4msr6H1Iqkoxi26D0cs=
X-Received: by 2002:a19:548:: with SMTP id 69mr2287824lff.465.1614865092582;
 Thu, 04 Mar 2021 05:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com> <20210304091025.ny52qjm7wbfvmjgl@mobilestation>
In-Reply-To: <20210304091025.ny52qjm7wbfvmjgl@mobilestation>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 14:38:01 +0100
Message-ID: <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Brad Larson <brad@pensando.io>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 4, 2021 at 10:10 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Thu, Mar 04, 2021 at 09:29:33AM +0100, Linus Walleij wrote:

> > > + * pin:             3            2        |       1            0
> > > + * bit:         7------6------5------4----|---3------2------1------0
> > > + *             cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > > + *                        ssi1            |             ssi0
> > > + */
> > > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> > > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
> >
>
> > So 2 bits per GPIO line in one register? (Nice doc!)
>
> I suppose the first bit is the CS-pin-override flag. So when it's set
> the output is directly driven by the second bit, otherwise the
> corresponding DW APB SPI controller drives it. That's how the
> multiplexing is implemented here.

If these output lines are so tightly coupled to the SPI block
and will not be used for any other GPO (general purpose output)
I think it makes more sense to bundle the handling into the
DW SPI driver, and activate it based on the Elba compatible
string (if of_is_compatible(...)).

I am a bit cautious because it has happened in the past that
people repurpose CS lines who were originally for SPI CS
to all kind of other purposes, such as a power-on LED and
in that case it needs to be a separate GPIO driver. So the
author needs to have a good idea about what is a realistic
use case here.

Yours,
Linus Walleij
