Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13D275C97
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 03:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfGZBl2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 21:41:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36648 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGZBl1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 21:41:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so53740923oti.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ighPKSSLVjo8m3qhCoJ0gAbnxi1s58viTGow47mPKlI=;
        b=SivHi7DVN/5kj1kctEug37qCMD0Y4G0dfc5wwLJSZ64f/P2VuSg2G7WTD07WUOC4Hk
         rxxWaChjs8o7wfnWwLmlbQ8OYOlR3lbMdZcKEfE6F90I8Kjm+gk3NcHXIXvOzeDlkPfk
         3evz8LbvxeogxUsAFS9lLoNa/rINwlijPMfyl7ncrTa+YEcYAsy8PXoNz+gWrCM8UQZY
         +gxhAVSST2qktUM1bGTq0YbHErr4TDuA0dbj5Msew6oleURvD80nnIB3YuqK0RGUSO2L
         Ytt9t506BJe2mUwjvqUihnX4mRNAiEpIwkHELhzkRSTX0z8PA7ivzMCO5B6itfa1toM9
         mtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ighPKSSLVjo8m3qhCoJ0gAbnxi1s58viTGow47mPKlI=;
        b=lD2Vk1CmH7Paj95Nom3InCn/De1zpvW7Z1ISFzgYCCnpFi8xRimhH4B8YOkLaBCZDI
         TECSIiIWrUVeilrrRK3/GZMqNhojW7goKePiCKGusNu7ZVgTpE7lM457vtejL0Vpv6My
         g0Gq/2LFgeLDL95T9RA0ivb0R8PF7aNl0+JrEvKNjLZY8nPUVaMilTCjyBXIo3kgBgcH
         XHMJ6QlSF/oLQXFT9jJJrXyjqzn+NUW/qeeyP+LqoPt3Usi7Z6TKKx0GRZ9/hHURQsOb
         hf7fR+k7GwQlds30ITOiWooanvEteSTsO7YT88H/pIeuTTQqe/KRCMo5K3ApPhp3vLl2
         cVCQ==
X-Gm-Message-State: APjAAAVVR8l4x5H4M9VVEUdaDMODB+y7OwTctwdLjCKv1+EYqVJVA2/5
        /pAs+H4biqRVp68u7Zv+tk7R/POVj/7tq9CVtx5jnw==
X-Google-Smtp-Source: APXvYqxyx07JRG2OJ//qHU18VkEwI2x2E9581akJQa4pUqIN2mPi3uK5y+/G56wo9/97VPLGTgbmLmDZ1qvNCWUbJ6E=
X-Received: by 2002:a9d:529:: with SMTP id 38mr67743332otw.145.1564105286756;
 Thu, 25 Jul 2019 18:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
 <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 26 Jul 2019 09:41:15 +0800
Message-ID: <CAMz4kuKOGmGHoYNELG38qYOw71=AaSk33=johskUtOs0KZ0z-g@mail.gmail.com>
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

On Thu, 25 Jul 2019 at 21:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> - Trimmed cc list
>
> On Thu, 25 Jul 2019 at 05:14, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > The SD host controller specification defines 3 types software reset:
> > software reset for data line, software reset for command line and
> > software reset for all. Software reset for all means this reset affects
> > the entire Host controller except for the card detection circuit.
> >
> > In sdhci_runtime_resume_host() function, now we will always do software
> > reset for all, which will cause Spreadtrum host controller work abnormally
> > after resuming. For Spreadtrum platform that will not power down the SD/eMMC
> > card during runtime suspend, we should just do software reset for data
> > and command instead doing reset for all.
> >
> > To fix this issue, this patch introduces a new parameter of
> > sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
> > be done or not. Meanwhile changes other host drivers to issue a software
> > reset for all to keep the original logic.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Applied for next, with a little change (renaming the "soft"
> in-parameter to soft_reset), thanks!

Thanks Ulf :)

>
> Adrian, if there is anything you want to change, please tell.
>
> BTW, perhaps this should be applied for fixes and tagged for stable?
> Baolin, if so, can point me the commit (or stable tag) the patch
> fixes?

Yes, since we fixed the PM runtime issue, which will reveal this
issue. And I think it still fixes:
Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")

Thanks.

-- 
Baolin Wang
Best Regards
