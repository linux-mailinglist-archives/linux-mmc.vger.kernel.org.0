Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFE13C220
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Jan 2020 13:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgAOM6g (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Jan 2020 07:58:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:46116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgAOM6f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 07:58:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 04:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="256764796"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 04:58:33 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: Disable 1.8V modes on external
 microSD on Lenovo Miix 320
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
Date:   Wed, 15 Jan 2020 14:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108093903.57620-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 11:39 am, Hans de Goede wrote:
> Based on a sample of 7 DSDTs from Cherry Trail devices using an AXP288
> PMIC depending on the design one of 2 possible LDOs on the PMIC is used
> for the MMC signalling voltage, either DLDO3 or GPIO1LDO (GPIO1 pin in
> low noise LDO mode).
> 
> The Lenovo Miix 320-10ICR uses GPIO1LDO in the SHC1 ACPI device's DSM
> methods to set 3.3 or 1.8 signalling voltage and this appears to work
> as advertised, so presumably the device is actually using GPIO1LDO for
> the external microSD signalling voltage.
> 
> But this device has a bug in the _PS0 method of the SHC1 ACPI device,
> the DSM remembers the last set signalling voltage and the _PS0 restores
> this after a (runtime) suspend-resume cycle, but it "restores" the voltage
> on DLDO3 instead of setting it on GPIO1LDO as the DSM method does. DLDO3
> is used for the LCD and setting it to 1.8V causes the LCD to go black.
> 
> This issue can be worked around by setting the SDHCI_QUIRK2_NO_1_8_V
> quirk on the sdhci_host so that the DSM never gets used to program the
> signalling voltage to 1.8V.

Could you instead call the 3.3V DSM at runtime suspend time, then the _PS0
would not "restore" the 1.8V value?  That should allow you to use 1.8V UHS-I
speed modes with SD cards that support them.

> 
> So far we have mostly been able to avoid using device specific quirks in
> the sdhci-acpi code, but given that this issue is specific to this one
> model and we certainly do not want to disable 1.8V modes everywhere I
> see no other option.
> 
> This commit adds a new mechanism for setting sdhci-acpi specific quirks
> and a matching sdhci-acpi.quirks module parameter to make testing quirks /
> similar issues on other devices easier.
> 
> The first quirk supported by this mechanism is SDHCI_ACPI_QUIRK_SD_NO_1_8V,
> which when set causes any slots with the SDHCI_ACPI_SD_CD flag to get the
> SDHCI_QUIRK2_NO_1_8_V quirk set on their sdhci_host.
> 
> This commit also adds a DMI table for specifying default quirks for some
> models and adds an entry for the Lenovo Miix 320-10ICR which enables the
> SDHCI_QUIRK2_NO_1_8_V by default on this model, fixing the LCD going black
> when the external microSD slot is used.
> 
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=111294
> BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
> Reported-by: russianneuromancer <russianneuromancer@ya.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 105e73d4a3b9..9f150c73e958 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/pm.h>
> @@ -75,6 +76,14 @@ struct sdhci_acpi_host {
>  	unsigned long			private[0] ____cacheline_aligned;
>  };
>  
> +enum {
> +	SDHCI_ACPI_QUIRK_SD_NO_1_8V			= BIT(0),
> +};
> +
> +static int quirks = -1;
> +module_param(quirks, int, 0444);
> +MODULE_PARM_DESC(quirks, "Override sdhci-acpi specific quirks");

Why is a module parameter needed?

> +
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
>  {
>  	return (void *)c->private;
> @@ -647,6 +656,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> +static const struct dmi_system_id sdhci_acpi_quirks[] = {
> +	{
> +		/*
> +		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
> +		 * the SHC1 ACPI device, this bug causes it to reprogram the
> +		 * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
> +		 * card is (runtime) suspended + resumed. DLDO3 is used for
> +		 * the LCD and setting it to 1.8V causes the LCD to go black.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
> +		},
> +		.driver_data = (void *)SDHCI_ACPI_QUIRK_SD_NO_1_8V,
> +	},
> +	{} /* Terminating entry */
> +};
> +
>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
>  {
>  	const struct sdhci_acpi_uid_slot *u;
> @@ -663,6 +690,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	const struct sdhci_acpi_slot *slot;
>  	struct acpi_device *device, *child;
> +	const struct dmi_system_id *id;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
> @@ -670,6 +698,14 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	size_t priv_size;
>  	int err;
>  
> +	if (quirks == -1) {
> +		id = dmi_first_match(sdhci_acpi_quirks);
> +		if (id)
> +			quirks = (long)id->driver_data;
> +		else
> +			quirks = 0;
> +	}
> +
>  	device = ACPI_COMPANION(dev);
>  	if (!device)
>  		return -ENODEV;
> @@ -759,6 +795,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  			dev_warn(dev, "failed to setup card detect gpio\n");
>  			c->use_runtime_pm = false;
>  		}
> +
> +		if (quirks & SDHCI_ACPI_QUIRK_SD_NO_1_8V)
> +			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  	}
>  
>  	err = sdhci_setup_host(host);
> 

