Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC9977E2
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHULZk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 07:25:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:42567 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHULZk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Aug 2019 07:25:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 04:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="181001058"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2019 04:25:35 -0700
Subject: Re: Subject: [PATCH V7 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock Phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
References: <1566252696-5206-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <22a84716-f33d-f4d5-0053-ab52c22cf1b8@intel.com>
Date:   Wed, 21 Aug 2019 14:24:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566252696-5206-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/19 1:11 AM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>

Please do not prefix the subject by "Subject: "
Please put a space after Signed-off-by:

> ---
> change in V7:
>  1. change subject
>  2. change the sdhci_o2_wait_dll_detect_lock function
>  3. add suitable usleep_range() to detect dll lock status
> 
> chagne in V6:
>  1. define constant by using array size
>  2. add more explanation for the code
>  3. fix loop forever code error
> 
> change in V5:
>  1. split 2 patches into 3 patches
>  2. make dll_adjust_count start from 0
>  3. fix ret overwritten issue
>  4. use break instead of goto
> 
> change in V4:
>  1. add a bug fix for V3
> 
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
> 
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 125 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 021e481..f0b3d93 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -11,6 +11,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -55,9 +56,18 @@
>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> +#define  O2_DLL_LOCK_STATUS	BIT(11)
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static const u32 dmdn_table[] = {0x2B1C0000,
> +	0x2C1A0000, 0x371B0000, 0x35100000};
> +#define DMDN_SZ ARRAY_SIZE(dmdn_table)
> +
> +struct o2_host {
> +	u8 dll_adjust_count;
> +};
> +
>  static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
>  {
>  	ktime_t timeout;
> @@ -133,7 +143,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	sdhci_o2_enable_internal_clock(host);
> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
> +		sdhci_o2_enable_internal_clock(host);
>  
>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
> @@ -141,6 +152,7 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  {
>  	u32 scratch_32;
> +
>  	pci_read_config_dword(chip->pdev,
>  			      O2_SD_PLL_SETTING, &scratch_32);
>  
> @@ -151,6 +163,25 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  			       O2_SD_PLL_SETTING, scratch_32);
>  }
>  
> +static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host)
> +{
> +	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +/*
> + * This function is used to detect dll lock status.
> + * Since the dll lock status bit will toggle randomly
> + * with very short interval which needs to be polled
> + * as fast as possible. Set sleep_us as 1 microsecond.
> + */
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +	u32	scratch32 = 0;
> +
> +	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
> +		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 1, 1000000);
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -188,6 +219,83 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	sdhci_reset_tuning(host);
>  }
>  
> +/*
> + * This function is used to fix o2 dll shift issue.
> + * It isn't necessary to detect card present before recovery.
> + * Firstly, it is used by bht emmc card, which is embedded.
> + * Second, before call recovery card present will be detected
> + * outside of the execute tuning function.
> + */
> +static int sdhci_o2_dll_recovery(struct sdhci_host *host)
> +{
> +	int ret = 0;
> +	u8 scratch_8 = 0;
> +	u32 scratch_32 = 0;
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct sdhci_pci_chip *chip = slot->chip;
> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
> +
> +	/* UnLock WP */
> +	pci_read_config_byte(chip->pdev,
> +			O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	while (o2_host->dll_adjust_count < DMDN_SZ && !ret) {
> +		/* Disable clock */
> +		sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +		/* PLL software reset */
> +		scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		scratch_32 |= O2_PLL_SOFT_RESET;
> +		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +		pci_read_config_dword(chip->pdev,
> +					    O2_SD_FUNC_REG4,
> +					    &scratch_32);
> +		/* Enable Base Clk setting change */
> +		scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> +		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
> +		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
> +
> +		/* Enable internal clock */
> +		scratch_8 = SDHCI_CLOCK_INT_EN;
> +		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
> +
> +		if (sdhci_o2_get_cd(host->mmc)) {
> +			/*
> +			 * need wait at least 5ms for dll status stable,
> +			 * after enable internal clock
> +			 */
> +			usleep_range(5000, 6000);
> +			if (sdhci_o2_wait_dll_detect_lock(host)) {
> +				scratch_8 |= SDHCI_CLOCK_CARD_EN;
> +				sdhci_writeb(host, scratch_8,
> +					SDHCI_CLOCK_CONTROL);
> +				ret = 1;
> +			} else {
> +				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
> +					mmc_hostname(host->mmc),
> +					o2_host->dll_adjust_count);
> +			}
> +		} else {
> +			pr_err("%s: card present detect failed.\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +
> +		o2_host->dll_adjust_count++;
> +	}
> +	if (!ret && o2_host->dll_adjust_count == DMDN_SZ)

Isn't this off by 1? i.e. should be o2_host->dll_adjust_count > DMDN_SZ

> +		pr_err("%s: DLL adjust over max times\n",
> +		mmc_hostname(host->mmc));
> +	/* Lock WP */
> +	pci_read_config_byte(chip->pdev,
> +				   O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	return ret;
> +}
> +
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -202,7 +310,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
>  		return -EINVAL;
> -
> +	/*
> +	 * Judge the tuning reason, whether caused by dll shift
> +	 * If cause by dll shift, should call sdhci_o2_dll_recovery
> +	 */
> +	if (!sdhci_o2_wait_dll_detect_lock(host))
> +		if (!sdhci_o2_dll_recovery(host)) {
> +			pr_err("%s: o2 dll recovery failed\n",
> +				mmc_hostname(host->mmc));
> +			return -EINVAL;
> +		}
>  	/*
>  	 * o2 sdhci host didn't support 8bit emmc tuning
>  	 */
> @@ -370,6 +487,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> +	sdhci_o2_enable_internal_clock(host);
>  	if (sdhci_o2_get_cd(host->mmc)) {
>  		clk |= SDHCI_CLOCK_CARD_EN;
>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -395,12 +513,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>  	u32 reg, caps;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
>  
> +	o2_host->dll_adjust_count = 0;	

Please remove trailing white space after "o2_host->dll_adjust_count = 0;"

>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
>  	/*
> @@ -687,4 +807,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>  	.resume = sdhci_pci_o2_resume,
>  #endif
>  	.ops = &sdhci_pci_o2_ops,
> +	.priv_size = sizeof(struct o2_host),
>  };
> 

