Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65AC9B82
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJCKB4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:01:56 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41538 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfJCKB4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:01:56 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so1270755vsr.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQZgMiPBlch+da9eCpuVvMh7cDd98498ZGUQ3xlwUWM=;
        b=FuER+l0gj2hl/fxpTFxvQ3nYlHiIWdyz8MM9HC+XQxx5GTIH0AH9LvMxKjOxn40Vro
         o+KyzVClab/FiyZjLNkL5uvla+jp3D7dYdVVtEYEy44JiAKab3nvxz4nJd6Ys5vh0SUy
         royoVNCuLwNLyUgLj8W8Kuh10mXwzsJo9jNwQvoyIDXn2nmCgvO3lybBQKlhuooIgcTk
         MTwDkH6MQUPFv7fjj6JIj4n7fE/l+oVA44YgZLiT1EaCIAO6iROTdyF8i9qsSVZy9x6O
         L44zkMJjvgyat95nf/WiY2dPlBJluv73B32vxzs2rYOxLxVvrEFQWW3MjOncsHTUgB4g
         T4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQZgMiPBlch+da9eCpuVvMh7cDd98498ZGUQ3xlwUWM=;
        b=bZrFdQEs733N22KjWL/pVlUJVx3c9Yvm/jYnGD4jtHoafhEdA7D+vcSctuBWJOtuWG
         NI+AIdT5WmMoH7sMElsHyTqJn2pF1LSq2CLOxN+D/j3wnL1cFdNnLN0TNne3/wW79rii
         uh17gpgWSBLcY9c5MxPMcIdKDnYP0UsTKwQZcbaNTvBLBKFBvGfmmA11fxWnskQ0z9ec
         FTtO6GgExoiv9J3ARCSSGOvT4VE6WnDDgqROzKIC1vIZ8qsUSlEFHAWIpmft5ReWv/2X
         yfkQJzm9GCc6kD4Qfu2Lxj10WPrZpVksf+9f7pmgqixljIWD92azMrRH/rJ04z7Kq1V+
         Wyig==
X-Gm-Message-State: APjAAAVrvrgrCSSrV1sUoUNOLMZ+pcLFsKsPYc0W4XguZfrSUJxOyZ5b
        3UTrlxSUZg0WYgCOx7Zr+JoSzqhSzUOqaV30OGsWpTuc
X-Google-Smtp-Source: APXvYqzuSKcUmTZ9N2NNO3rEXGfkm5tGlVKGyINBteWvalYdV0+g5zqRsur4hFkbU0QLK6GOzgBpgwJYcfHAKQXzTWE=
X-Received: by 2002:a67:e414:: with SMTP id d20mr4534032vsf.191.1570096914812;
 Thu, 03 Oct 2019 03:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:18 +0200
Message-ID: <CAPDyKFqsZ1mZ53b9wLruATzi+ymFrUCLhxzx7NFUq48p5w0Gtw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add SD/MMC driver for Actions Semi S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds SD/MMC driver for Actions Semi S900 SoC from Owl
> family SoCs. There are 4 SD/MMC controller present in this SoC but
> only 2 are enabled currently for Bubblegum96 board to access uSD and
> onboard eMMC. SDIO support for this driver is not currently implemented.
>
> Note: Currently, driver uses 2 completion mechanisms for maintaining
> the coherency between SDC and DMA interrupts and I know that it is not
> efficient. Hence, I'd like to hear any suggestions for reimplementing
> the logic if anyone has.
>
> With this driver, this patchset also fixes one clk driver issue and enables
> the Actions Semi platform in ARM64 defconfig.
>
> Thanks,
> Mani
>
> Changes in v4:
>
> * Incorporated review comments from Rob on dt binding
>
> Changes in v3:
>
> * Incorporated a review comment from Andreas on board dts patch
> * Modified the MAINTAINERS entry for devicetree YAML binding
>
> Changes in v2:
>
> * Converted the devicetree bindings to YAML
> * Misc changes to bubblegum devicetree as per the review from Andreas
> * Dropped the read/write wrappers and renamed all functions to use owl-
>   prefix as per the review from Ulf
> * Renamed clk_val_best to owl_clk_val_best and added Reviewed-by tag
>   from Stephen
>
> Manivannan Sadhasivam (7):
>   clk: actions: Fix factor clk struct member access
>   dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
>   arm64: dts: actions: Add MMC controller support for S900
>   arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
>   mmc: Add Actions Semi Owl SoCs SD/MMC driver
>   MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
>   arm64: configs: Enable Actions Semi platform in defconfig
>
>  .../devicetree/bindings/mmc/owl-mmc.yaml      |  59 ++
>  MAINTAINERS                                   |   2 +
>  .../boot/dts/actions/s900-bubblegum-96.dts    |  62 ++
>  arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/actions/owl-factor.c              |   7 +-
>  drivers/mmc/host/Kconfig                      |   8 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
>  9 files changed, 877 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>  create mode 100644 drivers/mmc/host/owl-mmc.c
>
> --
> 2.17.1
>

I have picked up the mmc patches for next and as Stephen picked the
clock patch, the rest are now for arm-soc, I guess!?

Kind regards
Uffe
