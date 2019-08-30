Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17F2A3567
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfH3LIb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 07:08:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45728 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfH3LIb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 07:08:31 -0400
Received: by mail-ua1-f67.google.com with SMTP id j6so2160904uae.12
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CSQBhJvANYsAiX9WS3f40frVxwxaLfzODJKkSq4Q84s=;
        b=UVtIb/FnG8AO2mpTlksUrExLFCuuWrKHejYqBR7X4CwyiUVyLU3M6eONIFfEeVPyQm
         Qjdum4QsnftQY18dHGEaRf5xivQUxodG+rghrKr0BHxgictOGpsNoPDNVMrSXlNMyD4A
         U8n8psYSgyFdtTFPSL7em+mmB/qdqwFmGq7yjS3H0gFTD/XA+bw1uQscY/bTnIV3UKfA
         Zg8J63R9ip0gmu4SNcYN1PHEi6obb3Ldw8mDLDCDS3MmGJ+cQum2XZoo5TUTAWsFR15/
         lIt8RiJHiCv86YR9U8CcREqii4NtAI0cvFh2ETdNQ/MTpH1BOb42VQZytONEZ36P2//r
         ePQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CSQBhJvANYsAiX9WS3f40frVxwxaLfzODJKkSq4Q84s=;
        b=kIIlZYk7LIFXsMN4yu/QeONnq/im+WQEq+KOxQHVhCNnwRlv6qLiZkjAQlFzgnl9r3
         QN3bTCNNZpOTwdWIZiiuE9R1CI51Oaj3ZLfFIbqxeX3crARQslLhc16FTQCPbaJ5kBw9
         r2lKQnQkCgc7CfShm5j8GefL3KMMkIk+4WsJ1fCty6x2uhuCKqm42f/4XBllhM4660Bs
         aR5e63Yei90zZQGFkmiapLh2N3PVwf49iTyPIIqvlR+0I0KH73kAHKoJSIGryGlXHUmN
         7WlctkqfwYMpsnC2pWorojOWNgB+/Zuch+ctwiRwYeCXyqRk5SOKqxhhr4sHcRJ8o00V
         qqzQ==
X-Gm-Message-State: APjAAAW7/yi/W3Efv1do9b58ICe2v5itczFWaQmQakmB9pG0m+2sDE7l
        vVV237SJvQVTEjitTYRNJ9LY0tJBfH0yneVuzJWkmw==
X-Google-Smtp-Source: APXvYqyShiiL7KsFahEurCeKFg1FRHyRkZr/ZVWCOjvR7DERwmGOM0/0vsDLXafHgGAzHZJbw4P8s4DntpVmtfq7C3c=
X-Received: by 2002:ab0:15e9:: with SMTP id j38mr3011730uae.19.1567163309499;
 Fri, 30 Aug 2019 04:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
 <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
 <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
 <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com>
 <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com>
 <CAPDyKFpatR0q+uO4Q-xcfAWVRTnc3Wp+_oDqECepk_FiLM1kBQ@mail.gmail.com>
 <CAPDyKFrHvgcXy5PnsiOD=Oo09JNTM2uQ6BCTzhMNsFu=f7V7RA@mail.gmail.com> <CAPnxhu53o=MB9NuXrVKB_WzvsLTbBByj7z_M6wFuQzas4FQrSQ@mail.gmail.com>
In-Reply-To: <CAPnxhu53o=MB9NuXrVKB_WzvsLTbBByj7z_M6wFuQzas4FQrSQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 13:07:51 +0200
Message-ID: <CAPDyKFqwhWSFdXDxAodW1iM4_qebPVdZ5TxVCRsTn2dW7WQjBA@mail.gmail.com>
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

