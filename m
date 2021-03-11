Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B29336CD0
	for <lists+linux-mmc@lfdr.de>; Thu, 11 Mar 2021 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhCKHJ1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 11 Mar 2021 02:09:27 -0500
Received: from regular1.263xmail.com ([211.150.70.196]:44910 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhCKHJN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 02:09:13 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 09BF61E83;
        Thu, 11 Mar 2021 15:08:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1823T139670168000256S1615446482474051_;
        Thu, 11 Mar 2021 15:08:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0ab1de4a6364e28e5e1cc11df515db1e>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <9b7106e4-8817-6b49-e400-daa7b33a96ca@rock-chips.com>
Date:   Thu, 11 Mar 2021 15:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Cc:     shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform
 support
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
References: <1615443684-198078-1-git-send-email-shawn.lin@rock-chips.com>
 <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
 <20210311145924.498c690a@xhacker.debian>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210311145924.498c690a@xhacker.debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jisheng

On 2021/3/11 14:59, Jisheng Zhang wrote:
> Hi Shawn,
> 
> On Thu, 11 Mar 2021 14:21:24 +0800 Shawn Lin <shawn.lin@rock-chips.com> wrote:
> 
>>
>> sdhci based synopsys MMC IP is also used on some rockchip platforms,
>> so add a basic support here.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>> Changes in v4:
>> - add comments for disabling rx invert
>> - add tag from Adrian
>>
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 225 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 218 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 59d8d96..dabc1ec 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -9,9 +9,11 @@
>>
>>   #include <linux/clk.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device.h>
>>   #include <linux/sizes.h>
>>
>>   #include "sdhci-pltfm.h"
>> @@ -21,11 +23,43 @@
>>   /* DWCMSHC specific Mode Select value */
>>   #define DWCMSHC_CTRL_HS400             0x7
>>
>> +/* Rockchip specific Registers */
>> +#define DWCMSHC_HOST_CTRL3             0x508
> 
> Maybe 0x500 can be read from VENDOR_PTR_R while 0x8 is the offset?

It should be but we didn't add this info for this IP so we have
to hardcode the register offset.

> 
>> +#define DWCMSHC_EMMC_CONTROL           0x52c
>> +#define DWCMSHC_EMMC_ATCTRL            0x540
>> +#define DWCMSHC_EMMC_DLL_CTRL          0x800
> 
> Maybe 0x800 is phy offset? while 0, 4, 8 etc. below are phy registers?
> 
>> +#define DWCMSHC_EMMC_DLL_RXCLK         0x804
>> +#define DWCMSHC_EMMC_DLL_TXCLK         0x808
>> +#define DWCMSHC_EMMC_DLL_STRBIN                0x80c
>> +#define DWCMSHC_EMMC_DLL_STATUS0       0x840
>> +#define DWCMSHC_EMMC_DLL_START         BIT(0)
>> +#define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL  29
>> +#define DWCMSHC_EMMC_DLL_START_POINT   16
>> +#define DWCMSHC_EMMC_DLL_INC           8
>> +#define DWCMSHC_EMMC_DLL_DLYENA                BIT(27)
>> +#define DLL_TXCLK_TAPNUM_DEFAULT       0x8
>> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
>> +#define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
>> +#define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
>> +#define DWCMSHC_EMMC_DLL_LOCKED                BIT(8)
>> +#define DWCMSHC_EMMC_DLL_TIMEOUT       BIT(9)
>> +#define DLL_RXCLK_NO_INVERTER          1
>> +#define DLL_RXCLK_INVERTER             0
>> +#define DWCMSHC_ENHANCED_STROBE                BIT(8)
> 
> Is it better to let bits' definition grouped with register together, e.g this
> definition could be moved to the corresponding CONTROL register MACRO

Make sense to me. Will improve it.

> 
>> +#define DLL_LOCK_WO_TMOUT(x) \
>> +       ((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>> +       (((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
>> +#define ROCKCHIP_MAX_CLKS              3
>> +
>>   #define BOUNDARY_OK(addr, len) \
>>          ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>>
>>   struct dwcmshc_priv {
>>          struct clk      *bus_clk;
>> +
>> +       /* Rockchip specified optional clocks */
>> +       struct clk_bulk_data rockchip_clks[ROCKCHIP_MAX_CLKS];
>> +       u8 txclk_tapnum;
>>   };
>>
>>   /*
>> @@ -100,6 +134,102 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>>          sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>   }
>>
>> +static void dwcmshc_rk_hs400_enhanced_strobe(struct mmc_host *mmc,
>> +                                            struct mmc_ios *ios)
>> +{
>> +       u32 vendor;
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +       vendor = sdhci_readl(host, DWCMSHC_EMMC_CONTROL);
>> +       if (ios->enhanced_strobe)
>> +               vendor |= DWCMSHC_ENHANCED_STROBE;
>> +       else
>> +               vendor &= ~DWCMSHC_ENHANCED_STROBE;
>> +
>> +       sdhci_writel(host, vendor, DWCMSHC_EMMC_CONTROL);
>> +}
>> +
>> +static void dwcmshc_rk_set_clock(struct sdhci_host *host, unsigned int clock)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>> +       u32 extra;
>> +       int err;
>> +
>> +       host->mmc->actual_clock = 0;
>> +
>> +       /*
>> +        * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
>> +        * by default, but it shouldn't be enabled. We should anyway
>> +        * disable it before issuing any cmds.
>> +        */
>> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
>> +               DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>> +
>> +       if (clock == 0)
>> +               return;
>> +
>> +       /* Rockchip platform only support 375KHz for identify mode */
>> +       if (clock <= 400000)
>> +               clock = 375000;
>> +
>> +       err = clk_set_rate(pltfm_host->clk, clock);
>> +       if (err)
>> +               dev_err(mmc_dev(host->mmc), "fail to set clock %d", clock);
>> +
>> +       sdhci_set_clock(host, clock);
>> +
>> +       /* Disable cmd conflict check */
>> +       extra = sdhci_readl(host, DWCMSHC_HOST_CTRL3);
>> +       extra &= ~BIT(0);
>> +       sdhci_writel(host, extra, DWCMSHC_HOST_CTRL3);
>> +
>> +       if (clock <= 400000) {
>> +               /* Disable DLL to reset sample clock */
>> +               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
>> +               return;
>> +       }
>> +
>> +       /* Reset DLL */
>> +       sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
>> +       udelay(1);
>> +       sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
>> +
>> +       /* Init DLL settings */
>> +       extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
>> +               0x2 << DWCMSHC_EMMC_DLL_INC |
>> +               DWCMSHC_EMMC_DLL_START;
>> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CTRL);
>> +       err = readl_poll_timeout(host->ioaddr + DWCMSHC_EMMC_DLL_STATUS0,
>> +                                extra, DLL_LOCK_WO_TMOUT(extra), 1,
>> +                                500 * USEC_PER_MSEC);
>> +       if (err) {
>> +               dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
>> +               return;
>> +       }
>> +
>> +       extra = 0x1 << 16 | /* tune clock stop en */
>> +               0x2 << 17 | /* pre-change delay */
>> +               0x3 << 19;  /* post-change delay */
>> +       sdhci_writel(host, extra, DWCMSHC_EMMC_ATCTRL);
>> +
>> +       if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>> +           host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>> +               txclk_tapnum = priv->txclk_tapnum;
>> +
>> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
>> +               DLL_TXCLK_TAPNUM_FROM_SW |
>> +               txclk_tapnum;
>> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>> +
>> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
>> +               DLL_STRBIN_TAPNUM_DEFAULT |
>> +               DLL_STRBIN_TAPNUM_FROM_SW;
>> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>> +}
>> +
>>   static const struct sdhci_ops sdhci_dwcmshc_ops = {
>>          .set_clock              = sdhci_set_clock,
>>          .set_bus_width          = sdhci_set_bus_width,
>> @@ -109,21 +239,91 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>>          .adma_write_desc        = dwcmshc_adma_write_desc,
>>   };
>>
>> +static const struct sdhci_ops sdhci_dwcmshc_rk_ops = {
>> +       .set_clock              = dwcmshc_rk_set_clock,
>> +       .set_bus_width          = sdhci_set_bus_width,
>> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
>> +       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
>> +       .reset                  = sdhci_reset,
>> +       .adma_write_desc        = dwcmshc_adma_write_desc,
>> +};
>> +
>>   static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>>          .ops = &sdhci_dwcmshc_ops,
>>          .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>          .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>   };
>>
>> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk_pdata = {
>> +       .ops = &sdhci_dwcmshc_rk_ops,
>> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>> +                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>> +                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>> +};
>> +
>> +static int rockchip_pltf_init(struct sdhci_host *host, struct dwcmshc_priv *priv)
>> +{
>> +       int err;
>> +
>> +       priv->rockchip_clks[0].id = "axi";
>> +       priv->rockchip_clks[1].id = "block";
>> +       priv->rockchip_clks[2].id = "timer";
>> +       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), ROCKCHIP_MAX_CLKS,
>> +                                        priv->rockchip_clks);
>> +       if (err) {
>> +               dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
>> +               return err;
>> +       }
>> +
>> +       err = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>> +       if (err) {
>> +               dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
>> +               return err;
>> +       }
>> +
>> +       if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
>> +                               &priv->txclk_tapnum))
>> +               priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>> +
>> +       /* Disable cmd conflict check */
>> +       sdhci_writel(host, 0x0, DWCMSHC_HOST_CTRL3);
>> +       /* Reset previous settings */
>> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>> +       {
>> +               .compatible = "snps,dwcmshc-sdhci",
>> +               .data = &sdhci_dwcmshc_pdata,
>> +       },
>> +       {
>> +               .compatible = "rockchip,dwcmshc-sdhci",
>> +               .data = &sdhci_dwcmshc_rk_pdata,
>> +       },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>> +
>>   static int dwcmshc_probe(struct platform_device *pdev)
>>   {
>>          struct sdhci_pltfm_host *pltfm_host;
>>          struct sdhci_host *host;
>>          struct dwcmshc_priv *priv;
>> +       const struct sdhci_pltfm_data *pltfm_data;
>>          int err;
>>          u32 extra;
>>
>> -       host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
>> +       pltfm_data = of_device_get_match_data(&pdev->dev);
>> +       if (!pltfm_data) {
>> +               dev_err(&pdev->dev, "Error: No device match data found\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       host = sdhci_pltfm_init(pdev, pltfm_data,
>>                                  sizeof(struct dwcmshc_priv));
>>          if (IS_ERR(host))
>>                  return PTR_ERR(host);
>> @@ -161,6 +361,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>
>>          host->mmc_host_ops.request = dwcmshc_request;
>>
>> +       if (pltfm_data == &sdhci_dwcmshc_rk_pdata) {
>> +               host->mmc_host_ops.hs400_enhanced_strobe =
>> +                       dwcmshc_rk_hs400_enhanced_strobe;
>> +
>> +               err = rockchip_pltf_init(host, priv);
>> +               if (err)
>> +                       goto err_clk;
>> +       }
>> +
>>          err = sdhci_add_host(host);
>>          if (err)
>>                  goto err_clk;
>> @@ -170,6 +379,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   err_clk:
>>          clk_disable_unprepare(pltfm_host->clk);
>>          clk_disable_unprepare(priv->bus_clk);
>> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>>   free_pltfm:
>>          sdhci_pltfm_free(pdev);
>>          return err;
>> @@ -185,6 +395,7 @@ static int dwcmshc_remove(struct platform_device *pdev)
>>
>>          clk_disable_unprepare(pltfm_host->clk);
>>          clk_disable_unprepare(priv->bus_clk);
>> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>>
>>          sdhci_pltfm_free(pdev);
>>
>> @@ -207,6 +418,8 @@ static int dwcmshc_suspend(struct device *dev)
>>          if (!IS_ERR(priv->bus_clk))
>>                  clk_disable_unprepare(priv->bus_clk);
>>
>> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>> +
>>          return ret;
>>   }
>>
>> @@ -227,18 +440,16 @@ static int dwcmshc_resume(struct device *dev)
>>                          return ret;
>>          }
>>
>> +       ret = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>> +       if (ret)
>> +               return ret;
>> +
>>          return sdhci_resume_host(host);
>>   }
>>   #endif
>>
>>   static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
>>
>> -static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>> -       { .compatible = "snps,dwcmshc-sdhci" },
>> -       {}
>> -};
>> -MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>> -
>>   static struct platform_driver sdhci_dwcmshc_driver = {
>>          .driver = {
>>                  .name   = "sdhci-dwcmshc",
>> --
>> 2.7.4
>>
>>
>>
> 
> 
> 
> 


