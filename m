Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F6E06AC
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfJVOrR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 10:47:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43335 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOrR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2019 10:47:17 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so15656621ilh.10
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2019 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtR0PWo1dnvCC8sVNqIrEQULx6YseetGPasRYtSEfgU=;
        b=MhxylbhKkpmyjYOkefoLAam3gigL71xHU7w6C3RixbGIvY/htZLZ3NLPukRnCrP3tb
         EQ/HSW2Pf9P7GEFdQvHA7IkPm+joLGn+EnOslY9EhkKYD7B47a5V+ks4rnpudK5oQytn
         78uU9PCAmnihBor54R6P4YKJ3jC1Qdq4YKuNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtR0PWo1dnvCC8sVNqIrEQULx6YseetGPasRYtSEfgU=;
        b=B+KdbZPuTQLV3XKE7/Jcrs9K1NfT/amdoQKdBVutC4GKqb7QUyoaeTA1vZ9TRaFbgL
         H+IQhj67fZXESWOaI1HNczXzxaus4x1+AhU3NAOWpRhiVvXCKW0kdNU3zPhfNMdmKi/r
         vNcvfo+VLshiwL/nLuV3fZpZwFVE4Q+Nbj2h1PKVWa1MdgLuLwgyA3IDX+OW/zXHZDuv
         jd+q8z+Z1fU9L+A1iGmlLGCZa8tg69J92TJmfNwszu4ytbahjWTaKxjbca9ZRxSPrE2l
         I38g67W3nXOf+40hLNX4qsvqNt8fxSdjUArBQe1Ea+62qjIwTos/SyVsIogTXS/hnIVr
         qKBg==
X-Gm-Message-State: APjAAAXdADmwAsjmQgFvPuO3MZHU9YTU3I6ypCilcXkDB6TvTZetPDDH
        IWOd34q3fIRxqTY4/bnvdxefrc2O1fI=
X-Google-Smtp-Source: APXvYqwIRLc56ja7jxENUpnpvsOU7HSYYmyWRXh9i3uc7LYnLGFEchZR3Vr5lLiTGYga+EM5SVyMcQ==
X-Received: by 2002:a92:381c:: with SMTP id f28mr5887747ila.169.1571755636078;
        Tue, 22 Oct 2019 07:47:16 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id d2sm3458566iob.22.2019.10.22.07.47.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:47:15 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id l12so15677813ilq.4
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2019 07:47:15 -0700 (PDT)
X-Received: by 2002:a92:1e03:: with SMTP id e3mr8267234ile.168.1571755634923;
 Tue, 22 Oct 2019 07:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com> <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
In-Reply-To: <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Oct 2019 07:47:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
Message-ID: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 21, 2019 at 11:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > The problem I see here is that callers of this reset function aren't
> > expecting it to work this way.  Look specifically at
> > mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> > things like shutdown / reinit.  Now it's true that the old
> > mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> > also had SDIO bluetooth, but presumably it worked OK on systems
> > without SDIO Bluetooth.  I don't think it'll work so well now.
>
> Good point!
>
> I guess I was hoping that running through ->remove() and then
> ->probe() for the SDIO func drivers should simply take care of
> whatever that may be needed. In some way this makes the driver broken
> already in regards to this path, but never mind.

Yeah, probably true.  I guess if anyone actually expected to use one
of these cards as a removable SDIO card (I have seen such dev boards
long ago) then it would always have been possible for someone to
remove the card at just the wrong time and break things.


> > Testing shows that indeed your patch breaks mwifiex reset worse than
> > it was before (AKA WiFi totally fails instead of it just killing
> > Bluetooth).
> >
> > I think it may be better to add a new API call rather than trying to
> > co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> > make people move away from it, or something?
>
> Thanks again for testing and for valuable feedback! Clearly this needs
> a little more thinking.
>
> An additional concern I see with the "hotplug approach" implemented in
> $subject patch, is that it becomes unnecessary heavy when there is
> only one SDIO func driver bound.
>
> In one way I am tempted to try to address that situation, as it seems
> a bit silly to do full hotplug dance when it isn't needed.

True, though I kinda like the heavy solution here.  At least in the
mwifiex case this isn't a part of the normal flow.  AKA: we don't call
this function during normal bootup nor during any normal operations.
It's much more of an "oh crap, something's not working and we don't
know what to do" type solution.  I mean, I guess it's still not
uncommon that we end up in this code path due to the number of bugs in
Marvell firmware, but I'm just trying to say that it's an error code
path and not a normal one.  In my mind that means the more things we
can re-init the better.

If this was, on the other hand, a reset that we were supposed to
always assert when doing a normal operation (like it wants us to reset
it when we switch modes, or something) then a lighter operation would
make more sense.

-Doug
