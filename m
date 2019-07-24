Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6097245A
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 04:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfGXCWJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 22:22:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42491 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfGXCWJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 22:22:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so46225548otn.9
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLF4pm4RL0wA5hcVMMrw5NHFRQ2ig5s8he/98rvlGyk=;
        b=z4hxi5G1bGRKaxWUmoOapIH+np2Z8tsVglNR9ERPddstRiq1j+A8iaNPQj935G+M7h
         3yqJUpOVU86A4Z0eoouJecKlZXZ7G7dRajE79VKd3RQe8MfNzzist2Eu+WvktxfNhtjN
         W6SOLeN4cPTx8t1SngtztORzM+JDxOlvVfEAgnvT0AzT4W0Uv0NhiehmCPaUYtXrbf3Z
         2bRBT9XbxdIKTb9bdhXnNbbZtISNzn4jEJdR1gZmtBUGY+A6RBB1AWn24FS/nzODNjmN
         K24AURwQG2mM+llYT3GsFwP/sAE/u4iMIS+OfBIesHOQkyFA5U092OEe/HPyjsOXHDdI
         lTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLF4pm4RL0wA5hcVMMrw5NHFRQ2ig5s8he/98rvlGyk=;
        b=kyPODOJ03qjdveXZlZIaVSZlKm0D33W0DhkyKLfh/PC9QWNBf0UDTz8KIUMpq4f1Cc
         P3+K+qVYtdfZn90c7LbDyD9z5y4vk5RB3wyre93YeouYTKYcqWP2WYl55KH3PPTdlt/l
         dBRLWlNP56Ezu4aDxd6L8QLBnqniC49zyXkHsNokCpy4lDJmnA5QKkGiGMWO8ILTlV0f
         YzvJJ29GLO6kULrz7fM65P2uGPj9tbronoaBPX6NNGYVZ6wlZYx7fdJ5rdeM20bW7PpQ
         Xcn6QndTpVIFgOMT5ZHtiHjdDEw2lRYpRWg3cMKkt5lK+P7Y2RwtUkqGYTd/ZoN6h8tM
         880g==
X-Gm-Message-State: APjAAAX/22VjNc8dfzqDmmFGXHBWH4Zvh9eK/IFJTRZI6jlQkV/fN1nf
        ys23COpR1K1Hmrcd7az0Y6Ocv47UKK6c6HrKWG9hXA==
X-Google-Smtp-Source: APXvYqxnOt402L5HhNkgDDvSy4DpF7ukOVhYefdp2TGaYvy/AB0kwedVYo2x2l8D2jCfGB1qH9kpkALSvsj4T0IXBwM=
X-Received: by 2002:a9d:1718:: with SMTP id i24mr20907922ota.269.1563934928175;
 Tue, 23 Jul 2019 19:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
 <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com> <CAPDyKFpy5JeGZ2w1KJN0ECB6jPG=UTZXbPRjMQQs8+NdK4rxuQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpy5JeGZ2w1KJN0ECB6jPG=UTZXbPRjMQQs8+NdK4rxuQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 24 Jul 2019 10:21:56 +0800
Message-ID: <CAMz4ku+ZTtnJdonZVAPVuvAiGCmCESvM8SbYKjwpNUgE4bO3gA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 20:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Jul 2019 at 05:05, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > > In sdhci_runtime_resume_host() function, we will always do software reset
> > > > for all, which will cause Spreadtrum host controller work abnormally after
> > > > resuming.
> > >
> > > What does "software reset for all" means?
> >
> > The SD host controller specification defines 3 types software reset:
> > software reset for data line, software reset for command line and
> > software reset for all.
> > Software reset for all means this reset affects the entire Host
> > controller except for the card detection circuit.
>
> Thanks for clarifying, please update the changelog accordingly.

Sure, sorry for confusing.

>
> >
> > >
> > > >
> > > > Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> > > > runtime suspend, we should not do software reset for all.
> > >
> > > Normally, sdhci hosts that enters runtime suspend doesn't power off
> > > the card (there are some exceptions like PCI variants).
> >
> > Yes, same as our controller.
> >
> > >
> > > So, what's so special here and how does the reset come into play? I
> > > don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> > > and nor doesn the callback from the sdhci-sprd.c variant doing it.
> >
> > In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
> > issue software reset for all.
>
> Aha, I didn't read the code carefully enough. Apologize for the noise.

No worries :)

> >
> > >
> > > > To fix this
> > > > issue, adding a specific reset operation that adds one condition to validate
> > > > the power mode to decide if we can do software reset for all or just reset
> > > > command and data lines.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > > Changess from v3:
> > > >  - Use ios.power_mode to validate if the card is power down or not.
> > > >
> > > > Changes from v2:
> > > >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> > > >
> > > > Changes from v1:
> > > >  - Add a specific reset operation instead of changing the core to avoid
> > > >  affecting other hardware.
> > > > ---
> > > >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > > > index 603a5d9..94f9726 100644
> > > > --- a/drivers/mmc/host/sdhci-sprd.c
> > > > +++ b/drivers/mmc/host/sdhci-sprd.c
> > > > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > > >         return 1 << 31;
> > > >  }
> > > >
> > > > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > > > +{
> > > > +       struct mmc_host *mmc = host->mmc;
> > > > +
> > > > +       /*
> > > > +        * When try to reset controller after runtime suspend, we should not
> > > > +        * reset for all if the SD/eMMC card is not power down, just reset
> > > > +        * command and data lines instead. Otherwise will meet some strange
> > > > +        * behaviors for Spreadtrum host controller.
> > > > +        */
> > > > +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > > > +           mmc->ios.power_mode == MMC_POWER_ON)
> > > > +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> > >
> > > Can sdhci_sprd_reset() be called when the host is runtime suspended?
> >
> > When host tries to runtime resume in sdhci_runtime_resume_host(), it
> > will call reset operation to do software reset.
>
> Right, I see that now, thanks for clarifying.
>
> However, there are still some weird things going on in
> sdhci_runtime_resume_host(). Like why is host->ops->enable_dma()
> called first, directly from sdhci_runtime_resume_host(), then again in
> sdhci_do_reset(), after host->ops->reset() has been called. Looks like
> the first call to ->enable_dma() doesn't make sense?

I am mot sure, since our host did not supply enable_dma() operation.
This logic was used by some other hardware and worked well, I am not
sure if it can reveal some issues if we change the logic here.

Adrian, could you help to explain why we put enable_dma() in front of
software reset?

>
> >
> > > That sounds like a bug to me, no?
> >
> > Since our controller will meet some strange behaviors if we do
> > software reset for all in sdhci_runtime_resume_host(), and try to
> > avoid changing the core logic of sdhci_runtime_resume_host() used by
> > other hardware controllers, thus I introduced a specific reset ops and
> > added some condition to make sure we just do software reset command
> > and data lines from runtime suspend state.
>
> I understand, but perhaps it would become more clear if
> sdhci_runtime_resume_host() is re-factored a bit. Maybe the caller can
> give it some new parameter to let it decide if a SDHCI_RESET_ALL shall
> be done or not.

Yes, sounds reasonable, but need change other host drivers which
issued the sdhci_runtime_resume_host().

Adrian, if you also agree with Ulf's suggestion, then I will post new
patches to add a parameter to decide the reset mode. Thanks.

-- 
Baolin Wang
Best Regards
