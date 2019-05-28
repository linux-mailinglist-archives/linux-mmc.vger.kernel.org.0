Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88CC2CD97
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfE1R0z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 13:26:55 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43185 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1R0z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 13:26:55 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CAF27200009;
        Tue, 28 May 2019 17:26:49 +0000 (UTC)
Date:   Tue, 28 May 2019 19:26:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Add YAML schemas for the
 generic MMC options
Message-ID: <20190528172649.6mkdkscnu5d2rybi@flea>
References: <c6b8789d71ce1970be77387c066a262dca0a0dec.1558340089.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFrs6f4_Xr=ATay_wDYNPa+-jdZvP4XSB55B-EFMAETN1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrs6f4_Xr=ATay_wDYNPa+-jdZvP4XSB55B-EFMAETN1Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, May 28, 2019 at 10:40:16AM +0200, Ulf Hansson wrote:
> > +patternProperties:
> > +  "^.*@[0-9]+$":
> > +    properties:
> > +      reg:
> > +        items:
> > +          - minimum: 0
> > +            maximum: 7
> > +            description:
> > +              Must contain the SDIO function number of the function this
> > +              subnode describes. A value of 0 denotes the memory SD
> > +              function, values from 1 to 7 denote the SDIO functions.
> > +
> > +      broken-hpi:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Use this to indicate that the mmc-card has a broken hpi
> > +          implementation, and that hpi should not be used.
> > +
> > +    required:
> > +      - reg
> > +
>
> [...]
>
> > -Use of Function subnodes
> > -------------------------
> > -
> > -On embedded systems the cards connected to a host may need additional
> > -properties. These can be specified in subnodes to the host controller node.
> > -The subnodes are identified by the standard 'reg' property.
> > -Which information exactly can be specified depends on the bindings for the
> > -SDIO function driver for the subnode, as specified by the compatible string.
> > -
> > -Required host node properties when using function subnodes:
> > -- #address-cells: should be one. The cell is the slot id.
> > -- #size-cells: should be zero.
> > -
> > -Required function subnode properties:
> > -- reg: Must contain the SDIO function number of the function this subnode
> > -       describes. A value of 0 denotes the memory SD function, values from
> > -       1 to 7 denote the SDIO functions.
> > -
> > -Optional function subnode properties:
> > -- compatible: name of SDIO function following generic names recommended practice
> > -
>
> I think most of the information of how we use sub(child) nodes
> disappeared in this conversion - or at least gets harder to
> understand. Could we perhaps keep some of this?

Sure, what would you like to keep in particular?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
