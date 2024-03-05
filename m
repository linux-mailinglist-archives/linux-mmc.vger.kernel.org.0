Return-Path: <linux-mmc+bounces-1285-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F4871ECF
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Mar 2024 13:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7CEB23B05
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Mar 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA445B676;
	Tue,  5 Mar 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM/up9g3"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF65B67A
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640919; cv=none; b=BtQaI87y2mZXL+/hd226QpxDnEhQF8SZJ56aJRbwEsBmWLB3pACOlqn8vD4fIW11QJ+TmYgX2CRrmq9VQ1K3VrGHUnPTvhHra14xNjJKcpX252SRmXJsxaZQifed6CwUXvhscxnDOCarmsRLJ0NDL94dVSo+6jjhRaEgRAZxVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640919; c=relaxed/simple;
	bh=j/mszeX9ORsz5fjWmkU/e3unjh7kWHFSsDaC36s4PtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE03pa1LgxiFym5UY+HV3lZ4u4AHy1sD1pIstgC59LUzbeCFl5gmnKi7oas8ECbsH8QpfT7W8+58yE/+VCpaFx42kz266Ka8X+Fxbpe+ZWSGgXUWWKIdtJDgA84Sk3XnUSCzStytl1MIuvK4AD0rURRpPUWY+YqHT3P8T5geC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OM/up9g3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso573477276.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640916; x=1710245716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3k9Q26KqpXO2O4o4Z5OcECU0fKN3tYgMC1M4NBA6YU=;
        b=OM/up9g3t+SoYuCP8FfYxRHxJ9UP5pi75lJXhvO7s8A0rVtR1AaxtlT+bM5yKeqN2G
         8SbFfoF1nj7EH8R1TH0PZ5eIwty3Fg2oJAzoA1Mbg6PyoCVsOnmdsHWiGFLRNRcPLA1x
         vgBraekTYFiTYkFZ/7NCz61h07JmQncRDSls4nH+oiqVMpKK8p1ce8HzBSiFtD0fs03e
         ohuP8U0AszrQf+1by0nMUJfGfpPSy3pVqvutCr8N/oCi613s9FJCICLNohPV4SIMV2jP
         h0l6eXSwYmNY3j9Xt8boLBY48Tc5XClfrm5HAqBvQSof/nVE758WMZAnVTWB/RgH5PC/
         9erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640916; x=1710245716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3k9Q26KqpXO2O4o4Z5OcECU0fKN3tYgMC1M4NBA6YU=;
        b=ApEOH5oKL6uPBl/l4wV3mUZ8S8f1AWJgQy+y/ofkU7/xCpCk7VVor2lXms4oIeiCJ5
         DPeSQA8KWf6yI1UaDkHuEGfGwWZyD0BNoZ1bguxvxvmnaL/vDPLv9qH5F0911bYKO6Ag
         H1rFfY7dCsM01XHegejm0/26YBISewu8N6HeZTP17zr9v5eHzoptbDOVK6cio2/gJo4w
         ck2ksZYMRE0tGA1ad4mmafaiu1YEE0PZBG00fcG61ayrl7RxXyUau2cdTvKQ1tiljowJ
         FCW0k37JGIUZdrHI3SiBQJxI5wdWIBKX4E9V/ERSo409YzeLZA45HRzAy7mcSXIBOsOa
         INFw==
X-Gm-Message-State: AOJu0YwwvqCBAa0U8VeiuSo0jcfTocIidzWBuh0kHYNhX6njFecwPa9C
	dBaTFhH5WP+iub0cAXz8eNEVQO1Zfk7rLn27UvKI0w0QAt5otyBhHq7Uo0HUwueImxm1Lc347sm
	Me4QyeGhN4LvRU90INB/XYVxMuXWMYCPeBgbmHg==
X-Google-Smtp-Source: AGHT+IGk4eFIk1xSfMQIxCe96ENwj5QOTBbRvnLLzOU6KKjmzrvHuoZFf6okRbCguchxev/n93wBqmdvrMcNJ8Okst0=
X-Received: by 2002:a5b:a43:0:b0:dc6:b617:a28c with SMTP id
 z3-20020a5b0a43000000b00dc6b617a28cmr9333881ybq.5.1709640916589; Tue, 05 Mar
 2024 04:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304184830.1319526-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304184830.1319526-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:40 +0100
