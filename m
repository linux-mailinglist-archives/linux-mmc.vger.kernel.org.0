Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D41828C1
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Aug 2019 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHFAiu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Aug 2019 20:38:50 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59553 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfHFAit (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2019 20:38:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EB5B52307;
        Mon,  5 Aug 2019 20:38:47 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 05 Aug 2019 20:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=x/FmbQA70Z4mje3y7VGtwApl9xp6RTV
        VRLXboLhs2Fk=; b=ZGfMkscqBzdJrmqsA76P07XYPKAByfmKxaJlWOgGcYyoh9M
        sAMv+9LxEvw7F9Tc2j0VSPOAzYCeq6EYXZkt/1yqDnjTm83/9wVj2fiKfms4Do7u
        BH66HBfVN2EQhrsAneqJUPEwOlNF9qTsdp+zPawpHkEmaMeZmJCtVg5ZJ1adT2ue
        2Ia7S/WYRx5Nlw14UlgZfgCO6pMPrFwb4T/MF3RZWscFMSMAM0aqImq1SPMjBubF
        t2QgkRraeYwbCGbW+Y7xmIqbghI7ulOhhQy3pNsgd07Xrd1mpK6cE1lJJn/LpSNS
        1Ot9lgrKOpFmgtuSx0At/JhI2t6O7j1nb5prqMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=x/FmbQ
        A70Z4mje3y7VGtwApl9xp6RTVVRLXboLhs2Fk=; b=SuoNoSB0MGyMGuV9TmVmin
        OVkbJSgM74uliWJdHaFH5pfCfEst4COYfXuaQsRNfURCvyqpcHu143/qNO3+CHa+
        vRKLoNPniz7pQng1cj+d8MpAgl2F/HTJIhMkFtXdtmOlY3Bvsvrxn4/CHJKLeg5w
        xto0yJATXsx8QXMQ69xdSMDqOFuHo0LEGke+5IrqQoMw0uOivZBDM67186zit2NO
        NWg+OfvQPjFZyMVR6qyh9ZAxj+F5NFz+U/tyyROxrOXwNjrLeT3dWv+jUZqMktoE
        GX2dgYRA2c/WS89D99wNpaD/cZFtdWYeVB1I+px/oIQKKlyGKUpvze0pd+kZ80pQ
        ==
X-ME-Sender: <xms:FsxIXT8wMy-ydYcbV5G-ZVOSE-QDHzUWny3Y5l8ZNrln4XSOve3ZQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:FsxIXZwvIstLosN--5ek9_dPgLXA7RM2KIeV4QaCF5PW_bCqGHMEaw>
    <xmx:FsxIXV-5zm2SKq2_OxzcVbsmGTftaF6L8671VDaaMtixr6YzNgQCLQ>
    <xmx:FsxIXXMqEjsNp8tvzrKNlCqD4jbHgzelhLqJO9LgFFaQYn5pEUy1iQ>
    <xmx:F8xIXY3W9NCJ9W17PBCvX4_MUuGxFvQl-n5qb-Frqv7y-GGv9uYJQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E116E00A2; Mon,  5 Aug 2019 20:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-799-g925e343-fmstable-20190729v1
Mime-Version: 1.0
Message-Id: <222b7a32-7c69-4af1-a72f-433e671604d3@www.fastmail.com>
In-Reply-To: <497ab8d6-24aa-c505-a1fa-e71fa1560da1@intel.com>
References: <20190805025155.9020-1-andrew@aj.id.au>
 <20190805025155.9020-3-andrew@aj.id.au>
 <497ab8d6-24aa-c505-a1fa-e71fa1560da1@intel.com>
Date:   Tue, 06 Aug 2019 10:09:11 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: Add support for the ASPEED SD controller
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Mon, 5 Aug 2019, at 23:08, Adrian Hunter wrote:
> On 5/08/19 5:51 AM, Andrew Jeffery wrote:
> > Add a minimal driver for ASPEED's SD controller, which exposes two
> > SDHCIs.
> > 
> > The ASPEED design implements a common register set for the SDHCIs, and
> > moves some of the standard configuration elements out to this common
> > area (e.g. 8-bit mode, and card detect configuration which is not
> > currently supported).
> > 
> > The SD controller has a dedicated hardware interrupt that is shared
> > between the slots. The common register set exposes information on which
> > slot triggered the interrupt; early revisions of the patch introduced an
> > irqchip for the register, but reality is it doesn't behave as an
> > irqchip, and the result fits awkwardly into the irqchip APIs. Instead
> > I've taken the simple approach of using the IRQ as a shared IRQ with
> > some minor performance impact for the second slot.
> > 
> > Ryan was the original author of the patch - I've taken his work and
> > massaged it to drop the irqchip support and rework the devicetree
> > integration. The driver has been smoke tested under qemu against a
> > minimal SD controller model and lightly tested on an ast2500-evb.
> > 
> > Signed-off-by: Ryan Chen <ryanchen.aspeed@gmail.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> One minor comment otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> > 
> > ---
> > v3: No change
> > v2:
> > * Add AST2600 compatible
> > * Drop SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
> > * Ensure slot number is valid
> > * Fix build with CONFIG_MODULES
> > * Fix module license string
> > * Non-PCI devices won't die
> > * Rename aspeed_sdc_configure_8bit_mode()
> > * Rename aspeed_sdhci_pdata
> > * Switch to sdhci_enable_clk()
> > * Use PTR_ERR() on the right `struct platform_device *`
> > ---
> >  drivers/mmc/host/Kconfig           |  12 ++
> >  drivers/mmc/host/Makefile          |   1 +
> >  drivers/mmc/host/sdhci-of-aspeed.c | 328 +++++++++++++++++++++++++++++
> >  3 files changed, 341 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 14d89a108edd..0f8a230de2f3 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -154,6 +154,18 @@ config MMC_SDHCI_OF_ARASAN
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_OF_ASPEED
> > +	tristate "SDHCI OF support for the ASPEED SDHCI controller"
> > +	depends on MMC_SDHCI_PLTFM
> > +	depends on OF
> > +	help
> > +	  This selects the ASPEED Secure Digital Host Controller Interface.
> > +
> > +	  If you have a controller with this interface, say Y or M here. You
> > +	  also need to enable an appropriate bus interface.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_OF_AT91
> >  	tristate "SDHCI OF support for the Atmel SDMMC controller"
> >  	depends on MMC_SDHCI_PLTFM
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 73578718f119..390ee162fe71 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -84,6 +84,7 @@ obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
> >  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
> > +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > new file mode 100644
> > index 000000000000..d31785ec90d7
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -0,0 +1,328 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* Copyright (C) 2019 ASPEED Technology Inc. */
> > +/* Copyright (C) 2019 IBM Corp. */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "sdhci-pltfm.h"
> > +
> > +#define ASPEED_SDC_INFO		0x00
> > +#define   ASPEED_SDC_S1MMC8	BIT(25)
> > +#define   ASPEED_SDC_S0MMC8	BIT(24)
> > +
> > +struct aspeed_sdc {
> > +	struct clk *clk;
> > +	struct resource *res;
> > +
> > +	spinlock_t lock;
> > +	void __iomem *regs;
> > +};
> > +
> > +struct aspeed_sdhci {
> > +	struct aspeed_sdc *parent;
> > +	u32 width_mask;
> > +};
> > +
> > +static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> > +					   struct aspeed_sdhci *sdhci,
> > +					   bool bus8)
> > +{
> > +	u32 info;
> > +
> > +	/* Set/clear 8 bit mode */
> > +	spin_lock(&sdc->lock);
> > +	info = readl(sdc->regs + ASPEED_SDC_INFO);
> > +	if (bus8)
> > +		info |= sdhci->width_mask;
> > +	else
> > +		info &= ~sdhci->width_mask;
> > +	writel(info, sdc->regs + ASPEED_SDC_INFO);
> > +	spin_unlock(&sdc->lock);
> > +}
> > +
> > +static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > +{
> > +	int div;
> > +	u16 clk;
> > +
> > +	if (clock == host->clock)
> > +		return;
> > +
> > +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +	if (clock == 0)
> > +		goto out;
> > +
> > +	for (div = 1; div < 256; div *= 2) {
> > +		if ((host->max_clk / div) <= clock)
> > +			break;
> > +	}
> > +	div >>= 1;
> > +
> > +	clk = div << SDHCI_DIVIDER_SHIFT;
> > +
> > +	sdhci_enable_clk(host, clk);
> > +
> > +out:
> > +	host->clock = clock;
> > +}
> > +
> > +static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_priv;
> > +	struct aspeed_sdhci *aspeed_sdhci;
> > +	struct aspeed_sdc *aspeed_sdc;
> > +	u8 ctrl;
> > +
> > +	pltfm_priv = sdhci_priv(host);
> > +	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
> > +	aspeed_sdc = aspeed_sdhci->parent;
> > +
> > +	/* Set/clear 8-bit mode */
> > +	aspeed_sdc_configure_8bit_mode(aspeed_sdc, aspeed_sdhci,
> > +				       width == MMC_BUS_WIDTH_8);
> > +
> > +	/* Set/clear 1 or 4 bit mode */
> > +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > +	if (width == MMC_BUS_WIDTH_4)
> > +		ctrl |= SDHCI_CTRL_4BITBUS;
> > +	else
> > +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> > +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +}
> > +
> > +static const struct sdhci_ops aspeed_sdhci_ops = {
> > +	.set_clock = aspeed_sdhci_set_clock,
> > +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > +	.set_bus_width = aspeed_sdhci_set_bus_width,
> > +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> > +	.reset = sdhci_reset,
> > +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> > +};
> > +
> > +static const struct sdhci_pltfm_data aspeed_sdhci_pdata = {
> > +	.ops = &aspeed_sdhci_ops,
> > +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > +};
> > +
> > +static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > +					      struct resource *res)
> > +{
> > +	resource_size_t delta;
> > +
> > +	if (!res || resource_type(res) != IORESOURCE_MEM)
> > +		return -EINVAL;
> > +
> > +	if (res->start < dev->parent->res->start)
> > +		return -EINVAL;
> > +
> > +	delta = res->start - dev->parent->res->start;
> > +	if (delta & (0x100 - 1))
> > +		return -EINVAL;
> > +
> > +	return (delta / 0x100) - 1;
> > +}
> > +
> > +static int aspeed_sdhci_probe(struct platform_device *pdev)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct aspeed_sdhci *dev;
> > +	struct sdhci_host *host;
> > +	struct resource *res;
> > +	int slot;
> > +	int ret;
> > +
> > +	host = sdhci_pltfm_init(pdev, &aspeed_sdhci_pdata, sizeof(*dev));
> > +	if (IS_ERR(host))
> > +		return PTR_ERR(host);
> > +
> > +	pltfm_host = sdhci_priv(host);
> > +	dev = sdhci_pltfm_priv(pltfm_host);
> > +	dev->parent = dev_get_drvdata(pdev->dev.parent);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	slot = aspeed_sdhci_calculate_slot(dev, res);
> > +
> > +	if (slot < 0)
> > +		return slot;
> > +	else if (slot >= 2)
> > +		return -EINVAL;
> > +
> > +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> > +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> > +
> > +	sdhci_get_of_property(pdev);
> > +
> > +	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(pltfm_host->clk))
> > +		return PTR_ERR(pltfm_host->clk);
> > +
> > +	ret = clk_prepare_enable(pltfm_host->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable SDIO clock\n");
> > +		goto err_pltfm_free;
> > +	}
> > +
> > +	ret = mmc_of_parse(host->mmc);
> > +	if (ret)
> > +		goto err_sdhci_add;
> > +
> > +	ret = sdhci_add_host(host);
> > +	if (ret)
> > +		goto err_sdhci_add;
> > +
> > +	return 0;
> > +
> > +err_sdhci_add:
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +err_pltfm_free:
> > +	sdhci_pltfm_free(pdev);
> > +	return ret;
> > +}
> > +
> > +static int aspeed_sdhci_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct sdhci_host *host;
> > +	int dead = 0;
> > +
> > +	host = platform_get_drvdata(pdev);
> > +	pltfm_host = sdhci_priv(host);
> > +
> > +	sdhci_remove_host(host, dead);
> > +
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +
> > +	sdhci_pltfm_free(pdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_sdhci_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sdhci", },
> > +	{ .compatible = "aspeed,ast2500-sdhci", },
> > +	{ .compatible = "aspeed,ast2600-sdhci", },
> > +	{ }
> > +};
> > +
> > +static struct platform_driver aspeed_sdhci_driver = {
> > +	.driver		= {
> > +		.name	= "sdhci-aspeed",
> > +		.of_match_table = aspeed_sdhci_of_match,
> > +	},
> > +	.probe		= aspeed_sdhci_probe,
> > +	.remove		= aspeed_sdhci_remove,
> > +};
> > +
> > +static int aspeed_sdc_probe(struct platform_device *pdev)
> > +
> > +{
> > +	struct device_node *parent, *child;
> > +	struct aspeed_sdc *sdc;
> > +	int ret;
> > +
> > +	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> > +	if (!sdc)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&sdc->lock);
> > +
> > +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(sdc->clk))
> > +		return PTR_ERR(sdc->clk);
> > +
> > +	ret = clk_prepare_enable(sdc->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable SDCLK\n");
> > +		return ret;
> > +	}
> > +
> > +	sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> > +	if (IS_ERR(sdc->regs)) {
> > +		ret = PTR_ERR(sdc->regs);
> > +		goto err_clk;
> > +	}
> > +
> > +	dev_set_drvdata(&pdev->dev, sdc);
> > +
> > +	parent = pdev->dev.of_node;
> > +	for_each_available_child_of_node(parent, child) {
> > +		struct platform_device *cpdev;
> > +
> > +		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> > +		if (IS_ERR(cpdev)) {
> > +			of_node_put(child);
> > +			ret = PTR_ERR(cpdev);
> > +			goto err_clk;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +err_clk:
> > +	clk_disable_unprepare(sdc->clk);
> > +	return ret;
> > +}
> > +
> > +static int aspeed_sdc_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
> > +
> > +	clk_disable_unprepare(sdc->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_sdc_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sd-controller", },
> > +	{ .compatible = "aspeed,ast2500-sd-controller", },
> > +	{ .compatible = "aspeed,ast2600-sd-controller", },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> > +
> > +static struct platform_driver aspeed_sdc_driver = {
> > +	.driver		= {
> > +		.name	= "sd-controller-aspeed",
> > +		.pm	= &sdhci_pltfm_pmops,
> > +		.of_match_table = aspeed_sdc_of_match,
> > +	},
> > +	.probe		= aspeed_sdc_probe,
> > +	.remove		= aspeed_sdc_remove,
> > +};
> > +
> > +static int __init aspeed_sdc_init(void)
> > +{
> > +	int rc;
> > +
> > +	rc = platform_driver_register(&aspeed_sdhci_driver);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return platform_driver_register(&aspeed_sdc_driver);
> 
> Shouldn't aspeed_sdhci_driver be unregistered here if there was an error.

Yeah, fair point. I'll send a v5 to fix that.

Thanks for the feedback.

Andrew
