Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F0506BF2
	for <lists+linux-mmc@lfdr.de>; Tue, 19 Apr 2022 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiDSMO2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 19 Apr 2022 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352443AbiDSMNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 08:13:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA610A9;
        Tue, 19 Apr 2022 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8gQWXQgd27+7MjvZ/x9NAZsP0RMarQtIN5a8js2NhjY=; b=mzKoH3TXs2ckA/NQw7+zgkNA5K
        8p0VVw0yWNiUHQ3Ohv+7MbWluGIHQO7uu0pzi4wrKVM53wXY1XHgpaGYN6WEwNXK/+MRUY4CBBGFV
        SAIjxVSGcE6bRlBATcYyxrWoQ8cbfSrZhpLStIiS4JSOlavyI01sMEL7eWzSHfs3oTFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ngmfg-00GUco-Kr; Tue, 19 Apr 2022 14:09:28 +0200
Date:   Tue, 19 Apr 2022 14:09:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, nico@fluxnic.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] ARM: dts: dove: Update sdio-host node names to
 match schema
Message-ID: <Yl6meIXs9C6Z6AsA@lunn.ch>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
 <20220419024611.1327525-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419024611.1327525-3-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 19, 2022 at 02:46:09PM +1200, Chris Packham wrote:
> Update the node names of the sdio-host@ interfaces to be mmc@ to match
> the node name enforced by the mmc-controller.yaml schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
