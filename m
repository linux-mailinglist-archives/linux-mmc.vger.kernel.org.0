Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1CFC498
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 11:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNKrD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 05:47:03 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37778 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfKNKrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 05:47:03 -0500
Received: by mail-ua1-f65.google.com with SMTP id l38so1717643uad.4
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 02:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Z7zzjF1yR5HW1GmAitGOf39HmOM3mJTrajNy5woG3s=;
        b=QmKQUDdoeOMyx6GoduNvAB+A6ByZBHDCd+m44cbjKkLycBOCHODSVbwGUtmtZnFncI
         jBSatmf+RWZClV7+/BbAdYlKRMyyAijZM/mTIM/4AIh3nL2mbNlizGws7XFqqjSyznmX
         Dn0gEK8v15SByp0mIgAuXm4ACcaG+8wlLEZZIjr9uDr4PeVGEzM043Uj4wVOg+qktF6d
         PE94zBhSofxflwJqnIoljIpQNv0gzelfMX/0QBMZNpLbhBsuR9WUPo8TdZDTUPrI9b4H
         HFDaB0Obzgblcc6SmVLw2/kbduFDbXerQRneC2C3GZMrJz5OvaV7L/qCpremwSvgrsIl
         +o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Z7zzjF1yR5HW1GmAitGOf39HmOM3mJTrajNy5woG3s=;
        b=shBiDy2husekRA7300H00NEXy3pMn3nZDqiw2WgobyIx0kwvJFGi6j6V34pRXUOc6D
         CJQmeAD5lvcsnM8bHnj7zaWjZZ8825PKKNm8uolx934w19dZieN/0ap/tJKcp+n1rhZf
         gWt1q5/T8HcYRNTCCxveFU3BhkHh9pKq/K13u8/ht1y8CXEyDRDpxl5krzDIKaWyDhRF
         6W4w6AcZDFW1iLGPEcvtKZstu1vgo6iArxTIhk+xo90Ff+DTzNf77t/jSVQzLYAFafzT
         iX9YV7exOMm2Efptj2Zj4lapTQvUwZQeQg1nnVpQyzZmz4yCnm6DqVgCXyfGG3vcs6iU
         i9VA==
X-Gm-Message-State: APjAAAVNjwxNScjf/cLf2pqqytk4PEKJ4jPJ6gtKiKeUZmzFek7RKjPU
        vwcngBVh6PVx0g2tfg0UWNYAsx2NA0nUJNlv8+yz9g==
X-Google-Smtp-Source: APXvYqzs2hzCHGhzo4MLkvjZ4GdlPj6hUM6/5I/OJ+TEn23Lr7XxbNQB98pkh3DLyHV1zrutRRH8jaIY8J3D/SKfoY0=
X-Received: by 2002:ab0:2042:: with SMTP id g2mr4940760ual.19.1573728422241;
 Thu, 14 Nov 2019 02:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com> <20191107003907.GA22634@bogus>
 <20191112211950.GB3402@kunai>
In-Reply-To: <20191112211950.GB3402@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 11:46:26 +0100
Message-ID: <CAPDyKFoXT-UtO05xbHRVJTJAg+yYJK9AM7KjK18QcaGM0Bqn9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> > >
> > > One option to achieve a similar degree of flexibility by using an array
> > > OF property (instead of several u32 properties) would be to agree on a
> > > convention based on magic values, i.e. below DT one-liner could be an
> > > example of providing solely the "fixed-emmc-driver-type-hs200" value
> > > (based on the agreement that 0xFF values are discarded by the driver):
> > >
> > >     fixed-emmc-driver-type = <0xFF 0x1 0xFF>;
> >
> > I don't understand why you have 3 values instead of 2.
>
> Because he sketches maximum flexibility here. Have a non-HS (default)
> value, one for HS200, and one for HS400:
>
>         fixed-emmc-driver-type = <[default] [HS200] [HS400]>;
>
> > I would just use -1 if you want to ignore an entry. If that's the common
>
> '-1' sounds good to me, too.
>
> > case, then I'd stick with what you originally proposed. If rare, then I
> > think an array is the better route.
>
> What I have seen so far: setting drive strength alone is more on the
> rare side. Setting specific values for default and HS200/400 seems even
> more rare to me. With this patchset, it is the first time I hear about
> it.
>
> Yet, my experience might be a bit limited, maybe others (Hi Ulf! ;)) can add
> their views, too?

My experience in this field is quite limited. No input from me, sorry.

Kind regards
Uffe
