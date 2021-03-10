Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED9333498
	for <lists+linux-mmc@lfdr.de>; Wed, 10 Mar 2021 05:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhCJEzE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Mar 2021 23:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCJEyq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 23:54:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A28C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 20:54:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k9so31215016lfo.12
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 20:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nJduy9vJ/gQ9Q5XK6k0XKFhpSnNly3WrZaYD2M0E4M=;
        b=Qu+1v9uZK4/SCesRdfvdaIGpwyqIYD3wcfpeNPzOcsro1n4BnHpcpIshrnhMWrC297
         bJ1vLzD8JDObKwC5i3DXxeM1b6ttsMToxGQiVstvyI4EzvPyPEmcgDwImrG7jz35W76R
         5WBVSyEOuu0OOPuNDEgZJyyPu3wrxis8s+iJK6IxnMnPMM5fQXVmjj6V/BgYVnzhtRt8
         Q/g3YQRgbR8t6eYYRUcO7tTT4k79FpDfKDxiCqmg614HPZB3FPgXAABs2eXgqEyoOU86
         3XGRbsqTonKUCL3dh5eUUlW3+4Jvd/Wys5N/s+z3AXteE5qQ0zl+736eu+txVvl14A5E
         bsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nJduy9vJ/gQ9Q5XK6k0XKFhpSnNly3WrZaYD2M0E4M=;
        b=pWikCowWIa5ZFjyHEMyB+IMu3R/aYEZa5+Aiq9mc+EVVnzuNdpIUbO4C5JRxsbYGcx
         a9roq1gInW9DXgQHWNqx+87yO+2/d4tXNYQPOKkGlAjyuNMJn7IS+mKINlhL+xvnbM+N
         Q82ikcDvDLHcWXfZq7X9I//mJ08Ag8qm/kul/a32BmWhZoGrGGb+jzPmx6SbDvUV52Kg
         SpK8lbNwKqszQcNHM7VxMDwnjHz+YB4VxU+NnuzHhYYlMUGpny8pyBm43/N1R5khkkW0
         qw0mtVh4VtuXNaPCOXqSpqFcleFSoZuELKLeAioTDNL07L4qlPN6a4UfdGnrYE/U4dAL
         Rp1w==
X-Gm-Message-State: AOAM533lTtMJAeKrzWKCLKwkLJnaj26TlCm3/sJ/krBD/qeE2F6JHuSg
        LJwGcH6B0RifBFNRtD+OoYDSs8hfWAcsiSZ6NTJOLA==
X-Google-Smtp-Source: ABdhPJyA+Fk223H+bm0hGNLZN8BH2HdjMZLq6AkSXE9jXyn96FwjiEAycghxLxVYi1VmZdSiSE4xc4Vgs9mOjBPtTQw=
X-Received: by 2002:ac2:5970:: with SMTP id h16mr901084lfp.108.1615352084389;
 Tue, 09 Mar 2021 20:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
 <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com> <178479.1615309961@warthog.procyon.org.uk>
In-Reply-To: <178479.1615309961@warthog.procyon.org.uk>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 Mar 2021 10:24:33 +0530
Message-ID: <CAFA6WYOvszeEBUL6_mhX90zZMFAtGN6f=tBAC7L43ik00Js7=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ruchika Gupta <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi David,

On Tue, 9 Mar 2021 at 22:43, David Howells <dhowells@redhat.com> wrote:
>
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > As it seems neither Microsoft nor Apple is paying it much attention
> > (+/- new facts) it will be up to the community to define use cases
> > for RPMB. I don't know what would make most sense, but the
> > kernel keyring seems to make a bit of sense as it is a well maintained
> > keyring project.
>
> I'm afraid I don't know a whole lot about the RPMB.  I've just been and read
> https://lwn.net/Articles/682276/ about it.
>
> What is it you envision the keyring API doing with regard to this?  Being used
> to represent the key needed to access the RPMB or being used to represent an
> RPMB entry (does it have entries?)?
>

I think it's the former one to represent the RPMB key and it looks
like the trusted and encrypted keys subsystem should be useful here to
prevent any user-space exposures of the RPMB key.

-Sumit

> David
>
