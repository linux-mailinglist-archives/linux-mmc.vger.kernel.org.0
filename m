Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28B1E093
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfD2Kce (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:32:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34443 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfD2Kce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:32:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id f9so2191346ual.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b2cEiOwIFkqDrQwWdAjt6VF1fB8qiQz/fciHm7Mse8=;
        b=NWrXGb7VRDf7VArwNbZq3mfkZ/mEzdLLQOnDoNGqkHD+qe5I+el9Byc7lTeBzTWxV1
         Zcoq5eybd9Y96Vp2t33F73F8kSNFxenatKNwy+u1zdrLGXMOh0t78xdIek371AXeeK+l
         AvqudcclwmvCCZ8TExoiu4OF+pGfNardPP/IywWZwIM94wA1qdMiOpH5c2TU8AKf6M0G
         eg9gFxSk8ndkMUT87GMxIP67sT+3YPIElkGNr+0XJlRt4A6fv2/H1Wr6uY+wjMI+FFF3
         QIqWXkQeMvJZN3INJiqENsnZrrcLg31u/S7KOuuEwve7wACJVc3A6QDklIyKODxDmvmK
         ODFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b2cEiOwIFkqDrQwWdAjt6VF1fB8qiQz/fciHm7Mse8=;
        b=dgFghlanj9oPAA7yhb7ZFshkdjpXvSLJjCdD6pzcwUYw2zYd4De4rrkoTjvWOzsTZT
         aKBp+UWFga9mdArJ9WcN+AyebwYwKyj8+TZNEV1VmWwQtSEdqTNs9X/hK4kdPec7oVd9
         4KTjOH9VVYCOIzIZmN9mm5A3jYCdQZpTg6f+JTmHOc1sA+BMiF77hKuBbDILY8zk7IBj
         AemCaCAx/Rb9NuCWr49wGURSdfX6ryUqWtK0NI7UPejJfIQzipgZwDDhVgQFhGvB25pJ
         asJOzkt1myB1F4lrlJF1Y6zJCQgEl30C7s3Vw6qjB2PGo90DIy/WJtzfi2FO0mwCXQ8n
         X2/A==
X-Gm-Message-State: APjAAAUc9HNh/EmPYHBJLwbE+7SEXmdEyAtgG0LpkhmOTGJ2gwKWHboV
        XHNinFztoPYUNwLbL5ASKIB7EFMXKcG+KYFhD1BOmg==
X-Google-Smtp-Source: APXvYqxb7hueDVUMb3fMwLwbCdvQGzw8jp5PicLihCwM99lR82KoE8Y14rvJ12sRpOS8QvSPQaWEH10powEv6UMe7HY=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr30989522uan.129.1556533953648;
 Mon, 29 Apr 2019 03:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:31:57 +0200
Message-ID: <CAPDyKFrBJeBNOPh9H3Yn-6-um2B-9Gt6_pW8Qh0ZGQB26-tq+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller driver
To:     Takao Orito <orito.takao@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> +
> +static void sdhci_milbeaut_power_off(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 0);
> +       udelay(1000);
> +}
> +
> +static void sdhci_milbeaut_power_on(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 1);
> +}
> +

As stated for the DT doc patch, please use a fixed GPIO regulator
instead. In this way you will also get a the OCR mask based upon the
GPIO regulator, which is parsed out by the mmc core when sdhci calls
mmc_regulator_get_supply().

Otherwise, this looks good to me.

[...]

Kind regards
Uffe
