Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7B5A23F3
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Aug 2022 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbiHZJRn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 26 Aug 2022 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbiHZJRe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2022 05:17:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2EAD6306
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so1234024lfr.2
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gse99LVVZ+s0NzcFeYnNMOa2sY4Nvzm38CgGv+mxYoA=;
        b=gtgsU8JUGcfQO5lbt+pt0b3USg0WmaEjHwGR0eC2zhDnzLijjX07ZXPviwekZf/QSz
         gOII2rIE6k1XBKHB45CXOG6d1NvlfMU+LZLHkDv0ICPTC+Kt8102oOdPLiIZlH95FQaR
         TaoMxfyYFLZzTPH5LtJ74dae4iLPcJ/7n86ak3oBMZSMqL8NULQQWF45mGyq9PAvuEc+
         +353KUJZfYSzZIvzEO3KVIG/4xfFQqw+5LKeOAI3EIbwDlkaXBs4zuaKXZZ8N089Wlqj
         MkCWcFtVsaSgf8GAENWCKAUFyfDIncwQlR3KhAuRJx+GqrPBIUHiBQ8Fjd/ymU8uLjq+
         186g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gse99LVVZ+s0NzcFeYnNMOa2sY4Nvzm38CgGv+mxYoA=;
        b=7SLPeiLPg/3e5n1lA6En1ef/v2B2vt++quHUKzCKiRTUTFKS2dpszZqgldsuUHoS+z
         Z5HVsbI47rcV+HTWAl8NiYQepcBKNSqoTg0tUqH+G1eEuv4SZ5XRr6FS9jR235YL9MO2
         aPJP9LaOuPqpcEHAXHbHQafDLE9r6ShMdSZur2rxVJE6YUkScqsmYaLRwQfF1min0WDe
         BYAOyvefCgWCmR2G5cKKX4U9pjvEAGwZ4JeWtpH433Zs5FGkJh1x2DA/wmEdB2TIGro+
         k6iXlEgBbKG9he9A6g++JBiKO2ruu/8X7K7Sn0kW6pZls3s2muhIi8dzzQCTsZYy/ryg
         s6wQ==
X-Gm-Message-State: ACgBeo126WXWNgBYW6hCCMcM3C9tBCdiYGNlFtlXHZMBlaBTkGdUQGkm
        y1S74QJ5bhPZIEeK/Ppe2xhTtSQRrMqKvzex8lKNRw==
X-Google-Smtp-Source: AA6agR6VRBeoYp6RsQWAa382P3cI0h1mU+eE6bV7HbsjLTQeoWf2eodw9E095dOILPJSqLJfyOWManU8Unfk2j30I0Y=
X-Received: by 2002:a19:5f53:0:b0:492:f5a8:2da9 with SMTP id
 a19-20020a195f53000000b00492f5a82da9mr2136571lfj.184.1661505445547; Fri, 26
 Aug 2022 02:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
In-Reply-To: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 11:16:48 +0200
Message-ID: <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Add SDIO interrupt support. Successfully tested on a S905X4-based
> system (V3 register layout) with a BRCM4334 SDIO wifi module
> (brcmfmac driver).
>
> v2:
> - use new SDIO interrupt API
> v3:
> - don't duplicate checking mmc->sdio_irq_pending
>
> Heiner Kallweit (2):
>   mmc: meson: adjust and re-use constant IRQ_EN_MASK
>   mmc: meson-gx: add SDIO interrupt support
>
>  drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 19 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
