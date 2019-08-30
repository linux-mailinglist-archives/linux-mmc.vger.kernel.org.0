Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC46A3490
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfH3KBO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 06:01:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41918 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3KBO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 06:01:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id z9so2109465edq.8
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTqPN6MZ10DrrJyZghufx7Iwh6EHaFBU91HP6r8ncZs=;
        b=F2iaCWyjGCFqbhvN1hLO7OW+lOmW9TnG+KTYd+t9Yib3lEy1Yw8fWh8pbqr8ohncFv
         5pnUsq8NZAhG3pVHWEZjMY0o9XbrQ5lR0vWLlLPGPsM8sXJYYWHD1xAzKqRrMhjyeo53
         fzMadCEm6G/3jsRewiWfLJgDvfSrci0Z1Sqcb9ABvtxwiqmDI5WwqSpikXnWTQ5q5G5B
         v6fwWutYGBqO/I43ejvsu3JObefNYkAoX2XILhMp9FA13yD9eH/119ZpB0CQZqK9OFlO
         uAaMO+fN0/rDcz27SOaO7IeJVh8VtqXuLSMtwH+dVv7SQHKqXYZKV/w1Ka+0GjWNUxIb
         NJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTqPN6MZ10DrrJyZghufx7Iwh6EHaFBU91HP6r8ncZs=;
        b=i+X51P/lcPRdPdy/2XNKDDP8e5hDRsVuBrMjuQ7Ntow8YAiqe+3mLVB8rkuo8iAEH2
         XbbPrbmj80sdtGsTmjjy8/V1fq6pZVcI6Lqpv/zVhwySRCOyYjnYWMoc3qGOgKyYoM+L
         TIrEzB7j4Oon4U/pYJPeORRpIeQCne28Q1/wmFigxJg8q3EZSHrbzyN/S14kCRdyURbP
         N7eY0y2esrOpUW87PE4TYJG4nQL8xl6K8L3aqNeVSKmTcLYIQlehEfPuGMYzxWYAZfXa
         HKd4sGfBJoHspHxddgzgSPua6yes9NiQEwdZz2+Czei86Su88Bue6pTOTkfIG2ZNvUg3
         RxXA==
X-Gm-Message-State: APjAAAWxjjx3dwbn6S5LFmm/dRmk4MjBRbshC5OaAd22H5oyDWt9rhho
        jNmPBUHkhiOWGclAluGfdsKeJ+DqaLRfg4i0F0Dmsm+D
X-Google-Smtp-Source: APXvYqy36jlw7V6dVEV98WcDkNtD2S7/ZEp2e4qS0mK3qopkqbxbE59ULiOrsJ3zBqw6dwQR0HexYvHg91M/TQhaDPs=
X-Received: by 2002:a17:906:4b15:: with SMTP id y21mr12534885eju.57.1567159271943;
 Fri, 30 Aug 2019 03:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
 <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
 <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
 <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com>
 <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com>
 <CAPDyKFpatR0q+uO4Q-xcfAWVRTnc3Wp+_oDqECepk_FiLM1kBQ@mail.gmail.com> <CAPDyKFrHvgcXy5PnsiOD=Oo09JNTM2uQ6BCTzhMNsFu=f7V7RA@mail.gmail.com>
In-Reply-To: <CAPDyKFrHvgcXy5PnsiOD=Oo09JNTM2uQ6BCTzhMNsFu=f7V7RA@mail.gmail.com>
From:   Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Fri, 30 Aug 2019 12:01:00 +0200
Message-ID: <CAPnxhu53o=MB9NuXrVKB_WzvsLTbBByj7z_M6wFuQzas4FQrSQ@mail.gmail.com>
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

