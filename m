Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C5AF51D
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 06:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfIKEmb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 00:42:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42917 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfIKEma (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 00:42:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so10849681pgb.9;
        Tue, 10 Sep 2019 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUEX5VfNjgmgSzyZcvJ0bWOEtOCtMYXz+ema9U1HuEc=;
        b=E2j5XnO5OtJ9y86VZD2+/K8yz6DSfihFalrcCWymQwrJ/JEFGbtJrsP+gTiDP0ujvY
         iS18NbY80nq2XkuITQMiqmly3gaCX3XPa3yIxN7s5i1B/Fa0nFzWhIaD7R+G4HQYTHjV
         O1NDU9ClOW0snrKekzT8PKn4tlP++lYfUArhlrxvPoWC5kYsG1O8bovGNuoDWu8QoNcy
         CNrwLWQRoTa6tPKcTsQ1Y0tYnKPgGlrp4Ue525QbysY4njuj3OOsEC1RDL5EQGKrom+Q
         kW0tarcg6GYKVeYF4XTarSmqHW0uAJut4J1CDseSduC0Ii+Y/fp8CrvV9sAa3e51Fj2X
         7GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUEX5VfNjgmgSzyZcvJ0bWOEtOCtMYXz+ema9U1HuEc=;
        b=ZxePIBNecuoDnhXyOogr2AOjCJS1lB+Je9m7PRLGZngHkY/HBl2ewE8QLU5uyBx9sb
         1XipJQFOK14hqvVeIPn2apbysXyhiM3P17DKaYVEA1jHvdVLXPrtjHbheOE6eNUUFV9S
         NF4mKSrCgK2s5M4/e7RqYgh62ovpym9PLThOxJ9TLSjbwVAFpfUHkMm0aFQ9QaHBgXqj
         RH9W/m2qUAYsdSWQ32ztXAYHdCJjXDgLW6R+lZifzlDPfDzR3KIaUUYJmlwx77PMOCmg
         rp9k/G1z+laA2m9GZfJ6lMCDe3qCX/S47prrFFimJoNmYYWsAxfW5gIuWVvKuC98nouJ
         dCpw==
X-Gm-Message-State: APjAAAUNhMZgj8nX+U+9JJsIg8+2EHKPWeNNwETR0+xluzHe0frtczqp
        ixl3tbvy7gvUEAltouGefiw=
X-Google-Smtp-Source: APXvYqzxiGWg2mqzP3lDJTHKZCmUXrxYAwc+iKQbZQEGhc6BUNabDV/AhJDPltjDBwixWy/VJI65rw==
X-Received: by 2002:a17:90a:8509:: with SMTP id l9mr3286522pjn.10.1568176948031;
        Tue, 10 Sep 2019 21:42:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u69sm17824728pgu.77.2019.09.10.21.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 21:42:26 -0700 (PDT)
Date:   Tue, 10 Sep 2019 21:42:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
Subject: Re: [PATCH V8 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Message-ID: <20190911044225.GA8049@roeck-us.net>
References: <cover.1567734321.git.benchuanggli@gmail.com>
 <13ba23b2b159a88bb385b6a1e8ead5fe5ea53156.1567734321.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ba23b2b159a88bb385b6a1e8ead5fe5ea53156.1567734321.git.benchuanggli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 06, 2019 at 10:33:26AM +0800, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add support for the GL9750 and GL9755 chipsets.
> 
> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> tuning flow for GL9750.
> 
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/Kconfig          |   1 +
>  drivers/mmc/host/Makefile         |   2 +-
>  drivers/mmc/host/sdhci-pci-core.c |   2 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 355 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   5 +
>  5 files changed, 364 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-gli.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 931770f17087..9fbfff514d6c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
>  	depends on MMC_SDHCI && PCI
>  	select MMC_CQHCI
>  	select IOSF_MBI if X86
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the PCI Secure Digital Host Controller Interface.
>  	  Most controllers found today are PCI devices.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..661445415090 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> -				   sdhci-pci-dwc-mshc.o
> +				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4154ee11b47d..e5835fbf73bc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1682,6 +1682,8 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>  	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
> +	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
> +	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> new file mode 100644
> index 000000000000..94462b94abec
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Genesys Logic, Inc.
> + *
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Version: v0.9.0 (2019-08-08)
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/pci.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +/*  Genesys Logic extra registers */
> +#define SDHCI_GLI_9750_WT         0x800
> +#define   SDHCI_GLI_9750_WT_EN      BIT(0)
> +#define   GLI_9750_WT_EN_ON	    0x1
> +#define   GLI_9750_WT_EN_OFF	    0x0
> +
> +#define SDHCI_GLI_9750_DRIVING      0x860
> +#define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
> +#define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
> +#define   GLI_9750_DRIVING_1_VALUE    0xFFF
> +#define   GLI_9750_DRIVING_2_VALUE    0x3
> +
> +#define SDHCI_GLI_9750_PLL	      0x864
> +#define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> +#define   SDHCI_GLI_9750_PLL_TX2_DLY    GENMASK(22, 20)
> +#define   GLI_9750_PLL_TX2_INV_VALUE    0x1
> +#define   GLI_9750_PLL_TX2_DLY_VALUE    0x0
> +
> +#define SDHCI_GLI_9750_SW_CTRL      0x874
> +#define   SDHCI_GLI_9750_SW_CTRL_4    GENMASK(7, 6)
> +#define   GLI_9750_SW_CTRL_4_VALUE    0x3
> +
> +#define SDHCI_GLI_9750_MISC            0x878
> +#define   SDHCI_GLI_9750_MISC_TX1_INV    BIT(2)
> +#define   SDHCI_GLI_9750_MISC_RX_INV     BIT(3)
> +#define   SDHCI_GLI_9750_MISC_TX1_DLY    GENMASK(6, 4)
> +#define   GLI_9750_MISC_TX1_INV_VALUE    0x0
> +#define   GLI_9750_MISC_RX_INV_ON        0x1
> +#define   GLI_9750_MISC_RX_INV_OFF       0x0
> +#define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
> +#define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
> +
> +#define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
> +#define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
> +#define   GLI_9750_TUNING_CONTROL_EN_OFF            0x0
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1    BIT(16)
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2    GENMASK(20, 19)
> +#define   GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE    0x1
> +#define   GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE    0x2
> +
> +#define SDHCI_GLI_9750_TUNING_PARAMETERS           0x544
> +#define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
> +#define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
> +
> +#define GLI_MAX_TUNING_LOOP 40
> +
> +/* Genesys Logic chipset */
> +static inline void gl9750_wt_on(struct sdhci_host *host)
> +{
> +	u32 wt_value;
> +	u32 wt_enable;
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
> +
> +	if (wt_enable == GLI_9750_WT_EN_ON)
> +		return;
> +
> +	wt_value &= ~SDHCI_GLI_9750_WT_EN;
> +	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_ON);
> +
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static inline void gl9750_wt_off(struct sdhci_host *host)
> +{
> +	u32 wt_value;
> +	u32 wt_enable;
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
> +
> +	if (wt_enable == GLI_9750_WT_EN_OFF)
> +		return;
> +
> +	wt_value &= ~SDHCI_GLI_9750_WT_EN;
> +	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_OFF);
> +
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static void gli_set_9750(struct sdhci_host *host)
> +{
> +	u32 driving_value;
> +	u32 pll_value;
> +	u32 sw_ctrl_value;
> +	u32 misc_value;
> +	u32 parameter_value;
> +	u32 control_value;
> +	u16 ctrl2;
> +
> +	gl9750_wt_on(host);
> +
> +	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
> +	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +	control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	driving_value &= ~(SDHCI_GLI_9750_DRIVING_1);
> +	driving_value &= ~(SDHCI_GLI_9750_DRIVING_2);
> +	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_1,
> +				    GLI_9750_DRIVING_1_VALUE);
> +	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
> +				    GLI_9750_DRIVING_2_VALUE);
> +	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
> +
> +	sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
> +	sw_ctrl_value |= FIELD_PREP(SDHCI_GLI_9750_SW_CTRL_4,
> +				    GLI_9750_SW_CTRL_4_VALUE);
> +	sdhci_writel(host, sw_ctrl_value, SDHCI_GLI_9750_SW_CTRL);
> +
> +	/* reset the tuning flow after reinit and before starting tuning */
> +	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_INV;
> +	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_DLY;
> +	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_INV,
> +				GLI_9750_PLL_TX2_INV_VALUE);
> +	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_DLY,
> +				GLI_9750_PLL_TX2_DLY_VALUE);
> +
> +	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_INV;
> +	misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
> +	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_DLY;
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_INV,
> +				 GLI_9750_MISC_TX1_INV_VALUE);
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +				 GLI_9750_MISC_RX_INV_VALUE);
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_DLY,
> +				 GLI_9750_MISC_TX1_DLY_VALUE);
> +
> +	parameter_value &= ~SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY;
> +	parameter_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY,
> +				      GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE);
> +
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1;
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1,
> +				    GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE);
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2,
> +				    GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE);
> +
> +	sdhci_writel(host, pll_value, SDHCI_GLI_9750_PLL);
> +	sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +
> +	/* disable tuned clk */
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	/* enable tuning parameters control */
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
> +				    GLI_9750_TUNING_CONTROL_EN_ON);
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	/* write tuning parameters */
> +	sdhci_writel(host, parameter_value, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +
> +	/* disable tuning parameters control */
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
> +				    GLI_9750_TUNING_CONTROL_EN_OFF);
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	/* clear tuned clk */
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	gl9750_wt_off(host);
> +}
> +
> +static void gli_set_9750_rx_inv(struct sdhci_host *host, bool b)
> +{
> +	u32 misc_value;
> +
> +	gl9750_wt_on(host);
> +
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	if (b) {
> +		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;

The above statement can be moved outside the if.

> +		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +					 GLI_9750_MISC_RX_INV_ON);
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);

