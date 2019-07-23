Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7977101F
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 05:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfGWDbN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 23:31:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36401 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfGWDbN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 23:31:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so42578578oti.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuJsOMP1sWOzyNRASKm1FqxCyfBszTFRMXUcxGZKlTM=;
        b=YhkuphGhxPljuSFa78sx3nQhoK6Y5gGMfv3ar3Rbe9ZOT/1wCT4+pTRYS6yRMkxshj
         +gJmzWnBfUkaRf9LlPDIhag5hAvraMpoMVwTisQyHKSnU0GdET9s7/qSZ5/FXb04n6gw
         xo0AHA5Ln7X+f2s6w0dmuyQo1BJDUv/u9MBPp7LeNhR9xaWMg+/Nl7dNrfXdr9Ciqyu+
         MHE29CgWWIbCK2+lqVPANNs0GLoOBQmrw+uar5N4wW6Vd+PALXN1X0uSWkAii9PWrNPg
         Bn1yKxmcEmCFE3dQggDm0hAhVJyXuLp5K/43TfMKi0Vmtpfsrr3Liiu99maJm/iN5Q6A
         h9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuJsOMP1sWOzyNRASKm1FqxCyfBszTFRMXUcxGZKlTM=;
        b=mfI/YCGAkZ7FUyu0MXTJCImzKcrNAMV2Q03FzGwmzF3r2c1AwvXT8RX9uruQOHo1+f
         ulHWCMPGwDYPIpVvUYU/TGQkOC3EcQC1TFbqWym0BoUvnXZ2bYhuB2zFvONUrAURSQlb
         ZJgRrzFdWSL/X59+RElnfutTCp8qKT0TORy2SM92jiVzRAH/ZCxoT/5X/fsiRjDdAvVL
         jhPb9O5KhLCY7+rQN/fFKSMiuPHZbLnm7XHOXn/ljR94UeOA3MfWDo1FJDjMegPyjfXG
         xCJ2gzxFt0NVQrQbv0X16n5ULQDA6G3Z3SuaTkSYBdLM51vyaKFcsZ0V1Xi7fq4YUHfv
         XR7w==
X-Gm-Message-State: APjAAAVGc/uSLMiEwg5j09voLS7LkODhQmpW3x2URdi0OnOlc6Q690M4
        JoqXSxE8AnJgy4MEVE13zd7FXmmGgG/gpgG61Zc7Kg==
X-Google-Smtp-Source: APXvYqzsAwVOYSW7/1SB7VSKWgabK9ejyGUFaHieaEx7LWJg+Q7uKdonWAt70NYTeBDXz22RgLCiyyE53Fv3qO0Zlhs=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr20925635otn.247.1563852672027;
 Mon, 22 Jul 2019 20:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
 <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com> <CAAfSe-s=Lae-JV_ogAyd355U6X2q0Zr-fhHcMm1=y=So=UTpxw@mail.gmail.com>
In-Reply-To: <CAAfSe-s=Lae-JV_ogAyd355U6X2q0Zr-fhHcMm1=y=So=UTpxw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 11:30:59 +0800
Message-ID: <CAMz4kuLz8UnREy=rMv0OH1tjOD3v=PYtVuM91HkcS=j7Lia=ZQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 11:21, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Tue, 23 Jul 2019 at 11:05, Baolin Wang <baolin.wang@linaro.org> wrote:
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
> I can make a verification on sprd's SC9863A, but that would take a
> little time, since I need to make sd card registered with sdhci-sprd.c
> first :)

Great, you can try it on your board. Thanks.

-- 
Baolin Wang
Best Regards
