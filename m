Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8410148061
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfFQLPl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:15:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45322 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfFQLPl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:15:41 -0400
Received: by mail-ua1-f68.google.com with SMTP id v18so3278223uad.12
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOF08Kd8gvLLYtfWI0cYTkenEuQri7zpLz/JSt4v/xU=;
        b=MrRsLl9iUyiGYQSxAwc33dWM+RzxbM3wFsTH5CBlrji4IGCyYk4yvEI4xS/tT1pecu
         phYWdunoDqyMQqR070S4GpgR9DOPQLjoFadBG8NVfMYy952a4K6CGQndKArGugLNxFep
         /yHSIvX6Q3G2+rMDf9N/s//pJ7cnuLDlt7eWetwok+6pEJY18i0rTWiotZpQf02W6IZc
         yRAfTukTRHU9G+fRfKa7f+u46zlVnABmyX61MjigfFm3xNJMsMVtZwS5r2N+dpbqvvyd
         K4zaHdnkj/LsUC+egcdnik73LxiuKJ+GFV4wzuUg4x1vyWMNMN07WJWZNmqb5iTHlF1L
         qvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOF08Kd8gvLLYtfWI0cYTkenEuQri7zpLz/JSt4v/xU=;
        b=opB/ru5yKDiwWImHCl63Ulcyxa0u2NM97A1JnTfGcc0Swdc0AenHdpFNw2RFQPBO73
         tsf1R8QI8NfWX9rcwy3Nup2jTr1Ci6jIg2W9+6YV+oaqamz+x2mzjz1vE6hLwQg0oNVz
         Jga/M8dTrtnV8c7uimxjYO+QlI32x1Ds9P2x6SuVcf3mCGWEYLEHOXNOYeArgSCMRhyk
         eYuSdto66qm2PXYAyrRpSe6iu5jpFjpRUSBDsgMVZ6S8P/hTeym37KwdSYhwgGkDOw/0
         QeVWGD9RzSCaEcadTQhQlUkzZsSiySXu5bqGEfB4XCzeFlhaVjYAFCUNfM+o7tMa3h4W
         5+Jg==
X-Gm-Message-State: APjAAAWbDzE6xgRpxLR5H6oz69nzsrpyIswXjL9ZbOv2BlibRVRIvi8y
        AQzuahKNDHZf11co/miDgdeX0ZrW/9DKk1L7o13to19WbnY=
X-Google-Smtp-Source: APXvYqxv6PbqDpP2z9ZJaq9ci5jvEg3N87A4/Iy7u5CfHBbTDRRzt5ZE8iMU00CAEVVAIhmuBcVjHxA+PnfMsn6ngA4=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr8692794uam.129.1560770139986;
 Mon, 17 Jun 2019 04:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com> <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:15:03 +0200
Message-ID: <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Jun 2019 at 11:57, Manish Narani <manish.narani@xilinx.com> wrote:
>
> Apart from taps set by auto tuning, ZynqMP platform has feature to set
> the tap values manually. Add support to read tap delay values from
> DT and set the same in HW via ZynqMP SoC framework. Reading Tap
> Delays from DT is optional, if the property is not available in DT the
> driver will use the pre-defined Tap Delay Values.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 173 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 172 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b12abf9..7af6cec 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -22,6 +22,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
>
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -32,6 +33,10 @@
>
>  #define PHY_CLK_TOO_SLOW_HZ            400000
>
> +/* Default settings for ZynqMP Tap Delays */
> +#define ZYNQMP_ITAP_DELAYS {0, 0x15, 0x15, 0, 0x15, 0, 0, 0x3D, 0x12, 0, 0}
> +#define ZYNQMP_OTAP_DELAYS {0, 0x5, 0x6, 0, 0x5, 0x3, 0x3, 0x4, 0x6, 0x3, 0}
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -81,6 +86,7 @@ struct sdhci_arasan_soc_ctl_map {
>   * @sdcardclk:         Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> + * @of_data:           Platform specific runtime data storage pointer
>   */
>  struct sdhci_arasan_data {
>         struct sdhci_host *host;
> @@ -101,6 +107,15 @@ struct sdhci_arasan_data {
>  /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
>   * internal clock even when the clock isn't stable */
>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
> +
> +       void *of_data;
> +};
> +
> +struct sdhci_arasan_zynqmp_data {
> +       void (*set_tap_delay)(struct sdhci_host *host);
> +       const struct zynqmp_eemi_ops *eemi_ops;
> +       u8 tapdly[MMC_TIMING_MMC_HS400 + 1][2]; /* [0] for input delay, */
> +                                               /* [1] for output delay */
>  };

Please use two different structs, one for the clock provider data and
one for the mmc variant/platform data. This makes the code more
readable.

In regards to the mmc data part, I suggest to drop the
->set_tap_delay() callback, but rather use a boolean flag to indicate
whether clock phases needs to be changed for the variant. Potentially
that could even be skipped and instead call clk_set_phase()
unconditionally, as the clock core deals fine with clock providers
that doesn't support the ->set_phase() callback.

[...]

Otherwise this looks good to me!

When it comes to patch1, I need an ack from Michal to pick it up.

Kind regards
Uffe
