Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F972F4A7
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Jun 2023 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjFNGWF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Jun 2023 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjFNGWE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 02:22:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384C10F9;
        Tue, 13 Jun 2023 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686723721; x=1718259721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QGk6S3QokXDn/IY45blEKkM0KWm8mox5nS3b9uFwNAA=;
  b=AOXNknTIEr2nV8Ya3kmWDHJ94vzKKUatM+k1QV3jbX3pX6dQnqlyWIOE
   Pxz97Ts/T1SffYg4cksMXwmGpviVg3Bkei6BBqwBkdTjJJ2vJyQ4lz7LS
   n4uK7pB0WP2AFFQNIdVC4uowEr3kMTwjKOOdXR0QYXmArPkRFgNHEbQo7
   vbRMOxDCFeqcLYz8eytSy1RHU0w40EGKB9d7IYtQ6csciiws296MLPrTE
   ye+NHja6bW4avVX9xIBzeDfvezh7WwxdJMLYVXJmkAw9qTPqSOB0Lc6wR
   2oiMuzA+p+704hmgk+rwQSE0A4NIAI4lniKHndB7plsTYXskwe/NDWW/g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424418624"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="424418624"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="715072539"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="715072539"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.240])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:21:57 -0700
Message-ID: <619d3117-d8e0-6df3-c60e-a2f8859abe54@intel.com>
Date:   Wed, 14 Jun 2023 09:21:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Content-Language: en-US
To:     Chevron Li <chevron_li@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
References: <20230607014812.30104-1-chevron_li@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230607014812.30104-1-chevron_li@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/06/23 04:48, Chevron Li wrote:
> From: Chevron Li <chevron.li@bayhubtech.com>
> 
> Add Bayhub new chip GG8 support for USHI function
> 
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Some minor cosmetic comments below.

> ---
> Change in V1:
> 1.Add GG8 chip IDs in sdhci-pci-core.c and sdhci-pci.h
> 2.Add GG8 chip initialization flow at sdhci-pci-o2micro.c
> ---
>  drivers/mmc/host/sdhci-pci-core.c    |   4 +
>  drivers/mmc/host/sdhci-pci-o2micro.c | 154 ++++++++++++++++++++-------
>  drivers/mmc/host/sdhci-pci.h         |   4 +
>  3 files changed, 126 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 01975d145200..1d14300691f4 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1898,6 +1898,10 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
> +	SDHCI_PCI_DEVICE(O2, GG8_9860, o2),
> +	SDHCI_PCI_DEVICE(O2, GG8_9861, o2),
> +	SDHCI_PCI_DEVICE(O2, GG8_9862, o2),
> +	SDHCI_PCI_DEVICE(O2, GG8_9863, o2),
>  	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
>  	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 620f52ad9667..8243a63b3c81 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -36,6 +36,7 @@
>  #define O2_SD_INF_MOD		0xF1
>  #define O2_SD_MISC_CTRL4	0xFC
>  #define O2_SD_MISC_CTRL		0x1C0
> +#define O2_SD_EXP_INT_REG	0x1E0
>  #define O2_SD_PWR_FORCE_L0	0x0002
>  #define O2_SD_TUNING_CTRL	0x300
>  #define O2_SD_PLL_SETTING	0x304
> @@ -49,6 +50,9 @@
>  #define O2_SD_UHS2_L1_CTRL	0x35C
>  #define O2_SD_FUNC_REG3		0x3E0
>  #define O2_SD_FUNC_REG4		0x3E4
> +#define O2_SD_PARA_SET_REG1 0x444
> +#define O2_SD_VDDX_CTRL_REG 0x508
> +#define O2_SD_GPIO_CTRL_REG1 0x510

Values do not align with the ones above

