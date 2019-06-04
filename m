Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6C33D30
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 04:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFDCdV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 22:33:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43527 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfFDCdU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 22:33:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so5358513oif.10
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 19:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/efz5fBqwkKql5eaLioEbxPG0lpeX3IuNQzBKE0KZPY=;
        b=t0Tg5fNTxniTRmz/iZalyXNNLBLd+1rhT2xgBa8LZbek9rqjAlwbOGh00WHUB1ncrx
         Yo/H4u0aKaaEw1LY3oxY/qG/vRwpEj/gpqna5xGRMKtyhf3tetBrPBVEq5/wW5OunbmT
         6P+dBmhIXg4OTMvR81tWx1OWHYVdqp3+mTeW/erFR9g1OpVb3yvcUQDsNFS7/xBbe2Ix
         099d7LnpWWUcDprl9p4V7TN5UkrBzPDwAaJK9fx2m9ZdntdbcTThl4RrqZGvB8aLAESR
         7H5CqQB/OZL7Y8tzXpk5gqxdRBj4CkDWX7h78XUi9vUABQ5ElROPygSMfDoZJKEFAcyt
         5New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/efz5fBqwkKql5eaLioEbxPG0lpeX3IuNQzBKE0KZPY=;
        b=p22dlt58K5m68cEl7INQB5ulw56NmCiZ12CtkUquoSNiywGZHv20MzNiM151zQKsWX
         GQIGBO82GRJHsXoFLC9mav9w1ypDv86Eglhq/S6ahpF+GEgNxbVCjp6tZOkOMOMt42A3
         vk3M8wxPJmLdBGGwuRS2re83k3mSiUHjPsL87KZtCrU+1vif8Fc+ccBm0DtycybJ0a9W
         0Hsk5PoNbxQKUDO22LAF8WH1yQDLa9tviuWyEbuAa2qkVz8L1y7z2p9WwJ1cY9Jsj98S
         ds7/E3l/iwKgwlRXpg8GluW8PoToAmX79YFl+Csy2sCJfKvSpKX5MLRdAqiGpUYhrDyl
         JN7w==
X-Gm-Message-State: APjAAAVvzAC2oOUcRavQwQrawRkrCdeCY6odp0oZFO9Nv+eoIdFqELGZ
        Ui8PiaXnca5zyJCnrxi7ZhtqMP+DArkOI2zEl46jFw==
X-Google-Smtp-Source: APXvYqxb/i7+n5YIjVsNZWPZfvdm7xM+4h6bvKEOeA1ig/CQVGfW4rtKxXeB0d4+sPhSP0CMWDZvMBprzf2J8CSGkSs=
X-Received: by 2002:aca:dd08:: with SMTP id u8mr74850oig.27.1559615599920;
 Mon, 03 Jun 2019 19:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
 <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
In-Reply-To: <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 10:33:08 +0800
Message-ID: <CAMz4kuK+yX=V2zp-C4Xb-6ZjgLOY+ON2iHZU=HwONeXcJCkk4w@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Ulf,

On Mon, 3 Jun 2019 at 21:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 20 May 2019 at 12:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > For some Spreadtrum platforms like SC9860 platform, we should enable another
> > gate clock '2x_enable' to make the SD host controller work well. Thus add
> > documentation for this optional clock.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > index 45c9978..a285c77 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >  - clock-names: Should contain the following:
> >         "sdio" - SDIO source clock (required)
> >         "enable" - gate clock which used for enabling/disabling the device (required)
> > +       "2x_enable" - gate clock controlling the device for some special platforms (optional)
>
> This is a bit vague, could you please elaborate (and fold in that
> information to the doc) on what kind of clock this is?

Sorry for confusing. For some Spreadtrum platfroms like SC9860
platform, we should enable 2 gate clocks to enable SD host controller,
that means we have 2 serialized clock gates. I know that's a little
weird, but that's our clock's design.

-- 
Baolin Wang
Best Regards
