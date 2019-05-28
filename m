Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8312CF88
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1TdJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 15:33:09 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38503 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfE1TdJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 15:33:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id b10so27437vsp.5
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/4WAdDHD7o2J6jLaTa03Ods2jMwUYJoiUyhNBxjWQI=;
        b=dMMWYbArcJceM9L9LmUxOvLkkrX2JOFBhsd3cXHlbV62EkEx3ql6/xwnm6N5ua68wq
         lfkom4j6oFv/YNmvQUm8B1OQGZ2zulvaZOZ4Vb/2f9dLCgPmMB9Ugey3bU87fOc/WHEw
         p7Sw2zAKvnev37PmWp+aAzuUJUkQppWVldppFq2B2zoUI2yWw6WtGdGKVjULC+Dn/H6e
         d3sLokS7BkvYEDy3Hes7bzROVLsETM8bkQAKS2rty6owPH9VPSYb57J7qWuBL1cc+AVg
         V9jyGJ9CiMd+OVDQN8n0mjfPQP1ssYNAAjmKXpcP/+z1XJBMKFdd+vvMGuzqNeTQcjMe
         XoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/4WAdDHD7o2J6jLaTa03Ods2jMwUYJoiUyhNBxjWQI=;
        b=CRTl/zKvzrNbHWw78ouL4HUe2lWJxHLrKdYV8UC5TNuem7JpZSmXDED2l7yFu5ty+0
         PnXRAI/Xkz6px595NRc+Yl2ZsmfzIuvAoFmeKVzPrd4bANyArq4YUC0ZEHA8r7T0uX81
         jYpXdbRyZhxuulbhBXeYEg5klqEKBoCO1OEkCmb4tiOASliRy+vU8ynvoW729dcJs0Gz
         Do6Z8Af60cQCRyQHum78EGl+XMNuwRRTUUdaXx+8qwM/6kBbxIUX23BuLUaFzqIHNXmh
         SHA8boyP0eXlNGunYzbcjKp/cuhPxd5wBNj/BipgB/iuQsgspzHqb+S+s6XEj6jlU+xr
         wFGA==
X-Gm-Message-State: APjAAAVN6gkrOSNkRj9eq7nB8bV3AtW2uR3ThBOLQC4fYBPHuq+eo6nA
        mT5A4akOeiVGcBoDvkAqNmgqdV5lDZqP5a/ors7VPA==
X-Google-Smtp-Source: APXvYqwd813q3SqUy11sYCOolIowQZSdilqwamuHYez09q5jBp5bAunxVlKM4u8MuI3TDxKOUo/xgfSsPHni9ARExfo=
X-Received: by 2002:a67:f485:: with SMTP id o5mr2970694vsn.165.1559071987467;
 Tue, 28 May 2019 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <c6b8789d71ce1970be77387c066a262dca0a0dec.1558340089.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFrs6f4_Xr=ATay_wDYNPa+-jdZvP4XSB55B-EFMAETN1Q@mail.gmail.com> <20190528172649.6mkdkscnu5d2rybi@flea>
In-Reply-To: <20190528172649.6mkdkscnu5d2rybi@flea>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 21:32:31 +0200
Message-ID: <CAPDyKFrTroAOjEyT9GxQALC4UsiDg8739F9Qc216bDC=wgk2mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 May 2019 at 19:26, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Ulf,
>
> On Tue, May 28, 2019 at 10:40:16AM +0200, Ulf Hansson wrote:
> > > +patternProperties:
> > > +  "^.*@[0-9]+$":
> > > +    properties:
> > > +      reg:
> > > +        items:
> > > +          - minimum: 0
> > > +            maximum: 7
> > > +            description:
> > > +              Must contain the SDIO function number of the function this
> > > +              subnode describes. A value of 0 denotes the memory SD
> > > +              function, values from 1 to 7 denote the SDIO functions.
> > > +
> > > +      broken-hpi:
> > > +        $ref: /schemas/types.yaml#/definitions/flag
> > > +        description:
> > > +          Use this to indicate that the mmc-card has a broken hpi
> > > +          implementation, and that hpi should not be used.
> > > +
> > > +    required:
> > > +      - reg
> > > +
> >
> > [...]
> >
> > > -Use of Function subnodes
> > > -------------------------
> > > -
> > > -On embedded systems the cards connected to a host may need additional
> > > -properties. These can be specified in subnodes to the host controller node.
> > > -The subnodes are identified by the standard 'reg' property.
> > > -Which information exactly can be specified depends on the bindings for the
> > > -SDIO function driver for the subnode, as specified by the compatible string.
> > > -
> > > -Required host node properties when using function subnodes:
> > > -- #address-cells: should be one. The cell is the slot id.
> > > -- #size-cells: should be zero.
> > > -
> > > -Required function subnode properties:
> > > -- reg: Must contain the SDIO function number of the function this subnode
> > > -       describes. A value of 0 denotes the memory SD function, values from
> > > -       1 to 7 denote the SDIO functions.
> > > -
> > > -Optional function subnode properties:
> > > -- compatible: name of SDIO function following generic names recommended practice
> > > -
> >
> > I think most of the information of how we use sub(child) nodes
> > disappeared in this conversion - or at least gets harder to
> > understand. Could we perhaps keep some of this?
>
> Sure, what would you like to keep in particular?

Most of it, so we can understand what can be described in sub-nodes.

Additionally, we should also include what is stated in
Documentation/devicetree/bindings/mmc/mmc-card.txt, as that also
refers to how subnodes should be used, when it has the "mmc-card"
compatible.

Or maybe we should simply move all things related to subnodes into a
separate .yaml?

Kind regards
Uffe