>  #define O2_SD_LED_ENABLE	BIT(6)
>  #define O2_SD_FREG0_LEDOFF	BIT(13)
>  #define O2_SD_SEL_DLL		BIT(16)
> @@ -334,33 +338,45 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	scratch |= O2_SD_PWR_FORCE_L0;
>  	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
>  
> -	/* Stop clk */
> -	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	reg_val &= ~SDHCI_CLOCK_CARD_EN;
> -	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> -
> -	if ((host->timing == MMC_TIMING_MMC_HS200) ||
> -		(host->timing == MMC_TIMING_UHS_SDR104)) {
> -		/* UnLock WP */
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -		scratch_8 &= 0x7f;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> -
> -		/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> -		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> -		reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> -		reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> -		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +	/* Update output phase */
> +	switch (chip->pdev->device) {
> +	case PCI_DEVICE_ID_O2_SDS0:
> +	case PCI_DEVICE_ID_O2_SEABIRD0:
> +	case PCI_DEVICE_ID_O2_SEABIRD1:
> +	case PCI_DEVICE_ID_O2_SDS1:
> +	case PCI_DEVICE_ID_O2_FUJIN2:
> +		/* Stop clk */
> +		reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		reg_val &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
> +		if ((host->timing == MMC_TIMING_MMC_HS200) ||
> +			(host->timing == MMC_TIMING_UHS_SDR104)) {

There are unecessary parentheses here and elsewhere.
Have a look at the output of checkpatch.pl --strict

There are "Alignment should match open parenthesis"
messages also

> +			/* UnLock WP */
> +			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +			scratch_8 &= 0x7f;
> +			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +			/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +			pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +			reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +			reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +			pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +
> +			/* Lock WP */
> +			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +			scratch_8 |= 0x80;
> +			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +		}
>  
> -		/* Lock WP */
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -		scratch_8 |= 0x80;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +		/* Start clk */
> +		reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		reg_val |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +		break;
> +	default:
> +		break;
>  	}
> -	/* Start clk */
> -	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	reg_val |= SDHCI_CLOCK_CARD_EN;
> -	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>  
>  	/* wait DLL lock, timeout value 5ms */
>  	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
> @@ -563,6 +579,7 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	u16 clk;
>  	u8 scratch;
>  	u32 scratch_32;
> +	u32 dmdn_208m, dmdn_200m;
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>  	struct sdhci_pci_chip *chip = slot->chip;
>  
> @@ -578,16 +595,27 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	scratch &= 0x7f;
>  	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
> +	if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
> +		dmdn_208m = 0x2c500000;
> +		dmdn_200m = 0x25200000;
> +	} else {
> +		dmdn_208m = 0x2c280000;
> +		dmdn_200m = 0x25100000;
> +	}
> +
>  	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
> -		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
> -			o2_pci_set_baseclk(chip, 0x2c280000);
> +		if ((scratch_32 & 0xFFFF0000) != dmdn_208m)
> +			o2_pci_set_baseclk(chip, dmdn_208m);
>  	} else {
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
> -		if ((scratch_32 & 0xFFFF0000) != 0x25100000)
> -			o2_pci_set_baseclk(chip, 0x25100000);
> +		if ((scratch_32 & 0xFFFF0000) != dmdn_200m)
> +			o2_pci_set_baseclk(chip, dmdn_200m);
>  	}
>  
>  	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> @@ -624,6 +652,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  	if (caps & SDHCI_CAN_DO_8BIT)
>  		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>  
> +	host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
> +
> +	sdhci_pci_o2_enable_msi(chip, host);
> +
> +	host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> @@ -634,10 +667,6 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> -		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
> -
> -		sdhci_pci_o2_enable_msi(chip, host);
> -
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>  			ret = pci_read_config_dword(chip->pdev,
>  						    O2_SD_MISC_SETTING, &reg);
> @@ -663,15 +692,21 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>  		}
>  
> -		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
> -
>  		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>  			break;
>  		/* set dll watch dog timer */
>  		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING2);
>  		reg |= (1 << 12);
>  		sdhci_writel(host, reg, O2_SD_VENDOR_SETTING2);
> -
> +		break;
> +	case PCI_DEVICE_ID_O2_GG8_9860:
> +	case PCI_DEVICE_ID_O2_GG8_9861:
> +	case PCI_DEVICE_ID_O2_GG8_9862:
> +	case PCI_DEVICE_ID_O2_GG8_9863:
> +		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +		host->mmc->caps |= MMC_CAP_HW_RESET;
> +		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>  		break;
>  	default:
>  		break;
> @@ -684,6 +719,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  {
>  	int ret;
>  	u8 scratch;
> +	u16 scratch16;
>  	u32 scratch_32;
>  
>  	switch (chip->pdev->device) {
> @@ -885,6 +921,52 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		scratch_32 |= 0x00180000;
>  		pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL2, scratch_32);
>  		pci_write_config_dword(chip->pdev, O2_SD_DETECT_SETTING, 1);
> +		/* Lock WP */
> +		ret = pci_read_config_byte(chip->pdev,
> +					   O2_SD_LOCK_WP, &scratch);
> +		if (ret)
> +			return ret;
> +		scratch |= 0x80;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +		break;
> +	case PCI_DEVICE_ID_O2_GG8_9860:
> +	case PCI_DEVICE_ID_O2_GG8_9861:
> +	case PCI_DEVICE_ID_O2_GG8_9862:
> +	case PCI_DEVICE_ID_O2_GG8_9863:
> +		/* UnLock WP */
> +		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +		if (ret)
> +			return ret;
> +		scratch &= 0x7f;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +
> +		/* Select mode switch source as software control */
> +		pci_read_config_word(chip->pdev,
> +						O2_SD_PARA_SET_REG1, &scratch16);

Line break is not needed above and in similar cases below.
Wrapping at 100 columns instead of 80 is OK.

> +		scratch16 &= 0xF8FF;
> +		scratch16 |= BIT(9);
> +		pci_write_config_word(chip->pdev,
> +						O2_SD_PARA_SET_REG1, scratch16);
> +
> +		/* set VDD1 supply source */
> +		pci_read_config_word(chip->pdev,
> +						O2_SD_VDDX_CTRL_REG, &scratch16);
> +		scratch16 &= 0xFFE3;
> +		scratch16 |= BIT(3);
> +		pci_write_config_word(chip->pdev,
> +						O2_SD_VDDX_CTRL_REG, scratch16);
> +
> +		/* Set host drive strength*/
> +		scratch16 = 0x0025;
> +		pci_write_config_word(chip->pdev,
> +						O2_SD_PLL_SETTING, scratch16);
> +
> +		/* Set output delay*/
> +		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> +		scratch_32 &= 0xFF0FFF00;
> +		scratch_32 |= 0x00B0003B;
> +		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
> +
>  		/* Lock WP */
>  		ret = pci_read_config_byte(chip->pdev,
>  					   O2_SD_LOCK_WP, &scratch);
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 3661a224fb04..d680a030f3bf 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -11,6 +11,10 @@
>  #define PCI_DEVICE_ID_O2_FUJIN2		0x8520
>  #define PCI_DEVICE_ID_O2_SEABIRD0	0x8620
>  #define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
> +#define PCI_DEVICE_ID_O2_GG8_9860	0x9860
> +#define PCI_DEVICE_ID_O2_GG8_9861	0x9861
> +#define PCI_DEVICE_ID_O2_GG8_9862	0x9862
> +#define PCI_DEVICE_ID_O2_GG8_9863	0x9863
>  
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
> 
> base-commit: 9e87b63ed37e202c77aa17d4112da6ae0c7c097c

