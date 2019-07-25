Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79574F76
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jul 2019 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfGYN3n (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 09:29:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32917 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbfGYN3m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 09:29:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so37684153oiv.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1z3qSqeis7KRp59LvW3GrIz3rWu/CFv+sXSsB3MIv0=;
        b=S7zg9NIJWKApcIDLjPg7XBK9rjPeDYoBWNVm005ZjT5gIbIyVfUK1xk1sLRQw2MM6x
         0Mdkbzf6ixFn9ev3RGLQI0Euk3fBpj38V9Um9YNXmB8Nig9Gqm7yu3MXe9SGvtsSF/wm
         cBMTtWscvwBj58mpSYQZHP82mWWmXezEv903XajiM4H7GkdESKIQ2TWthd1ygp1tVdlf
         auy3V0rc8NfdYnkaaXDknQrzs7TI038ABRxdFGjrDH+niO5voLKTNLeZJ3SjiHVtixc8
         lxDg71dtEjf+ShJe5QILrIeZjUXh+f9GR/ZH/Tfe/MfFQcGDLs78lnMBTM2MtL7glJNB
         5yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1z3qSqeis7KRp59LvW3GrIz3rWu/CFv+sXSsB3MIv0=;
        b=DZeZNn35oSOu5jHQFDWZ5kdR5fWqkEsIQiWdhHLYoQb6+BllXGNF2Akj2VwTzSY3YT
         Hj73f5IGEhd7aKV5hy5pjlKyEBWDt4LBDDCb2V/NO58j/RNq1gXb/kSggOum1zwJ0ki0
         jTBdF4VdN90c2wlcUIXVhcsGjP4SryA5PCodTaSkJIo2TOb/Rn6Pyz1n9A34wu/UWR/+
         dXFzTUD/f3RU1wVRV2g9sXejXnbj8/2GwodNgGa8RY7epHqH4dw4l4uRjs8MCsWwpoqo
         4ANApT46T1OSvcJIRFIZK+5n9eyvRMJuLp2SY44nwSoXfFGMZEAU1esNhMY6w1nZyCL5
         U8tw==
X-Gm-Message-State: APjAAAWwimNxiDmO7eq9cKOXe9VocKnZgcQfBMwcDCbO7pnGKJfcC/cb
        yUFN8ERNAIQq4jZWBXCKtCGwQ6HZIi0mxsV0c1rQuV7v9DI=
X-Google-Smtp-Source: APXvYqzWSaFSn1p/xkKu/nTk8JDTShS1XkRJNDVHcXJf+E/HgRUTiWRJNBpO14sGxRyKRreBRD1/QWYHKp73a7558FA=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr34325145vkh.4.1564059690186;
 Thu, 25 Jul 2019 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus> <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:00:53 +0200
Message-ID: <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 10:23, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks a lot for the review!
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, July 23, 2019 3:24 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; heiko@sntech.de; Michal
> > Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> > christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> > systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> > ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com; Rajan Vaja
> > <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> > <navam@xilinx.com>; mdf@kernel.org; olof@lixom.net; linux-
> > mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org
> > Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update
> > documentation for SD Card Clock
> >
> > On Mon, Jul 01, 2019 at 10:59:41AM +0530, Manish Narani wrote:
> > > The clock handling is to be updated in the Arasan SDHCI. As the
> > > 'devm_clk_register' is deprecated in the clock framework, this needs to
> > > specify one more clock named 'clk_sdcard' to get the clock in the driver
> > > via 'devm_clk_get()'. This clock represents the clock from controller to
> > > the card.
> >
> > Please explain why in terms of the binding, not some driver calls.
> Okay.
>
> >
> >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-
> > ----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > index 1edbb04..15c6397 100644
> > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > @@ -23,6 +23,10 @@ Required Properties:
> > >    - reg: From mmc bindings: Register location and length.
> > >    - clocks: From clock bindings: Handles to clock inputs.
> > >    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> > > +            Apart from these two there is one more optional clock which
> > > +            is "clk_sdcard". This clock represents output clock from
> > > +            controller and card. This must be specified when #clock-cells
> > > +            is specified.
> > >    - interrupts: Interrupt specifier
> > >
> > >  Required Properties for "arasan,sdhci-5.1":
> > > @@ -36,9 +40,10 @@ Optional Properties:
> > >    - clock-output-names: If specified, this will be the name of the card clock
> > >      which will be exposed by this device.  Required if #clock-cells is
> > >      specified.
> > > -  - #clock-cells: If specified this should be the value <0>.  With this property
> > > -    in place we will export a clock representing the Card Clock.  This clock
> > > -    is expected to be consumed by our PHY.  You must also specify
> > > +  - #clock-cells: If specified this should be the value <0>. With this
> > > +    property in place we will export one clock representing the Card
> > > +    Clock. This clock is expected to be consumed by our PHY. You must also
> > > +    specify
> >
> > specify what?
> I think this line was already there, I missed to correct it, Will update in v3.
>
> >
> > The 3rd clock input I assume? This statement means any existing users
> > with 2 clock inputs and #clock-cells are in error now. Is that correct?
> Yes, this is correct. So far there was only one vendor using '#clock-cells'  which is Rockchip. I have sent DT patch (02/11) for that also.
> Here this is needed as earlier implementation isn't correct as suggested by Uffe. (https://lkml.org/lkml/2019/6/20/486) .

I am not sure how big of a problem the backwards compatible thingy
with DT is, in general we must not break it. What do you say Manish?

As a workaround, would it be possible to use
of_clk_get_from_provider() somehow to address the compatibility issue?
Or maybe there is another clock API that can help.

Kind regards
Uffe
