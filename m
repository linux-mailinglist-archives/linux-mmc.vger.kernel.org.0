Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE6A0020
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Aug 2019 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1KpV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Aug 2019 06:45:21 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40707 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1KpV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2019 06:45:21 -0400
Received: by mail-vs1-f68.google.com with SMTP id i128so1517824vsc.7
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2019 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o+xrSlt5Kh0C3lpbOcjkSvTMU466Hl/PMz9rxck7blI=;
        b=tRpQI197XB+4tMvBnbenKIhncyuaVhy7mvK/rbhaxj5NxBKRLiE9JQcXblIFjK7vT1
         uRghSGNKv5LoqfRT6Ql3emIoffrK4M2JYKCiD9QHGBwXrMWcdrsWEmYTE3jVsmisA/G2
         GYLX8FMc7uOtT6ATuOQIDEkHxRzMfXv3KannjCEm7oskZGQsO9zXwbDbjCcjxHlys1vl
         OoB6BWU60QtCwkPPeyilqdEMIN+FP9ZuJfgdxUUhjLi60Ine/tMXhz+0RRJufwE7Ncib
         FrphWGU8PZF82l8DTLaD0ZPyeJ0z1ia/otIZcUIClOgh6dCX22wq8ktXXap+xt8z7Rfp
         M/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o+xrSlt5Kh0C3lpbOcjkSvTMU466Hl/PMz9rxck7blI=;
        b=NPdLyuDFkr9ABsE5cnwtkqxvmyJ3472PRpjCkRXzOtsFQ0vg6r478WFeS7QgBT7kTq
         99CgN+Z8jkv3YVgh5Oa6uXxjhlgOSwq5hhe59pZdR5J0uxlMA0futEV4f6A01E/I52Zz
         lbNDXTlYz4VcJkd4Pe7ynFyteZN/LolTTPBdMXomteRJvtSNe9CMJ5ZZSGGWCXQc6Dx3
         ugcE1Le7SwSDvggRjAZzqGeo3fTCmcRebrvygtwfhFguqdkAtJDQsNVHlmh2E6tQbryQ
         yp91EuSRAwgw946VtQtkhE3zDOTjbpMOENu4c+yYbQMAgHKLE7GmzOORKQ/BGA+Y3b7r
         Oj0A==
X-Gm-Message-State: APjAAAX3D51bS2P+icuUjtm7TLF8qlqcpViOg+7LHBvLFiIOYNBHQAQE
        GTzUmklvGxS/u345GWqcgk83xSgaGprZ+ItHbnRrscpu
X-Google-Smtp-Source: APXvYqyu77jdbOmIUfwGAlidVRH14Wk9RGAQea5SkMpiT1mS6rTeqNiVdbW4aODZk9/D3j13752tysZPcoFtD2mrWwY=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr1846173vsy.191.1566989119758;
 Wed, 28 Aug 2019 03:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
 <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
 <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
 <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com> <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com>
In-Reply-To: <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Aug 2019 12:44:43 +0200
Message-ID: <CAPDyKFpatR0q+uO4Q-xcfAWVRTnc3Wp+_oDqECepk_FiLM1kBQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     Jan Kaisrlik <ja.kaisrlik@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 17:55, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
>
> On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >
> > On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrot=
e:
> > >
> > > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.hansson@=
linaro.org> napsal:
> > > >
> > > > + some meson driver folkz
> > > >
> > > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.com> =
wrote:
> > > > >
> > > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@l=
inaro.org> napsal:
> > > > > >
> > > > > > + Chaotian Jing
> > > > > >
> > > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > > > > >
> > > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> > > > > > >
> > > > > > > Turns out the patch breaks initialization of Toshiba THGBMNG5=
.
> > > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > > > > [    1.648988] mmc0: error -84 whilst initialising MMC card
> > > > > >
> > > > > > For exactly this reason, when getting CRC errors on the first a=
ttempt,
> > > > > > doing a retry makes little sense.
> > > > > >
> > > > > > I have looped in Chaotian who has some more details about the p=
roblem.
> > > > > >
> > > > > > In any case, Jan, what HW and mmc controller are you using?
> > > > >
> > > > > It's a custom board based on Amlogic A113D. The compatibility in =
dts
> > > > > is set to "alogic,meson-axg-mmc".
> > > >
> > > > Good. I have looped in some of the relevant developers/maintainers.
> > > >
> > > > >
> > > > > In the different revision of HW we are using Kingston EMMC04G. Th=
e
> > > > > card has no such problem and is working fine without this patch.
> > > > > We observed it only on mention Toshiba card.
> > > >
> > > > I see. Of course it would also be interesting to see what CMD6 comm=
and
> > > > that is that fails. Would you mind adding some debug/trace to find =
out
> > > > what command it is that fails?
> > >
> > > Providing a log with following debug option  `dyndbg=3D"func mmc_mrq_=
pr_debug +p`
> >
> > Thanks!
> >
> > >
> > > # dmesg | grep mmc0
> > > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
> > > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
> > > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
> > > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
> > > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
> > > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
> > > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
> > > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
> > > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
> > > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms=
 nsac 0
> > > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
> > > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
> > > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> > > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms=
 nsac 0
> > > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
> > > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
> > > [    1.868892] mmc0: error -84 whilst initialising MMC card
> >
> > Alright, so the CMD6 command that tries to switch the card into HS200
> > mode is the one that fails.
> >
> > >
> > > I cannot provide more verbose logs. When I enable more it (f.e. file
> > > core.c) the initialization of card was successful.
> >
> > That's an interesting observation!
> >
> > Perhaps the card is still in some kind of busy state, after the CMD8
> > has been sent to read the EXT_CSD, when verifying the earlier bus
> > width switch (mmc_compare_ext_csds()).
>
> I'm curious, do you know if there is a command that says if the card
> is busy/ready?

Yes, the CMD13.

However, CMD13 is not allowed to be sent for some command sequences.
For example sending CMD6 to switch to HS200 mode, is one case where we
must avoid it.

For these scenarios, either we rely on the host HW to detect when the
card stop signals busy or we simply insert a delay (according to spec)
after sending the CMD6 command.

>
> >
> > > If you want to see any another logs fell free to ask.
> >
> > Would you mind trying one thing, in a way to narrow down the problem?
> >
> > Add a delay (msleep() or usleep_range() with some different values up
> > to 50 ms) somewhere after mmc_compare_ext_csds() has been executed,
> > but also before having mmc_select_bus_width() to return the error
> > code?
>
> I've added msleep just before exit point of mmc_select_bus_width() and
> observation is following
> * 1ms or 2 ms - failing (time to time it was successfully initialized)
> * 5 ms - success in all attempts

Very good!

Let me post a debug patch in short while, that can try to verify if
the card is busy during this period.

Kind regards
Uffe
