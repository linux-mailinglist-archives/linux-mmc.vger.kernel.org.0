Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3883076
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Aug 2019 13:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfHFLRR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 6 Aug 2019 07:17:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33006 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFLRQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Aug 2019 07:17:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x76BGnrA082997;
        Tue, 6 Aug 2019 06:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565090209;
        bh=1Qpae6tF/7leTao4sxzBGaO6r1r8dpoNg/I6HCnEums=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IMf8eS7zc6KNAbTqU4+AKeRs/r0LZ/lyzyrN879qbBTJ5OUSMo8D/ihOKcfgRsD+L
         F+NRSRQjAkE+VjWFyLbfsHyfbIy9uRkLRjww5I8wbt7aKa+qA5692uSiChS4NVaSxE
         kZ3qKGwGC7x3Hlv6c4ifqzhu3q1kFfu3XmoS5Erw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x76BGnHL002634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Aug 2019 06:16:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 06:16:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 6 Aug 2019 06:16:48 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x76BGkGK027908;
        Tue, 6 Aug 2019 06:16:46 -0500
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add CQHCI support for arasan,
 sdhci-5.1
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
References: <1515739370-102434-1-git-send-email-shawn.lin@rock-chips.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <91476bc6-aa63-ee5d-8f82-6874b9b13e79@ti.com>
Date:   Tue, 6 Aug 2019 16:47:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1515739370-102434-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

On 12/01/18 12:12 PM, Shawn Lin wrote:
> Add CQHCI initialization and implement CQHCI operations for Arasan
> SDHCI variant host, namely arasan,sdhci-5.1, which is used by Rockchip
> RK3399 platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
>  drivers/mmc/host/Kconfig           |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c | 137 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 131 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2fda095..45aed90 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -133,6 +133,7 @@ config MMC_SDHCI_OF_ARASAN
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
>  	depends on COMMON_CLK
> +	select MMC_CQHCI
>  	help
>  	  This selects the Arasan Secure Digital Host Controller Interface
>  	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index fb57206..e30c84f 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -25,11 +25,13 @@
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> -#include "sdhci-pltfm.h"
>  #include <linux/of.h>
>  
> -#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
> +#include "cqhci.h"
> +#include "sdhci-pltfm.h"
>  
> +#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
> +#define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
>  
>  #define PHY_CLK_TOO_SLOW_HZ		400000
> @@ -90,6 +92,7 @@ struct sdhci_arasan_data {
>  	struct phy	*phy;
>  	bool		is_phy_on;
>  
> +	bool		has_cqe;
>  	struct clk_hw	sdcardclk_hw;
>  	struct clk      *sdcardclk;
>  
> @@ -290,6 +293,61 @@ static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>  
> +static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static void sdhci_arasan_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static void sdhci_arasan_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (reg & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	}

Sorry for replying to old thread.

I am also trying to implement command queuing for my driver and was
wondering why you needed to do this. Did you see some issues without
clearing the buffer? Wouldn't an SRD reset have got rid of any residual
data in the buffer? Why is there residual data in the buffer in the
first place?

Thanks,
Faiz