On Thu, Aug 29, 2019 at 9:50 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 28 Aug 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 27 Aug 2019 at 17:55, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrot=
e:
> > >
> > > On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
> > > >
> > > > On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.com> =
wrote:
> > > > >
> > > > > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.hans=
son@linaro.org> napsal:
> > > > > >
> > > > > > + some meson driver folkz
> > > > > >
> > > > > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hanss=
on@linaro.org> napsal:
> > > > > > > >
> > > > > > > > + Chaotian Jing
> > > > > > > >
> > > > > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote=
:
> > > > > > > > >
> > > > > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > > > > > > >
> > > > > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35=
f1a.
> > > > > > > > >
> > > > > > > > > Turns out the patch breaks initialization of Toshiba THGB=
MNG5.
> > > > > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > > > > > > [    1.648988] mmc0: error -84 whilst initialising MMC ca=
rd
> > > > > > > >
> > > > > > > > For exactly this reason, when getting CRC errors on the fir=
st attempt,
> > > > > > > > doing a retry makes little sense.
> > > > > > > >
> > > > > > > > I have looped in Chaotian who has some more details about t=
he problem.
> > > > > > > >
> > > > > > > > In any case, Jan, what HW and mmc controller are you using?
> > > > > > >
> > > > > > > It's a custom board based on Amlogic A113D. The compatibility=
 in dts
> > > > > > > is set to "alogic,meson-axg-mmc".
> > > > > >
> > > > > > Good. I have looped in some of the relevant developers/maintain=
ers.
> > > > > >
> > > > > > >
> > > > > > > In the different revision of HW we are using Kingston EMMC04G=
. The
> > > > > > > card has no such problem and is working fine without this pat=
ch.
> > > > > > > We observed it only on mention Toshiba card.
> > > > > >
> > > > > > I see. Of course it would also be interesting to see what CMD6 =
command
> > > > > > that is that fails. Would you mind adding some debug/trace to f=
ind out
> > > > > > what command it is that fails?
> > > > >
> > > > > Providing a log with following debug option  `dyndbg=3D"func mmc_=
mrq_pr_debug +p`
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > # dmesg | grep mmc0
> > > > > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
> > > > > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
> > > > > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > > > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
> > > > > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
> > > > > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
> > > > > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
> > > > > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> > > > > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
> > > > > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > > > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
> > > > > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
> > > > > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
> > > > > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
> > > > > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
> > > > > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > > > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 5=
0 ms nsac 0
> > > > > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
> > > > > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
> > > > > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> > > > > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
> > > > > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 5=
0 ms nsac 0
> > > > > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
> > > > > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
> > > > > [    1.868892] mmc0: error -84 whilst initialising MMC card
> > > >
> > > > Alright, so the CMD6 command that tries to switch the card into HS2=
00
> > > > mode is the one that fails.
> > > >
> > > > >
> > > > > I cannot provide more verbose logs. When I enable more it (f.e. f=
ile
> > > > > core.c) the initialization of card was successful.
> > > >
> > > > That's an interesting observation!
> > > >
> > > > Perhaps the card is still in some kind of busy state, after the CMD=
8
> > > > has been sent to read the EXT_CSD, when verifying the earlier bus
> > > > width switch (mmc_compare_ext_csds()).
> > >
> > > I'm curious, do you know if there is a command that says if the card
> > > is busy/ready?
> >
> > Yes, the CMD13.
> >
> > However, CMD13 is not allowed to be sent for some command sequences.
> > For example sending CMD6 to switch to HS200 mode, is one case where we
> > must avoid it.
> >
> > For these scenarios, either we rely on the host HW to detect when the
> > card stop signals busy or we simply insert a delay (according to spec)
> > after sending the CMD6 command.
> >
> > >
> > > >
> > > > > If you want to see any another logs fell free to ask.
> > > >
> > > > Would you mind trying one thing, in a way to narrow down the proble=
m?
> > > >
> > > > Add a delay (msleep() or usleep_range() with some different values =
up
> > > > to 50 ms) somewhere after mmc_compare_ext_csds() has been executed,
> > > > but also before having mmc_select_bus_width() to return the error
> > > > code?
> > >
> > > I've added msleep just before exit point of mmc_select_bus_width() an=
d
> > > observation is following
> > > * 1ms or 2 ms - failing (time to time it was successfully initialized=
)
> > > * 5 ms - success in all attempts
> >
> > Very good!
> >
> > Let me post a debug patch in short while, that can try to verify if
> > the card is busy during this period.
>
> Here it is, please give it a try and see what happens.
>
> You may also want to run a second test, changing the second parameter
> to false when calling poll_for_busy(), as that switches from CMD13 to
> use of the host driver's ->card_busy() callback, when checking for
> busy.

