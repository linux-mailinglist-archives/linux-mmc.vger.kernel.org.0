Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776082EC02E
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Jan 2021 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAFPKm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Jan 2021 10:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFPKm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jan 2021 10:10:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB21C06134C
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jan 2021 07:10:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kxARd-0003oM-Db; Wed, 06 Jan 2021 16:09:53 +0100
Message-ID: <51b607eb7691f2b631f5c809022f4361ec78256e.camel@pengutronix.de>
Subject: Re: sdhci timeout on imx8mq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bough Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 06 Jan 2021 16:09:50 +0100
In-Reply-To: <VI1PR04MB52945F58FDD4A2902A30F2C290D00@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
         <20200205092653.GB2737@bogon.m.sigxcpu.org>
         <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
         <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
         <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
         <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
                 <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
         <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
         <VI1PR04MB52945F58FDD4A2902A30F2C290D00@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

Am Mittwoch, dem 06.01.2021 um 09:29 +0000 schrieb Bough Chen:
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: 2021年1月5日 23:07
> > To: Bough Chen <haibo.chen@nxp.com>; Fabio Estevam
> > <festevam@gmail.com>; Angus Ainslie <angus@akkea.ca>; Leonard
> > Crestez
> > <leonard.crestez@nxp.com>; Peng Fan <peng.fan@nxp.com>; Abel Vesa
> > <abel.vesa@nxp.com>; Stephen Boyd <sboyd@kernel.org>; Michael
> > Turquette
> > <mturquette@baylibre.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>; Guido Günther <
> > agx@sigxcpu.org>;
> > linux-mmc <linux-mmc@vger.kernel.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha
> > Hauer
> > <kernel@pengutronix.de>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: sdhci timeout on imx8mq
> > 
> > Hi all,
> > 
> > Am Mittwoch, dem 08.07.2020 um 01:32 +0000 schrieb BOUGH CHEN:
> > > > -----Original Message-----
> > > > From: Fabio Estevam [mailto:festevam@gmail.com]
> > > > Sent: 2020年7月7日 20:45
> > > > To: Angus Ainslie <angus@akkea.ca>
> > > > Cc: BOUGH CHEN <haibo.chen@nxp.com>; Ulf Hansson
> > > > <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>;
> > > > linux-
> > > > mmc <linux-mmc@vger.kernel.org>; Adrian Hunter
> > > > <adrian.hunter@intel.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > > Sascha
> > > > Hauer < kernel@pengutronix.de>; moderated list:ARM/FREESCALE
> > > > IMX /
> > > > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> > > > Subject: Re: sdhci timeout on imx8mq
> > > > 
> > > > Hi Angus,
> > > > 
> > > > On Tue, Jun 30, 2020 at 4:39 PM Angus Ainslie <angus@akkea.ca>
> > > > wrote:
> > > > 
> > > > > Has there been any progress with this. I'm getting this on
> > > > > about
> > > > > 50% of
> > > > 
> > > > Not from my side, sorry.
> > > > 
> > > > Bough,
> > > > 
> > > > Do you know why this problem affects the imx8mq-evk versions
> > > > that
> > > > are populated with the Micron eMMC and not the ones with
> > > > Sandisk
> > > > eMMC?
> > > 
> > > Hi Angus,
> > > 
> > > Can you show me the full fail log? I do not meet this issue on my
> > > side, besides, which kind of uboot do you use?
> > 
> > I was finally able to bisect this issue, which wasn't that much fun
> > due to the
> > issue not being reproducible 100%. :/ Turns out that the issue is
> > even more
> > interesting than I thought and likely doesn't have anything to do
> > with SDHCI or
> > used bootloader versions. Here's my current debugging state:
> > 
> > I've bisected the issue down to b04383b6a558 (clk: imx8mq: Define
> > gates for
> > pll1/2 fixed dividers). The change itself looks fine to me, still
> > CC'ed Leonard for
> > good measure.
> > 
> > In my testing the following partial revert fixes the issue:
> > 
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -365,7 +365,7 @@ static int imx8mq_clocks_probe(struct
> > platform_device *pdev)
> >         hws[IMX8MQ_SYS1_PLL_133M_CG] =
> > imx_clk_hw_gate("sys1_pll_133m_cg", "sys1_pll_out", base + 0x30, 15);
> >         hws[IMX8MQ_SYS1_PLL_160M_CG] =
> > imx_clk_hw_gate("sys1_pll_160m_cg", "sys1_pll_out", base + 0x30, 17);
> >         hws[IMX8MQ_SYS1_PLL_200M_CG] =
> > imx_clk_hw_gate("sys1_pll_200m_cg", "sys1_pll_out", base + 0x30, 19);
> > -       hws[IMX8MQ_SYS1_PLL_266M_CG] =
> > imx_clk_hw_gate("sys1_pll_266m_cg", "sys1_pll_out", base + 0x30, 21);
> >         hws[IMX8MQ_SYS1_PLL_400M_CG] =
> > imx_clk_hw_gate("sys1_pll_400m_cg", "sys1_pll_out", base + 0x30, 23);
> >         hws[IMX8MQ_SYS1_PLL_800M_CG] =
> > imx_clk_hw_gate("sys1_pll_800m_cg", "sys1_pll_out", base + 0x30, 25);
> > 
> > @@ -375,7 +375,7 @@ static int imx8mq_clocks_probe(struct
> > platform_device *pdev)
> >         hws[IMX8MQ_SYS1_PLL_133M] =
> > imx_clk_hw_fixed_factor("sys1_pll_133m", "sys1_pll_133m_cg", 1, 6);
> >         hws[IMX8MQ_SYS1_PLL_160M] =
> > imx_clk_hw_fixed_factor("sys1_pll_160m", "sys1_pll_160m_cg", 1, 5);
> >         hws[IMX8MQ_SYS1_PLL_200M] =
> > imx_clk_hw_fixed_factor("sys1_pll_200m", "sys1_pll_200m_cg", 1, 4);
> > -       hws[IMX8MQ_SYS1_PLL_266M] =
> > imx_clk_hw_fixed_factor("sys1_pll_266m", "sys1_pll_266m_cg", 1, 3);
> > +       hws[IMX8MQ_SYS1_PLL_266M] =
> > + imx_clk_hw_fixed_factor("sys1_pll_266m", "sys1_pll_out", 1, 3);
> >         hws[IMX8MQ_SYS1_PLL_400M] =
> > imx_clk_hw_fixed_factor("sys1_pll_400m", "sys1_pll_400m_cg", 1, 2);
> >         hws[IMX8MQ_SYS1_PLL_800M] =
> > imx_clk_hw_fixed_factor("sys1_pll_800m", "sys1_pll_800m_cg", 1, 1);
> > 
> > The sys1_pll_266m is the parent of nand_usdhc_bus. I've validated
> > that the
> > SDHCI driver properly enables this bus clock across the problematic
> > card access.
> > So what I think is happening here is that both nand_usdhc_bus and
> > sys1_pll_266m are initially enabled. Sometime during boot
> > sys1_pll_266m gets
> > disabled due to runtime PM on the enet_axi clock, which is a direct
> > child of
> > sys1_pll_266m. At this point nand_usdhc_bus is still enabled, but
> > no consumer
> > has claimed the clock yet, so the parent clock gets disabled while
> > this branch of
> > the clock tree is still active.
> 
> Hi Lucas,
> 
> According to the clock tree, if nand_usdhc_bus is still enabled, then
> sys1_pll_266m has no chance to disable.

