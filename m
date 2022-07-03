Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31DB564A37
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Jul 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiGCWDz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 3 Jul 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGCWDz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 18:03:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D112BDA
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 15:03:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f2so5519750wrr.6
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xQhicMlo40PEYHEa+HtFNXOuSyAFEaSrHVHB9mDE+w=;
        b=J7IGjji+2MeqboyKlAyhT9occA5StCISxg7V+178S7fH9u89Xeeds7Gw2Yi/Iejd/w
         h3fgf2BUvt73wKg3vxi7r+Xnjoag35ngaWDSN6KiM84DvDWYEHwE3wIDC+eLuAAoGCxD
         coVhyq25rA2saP0tCYdNl3Wtxh7aU/Zi1M71lpNct6r4FPNzp3lmzDXyZ5HuDExuzVDh
         laH2HqaU9PQGwqW4TPXtIhwlEJFbB5f8M8iwyP0Hg+ScnwvQNvPcJhNt40aXkkF1qTCC
         exNJ4AUyjH5SC6NkXAuvwgj5zgF3XPN7RUiralscFib6/BIz+sNzE8hN5SH41hJ14lSc
         Wwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xQhicMlo40PEYHEa+HtFNXOuSyAFEaSrHVHB9mDE+w=;
        b=nAWhesvh87ghJn/p+s2VMQ0b2JbJCGEtQ6hg5C82u6K4aSt8xQfRCK0MTxFLcORDIe
         U/I/7POCezjYk5uLxLlz4W4qqpaNoPj26J0VkEyw7cdUakGhyhrlziFW7bf+tP7NJMn+
         REB0Np/j5ILvAc2mka8SKAreCS9MJVW9EVQD9ttQuLeTh0VsLLJUXWJzUMPFHRIDBTR0
         tLEr3UG/H/9eZJ5iivN1T0O/9NzWks6Q0Ji3fgl+mkLiaMFYLU3ipcd+wKPMmUUfsSm0
         2SIVKWfJk6Wa+sIWbgMgHi7hwAe3iKr6CZDQwxK57Bb00AJg9PPPu2BkcEs6EYApuTdK
         heYA==
X-Gm-Message-State: AJIora+r1pvSZh8WYV6XbdlMWSePVS4jT24Cqcg773gk4483RCylF+J8
        HykijX0wKD2PaftZMtMnZtMXYTAaYnsW0BqGD657Bw==
X-Google-Smtp-Source: AGRyM1tuU27Sd3adoglvl1Seo9Iys1g+XufZY6cogvzB+U2PQMuJVHpa8rlfUmfmSq9REo2HZnjnobGZgQ1e1QIinoA=
X-Received: by 2002:a5d:5a15:0:b0:21d:630c:a609 with SMTP id
 bq21-20020a5d5a15000000b0021d630ca609mr7051364wrb.468.1656885832059; Sun, 03
 Jul 2022 15:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-16-brad@pensando.io>
 <a929309891f9f28ae71f7ee09e990dc8bc362fdf.camel@pengutronix.de>
In-Reply-To: <a929309891f9f28ae71f7ee09e990dc8bc362fdf.camel@pengutronix.de>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 15:03:41 -0700
Message-ID: <CAK9rFnw0s4bVT0TV05EhL+znbJscLmSJKaQkJBtBDKpy+cqE8Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Philipp,

On Tue, Jun 14, 2022 at 7:49 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Brad,
>
> On Mo, 2022-06-13 at 12:56 -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > This patch adds the reset controller functionality for the
> > AMD Pensando Elba System Resource Chip.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> [...]
> > diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
> ...
> > +static inline int elbasr_reset_shift(unsigned long id)
> > +{
> > +     switch (id) {
> > +     case EMMC_HW_RESET:
>
> Are there more reset controls than EMMC_HW_RESET?
> If so, please list them all.
> If not, why is this a function with a switch statement for a single
> reset bit?
>
> > +             return 6;
> > +     default:
> > +             return -EINVAL;

There are others but only emmc hardware reset is currently needed/used.  Removed
the switch and just using BIT(6) and removed file amd,pensando-elba-reset.h.

> The error return value is never checked.
> This can't be reached, since ELBASR_NR_RESETS == 1. So id will only
> ever be 0.
>
> > +static int elbasr_reset_probe(struct platform_device *pdev)
> > +{
> > +     struct elbasr_data *elbasr = dev_get_drvdata(pdev->dev.parent);
>
> Peeking into the MFD driver's private data structure seems unnecessary.
> Consider using dev_get_regmap() instead.

Prefer to keep it this way as it follows the approach of existing
driver reset-a10sr.c

Regards,
Brad