Can be moved outside the if.

[ maybe that was discussed; if so please ignore ]

> +	} else {
> +		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
> +		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +					 GLI_9750_MISC_RX_INV_OFF);
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +	}
> +
> +	gl9750_wt_off(host);
> +}
> +
> +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
> +{
> +	int i;
> +	int rx_inv;
> +
> +	for (rx_inv = 0; rx_inv < 2; rx_inv++) {
> +		gli_set_9750_rx_inv(host, !!rx_inv);
> +		sdhci_start_tuning(host);
> +
> +		for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
> +			u16 ctrl;
> +
> +			sdhci_send_tuning(host, opcode);
> +
> +			if (!host->tuning_done) {
> +				sdhci_abort_tuning(host, opcode);
> +				break;
> +			}
> +
> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +				if (ctrl & SDHCI_CTRL_TUNED_CLK)
> +					return 0; /* Success! */
> +				break;
> +			}
> +		}
> +	}
> +	if (!host->tuning_done) {
> +		pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +			mmc_hostname(host->mmc));
> +		return -ETIMEDOUT;
> +	}
> +
> +	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +		mmc_hostname(host->mmc));
> +	sdhci_reset_tuning(host);
> +
> +	return -EAGAIN;
> +}
> +
> +static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	host->mmc->retune_period = 0;
> +	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> +		host->mmc->retune_period = host->tuning_count;
> +
> +	gli_set_9750(host);
> +	host->tuning_err = __sdhci_execute_tuning_9750(host, opcode);
> +	sdhci_end_tuning(host);
> +
> +	return 0;
> +}
> +
> +static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
> +static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
> +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> +{
> +	/*
> +	 * Accroding to Section 3.6.1 signal voltage switch procedure in

According

> +	 * SD Host Controller Simplified Spec. 4.20, the step 6~8 are the

s/the step/steps/

"as follows", maybe, instead of "the following" ?

> +	 * following:
> +	 * (6) Set 1.8V Signal Enable in the Host Control 2 register.
> +	 * (7) Wait 5ms. 1.8V voltage regulator shall be stable within this
> +	 *     period.
> +	 * (8) If 1.8V Signal Enable is cleared by Host Controller, go to
> +	 *     step (12).
> +	 *
> +	 * Wait 5ms after set 1.8V signal enable in Host Control 2 register
> +	 * to ensure 1.8V signal enable bit is set by GL9750/GL9755.
> +	 */
> +	usleep_range(5000, 5500);
> +}
> +
> +static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +	gli_set_9750(host);
> +}
> +
> +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> +{
> +	u32 value;
> +
> +	value = readl(host->ioaddr + reg);
> +	if (unlikely(reg == SDHCI_MAX_CURRENT && !(value & 0xff)))
> +		value |= 0xc8;
> +
> +	return value;
> +}
> +
> +static const struct sdhci_ops sdhci_gl9755_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9755 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9755,
> +	.ops            = &sdhci_gl9755_ops,
> +};
> +
> +static const struct sdhci_ops sdhci_gl9750_ops = {
> +	.read_l                 = sdhci_gl9750_readl,
> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_gl9750_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +	.platform_execute_tuning = gl9750_execute_tuning,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9750 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9750,
> +	.ops            = &sdhci_gl9750_ops,
> +};
> +
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e5dc6e44c7a4..738ba5afcc20 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -65,6 +65,9 @@
>  
>  #define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
>  
> +#define PCI_DEVICE_ID_GLI_9755		0x9755
> +#define PCI_DEVICE_ID_GLI_9750		0x9750
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -185,5 +188,7 @@ int sdhci_pci_enable_dma(struct sdhci_host *host);
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  extern const struct sdhci_pci_fixes sdhci_snps;
>  extern const struct sdhci_pci_fixes sdhci_o2;
> +extern const struct sdhci_pci_fixes sdhci_gl9750;
> +extern const struct sdhci_pci_fixes sdhci_gl9755;
>  
>  #endif /* __SDHCI_PCI_H */
