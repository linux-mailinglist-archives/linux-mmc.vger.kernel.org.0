Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77CBC3EE
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Sep 2019 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409217AbfIXIMk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Sep 2019 04:12:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:31745 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409380AbfIXIMk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Sep 2019 04:12:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 01:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="179409082"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2019 01:12:33 -0700
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yinbo Zhu <yinbo.zhu@nxp.com>
References: <20190917044631.3161-1-yangbo.lu@nxp.com>
 <20190917044631.3161-4-yangbo.lu@nxp.com>
 <0e8f0c12-093f-4235-27ec-88db734fa662@intel.com>
 <VI1PR0401MB22373BC252B36CF32C2AFB4EF8840@VI1PR0401MB2237.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d9d347ae-384c-50ab-7d6a-38e9b000e057@intel.com>
Date:   Tue, 24 Sep 2019 11:11:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB22373BC252B36CF32C2AFB4EF8840@VI1PR0401MB2237.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/19 6:11 AM, Y.b. Lu wrote:
> Hi Adrian,
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org <linux-mmc-owner@vger.kernel.org>
>> On Behalf Of Adrian Hunter
>> Sent: Monday, September 23, 2019 8:56 PM
>> To: Y.b. Lu <yangbo.lu@nxp.com>; linux-mmc@vger.kernel.org; Ulf Hansson
>> <ulf.hansson@linaro.org>
>> Cc: Yinbo Zhu <yinbo.zhu@nxp.com>
>> Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
>> workaround
>>
>> On 17/09/19 7:46 AM, Yangbo Lu wrote:
>>> A previous patch implemented an incomplete workaround of erratum
>>> A-008171. The complete workaround is as below. This patch is to
>>> implement the complete workaround which uses SW tuning if HW tuning
>>> fails, and retries both HW/SW tuning once with reduced clock if
>>> workaround fails. This is suggested by hardware team, and the patch
>>> had been verified on LS1046A eSDHC + Phison 32G eMMC which could
>>> trigger the erratum.
>>>
>>> Workaround:
>>> /* For T1040, T2080, LS1021A, T1023 Rev 1: */ 1. Program
>>> TBPTR[TB_WNDW_END_PTR] = 3*DIV_RATIO.
>>> 2. Program TBPTR[TB_WNDW_START_PTR] = 5*DIV_RATIO.
>>> 3. Program the software tuning mode by setting TBCTL[TB_MODE] = 2'h3.
>>> 4. Set SYSCTL2[EXTN] and SYSCTL2[SAMPCLKSEL].
>>> 5. Issue SEND_TUNING_BLK Command (CMD19 for SD, CMD21 for MMC).
>>> 6. Wait for IRQSTAT[BRR], buffer read ready, to be set.
>>> 7. Clear IRQSTAT[BRR].
>>> 8. Check SYSCTL2[EXTN] to be cleared.
>>> 9. Check SYSCTL2[SAMPCLKSEL], Sampling Clock Select. It's set value
>>>    indicate tuning procedure success, and clear indicate failure.
>>>    In case of tuning failure, fixed sampling scheme could be used by
>>>    clearing TBCTL[TB_EN].
>>> /* For LS1080A Rev 1, LS2088A Rev 1.0, LA1575A Rev 1.0: */ 1. Read the
>>> TBCTL[31:0] register. Write TBCTL[11:8]=4'h8 and wait for
>>>    1ms.
>>> 2. Read the TBCTL[31:0] register and rewrite again. Wait for 1ms second.
>>> 3. Read the TBSTAT[31:0] register twice.
>>> 3.1 Reset data lines by setting ESDHCCTL[RSTD] bit.
>>> 3.2 Check ESDHCCTL[RSTD] bit.
>>> 3.3 If ESDHCCTL[RSTD] is 0, go to step 3.4 else go to step 3.2.
>>> 3.4 Write 32'hFFFF_FFFF to IRQSTAT register.
>>> 4. if TBSTAT[15:8]-TBSTAT[7:0] > 4*DIV_RATIO or TBSTAT[7:0]-TBSTAT[15:8]
>>>    > 4*DIV_RATIO , then program TBPTR[TB_WNDW_END_PTR] =
>> 4*DIV_RATIO and
>>>    program TBPTR[TB_WNDW_START_PTR] = 8*DIV_RATIO.
>>> /* For LS1012A Rev1, LS1043A Rev 1.x, LS1046A 1.0: */ 1. Read the
>>> TBCTL[0:31] register. Write TBCTL[20:23]=4'h8 and wait for
>>>    1ms.
>>> 2. Read the TBCTL[0:31] register and rewrite again. Wait for 1ms second.
>>> 3. Read the TBSTAT[0:31] register twice.
>>> 3.1 Reset data lines by setting ESDHCCTL[RSTD] bit.
>>> 3.2 Check ESDHCCTL[RSTD] bit.
>>> 3.3 If ESDHCCTL[RSTD] is 0, go to step 3.4 else go to step 3.2.
>>> 3.4 Write 32'hFFFF_FFFF to IRQSTAT register.
>>> 4. if TBSTAT[16:23]-TBSTAT[24:31] > 4*DIV_RATIO or TBSTAT[24:31]-
>>>    TBSTAT[16:23] > 4* DIV_RATIO , then program
>> TBPTR[TB_WNDW_END_PTR] =
>>>    4*DIV_RATIO and program TBPTR[TB_WNDW_START_PTR] =
>> 8*DIV_RATIO.
>>> /* For LS1080A Rev 1, LS2088A Rev 1.0, LA1575A Rev 1.0 LS1012A Rev1,
>>>  * LS1043A Rev 1.x, LS1046A 1.0:
>>>  */
>>> 5. else program TBPTR[TB_WNDW_END_PTR] = 3*DIV_RATIO and program
>>>    TBPTR[TB_WNDW_START_PTR] = 5*DIV_RATIO.
>>> 6. Program the software tuning mode by setting TBCTL[TB_MODE] = 2'h3.
>>> 7. Set SYSCTL2[EXTN], wait 1us and SYSCTL2[SAMPCLKSEL].
>>> 8. Issue SEND_TUNING_BLK Command (CMD19 for SD, CMD21 for MMC).
>>> 9. Wait for IRQSTAT[BRR], buffer read ready, to be set.
>>> 10. Clear IRQSTAT[BRR].
>>> 11. Check SYSCTL2[EXTN] to be cleared.
>>> 12. Check SYSCTL2[SAMPCLKSEL], Sampling Clock Select. It's set value
>>>     indicate tuning procedure success, and clear indicate failure.
>>>     In case of tuning failure, fixed sampling scheme could be used by
>>>     clearing TBCTL[TB_EN].
>>>
>>> Fixes: b1f378ab5334 ("mmc: sdhci-of-esdhc: add erratum A008171
>>> support")
>>> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
>>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc.h    |   9 ++
>>>  drivers/mmc/host/sdhci-of-esdhc.c | 216
>>> ++++++++++++++++++++++++++++++++------
>>>  2 files changed, 192 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc.h
>>> b/drivers/mmc/host/sdhci-esdhc.h index 57b582b..e88dee5 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc.h
>>> +++ b/drivers/mmc/host/sdhci-esdhc.h
>>> @@ -59,7 +59,16 @@
>>>  #define ESDHC_HS400_WNDW_ADJUST		0x00000040
>>>  #define ESDHC_HS400_MODE		0x00000010
>>>  #define ESDHC_TB_EN			0x00000004
>>> +#define ESDHC_TB_MODE_MASK		0x00000003
>>> +#define ESDHC_TB_MODE_SW		0x00000003
>>> +#define ESDHC_TB_MODE_3			0x00000002
>>> +
>>> +#define ESDHC_TBSTAT			0x124
>>> +
>>>  #define ESDHC_TBPTR			0x128
>>> +#define ESDHC_WNDW_STRT_PTR_SHIFT	8
>>> +#define ESDHC_WNDW_STRT_PTR_MASK	(0x7f << 8)
>>> +#define ESDHC_WNDW_END_PTR_MASK		0x7f
>>>
>>>  /* SD Clock Control Register */
>>>  #define ESDHC_SDCLKCTL			0x144
>>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
>>> b/drivers/mmc/host/sdhci-of-esdhc.c
>>> index a01d3a5..ea8d35f 100644
>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>>> @@ -77,8 +77,10 @@ struct sdhci_esdhc {
>>>  	bool quirk_incorrect_hostver;
>>>  	bool quirk_limited_clk_division;
>>>  	bool quirk_unreliable_pulse_detection;
>>> -	bool quirk_fixup_tuning;
>>> +	bool quirk_tuning_erratum_type1;
>>> +	bool quirk_tuning_erratum_type2;
>>>  	bool quirk_ignore_data_inhibit;
>>> +	bool in_sw_tuning;
>>>  	unsigned int peripheral_clock;
>>>  	const struct esdhc_clk_fixup *clk_fixup;
>>>  	u32 div_ratio;
>>> @@ -806,16 +808,21 @@ static int esdhc_signal_voltage_switch(struct
>> mmc_host *mmc,
>>>  	}
>>>  }
>>>
>>> -static struct soc_device_attribute soc_fixup_tuning[] = {
>>> +static struct soc_device_attribute soc_tuning_erratum_type1[] = {
>>> +	{ .family = "QorIQ T1023", .revision = "1.0", },
>>>  	{ .family = "QorIQ T1040", .revision = "1.0", },
>>>  	{ .family = "QorIQ T2080", .revision = "1.0", },
>>> -	{ .family = "QorIQ T1023", .revision = "1.0", },
>>>  	{ .family = "QorIQ LS1021A", .revision = "1.0", },
>>> -	{ .family = "QorIQ LS1080A", .revision = "1.0", },
>>> -	{ .family = "QorIQ LS2080A", .revision = "1.0", },
>>> +	{ },
>>> +};
>>> +
>>> +static struct soc_device_attribute soc_tuning_erratum_type2[] = {
>>>  	{ .family = "QorIQ LS1012A", .revision = "1.0", },
>>>  	{ .family = "QorIQ LS1043A", .revision = "1.*", },
>>>  	{ .family = "QorIQ LS1046A", .revision = "1.0", },
>>> +	{ .family = "QorIQ LS1080A", .revision = "1.0", },
>>> +	{ .family = "QorIQ LS2080A", .revision = "1.0", },
>>> +	{ .family = "QorIQ LA1575A", .revision = "1.0", },
>>>  	{ },
>>>  };
>>>
>>> @@ -856,15 +863,97 @@ static void esdhc_tuning_block_enable(struct
>> sdhci_host *host, bool enable)
>>>  	esdhc_clock_enable(host, true);
>>>  }
>>>
>>> +static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8
>> *window_start,
>>> +				    u8 *window_end)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>>> +	u8 tbstat_15_8, tbstat_7_0;
>>> +	u32 val;
>>> +
>>> +	if (esdhc->quirk_tuning_erratum_type1) {
>>> +		*window_start = 5 * esdhc->div_ratio;
>>> +		*window_end = 3 * esdhc->div_ratio;
>>> +		return;
>>> +	}
>>> +
>>> +	/* Write TBCTL[11:8]=4'h8 */
>>> +	val = sdhci_readl(host, ESDHC_TBCTL);
>>> +	val &= ~(0xf << 8);
>>> +	val |= 8 << 8;
>>> +	sdhci_writel(host, val, ESDHC_TBCTL);
>>> +
>>> +	mdelay(1);
>>> +
>>> +	/* Read TBCTL[31:0] register and rewrite again */
>>> +	val = sdhci_readl(host, ESDHC_TBCTL);
>>> +	sdhci_writel(host, val, ESDHC_TBCTL);
>>> +
>>> +	mdelay(1);
>>> +
>>> +	/* Read the TBSTAT[31:0] register twice */
>>> +	val = sdhci_readl(host, ESDHC_TBSTAT);
>>> +	val = sdhci_readl(host, ESDHC_TBSTAT);
>>> +
>>> +	/* Reset data lines by setting ESDHCCTL[RSTD] */
>>> +	sdhci_reset(host, SDHCI_RESET_DATA);
>>> +	/* Write 32'hFFFF_FFFF to IRQSTAT register */
>>> +	sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
>>> +
>>> +	/* If TBSTAT[15:8]-TBSTAT[7:0] > 4 * div_ratio
>>> +	 * or TBSTAT[7:0]-TBSTAT[15:8] > 4 * div_ratio,
>>> +	 * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
>>> +	 * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
>>> +	 */
>>> +	tbstat_7_0 = val & 0xff;
>>> +	tbstat_15_8 = (val >> 8) & 0xff;
>>> +
>>> +	if (abs(tbstat_15_8 - tbstat_7_0) > (4 * esdhc->div_ratio)) {
>>> +		*window_start = 8 * esdhc->div_ratio;
>>> +		*window_end = 4 * esdhc->div_ratio;
>>> +	} else {
>>> +		*window_start = 5 * esdhc->div_ratio;
>>> +		*window_end = 3 * esdhc->div_ratio;
>>> +	}
>>> +}
>>> +
>>> +static int esdhc_execute_sw_tuning(struct mmc_host *mmc, u32 opcode,
>>> +				   u8 window_start, u8 window_end) {
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	/* Program TBPTR[TB_WNDW_END_PTR] and
>> TBPTR[TB_WNDW_START_PTR] */
>>> +	val = ((u32)window_start << ESDHC_WNDW_STRT_PTR_SHIFT) &
>>> +	      ESDHC_WNDW_STRT_PTR_MASK;
>>> +	val |= window_end & ESDHC_WNDW_END_PTR_MASK;
>>> +	sdhci_writel(host, val, ESDHC_TBPTR);
>>> +
>>> +	/* Program the software tuning mode by setting TBCTL[TB_MODE]=2'h3
>> */
>>> +	val = sdhci_readl(host, ESDHC_TBCTL);
>>> +	val &= ~ESDHC_TB_MODE_MASK;
>>> +	val |= ESDHC_TB_MODE_SW;
>>> +	sdhci_writel(host, val, ESDHC_TBCTL);
>>> +
>>> +	esdhc->in_sw_tuning = true;
>>> +	ret = sdhci_execute_tuning(mmc, opcode);
>>> +	esdhc->in_sw_tuning = false;
>>> +	return ret;
>>> +}
>>> +
>>>  static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)  {
>>>  	struct sdhci_host *host = mmc_priv(mmc);
>>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>  	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>>> +	u8 window_start, window_end;
>>> +	int ret, retries = 1;
>>>  	bool hs400_tuning;
>>>  	unsigned int clk;
>>>  	u32 val;
>>> -	int ret;
>>>
>>>  	/* For tuning mode, the sd clock divisor value
>>>  	 * must be larger than 3 according to reference manual.
>>> @@ -873,39 +962,73 @@ static int esdhc_execute_tuning(struct mmc_host
>> *mmc, u32 opcode)
>>>  	if (host->clock > clk)
>>>  		esdhc_of_set_clock(host, clk);
>>>
>>> -	if (esdhc->quirk_limited_clk_division &&
>>> -	    host->flags & SDHCI_HS400_TUNING)
>>> -		esdhc_of_set_clock(host, host->clock);
>>> -
>>>  	esdhc_tuning_block_enable(host, true);
>>>
>>>  	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>>> -	ret = sdhci_execute_tuning(mmc, opcode);
>>>
>>> -	if (hs400_tuning) {
>>> -		val = sdhci_readl(host, ESDHC_SDTIMNGCTL);
>>> -		val |= ESDHC_FLW_CTL_BG;
>>> -		sdhci_writel(host, val, ESDHC_SDTIMNGCTL);
>>> -	}
>>> +	do {
>>> +		if (esdhc->quirk_limited_clk_division &&
>>> +		    hs400_tuning)
>>> +			esdhc_of_set_clock(host, host->clock);
>>>
>>> -	if (host->tuning_err == -EAGAIN && esdhc->quirk_fixup_tuning) {
>>> +		/* Do HW tuning */
>>> +		val = sdhci_readl(host, ESDHC_TBCTL);
>>> +		val &= ~ESDHC_TB_MODE_MASK;
>>> +		val |= ESDHC_TB_MODE_3;
>>> +		sdhci_writel(host, val, ESDHC_TBCTL);
>>>
>>> -		/* program TBPTR[TB_WNDW_END_PTR] = 3*DIV_RATIO and
>>> -		 * program TBPTR[TB_WNDW_START_PTR] = 5*DIV_RATIO
>>> -		 */
>>> -		val = sdhci_readl(host, ESDHC_TBPTR);
>>> -		val = (val & ~((0x7f << 8) | 0x7f)) |
>>> -		(3 * esdhc->div_ratio) | ((5 * esdhc->div_ratio) << 8);
>>> -		sdhci_writel(host, val, ESDHC_TBPTR);
>>> +		ret = sdhci_execute_tuning(mmc, opcode);
>>> +		if (ret)
>>> +			break;
>>>
>>> -		/* program the software tuning mode by setting
>>> -		 * TBCTL[TB_MODE]=2'h3
>>> +		/* If HW tuning fails and triggers erratum,
>>> +		 * try workaround.
>>>  		 */
>>> -		val = sdhci_readl(host, ESDHC_TBCTL);
>>> -		val |= 0x3;
>>> -		sdhci_writel(host, val, ESDHC_TBCTL);
>>> -		sdhci_execute_tuning(mmc, opcode);
>>> +		ret = host->tuning_err;
>>> +		if (ret == -EAGAIN &&
>>> +		    (esdhc->quirk_tuning_erratum_type1 ||
>>> +		     esdhc->quirk_tuning_erratum_type2)) {
>>> +			/* Recover HS400 tuning flag */
>>> +			if (hs400_tuning)
>>> +				host->flags |= SDHCI_HS400_TUNING;
>>> +			pr_info("%s: Hold on to use fixed sampling clock. Try SW
>> tuning!\n",
>>> +				mmc_hostname(mmc));
>>> +			/* Do SW tuning */
>>> +			esdhc_prepare_sw_tuning(host, &window_start,
>>> +						&window_end);
>>> +			ret = esdhc_execute_sw_tuning(mmc, opcode,
>>> +						      window_start,
>>> +						      window_end);
>>> +			if (ret)
>>> +				break;
>>> +
>>> +			/* Retry both HW/SW tuning with reduced clock. */
>>> +			ret = host->tuning_err;
>>> +			if (ret == -EAGAIN && retries) {
>>> +				/* Recover HS400 tuning flag */
>>> +				if (hs400_tuning)
>>> +					host->flags |= SDHCI_HS400_TUNING;
>>> +
>>> +				clk = host->max_clk / (esdhc->div_ratio + 1);
>>> +				esdhc_of_set_clock(host, clk);
>>> +				pr_info("%s: Hold on to use fixed sampling clock. Try
>> tuning with reduced clock!\n",
>>> +					mmc_hostname(mmc));
>>> +			} else {
>>> +				break;
>>> +			}
>>> +		} else {
>>> +			break;
>>> +		}
>>> +	} while (retries--);
>>> +
>>> +	if (ret) {
>>> +		esdhc_tuning_block_enable(host, false);
>>> +	} else if (hs400_tuning) {
>>> +		val = sdhci_readl(host, ESDHC_SDTIMNGCTL);
>>> +		val |= ESDHC_FLW_CTL_BG;
>>> +		sdhci_writel(host, val, ESDHC_SDTIMNGCTL);
>>>  	}
>>> +
>>>  	return ret;
>>>  }
>>>
>>> @@ -937,6 +1060,26 @@ static u32 esdhc_irq(struct sdhci_host *host, u32
>> intmask)
>>>  	return intmask;
>>>  }
>>>
>>> +void esdhc_start_tuning(struct sdhci_host *host) {
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>>> +	u16 ctrl;
>>> +
>>> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +	ctrl |= SDHCI_CTRL_EXEC_TUNING;
>>> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>> +
>>> +	if (esdhc->in_sw_tuning) {
>>> +		udelay(1);
>>> +		ctrl |= SDHCI_CTRL_TUNED_CLK;
>>> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> Why not do that in the ->write_w() callback for SDHCI_HOST_CONTROL2
>> instead of adding ->start_tuning()?
> 
> [Y.b. Lu] The purpose is to set SDHCI_CTRL_TUNED_CLK bit just for starting tuning.
> I don’t think ->write_w() could check the condition of starting tuning, with esdhc->in_sw_tuning flag and SDHCI_CTRL_EXEC_TUNING bit set.

It seems to me that 0->1 transition of SDHCI_CTRL_EXEC_TUNING starts tuning
so it is equivalent to a  ->start_tuning() callback.

> There is possibility SDHCI_HOST_CONTROL2 register will be written for several times in tuning in the future.

Can you expand on what you mean?

> 
> Thanks.
>>
>>> +	}
>>> +
>>> +	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
>>> +	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE); }
>>> +
>>>  #ifdef CONFIG_PM_SLEEP
>>>  static u32 esdhc_proctl;
>>>  static int esdhc_of_suspend(struct device *dev) @@ -985,6 +1128,7 @@
>>> static const struct sdhci_ops sdhci_esdhc_be_ops = {
>>>  	.reset = esdhc_reset,
>>>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>>>  	.irq = esdhc_irq,
>>> +	.start_tuning = esdhc_start_tuning,
>>>  };
>>>
>>>  static const struct sdhci_ops sdhci_esdhc_le_ops = { @@ -1003,6
>>> +1147,7 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
>>>  	.reset = esdhc_reset,
>>>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>>>  	.irq = esdhc_irq,
>>> +	.start_tuning = esdhc_start_tuning,
>>>  };
>>>
>>>  static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = { @@
>>> -1140,10 +1285,15 @@ static int sdhci_esdhc_probe(struct
>>> platform_device *pdev)
>>>
>>>  	pltfm_host = sdhci_priv(host);
>>>  	esdhc = sdhci_pltfm_priv(pltfm_host);
>>> -	if (soc_device_match(soc_fixup_tuning))
>>> -		esdhc->quirk_fixup_tuning = true;
>>> +	if (soc_device_match(soc_tuning_erratum_type1))
>>> +		esdhc->quirk_tuning_erratum_type1 = true;
>>> +	else
>>> +		esdhc->quirk_tuning_erratum_type1 = false;
>>> +
>>> +	if (soc_device_match(soc_tuning_erratum_type2))
>>> +		esdhc->quirk_tuning_erratum_type2 = true;
>>>  	else
>>> -		esdhc->quirk_fixup_tuning = false;
>>> +		esdhc->quirk_tuning_erratum_type2 = false;
>>>
>>>  	if (esdhc->vendor_ver == VENDOR_V_22)
>>>  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>>
> 

