Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1D811BD
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Aug 2019 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfHEFpj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Aug 2019 01:45:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45577 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfHEFpj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2019 01:45:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so18583042otq.12
        for <linux-mmc@vger.kernel.org>; Sun, 04 Aug 2019 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsfKjYjCsf5pGaKB27gLmom1CRQ53Y2eR9DqAuao1go=;
        b=WVWleQQGj7idNGkcLWguKl+6s7c9GSJR9Peu1JHRQU1SG0mgaqIgyTthtSMf4Jk4MB
         4zJ0c4qDcqlSmq6yf6Hjlg9nnBa+zohiHYt/DUTpOALEWr5NPVhUD7QpVxAvPPk3CByb
         hjiy+HEn2al9OonxuFaAYvFr+eSprCNZ93R6L8a7UGkNjzNvgO+yMBul6cITiV19EMu/
         P9M8YX+4EFmtC5R0gj5vesO/GH6l0ry/OsadBwEXF82z5zwN589en16FyxjfbKZTi2sJ
         on6n8ozaoK9aPh2pv5AksJyypa2+35YV5XPIkRh8AfDDYtfkYg6cz2eyezjbMOtox8md
         57QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsfKjYjCsf5pGaKB27gLmom1CRQ53Y2eR9DqAuao1go=;
        b=El/Ewbrbta5MfanezCW3MFoNDeaUymO6upcqyIgKxyyPFEmFLbXyzpUOZHT+i7Wjb0
         nhAxynImZ4BDDn4Jrxh6PyQmIMPbttD0BlOlvmutS2PwvEUFoT9y85MbtK2YwFxv4mmB
         dOnmAgBxAO6xk/xb2g66h1UE9KHxaPyw+Ax/5X7F8kmS2ATQVqcsR9jCViBF8KccKi75
         OvfZpgaeffoUZ9MeTd48n718S/2qNetFsDdJDXJEvlSvy4DRtKLFu7WQ2eeX18CNg3IT
         yskI7yrvhp/NIaXzdKHMRBfuIHdp8pEEfYbder76yQiu/YnnGnhPS8LickLCWSREXSyY
         8SOw==
X-Gm-Message-State: APjAAAWTSNLzKS5OmvCYP7remtI8nBsgx9akkQ10DC3bE7z/o6cAqOfJ
        hyzpubTNT0NHz9aRL9Ea0C6ATO5vOzePA4nnTGH/Og==
X-Google-Smtp-Source: APXvYqynsimY/6Dqk84ghAu9wj0Oshr0r+P73GlacIpKT0W1PHkBUMRBx5KYGo8JN1hrV2qFA92p1qT0zF29I/6VC7Q=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr76937428otn.247.1564983938417;
 Sun, 04 Aug 2019 22:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
 <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com>
 <CAMz4kuKOGmGHoYNELG38qYOw71=AaSk33=johskUtOs0KZ0z-g@mail.gmail.com> <CAPDyKFrUxTzMr+aJ=mXcVJeiP8f4-8+wAxkbA9n8mJaAn=ftVA@mail.gmail.com>
In-Reply-To: <CAPDyKFrUxTzMr+aJ=mXcVJeiP8f4-8+wAxkbA9n8mJaAn=ftVA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 5 Aug 2019 13:45:27 +0800
Message-ID: <CAMz4ku+appDGrAe9yLwzLunUy4K90O1ej2bvA5A=fMbVu_u7Xg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: host: sdhci: Fix the incorrect soft reset
 operation when runtime resuming
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Aug 2019 at 23:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 26 Jul 2019 at 03:41, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > On Thu, 25 Jul 2019 at 21:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > - Trimmed cc list
> > >
> > > On Thu, 25 Jul 2019 at 05:14, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > > The SD host controller specification defines 3 types software reset:
> > > > software reset for data line, software reset for command line and
> > > > software reset for all. Software reset for all means this reset affects
> > > > the entire Host controller except for the card detection circuit.
> > > >
> > > > In sdhci_runtime_resume_host() function, now we will always do software
> > > > reset for all, which will cause Spreadtrum host controller work abnormally
> > > > after resuming. For Spreadtrum platform that will not power down the SD/eMMC
> > > > card during runtime suspend, we should just do software reset for data
> > > > and command instead doing reset for all.
> > > >
> > > > To fix this issue, this patch introduces a new parameter of
> > > > sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
> > > > be done or not. Meanwhile changes other host drivers to issue a software
> > > > reset for all to keep the original logic.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > >
> > > Applied for next, with a little change (renaming the "soft"
> > > in-parameter to soft_reset), thanks!
> >
> > Thanks Ulf :)
> >
> > >
> > > Adrian, if there is anything you want to change, please tell.
> > >
> > > BTW, perhaps this should be applied for fixes and tagged for stable?
> > > Baolin, if so, can point me the commit (or stable tag) the patch
> > > fixes?
> >
> > Yes, since we fixed the PM runtime issue, which will reveal this
> > issue. And I think it still fixes:
> > Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
> > controller")
>
> Make sense. I moved this to the fixes branch and also to took the
> opportunity to clarify the changelog a bit.

Thanks Ulf.

-- 
Baolin Wang
Best Regards
