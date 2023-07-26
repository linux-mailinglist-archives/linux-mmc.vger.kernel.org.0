Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7573D763690
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Jul 2023 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjGZMmq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 26 Jul 2023 08:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGZMmp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jul 2023 08:42:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21BB26B8;
        Wed, 26 Jul 2023 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690375351; x=1721911351;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yiYiugs/H2RaAWSY+OcV9+d9KuB/mqKOBFZsoAK5TmQ=;
  b=XCfLkID0q2Zd78ybA+j9iHEy1KNpA1/DPpqgryxnzSmy5Onahh5YVTWD
   uwYZr12k1uNX4EwNB9NJuH4lRaxfNjtRrQM9NPgmqy1+chaDQrVXrPVB6
   wm2JYQmzC/K/WnmvHkmh9kQqiVaE5rin897RsBsrAN+N5OgL8GmJaL2se
   v5s3IwPlgUKNu5Bm2zvFVAJKT11xJpzUyLgX2urWN6HkrI1bf7QTrsLKi
   2jBEggoaCeewsJS9AlAHNs9ml4SWmXCoaZ08bizwzGUAgNue7kydd+fEu
   YYQfv0YI8LwYOSU35ZF1dSuZpTvB4w+qCSA76D99V/jY2p0WdIAILZB2Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347617594"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="347617594"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676683393"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676683393"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:42:27 -0700
Message-ID: <08e4d85e-d3cb-deb0-f6ab-ca62beade421@intel.com>
Date:   Wed, 26 Jul 2023 15:42:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 6/6] mmc: sdhci-cadence: Add debug option for SD6
 controller
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-7-pmalgujar@marvell.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230717125146.16791-7-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/07/23 15:51, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support dumping PHY and host controller register configuration
> if debug config enabled.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 156 ++++++++++++++++++++++++++++++-
>  1 file changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index f1e597219c603f3921439cedb22dcb2884abe68d..337a97bf906137f0eac4122cdd603f25df7ae8d9 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -116,6 +116,10 @@
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
>  
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
> +
>  #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
>  #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
>  
> @@ -813,7 +817,7 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>  }
>  
>  static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
> -					u8 addr, u8 data)
> +				    u8 addr, u8 data)

Whitespace change should be done when renaming the function.

>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
> @@ -971,6 +975,154 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
>  	}
>  }
>  
> +#if defined(DEBUG) || IS_ENABLED(CONFIG_DYNAMIC_DEBUG)

Not sure what madness caused my comment last version, but this
is actually redundant.  If the condition above is not true
then the whole thing will get optimized away anyway. i.e.
conditional compilation is not needed here.

