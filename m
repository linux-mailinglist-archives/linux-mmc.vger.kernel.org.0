Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0586A103A8E
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfKTM7o (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 07:59:44 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37460 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfKTM7l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Nov 2019 07:59:41 -0500
Received: by mail-vk1-f193.google.com with SMTP id l5so5991855vkb.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2019 04:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv3ivjIPtynZHdywCSMliDx/clqr1q5FAXmvUn8sv20=;
        b=DZZd0nosT6fMGQa1LrZVBdRXKbdVyqsPindUQS1a1nqo5KvOOvDL6TYkJpiTiwvqJm
         kj/g0mCy/d36pCSmPRACtWRYhBo+puCWySIvVjJkhBdjQlOJX/vdsIwvOFJXKTqWEIkJ
         qilWi7YApsYcUIF/Ghp5HFDBliyzAw2KPYzEBMtEnuPBotdX72kg7XjjLYcdPlzZ6eTE
         mJzOOAhDrtjtwPvojZ3vCHKnUlRdvUb5r2UjPybqDbDV7PKTti/mA0zC4GArhWLwD1pu
         09jXs0Rs4TfHjCztF/mr43pLNjcug2oAeU+TFTbYX8J1siDHLBfAw3ku2nwrQVzY2d3/
         8HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv3ivjIPtynZHdywCSMliDx/clqr1q5FAXmvUn8sv20=;
        b=DRVq1JILauj4wk2UWKnp7yW6OsYPDLQ2kN0KZBynt2224dhQz7G6BkxWQe2TAOCw9j
         oMKlEtseH5JAguTc4CGsrw0VZPsXzUw4gJQV+7pulmxjJA6uMbChbvh+/h7Uzaajr4C4
         couMcyxS+neup145TkroSgGcx07ndeLJbd0PK8baXjbIE3WXDVmhiSfdWFrIsVT7yHT1
         cWQyjrLwXo35/9qmiSPGwb2Ta+u0WYlUjEaBN9gVJq2dxa5uMvuxXjLMWja/jIaI39tV
         RoynJqlabV2PQNZK/wnZ4xM/EP0lxW4slehLbfyApAPP6400Rin8bi7JKbXdJGVvmdgk
         Q3VQ==
X-Gm-Message-State: APjAAAWQFSvIZ1B+u9A9z7MRYst67pt9pNnQ9vfTGYjkv5cZuTvJuQdZ
        b92EpTgi12Eou85vHup7gbVhkH+7AntkHg+dAPGRaQ==
X-Google-Smtp-Source: APXvYqxQDALgcQNWwHLSVFVl8w6QJkMBvvg1vKNEOr6M8d/if/KbiPE09YO/XzOrupoT94zbpYTuK0JTffdMAGJDNgk=
X-Received: by 2002:a05:6122:1181:: with SMTP id x1mr1311701vkn.25.1574254780111;
 Wed, 20 Nov 2019 04:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20191118104646.3838-1-i.mikhaylov@yadro.com> <20191118104646.3838-4-i.mikhaylov@yadro.com>
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:59:04 +0100
Message-ID: <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied for next, thanks!

For clarity, I am leaving patch 1 for arm-soc.

Kind regards
Uffe



>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8962f6664381..56912e30c47e 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -111,7 +111,19 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> +static u32 aspeed_sdhci_readl(struct sdhci_host *host, int reg)
> +{
> +       u32 val = readl(host->ioaddr + reg);
> +
> +       if (unlikely(reg == SDHCI_PRESENT_STATE) &&
> +           (host->mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
> +               val ^= SDHCI_CARD_PRESENT;
> +
> +       return val;
> +}
> +
>  static const struct sdhci_ops aspeed_sdhci_ops = {
> +       .read_l = aspeed_sdhci_readl,
>         .set_clock = aspeed_sdhci_set_clock,
>         .get_max_clock = aspeed_sdhci_get_max_clock,
>         .set_bus_width = aspeed_sdhci_set_bus_width,
> --
> 2.20.1
>
