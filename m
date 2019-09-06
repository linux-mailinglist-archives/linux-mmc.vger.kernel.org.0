Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C707EAB88D
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404849AbfIFM5u (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 08:57:50 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39925 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbfIFM5u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 08:57:50 -0400
Received: by mail-vs1-f43.google.com with SMTP id y62so3966295vsb.6
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/neCd8bf2woHKxcIZzIPGUCLtuWSKibDQve29iKSewU=;
        b=kx4yXaHIEuVXRh30IAn7HfnEIEKQTLky2E3b9BlMEALM/RHF0DBf/IjXvSPPrQwcHS
         XjIPWuVRK/xj1HAJCWb29yDAs0mdcD6MYI7B26HY52+2vlgktPIdl12hNoef1RsOeocn
         dKWvNnwkL0B8ykjElJtOg9OzCb8w2PB9qIZCEo3Ca69cC4q5oeHCtyjYpgfoKYgsj9rz
         43+0Ql5+Kt4hJzjOckOR4jC8RJRIQSy+VPxSPoB3DmqgiVY3y4L2M1+UPRyCMM/PoHMh
         f5zkMEDblJbXrmWTKohPSqU6IwPQKJuShm+rMwqypRsDXRvo/AQYtK1DE0qkynSUx4sh
         JWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/neCd8bf2woHKxcIZzIPGUCLtuWSKibDQve29iKSewU=;
        b=sK5UDX0HONpfZsL6iYiD7X2iENcpX6IAH/GaDvsvFE6TL42No5YRg3UIHToybHEPot
         2gCq090Guwd0INNq5AAjG+I+4LSD0I+dFyD5t9TJqLejBwU9yB+IyojXEqidVC15n5Y0
         DyPm31VNjNIovufjGk9R81p0cd203rGCi/0E+L6g2/ehwQIsvqOMfO3k0phRcAt23Wut
         9N3bufWPKgZ0R4KhzhktU/4DVmjtcGBa/dWP1A2W7D/wKZCCyX1J3wcV/9KVPIBtCUYv
         JI3o1lAYFQIazX5xTjF4y1Tl5V2JeuE0O0+ZVkSnV523939f/Y0+Yky50PlEPgRQb1Re
         NEWg==
X-Gm-Message-State: APjAAAVqbIlfJD1mE62h1YbDPGPMSpuJFNaDncEqkU5PevoHTgYjBraR
        +oqyhn8o7UdqcfxAqLi2ZgXIccqs1UaEjAgULxTFXQ==
X-Google-Smtp-Source: APXvYqypQjrW9iyIEp62I8bWuxJPwQ43tr/W0/rhyH2tO2VWRlNHbi4m47UGxoSI3wqx4sL3MAEWYdRUbDhvv44LXcc=
X-Received: by 2002:a67:347:: with SMTP id 68mr4813081vsd.35.1567774668896;
 Fri, 06 Sep 2019 05:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
 <CAPDyKFo5E3a0w6YKReMNrU_Z1td6jTbgKH-d+shOynhyPsGGHA@mail.gmail.com> <CAAfyv34JHtLHRrCnF-5qg+odUvy_2PqRFfXwYK3xjDSN9TA7gg@mail.gmail.com>
In-Reply-To: <CAAfyv34JHtLHRrCnF-5qg+odUvy_2PqRFfXwYK3xjDSN9TA7gg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 14:57:12 +0200
Message-ID: <CAPDyKFoU5zVEKRmbR-uJPdKpJJKW51BJG1k1DsdxAareEu2Nbg@mail.gmail.com>
Subject: Re: slow emmc speed 4.12 am437x
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 14:26, Belisko Marek <marek.belisko@gmail.com> wrote:
>
> On Fri, Sep 6, 2019 at 2:19 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 6 Sep 2019 at 11:14, Belisko Marek <marek.belisko@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I'm trying to get some insights about how to debug emmc speed issue.
> > > We're using board with am437x CPU using mainline 4.12 kernel (added
> > > only devicetree for our custom board). eMMC is 8bit connect (using
> > > sandisk SDINBDG4-8G-I1 chip).
> > >
> > > Issue is that when copying data from SD card to eMMC we get throughput
> > > only ~300kB/s (it should be bit higher IIRC). I'm just looking for
> > > some advice what to check and how to find out where issue can be
> > > (still unsure if SW or HW). Thanks a lot.
> >
> > Mount debugfs and look at the ios node for the mmc host in question.
> > There is information about clocks, busdwidth, etc.
> Thanks for info. From below it looks quite ok:
> clock:          52000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    1 (mmc high-speed)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>
> compared to gumstix poblano (same cpu):
> cat /sys/kernel/debug/mmc1/ios
> clock:          50000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    2 (sd high-speed)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>
> difference is in bus width (I'm confused as poblano according dts +
> schematics should also have 8 bit interface) and timing spec are
> different for my case. Anything else I can check? Thanks.

This looks fine to me. I think you need to do some deeper debug to
find out what the issue is, sorry for not being able to help any more
than this.

Of course you already tried reading/writing to the eMMC and SD
independently, so you have a reference of the throughput values?

Kind regards
Uffe
