Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3C7F9B9
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394640AbfHBN2x (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 09:28:53 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:40146 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391729AbfHBN2x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 09:28:53 -0400
Received: by mail-vs1-f48.google.com with SMTP id a186so49697109vsd.7
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9L3tWNq55/6N+fb0w+92cMarsOIhZv92fgEA9Wl0NU=;
        b=OtoZAEPkbpbQu61sKlc/mWfmbvRVJRfjRvEW+0Ih6wA9+5VCgnO3VcwPjolH0SRj3S
         2/DyrM5Ho43TPXvIJ81glZojeATkmuG+b0oOl99p+KADJX2J/9Pi61Hh6ZlrZROhNQNK
         KcF+mWyvDAixY3Vgn5aMQmG3Rqm4sajiisKROqLiYD3oxknqvFeLSat/DSMofrIymWqz
         caBmJK6ZcbbIqTYdEZD3M3GgbtI4d/PD6cdsRQU0y3RA3t0VMbVqlDcvkPpwsd80H/xe
         hgQpG6FM/rLBX/3K4mHsgVa/CiTRL92YxF9hdvlm2Dlp54L9en3SG67dhktrIql0J8s4
         I+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9L3tWNq55/6N+fb0w+92cMarsOIhZv92fgEA9Wl0NU=;
        b=LjA8lB03YIfh+I2diD7h18coNeWI2edgwC69sjnoKLwe0GgXE0xK2T7kMH0pHFMXCE
         /zHiBfHQbSGPz2VcX/I9jj0oOAdZprLRiJfraj5ML5kHo9HVd+2XEXgngS9Pwo6i77LJ
         hYZkCqKTUe+jQlNNX85sYHYRY/cav3uY6gAbfZfhPS1IHtJgeKkl7PGki+3IF5b24c3Y
         yBYLj+0IIOdchCVE7a9Ixj6rCQBAGbTOkpP1Un9iKNrzAQVghE8Jrt0vB+Ibt2hx3DSk
         POoSmh9UCmH1SfkAm7Y3mDK3MlJ13YjggTHgfqqhKYy6mLjZFyUNXkhKEDvEsJPDRqWX
         t1+g==
X-Gm-Message-State: APjAAAXFBWOHt78HZq+C+icVBLbhSlF21dcaGtZQ3X6AIPBY9SR5ru6w
        n9fuekeWD+AJsE7yeRDd5gKE+SOOnM0H4MlftMASKQLQ
X-Google-Smtp-Source: APXvYqwwmxRCSFj9sJbzQPABF0bNL3n2eVxig7vkghJneMgMA+8nb9Mvfs5ZMMG0vmZkAfGzQaeCqqDKecK3AD6VXmo=
X-Received: by 2002:a67:8709:: with SMTP id j9mr86576230vsd.35.1564752532191;
 Fri, 02 Aug 2019 06:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
 <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com> <54d45628-14f4-514b-f5cb-18bf4f7baf63@raspberrypi.org>
In-Reply-To: <54d45628-14f4-514b-f5cb-18bf4f7baf63@raspberrypi.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 15:28:16 +0200
Message-ID: <CAPDyKFpKAaeLtppQAv5O1CW2FcF5Pa=-k+PEr4ppO-Mc6RN3-w@mail.gmail.com>
Subject: Re: Possible bug in sdhci_set_power_reg
To:     Phil Elwell <phil@raspberrypi.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Fri, 2 Aug 2019 at 15:23, Phil Elwell <phil@raspberrypi.org> wrote:
>
> Hi Uffe,
>
> On 02/08/2019 14:15, Ulf Hansson wrote:
> > On Tue, 30 Jul 2019 at 15:17, Phil Elwell <phil@raspberrypi.org> wrote:
> >>
> >> Hi MMC team,
> >>
> >> I've spent some time trying to add a regulator to control power to an SD card
> >> (vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
> >> I found that powering up the regulator during the boot process was effectively disabling
> >> the SDHCI controller. Note that this was despite having regulator-boot-on set in the
> >> device tree.
> >>
> >> The problem seems to be in sdhci_set_power_reg:
> >>
> >>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> >>
> >>         if (mode != MMC_POWER_OFF)
> >>                 sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> >>         else
> >>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >>
> >> This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
> >> register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
> >> Select bits to 0b000 (a reserved value).
> >>
> >> sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
> >> select bits, so I found that (in my limited test cases) replacing the if/else above
> >> with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.
> >>
> >> Can anyone tell me what I've been doing wrong, or suggest a better "fix"?
> >
> > There are other sdhci variants having the similar needs, hence we have
> > the flexibility available via using the optional ->set_power()
> > callback.
> >
> > Have a look at sdhci_arasan_set_power(), for example.
>
> I don't understand. Can you explain what writing 0x0001 to the SDHCI_POWER_CONTROL register
> is supposed to do according to the specification? And why is the Arasan SDHCI implementation
> not the default?

Good question, but unfortunate I don't know the SDHCI spec in that
great detail. And in the end, it has turned out that variants seems to
differs in regards to this register.

I looped in Adrian, to see if he has some comments.

Kind regards
Uffe
