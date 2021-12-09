Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462B846E622
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Dec 2021 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhLIKJi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Dec 2021 05:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhLIKJg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2021 05:09:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F15C0617A1
        for <linux-mmc@vger.kernel.org>; Thu,  9 Dec 2021 02:06:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 207so8106506ljf.10
        for <linux-mmc@vger.kernel.org>; Thu, 09 Dec 2021 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7n6FDX6H8P+X6R9kI/h8zvoHlnpjQBFH0K4aMAQsY4U=;
        b=vy3zy5ecThEmjJwBH4wP5aOWzJuoYC13mpIb5IaHd+yPGDJoqNe/ZoV7btijS5Z1dR
         GT15ZAYTW+6JcFDGE3sMH8+fyJv8DEMrqRKU7F9aqsM0wJ+TN1Sq0M0B6uBhSqJzzNNT
         GNOlkwE2ljRjXAqhA33pZOkesK9leJSgoaFAlakv4YKo7kln3tszZdQHp7Eu6UAaqEBN
         qzyfTR4RfuFMW1l8BGYZRW85dGtOKOavDbg3ByQu/tYNU62OYkBLRBBc+wkWCEKQC+DC
         qsAV2jOSDmnEQn8jlEi6QNxQU6D9uGfmZ5Z+zooltUkKWZ2CzkP54Di+raFLeYoKD6qU
         GZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7n6FDX6H8P+X6R9kI/h8zvoHlnpjQBFH0K4aMAQsY4U=;
        b=DpcdfHac2XUnmvu9+GocdtpFcKrjvpkteVNXKSxgYoDXrMUpnqT3pDqLySOOdZ085+
         OTO82f6lWHNt8VoY3blJBN5+Q2vViepeQDriby+ngUMv8nsE9H6S2v5TZrrmMoWyuPX4
         k8RkgWjJVd4GZOMZ79RCQe9kBsiIKgisBKA+RZeGxNLldSufdJzyeI9TyMLAMcq269vf
         vslpju5T+W5FTaRz+DVU89c+iVDCRmhxhGPfb5OCyVyaJjQAmfN2UEy33/1SFzxraLV2
         KuFLZV+fXUK8q0NwNYUDcmqdekcdbhfuCsbjThoVFDwWU3Qwxko9QGCBK8coz5jajLRb
         USyg==
X-Gm-Message-State: AOAM530MYWdHroFWaOT3oWVkZd0SpGNnJg2CZRVGjkNdggOnO3bq46mJ
        7In9QXJ+msR1DOL3MeuBve6kL+93sJRzEHRHkLe/eA==
X-Google-Smtp-Source: ABdhPJz0ilXt6W1+8bbBuz/OhSyvln6ct+a5k5j2QKYy7+TMvRWzx1l6Z7G5OJAd5TQwwoVT4vOxB5o4lmjVY2/UZC8=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr5126865ljn.463.1639044361794;
 Thu, 09 Dec 2021 02:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com> <20211206115218.73874-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211206115218.73874-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:25 +0100
Message-ID: <CAPDyKFrHqZxafeP=HMnKTHKWk4f-eC59aViVP=Lu71La_aYD1g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: mmc_spi: Use write_or_read temporary variable
 in mmc_spi_data_do()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 6 Dec 2021 at 12:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use write_or_read temporary variable in mmc_spi_data_do() to deduplicate
> the conditional code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 4b0f9035ad29..a576181e9db0 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -859,14 +859,14 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         struct spi_device       *spi = host->spi;
>         struct device           *dma_dev = host->dma_dev;
>         struct spi_transfer     *t;
> -       enum dma_data_direction direction;
> +       enum dma_data_direction direction = mmc_get_dma_dir(data);
>         struct scatterlist      *sg;
>         unsigned                n_sg;
>         bool                    multiple = (data->blocks > 1);
> +       const char              *write_or_read = (direction == DMA_TO_DEVICE) ? "write" : "read";
>         u32                     clock_rate;
>         unsigned long           timeout;
>
> -       direction = mmc_get_dma_dir(data);
>         mmc_spi_setup_data_message(host, multiple, direction);
>         t = &host->t;
>
> @@ -921,9 +921,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 while (length) {
>                         t->len = min(length, blk_size);
>
> -                       dev_dbg(&host->spi->dev, "    %s block, %d bytes\n",
> -                               (direction == DMA_TO_DEVICE) ? "write" : "read",
> -                               t->len);
> +                       dev_dbg(&spi->dev, "    %s block, %d bytes\n", write_or_read, t->len);
>
>                         if (direction == DMA_TO_DEVICE)
>                                 status = mmc_spi_writeblock(host, t, timeout);
> @@ -948,9 +946,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>
>                 if (status < 0) {
>                         data->error = status;
> -                       dev_dbg(&spi->dev, "%s status %d\n",
> -                               (direction == DMA_TO_DEVICE) ? "write" : "read",
> -                               status);
> +                       dev_dbg(&spi->dev, "%s status %d\n", write_or_read, status);
>                         break;
>                 }
>         }
> --
> 2.33.0
>
