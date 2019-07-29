Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1023078B75
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Jul 2019 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfG2MOG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Jul 2019 08:14:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:37319 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfG2MOG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Jul 2019 08:14:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 05:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="176380914"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2019 05:14:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock
 Phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>
References: <1564166909-7437-1-git-send-email-shirley.her@bayhubtech.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0ce0b72d-46f6-ee06-092b-abb0d656c083@intel.com>
Date:   Mon, 29 Jul 2019 15:12:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564166909-7437-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/07/19 9:48 PM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift

More explanation is needed.  See comment below where
sdhci_o2_error_recovery() is called.

> 
> Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
> ---
> change in V2:
>   1. Use usleep_range instead of udelay
>   2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> change in V1:
>   1. Add error recovery function to relock the DLL with correct phase
>   2. Retuning HS200 after DLL locked
> ---
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 157 +++++++++++++++++++++++++++++------
>  1 file changed, 133 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548..c43b2ce 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -51,13 +51,60 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_DISABLE	BIT(4)
>  
> -#define O2_PLL_WDT_CONTROL1	0x1CC
> +#define O2_PLL_DLL_WDT_CONTROL1	0x1CC

Renaming O2_PLL_WDT_CONTROL1 should be a separate patch.

>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> +#define  O2_DLL_LOCK_STATUS	BIT(11)
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static const u32 dmdn_table[5] = {0x25100000, 0x2B1C0000,
> +	0x2C1A0000, 0x371B0000, 0x35100000};
> +static u8 dll_adjust_count;

This should be in a struct:

struct o2_host {
	u8 dll_adjust_count;
}


> +static int sdhci_o2_get_cd(struct mmc_host *mmc);

Please make a separate patch that reorders the functions so that forward
declaration of sdhci_o2_get_cd() is not necessary.

> +
> +static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> +{
> +	u32 scratch_32;
> +
> +	pci_read_config_dword(chip->pdev,
> +			      O2_SD_PLL_SETTING, &scratch_32);
> +
> +	scratch_32 &= 0x0000FFFF;
> +	scratch_32 |= value;
> +
> +	pci_write_config_dword(chip->pdev,
> +			       O2_SD_PLL_SETTING, scratch_32);
> +}
> +
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	usleep_range(5000, 6000);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
> +		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
> +			mmc_hostname(host->mmc));
> +	}
> +
> +	/* Detect 500 ms */
> +	timeout = ktime_add_ms(ktime_get(), 500);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (!(scratch32 & O2_DLL_LOCK_STATUS))
> +			return 0;
> +
> +		if (timedout)
> +			return 1;
> +		usleep_range(10, 1000);
> +	}
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -95,11 +142,85 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	sdhci_reset_tuning(host);
>  }
>  
> +static int sdhci_o2_error_recovery(struct sdhci_pci_chip *chip,
> +				 struct sdhci_host *host)
> +{
> +	int ret = 0;
> +	u8 scratch_8 = 0;
> +	u32 scratch_32 = 0;

Please add a blank line after local variable declaration

> +	/* Disable clock */
> +	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +DLL_ADJUST:

Please use a 'do', 'for' or 'while' loop.

> +	if (dll_adjust_count >= 5) {
> +		dll_adjust_count = 4;
> +		pr_warn("%s: error recovery failed with the dll_adjust_count over max value.\n",
> +			mmc_hostname(host->mmc));

Isn't it necessary to exit the loop here?

> +	}
> +
> +	/* UnLock WP */
> +	ret = pci_read_config_byte(chip->pdev,
> +			O2_SD_LOCK_WP, &scratch_8);
> +	if (ret)
> +		return ret;
> +
> +	scratch_8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +	/* PLL software reset */
> +	scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch_32 |= O2_PLL_SOFT_RESET;
> +	sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	ret = pci_read_config_dword(chip->pdev,
> +				    O2_SD_FUNC_REG4,
> +				    &scratch_32);
> +	/* Enable Base Clk setting change */
> +	scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> +	pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
> +	o2_pci_set_baseclk(chip, dmdn_table[dll_adjust_count]);
> +
> +

Please don't use multiple blank lines

> +	/* Enable internal clock */
> +	scratch_8 = SDHCI_CLOCK_INT_EN;
> +	sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
> +
> +	if (sdhci_o2_get_cd(host->mmc)) {
> +		if (sdhci_o2_wait_dll_detect_lock(host)) {
> +			scratch_8 |= SDHCI_CLOCK_CARD_EN;
> +			sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
> +			ret = 1;
> +		} else {
> +

Blank lines aren't necessary after an open brace '{'

> +			pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
> +			mmc_hostname(host->mmc), dll_adjust_count);
> +			dll_adjust_count++;
> +			goto DLL_ADJUST;
> +		}
> +	} else
> +		goto DLL_ADJUST;

braces {} should be used on all arms of this statement

> +
> +		/* Lock WP */
> +	ret = pci_read_config_byte(chip->pdev,
> +				   O2_SD_LOCK_WP, &scratch_8);
> +	if (ret)
> +		return ret;
> +	scratch_8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	return ret;
> +}
> +
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);

