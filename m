Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59233F3B
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFDGxf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 02:53:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39389 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfFDGxf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 02:53:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id w44so7406319uad.6
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaDWiHPR9JRMc5dM2JBiUlOrVRUD/jYSdR+XH2uU4Co=;
        b=vJV/Z6ZXeWZX0q82NAqhljJbpDA+WvULjbfDIx58hTaojW2K0l7Kk0sm9KjHyb17DT
         kuQoWD7xepb9d29mYUK6sx3XuMTFm1+GXWLg6nVQ2oWiCNk/5C3QPsfK04iXuJez/HU8
         Lg6ijXWEgAa/nOQk5u/YKkwG31S3B1VcGxD1vkh2lRVwcpjKlOUoDc/bfI4xvVQfpk88
         4Wzhi5FxG5ihgAv3geCktS3P8DUmC3G3OeXsYVY+VtRDR9zodAhlb51H8IDnvZhbbfPf
         bnroEVDnDKPMsceW+ac5lih3IBV7ksqtWW7kaDIFQurKU1ZVgIB7Hip3Rq+CaoUpErFh
         nMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaDWiHPR9JRMc5dM2JBiUlOrVRUD/jYSdR+XH2uU4Co=;
        b=tOizAvpxxeR+1PfL+6LOl4h8yQWECYHJ5jt0SnxNQyKuKSIwsR/QpImr0Z1ADmzi4S
         0Kj6Gq7Lz9QH0Tng4hfX8+DapWRBYMAijwJ/PFbGjt+gn7Q5BYwIT6Bk+EZmuXGsvBYv
         p8t82ndNM/+AoYuqhDzuwQTJ8kEW+SRpXKiakTOF6NK1Rb2I2wdoqxOx/NvFt8Z5TQ0c
         /opGB7aQmeJjRRqjPhuinblj27XF2ncUhSrzDHMq1y8kfPngOm129vBp0vquVC/mR4PL
         KXWnE8eCvm3rWsgJ898n31OuICFdp29KZHMEqI3qZ0TVTYHkXpEWHoYo5U98i5FfLaOh
         MRAg==
X-Gm-Message-State: APjAAAWrtueQLE10VCHH2xece16Q6Sdfbu0NcShpTZXODjtwW/d/Dx7Z
        95Ds1hxrQ0A1j0eSjc76uPsW2Jrx6ORii8fOBJ//SA==
X-Google-Smtp-Source: APXvYqwOrrnYuan4kp6oT+cECdrmvG/OzTSJGNeXrjAnq+W5vLQh750wxVsaDLCIudNnKnWn328F87yP/49E98Xs9EA=
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr871475uae.19.1559631214438;
 Mon, 03 Jun 2019 23:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
 <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com> <CAMz4kuK+yX=V2zp-C4Xb-6ZjgLOY+ON2iHZU=HwONeXcJCkk4w@mail.gmail.com>
In-Reply-To: <CAMz4kuK+yX=V2zp-C4Xb-6ZjgLOY+ON2iHZU=HwONeXcJCkk4w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jun 2019 08:52:57 +0200
Message-ID: <CAPDyKFrfMWomOe1QgizbfG+4=vHOix8UH3+MbZicMKWusE8Tsw@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 04:33, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Ulf,
>
> On Mon, 3 Jun 2019 at 21:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 20 May 2019 at 12:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > For some Spreadtrum platforms like SC9860 platform, we should enable another
> > > gate clock '2x_enable' to make the SD host controller work well. Thus add
> > > documentation for this optional clock.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > > index 45c9978..a285c77 100644
> > > --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > > @@ -14,6 +14,7 @@ Required properties:
> > >  - clock-names: Should contain the following:
> > >         "sdio" - SDIO source clock (required)
> > >         "enable" - gate clock which used for enabling/disabling the device (required)
> > > +       "2x_enable" - gate clock controlling the device for some special platforms (optional)
> >
> > This is a bit vague, could you please elaborate (and fold in that
> > information to the doc) on what kind of clock this is?
>
> Sorry for confusing. For some Spreadtrum platfroms like SC9860
> platform, we should enable 2 gate clocks to enable SD host controller,
> that means we have 2 serialized clock gates. I know that's a little
> weird, but that's our clock's design.

Okay, just wanted to make sure this new clock isn't something that
should be modeled through the clock tree.

Thanks for explaining, then I am happy with the patch as is.

Kind regards
Uffe
