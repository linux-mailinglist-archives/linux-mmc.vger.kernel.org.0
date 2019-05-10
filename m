Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A419DA7
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEJNAM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 09:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfEJNAL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 May 2019 09:00:11 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63AFB217F9;
        Fri, 10 May 2019 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557493210;
        bh=LsB4wRG7wXandWAwzv751zSzegIOxKf8DCwVeYS+wZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o9UoB1IQfAzm/77bKAUyUve7ebdMFEiCfoaRDB5FHwVX7SeHyD7LSFzlA2KwZPWN8
         iQFgN9YsNWzEFcPkXXzZbK2oJpreht+OsFKhsMvDW7DVQPHSBQQ/v6OQh2pEX0OCRU
         2HvTRdsJGJhBBncqT4FYXfSlYOHki8wNlUSfmJJA=
Received: by mail-qk1-f172.google.com with SMTP id c1so2247002qkk.4;
        Fri, 10 May 2019 06:00:10 -0700 (PDT)
X-Gm-Message-State: APjAAAVaRZuUK0Bc2HPLPrZZ14wYgQlFRpQeK4cQQFET1kAl4VpEHrFE
        dg7fObbLVna7ZZ5O2V7rRsR0CrxHth19TRi4Aw==
X-Google-Smtp-Source: APXvYqyJFUpcXFgSc64L63+Yfqmy5T2ssN8dGlZHA7sVG67a1VSyOBVNxl+4OXjQWFgv+hoyeCHBDol+AkCsOX/sC/w=
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr1133260qkk.184.1557493209611;
 Fri, 10 May 2019 06:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <68d3fb999d16e49696e832e1d1a6bcd7b76a6e8d.1557389988.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqJi0iwM61anziC-cHXp0PL2AEtXiWFCLn943vTxK5eeig@mail.gmail.com> <20190510105759.z2ob5tl4ovn2ctdo@flea>
In-Reply-To: <20190510105759.z2ob5tl4ovn2ctdo@flea>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 May 2019 07:59:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+R3nWZi8u7_QRuGj=k7M2qB+NkM982OZfw0=n3+uLWA@mail.gmail.com>
Message-ID: <CAL_JsqL+R3nWZi8u7_QRuGj=k7M2qB+NkM982OZfw0=n3+uLWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 10, 2019 at 5:58 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Thu, May 09, 2019 at 11:45:26AM -0500, Rob Herring wrote:
> > > +dependencies:
> > > +  cd-inverted: [ cd-gpios ]
> >
> > The note (which you dropped) says 'cd-inverted' applies for built-in CD too.
> >
> > At least that is what I take "Polarity of dedicated pins can be
> > specified, using *-inverted properties." to mean.
>
> Indeed, my bad. i guess we should probably keep that note. How are we
> supposed to keep a note that would apply to multiple properties? In
> the global description?

You could do a comment next to both properties or add it to the
description on one and refer to it from the other property (and group
the 2 properties together).

Rob
