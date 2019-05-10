Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4819C08
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEJK6D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 06:58:03 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43187 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfEJK6D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 May 2019 06:58:03 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 45FF94000B;
        Fri, 10 May 2019 10:58:00 +0000 (UTC)
Date:   Fri, 10 May 2019 12:57:59 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
Message-ID: <20190510105759.z2ob5tl4ovn2ctdo@flea>
References: <68d3fb999d16e49696e832e1d1a6bcd7b76a6e8d.1557389988.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqJi0iwM61anziC-cHXp0PL2AEtXiWFCLn943vTxK5eeig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJi0iwM61anziC-cHXp0PL2AEtXiWFCLn943vTxK5eeig@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

On Thu, May 09, 2019 at 11:45:26AM -0500, Rob Herring wrote:
> > +dependencies:
> > +  cd-inverted: [ cd-gpios ]
>
> The note (which you dropped) says 'cd-inverted' applies for built-in CD too.
>
> At least that is what I take "Polarity of dedicated pins can be
> specified, using *-inverted properties." to mean.

Indeed, my bad. i guess we should probably keep that note. How are we
supposed to keep a note that would apply to multiple properties? In
the global description?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
