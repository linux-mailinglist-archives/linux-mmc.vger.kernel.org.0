Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC4A1B84
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfH2Nem (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 09:34:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35336 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfH2Nel (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 09:34:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id q16so2419472vsm.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZQRw3RVA3EaoAr0WIMQeD6W5AQqkz7QcXOAzySMDsY=;
        b=mjlYQJZXOCLmvYeLiazuIx+UY3wq5N7PVqOoMMGdiGRuWszrbjeeG5BdKIii+kFHf/
         zhlLgNOZDNfFJXEdvpQSldMZMsfy3EAJU813E8s8mZ+LwtLBw1/xuvT9iVLTWp5kBDr0
         XwgPt6sJe9MH17Gypg7IM3bSIV0w3vqZrnGDTNkHo9HKv9QPubEQ64tjw3T4vW/y1qWd
         P+3wZ/TYKCfoLGt9fjKNW32dtfxb28uZucnpAUmnSnWu6OoBM32fBZAXuRoGoxr1yJS4
         7QdSZ0ebZfNHcA+OWcb9389vfghhRPbVUuIXr5DfUxHNQFkXnLPg4+DzWZRh5ppANMTA
         C4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZQRw3RVA3EaoAr0WIMQeD6W5AQqkz7QcXOAzySMDsY=;
        b=KeIDRhLaE9CprtXy2Aq1OoPoUCmiASVDpWeDEH1mk2dtSDsqe/xPiezwa/iaqr9O4/
         h7eC6qxxO4jVyRRB9Md4TGxHOeufBnx/mIvCWqf/HJY1+ieETMByNq4ig8/PpESkFMG0
         l2GMlZHWnZ6nOihNW4wBNshc242s9JudxoRelKwpAsXNBQ/dozr/iv8Rs6wsoasINB4L
         klLU1jZK2Vdu+Xrtb1GbZEyMplgMf1Phf9shwXKKgV0P2zIyrVfTSm/+rHNA7uVlMHYb
         DyY0XCrS3zhlNmZRsk28g8nDjacKwViBKehCzrEMLRR1HTNqOtWuzx7bUjKrwASw5EtU
         dygg==
X-Gm-Message-State: APjAAAXVwxKA3IlJJDofIYF9JuQkCprtd+V4oLVzqGlha3yw4+TrVx39
        fOALqWAoFodakKxA58CYgDm8B22AbHJv3xlU4JlT8A==
X-Google-Smtp-Source: APXvYqxSPI3MRvojNzwX5Kyfz8EeaTkMx9wZb2I0g1wcY8R05FbnpvYzEDKCeOjDJ8VD8Z/lKEJxNPHt2Bumu0b0w/s=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr5483153vsy.191.1567085680040;
 Thu, 29 Aug 2019 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190829104928.27404-1-yamada.masahiro@socionext.com> <20190829104928.27404-3-yamada.masahiro@socionext.com>
In-Reply-To: <20190829104928.27404-3-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:34:04 +0200
Message-ID: <CAPDyKFrcvVKXmLpMdjtkX+OZ=VfyYa0hS_dStEiawUN3zMtbvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-cadence: override spec version
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The datasheet of the IP (sd4hc) says it is compiatible with SDHCI v4,
> but the spec version field in the version register is read as 2
> (i.e. SDHCI_SPEC_300) based on the RTL provided by Cadence.
>
> Socionext did not fix it up when it integrated the IP into the SoCs.
> So, it is working as SDHCI v3.
>
> It is not a real problem because there is no difference in the program
> flow in sdhci.c between SDHCI_SPEC_300/400, but set the real version
> just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 44139fceac24..9837214685b6 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -341,6 +341,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         unsigned int nr_phy_params;
>         int ret;
>         struct device *dev = &pdev->dev;
> +       static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>
>         clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk))
> @@ -370,6 +371,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
>         sdhci_enable_v4_mode(host);
> +       __sdhci_read_caps(host, &version, NULL, NULL);
>
>         sdhci_get_of_property(pdev);
>
> --
> 2.17.1
>
