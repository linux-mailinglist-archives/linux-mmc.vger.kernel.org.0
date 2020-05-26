Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403331CF8CF
	for <lists+linux-mmc@lfdr.de>; Tue, 12 May 2020 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgELPS2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 May 2020 11:18:28 -0400
Received: from hfcrelay.icp-osb-irony-out7.external.iinet.net.au ([203.59.1.87]:8752
        "EHLO hfcrelay.icp-osb-irony-out7.external.iinet.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgELPS2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 12 May 2020 11:18:28 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2020 11:18:26 EDT
X-SMTP-MATCH: 1
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ClAAAFu7pe//onNcoNUQgbAQEBAQE?=
 =?us-ascii?q?BAQEFAQEBEgEBAQMDAQEBQIFHhEyEJIN6jGcIJZl5gWcLAQEBAQEBAQEBNwQ?=
 =?us-ascii?q?BAYREAoIpOBMCEAEBAQUBAQEBAQUDAYV3hkkBAQEBAgEjBBFBBQsLGAICJgI?=
 =?us-ascii?q?CVwYBDAYCAQGDIoJLARGvTnZ/M4VRg12BQIEOKoxegUE/gREnDAOCWj6EJwk?=
 =?us-ascii?q?EAYMtgmAEmBCBB5lUgTmBG4EDjVGJTiOCXI1ojHaQHZ87gXgzGh+DPVAlkEw?=
 =?us-ascii?q?XjjdiNwIGCAEBAwmPAwEB?=
X-IPAS-Result: =?us-ascii?q?A2ClAAAFu7pe//onNcoNUQgbAQEBAQEBAQEFAQEBEgEBA?=
 =?us-ascii?q?QMDAQEBQIFHhEyEJIN6jGcIJZl5gWcLAQEBAQEBAQEBNwQBAYREAoIpOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAYV3hkkBAQEBAgEjBBFBBQsLGAICJgICVwYBDAYCAQGDI?=
 =?us-ascii?q?oJLARGvTnZ/M4VRg12BQIEOKoxegUE/gREnDAOCWj6EJwkEAYMtgmAEmBCBB?=
 =?us-ascii?q?5lUgTmBG4EDjVGJTiOCXI1ojHaQHZ87gXgzGh+DPVAlkEwXjjdiNwIGCAEBA?=
 =?us-ascii?q?wmPAwEB?=
X-IronPort-AV: E=Sophos;i="5.73,384,1583164800"; 
   d="scan'208";a="255837764"
Received: from 202-53-39-250.tpgi.com.au (HELO [192.168.0.106]) ([202.53.39.250])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 12 May 2020 23:09:04 +0800
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc
 controller
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-m68k@vger.kernel.org
References: <20200501235907.3978-1-angelo.dureghello@timesys.com>
 <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
From:   Greg Ungerer <gregungerer@westnet.com.au>
Message-ID: <bde7080c-298d-c28b-5986-dbabc95985bf@westnet.com.au>
Date:   Wed, 13 May 2020 01:09:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On 7/5/20 7:13 pm, Ulf Hansson wrote:
> + Geert
> 
> On Sat, 2 May 2020 at 01:54, Angelo Dureghello
> <angelo.dureghello@timesys.com> wrote:
>>
>> Add support for sdhci-edshc mmc controller.
>>
>> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
>> ---
>> Changes for v3:
>> - removed volatile cast from clk.c
>> ---
>>   arch/m68k/coldfire/clk.c                    | 15 ++++++++++
>>   arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
>>   arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
>>   arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
>>   arch/m68k/include/asm/mcfclk.h              |  2 ++
>>   include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
>>   6 files changed, 95 insertions(+), 3 deletions(-)
>>   create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
> 
> Not sure what's the best way to deal with this patch. I looped in
> Geert to get some input.
> 
> If it looks okay and the risk is minimal for conflicts, I can carry it
> via my tree, but then I need an ack from Geert.

I can carry just this patch in the m68knommu git tree it you prefer.
Should be no conflicts that way. But really if you want to carry it
with all the others I don't have a problem with that either.

Regards
Greg


> Kind regards
> Uffe
> 
>>
>> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
>> index 7bc666e482eb..8d048a72e173 100644
>> --- a/arch/m68k/coldfire/clk.c
>> +++ b/arch/m68k/coldfire/clk.c
>> @@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
>>   #endif /* MCFPM_PPMCR1 */
>>   #endif /* MCFPM_PPMCR0 */
>>
>> +static void __clk_enable2(struct clk *clk)
>> +{
>> +       __set_bit(clk->slot, MCFSDHC_CLK);
>> +}
>> +
>> +static void __clk_disable2(struct clk *clk)
>> +{
>> +       __clear_bit(clk->slot, MCFSDHC_CLK);
>> +}
>> +
>> +struct clk_ops clk_ops2 = {
>> +       .enable         = __clk_enable2,
>> +       .disable        = __clk_disable2,
>> +};
>> +
>>   struct clk *clk_get(struct device *dev, const char *id)
>>   {
>>          const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
>> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
>> index b4103b6bfdeb..9ef4ec0aea00 100644
>> --- a/arch/m68k/coldfire/device.c
>> +++ b/arch/m68k/coldfire/device.c
>> @@ -22,6 +22,7 @@
>>   #include <asm/mcfqspi.h>
>>   #include <linux/platform_data/edma.h>
>>   #include <linux/platform_data/dma-mcf-edma.h>
>> +#include <linux/platform_data/mmc-esdhc-mcf.h>
>>
>>   /*
>>    *     All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
>> @@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
>>                  .platform_data = &mcf_edma_data,
>>          }
>>   };
>> -
>>   #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
>>
>> +#if IS_ENABLED(CONFIG_MMC)
>> +static struct mcf_esdhc_platform_data mcf_esdhc_data = {
>> +       .max_bus_width = 4,
>> +       .cd_type = ESDHC_CD_NONE,
>> +};
>> +
>> +static struct resource mcf_esdhc_resources[] = {
>> +       {
>> +               .start = MCFSDHC_BASE,
>> +               .end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
>> +               .flags = IORESOURCE_MEM,
>> +       }, {
>> +               .start = MCF_IRQ_SDHC,
>> +               .end = MCF_IRQ_SDHC,
>> +               .flags = IORESOURCE_IRQ,
>> +       },
>> +};
>> +
>> +static struct platform_device mcf_esdhc = {
>> +       .name                   = "sdhci-esdhc-mcf",
>> +       .id                     = 0,
>> +       .num_resources          = ARRAY_SIZE(mcf_esdhc_resources),
>> +       .resource               = mcf_esdhc_resources,
>> +       .dev.platform_data      = &mcf_esdhc_data,
>> +};
>> +#endif /* IS_ENABLED(CONFIG_MMC) */
>> +
>>   static struct platform_device *mcf_devices[] __initdata = {
>>          &mcf_uart,
>>   #if IS_ENABLED(CONFIG_FEC)
>> @@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
>>   #if IS_ENABLED(CONFIG_MCF_EDMA)
>>          &mcf_edma,
>>   #endif
>> +#if IS_ENABLED(CONFIG_MMC)
>> +       &mcf_esdhc,
>> +#endif
>>   };
>>
>>   /*
>> @@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
>>   }
>>
>>   arch_initcall(mcf_init_devices);
>> -
>> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
>> index 5bd24c9b865d..ffa02de1a3fb 100644
>> --- a/arch/m68k/coldfire/m5441x.c
>> +++ b/arch/m68k/coldfire/m5441x.c
>> @@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
>>   DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
>>   DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
>>   DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
>> -DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
>> +DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
>>   DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
>>   DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
>>   DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
>> @@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
>>   DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
>>   DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
>>
>> +DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
>> +DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
>> +DEFINE_CLK(2, "per.0", 2, MCF_CLK);
>> +
>>   struct clk *mcf_clks[] = {
>>          &__clk_0_2,
>>          &__clk_0_8,
>> @@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
>>          &__clk_1_34,
>>          &__clk_1_36,
>>          &__clk_1_37,
>> +
>> +       &__clk_2_0,
>> +       &__clk_2_1,
>> +       &__clk_2_2,
>> +
>>          NULL,
>>   };
>>
>> @@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
>>          &__clk_0_33, /* pit.1 */
>>          &__clk_0_37, /* eport */
>>          &__clk_0_48, /* pll */
>> +       &__clk_0_51, /* esdhc */
>>
>>          &__clk_1_36, /* CCM/reset module/Power management */
>>          &__clk_1_37, /* gpio */
>> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
>> index 4892f314ff38..750555a6fa87 100644
>> --- a/arch/m68k/include/asm/m5441xsim.h
>> +++ b/arch/m68k/include/asm/m5441xsim.h
>> @@ -278,6 +278,17 @@
>>   #define MCFGPIO_IRQ_VECBASE    (MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
>>   #define MCFGPIO_PIN_MAX                87
>>
>> +/*********************************************************************
>> + *
>> + * Phase Locked Loop (PLL)
>> + *
>> + *********************************************************************/
>> +
>> +/* Register read/write macros */
>> +#define MCF_PLL_CR             0xFC0C0000
>> +#define MCF_PLL_DR             0xFC0C0004
>> +#define MCF_PLL_SR             0xFC0C0008
>> +
>>   /*
>>    *  DSPI module.
>>    */
>> @@ -298,5 +309,13 @@
>>   #define MCFEDMA_IRQ_INTR16     (MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
>>   #define MCFEDMA_IRQ_INTR56     (MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
>>   #define MCFEDMA_IRQ_ERR        (MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
>> +/*
>> + *  esdhc module.
>> + */
>> +#define MCFSDHC_BASE           0xfc0cc000
>> +#define MCFSDHC_SIZE           256
>> +#define MCFINT2_SDHC           31
>> +#define MCF_IRQ_SDHC           (MCFINT2_VECBASE + MCFINT2_SDHC)
>> +#define MCFSDHC_CLK            (MCFSDHC_BASE + 0x2c)
>>
>>   #endif /* m5441xsim_h */
>> diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
>> index 0aca504fae31..722627e06d66 100644
>> --- a/arch/m68k/include/asm/mcfclk.h
>> +++ b/arch/m68k/include/asm/mcfclk.h
>> @@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
>>   extern struct clk_ops clk_ops1;
>>   #endif /* MCFPM_PPMCR1 */
>>
>> +extern struct clk_ops clk_ops2;
>> +
>>   #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
>>   static struct clk __clk_##clk_bank##_##clk_slot = { \
>>          .name = clk_name, \
>> diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
>> new file mode 100644
>> index 000000000000..85cb786a62fe
>> --- /dev/null
>> +++ b/include/linux/platform_data/mmc-esdhc-mcf.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
>> +#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
>> +
>> +enum cd_types {
>> +       ESDHC_CD_NONE,          /* no CD, neither controller nor gpio */
>> +       ESDHC_CD_CONTROLLER,    /* mmc controller internal CD */
>> +       ESDHC_CD_PERMANENT,     /* no CD, card permanently wired to host */
>> +};
>> +
>> +struct mcf_esdhc_platform_data {
>> +       int max_bus_width;
>> +       int cd_type;
>> +};
>> +
>> +#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
>> --
>> 2.26.0
>>
