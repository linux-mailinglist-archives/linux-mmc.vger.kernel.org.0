Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E7181F8
	for <lists+linux-mmc@lfdr.de>; Wed, 31 May 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjEaNdk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 31 May 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjEaNdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 09:33:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983601980;
        Wed, 31 May 2023 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685539931; x=1717075931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9aWN5b6gaK+Bij93pZDi+jwp28FaFA3CUk0ft55iLnc=;
  b=nT9Nq+DKrdtIwEgyIAOQCNjNdRbSBMk2qCKPXlAgtJeYmulmcJkT2M8K
   pbyZGPTjfCtGm94zjI0rdyIEekFHWwnmU5M1nQYo1H6Brh3fdi8FMkfz0
   ByfSiygLLVHQfzH0i64ukvgN/ElmiJAXLYoyyEj9HB7KtlXYqvxnJqJHK
   4LrGjCpk6RiMuHUCq7iRd5+w0W46u7ZSHIpWp7tD4bssuXmZfFuMqJnuu
   gu76MkKmcTDUCFnzRrpQMBmOL9xZd6wzuc4mROG+inII9Yndm6mNbjrk5
   tZBb5mAvEZRYKSmCgAFYInDtHKAgt1jZBG8zJ+9tjG4uoj6whVSh2nCJV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421003142"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="421003142"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="739967101"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="739967101"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:29:40 -0700
Message-ID: <18bcc1c7-1cf6-5d0e-e6ab-e5179a402e18@intel.com>
Date:   Wed, 31 May 2023 16:29:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V4 4/4] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230531111518.396868-1-victorshihgli@gmail.com>
 <20230531111518.396868-5-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531111518.396868-5-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/05/23 14:15, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Add support SD Express card for GL9767. The workflow of the
> SD Express card in GL9767 is as below.
> 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> 2. If card is inserted, Host send CMD8 to ask the capabilities
>    of the card.
> 3. If the card has PCIe capability, then init_sd_express()
>    will be invoked.
> 4. If the card has been put in write protect state then the
>    SD features supported by SD mode but not supported by
>    PCIe mode, therefore GL9767 switch to SD mode.
> 5. If the card has not been put in write protect state then
>    GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
>    handover control to NVMe driver.
> 6. If card is removed, GL9767 will return to SD mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 113 +++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 392a106cea18..e47236e3b89a 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -164,6 +164,10 @@
>  #define PCIE_GLI_9767_CFG		0x8A0
>  #define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
>  
> +#define PCIE_GLI_9767_COMBO_MUX_CTL			0x8C8
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -181,6 +185,9 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_SDHC_CAP			0x91C
> +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
> +
>  #define PCIE_GLI_9767_SD_PLL_CTL			0x938
>  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
>  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
> @@ -191,6 +198,23 @@
>  #define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
>  #define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
>  
> +#define PCIE_GLI_9767_SD_EXPRESS_CTL			0x940
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE		  BIT(0)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
> +
> +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2				0x954
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN	  BIT(0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -935,6 +959,93 @@ static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
>  	gli_set_9767(host);
>  }
>  
> +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev;
> +	u32 value;
> +	int i;
> +
> +	pdev = slot->chip->pdev;
> +
> +	if (mmc->ops->get_ro(mmc)) {
> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +		return 0;
> +	}
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> +	value &= ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +	value &= ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> +	value |= FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME,
> +			    PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, &value);
> +	value |= PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	value &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +	sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +
> +	value = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +	value |= (SDHCI_VDD2_POWER_180 | SDHCI_VDD2_POWER_ON);
> +	sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +	value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +
> +	for (i = 0; i < 2; i++) {
> +		msleep(10);
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +		if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE) {
> +			pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2,
> +					       value);
> +			break;
> +		}
> +	}
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> +	if (value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +		value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +	} else {
> +		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +
> +		value = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +		value &= ~(SDHCI_VDD2_POWER_180 | SDHCI_VDD2_POWER_ON);
> +		sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +		value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		value |= (SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +		sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +	}
> +
> +	gl9767_vhs_read(pdev);
> +
> +	return 0;
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
> @@ -967,6 +1078,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
>  	gl9767_hw_setting(slot);
>  	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
> +	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
>  	sdhci_enable_v4_mode(host);
>  
>  	return 0;

