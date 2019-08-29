Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D896A1A8E
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2Mzv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 08:55:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:32467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfH2Mzv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 29 Aug 2019 08:55:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 05:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197799790"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 05:55:48 -0700
Subject: Re: [PATCH V8 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>
References: <1566412784-6224-1-git-send-email-shirley.her@bayhubtech.com>
 <4d926e9c-cb98-6587-f38d-426dd04d84de@intel.com>
 <BN6PR16MB14421161FCADC85B833B172D8BA30@BN6PR16MB1442.namprd16.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bdd42103-2794-0b61-0906-de4f08e403c1@intel.com>
Date:   Thu, 29 Aug 2019 15:54:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BN6PR16MB14421161FCADC85B833B172D8BA30@BN6PR16MB1442.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/08/19 8:10 PM, Shirley Her (SC) wrote:
> Hi, Adrian:
> 
> For the 1st comment, the array size of dmdn_table is DMDN_SZ and dll_adjust_count starts from 0. When its value reaches DMDN_SZ, it will break from while loop. By judging whether dll_adjust_count equals to DMDN_SZ should be OK.
> For the 2nd comment, we checked the patch by using checkpatch.pl and did not see any white space error. Can you let us know what version of checkpatch.pl are you running?

Yes you are right on both counts.  I have ack'ed the patch.

> 
> Thanks,
> Shirley
> 
> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com] 
> Sent: Wednesday, August 28, 2019 1:38 AM
> To: Shirley Her (SC) <shirley.her@bayhubtech.com>; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Chevron Li (WH) <chevron.li@bayhubtech.com>; Shaper Liu (WH) <shaper.liu@bayhubtech.com>; Louis Lu (TP) <louis.lu@bayhubtech.com>; Max Huang (SC) <max.huang@bayhubtech.com>
> Subject: Re: [PATCH V8 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data read/write DLL Lock phase shift issue
> 
> On 21/08/19 9:39 PM, Shirley Her (SC) wrote:
>> Fix data read/write error in HS200 mode due to chip DLL lock phase 
>> shift
>>
>> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
> 
> 2 comments below:
> 
>> ---
>> change in V8:
>>  1. fix patch format error
>>
>> change in V7:
>>  1. change subject
>>  2. change the sdhci_o2_wait_dll_detect_lock_function
>>  3. add suitable usleep_range() to detect dll lock status
>>
>> change in V6:
>>  1. define constant by using array size  2. add more explanation for 
>> the code  3. fix loop forever code error
>>
>> change in V5:
>>  1. split 2 patches into 3 patches
>>  2. make dll_adjust_count start from 0  3. fix ret overwritten issue  
>> 4. use break instead of goto
>>
>> change in V4:
>>  1. add a bug fix for V3
>>
>> change in V3:
>>  1. add more explanation in dll_recovery and execute_tuning function  
>> 2. move dll_adjust_count to O2_host struct  3. fix some coding style 
>> error  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
>>
>> change in V2:
>>  1. use usleep_range instead of udelay  2. move dll_adjust_count to 
>> sdhci-pci-o2micro.c
>>
>> chagne in V1:
>>  1. add error recovery function to relock DLL with correct phase  2. 
>> retuning HS200 after DLL locked
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 124 
>> ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 122 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c 
>> b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index 57c8b83..d879d91 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/mmc.h>
>>  #include <linux/delay.h>
>> +#include <linux/iopoll.h>
>>  
>>  #include "sdhci.h"
>>  #include "sdhci-pci.h"
>> @@ -55,9 +56,18 @@
>>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>>  #define  O2_PLL_SOFT_RESET	BIT(12)
>> +#define  O2_DLL_LOCK_STATUS	BIT(11)
>>  
>>  #define O2_SD_DETECT_SETTING 0x324
>>  
>> +static const u32 dmdn_table[] = {0x2B1C0000,
>> +	0x2C1A0000, 0x371B0000, 0x35100000}; #define DMDN_SZ 
>> +ARRAY_SIZE(dmdn_table)
>> +
>> +struct o2_host {
>> +	u8 dll_adjust_count;
>> +};
>> +
>>  static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)  
>> {
>>  	ktime_t timeout;
>> @@ -133,7 +143,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)  
>> {
>>  	struct sdhci_host *host = mmc_priv(mmc);
>>  
>> -	sdhci_o2_enable_internal_clock(host);
>> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
>> +		sdhci_o2_enable_internal_clock(host);
>>  
>>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & 
>> SDHCI_CARD_PRESENT);  } @@ -152,6 +163,25 @@ static void 
>> o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>>  			       O2_SD_PLL_SETTING, scratch_32);  }
>>  
>> +static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host) {
>> +	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1); }
>> +
>> +/*
>> + * This function is used to detect dll lock status.
>> + * Since the dll lock status bit will toggle randomly
>> + * with very short interval which needs to be polled
>> + * as fast as possible. Set sleep_us as 1 microsecond.
>> + */
>> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
>> +{
>> +	u32	scratch32 = 0;
>> +
>> +	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>> +		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 1, 1000000);
>> +}
>> +
>>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>>  {
>>  	u16 reg;
>> @@ -189,6 +219,83 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>>  	sdhci_reset_tuning(host);
>>  }
>>  
>> +/*
>> + * This function is used to fix o2 dll shift issue.
>> + * It isn't necessary to detect card present before recovery.
>> + * Firstly, it is used by bht emmc card, which is embedded.
>> + * Second, before call recovery card present will be detected
>> + * outside of the execute tuning function.
>> + */
>> +static int sdhci_o2_dll_recovery(struct sdhci_host *host)
>> +{
>> +	int ret = 0;
>> +	u8 scratch_8 = 0;
>> +	u32 scratch_32 = 0;
>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +	struct sdhci_pci_chip *chip = slot->chip;
>> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>> +
>> +	/* UnLock WP */
>> +	pci_read_config_byte(chip->pdev,
>> +			O2_SD_LOCK_WP, &scratch_8);
>> +	scratch_8 &= 0x7f;
>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>> +	while (o2_host->dll_adjust_count < DMDN_SZ && !ret) {
>> +		/* Disable clock */
>> +		sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
>> +
>> +		/* PLL software reset */
>> +		scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>> +		scratch_32 |= O2_PLL_SOFT_RESET;
>> +		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
>> +
>> +		pci_read_config_dword(chip->pdev,
>> +					    O2_SD_FUNC_REG4,
>> +					    &scratch_32);
>> +		/* Enable Base Clk setting change */
>> +		scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
>> +		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
>> +		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
>> +
>> +		/* Enable internal clock */
>> +		scratch_8 = SDHCI_CLOCK_INT_EN;
>> +		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
>> +
>> +		if (sdhci_o2_get_cd(host->mmc)) {
>> +			/*
>> +			 * need wait at least 5ms for dll status stable,
>> +			 * after enable internal clock
>> +			 */
>> +			usleep_range(5000, 6000);
>> +			if (sdhci_o2_wait_dll_detect_lock(host)) {
>> +				scratch_8 |= SDHCI_CLOCK_CARD_EN;
>> +				sdhci_writeb(host, scratch_8,
>> +					SDHCI_CLOCK_CONTROL);
>> +				ret = 1;
>> +			} else {
>> +				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
>> +					mmc_hostname(host->mmc),
>> +					o2_host->dll_adjust_count);
>> +			}
>> +		} else {
>> +			pr_err("%s: card present detect failed.\n",
>> +				mmc_hostname(host->mmc));
>> +			break;
>> +		}
>> +
>> +		o2_host->dll_adjust_count++;
>> +	}
>> +	if (!ret && o2_host->dll_adjust_count == DMDN_SZ)
> 
> As I wrote in reply to V7, isn't this off by 1? i.e. should be
> o2_host->dll_adjust_count > DMDN_SZ
> 
>> +		pr_err("%s: DLL adjust over max times\n",
>> +		mmc_hostname(host->mmc));
>> +	/* Lock WP */
>> +	pci_read_config_byte(chip->pdev,
>> +				   O2_SD_LOCK_WP, &scratch_8);
>> +	scratch_8 |= 0x80;
>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>> +	return ret;
>> +}
>> +
>>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  {
>>  	struct sdhci_host *host = mmc_priv(mmc);
>> @@ -203,7 +310,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  
>>  	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
>>  		return -EINVAL;
>> -
>> +	/*
>> +	 * Judge the tuning reason, whether caused by dll shift
>> +	 * If cause by dll shift, should call sdhci_o2_dll_recovery
>> +	 */
>> +	if (!sdhci_o2_wait_dll_detect_lock(host))
>> +		if (!sdhci_o2_dll_recovery(host)) {
>> +			pr_err("%s: o2 dll recovery failed\n",
>> +				mmc_hostname(host->mmc));
>> +			return -EINVAL;
>> +		}
>>  	/*
>>  	 * o2 sdhci host didn't support 8bit emmc tuning
>>  	 */
>> @@ -371,6 +487,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>>  	clk |= SDHCI_CLOCK_INT_EN;
>>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>  
>> +	sdhci_o2_enable_internal_clock(host);
>>  	if (sdhci_o2_get_cd(host->mmc)) {
>>  		clk |= SDHCI_CLOCK_CARD_EN;
>>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> @@ -396,12 +513,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>  {
>>  	struct sdhci_pci_chip *chip;
>>  	struct sdhci_host *host;
>> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>>  	u32 reg, caps;
>>  	int ret;
>>  
>>  	chip = slot->chip;
>>  	host = slot->host;
>>  
>> +	o2_host->dll_adjust_count = 0;
> 
> As I wrote in reply to V7, please remove trailing white space after
> "o2_host->dll_adjust_count = 0;"
> 
>>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>  
>>  	/*
>> @@ -688,4 +807,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>>  	.resume = sdhci_pci_o2_resume,
>>  #endif
>>  	.ops = &sdhci_pci_o2_ops,
>> +	.priv_size = sizeof(struct o2_host),
>>  };
>>
> 

