Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB299274
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfHVLp5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 07:45:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38380 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732864AbfHVLp5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 07:45:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id 62so3613782vsl.5
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ias0hnNTQ1W0WLMJ9Tw+pF62AvhAzndWUOgIreZptR4=;
        b=rDszp6GWldYKXV1jR5X0tVPwOQUmi6CxIEOrbjVQUz3WhkU6oYTxYzX8HxeY8leOeh
         zvTSuAERxKEcn8Yv9UsDjeKMrhx6DkoMarSTEZkDd68+2mj+BgZXGGtNWJI9+EFQuVQ+
         CyB4j3oAVf1Sm05kBVhXT8wjbkRr6SC4LyvEcPVuhYxovbmtuhHVcIXOTHLmpwk200KN
         3vWaa4ABGDhxySRoMd9bnoJjE/MwJ0QN6JNQuGkCtgyDw1T5WZeR3j0ywN5yzX6IjAZ4
         bp1uABpaYaWvwa4Z1bgZ93PENPx4XxOkKWdZY7cjBXyOAlrgPcwG5by4QPTERiNSTm/f
         90+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ias0hnNTQ1W0WLMJ9Tw+pF62AvhAzndWUOgIreZptR4=;
        b=gOtSVnzqPcr8IZvf7Nkgy/KeqcPDC8vXXCnEbiwkiR61P964Mv+OXMkDLKp5834Fs4
         Z7Go2T+MCAwB0O1b82U8WDjPmkhq8sLJBJMdvgWhBBc2wKr4CoiOq9WqR/myKYOeq0Gt
         ahhL6zw4ohqEB1W+5pwvS1Wgigertce+dcfNeiQwrYylPEB8i8NL1VP49khWgNwqJwo5
         NzGYj9qLHLn0bJkPGu8eoqlT7Mc0LiY7pZTFgpkfuNZrgtulQzdn+0aXspX83EjfxNhF
         fiGiW8Ud7UuSNDgsMmsukmNxLztaQUZWISE0WDGcmBCG6wYz/lBUukJOJmD3nj4SqCen
         +TQg==
X-Gm-Message-State: APjAAAVg5ha9zYWNeGUMbMn9cjoJqfwL565RnfX6vVMc+2/ffi+Gb/Gm
        uNo0lg431c6TdFVIuxtPTDXEQz7hlyBQrwjXedrRRA==
X-Google-Smtp-Source: APXvYqwpurVmREw1NCNrWD/HWUqNVjMRJbQbiiRPPhDel5CxOBrosK7SYbiXJVV66QIkSwppRQHrHqUJ1UD4Wg1NEeE=
X-Received: by 2002:a67:e287:: with SMTP id g7mr23784378vsf.200.1566474355983;
 Thu, 22 Aug 2019 04:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190807003629.2974-1-andrew@aj.id.au> <20190807003629.2974-2-andrew@aj.id.au>
 <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com> <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com>
In-Reply-To: <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 13:45:19 +0200
Message-ID: <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Aug 2019 at 07:37, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 15 Aug 2019, at 15:06, Joel Stanley wrote:
> > On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > data bus if only a single slot is enabled.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Two minor comments below.
> >
> > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > @@ -0,0 +1,105 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> >
> > No "Copyright IBM" ?
>
> I'm going rogue.
>
> That reminds me I should chase up where we got to with the binding
> licensing.
>
> >
> > > +%YAML 1.2
> > > +---
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    sdc@1e740000 {
> > > +            compatible = "aspeed,ast2500-sd-controller";
> > > +            reg = <0x1e740000 0x100>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <1>;
> > > +            ranges = <0 0x1e740000 0x10000>;
> >
> > According to the datasheet this could be 0x20000. It does not matter
> > though, as there's nothing in it past 0x300.
>
> Good catch.
>

Are you planning on sending a v6 or you want me to apply this and you
can post a patch on top?

Kind regards
Uffe
