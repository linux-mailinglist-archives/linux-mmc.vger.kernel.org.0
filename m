Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4420502AB
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Jun 2019 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfFXHEF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Jun 2019 03:04:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfFXHEE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2019 03:04:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so12589817wre.7
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2019 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZ5T6mh01LDQWIrhj08LXl2MtUB2ESjC8KM9udZMFnA=;
        b=cT7gQsGasepgwNAJAsZErgeyXSj7TxoPC17Mh9a13zT9EY3bA3/Fb0oX3ZjZnLihHN
         d5YLoFSyLaYcASqdiXgP+feb1CD1Z6CkMe69UsKDUa8Tc+lPucF8WE3zRFqAzHmfma2z
         zQZQwYziJDBj/8YMTw+ObQrO+xA6wIFQqnRKiejQ3BOCW7+evSwdwL9bycfpcu7UqgHQ
         juvXfx/rzxErHV5nLbYbR7NC2XoLxNVgFZP3ZOomo7AVy22+AM2mWVEmJJW0JJ7XajSw
         apN6jMKUEDgG1V2HondKyPYNY/XUXtJD6YL5VznIqm8cH9Hhn3rFEkR5Hbrf2uq6gnsS
         nXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZ5T6mh01LDQWIrhj08LXl2MtUB2ESjC8KM9udZMFnA=;
        b=MtsdxgILCNerKhSCVzQVpnUvbgPqKZ7e61t3RP7lxv7/tWYxoSLLlTDO/mEvnoHipk
         xJIbicfJIZOLfx5yECL9vSxqoLy157pwUWAInAGS1I5bSjsazfNlncRN+6WECzQj3ZdM
         3dx9pqjsOAMBSZetVaaVipMpENKqnISXO86yUetCWAshTZLE0yK301PF/yBQVp3xiVOU
         MtPI4UYl0H/tdol3S9BAxgHfB/VzyxlSwOrQicNWbnd+cVAR1RJZnPe5fQeM3Z1wA7wz
         d2CUq+WT7VI+Cle+Z2TjWfD/ClZoTq0ob7CU6ESys00F3mR6GhzMqyg8tYgh9AJtPe0N
         cGCg==
X-Gm-Message-State: APjAAAXIKI7tLvU8JqxJgwd1FOB4JpB/tPQG32qn/Blpgaswwv6Aw407
        zQCsscs+o4wxxUGMUBb1lYbMoci+AxlvjOTTtioHbg==
X-Google-Smtp-Source: APXvYqyv2ruv/eQURzEi0kuv9vFpJ/BPkzqTVpaga+ooyEJtqQzsVKlPEd+VaaQuL8v5QCCa3slUUh2DF7O/V7LrrwA=
X-Received: by 2002:a5d:5452:: with SMTP id w18mr72275585wrv.327.1561359842839;
 Mon, 24 Jun 2019 00:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190621060511.29609-1-yamada.masahiro@socionext.com>
 <CAK7LNASGVbkGgu7psy4DfCxmr-AxSQ3fmGJ=aDAiuSkJ5hrDwA@mail.gmail.com> <20190621105025.GA2987@kunai>
In-Reply-To: <20190621105025.GA2987@kunai>
From:   Lars Persson <lists@bofh.nu>
Date:   Mon, 24 Jun 2019 09:03:52 +0200
Message-ID: <CADnJP=sg1Kp=TAvUD-ofQje9Y6mWWE_ZnQM_eB85uw3z6PHrVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove another TMIO MMC variant usdhi6rol0.c
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rabin Vincent <rabin.vincent@axis.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jun 21, 2019 at 12:50 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Hi,
>
> On Fri, Jun 21, 2019 at 03:16:11PM +0900, Masahiro Yamada wrote:
> > (Added Lars Persson, Guennadi Liakhovetski)
> >
> > On Fri, Jun 21, 2019 at 3:06 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >
> > This needs Ack from Renesas.
> > But, I do not know if TMIO folks are sure about this driver, though.
> > (If they had been sure about it, they should not have duplicated the driver
> > in the first place.)
>
> ... and from the original mail:
>
> > Delete this driver now. Please re-implement it based on tmio_mmc_core.c
> > if needed.
>
> I was never happy with this driver existing, yet I never knew which HW
> platform needed this, so I didn't touch it. But I'd like to see it go in
> favor of merging with the TMIO code base.
>
> >
> > Perhaps, some code snippets in this driver might be useful for cleaning
> > tmio_mmc. It will stay in git history forever, and you can dig for it
> > whenever you need it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I double checked there is no user in the current tree. I also searched
> the web and did not find any out-of-tree user or even a reference of it.
>
> So, for now:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> But this seriously needs an Ack from Shimoda-san or Morimoto-san. And
> maybe Guennadi has remarks, too?
>

So let me tell you the real use of this driver.

It is used by Axis Communications in our Artpec-6 chips that will be
around for at least 5 years in active development at our side. The SoC
is upstreamed, but the upstreaming effort was side-tracked before the
usdhi6rol0 was added to the devicetree.

I do agree with you guys that we should not keep two drivers for the
same IP so there should be an effort to unify the drivers. In the mean
time, we can make the connection with Axis more explicit by assigning
us as maintainer and pushing the device tree entries.

BR,
 Lars
