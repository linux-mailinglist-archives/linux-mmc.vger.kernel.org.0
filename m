Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31EFEA80
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfD2SuY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 14:50:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2SuX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 14:50:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so17494842wrw.13
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k/tSEEpVfOTB3sYTDNontQ33XbDgKI57+ULaEZv4d0I=;
        b=Hp0RwA9MDJhr1O3TwRGn/bnp3v62pTPI/CtBqfDHIvIwusCU1OYSfeT7NcenDp74V7
         VjRuqamza0i9YBnJHiZsXSjPee1Q+bGNaccy1km/4616cIOJEKHeeC9QXPIGKJDtSUdH
         XOVpHBwdPAut5rmYw7xje1F57QLN9vcpkds5ZS9MZzNVjdAEurN/fKQ7hJxJLy2YbVAF
         f7g+ZTSUz3he+pRySAv1u0dJkZb5IoxDTHOmvNesZn+EjnE2TZeyUvmVzHw+AMt/BVyr
         xsjwSqmJ//Imh3aPRsCyL4lr1sr1IPPDg0DWyFxCkjse0EgqASEk2sgRyPDKzIDUfR2i
         jwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=k/tSEEpVfOTB3sYTDNontQ33XbDgKI57+ULaEZv4d0I=;
        b=uaQDwNKSOO9zXDhxyRBw5Y5qjz1P4ouBvlvIiVws2sq/FSj0PhZH228iPThGffdvXl
         Ph6bX4TjbWFrHkyTHQgqsK8TCubbSDzZpxcZnV6UgWj+0xCo5AifQgQSkICHIPwLGjRC
         t5vEG4GNo6U/jiOJXOMYeRM8BLN0B2uEDxqSDWxfuiA+oR89BHtNQ1CEUtxdxT5chFZa
         BaOrsGhHnvviH8Hhnj0HRgJYP3M1ZA4kx0leS9a+cFa3n69+ZWdHUujvBS6T+MJQybxU
         b7JmkO29bV80uZTXmURq6OIyhqyIw8giTjUi5uAKiFNnSjAtQKgYxRqKDeiSq8dFXFdZ
         HuZg==
X-Gm-Message-State: APjAAAVbMO8hgr8EEXvmLA2aVrkGUWD62myAcJy5ddTxNrpzLtZ7Tgvn
        sCPCc995bDpEKDBkZQkO2lsL0w==
X-Google-Smtp-Source: APXvYqy1qSw7xJpnL+ItwcmEzPn9HqZCdtxUSBbM+PQjPmQa9utQ/PeKtDN91CzsMyhLLRhCwxcfKQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr7747408wrp.290.1556563821390;
        Mon, 29 Apr 2019 11:50:21 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t76sm442176wmt.8.2019.04.29.11.50.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 11:50:20 -0700 (PDT)
Message-ID: <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Apr 2019 20:50:18 +0200
In-Reply-To: <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
         <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
         <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2019-04-29 at 20:31 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Mon, Apr 29, 2019 at 10:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > > 
> > > On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > > > been unsuccessful or unreliable. Until we can figure out how to enable this
> > > > mode safely and reliably, let's force it off.
> > > last year I have seen issues with HS400 on my Khadas VIM2: [0]
> > > have you tested all other patches from this series and HS400 is still
> > > not working for you?
> > 
> > Because HS400 was never really stable to begin with.
> > It was a mistake to enable it on the VIM2
> > 
> > > I'm curious because this patch is early in the series and all the
> > > tuning fixes and improvements are after this patch.
> > 
> > There are several reasons why this new tuning won't solve the HS400 problem:
> > - Signal resampling tuning granularity gets worse when rate rises. The resampling
> > is done using the input frequency. We can basically resample up to the value of
> > internal divider.
> > 
> > In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
> > In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
> >            possible (internal div = 1)
> >            Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
> >            that's not enough to tune
> this limitation would be great to have in the description of patch 7
> from this series

That's not really a limitation. I should probably not have mentioned as it it seems to
have made things even more unclear. I disabled HS400 before introducing the new tuning on
purpose. Any comment regarding hs400 does not belong in patch 7 IHMO. If you want
to add comment regarding hs400, I think it belongs here

> 
> > Going further, tuning the Rx path does not make much sense in HS400 since we
> > should be using the data strobe signal to account for the round trip delay of
> > the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
> > HS400, it is most likely linked to the data strobe.
> it would be great to have a better description as part of the commit
> message - with that you can add my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> my proposal for an update patch description (apologies I have
> incorrectly summarized your findings):
> "
> At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> been unsuccessful or unreliable:
> - signal resampling without delay adjustments and phase tuning for the
> RX and TX clocks (this caused CRC errors and hangs even without HS400
> mode, for example on the Khadas VIM, Khadas VIM2 and libretech-cc
> boards)
> - signal resampling without delay adjustments and RX clock phase
> tuning (some HS200 and HS400 eMMC chips were not recognized, for
> example on the Khadas VIM and Khadas VIM2 boards)
> - signal resampling tuning with delay adjustments only (works fine for
> HS200 and UHS modes but doesn't fix HS400 eMMC chips, for example on
> Khadas VIM2)
> 
> Further improvements for the HS400 mode are likely to be linked to the
> data strobe signal.
> Until we can figure out how to enable this mode safely and reliably,
> let's force it off.
> "

Thanks for effort but all this just maintain the blur around HS400 on amlogic.

Let me rephrase it:
Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
and HS200 modes. In HS400, this should be taken care of by the data strobe.
But we have not been to enable this reliably enable this on amlogic chipset ...

... and I believe we are back to the original commit message.

That's my understanding of the hs400 problem.

> 
> This whole series is a good step forward.
> also thank you for this additional explanation!
> 
> 
> Regards
> Martin


