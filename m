Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2603A3820
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfH3NyW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 09:54:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3NyV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 09:54:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so7044550wrn.10
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=txMaW8bL1+pAE5fY1OYmFsdua7JMNIhgWXK5pjkrEok=;
        b=TXv98AVd5uaqwhAwPqu6tsvUGwMtEVlNRNwQb9FphRU9E9X+6v0RVF4gEQV/zpuWbM
         rZiSjUXBkfGhfn4M17bWk7ad2tg/CcewBwda1nFF+LoeWIvb1OUF5so5fww1SPR77tH3
         /5PuGbUo6Qa8qLu0WWra0wr0qvTWHkD8Uh8YQx+RKW9JGRssuQb+cA7BgUHJTGNroCBg
         sDr55AEwokWLnBCdsL4CPrrRZJ+EjupiRtjTVFBhaZLYC03GUXAx+4lon2NZoHt/K6yM
         zv4WftmJCqm2ZvMNPSAXeBjmVm04GyIaCqe7osUcKM3dsM+P8vDdPODYJJq5wCgLgtAP
         XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=txMaW8bL1+pAE5fY1OYmFsdua7JMNIhgWXK5pjkrEok=;
        b=op/Ue70cz4QUOdmWmnDLOkKN65Hg/7hOavfEND9pjAuXwL+0yEMJ9cs2TsGdjpsG/g
         2V4rofwXowp0/ryjxaI/n9YZqKXxw51HLTpwzLtWLsRiTXYkxtGYr3olNU49xkI/kV28
         WsNU0HrYJeFeu5iBh7mSyqIr8wFxm9AlNMxgjffFRNbHjLm3Kob1rAQATF4EJxVZRDxM
         2VtPXX0+iaI5crzgpiq3IT4c1Esj0ie+WpHGhJonVJmw+BQPrv9GnAymK34q/LHPVLc/
         g+jiaa9B5hxKOx7RxiyevLBRjdHw3ar/IaNKUrzCZQN1cn/Sg2Zo+B9vBuTShFLi4y/4
         6ytQ==
X-Gm-Message-State: APjAAAXXH/IFpUP94Zt521WZH020vGG7oG8IZNo4sFqtfthmLpa2buqx
        OSMh8behztY/pDOPAwKDXhN06w==
X-Google-Smtp-Source: APXvYqxeItqx4k7HocdpeopEAB8EMWPW6NI+g8tmGz1IBdSrvfgfgf57jcq+W2x9IFYI8j5rbO4PKA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr18220505wrm.2.1567173257905;
        Fri, 30 Aug 2019 06:54:17 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p10sm7069715wma.8.2019.08.30.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 06:54:17 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jan Kaisrlik <ja.kaisrlik@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
In-Reply-To: <CAPDyKFqwhWSFdXDxAodW1iM4_qebPVdZ5TxVCRsTn2dW7WQjBA@mail.gmail.com>
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com> <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com> <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com> <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com> <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com> <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com> <CAPDyKFpatR0q+uO4Q-xcfAWVRTnc3Wp+_oDqECepk_FiLM1kBQ@mail.gmail.com> <CAPDyKFrHvgcXy5PnsiOD=Oo09JNTM2uQ6BCTzhMNsFu=f7V7RA@mail.gmail.com> <CAPnxhu53o=MB9NuXrVKB_WzvsLTbBByj7z_M6wFuQzas4FQrSQ@mail.gmail.com> <CAPDyKFqwhWSFdXDxAodW1iM4_qebPVdZ5TxVCRsTn2dW7WQjBA@mail.gmail.com>
Date:   Fri, 30 Aug 2019 15:54:16 +0200
Message-ID: <1jv9uevjw7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 30 Aug 2019 at 13:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Fri, 30 Aug 2019 at 12:01, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
>>
>> On Thu, Aug 29, 2019 at 9:50 AM Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>> >
>> > On Wed, 28 Aug 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>> > >
>> > > On Tue, 27 Aug 2019 at 17:55, Jan Kaisrlik <ja.kaisrlik@gmail.com> w=
rote:
>> > > >
>> > > > On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>> > > > >
>> > > > > On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.co=
m> wrote:
>> > > > > >
>> > > > > > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.h=
ansson@linaro.org> napsal:
>> > > > > > >
>> > > > > > > + some meson driver folkz
>> > > > > > >
>> > > > > > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmai=
l.com> wrote:
>> > > > > > > >
>> > > > > > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.ha=
nsson@linaro.org> napsal:
>> > > > > > > > >
>> > > > > > > > > + Chaotian Jing
>> > > > > > > > >
>> > > > > > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wr=
ote:
>> > > > > > > > > >
>> > > > > > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
>> > > > > > > > > >
>> > > > > > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281=
c35f1a.
>> > > > > > > > > >
>> > > > > > > > > > Turns out the patch breaks initialization of Toshiba T=
HGBMNG5.
>> > > > > > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
>> > > > > > > > > > [    1.648988] mmc0: error -84 whilst initialising MMC=
 card
