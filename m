Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B313251
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfECQhA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 12:37:00 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41963 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfECQg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 12:36:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id s30so2222582uas.8
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOhXxqwrhrqi22CbeLJVIpblT7qOBEHSnL9239pOuZY=;
        b=hOY8pzUaHTFuXrA+1GcYiD2vIu/TX9Uyerw59T3XF2I09wNu5QJfIvNktWMCZiqkP9
         eAuOJfcWhkz2MqPKHMkTvbGNTyknpN03CvNwJzFt8HlFn1BDeznvyCUz1vqNjkU6KQUI
         7szujSOmYYBp7g6jss/M8tE4YH/Z0/ysTfU0VmC9Au/JSYrf4n4NguzvZN7KSxSFi6fb
         6JENSoDdorpK7uvuGuhXQn00TwlJWx5nvx4uKpmTlm62aZyZDJM3PZJTIb47/i0kdH1r
         VO+BFTBF4EtL1U5M0ffixvcuwpjXgBXDCBPJs6XHDD+ZxV61JE/jf33kk3rYTbdBVAYS
         rA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOhXxqwrhrqi22CbeLJVIpblT7qOBEHSnL9239pOuZY=;
        b=aAwFKpPIhvuTScAyQ33pbsZd80OMklrkc0Tj5rQGP9sHI+TKk4f9W0k8OkHIT40C3n
         wGSvz3II7qHys283sGMhgJcUQ6r4ConsVvV854igDBRvXtgDD267Z36y+GFSLyVvv0vu
         cjzKYs5tvhbBnO/8r+lDwqW22AT7C80nQcH1aQJzvHFHvh3+AZC244+S+LNV8eYS//mN
         IB4hBwBRhyuabaZ+g3mezq2Aey/uDxFbW8dlWXXXBkKrNbFnou0JtShMT/4cAlPGKIt8
         lUKmK82PHRq0Quyle/8nQLbXa2saZmXiZ3OEdQVB0vB9i2hce3ZcuSkwXJmrKxq6DL2U
         bfxA==
X-Gm-Message-State: APjAAAUPAg79Q8BvZloCk3GgTBokQPtxXnWvxYZJRPwoqfrbVFb5FCTQ
        67H16GdWPUEZYvA/jNqdaPBtXcCJQGUE2/8a2MOJtA==
X-Google-Smtp-Source: APXvYqydNZ2JP4JT7mM9TAHxudYFShSRlDbh3hZ/Q8pAlpJwTXTuZ7DQou+9NHKF/WYJcr9VzSF6aFEylNuHOXZs8rQ=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr2711177uan.129.1556901418729;
 Fri, 03 May 2019 09:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-9-fparent@baylibre.com>
 <CAPDyKFrAxmBv+1i3qJpD=M1Wq33U2PMfQv_99xDm9MLhLxSWYg@mail.gmail.com> <CAOwMV_z8RrmoK+bfEqgwOv97uJarnuTCUo7aczZz=gyvg8CDzQ@mail.gmail.com>
In-Reply-To: <CAOwMV_z8RrmoK+bfEqgwOv97uJarnuTCUo7aczZz=gyvg8CDzQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 18:36:22 +0200
Message-ID: <CAPDyKFocSqRLC7eGVBY7J-WkBy0i9fxX5GNivMNQEfgqhcrb9w@mail.gmail.com>
Subject: Re: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
To:     Fabien Parent <fparent@baylibre.com>
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

On Fri, 3 May 2019 at 17:12, Fabien Parent <fparent@baylibre.com> wrote:
>
> Hi Ulf,
>
> On Mon, Mar 25, 2019 at 2:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > - trimmed cc list
> >
> > On Sat, 23 Mar 2019 at 22:17, Fabien Parent <fparent@baylibre.com> wrote:
> > >
> > > Add binding documentation of mtk-sd for MT8516 SoCs.
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >
> > Applied for next, thanks!
>
> I think this patch got lost since I cannot see it in your tree.

Thanks for telling me. I have picked it up (again?) and applied it for next.

[...]

Kind regards
Uffe
