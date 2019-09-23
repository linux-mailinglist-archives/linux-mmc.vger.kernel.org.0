Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6339BBE2A
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390757AbfIWVzZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 17:55:25 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44891 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfIWVzZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 17:55:25 -0400
Received: by mail-ua1-f65.google.com with SMTP id n2so4850893ual.11
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2019 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBT3Db6V0RCdk9MkaZmhWBxtvLD/Af76jFo64HoOBeI=;
        b=benxuRmzmLFhm7xj36+4hmpIGybL1LCdEOGcPPfa1Mka2sx96iD+2mxpNHHysxhkDM
         cTJsvAMlfXj632f0S78RwsA8bDKmv7rOxXgZznA7fgkoxxS9RcBZpsTAdR0+W133HdV8
         Y0JVlLtmYD7AywL1q2kPMe+sYcxHlCx3lOG3kendDo2V6VtlajezRBpooZ8saYHzgLjq
         qL3chwtLuyTQyPFZi572OgqB6MbvUwgY63EcB04CmCZiEp/W5clAy125j7XPikyAd53G
         Q0UY+gOLDbxHA7fovUHK4unByY+KDim/qagaz2r7TmldtX9BOmXzjY4qs9ZEBSfcSMTz
         VIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBT3Db6V0RCdk9MkaZmhWBxtvLD/Af76jFo64HoOBeI=;
        b=K5/ZahV5ruNm/p2y75/MvcLJqevbrPAzFruz2wo701LCIKQDnaTygQHsHCuAl3qoCg
         aI6Qn/pi4r4bbTAhKuiozJ1IlIrKY3LGrGon0zWnnBQFGGR18hjAeSRewQzs9Cy5Zu0r
         Cu64tlC2na8Kdrmm6c5sJKA/euFX5fl8xFr5mdy3lP/JgL3z/3w0yVEpAVBFdF35xlL8
         vLJaIkL/i55lIgtEC2QJluy/oaGXpcg9mYw7x1of46yer05xZHIGFMc2FtHW++bSQhvz
         S72jXbDWK5nhRdyMUlGLvNNKM8WLNUhOrtIfiwVEqKXf5CAViAo7+7qrtN4sLryGxTZA
         BWng==
X-Gm-Message-State: APjAAAUo1rG+VeA/o28mhpdk/rpSIWh7Kq5OlugxhX1idw5EPUI5Mho4
        AaB3EITd7eFtVE1VjSjNmgfZEzzCmMxva+KcBuOPmA==
X-Google-Smtp-Source: APXvYqxSlTkjicQD/SBCB1YP5+6EQVvpPwLYkYHSNKsYS/EHuKQ4u7NN2WARz8V/OrSNN+DdfdRUCFaF/GXcdojUQFk=
X-Received: by 2002:ab0:3113:: with SMTP id e19mr390086ual.129.1569275722401;
 Mon, 23 Sep 2019 14:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190922102341.GO25745@shell.armlinux.org.uk> <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Sep 2019 23:54:46 +0200
Message-ID: <CAPDyKFqmO3aRPzN2Wctx9Ww5w_YBbcjJqMHeasQAHb97Dwar0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: improve ADMA error reporting
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 22 Sep 2019 at 12:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> ADMA errors are potentially data corrupting events; although we print
> the register state, we do not usefully print the ADMA descriptors.
> Worse than that, we print them by referencing their virtual address
> which is meaningless when the register state gives us the DMA address
> of the failing descriptor.
>
> Print the ADMA descriptors giving their DMA addresses rather than their
> virtual addresses, and print them using SDHCI_DUMP() rather than DBG().
>
> We also do not show the correct value of the interrupt status register;
> the register dump shows the current value, after we have cleared the
> pending interrupts we are going to service.  What is more useful is to
> print the interrupts that _were_ pending at the time the ADMA error was
> encountered.  Fix that too.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This seems useful to land for 5.4, so I have queued this up via my fixes branch.

Perhaps we should also tag this for stable, what do you think?

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..0f33097c55ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2855,6 +2855,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  static void sdhci_adma_show_error(struct sdhci_host *host)
>  {
>         void *desc = host->adma_table;
> +       dma_addr_t dma = host->adma_addr;
>
>         sdhci_dumpregs(host);
>
> @@ -2862,18 +2863,21 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>                 struct sdhci_adma2_64_desc *dma_desc = desc;
>
>                 if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                       DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> -                           desc, le32_to_cpu(dma_desc->addr_hi),
> +                       SDHCI_DUMP("%08llx: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> +                           (unsigned long long)dma,
> +                           le32_to_cpu(dma_desc->addr_hi),
>                             le32_to_cpu(dma_desc->addr_lo),
>                             le16_to_cpu(dma_desc->len),
>                             le16_to_cpu(dma_desc->cmd));
>                 else
> -                       DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> -                           desc, le32_to_cpu(dma_desc->addr_lo),
> +                       SDHCI_DUMP("%08llx: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> +                           (unsigned long long)dma,
> +                           le32_to_cpu(dma_desc->addr_lo),
>                             le16_to_cpu(dma_desc->len),
>                             le16_to_cpu(dma_desc->cmd));
>
>                 desc += host->desc_sz;
> +               dma += host->desc_sz;
>
>                 if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
>                         break;
> @@ -2949,7 +2953,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>                         != MMC_BUS_TEST_R)
>                 host->data->error = -EILSEQ;
>         else if (intmask & SDHCI_INT_ADMA_ERROR) {
> -               pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
> +               pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
> +                      intmask);
>                 sdhci_adma_show_error(host);
>                 host->data->error = -EIO;
>                 if (host->ops->adma_workaround)
> --
> 2.7.4
>
