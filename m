Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8A97E4A
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfHUPMR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 11:12:17 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37742 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfHUPMR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2019 11:12:17 -0400
Received: by mail-vk1-f193.google.com with SMTP id b144so636585vkf.4
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2019 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKEtoel2h/x4hDnWnhY9qfx+YUzTSEXD8xKqnIyHogA=;
        b=yYdkVsx9q5KkA1Q/V3gWf7EJK3xA5NdhEa1zOfwWyUl3xdw0gh7cwfY52CkwuqlnnF
         SkS3kYWPA8XhE1ABbEuTLE4yA54rzHHW7Zhgl3ZN6cI9Ek1GibUPdnGEHrp6nW/BfguK
         8Q8f6wjQoKEgWCZHoWO05ph0nVKJ6Q15b+kRWDeJhpGxYQBQ3WVqR8AFRpi9Vofi5z0/
         CyPguiYpGdNtHZ63Uij63fkWKkJmsnYCjZxrzDO6rOoATCO1Cneza+w7e+WRA1CoPHbP
         4vGkIgcVH25yKKgrxqeBLrTBFDVtVuQZGJgsmHdrlp9lPtd+QKwcC51LhN+Ri6v+W+GL
         FjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKEtoel2h/x4hDnWnhY9qfx+YUzTSEXD8xKqnIyHogA=;
        b=h2yPNoIcaQ6kxDBBTzfy5aYI3rLl1+8mX0uCYKfJgStDEoa3n7uQV5S4FaNQokdKzF
         mSaxMQYmJHMy9Czeyabt0HwQY7nZ/9023KS06JQJPLwtESduPPMWC0b5+C1c2PNyiC9Y
         Rd5j8oWwhbGDFAO2YKzK4lVdbyTbxa40WzJX+ann/K7bM9P4In0na6CdlIkfRqkaQ3Du
         QP2jGvy/oaSklsRBQxT9nuCHTjB9yUdmCTFuuXOPGSbZBaaXt6lQ7QG42W3pi53PhRMY
         93YXSoshHLPudWrWKiIlu1+id25Q4YziFdpnMt8RsdFnUGfsUtZuNvGI9dPTrZeSPsJ9
         L2cQ==
X-Gm-Message-State: APjAAAWaUQzrTeZI/8KrnCR3L0k58/9KMKEhgfRQ4PEvuwnKC6o66Rw1
        AiZcHUC4O5unkE6DVNFG0nYW0Mc7IP3lqEO/ktRPJw==
X-Google-Smtp-Source: APXvYqxtlscJ8dXQyaX0YociSYwwEReTd/3YWWYYohOpyWgHzKm0z9v54biFqCNjdZObl+yGfYnUiack1hGdImu+9bI=
X-Received: by 2002:ac5:c4f7:: with SMTP id b23mr5310274vkl.17.1566400335753;
 Wed, 21 Aug 2019 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190808222430.28477-1-digetx@gmail.com>
In-Reply-To: <20190808222430.28477-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 17:11:39 +0200
Message-ID: <CAPDyKFqtAc_PK+yg4ev=-vm4-OPjhUdD2F9t+-ATJHO6y41G2w@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro() implementation"
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Aug 2019 at 00:25, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
> WP-GPIO state need to be used instead. In a case of the GPIO absence,
> write-enable should be assumed. External SD is writable once again as
> a result of this patch because the offending commit changed behaviour for
> the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
> which is incorrect for Tegra.
>
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f4d4761cf20a..02d8f524bb9e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -258,6 +258,16 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>         }
>  }
>
> +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
> +{
> +       /*
> +        * Write-enable shall be assumed if GPIO is missing in a board's
> +        * device-tree because SDHCI's WRITE_PROTECT bit doesn't work on
> +        * Tegra.
> +        */
> +       return mmc_gpio_get_ro(host->mmc);
> +}
> +
>  static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1224,6 +1234,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  };
>
>  static const struct sdhci_ops tegra_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
>         .write_l    = tegra_sdhci_writel,
>         .set_clock  = tegra_sdhci_set_clock,
> @@ -1279,6 +1290,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  };
>
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
>         .write_w    = tegra_sdhci_writew,
>         .write_l    = tegra_sdhci_writel,
> @@ -1332,6 +1344,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>  };
>
>  static const struct sdhci_ops tegra210_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
>         .write_w    = tegra210_sdhci_writew,
>         .write_l    = tegra_sdhci_writel,
> @@ -1366,6 +1379,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  };
>
>  static const struct sdhci_ops tegra186_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
>         .write_l    = tegra_sdhci_writel,
>         .set_clock  = tegra_sdhci_set_clock,
> --
> 2.22.0
>
