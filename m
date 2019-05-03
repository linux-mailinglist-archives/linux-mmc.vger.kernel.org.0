Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3B130F9
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfECPNB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 11:13:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54181 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfECPNB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 11:13:01 -0400
Received: by mail-it1-f193.google.com with SMTP id l10so9638482iti.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0gqP9UfAhrcVQ0B7jx45OW9tzcGMjRGZERkH/amQd8=;
        b=fc39lvNrtLQ+PPYtosoIsxvEQNSCEyLIoC+tTlsPyHSyB86C/K2Ksa2rV2eZSMGM6e
         8kWCQ8JFZdBwoDoLSdnbcM7+rOSwHi+7dCOOWVM01wEl2NceqOGu3KrH1YoREi7GDUl2
         Hs6YesgZxH8N1Qx3JSRTYZrdwVBWxYTOIE08vZAZ0oSQnxRTTAhbZjIwk7xkxMXTKK/N
         /l1nnVGX7L0dWh2Sq29F2WDwdvQWJId7/BMmu69ruuNp9wRHrIP523awi2Ppcz9k4WIU
         Az6uS9ExDKAlCoJ4pM0oPjzBJ4w5KN97FZyN2GUl1ykw+DPgsJJayFbSqWSqizMpmfmt
         K3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0gqP9UfAhrcVQ0B7jx45OW9tzcGMjRGZERkH/amQd8=;
        b=UC44JkEyRzAklhWvB9bTNgaH6OFzsh/S6L556/Bqmr6jy0yz9AsPHrrtkCZuOBLt6L
         +6f0m5c4l8XTJi820TdSLwWmqWxp/twOxuWW5yRGgJu+dCBqI5cxw+cw5+5YKogFohTQ
         kve0+dNY8bvaSwCjHPDCiLkUtTZaYDxnM38JehdeYwMF7BdK6JwWIW9QThHPlwYBzRtA
         5zC4E3JlQyAW5vskLiXEub2ZII1dafpYNYNPaYL9aP4TfY2luYtnqQCZVoxcPdF4Cq6w
         njb+LVrDqXPfEjJyzZ0L8khcWV2nyrsrsqa5a3rVcPVV4LK6V64LSgonNoppcpBi9YmE
         IteA==
X-Gm-Message-State: APjAAAXYLAD8g75boaIeostY8foTDQ7qEikMz2dyhR0IH4heKcAlfzG1
        h+Gk9yrDPCLpsdM0F+zqLzcny0VBUvCD0TRYGW403so7
X-Google-Smtp-Source: APXvYqylRqk8vy/C0ENyupfDoZQ0z4e1EDdlHqQ1vxzioimJlizkmjvHen1pYQGiwpvSjAY735JShzGgeVvSLnohe6E=
X-Received: by 2002:a02:4482:: with SMTP id o124mr7550142jaa.121.1556896365345;
 Fri, 03 May 2019 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-9-fparent@baylibre.com>
 <CAPDyKFrAxmBv+1i3qJpD=M1Wq33U2PMfQv_99xDm9MLhLxSWYg@mail.gmail.com>
In-Reply-To: <CAPDyKFrAxmBv+1i3qJpD=M1Wq33U2PMfQv_99xDm9MLhLxSWYg@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Fri, 3 May 2019 17:12:34 +0200
Message-ID: <CAOwMV_z8RrmoK+bfEqgwOv97uJarnuTCUo7aczZz=gyvg8CDzQ@mail.gmail.com>
Subject: Re: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, Mar 25, 2019 at 2:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> - trimmed cc list
>
> On Sat, 23 Mar 2019 at 22:17, Fabien Parent <fparent@baylibre.com> wrote:
> >
> > Add binding documentation of mtk-sd for MT8516 SoCs.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Applied for next, thanks!

I think this patch got lost since I cannot see it in your tree.

Thanks,
Fabien

>
> Kind regards
> Uffe
>
>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index f5bcda3980cc..91a2ec59e497 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -11,6 +11,7 @@ Required properties:
> >         "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> >         "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >         "mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> > +       "mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
> >         "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >         "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >         "mediatek,mt7622-mmc": for MT7622 SoC
> > --
> > 2.20.1
> >
