Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129D938866
	for <lists+linux-mmc@lfdr.de>; Fri,  7 Jun 2019 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfFGLDA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 Jun 2019 07:03:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40910 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfFGLC7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2019 07:02:59 -0400
Received: by mail-vs1-f65.google.com with SMTP id c24so886548vsp.7
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jun 2019 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUmbq4ZzrfgjJ6I/bdvOaFhtKBJjK9tscZns2i4i8ls=;
        b=rbswCChLasSiMv/BxkP+oqC6iQQ5YnOz2jHk8PMbC0zI9S1v/bznWuilMUyjrXLufI
         tBofULNs3jx0Ow9VaFVaYGxRQvzU82XBOlfJq5ISmCxvw20vVp1FfCTxng7lgcVr/fDO
         9wrhKxb2wX1Yw4awvXoH22X4YIcDGC6/cJSCWFxWFhrLqcAiXL7rOZA4rvSseDG3GeJK
         31m3sVPpE6DB+jvHavpdf3g+3NF6N3xKjgE5q+umHY3ZNSGHOuODtFu5/PLVhF8yEkSj
         HarLC+t7Wt+PP1PnEAgWPPTvHxQkqLFcoM4i2QNtsCkOcRNrm5xargwrFL5jAii+1OSc
         4kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUmbq4ZzrfgjJ6I/bdvOaFhtKBJjK9tscZns2i4i8ls=;
        b=WgGoLUtAfYC4OooxTU/dFACO5qtm0+SiVxyFN0Abf044F63JMm97GDIMSBDPc3Pabj
         g7IcvaVZ9iDwLzDZFt4rKD1JHjtvQd7X/fvLsEqnmaUuE3YJ/Ju0WR6obxcDor0veZtC
         Z+xicheBQByx4kiPSQG0yP1Kxr3n8HCHFv5uZsdaVdcKsaAG+vPb/4oyTmpXZWkbkqu2
         /gYqTzfUd50go2fDKvVYcELHcfJQR8PjUj87afQQS1VJ+vf/zgk1FdbniPt/iu4FN5BK
         FJOxDGMWIBW1Q2u3S4pWnN3qb40otb9E6F1FeCn7cfb8eM3G/W8uhw3w0hbsw3/hF4OD
         KM7w==
X-Gm-Message-State: APjAAAWlStkJqd97S64+XDYWSuSadUYKPsaGoBBfwzSvmamRqvDwtKho
        L2qvHBWMX2QmlleVGjIDZJF9Vj2bMe2gYwV/sUGlUw==
X-Google-Smtp-Source: APXvYqzDuz5mV6Jsi2xrh1eBdn+z7KJtHM7z3KIMpeuQwSP0He+fkG995ke/oRmFwgQo/qgul6kuZ3xCxNzlcCOd13U=
X-Received: by 2002:a67:706:: with SMTP id 6mr11457746vsh.200.1559905378848;
 Fri, 07 Jun 2019 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jun 2019 13:02:22 +0200
Message-ID: <CAPDyKFp+UXDrrferK0zP7nPFtvkq6UU29vhJu3HCEUiKcAOsJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add SD host controller support for SC9860 platform
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 10:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set adds optional clock support, HS400 enhanced strobe mode support,
> PHY DLL configuration and other optimization to make the SD host controller
> can work well on the Spreadtrum SC9860 platform.
>
> Changes from v1:
>  - Add acked-tags from Adrian.
>  - Fix one mistake by changing MMC_TIMING_MMC_HS to MMC_TIMING_SD_HS in patch 8.
>
> Baolin Wang (9):
>   mmc: sdhci-sprd: Check the enable clock's return value correctly
>   dt-bindings: mmc: sprd: Add another optional clock documentation
>   mmc: sdhci-sprd: Add optional gate clock support
>   mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
>   mmc: sdhci-sprd: Add HS400 enhanced strobe mode
>   mmc: sdhci-sprd: Enable PHY DLL to make clock stable
>   dt-bindings: mmc: sprd: Add PHY DLL delay documentation
>   mmc: sdhci-sprd: Add PHY DLL delay configuration
>   arm64: dts: sprd: Add Spreadtrum SD host controller support
>
>  .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
>  arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
>  drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
>  3 files changed, 217 insertions(+), 8 deletions(-)
>
> --
> 1.7.9.5
>

Patch 1 -> patch 8, applied for next, thanks!

Patch 9 is for arm-soc.

Kind regards
Uffe
