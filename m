Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F62147DA
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEFJwM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 05:52:12 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46179 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfEFJwL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 05:52:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so7727973vsc.13
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rV1a7HzGiypMloAmwPcR/9T2fLRxk2qSEdoAUv3cn0=;
        b=rPqfodRezo3OWzfxwP+VEWKArn65HI2Pa+4pMt7jzBxuhyMUFEAcc7gXJVHrzdfdTA
         Gk2AIMmeyOSE2zHrJpuAj9voZ25rvAHRIEF6Fto0ohxiGKBJ8sTkXEEExWVd6DsHatag
         WO/SVXhMdZwl3lj0thw3IK8TyrF/lLOyLwoW7R+v4b73mQhzxhWUrm2yAv9tkzoact1C
         d2xCPdEnxLZ5AL+WxCtrV1BMgxdWVfathQyQKZq0Gt1A+zRjB/+gVDRyQp5KEx5Gdpml
         iC0bKNbiA+UsuSWvqTSm48IaChNzMtmSn4m2XB6sm+E0i+gXfAQA4D3D14UJW/l4rpAs
         dC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rV1a7HzGiypMloAmwPcR/9T2fLRxk2qSEdoAUv3cn0=;
        b=aOmKIIQjF1OZ1EEuwVUtt45orfMaojV5RRv9kOdmZz6P45u2dLLIJ0whoz8I5ycXWi
         WCNCZ73LaCX/Pdp7z4dmbDQ6N9kB/RQNpo4I0XRLpzUbqJ9Pu3Io8RNedhmrAL7xt70w
         SoreI36CZemzflx38/+YX/3uN8Q5ozgudfA5OG3N9erk+3Dod3JIV9RoDZ+2cLHUpUi5
         Kzz7gO6CB0m4tyCRkWmNwMZoGli1Cc4GdnVCWN/r5KCyk91iUKUesDolD9gzJmvCxAXF
         dD5Q9u1P+kl0xlhs2BfVhrbJSBYGorXci/v+uKbtb997JT5QSeytOo+M+k4D3cR5QJ+F
         O6AA==
X-Gm-Message-State: APjAAAWBkgmhNoAv6byDdDo2olZhSiw8M6gKa2SxQBD+f+bgsbGjvr5X
        brga3uujzbpUQzi17l25D4WGOZvyN3aahixJJXYFZg==
X-Google-Smtp-Source: APXvYqz0oeMheo3KjObn/fMbGOVGo0xTHsWC799pUQmuBDtfFACOy6h2RFFj9tAivZCNWF+Pa8FKxXWoh7S7DXWc46Q=
X-Received: by 2002:a67:bd08:: with SMTP id y8mr632945vsq.200.1557136330658;
 Mon, 06 May 2019 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190506083853.12741-1-adrian.hunter@intel.com>
In-Reply-To: <20190506083853.12741-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:34 +0200
Message-ID: <CAPDyKFqeT1QoR3ThsK0qcz2rV-oth3Vm0O=xMhfQ1R7aXTJbkw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci: Fix BYT OCP setting
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 6 May 2019 at 10:39, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Some time ago, a fix was done for the sdhci-acpi driver, refer
> commit 6e1c7d6103fe ("mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO
> hangs"). The same issue was not expected to affect the sdhci-pci driver,
> but there have been reports to the contrary, so make the same hardware
> setting change.
>
> This patch applies to v5.0+ but before that backports will be required.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>
>
> Changes in V2:
>         Get rid of macros BYT_PM_OPS, BYT_SPM_OPS and BYT_RPM_OPS
>         Add fix pm ops also to sdhci_intel_byt_emmc
>
>
>
>  drivers/mmc/host/Kconfig          |  1 +
>  drivers/mmc/host/sdhci-pci-core.c | 96 +++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9c01310a0d2e..d084a9d63623 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -92,6 +92,7 @@ config MMC_SDHCI_PCI
>         tristate "SDHCI support on PCI bus"
>         depends on MMC_SDHCI && PCI
>         select MMC_CQHCI
> +       select IOSF_MBI if X86
>         help
>           This selects the PCI Secure Digital Host Controller Interface.
>           Most controllers found today are PCI devices.
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index a3d7a9db76c5..ab9e2b901094 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -31,6 +31,10 @@
>  #include <linux/mmc/sdhci-pci-data.h>
>  #include <linux/acpi.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/iosf_mbi.h>
> +#endif
> +
>  #include "cqhci.h"
>
>  #include "sdhci.h"
> @@ -451,6 +455,50 @@ static const struct sdhci_pci_fixes sdhci_intel_pch_sdio = {
>         .probe_slot     = pch_hc_probe_slot,
>  };
>
> +#ifdef CONFIG_X86
> +
> +#define BYT_IOSF_SCCEP                 0x63
> +#define BYT_IOSF_OCP_NETCTRL0          0x1078
> +#define BYT_IOSF_OCP_TIMEOUT_BASE      GENMASK(10, 8)
> +
> +static void byt_ocp_setting(struct pci_dev *pdev)
> +{
> +       u32 val = 0;
> +
> +       if (pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC &&
> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SDIO &&
> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SD &&
> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC2)
> +               return;
> +
> +       if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
> +                         &val)) {
> +               dev_err(&pdev->dev, "%s read error\n", __func__);
> +               return;
> +       }
> +
> +       if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
> +               return;
> +
> +       val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
> +
> +       if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
> +                          val)) {
> +               dev_err(&pdev->dev, "%s write error\n", __func__);
> +               return;
> +       }
> +
> +       dev_dbg(&pdev->dev, "%s completed\n", __func__);
> +}
> +
> +#else
> +
> +static inline void byt_ocp_setting(struct pci_dev *pdev)
> +{
> +}
> +
> +#endif
> +
>  enum {
>         INTEL_DSM_FNS           =  0,
>         INTEL_DSM_V18_SWITCH    =  3,
> @@ -715,6 +763,8 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>
>         byt_read_dsm(slot);
>
> +       byt_ocp_setting(slot->chip->pdev);
> +
>         ops->execute_tuning = intel_execute_tuning;
>         ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>
> @@ -938,7 +988,35 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int byt_resume(struct sdhci_pci_chip *chip)
> +{
> +       byt_ocp_setting(chip->pdev);
> +
> +       return sdhci_pci_resume_host(chip);
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_PM
> +
> +static int byt_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +       byt_ocp_setting(chip->pdev);
> +
> +       return sdhci_pci_runtime_resume_host(chip);
> +}
> +
> +#endif
> +
>  static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = byt_resume,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_resume = byt_runtime_resume,
> +#endif
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_emmc_probe_slot,
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> @@ -972,6 +1050,12 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = byt_resume,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_resume = byt_runtime_resume,
> +#endif
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -983,6 +1067,12 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = byt_resume,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_resume = byt_runtime_resume,
> +#endif
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -994,6 +1084,12 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = byt_resume,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_resume = byt_runtime_resume,
> +#endif
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
> --
> 2.17.1
>