Message-ID: <CAPDyKFoToK_BUeMyDMB-HDJPKYWdi1TiQVwE6mNSQshUFQDLKw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: Don't mention DMA direction
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 19:48, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since driver doesn't handle any DMA requests, drop any use of DMA bits,
> such as DMA direction. Instead, use MMC_DATA_WRITE flag directly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b8dda8160c4e..922275de0593 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/bio.h>
> -#include <linux/dma-direction.h>
>  #include <linux/crc7.h>
>  #include <linux/crc-itu-t.h>
>  #include <linux/scatterlist.h>
> @@ -510,10 +509,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>   * so we explicitly initialize it to all ones on RX paths.
>   */
>  static void
> -mmc_spi_setup_data_message(
> -       struct mmc_spi_host     *host,
> -       bool                    multiple,
> -       enum dma_data_direction direction)
> +mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
>  {
>         struct spi_transfer     *t;
>         struct scratch          *scratch = host->data;
> @@ -523,7 +519,7 @@ mmc_spi_setup_data_message(
>         /* for reads, readblock() skips 0xff bytes before finding
>          * the token; for writes, this transfer issues that token.
>          */
> -       if (direction == DMA_TO_DEVICE) {
> +       if (write) {
>                 t = &host->token;
>                 memset(t, 0, sizeof(*t));
>                 t->len = 1;
> @@ -547,7 +543,7 @@ mmc_spi_setup_data_message(
>         t = &host->crc;
>         memset(t, 0, sizeof(*t));
>         t->len = 2;
> -       if (direction == DMA_TO_DEVICE) {
> +       if (write) {
>                 /* the actual CRC may get written later */
>                 t->tx_buf = &scratch->crc_val;
>         } else {
> @@ -570,10 +566,10 @@ mmc_spi_setup_data_message(
>          * the next token (next data block, or STOP_TRAN).  We can try to
>          * minimize I/O ops by using a single read to collect end-of-busy.
>          */
> -       if (multiple || direction == DMA_TO_DEVICE) {
> +       if (multiple || write) {
>                 t = &host->early_status;
>                 memset(t, 0, sizeof(*t));
> -               t->len = (direction == DMA_TO_DEVICE) ? sizeof(scratch->status) : 1;
> +               t->len = write ? sizeof(scratch->status) : 1;
>                 t->tx_buf = host->ones;
>                 t->rx_buf = scratch->status;
>                 t->cs_change = 1;
> @@ -777,15 +773,15 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>  {
>         struct spi_device       *spi = host->spi;
>         struct spi_transfer     *t;
> -       enum dma_data_direction direction = mmc_get_dma_dir(data);
>         struct scatterlist      *sg;
>         unsigned                n_sg;
>         bool                    multiple = (data->blocks > 1);
> -       const char              *write_or_read = (direction == DMA_TO_DEVICE) ? "write" : "read";
> +       bool                    write = (data->flags & MMC_DATA_WRITE);
> +       const char              *write_or_read = write ? "write" : "read";
>         u32                     clock_rate;
>         unsigned long           timeout;
>
> -       mmc_spi_setup_data_message(host, multiple, direction);
> +       mmc_spi_setup_data_message(host, multiple, write);
>         t = &host->t;
>
>         if (t->speed_hz)
> @@ -807,7 +803,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>
>                 /* allow pio too; we don't allow highmem */
>                 kmap_addr = kmap(sg_page(sg));
> -               if (direction == DMA_TO_DEVICE)
> +               if (write)
>                         t->tx_buf = kmap_addr + sg->offset;
>                 else
>                         t->rx_buf = kmap_addr + sg->offset;
> @@ -818,7 +814,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>
>                         dev_dbg(&spi->dev, "    %s block, %d bytes\n", write_or_read, t->len);
>
> -                       if (direction == DMA_TO_DEVICE)
> +                       if (write)
>                                 status = mmc_spi_writeblock(host, t, timeout);
>                         else
>                                 status = mmc_spi_readblock(host, t, timeout);
> @@ -833,7 +829,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 }
>
>                 /* discard mappings */
> -               if (direction == DMA_FROM_DEVICE)
> +               if (write)
> +                       /* nothing to do */;
> +               else
>                         flush_dcache_page(sg_page(sg));
>                 kunmap(sg_page(sg));
>
> @@ -850,7 +848,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>          * that can affect the STOP_TRAN logic.   Complete (and current)
>          * MMC specs should sort that out before Linux starts using CMD23.
>          */
> -       if (direction == DMA_TO_DEVICE && multiple) {
> +       if (write && multiple) {
>                 struct scratch  *scratch = host->data;
>                 int             tmp;
>                 const unsigned  statlen = sizeof(scratch->status);
> --
> 2.43.0.rc1.1.gbec44491f096
>

