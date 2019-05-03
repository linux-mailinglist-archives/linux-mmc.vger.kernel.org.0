Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C836712F01
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 15:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfECN0E (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 09:26:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45110 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfECN0D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 09:26:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id o10so3543181vsp.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA5+ZR6qD2zARcWRdUmXEwMHxq0HlObaCRK218ohn5M=;
        b=qXmiRcDT5KxSgwICrstfdjOp02fmnxuqv/kzgMttoU/93NA069NcX3My3iPN10mInY
         JzmCQXO8incxqFK8EoA/QZ1wmKi+o9BTCFUFhx0FgWxPFOAgYCPFJ+QgrOxc1T/UzTqS
         bltI7zE1CzNNZCA7GbeInWc2uO3ZQ7ssmzbXDCcM0Ar/cshtaIKLZ3B077NwPDcC1yVg
         EBducQss95I8iWqDUQM3UKuyzLmfrJDqSVSDmEwD4ChREb82qbRHc7+FGKe4lvv9kxc5
         G6gFyCy5AO8cF/tde+HJEEFQt8HSWDmVdx25cqK/APVhZwmex/R2P4pMKbfY6VivJ6sf
         Iuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA5+ZR6qD2zARcWRdUmXEwMHxq0HlObaCRK218ohn5M=;
        b=N3uf+Xfrg5zFgd5zacM9HaozL7vMnA+0GfvDPQaQX35tn2RirTCmzkULMSThACY+y1
         8JMgifiquzvuyEm5B1s8eJ7h9PqRWLEsLpnlJQRdaIntL0JhjzVqBYLQHDoaNLUB8+v7
         E7qHPe+a0/npQ1fUIJNYrGhIO3jSI4qMlnLpy3l7UvGoO9Xn2u3bqcqxrxpNxCEdvImr
         +1QKXLmh3nXznsPvQAOOpHs5TIi5vedA40119BtKCSMif/po7piQ8fjIpRCWQGEfwFe5
         n+nqrLs1MCV7K+EAQPwpP/gAUsHkPMndseNUT/0Z7kq8JUl5ovcmkBT+/VtaVBmMQNJe
         9y2g==
X-Gm-Message-State: APjAAAWMVcniETDJJBN2+7xgV0vG65t9KEMwMyhypLThu0PDhkMGsmsf
        VuXYopyUKBd4/e0sD2ewFd+1qzNAaBqSf6mQbiGG/tqCq9o=
X-Google-Smtp-Source: APXvYqwSbuhgj9saZsxWrZ6XZbqM1mCqdvMwmgjc4RjH/LwUsU6BMzaz/2Kfgys2CCCrc4+R5/38HB1GFA7mCFjGg8U=
X-Received: by 2002:a67:8155:: with SMTP id c82mr5517994vsd.200.1556889962016;
 Fri, 03 May 2019 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190502075202.26434-1-adrian.hunter@intel.com>
 <CAPDyKFqq+cOXYJiiPZSuh7ci-468nk3aH4aPdxey1k76YURg8A@mail.gmail.com> <b451341a-4d84-f2f8-06d0-9829656d6b93@intel.com>
In-Reply-To: <b451341a-4d84-f2f8-06d0-9829656d6b93@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:25:26 +0200
Message-ID: <CAPDyKFo4BTmtBop5eY1ZQ6CJVeJTSn-uZfxwBX9SdkmtRqaz9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix BYT OCP setting
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 May 2019 at 13:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/05/19 12:59 PM, Ulf Hansson wrote:
> > On Thu, 2 May 2019 at 09:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Some time ago, a fix was done for the sdhci-acpi driver, refer
> >> commit 6e1c7d6103fe ("mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO
> >> hangs"). The same issue was not expected to affect the sdhci-pci driver,
> >> but there have been reports to the contrary, so make the same hardware
> >> setting change.
> >>
> >> This patch applies to v5.0+ but before that backports will be required.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  drivers/mmc/host/Kconfig          |  1 +
> >>  drivers/mmc/host/sdhci-pci-core.c | 89 +++++++++++++++++++++++++++++++
> >>  2 files changed, 90 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 9c01310a0d2e..d084a9d63623 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -92,6 +92,7 @@ config MMC_SDHCI_PCI
> >>         tristate "SDHCI support on PCI bus"
> >>         depends on MMC_SDHCI && PCI
> >>         select MMC_CQHCI
> >> +       select IOSF_MBI if X86
> >>         help
> >>           This selects the PCI Secure Digital Host Controller Interface.
> >>           Most controllers found today are PCI devices.
> >> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> >> index a3d7a9db76c5..64e79a19d5ad 100644
> >> --- a/drivers/mmc/host/sdhci-pci-core.c
> >> +++ b/drivers/mmc/host/sdhci-pci-core.c
> >> @@ -31,6 +31,10 @@
> >>  #include <linux/mmc/sdhci-pci-data.h>
> >>  #include <linux/acpi.h>
> >>
> >> +#ifdef CONFIG_X86
> >> +#include <asm/iosf_mbi.h>
> >> +#endif
> >> +
> >>  #include "cqhci.h"
> >>
> >>  #include "sdhci.h"
> >> @@ -451,6 +455,50 @@ static const struct sdhci_pci_fixes sdhci_intel_pch_sdio = {
> >>         .probe_slot     = pch_hc_probe_slot,
> >>  };
> >>
> >> +#ifdef CONFIG_X86
> >> +
> >> +#define BYT_IOSF_SCCEP                 0x63
> >> +#define BYT_IOSF_OCP_NETCTRL0          0x1078
> >> +#define BYT_IOSF_OCP_TIMEOUT_BASE      GENMASK(10, 8)
> >> +
> >> +static void byt_ocp_setting(struct pci_dev *pdev)
> >> +{
> >> +       u32 val = 0;
> >> +
> >> +       if (pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC &&
> >> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SDIO &&
> >> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SD &&
> >> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC2)
> >> +               return;
> >> +
> >> +       if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
> >> +                         &val)) {
> >> +               dev_err(&pdev->dev, "%s read error\n", __func__);
> >> +               return;
> >> +       }
> >> +
> >> +       if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
> >> +               return;
> >> +
> >> +       val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
> >> +
> >> +       if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
> >> +                          val)) {
> >> +               dev_err(&pdev->dev, "%s write error\n", __func__);
> >> +               return;
> >> +       }
> >> +
> >> +       dev_dbg(&pdev->dev, "%s completed\n", __func__);
> >> +}
> >> +
> >> +#else
> >> +
> >> +static inline void byt_ocp_setting(struct pci_dev *pdev)
> >> +{
> >> +}
> >> +
> >> +#endif
> >> +
> >>  enum {
> >>         INTEL_DSM_FNS           =  0,
> >>         INTEL_DSM_V18_SWITCH    =  3,
> >> @@ -715,6 +763,8 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
> >>
> >>         byt_read_dsm(slot);
> >>
> >> +       byt_ocp_setting(slot->chip->pdev);
> >> +
> >>         ops->execute_tuning = intel_execute_tuning;
> >>         ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
> >>
> >> @@ -971,7 +1021,44 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
> >>         .priv_size              = sizeof(struct intel_host),
> >>  };
> >>
> >> +#ifdef CONFIG_PM_SLEEP
> >> +
> >> +static int byt_resume(struct sdhci_pci_chip *chip)
> >> +{
> >> +       byt_ocp_setting(chip->pdev);
> >> +
> >> +       return sdhci_pci_resume_host(chip);
> >> +}
> >> +
> >> +#define BYT_SPM_OPS .resume = byt_resume,
> >> +
> >> +#else
> >> +
> >> +#define BYT_SPM_OPS
> >> +
> >> +#endif
> >> +
> >> +#ifdef CONFIG_PM
> >> +
> >> +static int byt_runtime_resume(struct sdhci_pci_chip *chip)
> >> +{
> >> +       byt_ocp_setting(chip->pdev);
> >> +
> >> +       return sdhci_pci_runtime_resume_host(chip);
> >> +}
> >> +
> >> +#define BYT_RPM_OPS .runtime_resume = byt_runtime_resume,
> >> +
> >> +#else
> >> +
> >> +#define BYT_RPM_OPS
> >> +
> >> +#endif
> >> +
> >> +#define BYT_PM_OPS BYT_SPM_OPS BYT_RPM_OPS
> >
> > This ifdef hackary is a bit too much for me. :-)
> >
> > Could you have the callbacks being assigned always and instead rely
> > only on byt_ocp_setting() having different implementations, depending
> > on if CONFIG_X86 is set or not?
>
> The callbacks themselves are under ifdef, so that wouldn't work.

Wouldn't SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS help with that?

> Could get rid of BYT_PM_OPS and put this instead:
>
> #ifdef CONFIG_PM_SLEEP
>         .resume            = byt_resume,
> #endif
> #ifdef CONFIG_PM
>         .runtime_resume    = byt_runtime_resume,
> #endif

That's better!

[...]

Kind regards
Uffe
