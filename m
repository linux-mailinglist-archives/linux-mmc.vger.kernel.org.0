Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D659C9B76
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfJCKBl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:01:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36331 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfJCKBk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:01:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id v19so1293161vsv.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B+E5RivcC5owz7oFA9AYi1iwjoiCE7P7xcMi6UgLa0=;
        b=hq/EKDlVT66/mmZ8X58aU7DGkBtQoN38XbVyMTmedpHFhNBWSXRua2vJ8cs7mp0mXW
         TuFkXknq5YLy2qnKHYeEUDrqQg4f9De83VAASuIknveh1oV7kMa+kUGD6Pjh5Mf+l3ai
         0yG+gbXTjTu+xTj2AHaNQ54Ga5TBXI9v7l4CGR0xH23+KFgFwUzqN3EopiOH0ws4wrge
         lfigp/bs/NBuqwTWgcnwhrmB2VydJvzv9MXxC7OzhNL0JEdwf241/HE7pusy+9qgoWQP
         zOgNV8kWFOmDsqTzeSHfQkTbZ/B0NkUO/ywFMB0Lwoi3daYmW1bZGkXDEMJ3lm7jLZZ0
         vIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B+E5RivcC5owz7oFA9AYi1iwjoiCE7P7xcMi6UgLa0=;
        b=oO02l1EKos546EN9lXG7bTQEevqqsuJoQXMIeTQyIJBmC2uZUgsJjBV0mAmE1jW+LI
         rEjKr9KaLIdRBbrNNc0KgPiHUcIQAJeFEQReEqowLRVK03tjtx0apkP8d9Uyql+Rz6MD
         Tkq59aPux9pa/CMfUTh8mOgTgK35sM0qEJUa+aRf4quagOGpuRqm+gW2YE4YaQJT5dSr
         PPr26iEMjVALx5UxsHdgtJMPRik0CTfgmaAobA17OFhLWtLORoC4/VnpO3TVEvvvy4BO
         M/hf2jyRiTV/EPhGpvuPl1JdqI9rQTPxlohMY2dfpksfNw1R2dk0b8orMVWH5FCv1z9g
         Hlbg==
X-Gm-Message-State: APjAAAXubDDR9Nwi8mCNYUBQSfRuRIr9toUaLmwptP5CXiOy6YnSSY4K
        ml1GseFvxRpE5AADCeE8gn/tyHnSV91qrdfm4aeG9w==
X-Google-Smtp-Source: APXvYqzlwi4amB7UdX5f2PKpwQatyFRQoBhnTFgxEQxEattFx/iQqKHcqAKAacBmYgLaUplhc/Bvnw0AfD5cC3bxSNI=
X-Received: by 2002:a67:eb84:: with SMTP id e4mr4472823vso.165.1570096899417;
 Thu, 03 Oct 2019 03:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:03 +0200
Message-ID: <CAPDyKFo3+uAYr-j_qmBMeqO9TsY8PFv2J0kzAi56LYWe+E-o9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
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
> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/owl-mmc.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> new file mode 100644
> index 000000000000..12b40213426d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/owl-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoCs SD/MMC/SDIO controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: actions,owl-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: mmc
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - dmas
> +  - dma-names
> +
> +examples:
> +  - |
> +    mmc0: mmc@e0330000 {
> +        compatible = "actions,owl-mmc";
> +        reg = <0x0 0xe0330000 0x0 0x4000>;
> +        interrupts = <0 42 4>;
> +        clocks = <&cmu 56>;
> +        resets = <&cmu 23>;
> +        dmas = <&dma 2>;
> +        dma-names = "mmc";
> +        bus-width = <4>;
> +    };
> +
> +...
> --
> 2.17.1
>
