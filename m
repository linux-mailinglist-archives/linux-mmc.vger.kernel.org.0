Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5559E7FD5D
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHBPRO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 11:17:14 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34131 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfHBPRO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 11:17:14 -0400
Received: by mail-vk1-f195.google.com with SMTP id v68so11699851vkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=am7VE97nq7ZCmyomVd2COANpZQyhG+APNd3r/OoUU8U=;
        b=BF0SB7AG4ut6fyvBHWEJHFmQpNcjCG/QXxAAJS/MFj9ASooOeUQ5thcsW0/uqjQ/gc
         HZTpZ8ckknuiN4hM3GcMD/JD3lUY1R0hbkxbYW9lzigzMgkm4KDtebOf79sVXLTcEPRu
         lVgOz27jxYFnbmqlUuv3p7iI3ITblLXTCvWUteXAGGjbTjxT9IOQewW3v04Qal0Vd0Kd
         CDyyltnc8QUHjcWtW9/kzMfjW08/g/lYPj7PLUGmQj4iQqmXlQ8TnJOrzYp7fqLtbCzt
         397e25T9NR4itzF05i+5wsImZyD5IF/PJYNiRtNU+rv3DBxT9ICNSmaca3Y7A2b22Rle
         9GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=am7VE97nq7ZCmyomVd2COANpZQyhG+APNd3r/OoUU8U=;
        b=uPHUzw153irwAwralywuL6fMz3aOadE6K19RTnBLbuJ8dRE7RI33yLDt3OHlqCS1eV
         HkvzcbHAHPt6qZMMbwZJiHrBCLQwsBif6EgHc6OEvnZbPpn5A1DIBRMFqFdkQTSYtl/c
         eMw+DUfjPSphwJKfOAThd8uwFlH/d/g9+eNzuOjmznNLUB2Rm4aWqw2g3/vST0aa1S24
         L+/oTHx14LmW5MngGXEjETnHUnV1SR6ukFCPNSL/N19LyiarwwA/p4lStwONvoDqQtfB
         4ciR1xlxD2jCD1U3XXzUmNS8cN6SzFxrldfAwItlo2rggmmFjH3LHTvxAwNLP6ylND/c
         FVvw==
X-Gm-Message-State: APjAAAUZqUunOFLVbXQ/UKhO4cd4w4qqLQ3XGFgUkwWo/vDFg9GU5BSS
        EZo8ZHwoig/lfRkEizRe3dI10Ig1LmvZ4Gaqkd0Kig==
X-Google-Smtp-Source: APXvYqzVQw8kB+1j21L33BZtSuag8+GbzvjmhwXIEvKgNDa3JbbTqxZRiSDmv4Xhj7zIIO2fTODFwifqyIfQ5/sgWQ8=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr53607626vkh.4.1564759033184;
 Fri, 02 Aug 2019 08:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
 <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com> <CAMz4kuKOGmGHoYNELG38qYOw71=AaSk33=johskUtOs0KZ0z-g@mail.gmail.com>
In-Reply-To: <CAMz4kuKOGmGHoYNELG38qYOw71=AaSk33=johskUtOs0KZ0z-g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:36 +0200
Message-ID: <CAPDyKFrUxTzMr+aJ=mXcVJeiP8f4-8+wAxkbA9n8mJaAn=ftVA@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: host: sdhci: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Jul 2019 at 03:41, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> On Thu, 25 Jul 2019 at 21:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > - Trimmed cc list
> >
> > On Thu, 25 Jul 2019 at 05:14, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > The SD host controller specification defines 3 types software reset:
> > > software reset for data line, software reset for command line and
> > > software reset for all. Software reset for all means this reset affects
> > > the entire Host controller except for the card detection circuit.
> > >
> > > In sdhci_runtime_resume_host() function, now we will always do software
> > > reset for all, which will cause Spreadtrum host controller work abnormally
> > > after resuming. For Spreadtrum platform that will not power down the SD/eMMC
> > > card during runtime suspend, we should just do software reset for data
> > > and command instead doing reset for all.
> > >
> > > To fix this issue, this patch introduces a new parameter of
> > > sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
> > > be done or not. Meanwhile changes other host drivers to issue a software
> > > reset for all to keep the original logic.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >
> > Applied for next, with a little change (renaming the "soft"
> > in-parameter to soft_reset), thanks!
>
> Thanks Ulf :)
>
> >
> > Adrian, if there is anything you want to change, please tell.
> >
> > BTW, perhaps this should be applied for fixes and tagged for stable?
> > Baolin, if so, can point me the commit (or stable tag) the patch
> > fixes?
>
> Yes, since we fixed the PM runtime issue, which will reveal this
> issue. And I think it still fixes:
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
> controller")

Make sense. I moved this to the fixes branch and also to took the
opportunity to clarify the changelog a bit.

Thanks and kind regards
Uffe
