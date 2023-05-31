Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7F717D14
	for <lists+linux-mmc@lfdr.de>; Wed, 31 May 2023 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjEaKUf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 31 May 2023 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEaKUI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 06:20:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9281981;
        Wed, 31 May 2023 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685528354; x=1717064354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fEV5T6z4nLEPLmhhH/gnfjRblE2+jMQYuIzqvlUDJ3Q=;
  b=gz1mLLeoHYXC2Wf56D5DP/QV6wrb7KRirC9jxBpj3Ru0/N2hufPsGK/G
   c+dOm8C9j/sK8jR3XFYbqkcOn4p+KarNO/oECQfwTjrlszs86A5SEv/fP
   dgrEfyh8hrfUs+faTXUfbZcEHrjHT4CAx7q9AowL6z8+Iw1MXs8sAm5F7
   h0opmK3bNlnSxuayDke/nX1SwTtU44iqT2mFraJZEEO9ho7fBFMVv4Lx1
   gY5pKCvuOCSpbcSTFZs1c431/kYAZNBElq/TNg7rl4pPvQYvuiSluU8BZ
   abPfi1QUHAH6atcmeR0IrL4P05MGzsryfjtcyGiAww8QyTQXC7tXDWTaA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335541320"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335541320"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831166585"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831166585"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:18:55 -0700
Message-ID: <ec36ef7e-6d64-075f-1484-809b1884e457@intel.com>
Date:   Wed, 31 May 2023 13:18:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/3] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz
 and enable SSC for GL9767
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230531095721.392664-1-victorshihgli@gmail.com>
 <20230531095721.392664-3-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531095721.392664-3-victorshihgli@gmail.com>
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

On 31/05/23 12:57, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Set GL9767 SDR104's clock to 205MHz and enable SSC feature
> depend on register 0x888 BIT(1).
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 135 ++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 3ed207b89d1a..392a106cea18 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -158,6 +158,12 @@
>  #define   GLI_9767_VHS_REV_M	  0x1
>  #define   GLI_9767_VHS_REV_W	  0x2
>  
> +#define PCIE_GLI_9767_COM_MAILBOX		0x888
> +#define   PCIE_GLI_9767_COM_MAILBOX_SSC_EN	  BIT(1)
> +
> +#define PCIE_GLI_9767_CFG		0x8A0
> +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -175,6 +181,16 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_SD_PLL_CTL			0x938
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN		  BIT(16)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_EN		  BIT(19)
> +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING	  GENMASK(28, 24)
> +
> +#define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
> +#define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -753,6 +769,123 @@ static inline void gl9767_vhs_write(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
>  }
>  
> +static bool gl9767_ssc_enable(struct pci_dev *pdev)
> +{
> +	u32 value;
> +	u8 enable;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_COM_MAILBOX, &value);
> +	enable = FIELD_GET(PCIE_GLI_9767_COM_MAILBOX_SSC_EN, value);
> +
> +	gl9767_vhs_read(pdev);
> +
> +	return enable;
> +}
> +
> +static void gl9767_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
> +{
> +	u32 pll;
> +	u32 ssc;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, &ssc);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING |
> +		 PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
> +	ssc &= ~PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM;
> +	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING, step) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_EN, enable);
> +	ssc |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM, ppm);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, ssc);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void gl9767_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
> +{
> +	u32 pll;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV |
> +		 PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV |
> +		 PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN);
> +	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV, ldiv) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV, pdiv) |
> +	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN, dir);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +
> +	/* wait for pll stable */
> +	msleep(1);
> +}
> +
> +static void gl9767_set_ssc_pll_205mhz(struct pci_dev *pdev)
> +{
> +	bool enable = gl9767_ssc_enable(pdev);
> +
> +	/* set pll to 205MHz and ssc */
> +	gl9767_set_ssc(pdev, enable, 0x1F, 0xF5C3);
> +	gl9767_set_pll(pdev, 0x1, 0x246, 0x0);
> +}
> +
> +static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
> +{
> +	u32 pll;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN | PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct mmc_ios *ios = &host->mmc->ios;
> +	struct pci_dev *pdev;
> +	u32 value;
> +	u16 clk;
> +
> +	pdev = slot->chip->pdev;
> +	host->mmc->actual_clock = 0;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	gl9767_disable_ssc_pll(pdev);
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> +		host->mmc->actual_clock = 205000000;
> +		gl9767_set_ssc_pll_205mhz(pdev);
> +	}
> +
> +	sdhci_enable_clk(host, clk);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
>  static void gli_set_9767(struct sdhci_host *host)
>  {
>  	u32 value;
> @@ -1293,7 +1426,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  };
>  
>  static const struct sdhci_ops sdhci_gl9767_ops = {
> -	.set_clock		 = sdhci_set_clock,
> +	.set_clock		 = sdhci_gl9767_set_clock,
>  	.enable_dma		 = sdhci_pci_enable_dma,
>  	.set_bus_width		 = sdhci_set_bus_width,
>  	.reset			 = sdhci_gl9767_reset,

