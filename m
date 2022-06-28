Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EB55DE02
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Jun 2022 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbiF1Bfv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 Jun 2022 21:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbiF1Bfu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2022 21:35:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE11AF2D;
        Mon, 27 Jun 2022 18:35:48 -0700 (PDT)
X-UUID: e2100dd6e45a49ba848ccabc6625f7d1-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:54d8fdd5-4023-4efa-a3a0-4525b25c0589,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:51
X-CID-INFO: VERSION:1.1.7,REQID:54d8fdd5-4023-4efa-a3a0-4525b25c0589,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:51
X-CID-META: VersionHash:87442a2,CLOUDID:1fb8fdd5-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:af11b62a56bb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e2100dd6e45a49ba848ccabc6625f7d1-20220628
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 926094020; Tue, 28 Jun 2022 09:35:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Jun 2022 09:35:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jun 2022 09:35:39 +0800
Message-ID: <8be385651b909c911a9225960cacff72cac96b5b.camel@mediatek.com>
Subject: Re: [PATCH v13 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>
Date:   Tue, 28 Jun 2022 09:35:39 +0800
In-Reply-To: <20220623090445.1401-4-axe.yang@mediatek.com>
References: <20220623090445.1401-1-axe.yang@mediatek.com>
         <20220623090445.1401-4-axe.yang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2022-06-23 at 17:04 +0800, Axe Yang wrote:
> Add support for eint IRQ when MSDC is used as an SDIO host. This
> feature requires SDIO device support async IRQ function. With this
> feature, SDIO host can be awakened by SDIO card in suspend state,
> without additional pin.
> 
> MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> resume, switch GPIO function back to DAT1 mode then turn on clock.
> 
> Some device tree property should be added or modified in MSDC node
> to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
> this feature depends on asynchronous interrupts, "wakeup-source",
> "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
> the interrupts list should be extended(the interrupt named with
> sdio_wakeup):
>         &mmcX {
> 		...
> 		interrupt-names = "msdc", "sdio_wakeup";
> 		interrupts-extended = <...>,
>                               	      <&pio xxx
> IRQ_TYPE_LEVEL_LOW>;
>                 ...
>                 pinctrl-names = "default", "state_uhs", "state_eint";
>                 ...
>                 pinctrl-2 = <&mmc2_pins_eint>;
>                 ...
>                 cap-sdio-irq;
> 		keep-power-in-suspend;
> 		wakeup-source;
>                 ...
>         };
> 
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
Reviewed-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 84 ++++++++++++++++++++++++++++++++++++-
> --
>  1 file changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..f907b96cfd87 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2014-2015 MediaTek Inc.
> + * Copyright (c) 2014-2015, 2022 MediaTek Inc.
>   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
>   */
>  
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -440,8 +441,10 @@ struct msdc_host {
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pins_default;
>  	struct pinctrl_state *pins_uhs;
> +	struct pinctrl_state *pins_eint;
>  	struct delayed_work req_timeout;
>  	int irq;		/* host interrupt */
> +	int eint_irq;		/* interrupt from sdio device for
> waking up system */
>  	struct reset_control *reset;
>  
>  	struct clk *src_clk;	/* msdc source clock */
> @@ -1520,17 +1523,46 @@ static void __msdc_enable_sdio_irq(struct
> msdc_host *host, int enb)
>  
>  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  {
> -	unsigned long flags;
>  	struct msdc_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int ret;
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	__msdc_enable_sdio_irq(host, enb);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	if (enb)
> -		pm_runtime_get_noresume(host->dev);
> -	else
> -		pm_runtime_put_noidle(host->dev);
> +	if (mmc_card_enable_async_irq(mmc->card) && host->pins_eint) {
> +		if (enb) {
> +			/*
> +			 * In dev_pm_set_dedicated_wake_irq_reverse(),
> eint pin will be set to
> +			 * GPIO mode. We need to restore it to SDIO
> DAT1 mode after that.
> +			 * Since the current pinstate is pins_uhs, to
> ensure pinctrl select take
> +			 * affect successfully, we change the pinstate
> to pins_eint firstly.
> +			 */
> +			pinctrl_select_state(host->pinctrl, host-
> >pins_eint);
> +			ret =
> dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> +
> +			if (ret) {
> +				dev_err(host->dev, "Failed to register
> SDIO wakeup irq!\n");
> +				host->pins_eint = NULL;
> +				pm_runtime_get_noresume(host->dev);
> +			} else {
> +				dev_dbg(host->dev, "SDIO eint irq:
> %d!\n", host->eint_irq);
> +			}
> +
> +			pinctrl_select_state(host->pinctrl, host-
> >pins_uhs);
> +		} else {
> +			dev_pm_clear_wake_irq(host->dev);
> +		}
> +	} else {
> +		if (enb) {
> +			/* Ensure host->pins_eint is NULL */
> +			host->pins_eint = NULL;
> +			pm_runtime_get_noresume(host->dev);
> +		} else {
> +			pm_runtime_put_noidle(host->dev);
> +		}
> +	}
>  }
>  
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
> @@ -2631,6 +2663,20 @@ static int msdc_drv_probe(struct
> platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	/* Support for SDIO eint irq ? */
> +	if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps &
> MMC_PM_KEEP_POWER)) {
> +		host->eint_irq = platform_get_irq_byname(pdev,
> "sdio_wakeup");
> +		if (host->eint_irq > 0) {
> +			host->pins_eint = pinctrl_lookup_state(host-
> >pinctrl, "state_eint");
> +			if (IS_ERR(host->pins_eint)) {
> +				dev_err(&pdev->dev, "Cannot find
> pinctrl eint!\n");
> +				host->pins_eint = NULL;
> +			} else {
> +				device_init_wakeup(&pdev->dev, true);
> +			}
> +		}
> +	}
> +
>  	msdc_of_property_parse(pdev, host);
>  
>  	host->dev = &pdev->dev;
> @@ -2845,6 +2891,13 @@ static int __maybe_unused
> msdc_runtime_suspend(struct device *dev)
>  	struct msdc_host *host = mmc_priv(mmc);
>  
>  	msdc_save_reg(host);
> +
> +	if (host->pins_eint) {
> +		disable_irq(host->irq);
> +		pinctrl_select_state(host->pinctrl, host->pins_eint);
> +		if (sdio_irq_claimed(mmc))
> +			__msdc_enable_sdio_irq(host, 0);
> +	}
>  	msdc_gate_clock(host);
>  	return 0;
>  }
> @@ -2860,12 +2913,18 @@ static int __maybe_unused
> msdc_runtime_resume(struct device *dev)
>  		return ret;
>  
>  	msdc_restore_reg(host);
> +
> +	if (host->pins_eint) {
> +		pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +		enable_irq(host->irq);
> +	}
>  	return 0;
>  }
>  
>  static int __maybe_unused msdc_suspend(struct device *dev)
>  {
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
> +	struct msdc_host *host = mmc_priv(mmc);
>  	int ret;
>  
>  	if (mmc->caps2 & MMC_CAP2_CQE) {
> @@ -2874,11 +2933,24 @@ static int __maybe_unused msdc_suspend(struct
> device *dev)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Bump up runtime PM usage counter otherwise dev-
> >power.needs_force_resume will
> +	 * not be marked as 1, pm_runtime_force_resume() will go out
> directly.
> +	 */
> +	if (host->pins_eint)
> +		pm_runtime_get_noresume(dev);
> +
>  	return pm_runtime_force_suspend(dev);
>  }
>  
>  static int __maybe_unused msdc_resume(struct device *dev)
>  {
> +	struct mmc_host *mmc = dev_get_drvdata(dev);
> +	struct msdc_host *host = mmc_priv(mmc);
> +
> +	if (host->pins_eint)
> +		pm_runtime_put_noidle(dev);
> +
>  	return pm_runtime_force_resume(dev);
>  }
>  