This statement is only correct after the SDHCI driver is probed an has
enabled nand_usdhc_bus. Before the driver probes the refcounts on the
clocks are not synchronized, so sys1_pll_266m_cg can be disabled, while
nand_usdhc_bus is enabled (from software running before Linux), even
though no consumer is using nand_usdhc_bus, yet.

>     sys1_pll_266m_cg                  1        1        0   800000000          0     0  50000         Y
>        sys1_pll_266m                  1        1        0   266666666          0     0  50000         Y
>           nand_usdhc_bus              0        0        0   266666666          0     0  50000         N
>              nand_usdhc_rawnand_clk       0        0        0   266666666          0     0  50000         N
>           enet_axi                    1        1        0   266666666          0     0  50000         Y
>              enet1_root_clk           2        2        0   266666666          0     0  50000         Y
> 
> 
> This issue seems related with the following errta:
> 
> e11232: USDHC: uSDHC setting requirement for IPG_CLK and AHB_BUS
> clocks
> Description: uSDHC AHB_BUS and IPG_CLK clocks must be synchronized.
> Due to current physical design implementation, AHB_BUS and IPG_CLK
> must come from
> same clock source to maintain clock sync.
> Workaround: Set AHB_BUS and IPG_CLK to clock source from PLL1.
> 
> After sys1_pll_266m gate off/on, seems need to sync the USDHC AHB bus
> and USDHC IPG_clk again. (Here usdhc AHB BUS source from
> nand_usdhc_bus.)
> This sync is handle by hardware, and maybe need some time, during
> this sync period, usdhc operation may has issue.

Where in HW is this synchronization done? If it's at the uSDHC
controller side, I would expect this issue to show up even with the
commit reverted, as nand_usdhc_bus gets gated due to runtime PM from
the controller side. The only difference with the commit in question is
that now the clock branch can be gated _before_ nand_usdhc_bus. If the
synchronization is done somewhere in the clock tree than this might be
an issue.

> 
> I just double check our local v5.10 branch, already revert the commit
> b04383b6a558 (clk: imx8mq: Define gates for pll1/2 fixed dividers).
> So to fix this issue, one method is revert this patch, another method
> is keep the 'nand_usdhc_bus' always on. Add change like this:
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 779ea69e639c..939806b36916 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -433,7 +433,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>         /* BUS */
>         hws[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
>         hws[IMX8MQ_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mq_enet_axi_sels, base + 0x8880);
> -       hws[IMX8MQ_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus("nand_usdhc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
> +       hws[IMX8MQ_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
>         hws[IMX8MQ_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mq_vpu_bus_sels, base + 0x8980);
>         hws[IMX8MQ_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mq_disp_axi_sels, base + 0x8a00);
>         hws[IMX8MQ_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mq_disp_apb_sels, base + 0x8a80);
> 
> 
> What you think? Or any other suggestion?

This is suboptimal, as it will not allow to gate the uSDHC controller
AHB clock in runtime suspend. Also my testing shows that it's the gate
_before_ the nand_usdhc_bus slice that's causing the issue. So my
minimal fix from the previous mail would still be better, as it allows
to gate the nand_usdhc_bus clock, while keeping sys1_pll_266m enabled.

Regards,
Lucas
> 

