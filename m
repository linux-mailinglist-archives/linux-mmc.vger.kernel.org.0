Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541D0501F25
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Apr 2022 01:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiDNXfl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Apr 2022 19:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbiDNXfk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2022 19:35:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54129ADD5C;
        Thu, 14 Apr 2022 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=HmUE+PZp0Rbqp9MW9Lg51Iv1Xyhv5G1uDn7lkiqLRCw=; b=Hzln3JrzvsaMlEIvbahrKm8QgL
        mdPO2fX1+PiWnpmBgSLENXHIwMx9CfhfiOqs6TtWwoDot7qRvgUy3I43S0/4h+z1RT5u5tE253oUM
        uLGnUzuO/7kusbfPMxacQYmVbHK8OVwfrYDRNFbDhoRmEaOECykgii3LG5h4OOMZ++7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nf8xU-00Ft7z-5J; Fri, 15 Apr 2022 01:33:04 +0200
Date:   Fri, 15 Apr 2022 01:33:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
Message-ID: <YlivMII9rDCcB6lk@lunn.ch>
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
 <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Chris

> +required:
> +  - compatible
> +  - reg
> +  - interrupts

https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci-dove.c#L78

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/dove.dtsi#L344

Dove does actually have a clock. It looks like it is optional in the
driver, but the .dtsi file has it. It is not documented in the current
.txt file, so i can understand you missing it.

I'm surprised the DT tools didn't complain about an unexpected
property.

	Andrew
