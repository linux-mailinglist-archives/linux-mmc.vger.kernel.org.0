Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9553801C7
	for <lists+linux-mmc@lfdr.de>; Fri, 14 May 2021 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhENCMA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 13 May 2021 22:12:00 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:28924 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhENCL7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2021 22:11:59 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14E1ulev039779;
        Fri, 14 May 2021 09:56:47 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 May
 2021 10:09:03 +0800
Date:   Fri, 14 May 2021 10:09:01 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset
 signal before probing eMMC
Message-ID: <20210514020900.GB540@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
 <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
 <20210507062416.GD23749@aspeedtech.com>
 <2a339218-19d7-4eea-a734-8053dd553dbb@www.fastmail.com>
 <20210510060338.GB6883@aspeedtech.com>
 <f063cb34-9a42-4373-a333-cad1d8a9c37b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f063cb34-9a42-4373-a333-cad1d8a9c37b@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14E1ulev039779
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 05/13/2021 08:42, Andrew Jeffery wrote:
> 
> 
> On Mon, 10 May 2021, at 15:33, Steven Lee wrote:
> > The 05/07/2021 15:36, Andrew Jeffery wrote:
> > > 
> > > 
> > > On Fri, 7 May 2021, at 15:54, Steven Lee wrote:
> > > > The 05/07/2021 09:32, Andrew Jeffery wrote:
> > > > > 
> > > > > 
> > > > > On Thu, 6 May 2021, at 19:54, Philipp Zabel wrote:
> > > > > > Hi Steven,
> > > > > > 
> > > > > > On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > > > > > > +	if (info) {
> > > > > > > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > > > > > > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > > > > 
> > > > > > Please use devm_reset_control_get_exclusive() or
> > > > > > devm_reset_control_get_optional_exclusive().
> > > > > > 
> > > > > > > +			if (!IS_ERR(sdc->rst)) {
> > > > > > 
> > > > > > Please just return errors here instead of ignoring them.
> > > > > > The reset_control_get_optional variants return NULL in case the
> > > > > > device node doesn't contain a resets phandle, in case you really
> > > > > > consider this reset to be optional even though the flag is set?
> > > > > 
> > > > > It feels like we should get rid of the flag and leave it to the 
> > > > > devicetree.
> > > > > 
> > > > 
> > > > Do you mean adding a flag, for instance, "mmc-reset" in the
> > > > device tree and call of_property_read_bool() in aspeed_sdc_probe()?
> > > > 
> > > > > I'm still kind of surprised it's not something we want to do for the 
> > > > > 2400 and 2500 as well.
> > > > > 
> > > > 
> > > > Per discussion with the chip designer, AST2400 and AST2500 doesn't need
> > > > this implementation since the chip design is different to AST2600.
> > > 
> > > So digging a bit more deeply on this, it looks like the reset is 
> > > already taken care of by drivers/clk/clk-ast2600.c in the 
> > > clk_prepare_enable() path.
> > > 
> > > clk-ast2600 handles resets when enabling the clock for most peripherals:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n276
> > > 
> > > and this is true for both the SD controller and the eMMC controller:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n94
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n88
> > > 
> > > If this weren't the case you'd specify a reset property in the SD/eMMC 
> > > devicetree nodes for the 2600 and then use 
> > > devm_reset_control_get_optional_exclusive() as Philipp suggested. See 
> > > the reset binding here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/reset/reset.txt?h=v5.12
> > > 
> > > So on the surface it seems the reset handling in this patch is 
> > > unnecessary. Have you observed an issue with the SoC that means it's 
> > > required?
> > > 
> > 
> > Yes, you are right, aspeed_sdc_probe() calls clk_prepare_enable(),
> > aspeed_g6_clk_enable() does reset eMMC.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-of-aspeed.c#n496
> > 
> > However, the clock of eMMC is enabled in my u-boot(2019.04).
> > So it is retruned in the condition of aspeed_g6_clk_is_enabled() below
> > and doesn't reset eMMC.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n285
> 
> Okay, so what's the issue that the patch addresses? Is there a bug? 
> Presumably if u-boot isn't making use of the eMMC the clock won't be 
> on, so we'll do the reset if the kernel wants to make use of the 
> device. If u-boot _is_ using the eMMC, u-boot will have done the 
> correct clock enable/reset sequence and so the controller should be 
> ready to go?
> 
> The only potential issue remaining is u-boot leaving the controller in 
> a configuration the kernel isn't expecting when handing over. If that's 
> the issue then we've forgotten to do some specific initialisation (i.e. 
> not just reset the entire thing) of the controller in the driver probe 
> path, right?
> 

If DMA engine is used before probing eMMC in kernel stage,
eMMC controller may have unexpected behavior when re-exectuing
identifying process.
Thus, we need to reset at the beginning of kernel since
kernel is a new stage. We should not assume some one do something
before.

> FWIW I haven't recently seen any poor behaviour from the controller or 
> driver. For us (IBM) it seems to be working well since we sorted out 
> the phase configuration.
> 

Yes, you are right, everything work well currently. But, kernel is a new
stage, we cannot assume eMMC controller is at initial state when
entering kernel stage.

> Andrew
