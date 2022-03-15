Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2F4D9103
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Mar 2022 01:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiCOAOO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 14 Mar 2022 20:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiCOAON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 20:14:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263786550;
        Mon, 14 Mar 2022 17:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dxSFLKp24IEE3ZbRaqX5QTrZlpbhDWVCEB9VKKIfjyY=; b=ofGfGCvqo/t/7TGOgnUmnfOlf/
        RXJga7J2IAilCEUIatyCYU+logiVaSoonWgKRtSPzSxWnTCmbEzXG7V1nEYf6suI891LAYzU00muW
        KREQLbnslBAXhz8t0ZiOtvteIBwByUH2lvB8iRALNXhFR467v6hCvZOQEoiJrDJci+0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nTunx-00Apyf-ON; Tue, 15 Mar 2022 01:12:49 +0100
Date:   Tue, 15 Mar 2022 01:12:49 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        davem@davemloft.net, kuba@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, thomas.petazzoni@bootlin.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/8] net: mvneta: Add support for 98DX2530 Ethernet
 port
Message-ID: <Yi/aAemqY+NBRaov@lunn.ch>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314213143.2404162-6-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 15, 2022 at 10:31:40AM +1300, Chris Packham wrote:
> The 98DX2530 SoC is similar to the Armada 3700 except it needs a
> different MBUS window configuration. Add a new compatible string to
> identify this device and the required MBUS window configuration.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I suggest you separate the two mvneta patches and send them to the
netdev list. They are likely to get merged before the merge window
opens next weekend. The other patches are less likely to be merged so
fast.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
