Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1973560A
	for <lists+linux-mmc@lfdr.de>; Mon, 19 Jun 2023 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjFSLnw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Jun 2023 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjFSLnu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 07:43:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA7DA
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9e33a3d3fso34888671cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175029; x=1689767029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiE4sUiZ5gb1dIqZRDsEwzAqAkHEUTh3d5zGtU6Qn2U=;
        b=ltvWUnIidji1hMhVQiDBT04sYB/O5GElRF9pAhEnG6qVAllBb7atyc1Wh0L42Ja80m
         yukc9t51vrJSmhKUYtq8RzDYlKr94YMqgQkYdjUgdn0nWpndcjvE2SABKGSrCxTCW1jl
         3IHFxPvNje42HjJFHX7kwrLP8ggztGUjND7N3l4W2Ckzlg81LjSyFNPdFBs0zMoz8vtN
         j7d4fxGVyBkSbxUWDiczp3z0K1WF98EtfRl9eHYahuFNxunOcwsNTC9w2r8P7cJhiJhQ
         q99QHs0GjeF0mFgANCp5vp/f9KV1XL2G26YzApaBZ7MHAw1AUJh9N0p4C0JpWTe9FTlk
         lzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175029; x=1689767029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiE4sUiZ5gb1dIqZRDsEwzAqAkHEUTh3d5zGtU6Qn2U=;
        b=TqRpcVTBzSNs9vhu2YwJyiA5XrXJF7pw+za3TE0GDOLAg7Ccur44ov4OcH3FWOpTzE
         nMymI76eEc/WwGGqYD6ULUB5lqkiZXJm6UHAWv2nj1AOB8raAl2O7oZfWOcNx6t6rRoV
         Y2Bqjrs8QqnEoi1educagUzJnaT4xol3++UTcC4S1ccTIYVf0eUXl4SsqRmVQknoD3bK
         LiadcX3FGq8PStu4NcVD69jVzZhzWhW5XSX4gCEyPATY5B3EOa9hTXdFcgL1emjllZS5
         YjCQcd/T448sbvv6lIA2paRmxSj8V1219YiceslyBiihggk/EnhLaPfz3fMK2bONwt5b
         5MvQ==
X-Gm-Message-State: AC+VfDxuZHXzWPYaxTWOguQ+tHZdvD1puRLRIRy18uc4bAblnSKxey1V
        HSiz5bkNphHQpTtu4Tbe0z/iBWgEQ2Ljx539tuyi4w8J4llQHD1k
X-Google-Smtp-Source: ACHHUZ47SXfr2RTlIPoiW8/gI7b4nOmcfm0BbSDiKddQ8gjzlbymuhWn78Une5RI0DFW1ar5tVWmofmt3KKNlo+P7pg=
X-Received: by 2002:a05:622a:648:b0:3f8:493:d9e2 with SMTP id
 a8-20020a05622a064800b003f80493d9e2mr13037181qtb.38.1687175028977; Mon, 19
 Jun 2023 04:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230617203622.6812-1-s.shtylyov@omp.ru>
In-Reply-To: <20230617203622.6812-1-s.shtylyov@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Jun 2023 13:43:13 +0200
Message-ID: <CAPDyKFrcLTFWOHAwiVBu0NvymMFxfx-6T-5g3Pt2PX5obJAsog@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Fix deferred probing in the MMC/SD drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
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

On Sat, 17 Jun 2023 at 22:36, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Here are 12 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
>
> The affected MMC/SD drivers call platform_get_irq[_byname]() but override its
> result in case of error which prevents the deferred probing from working. Some
> of these patches logically depend on commit ce753ad1549c ("platform: finally
> disallow IRQ0 in platform_get_irq() and its ilk")...
>
> Sergey Shtylyov (12):
>   mmc: bcm2835: fix deferred probing
>   mmc: meson-gx: fix deferred probing
>   mmc: mtk-sd: fix deferred probing
>   mmc: mvsdio: fix deferred probing
>   mmc: omap: fix deferred probing
>   mmc: omap_hsmmc: fix deferred probing
>   mmc: owl: fix deferred probing
>   mmc: sdhci-acpi: fix deferred probing
>   mmc: sdhci-spear: fix deferred probing
>   mmc: sh_mmcif: fix deferred probing
>   mmc: sunxi: fix deferred probing
>   mmc: usdhi60rol0: fix deferred probing
>
>  drivers/mmc/host/bcm2835.c      | 4 ++--
>  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>  drivers/mmc/host/mtk-sd.c       | 2 +-
>  drivers/mmc/host/mvsdio.c       | 2 +-
>  drivers/mmc/host/omap.c         | 2 +-
>  drivers/mmc/host/omap_hsmmc.c   | 6 ++++--
>  drivers/mmc/host/owl-mmc.c      | 2 +-
>  drivers/mmc/host/sdhci-acpi.c   | 2 +-
>  drivers/mmc/host/sdhci-spear.c  | 4 ++--
>  drivers/mmc/host/sh_mmcif.c     | 2 +-
>  drivers/mmc/host/sunxi-mmc.c    | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c   | 6 ++++--
>  12 files changed, 22 insertions(+), 18 deletions(-)
>

Applied for fixes, thanks!

Kind regards
Uffe