>> > > > > > > > >
>> > > > > > > > > For exactly this reason, when getting CRC errors on the =
first attempt,
>> > > > > > > > > doing a retry makes little sense.
>> > > > > > > > >
>> > > > > > > > > I have looped in Chaotian who has some more details abou=
t the problem.
>> > > > > > > > >
>> > > > > > > > > In any case, Jan, what HW and mmc controller are you usi=
ng?
>> > > > > > > >
>> > > > > > > > It's a custom board based on Amlogic A113D. The compatibil=
ity in dts
>> > > > > > > > is set to "alogic,meson-axg-mmc".
>> > > > > > >
>> > > > > > > Good. I have looped in some of the relevant developers/maint=
ainers.
>> > > > > > >
>> > > > > > > >
>> > > > > > > > In the different revision of HW we are using Kingston EMMC=
04G. The
>> > > > > > > > card has no such problem and is working fine without this =
patch.
>> > > > > > > > We observed it only on mention Toshiba card.
>> > > > > > >
>> > > > > > > I see. Of course it would also be interesting to see what CM=
D6 command
>> > > > > > > that is that fails. Would you mind adding some debug/trace t=
o find out
>> > > > > > > what command it is that fails?
>> > > > > >
>> > > > > > Providing a log with following debug option  `dyndbg=3D"func m=
mc_mrq_pr_debug +p`
>> > > > >
>> > > > > Thanks!
>> > > > >
>> > > > > >
>> > > > > > # dmesg | grep mmc0
>> > > > > > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
>> > > > > > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
>> > > > > > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
>> > > > > > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
>> > > > > > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
>> > > > > > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> > > > > > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> > > > > > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> > > > > > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> > > > > > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
>> > > > > > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
>> > > > > > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
>> > > > > > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
>> > > > > > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
>> > > > > > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
>> > > > > > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
>> > > > > > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
>> > > > > > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
>> > > > > > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
>> > > > > > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
>> > > > > > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
>> > > > > > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsa=
c 50 ms nsac 0
>> > > > > > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
>> > > > > > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
>> > > > > > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
>> > > > > > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
>> > > > > > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
>> > > > > > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
>> > > > > > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
>> > > > > > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsa=
c 50 ms nsac 0
>> > > > > > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
>> > > > > > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
>> > > > > > [    1.868892] mmc0: error -84 whilst initialising MMC card
>> > > > >
>> > > > > Alright, so the CMD6 command that tries to switch the card into =
HS200
>> > > > > mode is the one that fails.
>> > > > >
>> > > > > >
>> > > > > > I cannot provide more verbose logs. When I enable more it (f.e=
. file
>> > > > > > core.c) the initialization of card was successful.
>> > > > >
>> > > > > That's an interesting observation!
>> > > > >
>> > > > > Perhaps the card is still in some kind of busy state, after the =
CMD8
>> > > > > has been sent to read the EXT_CSD, when verifying the earlier bus
>> > > > > width switch (mmc_compare_ext_csds()).
>> > > >
>> > > > I'm curious, do you know if there is a command that says if the ca=
rd
>> > > > is busy/ready?
>> > >
>> > > Yes, the CMD13.
>> > >
>> > > However, CMD13 is not allowed to be sent for some command sequences.
>> > > For example sending CMD6 to switch to HS200 mode, is one case where =
we
>> > > must avoid it.
>> > >
>> > > For these scenarios, either we rely on the host HW to detect when the
>> > > card stop signals busy or we simply insert a delay (according to spe=
c)
>> > > after sending the CMD6 command.
>> > >
>> > > >
>> > > > >
>> > > > > > If you want to see any another logs fell free to ask.
>> > > > >
>> > > > > Would you mind trying one thing, in a way to narrow down the pro=
blem?
>> > > > >
>> > > > > Add a delay (msleep() or usleep_range() with some different valu=
es up
>> > > > > to 50 ms) somewhere after mmc_compare_ext_csds() has been execut=
ed,
>> > > > > but also before having mmc_select_bus_width() to return the error
>> > > > > code?
>> > > >
>> > > > I've added msleep just before exit point of mmc_select_bus_width()=
 and
