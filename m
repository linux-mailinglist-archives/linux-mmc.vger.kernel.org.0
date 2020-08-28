Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91584255D29
	for <lists+linux-mmc@lfdr.de>; Fri, 28 Aug 2020 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH1O4T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 28 Aug 2020 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1O4S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 10:56:18 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6FDC061232
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 07:56:17 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n193so306396vkf.12
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTaoSyHl3HqBsHrY5A4LuCqff0xNJw9//Kl7Y7tQ/M4=;
        b=eyWU4USiiQHhauh+FMao8Op72UXp1qitc0E2GZbWptF8sa6nAWnBPCn9xxOOXhSXB5
         aPXkX6rwzK6pL7JZvxRyZskSKLenOvFqESRRJx3DmaPc79bPObCOFBVPDxuCJ1FheAhQ
         vrB2C/VgFTyn1jotUHzF7U49NATW0dZFMF7zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTaoSyHl3HqBsHrY5A4LuCqff0xNJw9//Kl7Y7tQ/M4=;
        b=HDzcBrdESReJ2IShVkIujDW1IYYzU/zK4slqkaj9vSZIz+618qfjLK580XkkRSaPJo
         RJx0EZmpkHljVp7toW8Mj5N7xzXHmXHvbCdWUBIfMM0JAMdFHx0EZUSvaW1huuTmgvPg
         P/cbARpFaJgEVqiQD1qcJDZ2q9oFeWODAKyEDmVNv8IZkm6mYfTOt0sOWcJsF5NOADjc
         t2Gf5QcoFlmB4FFYRe8zLs/hFFK9kHmTYVuZmr3TfFOhhGDh6jG4kYgljDeS9cygymQe
         OLbtAvkKIyir0JvMVw2qoD0tdQwVjyjsaag2UE8FARfA+ypZbJR44yCyiVpo5y+kwjnv
         xD9g==
X-Gm-Message-State: AOAM532tS2wLNz/Ce3FNvrF1yXm6xF8XKJCKG1Hne9GEsXfeDUEmEF6p
        XB5YChVuhpZxCygq4fU4EnItVcyMGvo3Qg==
X-Google-Smtp-Source: ABdhPJyMiyuWdHja5/34KWAONo/uFMlo1O1gU4huO14n/tVdTD6Z7gDoXatT8e6pOossRzNNAXQfKw==
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr1314364vkc.53.1598626576523;
        Fri, 28 Aug 2020 07:56:16 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id c10sm180357vsp.32.2020.08.28.07.56.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 07:56:15 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id 68so459054ual.3
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 07:56:15 -0700 (PDT)
X-Received: by 2002:ab0:3114:: with SMTP id e20mr1362127ual.104.1598626574941;
 Fri, 28 Aug 2020 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
 <CA+G9fYtWpBQb8Ew_G=bjcR7wBHMgKm=EXV7vuk6FE9m0-4Ef3A@mail.gmail.com> <CA+G9fYt-k9FMq0HcRN5iQyvt7yaz8YMpENcUktm7yQ1y+zgd1A@mail.gmail.com>
In-Reply-To: <CA+G9fYt-k9FMq0HcRN5iQyvt7yaz8YMpENcUktm7yQ1y+zgd1A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Aug 2020 07:56:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7SuUEFAtqPhDpW0O9H3bznsGma_n-fB-JArDAtfHrFg@mail.gmail.com>
Message-ID: <CAD=FV=V7SuUEFAtqPhDpW0O9H3bznsGma_n-fB-JArDAtfHrFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0
 it's not an error
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 2:15 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Fri, 28 Aug 2020 at 01:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 27 Aug 2020 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
> > > dev_pm_opp_of_remove_table()") works fine in the case where there is
> > > no OPP table.  However, if there is an OPP table then
> > > dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
> > > "if (ret != -ENODEV)" will evaluate to true and we'll fall into the
> > > error case.  Oops.
> > >
> > > Let's fix this.
> > >
> > > Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > I will test this patch and report again on this email thread.
>
> Sorry this patch did not solve the reported problem.

To be fair, I wasn't trying to.  ;-)  That's why I didn't add
Reported-by to my original patch.  I was trying to solve problems I
was seeing myself and my patch did solve the problems I was seeing.  I
only CCed you because I saw that you were having problems with the
same patch...

> However, I would be testing the V2 set from Viresh Kumar.

I've confirmed that the current mmc/next (with Viresh's new patch) no
longer breaks me.  :-)

$ git show --format=fuller linux_mmc/next | head -8
commit 174e889d08aa54219b841464458f81d13fafec93
Merge: c282fdb49b18 8048822bac01
Author:     Ulf Hansson <ulf.hansson@linaro.org>
AuthorDate: Fri Aug 28 14:26:25 2020 +0200
Commit:     Ulf Hansson <ulf.hansson@linaro.org>
CommitDate: Fri Aug 28 14:26:25 2020 +0200

    Merge branch 'fixes' into next

-Doug
