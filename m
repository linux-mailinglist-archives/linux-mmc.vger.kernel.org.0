Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55212CA5
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfECLp1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 07:45:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:63746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECLp0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 May 2019 07:45:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 04:45:25 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2019 04:45:23 -0700
Subject: Re: [PATCH] mmc: sdhci-pci: Fix BYT OCP setting
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
References: <20190502075202.26434-1-adrian.hunter@intel.com>
 <CAPDyKFqq+cOXYJiiPZSuh7ci-468nk3aH4aPdxey1k76YURg8A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b451341a-4d84-f2f8-06d0-9829656d6b93@intel.com>
Date:   Fri, 3 May 2019 14:44:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqq+cOXYJiiPZSuh7ci-468nk3aH4aPdxey1k76YURg8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/05/19 12:59 PM, Ulf Hansson wrote:
> On Thu, 2 May 2019 at 09:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Some time ago, a fix was done for the sdhci-acpi driver, refer
>> commit 6e1c7d6103fe ("mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO
>> hangs"). The same issue was not expected to affect the sdhci-pci driver,
>> but there have been reports to the contrary, so make the same hardware
>> setting change.
>>
>> This patch applies to v5.0+ but before that backports will be required.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/mmc/host/Kconfig          |  1 +
>>  drivers/mmc/host/sdhci-pci-core.c | 89 +++++++++++++++++++++++++++++++
>>  2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 9c01310a0d2e..d084a9d63623 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -92,6 +92,7 @@ config MMC_SDHCI_PCI
>>         tristate "SDHCI support on PCI bus"
>>         depends on MMC_SDHCI && PCI
>>         select MMC_CQHCI
>> +       select IOSF_MBI if X86
>>         help
>>           This selects the PCI Secure Digital Host Controller Interface.
>>           Most controllers found today are PCI devices.
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index a3d7a9db76c5..64e79a19d5ad 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -31,6 +31,10 @@
>>  #include <linux/mmc/sdhci-pci-data.h>
>>  #include <linux/acpi.h>
>>
>> +#ifdef CONFIG_X86
>> +#include <asm/iosf_mbi.h>
>> +#endif
>> +
>>  #include "cqhci.h"
>>
>>  #include "sdhci.h"
>> @@ -451,6 +455,50 @@ static const struct sdhci_pci_fixes sdhci_intel_pch_sdio = {
>>         .probe_slot     = pch_hc_probe_slot,
>>  };
>>
>> +#ifdef CONFIG_X86
>> +
>> +#define BYT_IOSF_SCCEP                 0x63
>> +#define BYT_IOSF_OCP_NETCTRL0          0x1078
>> +#define BYT_IOSF_OCP_TIMEOUT_BASE      GENMASK(10, 8)
>> +
>> +static void byt_ocp_setting(struct pci_dev *pdev)
>> +{
>> +       u32 val = 0;
>> +
>> +       if (pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC &&
>> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SDIO &&
>> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_SD &&
>> +           pdev->device != PCI_DEVICE_ID_INTEL_BYT_EMMC2)
>> +               return;
>> +
>> +       if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
>> +                         &val)) {
>> +               dev_err(&pdev->dev, "%s read error\n", __func__);
>> +               return;
>> +       }
>> +
>> +       if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
>> +               return;
>> +
>> +       val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
>> +
>> +       if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
>> +                          val)) {
>> +               dev_err(&pdev->dev, "%s write error\n", __func__);
>> +               return;
>> +       }
>> +
>> +       dev_dbg(&pdev->dev, "%s completed\n", __func__);
>> +}
>> +
>> +#else
>> +
>> +static inline void byt_ocp_setting(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +#endif
>> +
>>  enum {
>>         INTEL_DSM_FNS           =  0,
>>         INTEL_DSM_V18_SWITCH    =  3,
>> @@ -715,6 +763,8 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>>
>>         byt_read_dsm(slot);
>>
>> +       byt_ocp_setting(slot->chip->pdev);
>> +
>>         ops->execute_tuning = intel_execute_tuning;
>>         ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>>
>> @@ -971,7 +1021,44 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
>>         .priv_size              = sizeof(struct intel_host),
>>  };
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +
>> +static int byt_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       byt_ocp_setting(chip->pdev);
>> +
>> +       return sdhci_pci_resume_host(chip);
>> +}
>> +
>> +#define BYT_SPM_OPS .resume = byt_resume,
>> +
>> +#else
>> +
>> +#define BYT_SPM_OPS
>> +
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +
>> +static int byt_runtime_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       byt_ocp_setting(chip->pdev);
>> +
>> +       return sdhci_pci_runtime_resume_host(chip);
>> +}
>> +
>> +#define BYT_RPM_OPS .runtime_resume = byt_runtime_resume,
>> +
>> +#else
>> +
>> +#define BYT_RPM_OPS
>> +
>> +#endif
>> +
>> +#define BYT_PM_OPS BYT_SPM_OPS BYT_RPM_OPS
> 
> This ifdef hackary is a bit too much for me. :-)
> 
> Could you have the callbacks being assigned always and instead rely
> only on byt_ocp_setting() having different implementations, depending
> on if CONFIG_X86 is set or not?

The callbacks themselves are under ifdef, so that wouldn't work.
Could get rid of BYT_PM_OPS and put this instead:

#ifdef CONFIG_PM_SLEEP
	.resume            = byt_resume,
#endif
#ifdef CONFIG_PM
	.runtime_resume    = byt_runtime_resume,
#endif

> 
>> +
>>  static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>> +       BYT_PM_OPS
>>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>>                           SDHCI_QUIRK_NO_LED,
>>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>> @@ -983,6 +1070,7 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>>  };
>>
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>> +       BYT_PM_OPS
>>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>>                           SDHCI_QUIRK_NO_LED,
>>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>> @@ -994,6 +1082,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>  };
>>
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>> +       BYT_PM_OPS
>>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>>                           SDHCI_QUIRK_NO_LED,
>>         .quirks2        = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 

