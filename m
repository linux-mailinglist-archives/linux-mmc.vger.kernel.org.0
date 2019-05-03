Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8245512B25
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfECKAT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 06:00:19 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44936 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECKAS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 06:00:18 -0400
Received: by mail-vk1-f195.google.com with SMTP id q189so1234765vkq.11
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VT8DPqG9NF/9I0JewNMGFCCR6biS7N3133o7asCWT5A=;
        b=uFUMvm8Msb9ouMeIq9IficH4MLOmqNs960m/7eKsE22F04TwJIIoVeZJRyz/F9cD99
         p8amRlDmT8REo9Gn5Iu+UHf+lQBJGNHbzkJK2p903hCthm7GjiA5t0uTWOu9AH8bwzYH
         ZeuoHekTf4OdGkBrF9jLdaaiIINuDw2hlw/0AeHtmlLPBdM3QDGC3ux9W/+b83a3+9/p
         0UwaikNE3VwD35x3lnreY5xcWcBGxzbygowDbQfEZLwUY5Uvl1CHQwqX8DAyXLS/kUfp
         odetME8P/oJ24wcVfUHychiE/y2KWiM1zH8gMjp4XzEZOVlVdXVRcIm6DH3A/6kE32Iu
         XnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT8DPqG9NF/9I0JewNMGFCCR6biS7N3133o7asCWT5A=;
        b=AAgbHOg2r2EnXMZGhr3dVE7DijAbc4682oE75t52aPhcOjx6sRJETiYwzwgW5N5vn5
         dvMeNCpU7obwshSthDII6ouYsdJw1wiRjTs52cmadw7wbEWZL+SnmhtYohGVhjPo4+xt
         O6QZReiwfyCwUK0U7edTcRfiWaViXlBfCaD1o6uvGrq08k3iGNS3/MNm6D6PoGPdRPJ5
         JuFqIj1urDf7U7wBOSxQ/5mgF551vCaWKDlnAYWbSQo350ISRpI73JuLuHkNqyteebQq
         TUXUXYRkY5Z32SXRvbbmHGM6G/GReyFdiLRJgjLem8SIDl/QMcuQ4zU6gPvzzxsdQ1gq
         MjLw==
X-Gm-Message-State: APjAAAVrMiudSVC1s/oX5n5R6w20TYaPLqK6CyeGG2FtGcnTD2uAW6BX
        Dg84KY6kd/E7ekc0AMji9vQDGWoig851192sfRObgT8x8BU=
X-Google-Smtp-Source: APXvYqzy3MSLs7NbfA3tzku33s+YwXvwTiTkJ2QdFSjezBSMo7M0rGGK4vhr6hZQMfQpk9CyPSaqdq1rncet2z4fSHA=
X-Received: by 2002:a1f:3458:: with SMTP id b85mr4758900vka.4.1556877616903;
 Fri, 03 May 2019 03:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190502075202.26434-1-adrian.hunter@intel.com>
In-Reply-To: <20190502075202.26434-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 11:59:41 +0200
Message-ID: <CAPDyKFqq+cOXYJiiPZSuh7ci-468nk3aH4aPdxey1k76YURg8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix BYT OCP setting
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 May 2019 at 09:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> ---
>  drivers/mmc/host/Kconfig          |  1 +
>  drivers/mmc/host/sdhci-pci-core.c | 89 +++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
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
> index a3d7a9db76c5..64e79a19d5ad 100644
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
> @@ -971,7 +1021,44 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
>         .priv_size              = sizeof(struct intel_host),
>  };
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
> +#define BYT_SPM_OPS .resume = byt_resume,
> +
> +#else
> +
> +#define BYT_SPM_OPS
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
> +#define BYT_RPM_OPS .runtime_resume = byt_runtime_resume,
> +
> +#else
> +
> +#define BYT_RPM_OPS
> +
> +#endif
> +
> +#define BYT_PM_OPS BYT_SPM_OPS BYT_RPM_OPS

This ifdef hackary is a bit too much for me. :-)

Could you have the callbacks being assigned always and instead rely
only on byt_ocp_setting() having different implementations, depending
on if CONFIG_X86 is set or not?

> +
>  static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
> +       BYT_PM_OPS
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -983,6 +1070,7 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
> +       BYT_PM_OPS
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -994,6 +1082,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
> +       BYT_PM_OPS
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
> --
> 2.17.1
>

Kind regards
Uffe
