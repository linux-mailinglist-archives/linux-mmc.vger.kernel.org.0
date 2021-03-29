Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98334C0BB
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Mar 2021 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhC2AzJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 28 Mar 2021 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhC2Ay7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 20:54:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665BBC061762
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 17:54:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x21so12385139eds.4
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 17:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVAc9b+mBnGmiPe0hQUBS5bq7gPTXTsIqeLgC0QKuYo=;
        b=NoS1GIebv3iSWHAId4v66ODhmcXKQ/qQgeX+r/F705yNSzRoWkVkukYHE2U4SXzj7l
         3idkz2/42j4ZbHW78CX53X7tItXmV94qnWB5OdZOyQnbEsoGPsYkSWpOSMDnWm16M77n
         hxLk9rcJsK2WKGOofwpCR6fzZNHzRZZeic4Bas0Ki4nLhez/wE3QZpZS5gvML/zDm3gi
         g9leOVIkOl3WZlwloo/rXhtFJIOSID1WTvNwZfezLQYLQIB7EwNVLn3S61HwpAQcPDRX
         zaOUJcL6r/q364sBH0DBnzDGmlTYrO8r0TFMDJUmBAMxfPzwh2rVjOLSrojRZRucPjUH
         TVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVAc9b+mBnGmiPe0hQUBS5bq7gPTXTsIqeLgC0QKuYo=;
        b=sxiz2JKl1oMt1sSTteBegUpxnBn3ZEWuS1G2HQiATq3HcfHU1VbFFQyK/1Hop9Dahu
         A2U6fFTaLy4s9MxRXc4VGmYDO378lXP6oVOicMc8vWq3fv7j5rn5yLBaz38EYcYUP6kN
         OIAYuwmG4cJ2jBm/uyb3+Mav6I1Of+/23N9LAVOUJNGVjmaMrXbngLJpQijH/9fPzdbt
         R13h5Uyc4+fJaYZaKlicuCFQNflU5SWwLjjHrC8nEI0ws0ddQ95q1+Z3l9DIlAGPc3Fj
         7klmS6ktRVxe7Z86o/5ePiq681lT4nuHUd4LfCg4K1ovOMuGtgk4ayMFs0Mr0YHhRgr2
         5aaA==
X-Gm-Message-State: AOAM530n7CzwkbbOFvVI+7xBi6GBx1OQG/3YijxD5c+cbuihAG1hGjMh
        UEDM12px5JfJJzAum2M2SDpQfqx0S2inCAJAC4xv1A==
X-Google-Smtp-Source: ABdhPJx+4A/Txkzyq838knHsu1E43Gon6mva2bR+kHkuk+1ju7bFnu+zuJhSeTQ6qkrvnEusq0RO4FBMrBSodVEvcoE=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr26382778edu.268.1616979297849;
 Sun, 28 Mar 2021 17:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
 <CACRpkdZr8qrQ+b15z_zRP3wAntQeW7T0Z515sUv6e2gL9GzDyg@mail.gmail.com>
In-Reply-To: <CACRpkdZr8qrQ+b15z_zRP3wAntQeW7T0Z515sUv6e2gL9GzDyg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 28 Mar 2021 17:54:47 -0700
Message-ID: <CAK9rFnw6cM9UsNoD1-37JfM0n2h6fATSTZYqAP0DBhwwigqBzA@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
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

On Thu, Mar 4, 2021 at 12:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:
>
> > Add Pensando common and Elba SoC specific device nodes
> > and corresponding binding documentation.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> (...)
> >  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
>
> Please use YAML schema for this.

In patchset v2 changed to YAML schema and passed dt_binding_check and
dtbs_check.
