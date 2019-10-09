Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA9D0AAC
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfJIJNG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:13:06 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44256 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfJIJNG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2019 05:13:06 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so1011061vsw.11
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2019 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czvwlzjYxEI9/u0IXNcmOe4QZHiW6rPzIFMH9Q1LDCk=;
        b=Qc2Deu0jcIu8UninSS/S0zk70x0bqBdhAd0yfA7qBpIuezQeZhtsCMTgl2oQe67acx
         u4wk111JrrgX/Jufsar0klMlx/zh57vz5Os14hIVrppTBRjeDz1m/qPp14Igo/yautTp
         5Yp2IuccCgRDP8J+M/yEawZoabNWJj43fHG3X77q630c9m3abY5NfhVAsc6wFldOdZ0s
         URDbnfkIgbDn2cMwtKsMIazie7O3cxvzTzVpMxvAs2ppmr3oy88BoEjddyECLhglvj7O
         8MikkaTtXlf/pIq8kNTiyPvhLgkdFMroK2tRyngXNEVw+M8Nbi4i+K5qvBjvoqJ3g0Ud
         N/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czvwlzjYxEI9/u0IXNcmOe4QZHiW6rPzIFMH9Q1LDCk=;
        b=apz30wQcoCGR13rrqyCo6Of4yFMtGDo6HkNVEg+7mDvtW/oXTkR3wJI90T4P+A9mdQ
         XIiejfvu6+FTFaIOcyN4c21AauezCYQlPcAQe7N4NIw/I/TDm4NZwOYT4q1SPCY9HPyF
         cG/z8aOoW2BIhMbT+sDBw58fjVUuI7AIfZnpXUbTI6Fl3eq2sK4zILGy/vlNhmqQFHyA
         OxBz2Xs0JJaJRwE4f0ay+Ishi66j1HfFGo71fOR/nXydj8eWIUrGb+g3bZwxSqAlkEPZ
         o6OS0fSubrCW1rZM4cOAmPkmHCCJn3ccKNf5zXzMEAB2tyrg3iUchW1sUE/bYaI/GlUM
         s2aQ==
X-Gm-Message-State: APjAAAU4Df94EwHw8kK6m9lXQ4k7joA8oPJY1sh/itWuWcfS0YqumsvV
        M6SEGRY53kDjB5K2OUtN4Zircr2tln6Jx+pRcUytvg==
X-Google-Smtp-Source: APXvYqzP3FVres/j/D8kUEjQC+HXZ/OT5WzktimrnRbXf6/XBUuevqgnd5AQdUIZ6APOTW+/Qh/g5LVfGjLDkHD8OAw=
X-Received: by 2002:a67:ef89:: with SMTP id r9mr1243756vsp.200.1570612385264;
 Wed, 09 Oct 2019 02:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191004134452.6493-1-nsaenzjulienne@suse.de>
In-Reply-To: <20191004134452.6493-1-nsaenzjulienne@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:29 +0200
Message-ID: <CAPDyKFpprt9TVP2Ywu2urqy6zB_H7Xrbo=N6OGp6-O6Qk7rLPw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-iproc: fix spurious interrupts on
 Multiblock reads with bcm2711
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Oct 2019 at 15:45, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The Raspberry Pi 4 SDHCI hardware seems to automatically issue CMD12
> after multiblock reads even when ACMD12 is disabled. This triggers
> spurious interrupts after the data transfer is done with the following
> message:
>
>   mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
>   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>   mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
>   mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>   mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>   mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>   mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
>   mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00080008
>   mmc1: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x00edc87f
>   mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
>   mmc1: sdhci: Host ctl2: 0x00000001
>   mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf3025208
>   mmc1: sdhci: ============================================
>
> Enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable ACMD12 on multiblock
> reads and suppress the spurious interrupts.
>
> Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Acked-by: Stefan Wahren <wahrenst@gmx.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
> - Add Fixes tag and Acked-by
>
>  drivers/mmc/host/sdhci-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 2b9cdcd1dd9d..f4f5f0a70cda 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -262,6 +262,7 @@ static const struct sdhci_iproc_data bcm2835_data = {
>  };
>
>  static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> +       .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>         .ops = &sdhci_iproc_32only_ops,
>  };
>
> --
> 2.23.0
>
