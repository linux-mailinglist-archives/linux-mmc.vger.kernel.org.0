Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82FBC0C77
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Sep 2019 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfI0UPR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Sep 2019 16:15:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38152 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfI0UPQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2019 16:15:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so3703057ljj.5
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2019 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXC46ElY52rOcZF+haJMaG9kGcpXjGEmuqnl/s6D7sU=;
        b=iJFiMf8oaWyvJ8t2FRdzBieJmBW5yu3HRnK01HFEMVSw7D+/9QK25m8hgUZhlWOrkd
         GziWqf9HwAaV/7hi26Io+K/S80D/MN/x+ezIQfe7uGfBQiGtpImE2fapnlVBtF1Vb+/3
         yQFsiXQup4fp1DCtB1o8KLpGpzcrECIOGG0AqChAK5VdPoNZvJJkWfrIX+n1PXyv3VmT
         xGys7w1WQGLfw68iLVFJYjP9Y2g0uImlpyLL/hpSnSJNSyZYO9tVpYVdCkiH5gkniz8q
         qLMAKTa17sTc5w77+WioyDKi/0DjMl+dAoWnHWw2RP+jPn1YO6K5X6L28U4WNAe5qVco
         U9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXC46ElY52rOcZF+haJMaG9kGcpXjGEmuqnl/s6D7sU=;
        b=HGVmTp1iO94cz9tch1lXasEZ0MX+/m/KyJeF2L4RdlTtKFrt5cSLZsT5Xygzwm+Goc
         kYa4IYm2iWYnAPjLmB9pOB/7KfFg6N7dmoeG0wa0S9vV7hPuLs48JJB41pA4DlFXyel7
         DmiPDOPa+0FHt03GgyworvJ62LEjD+E588YICzfez5PHZwNM77gjhRnff8dxtytF9Cvo
         eA/WYUzzDpEgYcgU6WFYcmQheLncLf+almZ9cQ/Y/OnjT/UBIeEDUTsJcpVnWZu/mhmf
         WKDpCjwc7GX3PTy+cvkLVMqg9n6DbjFg7OcJ5TkTMOcdbsw7OOZe5x0vSNz2Djy+6kOX
         mY+A==
X-Gm-Message-State: APjAAAVpn697rY3YDFLzCNNl3WP+p2sAw3By2UkKn+rkPcuU6AmYdQLe
        Wg9sym8bAIV7kDUAyzHQSEpy8cHOnylRV43w+Oeh1A==
X-Google-Smtp-Source: APXvYqyc5PxTmVaJ0Ok+2gj+DX5t1h/U/xZZiw2Ey28AqH+xKmSmLTYAFO5aIUid9OVGoQCZP/0p7sxnItq2tt3rgmM=
X-Received: by 2002:a2e:98ce:: with SMTP id s14mr4228705ljj.108.1569615315050;
 Fri, 27 Sep 2019 13:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
 <1563776607-8368-3-git-send-email-wahrenst@gmx.net> <CACRpkdabfiDbGmAQciAUSThY-KfTsVq3tHz0bBszs2j_ej18Nw@mail.gmail.com>
 <63f17284-5551-9492-9eff-f8a4c003196b@gmx.net> <66dc2cad-673e-0a0b-0aeb-3d62fa2d4ccf@gmx.net>
In-Reply-To: <66dc2cad-673e-0a0b-0aeb-3d62fa2d4ccf@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Sep 2019 22:15:01 +0200
Message-ID: <CACRpkdb9pxCF-WvA0f3rU2cttX1XmQxB=xtOhPAaP+nYoBd_LA@mail.gmail.com>
Subject: Re: [PATCH 12/18] pinctrl: bcm2835: Add support for BCM2711 pull-up functionality
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Scott Branden <sbranden@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 27, 2019 at 9:29 PM Stefan Wahren <wahrenst@gmx.net> wrote:

> today i had the time to try this out. Instead of the following:
>
>     i2c0_gpio0: i2c0_gpio0 {
>         brcm,pins = <0 1>;
>         brcm,function = <BCM2835_FSEL_ALT0>;
>         brcm,pull = <BCM2835_PUD_UP
>                  BCM2835_PUD_OFF>;
>     }
>
> you want this?
>
>     i2c0_gpio0: i2c0_gpio0 {
>         pin-sda {
>             function = "alt0";
>             pins = "gpio0";
>             bias-pull-up;
>         };
>         pin-scl {
>             function = "alt0";
>             pins = "gpio1";
>             bias-disable;
>         };
>     };

Yes that looks much better. In my opinion.

I understand that it puts some developers off because of being
more lines or excessively verbose, so to be on the clear,
verboseness in itself is not the goal.

The goal is universal
portability: i.e. it should not matter one bit whether I work
on an 2001 Intel StrongARM SoC, a 2019 Broadcom SoC
or a 2011 ST-Ericsson SoC: I will understand what bias-disable;
or bias-pull-up; means, which lowers the threshold to
maintenance.

Opaque macros, however helpfully named, still creates
a higher cognitive resistance and stresses developers.

> Unfortunately i don't know U-Boot is handle the BCM2835 specific pinctrl
> functions.

I think it would be nice if boot loaders avoid to forking the
standards, but I suppose it will invariably happen.
Just keep in mind the IETF motto "rough consensus and
running code".

Yours,
Linus Walleij
