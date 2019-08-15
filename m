Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4138E99A
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2019 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfHOLI0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 07:08:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:28888 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730300AbfHOLI0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Aug 2019 07:08:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184593310"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:08:23 -0700
Subject: Re: [PATCH V6 2/3] mmc: sdhci: Modify get CD status function
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
References: <1565372322-4667-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <16f15218-daa2-e22c-2174-416387323072@intel.com>
Date:   Thu, 15 Aug 2019 14:07:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565372322-4667-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/08/19 8:38 PM, Shirley Her (SC) wrote:
> Modify get CD status function

Please change the subject to:

mmc: sdhci-pci-o2micro: Move functions in preparation to fix DLL lock phase shift issue

Please change the commit message accordingly.

Also this patch should not make any changes except moving
functions, see comment further below.

> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
> ---
> change in V6:
>  1. change subjec and commit message to match the patch
>  2. modify the get CD status function
>  3. re-arrange the order of some functions
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 188 ++++++++++++++++++-----------------
>  1 file changed, 95 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b3a33d9..c780888 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -58,6 +58,101 @@
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	/* Wait max 50 ms */
> +	timeout = ktime_add_ms(ktime_get(), 50);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> +		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> +			break;
> +
> +		if (timedout) {
> +			pr_err("%s: Card Detect debounce never finished.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +
> +static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u16 scratch;
> +	u32 scratch32;
> +
> +	/* PLL software reset */
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 |= O2_PLL_SOFT_RESET;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +	udelay(1);
> +	scratch32 &= ~(O2_PLL_SOFT_RESET);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* PLL force active */
> +	scratch32 |= O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (scratch & O2_PLL_LOCK_STATUS)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			goto out;
> +		}
> +		udelay(10);
> +	}
> +
> +	/* Wait for card detect finish */
> +	udelay(1);
> +	sdhci_o2_wait_card_detect_stable(host);
> +
> +out:
> +	/* Cancel PLL force active */
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +static int sdhci_o2_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))

This patch should not make any changes except moving the functions.

> +		sdhci_o2_enable_internal_clock(host);
> +
> +	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> +}
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
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -136,19 +231,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	return 0;
>  }
>  
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> -{
> -	u32 scratch_32;
> -	pci_read_config_dword(chip->pdev,
> -			      O2_SD_PLL_SETTING, &scratch_32);
> -
> -	scratch_32 &= 0x0000FFFF;
> -	scratch_32 |= value;
> -
> -	pci_write_config_dword(chip->pdev,
> -			       O2_SD_PLL_SETTING, scratch_32);
> -}
> -
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>  {
>  	int ret;
> @@ -284,86 +366,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  	host->irq = pci_irq_vector(chip->pdev, 0);
>  }
>  
> -static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u32 scratch32;
> -
> -	/* Wait max 50 ms */
> -	timeout = ktime_add_ms(ktime_get(), 50);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> -		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> -			break;
> -
> -		if (timedout) {
> -			pr_err("%s: Card Detect debounce never finished.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			return;
> -		}
> -		udelay(10);
> -	}
> -}
> -
> -static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u16 scratch;
> -	u32 scratch32;
> -
> -	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -	udelay(1);
> -	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -	/* PLL force active */
> -	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> -		if (scratch & O2_PLL_LOCK_STATUS)
> -			break;
> -		if (timedout) {
> -			pr_err("%s: Internal clock never stabilised.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			goto out;
> -		}
> -		udelay(10);
> -	}
> -
> -	/* Wait for card detect finish */
> -	udelay(1);
> -	sdhci_o2_wait_card_detect_stable(host);
> -
> -out:
> -	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -}
> -
> -static int sdhci_o2_get_cd(struct mmc_host *mmc)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -
> -	sdhci_o2_enable_internal_clock(host);
> -
> -	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> -}
> -
>  static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  {
>  	/* Enable internal clock */
> 