>> > > > observation is following
>> > > > * 1ms or 2 ms - failing (time to time it was successfully initiali=
zed)
>> > > > * 5 ms - success in all attempts
>> > >
>> > > Very good!
>> > >
>> > > Let me post a debug patch in short while, that can try to verify if
>> > > the card is busy during this period.
>> >
>> > Here it is, please give it a try and see what happens.
>> >
>> > You may also want to run a second test, changing the second parameter
>> > to false when calling poll_for_busy(), as that switches from CMD13 to
>> > use of the host driver's ->card_busy() callback, when checking for
>> > busy.
>>
>> I've applied the patch and test poll_for_busy() with different
>> send_status parameter as you recommend (true/false).
>> The outputs are the same
>> [    1.526554] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
>> [    1.682886] mmc0: mmc_select_hs200 failed, error -84
>> [    1.693081] mmc0: error -84 whilst initialising MMC card
>
> Alright, my guess that the card was busy was solely incorrect.
>
>>
>> >
>> > Kind regards
>> > Uffe
>> >
>> > From: Ulf Hansson <ulf.hansson@linaro.org>
>> > Date: Thu, 29 Aug 2019 09:42:11 +0200
>> > Subject: [PATCH] mmc: core: DEBUG for mmc_select_bus_width()
>> >
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> > ---
>> >  drivers/mmc/core/mmc.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 47 insertions(+)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index c8804895595f..ff3a4c166f20 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -975,6 +975,52 @@ static void mmc_set_bus_speed(struct mmc_card *ca=
rd)
>> >         mmc_set_clock(card->host, max_dtr);
>> >  }
>> >
>> > +static void poll_for_busy(struct mmc_card *card, bool send_status)
>> > +{
>> > +       struct mmc_host *host =3D card->host;
>> > +       int err;
>> > +       unsigned long timeout;
>> > +       unsigned int timeout_ms =3D 5000;
>> > +       u32 status =3D 0;
>> > +       bool expired =3D false;
>> > +       bool busy =3D false;
>> > +
>> > +       if (!send_status && !host->ops->card_busy) {
>> > +               mmc_delay(timeout_ms);
>>
>> fyi this code hasn't been executed.
>
> Yeah, thanks, expected.
>
>>
>> > +               return;
>> > +       }
>> > +
>> > +       timeout =3D jiffies + msecs_to_jiffies(timeout_ms) + 1;
>> > +       do {
>> > +               expired =3D time_after(jiffies, timeout);
>> > +               if (send_status) {
>> > +                       err =3D __mmc_send_status(card, &status, 0);
>>
>> I've added some print here as well to see whats the value of the status
>>
>> +                       printk("%s: %s status=3D0x%x
>> R1_CURRENT_STATE(status)=3D0x%x \n",
>> +                               mmc_hostname(host),__func__, status,
>> R1_CURRENT_STATE(status));
>
> Great!
>
>>
>> [    1.676970] mmc0: poll_for_busy status=3D0x900 R1_CURRENT_STATE(statu=
s)=3D0x4
>
> This means the card reports that it's "READY_FOR_DATA" and the current
> state is the transfer state.
>
> Nothing weird is going on at card side, it seems.
>
>> [    1.685821] mmc0: mmc_select_hs200 failed, error -84
>> [    1.698029] mmc0: error -84 whilst initialising MMC card
>
> I am out of ideas. :-(
>
> Perhaps the meson developers can think of something? Could it be that
> the driver isn't behaving as it should when switching bus width? Maybe
> something happens on pinctrl level?

I have not seen this particular issue myself. Since the last round of
updates we did a few month ago, things have been quite stable

We get our information only from the datasheet and vendor code. These
are publicly available and it has proved quite insufficient judging by
the number of issue we had in the past years.

IOW, we would love to know more about this controller too ;)

So, to answer your question, AFAIK, there is nothing special regarding
bus width switch ...

Regarding pinctrl, I think there a bias-pull-up on data line set in DT.
Maybe it's worth trying to disable that a see how it goes ?

OTOH, it this was the problem, I wonder how it could have got this far
and why a delay would help ?

>
> Anyway, if no progress is made the next few days, let's do the revert.
> And thanks a lot for helping out with the tests, etc!
>
> Kind regards
> Uffe