I've applied the patch and test poll_for_busy() with different
send_status parameter as you recommend (true/false).
The outputs are the same
[    1.526554] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.682886] mmc0: mmc_select_hs200 failed, error -84
[    1.693081] mmc0: error -84 whilst initialising MMC card

>
> Kind regards
> Uffe
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Thu, 29 Aug 2019 09:42:11 +0200
> Subject: [PATCH] mmc: core: DEBUG for mmc_select_bus_width()
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8804895595f..ff3a4c166f20 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -975,6 +975,52 @@ static void mmc_set_bus_speed(struct mmc_card *card)
>         mmc_set_clock(card->host, max_dtr);
>  }
>
> +static void poll_for_busy(struct mmc_card *card, bool send_status)
> +{
> +       struct mmc_host *host =3D card->host;
> +       int err;
> +       unsigned long timeout;
> +       unsigned int timeout_ms =3D 5000;
> +       u32 status =3D 0;
> +       bool expired =3D false;
> +       bool busy =3D false;
> +
> +       if (!send_status && !host->ops->card_busy) {
> +               mmc_delay(timeout_ms);

fyi this code hasn't been executed.

> +               return;
> +       }
> +
> +       timeout =3D jiffies + msecs_to_jiffies(timeout_ms) + 1;
> +       do {
> +               expired =3D time_after(jiffies, timeout);
> +               if (send_status) {
> +                       err =3D __mmc_send_status(card, &status, 0);

I've added some print here as well to see whats the value of the status

+                       printk("%s: %s status=3D0x%x
R1_CURRENT_STATE(status)=3D0x%x \n",
+                               mmc_hostname(host),__func__, status,
R1_CURRENT_STATE(status));

[    1.676970] mmc0: poll_for_busy status=3D0x900 R1_CURRENT_STATE(status)=
=3D0x4
[    1.685821] mmc0: mmc_select_hs200 failed, error -84
[    1.698029] mmc0: error -84 whilst initialising MMC card

best regards,
Jan


> +                       if (err) {
> +                               busy =3D true;
> +                               pr_err("%s: failed to get card status
> err=3D%d! %s\n",
> +                                       mmc_hostname(host), err, __func__=
);
> +                               continue;
> +                       }
> +                       busy =3D R1_CURRENT_STATE(status) =3D=3D R1_STATE=
_PRG;
> +               } else {
> +                       busy =3D host->ops->card_busy(host);
> +               }
> +
> +               if (expired && busy) {
> +                       pr_err("%s: Card stuck being busy! %s\n",
> +                               mmc_hostname(host), __func__);
> +                       return;
> +               }
> +
> +               if (busy)
> +                       pr_err("%s: card temporary busy! %s\n",
> +                               mmc_hostname(host), __func__);
> +
> +       } while (busy);
> +
> +       return;
> +}
> +
>  /*
>   * Select the bus width amoung 4-bit and 8-bit(SDR).
>   * If the bus width is changed successfully, return the selected width v=
alue.
> @@ -1036,6 +1082,7 @@ static int mmc_select_bus_width(struct mmc_card *ca=
rd)
>
>                 if (!err) {
>                         err =3D bus_width;
> +                       poll_for_busy(card, true);
>                         break;
>                 } else {
>                         pr_warn("%s: switch to bus width %d failed\n",
> --
> 2.17.1
