Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFD6FF08
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfGVLyi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 07:54:38 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41137 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfGVLyi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 07:54:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id 34so15187181uar.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+jcqREf0y9aZZyOwn61TZepULbNlwtiLvYl1u1X4h0=;
        b=jYgsjNrm5DLwDRKga2G6kbcDqPs0WqeGaCaUJTW71luxttK/AKH8nd1s3ahL10ppLc
         fOeSvqncdR7y5Zkoz03hM5q5wLRrTfRijStSrb2iKT0btXaqEkkkX2hbuiLV+qwbFE81
         Ezs30ZYWr3O8Hdy2HZZobySjUci7JPRa+7P8ccen9AI982wZSqGfQJVzoiNbhje0z7o9
         eP1htrnKA5GUIuym0D5NhwEP9Vt45b1t4sKWVXDB2mzKb+BMCyQnQ1KIJvMmsG7Y7IP8
         C8B3+6b+v4OiIGMR7Pz8eDZp12559FVVBADFYIsc/0mwjyyEZctgDkf8g1IaCNU8iM8M
         amvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+jcqREf0y9aZZyOwn61TZepULbNlwtiLvYl1u1X4h0=;
        b=ZPnMvP2e4KGLH6sQUAjhJzzX/ScRm+82qk4xlnB/Uu/qb/7FiAH08adtGF4jaeS80V
         rxQUhX13oxh+46odmFY5JJ+2dDH3+f7nGKW5JFWQoawBSTDwB3JuqgjKOO8lPABFKeGH
         tNwaJ3GiTZDmbFLx2nW3Yk2ACP/DnyBkOqYFR0fRZx+XMaUATNdH4gvoQhjZDAZhmvtV
         7lgXwWp1nS69ncZSouP4RoJ22df+ZBAHJ8uR44XpKi0UobSSpvspbK+htwoeLItUhjCC
         muigIxRy0STgPv4VivwlGx2n5mLvYhBELtkk8KE71hWPI0D3TE/O4qk5zKPLhmlQgwwI
         uhTw==
X-Gm-Message-State: APjAAAUcKi7ygttNhHjQ2GRjhhVmQPP4HnKjNB4G/0H2M1cVZqS48Q0M
        rrJWQ79t7bwEmQ7cBRONin45tO1N9SPxU95v8cvXdg==
X-Google-Smtp-Source: APXvYqyER+QheiF65Y24ygl+OAmEAkNJ0+BDjyOfafxC+aFcXzqZpZP/NHU00/dvkHkEZnPUIEUhDuaRlU44tBGPerU=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr41180854uad.15.1563796477559;
 Mon, 22 Jul 2019 04:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
In-Reply-To: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 13:54:01 +0200
Message-ID: <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, which will cause Spreadtrum host controller work abnormally after
> resuming.

What does "software reset for all" means?

>
> Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all.

Normally, sdhci hosts that enters runtime suspend doesn't power off
the card (there are some exceptions like PCI variants).

So, what's so special here and how does the reset come into play? I
don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
and nor doesn the callback from the sdhci-sprd.c variant doing it.

> To fix this
> issue, adding a specific reset operation that adds one condition to validate
> the power mode to decide if we can do software reset for all or just reset
> command and data lines.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changess from v3:
>  - Use ios.power_mode to validate if the card is power down or not.
>
> Changes from v2:
>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
>
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..94f9726 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>         return 1 << 31;
>  }
>
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       /*
> +        * When try to reset controller after runtime suspend, we should not
> +        * reset for all if the SD/eMMC card is not power down, just reset
> +        * command and data lines instead. Otherwise will meet some strange
> +        * behaviors for Spreadtrum host controller.
> +        */
> +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> +           mmc->ios.power_mode == MMC_POWER_ON)
> +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;

Can sdhci_sprd_reset() be called when the host is runtime suspended?
That sounds like a bug to me, no?

> +
> +       sdhci_reset(host, mask);
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
> @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>         .get_max_clock = sdhci_sprd_get_max_clock,
>         .get_min_clock = sdhci_sprd_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
> -       .reset = sdhci_reset,
> +       .reset = sdhci_sprd_reset,
>         .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>         .hw_reset = sdhci_sprd_hw_reset,
>         .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> --
> 1.7.9.5
>

Kind regards
Uffe
