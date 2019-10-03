Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F40C9B9F
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfJCKCn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:02:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35906 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfJCKCn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:02:43 -0400
Received: by mail-ua1-f65.google.com with SMTP id r25so700380uam.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsGUYnNO73EMBgzSxiWS52Dw+bBWnZJ2Rg7VZyB1pBk=;
        b=mt0rPuBKoWYOsRjtwgnJKALOISHSQUBjMTwK3t/QvL+HabYgTA5WFQcb6a1swync2P
         X896q7PX1h6UfLz077bHpvrI0AVlvyoim2XCCbY9lby8O/ggsMw4Omgt8XMM1zM8eJuZ
         WUz426kB5fR5bI/VIiCqSyknto1ALcm0VNyrEQjiPyI4iqGM+I1U/TGol42P1D+1Wn4D
         3Y6qgy2qHSTpS/UQFNl+djWtUajiEURZkiuVzwcPmCqdqWRXivWdreIrABEKvU7kJo8h
         Tsar41Y49w561BML/0ZBJrrNwCPaSC4q4oGVqyx1KWqCQXabcqe/8pHOr2stGeW9nEIH
         D7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsGUYnNO73EMBgzSxiWS52Dw+bBWnZJ2Rg7VZyB1pBk=;
        b=G3xrpYhUejmlRO90YfAlJTjQRUPs3eUmjNyGiNgTZGo+Fl96vumtsWpbLJdswo/2ro
         PEYN2GMvDBsVeB32gURJCx235Qg4gK01uFt6Q8glvdinvjoeepTVfL4wmw3T/jeGeMOf
         OMYbDGfcyVZomQJT4NYmY6hwRGettBYHaUZ9VBVfR1zY0EStvara9on+u3pKelNo3yG0
         aFMgPdzRkJ9jGxthEqIm8E+zdNCchfHsjZieSAkwx339GEPwFg0F2LKbd7nLt240tsVT
         erCWzb/WN5uivcFD2SEFTuARUq6RDGK2SMZuZBszNK6I1Mn7H6+FRyDgjHn1KVF726Rm
         lanQ==
X-Gm-Message-State: APjAAAWXDzXPNNSah0fSJBktnn+n+i49a7uStZbQE1tOTKtuKcsECNQ1
        jQ4lZq2n9WqDBblBol226uoC/b9219efUsOQZVZCdlR9
X-Google-Smtp-Source: APXvYqxVPZ2LZcD5IQHttgCw65XLapXwmDtGRUuj06LbKFtdQ73a/eKJIwuQzRSKuZK1eSgfO/25woD2OMxFQZYzBjE=
X-Received: by 2002:ab0:3098:: with SMTP id h24mr4324983ual.100.1570096961658;
 Thu, 03 Oct 2019 03:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190925114231.17640-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190925114231.17640-1-ben.dooks@codethink.co.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:02:05 +0200
Message-ID: <CAPDyKFr2hATGz_jspAGbEivxLhbP8q2XVh7iAFyjTXEwctNmGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: make unexported functions static
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Sep 2019 at 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> Fix the following sparse warnings by making any functions not used
> outsde the mmci.c driver static.
>
> drivers/mmc/host/mmci.c:422:6: warning: symbol 'mmci_dma_release' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:430:6: warning: symbol 'mmci_dma_setup' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:465:5: warning: symbol 'mmci_prep_data' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:481:6: warning: symbol 'mmci_unprep_data' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:490:6: warning: symbol 'mmci_get_next_data' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:498:5: warning: symbol 'mmci_dma_start' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:533:6: warning: symbol 'mmci_dma_finalize' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:542:6: warning: symbol 'mmci_dma_error' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:951:6: warning: symbol 'mmci_variant_init' was not declared. Should it be static?
> drivers/mmc/host/mmci.c:956:6: warning: symbol 'ux500v2_variant_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..e14003e52058 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -419,7 +419,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>         mmci_write_clkreg(host, clk);
>  }
>
> -void mmci_dma_release(struct mmci_host *host)
> +static void mmci_dma_release(struct mmci_host *host)
>  {
>         if (host->ops && host->ops->dma_release)
>                 host->ops->dma_release(host);
> @@ -427,7 +427,7 @@ void mmci_dma_release(struct mmci_host *host)
>         host->use_dma = false;
>  }
>
> -void mmci_dma_setup(struct mmci_host *host)
> +static void mmci_dma_setup(struct mmci_host *host)
>  {
>         if (!host->ops || !host->ops->dma_setup)
>                 return;
> @@ -462,7 +462,7 @@ static int mmci_validate_data(struct mmci_host *host,
>         return 0;
>  }
>
> -int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
> +static int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
>  {
>         int err;
>
> @@ -478,7 +478,7 @@ int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
>         return err;
>  }
>
> -void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
> +static void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
>                       int err)
>  {
>         if (host->ops && host->ops->unprep_data)
> @@ -487,7 +487,7 @@ void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
>         data->host_cookie = 0;
>  }
>
> -void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
> +static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
>
> @@ -495,7 +495,7 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>                 host->ops->get_next_data(host, data);
>  }
>
> -int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
> +static int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
>  {
>         struct mmc_data *data = host->data;
>         int ret;
> @@ -530,7 +530,7 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
>         return 0;
>  }
>
> -void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
> +static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>  {
>         if (!host->use_dma)
>                 return;
> @@ -539,7 +539,7 @@ void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>                 host->ops->dma_finalize(host, data);
>  }
>
> -void mmci_dma_error(struct mmci_host *host)
> +static void mmci_dma_error(struct mmci_host *host)
>  {
>         if (!host->use_dma)
>                 return;
> @@ -948,12 +948,12 @@ static struct mmci_host_ops mmci_variant_ops = {
>  };
>  #endif
>
> -void mmci_variant_init(struct mmci_host *host)
> +static void mmci_variant_init(struct mmci_host *host)
>  {
>         host->ops = &mmci_variant_ops;
>  }
>
> -void ux500v2_variant_init(struct mmci_host *host)
> +static void ux500v2_variant_init(struct mmci_host *host)
>  {
>         host->ops = &mmci_variant_ops;
>         host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
> --
> 2.23.0
>