> +
> +static
> +void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy,
> +			     struct sdhci_host *host)
> +{
> +	dev_dbg(mmc_dev(host->mmc), "PHY Timings\n");
> +	dev_dbg(mmc_dev(host->mmc), "mode %d t_sdclk %d\n", phy->mode,
> +		phy->t_sdclk);
> +
> +	dev_dbg(mmc_dev(host->mmc), "cp_clk_wr_delay %d\n",
> +		phy->settings.cp_clk_wr_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_clk_wrdqs_delay %d\n",
> +		phy->settings.cp_clk_wrdqs_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_data_select_oe_end %d\n",
> +		phy->settings.cp_data_select_oe_end);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_bypass_mode %d\n",
> +		phy->settings.cp_dll_bypass_mode);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_locked_mode %d\n",
> +		phy->settings.cp_dll_locked_mode);
> +	dev_dbg(mmc_dev(host->mmc), "cp_dll_start_point %d\n",
> +		phy->settings.cp_dll_start_point);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_always_on %d\n",
> +		phy->settings.cp_io_mask_always_on);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_end %d\n",
> +		phy->settings.cp_io_mask_end);
> +	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_start %d\n",
> +		phy->settings.cp_io_mask_start);
> +	dev_dbg(mmc_dev(host->mmc), "cp_rd_del_sel %d\n",
> +		phy->settings.cp_rd_del_sel);
> +	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_cmd_delay %d\n",
> +		phy->settings.cp_read_dqs_cmd_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_delay %d\n",
> +		phy->settings.cp_read_dqs_delay);
> +	dev_dbg(mmc_dev(host->mmc), "cp_sw_half_cycle_shift %d\n",
> +		phy->settings.cp_sw_half_cycle_shift);
> +	dev_dbg(mmc_dev(host->mmc), "cp_sync_method %d\n",
> +		phy->settings.cp_sync_method);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_ext_lpbk_dqs %d\n",
> +		phy->settings.cp_use_ext_lpbk_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_lpbk_dqs %d\n",
> +		phy->settings.cp_use_lpbk_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs %d\n",
> +		phy->settings.cp_use_phony_dqs);
> +	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs_cmd %d\n",
> +		phy->settings.cp_use_phony_dqs_cmd);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_rd_mode %d\n",
> +		phy->settings.sdhc_extended_rd_mode);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_wr_mode %d\n",
> +		phy->settings.sdhc_extended_wr_mode);
> +
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_hcsdclkadj %d\n",
> +		phy->settings.sdhc_hcsdclkadj);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_idelay_val %d\n",
> +		phy->settings.sdhc_idelay_val);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rdcmd_en %d\n",
> +		phy->settings.sdhc_rdcmd_en);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rddata_en %d\n",
> +		phy->settings.sdhc_rddata_en);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_rw_compensate %d\n",
> +		phy->settings.sdhc_rw_compensate);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsh %d\n",
> +		phy->settings.sdhc_sdcfsh);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsl %d\n",
> +		phy->settings.sdhc_sdcfsl);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd0_dly %d %d\n",
> +		phy->settings.sdhc_wrcmd0_dly,
> +		phy->settings.sdhc_wrcmd0_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd1_dly %d %d\n",
> +		phy->settings.sdhc_wrcmd1_dly,
> +		phy->settings.sdhc_wrcmd1_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata0_dly %d %d\n",
> +		phy->settings.sdhc_wrdata0_dly,
> +		phy->settings.sdhc_wrdata0_sdclk_dly);
> +
> +	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata1_dly %d %d\n",
> +		phy->settings.sdhc_wrdata1_dly,
> +		phy->settings.sdhc_wrdata1_sdclk_dly);
> +	dev_dbg(mmc_dev(host->mmc), "hs200_tune_val %d\n",
> +		phy->settings.hs200_tune_val);
> +}
> +
> +static
> +void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv, struct sdhci_host *host)
> +{
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +	int id;
> +
> +	sdhci_cdns_sd6_phy_dump(phy);

As the robot pointed out, that should be:

	sdhci_cdns_sd6_phy_dump(phy, host);

> +
> +	dev_dbg(mmc_dev(host->mmc), "Host controller Register Dump\n");
> +	for (id = 0; id < 14; id++) {
> +		dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +			readl(priv->hrs_addr + (id * 4)));
> +	}
> +
> +	id = 29;
> +	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +		readl(priv->hrs_addr + (id * 4)));
> +	id = 30;
> +	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
> +		readl(priv->hrs_addr + (id * 4)));
> +
> +	for (id = 0; id < 27; id++) {
> +		dev_dbg(mmc_dev(host->mmc), "SRS%d 0x%x\n", id,
> +			readl(priv->hrs_addr + 0x200 + (id * 4)));
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DQS_TIMING));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_GATE_LPBK));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_MASTER));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DQ_TIMING));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
> +	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
> +		sdhci_cdns_sd6_read_phy_reg(priv,
> +					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
> +}
> +
> +#else
> +
> +static inline void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv,
> +				       struct sdhci_host *host)
> +{
> +}
> +
> +#endif
> +
>  static
>  int sdhci_cdns_sd6_get_delay_params(struct device *dev,
>  				    struct sdhci_cdns_priv *priv)
> @@ -1322,6 +1474,8 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
>  		pr_debug("%s: phy init failed\n", __func__);
>  
>  	sdhci_set_clock(host, clock);
> +
> +	sdhci_cdns_sd6_dump(priv, host);
>  }
>  
>  static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,

