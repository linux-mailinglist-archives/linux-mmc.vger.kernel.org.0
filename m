Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B07140C03
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Jan 2020 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAQOFO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Jan 2020 09:05:14 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:59685 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgAQOFO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 09:05:14 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47zjWD35x8zJv;
        Fri, 17 Jan 2020 15:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579269912; bh=+231y6ZND1a+e2pV2RjuPIKlHeV8kdbhF4SiUXm8rhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irAG46LM2InaZHcAyXRu9G+As+Fh2rYWHaa6Cbpan7O8jRKys93znY1oUhRGu7AmH
         nWLbHEAF03BEAqfct1gIq0n19iV5RNCemQfA8mmQraFXMumlS2mmIgv9P/uMFZJ1BX
         E7lS/Dn9pOOU8dENCMoFmzIApbx26sw0nohy8acGU3fVcUbmQL3r1zGXAWUKmRu/ft
         rF07OppKyWGr6tw/S4Q9aFX0Wcvtu9/ffwgnOUWvz15czk9/4m+Rb8F4iLcAd+herx
         DJiHFnloh3c547VWNaTksBxo/fZYSRJgkmvlKVTzp0Bi5F4MszOZL4g2XfL9MzAw5k
         FhVhLGTLkoJow==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 17 Jan 2020 15:05:11 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: limit probe clock frequency to configured
 f_max
Message-ID: <20200117140511.GC26135@qmqm.qmqm.pl>
References: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2020 at 03:07:22PM +0100, Ulf Hansson wrote:
> On Thu, 2 Jan 2020 at 11:54, Micha� Miros�aw <mirq-linux@rere.qmqm.pl> wrote:
> >
> > Currently MMC core disregards host->f_max during card initialization
> > phase. Obey upper boundary for the clock frequency and skip faster
> > speeds when they are above the limit.
> 
> Is this a hypothetical problem or a real problem?

This is a problem on noisy or broken boards or cards - so needed for
debugging such a combination. I wouldn't expect this is required for
normal devices.

> > Signed-off-by: Micha� Miros�aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/mmc/core/core.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index abf8f5eb0a1c..aa54d359dab7 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
> >         }
> >
> >         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > -               if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> > +               unsigned int freq = freqs[i];
> > +               if (freq > host->f_max) {
> > +                       if (i + 1 < ARRAY_SIZE(freqs))
> > +                               continue;
> > +                       freq = host->f_max;
> 
> This looks wrong to me. For example, what if f_max = 250KHz and f_min = 50 KHz.
> 
> Then we should try with 250KHz, then 200KHz and then 100KHz. This
> isn't what the above code does, I think.
> 
> Instead it will try with 200KHz and then 100KHz, thus skip 250KHz.
> 
> Maybe we should figure out what index of freqs[] to start the loop for
> (before actually starting the loop), depending on the value of f_max -
> rather than always start at 0.

Yes, it will skip higher frequencies. I didn't view it a problem,
because the new code guarantees at least one frequency will be tried.
The eMMC standard specifies only max init frequency (400kHz), so all we
should try is something less whatever works.

SD spec specifies minimal frequency (100kHz), but I wouldn't expect
this to be enforced nor required to be anywhere.

Best Regards
Micha� Miros�aw
