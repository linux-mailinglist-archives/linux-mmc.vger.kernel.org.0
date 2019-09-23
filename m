Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28AFBBE2B
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390761AbfIWVzb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 17:55:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37593 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfIWVzb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 17:55:31 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so4874925uaj.4
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2019 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8HE0xxgJIdBygBr0LPfHnPWj798ffNarvcJbPJ7Ow0=;
        b=L/X0zWW2HLVUwUk7XKX2JM3b2Rdh6Nld8BblfE4zqSe+TwYwq4CNgYyAF7iKJaWNKe
         fwkKSjQfdbcwaC/XdwVEOAtw8x1BjKbvVwZkGHFlWYMaLG0PBmhrDrD0dRZn6MGxRiM3
         dcbJdPJ/7Kiqwl2YGXmOI6xvrDSw2ZkdGHoaFDLrCi+/lQu3NSaeCZBcu3WamRBnK3SG
         loToV0kTCcq2Y5NZIbMJFfwpv+65fVZhJ5c5g5ariBGNhG37TCadTY0JoZorV0WDwiMp
         GqJ+7ECwgSJhsylsqWOzV3FkRB4Ulaqq1nwh7b9kLrRpANSvlL59jkoB52E37iDgBGYz
         AcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8HE0xxgJIdBygBr0LPfHnPWj798ffNarvcJbPJ7Ow0=;
        b=qDfs6W56wbGF2c96GJ1pVRCOLzZZ2q4dFGFp8tHiB3dOYSCvd9P2ygpC56q90bUcD4
         ii2G+o00bOhqhzzd6XcWJbW3ApwtfX6XaHt13HYympd/lU7t2J6C8C0Gr7a8yX6pglSP
         vyLO67RPOJJKfiOahZA5ogeEFmihkMAFnbwyJot2wMLRu0Vit7Tfbcarwt2UC8J9TsNu
         tqqvKJ5J9vSuqF7bXIJ3DSQEdeDLLAYMBCOeQmbne/ZpuxyhQDPqv/Kn8G9ARr4t0Om7
         xWTkq2BNBR4GMZEHv1c8vwydaYUeV0zbDtYEjU+goig9MvqeY66BFj+9BP+iUunRFdAs
         /O9A==
X-Gm-Message-State: APjAAAXia7ACDm/3/MVmRD/p7uxrIhDNbesgBqODotFtQoP2KIslwKSC
        MDQvz23H1Ot89lN9AROKkog9Pn6P2tasXeC0WhcPzg==
X-Google-Smtp-Source: APXvYqwNAJfeaQHbBbihzaYwIQbFiFZyrr2MKWfGo/FSzwOeexwJrdKxpdRPjEVAv2pO08DQUhRn2dZGuw8Gohde1CU=
X-Received: by 2002:ab0:3098:: with SMTP id h24mr924785ual.100.1569275730470;
 Mon, 23 Sep 2019 14:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190922102341.GO25745@shell.armlinux.org.uk> <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Sep 2019 23:54:54 +0200
Message-ID: <CAPDyKFrnPpkWoRob+9FUYromqepXPtiC1pM_sgUx2Mfz-PPvWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA coherence
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
> We must not unconditionally set the DMA snoop bit; if the DMA API is
> assuming that the device is not DMA coherent, and the device snoops the
> CPU caches, the device can see stale cache lines brought in by
> speculative prefetch.
>
> This leads to the device seeing stale data, potentially resulting in
> corrupted data transfers.  Commonly, this results in a descriptor fetch
> error such as:
>
> mmc0: ADMA error
> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> mmc0: sdhci: Host ctl2: 0x00000000
> mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> mmc0: sdhci: ============================================
> mmc0: error -5 whilst initialising SD card
>
> but can lead to other errors, and potentially direct the SDHCI
> controller to read/write data to other memory locations (e.g. if a valid
> descriptor is visible to the device in a stale cache line.)
>
> Fix this by ensuring that the DMA snoop bit corresponds with the
> behaviour of the DMA API.  Since the driver currently only supports DT,
> use of_dma_is_coherent().  Note that device_get_dma_attr() can not be
> used as that risks re-introducing this bug if/when the driver is
> converted to ACPI.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied for fixes and taged for stable, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4dd43b1adf2c..74de5e8c45c8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -495,7 +495,12 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
>                 dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>
>         value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> -       value |= ESDHC_DMA_SNOOP;
> +
> +       if (of_dma_is_coherent(dev->of_node))
> +               value |= ESDHC_DMA_SNOOP;
> +       else
> +               value &= ~ESDHC_DMA_SNOOP;
> +
>         sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
>         return 0;
>  }
> --
> 2.7.4
>
