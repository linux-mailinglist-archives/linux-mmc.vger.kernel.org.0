Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8F8E99C
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2019 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfHOLIp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 07:08:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:40208 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbfHOLIp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Aug 2019 07:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184593363"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:08:42 -0700
Subject: Re: [PATCH V6 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
References: <1565372331-4716-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <47cb4374-4237-05c8-d822-a686bafc7cc9@intel.com>
Date:   Thu, 15 Aug 2019 14:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565372331-4716-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/08/19 8:38 PM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Please change subject to:

mmc: sdhci-pci-o2micro: Fix O2 Host data read/write DLL Lock Phase shift issue

> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
> ---
> change in V6:
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 128 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index c780888..8cb516d 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -55,9 +55,18 @@
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
> @@ -153,6 +162,38 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  			       O2_SD_PLL_SETTING, scratch_32);
>  }
>  
> +/*
> + * This function is used to detect dll lock status.
> + * Before detect, need wait 5ms for dll status stable.
> + * In order to detect the toggle of dll lock status bit,
> + * we should fast polling this bit status without delay.
> + */
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
> +	/* Detect 1 s */
> +	timeout = ktime_add_ms(ktime_get(), 1000);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (!(scratch32 & O2_DLL_LOCK_STATUS))
> +			return 0;
> +
> +		if (timedout)
> +			return 1;

Please put a suitable usleep_range() here

> +	}
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -190,6 +231,78 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
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
> @@ -204,7 +317,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
> @@ -372,6 +494,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> +	sdhci_o2_enable_internal_clock(host);
>  	if (sdhci_o2_get_cd(host->mmc)) {
>  		clk |= SDHCI_CLOCK_CARD_EN;
>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -397,12 +520,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
>  	/*
> @@ -689,4 +814,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>  	.resume = sdhci_pci_o2_resume,
>  #endif
>  	.ops = &sdhci_pci_o2_ops,
> +	.priv_size = sizeof(struct o2_host),
>  };
> 