This is how you get a reference to o2_host:

	struct o2_host *o2_host = sdhci_pci_priv(slot);

>  	int current_bus_width = 0;
>  
> +

Please don't use multiple blank lines

> +	if (dll_adjust_count)

dll_adjust_count should be in struct o2_host

	o2_host->dll_adjust_count

> +		sdhci_o2_error_recovery(slot->chip, host);

Tuning will be executed whenever the system resumes, which is not an error.
Can you explain when error recovery is needed, and how this patch works.

> +
> +	dll_adjust_count++;
>  	/*
>  	 * This handler only implements the eMMC tuning that is specific to
>  	 * this controller.  Fall back to the standard method for other TIMING.
> @@ -131,23 +252,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>  		sdhci_set_bus_width(host, current_bus_width);
>  	}
> -

Please avoid unrelated white space changes.

>  	host->flags &= ~SDHCI_HS400_TUNING;
>  	return 0;
>  }
>  
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> -{
> -	u32 scratch_32;
> -	pci_read_config_dword(chip->pdev,
> -			      O2_SD_PLL_SETTING, &scratch_32);
>  
> -	scratch_32 &= 0x0000FFFF;
> -	scratch_32 |= value;
> -
> -	pci_write_config_dword(chip->pdev,
> -			       O2_SD_PLL_SETTING, scratch_32);
> -}
>  
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>  {
> @@ -316,23 +425,23 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  	u32 scratch32;
>  
>  	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  	udelay(1);
>  	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* PLL force active */
>  	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* Wait max 20 ms */
>  	timeout = ktime_add_ms(ktime_get(), 20);
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> -		scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
>  		if (scratch & O2_PLL_LOCK_STATUS)
>  			break;
>  		if (timedout) {
> @@ -350,16 +459,16 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  
>  out:
>  	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  }
>  
>  static int sdhci_o2_get_cd(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -

Please keep the blank line after declarations.

> -	sdhci_o2_enable_internal_clock(host);
> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
> +		sdhci_o2_enable_internal_clock(host);
>  
>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
> @@ -369,7 +478,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  	/* Enable internal clock */
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
> +	sdhci_o2_enable_internal_clock(host);
>  	if (sdhci_o2_get_cd(host->mmc)) {
>  		clk |= SDHCI_CLOCK_CARD_EN;
>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -400,7 +509,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  
>  	chip = slot->chip;
>  	host = slot->host;
> -
> +	dll_adjust_count = 0;
>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
>  	/*
> 

Set up o2_host like this:

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c
b/drivers/mmc/host/sdhci-pci-o2micro.c
index c43b2cecdf30..cfe57f23dcf1 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -796,4 +796,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
 	.resume = sdhci_pci_o2_resume,
 #endif
 	.ops = &sdhci_pci_o2_ops,
+	.priv_size = sizeof(struct o2_host),
 };
