Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29448DF0AB
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUO7t (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 10:59:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41019 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJUO7t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 10:59:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id l13so3885978uap.8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQEMzZ3n9HZGBVGN9SO76x64fTpC/nzRkT+q4TdyARE=;
        b=YwpD2tlOXEpFV0G2oPpmEUBq0eGPZxEyQvbg0Ij+S7eUl/o1VWXxdjZCtbD3GtOmGJ
         XQxPjqGl84eW26nD6MqIyMFyXJ+JGDHSOXytEpKkJ4yfGGXGb/O1X1sNnooGJrcVpRSn
         cgZZsx1hTzCItMGjYjs2oJKbl3Ns6cpGep20mXta9VJ4IIKv8QrlbajnxvnVeEWuEI4v
         0tlV3nmgqmTa9BMufNh5qsiRTSA79CcPRZtjUgFWkg5OBmtuthxvUcy3phm9NkDd9UZU
         2k0lWC3vQboogfErXaUcTwHHzL3OP9Y++fpxA2M7GL2zsczZSwGHVO6UHeJ3BT6vVi1W
         xu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQEMzZ3n9HZGBVGN9SO76x64fTpC/nzRkT+q4TdyARE=;
        b=IwedF7IQrZKoWw5sCpZ+ajMsD2/TRTb6l9VPn0fJbWBUHBOBAbfkGg+DloHS9m8wnO
         5bZkYaIuugEfPvtyWvcDANHRZCyKJBaMRaDt3yxOnELEsQGPop1ieiu1GfkSd7WRbjJd
         d00ffUnoN/81yVqIuGSw/sEkbQ7+bmDcajJcxr9zo3O758g0BJZeU5qAxVTUHmgEVOOm
         qH2jJBzD034iTyCp+bKY8kHuYYb7Q+jhDQACqv/UEn4UowtyySYspNEPk0/wpMV95/l1
         /oM1DvDMedkANlkB4cMBMfcXI23NsywK1XOiXtRS+KGGG73R9SUbRTB1gv6UAc/M673s
         r4hg==
X-Gm-Message-State: APjAAAX6vFMvhTpryuZz8I9HVJmSIi4GSSh+jlDPGkKbCJ0H7nLINbRw
        BbXsO10J7wc3xXA6xM0mPIGWHgaxHa/IM6DcDTS+2Q==
X-Google-Smtp-Source: APXvYqwnixcjjN0hTjPTgM8HUTjEJfsmWob9as5b1hcMrBpF54oMkgriOisnDJXO5PLMwuSGBM2NvnsyU6AObb8y6UA=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr6111832uao.104.1571669988369;
 Mon, 21 Oct 2019 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191018093934.29695-1-s.hauer@pengutronix.de>
In-Reply-To: <20191018093934.29695-1-s.hauer@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 16:59:12 +0200
Message-ID: <CAPDyKFo7-rb3285L9XpCi_eAE=RqfuKaz-njEWQjGYzfCoSLwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Oct 2019 at 11:39, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
> driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
> changed all users to this flag though. This patch fixes it for the
> mxs-mmc driver.
>
> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Reported-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 78e7e350655c..4031217d21c3 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma/mxs-dma.h>
>  #include <linux/highmem.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -266,7 +267,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
>         ssp->ssp_pio_words[2] = cmd1;
>         ssp->dma_dir = DMA_NONE;
>         ssp->slave_dirn = DMA_TRANS_NONE;
> -       desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> @@ -311,7 +312,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
>         ssp->ssp_pio_words[2] = cmd1;
>         ssp->dma_dir = DMA_NONE;
>         ssp->slave_dirn = DMA_TRANS_NONE;
> -       desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> @@ -441,7 +442,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
>         host->data = data;
>         ssp->dma_dir = dma_data_dir;
>         ssp->slave_dirn = slave_dirn;
> -       desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> --
> 2.23.0
>
