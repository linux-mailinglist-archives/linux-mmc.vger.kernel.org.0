Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB79EC9B5F
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfJCKBQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:01:16 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41756 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbfJCKBP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:01:15 -0400
Received: by mail-ua1-f66.google.com with SMTP id l13so688372uap.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFXtDFTHO0HF9pGMt5XFsRsW4Q3dt04mUBjZZSzIhJ8=;
        b=FGI6fw/+nrQ6ZIl+M0Mz1bs2QtbMyBtxBY1sHJvmbJHgntBE/reTItw3dSkx1wCALQ
         IJ2PwH1uwdK/sHDPFbIuLXsWKkJXfrcbbHFMAtIHqB8HHe/h7espu5APJxjQLdsP0dLh
         xYJ7YCoj7D1CbSkijjXW/yNsYYKlqCdHzrDceuvSqsSEUSIpeGeu4JA8YySNLkaho8uh
         hGe44GkHC6ggmxwV6F60LOMlkx9mfKR7Trsal89+xFjNN/lCyJRPw8v7+NZHwrGJSL3h
         4yqXe9LBAHdfp+dJyz0WLUGsJTQtHGjeNyszL7Gbig+fYmffgTtqgnLR2V2iOpV3dP0h
         NGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFXtDFTHO0HF9pGMt5XFsRsW4Q3dt04mUBjZZSzIhJ8=;
        b=Km/5S73fHx0HEkCTjxdB+qkL6Hx1So4gBOV95JFIRv/dJqlnve7uSTFOMxJtJ9TzK/
         3u9/leGLw638nY5D3PLvRDIijnKvAbojHDSj3es4dUqwyBtowlTU0YkpfwpQUfQGzjvI
         LXXtM52jbsf/Wx8nqUULQCP7dVBKNvwB/VoClpf+m0mNo3iXgcenF6RrJ6hyowIw0s/r
         lFDLqHOApa1822ptLKK0tgShXKbIQXedcwNN4hHfuLwVumYsownzml/YofUYIVnq8dR5
         MQywY2X5Q8D8RiP/uqReGW1JV97x30Ho9RPCqUOsiLyxykhk+c4SvE19i1ONC0vGH6gx
         jvbA==
X-Gm-Message-State: APjAAAVmUJFti0c4KEcPgfXGJE61zvc3wE+S1rYYDBqIvW95fHfxMKYz
        DLIWOcBsGI1a9CX4pKiXbkBqq2hOUxGSKhmISq3Qfw==
X-Google-Smtp-Source: APXvYqwBA9hmJGoXg7Fwkp50y3YnNy7YwEVTr8gN2ylX6xhtnNzW3AzpImVWkLsxbsR/YidCguMGldZfB0pHUrALsuQ=
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr4430721uar.104.1570096874324;
 Thu, 03 Oct 2019 03:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164625.236978-1-rrangel@chromium.org> <20190904164625.236978-2-rrangel@chromium.org>
In-Reply-To: <20190904164625.236978-2-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:00:37 +0200
Message-ID: <CAPDyKFpgNQ_MbrM8wqox3a9JutemNng+qrCjz91uam=gaLW-HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 18:46, Raul E Rangel <rrangel@chromium.org> wrote:
>
> AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> Otherwise it can get into a bad state where the DATA lines are always
> read as zeros.
>
> This change requires firmware that can transition the device into
> D3Cold for it to work correctly. If the firmware does not support
> transitioning to D3Cold then the power state transitions are a no-op.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is just a resend of https://patchwork.kernel.org/patch/10925467/
>
>
>  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7d06e2860c36..84931ebe0c93 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -21,6 +21,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mmc/slot-gpio.h>
> @@ -1590,11 +1591,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>         return 0;
>  }
>
> +static u32 sdhci_read_present_state(struct sdhci_host *host)
> +{
> +       return sdhci_readl(host, SDHCI_PRESENT_STATE);
> +}
> +
> +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 present_state;
> +
> +       /*
> +        * SDHC 0x7906 requires a hard reset to clear all internal state.
> +        * Otherwise it can get into a bad state where the DATA lines are always
> +        * read as zeros.
> +        */
> +       if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> +               pci_clear_master(pdev);
> +
> +               pci_save_state(pdev);
> +
> +               pci_set_power_state(pdev, PCI_D3cold);
> +               pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> +                       pdev->current_state);
> +               pci_set_power_state(pdev, PCI_D0);
> +
> +               pci_restore_state(pdev);
> +
> +               /*
> +                * SDHCI_RESET_ALL says the card detect logic should not be
> +                * reset, but since we need to reset the entire controller
> +                * we should wait until the card detect logic has stabilized.
> +                *
> +                * This normally takes about 40ms.
> +                */
> +               readx_poll_timeout(
> +                       sdhci_read_present_state,
> +                       host,
> +                       present_state,
> +                       present_state & SDHCI_CD_STABLE,
> +                       10000,
> +                       100000
> +               );
> +       }
> +
> +       return sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops amd_sdhci_pci_ops = {
>         .set_clock                      = sdhci_set_clock,
>         .enable_dma                     = sdhci_pci_enable_dma,
>         .set_bus_width                  = sdhci_set_bus_width,
> -       .reset                          = sdhci_reset,
> +       .reset                          = amd_sdhci_reset,
>         .set_uhs_signaling              = sdhci_set_uhs_signaling,
>  };
>
> --
> 2.23.0.187.g17f5b7556c-goog
>
