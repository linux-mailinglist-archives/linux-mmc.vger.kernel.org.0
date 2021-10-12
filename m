Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6EC42B09E
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Oct 2021 01:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhJLXyP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Oct 2021 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbhJLXyN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2021 19:54:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0017C06174E
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 16:52:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so2689505edj.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbR0fYQwEzzPnCNSZ2ICWQZko1+pYoFdiGN6U0UHQwc=;
        b=xGQWQl+Rhu5wc1pookDpIpkj5pCLuttrBc/yXvjFsnnJT7q4Pc+AqreFLXb9frSAtV
         g+m12d9PJuw5aFPIVGI1DH3Z/LxUFCP3JDOhQ/QMnVhKm8pCSzj7dSa9J5HfXtCpDLBn
         Oax0yqSgmK1iXRZgCqNT0gYq7qRSJkpv4RIiM2uqoNpUdNvIq1cnGVA6Jiu4U21TgAjM
         WG9OZYzMwG9I6pRNj+8+O4a1xZ5PczLu/bmxs0yciQhettLEZgYHloJ9EwZZ+Hq9w52W
         snn15hSloMgqG14PY/X5UtPVikd3uCCsHKQAT0RWNxa8rzpnTFc6kTGuJPdmbm+d+/8t
         pe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbR0fYQwEzzPnCNSZ2ICWQZko1+pYoFdiGN6U0UHQwc=;
        b=q5ezgmrHSlnaNcAepRttGNzKxb42eaik0boF476BHMJT4/uGj2jG/rehedRNVdIDuN
         IpaclojZzjVwR+bHIYH7eI2wwM/enVnUfxGrcffWRlZAyvKd+PQCwC/lJfcHnNWFqgcd
         2z2Bgm1f6SL2zTk8WjYAJPTwxi7mF6Oo6ELd8ldEgqjYSvJ40gVAlsybm3CDW8pGZkYq
         x3my3LmZDjqYQGsF7tpjQNOVfdA1ppNvz5qWWncF+VBBWr0dnBdEp091R5YMzjK53xUL
         HaQjdGmWUJbsNHUnBu/DliqX7aAlDsEXf5SNkpnlKyMdQ75p2yiTI5jkXjfCuxJbKsUZ
         vCgg==
X-Gm-Message-State: AOAM530tAOIyLQd/67GVW8XCR54/akWqVGN5KSMBTn7zAhsq2xYRTIiv
        MDm/uTe3MAhWu1ISk7OSToyVriga3KWhYZ6Nf92L5g==
X-Google-Smtp-Source: ABdhPJxMAqC/9xf+4Ig3GYpEod8yl4nK4RsazuqtIkK0qfl4kAfDsXmJeks3/H6i+HVOnzNz5Q2XqvqQamIzMGXchIc=
X-Received: by 2002:a17:907:2156:: with SMTP id rk22mr36680106ejb.64.1634082729262;
 Tue, 12 Oct 2021 16:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
 <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com> <CAK9rFnxuiAX2-5TFhfyTdpaY3BRysX_Q2sJkca4LhOLzapB83Q@mail.gmail.com>
In-Reply-To: <CAK9rFnxuiAX2-5TFhfyTdpaY3BRysX_Q2sJkca4LhOLzapB83Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 01:51:58 +0200
Message-ID: <CACRpkdbF3oXec-8Z-1fNVL47mfYo2TW8WTDxzpwaR2YqLaTdAQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Mon, Oct 4, 2021 at 6:46 PM Brad Larson <brad@pensando.io> wrote:

> Yes that works, please see the diff below where the file
> gpio-elba-spics.c goes away.  The original implementation was
> motivated by gpio-spear-spics.c.

This looks good to me :)

Yours,
Linus Walleij