On Fri, 30 Aug 2019 at 12:01, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 9:50 AM Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >
> > On Wed, 28 Aug 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > >
> > > On Tue, 27 Aug 2019 at 17:55, Jan Kaisrlik <ja.kaisrlik@gmail.com> wr=
ote:
> > > >
> > > > On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> > > > >
> > > > > On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.com=
> wrote:
> > > > > >
> > > > > > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.ha=
nsson@linaro.org> napsal:
> > > > > > >
> > > > > > > + some meson driver folkz
> > > > > > >
> > > > > > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail=
.com> wrote:
> > > > > > > >
> > > > > > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.han=
sson@linaro.org> napsal:
> > > > > > > > >
> > > > > > > > > + Chaotian Jing
> > > > > > > > >
> > > > > > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wro=
te:
> > > > > > > > > >
> > > > > > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > > > > > > > >
> > > > > > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c=
35f1a.
> > > > > > > > > >
> > > > > > > > > > Turns out the patch breaks initialization of Toshiba TH=
GBMNG5.
> > > > > > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > > > > > > > [    1.648988] mmc0: error -84 whilst initialising MMC =
card
> > > > > > > > >
> > > > > > > > > For exactly this reason, when getting CRC errors on the f=
irst attempt,
> > > > > > > > > doing a retry makes little sense.
> > > > > > > > >
> > > > > > > > > I have looped in Chaotian who has some more details about=
 the problem.
> > > > > > > > >
> > > > > > > > > In any case, Jan, what HW and mmc controller are you usin=
g?
> > > > > > > >
> > > > > > > > It's a custom board based on Amlogic A113D. The compatibili=
ty in dts
> > > > > > > > is set to "alogic,meson-axg-mmc".
> > > > > > >
> > > > > > > Good. I have looped in some of the relevant developers/mainta=
iners.
> > > > > > >
> > > > > > > >
> > > > > > > > In the different revision of HW we are using Kingston EMMC0=
4G. The
> > > > > > > > card has no such problem and is working fine without this p=
atch.
> > > > > > > > We observed it only on mention Toshiba card.
> > > > > > >
> > > > > > > I see. Of course it would also be interesting to see what CMD=
6 command
> > > > > > > that is that fails. Would you mind adding some debug/trace to=
 find out
> > > > > > > what command it is that fails?
> > > > > >
> > > > > > Providing a log with following debug option  `dyndbg=3D"func mm=
c_mrq_pr_debug +p`
> > > > >
> > > > > Thanks!
> > > > >
> > > > > >
> > > > > > # dmesg | grep mmc0
> > > > > > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
> > > > > > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
> > > > > > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > > > > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
> > > > > > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
> > > > > > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
> > > > > > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > > > > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > > > > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > > > > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
> > > > > > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
> > > > > > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
> > > > > > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
> > > > > > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > > > > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac=
 50 ms nsac 0
> > > > > > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
> > > > > > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
> > > > > > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> > > > > > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > > > > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac=
 50 ms nsac 0
> > > > > > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
> > > > > > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
> > > > > > [    1.868892] mmc0: error -84 whilst initialising MMC card
> > > > >
> > > > > Alright, so the CMD6 command that tries to switch the card into H=
S200
> > > > > mode is the one that fails.
> > > > >
> > > > > >
> > > > > > I cannot provide more verbose logs. When I enable more it (f.e.=
 file
> > > > > > core.c) the initialization of card was successful.
> > > > >
> > > > > That's an interesting observation!
> > > > >
> > > > > Perhaps the card is still in some kind of busy state, after the C=
MD8
> > > > > has been sent to read the EXT_CSD, when verifying the earlier bus
> > > > > width switch (mmc_compare_ext_csds()).
> > > >
> > > > I'm curious, do you know if there is a command that says if the car=
d
> > > > is busy/ready?
> > >
> > > Yes, the CMD13.
> > >
> > > However, CMD13 is not allowed to be sent for some command sequences.
> > > For example sending CMD6 to switch to HS200 mode, is one case where w=
e
> > > must avoid it.
> > >
> > > For these scenarios, either we rely on the host HW to detect when the
> > > card stop signals busy or we simply insert a delay (according to spec=
)
> > > after sending the CMD6 command.
> > >
> > > >
> > > > >
> > > > > > If you want to see any another logs fell free to ask.
> > > > >
> > > > > Would you mind trying one thing, in a way to narrow down the prob=
lem?
> > > > >
> > > > > Add a delay (msleep() or usleep_range() with some different value=
s up
> > > > > to 50 ms) somewhere after mmc_compare_ext_csds() has been execute=
d,
> > > > > but also before having mmc_select_bus_width() to return the error
> > > > > code?
> > > >
> > > > I've added msleep just before exit point of mmc_select_bus_width() =
and
> > > > observation is following
> > > > * 1ms or 2 ms - failing (time to time it was successfully initializ=
ed)
> > > > * 5 ms - success in all attempts
> > >
> > > Very good!
> > >
> > > Let me post a debug patch in short while, that can try to verify if
> > > the card is busy during this period.
> >
> > Here it is, please give it a try and see what happens.
> >
> > You may also want to run a second test, changing the second parameter
> > to false when calling poll_for_busy(), as that switches from CMD13 to
> > use of the host driver's ->card_busy() callback, when checking for
> > busy.
>
> I've applied the patch and test poll_for_busy() with different
> send_status parameter as you recommend (true/false).
> The outputs are the same
> [    1.526554] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
> [    1.682886] mmc0: mmc_select_hs200 failed, error -84
> [    1.693081] mmc0: error -84 whilst initialising MMC card

Alright, my guess that the card was busy was solely incorrect.

>
> >
> > Kind regards
> > Uffe
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Date: Thu, 29 Aug 2019 09:42:11 +0200
> > Subject: [PATCH] mmc: core: DEBUG for mmc_select_bus_width()
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/mmc.c | 47 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index c8804895595f..ff3a4c166f20 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -975,6 +975,52 @@ static void mmc_set_bus_speed(struct mmc_card *car=
d)
> >         mmc_set_clock(card->host, max_dtr);
> >  }
> >
> > +static void poll_for_busy(struct mmc_card *card, bool send_status)
> > +{
> > +       struct mmc_host *host =3D card->host;
> > +       int err;
> > +       unsigned long timeout;
> > +       unsigned int timeout_ms =3D 5000;
> > +       u32 status =3D 0;
> > +       bool expired =3D false;
> > +       bool busy =3D false;
> > +
> > +       if (!send_status && !host->ops->card_busy) {
> > +               mmc_delay(timeout_ms);
>
> fyi this code hasn't been executed.

Yeah, thanks, expected.

>
> > +               return;
> > +       }
> > +
> > +       timeout =3D jiffies + msecs_to_jiffies(timeout_ms) + 1;
> > +       do {
> > +               expired =3D time_after(jiffies, timeout);
> > +               if (send_status) {
> > +                       err =3D __mmc_send_status(card, &status, 0);
>
> I've added some print here as well to see whats the value of the status
>
> +                       printk("%s: %s status=3D0x%x
> R1_CURRENT_STATE(status)=3D0x%x \n",
> +                               mmc_hostname(host),__func__, status,
> R1_CURRENT_STATE(status));

Great!

>
> [    1.676970] mmc0: poll_for_busy status=3D0x900 R1_CURRENT_STATE(status=
)=3D0x4

This means the card reports that it's "READY_FOR_DATA" and the current
state is the transfer state.

Nothing weird is going on at card side, it seems.

> [    1.685821] mmc0: mmc_select_hs200 failed, error -84
> [    1.698029] mmc0: error -84 whilst initialising MMC card

I am out of ideas. :-(

Perhaps the meson developers can think of something? Could it be that
the driver isn't behaving as it should when switching bus width? Maybe
something happens on pinctrl level?

Anyway, if no progress is made the next few days, let's do the revert.
And thanks a lot for helping out with the tests, etc!

Kind regards
Uffe
