Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926F2C2433
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Nov 2020 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbgKXLb4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Nov 2020 06:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgKXLbz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 06:31:55 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE29C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 03:31:55 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id q4so6720952ual.8
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 03:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9W58if+JezX43XzX/NTqEDDLCHAVBE0I7kJVPV3FQU=;
        b=GyXPQqvplM0hD0QK6fBGY3qj8M8K9yQQt7ULZrSJM+aYyPiOAlMM1fbYdCE4/tHWTG
         GHpysbrtdQqdB2EUCVI7a45O6mgb62cPOrUpgMBBMrmwnmO4sGQXNZINKHMMJi4zcPQg
         FBu0cZsj7PyPm0wYK5/bjH76dHZfSF8DRmn7/P2yLvT7Uv9dUDSjvOX4giv1jKs6IaoN
         yFaQoSdny9pBQ8BeYAdcfLDIUtRg1Uei+tp5KsGbJl3KL8bJo7hOdD/RwP89VLUnVdYL
         rtTg+aegRR533UkMMK8ycUNzyvg+urMccaExXJC5hKDdCXdW4xoqlVw/f6H8HgBGPpa1
         JsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9W58if+JezX43XzX/NTqEDDLCHAVBE0I7kJVPV3FQU=;
        b=Gr8o0CWqc5sSFbea+vkK+xl6oxTvQSwgSYkNYeKwqvFwpEJ5PpGHyBqbV51oo/fnep
         HfxAw7nwAygYu+jdQL/lQOt0W3GOGElAWumlowCglx6nydo9FmWCfMpleiamzSGezkIL
         J/lKI8nh5gElNypRuIvtYYLhsSvgoDBDTQ3c9P4ktsYNm51GBr1+Yh2XmwppmmqhI1oA
         mS0VQmUB6TMoiI27HDqnPk0VO2BAHicvr6icO0KLVYFGYzAMjelR/uYpmmBlEsbZwSVN
         /Si+5XQSFw2gO6/qTqTSwzMkZlwFBAjZzD2vqMV6zEJIh05tuw4oKUrcJoR3oJu0Tx8M
         kAmg==
X-Gm-Message-State: AOAM531exCEodTWvVbX+NmqPCGE9ipICnHZIcG4ULLcXJ6iYpReLt2Zf
        f1x2+o44Bv/P41sOtX5AnQ800f4jj8p8YRqEsFqDAA==
X-Google-Smtp-Source: ABdhPJx/ET0gtWWmdhOHFuowKK134M/q4mr9M/NtgE+/oqHz1Kr/+2ute0xyp5F77kX7U0HAAwwsZxvvoOQWu6D7TcI=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr2583344uak.19.1606217514653;
 Tue, 24 Nov 2020 03:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20201120032639.24386-1-mw@semihalf.com> <20201120032639.24386-4-mw@semihalf.com>
In-Reply-To: <20201120032639.24386-4-mw@semihalf.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 12:31:18 +0100
Message-ID: <CAPDyKFoXX_uOkes6JW5thTe5rqjCCrB_pYvLkTzHncfcxvMD_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-xenon: use clk only with DT
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 Nov 2020 at 04:27, Marcin Wojtas <mw@semihalf.com> wrote:
>
> As a preparation for supporting ACPI, modify the driver
> to use the clk framework only when booting with DT -
> otherwise rely on the configuration done by firmware.
> For that purpose introduce also a custom SDHCI get_max_clock
> callback.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

[...]

> @@ -561,9 +574,11 @@ static int xenon_probe(struct platform_device *pdev)
>         pm_runtime_put_noidle(&pdev->dev);
>         xenon_sdhc_unprepare(host);
>  err_clk_axi:
> -       clk_disable_unprepare(priv->axi_clk);
> +       if (dev->of_node)
> +               clk_disable_unprepare(priv->axi_clk);
>  err_clk:
> -       clk_disable_unprepare(pltfm_host->clk);
> +       if (dev->of_node)
> +               clk_disable_unprepare(pltfm_host->clk);

There's no need to check the dev->of_node, I believe. The
clk_disable_unprepare() is capable of managing a NULL pointer as
in-parameter.

[...]

Kind regards
Uffe
