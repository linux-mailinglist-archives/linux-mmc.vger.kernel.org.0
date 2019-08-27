Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACA9EF78
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfH0PzO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 11:55:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43828 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0PzN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 11:55:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so31956665edq.10
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Qk1xF8/1QWrO06a7YwbZsCoQo0yycShHqyCI513rzs=;
        b=Bfgwj8BDwdJem8igncpIxLAqu0ghBJtCnATYLMWOj5bgkU0DUlsUSeRqtbw5KXzkhM
         TEzIl+h+HAPMecBLJ4vruap72KD6ZES6jNva40GCTSYDVOxBIH7cpv6o+kYwWq2Z+agK
         kTCKycDUGfRFRhNl9DB2yzAZhce/vH3r25T2ecdUp7Qax7rLyfMVvHPJmKZjmcN/wjZK
         ywaphnyvx2ET71i7tSmh8chUZc4pSwNpjAbl8LB8y/HJu8MJnPcO1HySo87lF8b68EzG
         6zx6HZhdDBoOlbaS9WmOTnSHVPA4Tn//iFVCURQ0johVudQvJtikCY2XauEj1jA/ycvf
         /gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Qk1xF8/1QWrO06a7YwbZsCoQo0yycShHqyCI513rzs=;
        b=RZE0HOiSX8uLd0z+XJfoZxACQFsSvzTzJlX/TkPALBOmfzFicTdwdWYa5eDK4CxYtS
         /xICavMTWlIab0wWOuNZhWL6USCrqlll0aaJpiMTDk4UYMDEA1gy49diOvctuQIE2wy9
         GVObt3RApyWvNIVQsydTUqUvJrhDNPF+8HeGXECsk8X+jtMtFRYB9gHKVdZphfYs07wU
         f9QmQy2Hn7pA9G8ZN5Dm2G+PAeOzFTg/4uEAXz0wcGVa3WLGpDRoET9AgFu2hxcqU9TG
         3wZM6RDZWGKX4GxdZJeXOW9kZJfYKEHBS5YPQ48z2w+tEV6N4HJ/YD8F7kaKF7sMm/rh
         Jo/w==
X-Gm-Message-State: APjAAAWdbhdVAbenwCQmSlGzXT3iAgumn7e2ZpolGJpDniC761ldarKL
        7LCKoweUHczShbDpb5R4KxsPWsOXItodtTrNqd+4ewgr
X-Google-Smtp-Source: APXvYqxqQBLLTEX1plhJNHElCRDFhQPbxHT6oPvFyw4u4vGTEA4JoKF3ddWCP2yCABE7H3TywleG992hWik7HK375qI=
X-Received: by 2002:a17:906:4d87:: with SMTP id s7mr22314510eju.155.1566921311752;
 Tue, 27 Aug 2019 08:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
 <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
 <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com> <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com>
In-Reply-To: <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com>
From:   Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Tue, 27 Aug 2019 17:55:00 +0200
Message-ID: <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
> >
> > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.hansson@li=
naro.org> napsal:
> > >
> > > + some meson driver folkz
> > >
> > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.com> wr=
ote:
> > > >
> > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@lin=
aro.org> napsal:
> > > > >
> > > > > + Chaotian Jing
> > > > >
> > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> > > > > >
> > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > > > >
> > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> > > > > >
> > > > > > Turns out the patch breaks initialization of Toshiba THGBMNG5.
> > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > > > [    1.648988] mmc0: error -84 whilst initialising MMC card
> > > > >
> > > > > For exactly this reason, when getting CRC errors on the first att=
empt,
> > > > > doing a retry makes little sense.
> > > > >
> > > > > I have looped in Chaotian who has some more details about the pro=
blem.
> > > > >
> > > > > In any case, Jan, what HW and mmc controller are you using?
> > > >
> > > > It's a custom board based on Amlogic A113D. The compatibility in dt=
s
> > > > is set to "alogic,meson-axg-mmc".
> > >
> > > Good. I have looped in some of the relevant developers/maintainers.
> > >
> > > >
> > > > In the different revision of HW we are using Kingston EMMC04G. The
> > > > card has no such problem and is working fine without this patch.
> > > > We observed it only on mention Toshiba card.
> > >
> > > I see. Of course it would also be interesting to see what CMD6 comman=
d
> > > that is that fails. Would you mind adding some debug/trace to find ou=
t
> > > what command it is that fails?
> >
> > Providing a log with following debug option  `dyndbg=3D"func mmc_mrq_pr=
_debug +p`
>
> Thanks!
>
> >
> > # dmesg | grep mmc0
> > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
> > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
> > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
> > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
> > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
> > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
> > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
> > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
> > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
> > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms n=
sac 0
> > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
> > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
> > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
> > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
> > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
> > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms n=
sac 0
> > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
> > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
> > [    1.868892] mmc0: error -84 whilst initialising MMC card
>
> Alright, so the CMD6 command that tries to switch the card into HS200
> mode is the one that fails.
>
> >
> > I cannot provide more verbose logs. When I enable more it (f.e. file
> > core.c) the initialization of card was successful.
>
> That's an interesting observation!
>
> Perhaps the card is still in some kind of busy state, after the CMD8
> has been sent to read the EXT_CSD, when verifying the earlier bus
> width switch (mmc_compare_ext_csds()).

I'm curious, do you know if there is a command that says if the card
is busy/ready?

>
> > If you want to see any another logs fell free to ask.
>
> Would you mind trying one thing, in a way to narrow down the problem?
>
> Add a delay (msleep() or usleep_range() with some different values up
> to 50 ms) somewhere after mmc_compare_ext_csds() has been executed,
> but also before having mmc_select_bus_width() to return the error
> code?

I've added msleep just before exit point of mmc_select_bus_width() and
observation is following
* 1ms or 2 ms - failing (time to time it was successfully initialized)
* 5 ms - success in all attempts

Best regards,
Jan

>
> Kind regards
> Uffe
