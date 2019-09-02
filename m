Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A7A5213
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Sep 2019 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfIBIo7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 2 Sep 2019 04:44:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35095 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfIBIo6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Sep 2019 04:44:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so2979850wmj.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Sep 2019 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wAQYga6bxUusNLyU++tO1GgH1tiIqBXf1W5wx1x1cKk=;
        b=N36GbIeoiK/JjCCxMR1JafywwXBXU29bBEN6+hQWyLhMt+x1O5yQXa/ZH6YB7OjTfZ
         IzbM9RaPktxAH0mXsiJ90Wt29wJeTSV+KhPi5FL27W6+jZUiy4EjSxFHQRDymTm3FvoM
         V40df0tvFTcZ0L/qbB8AFmoOiSoNwqiwFIgVHH9XeC7bRT1VkkvF9khG6N/26xIMtTNv
         r+kCrPH+nBAPnLS8nL5d+IqBRLOPo3ChdvfvYSUDmz9mwgaaO2Y2/AZuH3kJhz1ULa05
         7ckkzzvVIrpRciMwYrrHCmC6U4oJ9kyVaZXMLOZJe7drlBxQu20o1KiyyfHSjzIEhhjK
         az0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wAQYga6bxUusNLyU++tO1GgH1tiIqBXf1W5wx1x1cKk=;
        b=fpO35mcubB8lK4mfo/hxInMYssbn72ijThIavAHhB8rBJoh2kpdq3y0Mo9fcrpPYq9
         3phSpjED0xaGNZWQXrKBJZxwtUbBXPIZNqUqNJeWVRTF+1JXfTE+D235p4qAZoyvY6hu
         myusLRr0cLw2d47NTQ1Ka6ePrR6z9BPbnpTMVm18GfFr1PmBB3bI2jpnbJFbg8ED8du8
         1EDwTLq0PG8Q2aYuAZKtub3xD30gsTtVN5NC3l6TCDivjzKxmFehfQdnW2riDcful3vb
         J/mGdAP5kUy2ps6IV+t+qWDpPWNdWUggwO6sWQ6wM3C69EHwARrr3NZSH+ShNnACCOxu
         6AiQ==
X-Gm-Message-State: APjAAAXcpJ8Tm4cXQhs5MaoYsy1HtFOXpm9FzdEv586RddEmWdOFQSYO
        Y768ABXRoJntS+OChX/zDhA5XQ==
X-Google-Smtp-Source: APXvYqxyQTWF1nBK90m7Nxq+7w9FhJT2N8+khNEDXgyuvDgbq8ps+0hXD/V+PSlh5PfOBc9UiGj62w==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr12724718wmj.163.1567413894887;
        Mon, 02 Sep 2019 01:44:54 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 2sm15957167wmz.16.2019.09.02.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:44:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jan Kaisrlik <ja.kaisrlik@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
In-Reply-To: <CAPnxhu7JEK1Sx7J0eyj-q71ysATjb79Um0hNi9A3J+OFhynC4Q@mail.gmail.com>
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com> <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com> <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com> <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com> <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com> <CAPnxhu7+fhiNz8URk3+EnQPDs0hO+oKHyMnXC5RT+CwQymd=Pg@mail.gmail.com> <CAPDyKFpatR0q+uO4Q-xcfAWVRTnc3Wp+_oDqECepk_FiLM1kBQ@mail.gmail.com> <CAPDyKFrHvgcXy5PnsiOD=Oo09JNTM2uQ6BCTzhMNsFu=f7V7RA@mail.gmail.com> <CAPnxhu53o=MB9NuXrVKB_WzvsLTbBByj7z_M6wFuQzas4FQrSQ@mail.gmail.com> <CAPDyKFqwhWSFdXDxAodW1iM4_qebPVdZ5TxVCRsTn2dW7WQjBA@mail.gmail.com> <1jv9uevjw7.fsf@starbuckisacylon.baylibre.com> <CAPnxhu7JEK1Sx7J0eyj-q71ysATjb79Um0hNi9A3J+OFhynC4Q@mail.gmail.com>
Date:   Mon, 02 Sep 2019 10:44:53 +0200
Message-ID: <1jpnkjulx6.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon 02 Sep 2019 at 10:28, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:

> On Fri, Aug 30, 2019 at 3:54 PM Jerome Brunet <jbrunet@baylibre.com> wrot=
e:
>>
>> On Fri 30 Aug 2019 at 13:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> > On Fri, 30 Aug 2019 at 12:01, Jan Kaisrlik <ja.kaisrlik@gmail.com> wro=
te:
>> >>
>> >> On Thu, Aug 29, 2019 at 9:50 AM Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
>> >> >
>> >> > On Wed, 28 Aug 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
>> >> > >
>> >> > > On Tue, 27 Aug 2019 at 17:55, Jan Kaisrlik <ja.kaisrlik@gmail.com=
> wrote:
>> >> > > >
>> >> > > > On Tue, Aug 27, 2019 at 3:14 PM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
>> >> > > > >
>> >> > > > > On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail=
.com> wrote:
>> >> > > > > >
>> >> > > > > > =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ul=
f.hansson@linaro.org> napsal:
>> >> > > > > > >
>> >> > > > > > > + some meson driver folkz
>> >> > > > > > >
>> >> > > > > > > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@g=
mail.com> wrote:
>> >> > > > > > > >
>> >> > > > > > > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf=
.hansson@linaro.org> napsal:
>> >> > > > > > > > >
>> >> > > > > > > > > + Chaotian Jing
>> >> > > > > > > > >
>> >> > > > > > > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com>=
 wrote:
>> >> > > > > > > > > >
>> >> > > > > > > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
>> >> > > > > > > > > >
>> >> > > > > > > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd=
281c35f1a.
>> >> > > > > > > > > >
>> >> > > > > > > > > > Turns out the patch breaks initialization of Toshib=
a THGBMNG5.
>> >> > > > > > > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error=
 -84
>> >> > > > > > > > > > [    1.648988] mmc0: error -84 whilst initialising =
MMC card
>> >> > > > > > > > >
>> >> > > > > > > > > For exactly this reason, when getting CRC errors on t=
he first attempt,
>> >> > > > > > > > > doing a retry makes little sense.
>> >> > > > > > > > >
>> >> > > > > > > > > I have looped in Chaotian who has some more details a=
bout the problem.
>> >> > > > > > > > >
>> >> > > > > > > > > In any case, Jan, what HW and mmc controller are you =
using?
>> >> > > > > > > >
>> >> > > > > > > > It's a custom board based on Amlogic A113D. The compati=
bility in dts
>> >> > > > > > > > is set to "alogic,meson-axg-mmc".
>> >> > > > > > >
>> >> > > > > > > Good. I have looped in some of the relevant developers/ma=
intainers.
>> >> > > > > > >
>> >> > > > > > > >
>> >> > > > > > > > In the different revision of HW we are using Kingston E=
MMC04G. The
>> >> > > > > > > > card has no such problem and is working fine without th=
is patch.
>> >> > > > > > > > We observed it only on mention Toshiba card.
>> >> > > > > > >
>> >> > > > > > > I see. Of course it would also be interesting to see what=
 CMD6 command
>> >> > > > > > > that is that fails. Would you mind adding some debug/trac=
e to find out
>> >> > > > > > > what command it is that fails?
>> >> > > > > >
>> >> > > > > > Providing a log with following debug option  `dyndbg=3D"fun=
c mmc_mrq_pr_debug +p`
>> >> > > > >
>> >> > > > > Thanks!
>> >> > > > >
>> >> > > > > >
>> >> > > > > > # dmesg | grep mmc0
>> >> > > > > > [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 0000=
0195
>> >> > > > > > [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 0000=
0195
>> >> > > > > > [    1.575219] mmc0: starting CMD0 arg 00000000 flags 00000=
0c0
>> >> > > > > > [    1.593142] mmc0: starting CMD8 arg 000001aa flags 00000=
2f5
>> >> > > > > > [    1.604439] mmc0: starting CMD5 arg 00000000 flags 00000=
2e1
>> >> > > > > > [    1.623875] mmc0: starting CMD55 arg 00000000 flags 0000=
00f5
>> >> > > > > > [    1.631024] mmc0: starting CMD55 arg 00000000 flags 0000=
00f5
>> >> > > > > > [    1.640221] mmc0: starting CMD55 arg 00000000 flags 0000=
00f5
>> >> > > > > > [    1.646802] mmc0: starting CMD55 arg 00000000 flags 0000=
00f5
>> >> > > > > > [    1.652397] mmc0: starting CMD1 arg 00000000 flags 00000=
0e1
>> >> > > > > > [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 00000=
0e1
>> >> > > > > > [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 00000=
0e1
>> >> > > > > > [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 00000=
0e1
>> >> > > > > > [    1.704327] mmc0: starting CMD0 arg 00000000 flags 00000=
0c0
>> >> > > > > > [    1.722251] mmc0: starting CMD1 arg 40200000 flags 00000=
0e1
>> >> > > > > > [    1.745317] mmc0: starting CMD1 arg 40200000 flags 00000=
0e1
>> >> > > > > > [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000=
007
>> >> > > > > > [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000=
015
>> >> > > > > > [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000=
007
>> >> > > > > > [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000=
015
>> >> > > > > > [    1.795691] mmc0: starting CMD8 arg 00000000 flags 00000=
0b5
>> >> > > > > > [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 =
tsac 50 ms nsac 0
>> >> > > > > > [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 00000=
49d
>> >> > > > > > [    1.818845] mmc0: starting CMD13 arg 00010000 flags 0000=
0195
>> >> > > > > > [    1.824349] mmc0: starting CMD6 arg 03220101 flags 00000=
49d
>> >> > > > > > [    1.829992] mmc0: starting CMD13 arg 00010000 flags 0000=
0195
>> >> > > > > > [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 00000=
49d
>> >> > > > > > [    1.841119] mmc0: starting CMD13 arg 00010000 flags 0000=
0195
>> >> > > > > > [    1.846628] mmc0: starting CMD8 arg 00000000 flags 00000=
0b5
>> >> > > > > > [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 =
tsac 50 ms nsac 0
>> >> > > > > > [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 00000=
49d
>> >> > > > > > [    1.864421] mmc0: mmc_select_hs200 failed, error -84
>> >> > > > > > [    1.868892] mmc0: error -84 whilst initialising MMC card
>> >> > > > >
>> >> > > > > Alright, so the CMD6 command that tries to switch the card in=
to HS200
>> >> > > > > mode is the one that fails.
>> >> > > > >
>> >> > > > > >
>> >> > > > > > I cannot provide more verbose logs. When I enable more it (=
f.e. file
>> >> > > > > > core.c) the initialization of card was successful.
>> >> > > > >
>> >> > > > > That's an interesting observation!
>> >> > > > >
>> >> > > > > Perhaps the card is still in some kind of busy state, after t=
he CMD8
>> >> > > > > has been sent to read the EXT_CSD, when verifying the earlier=
 bus
>> >> > > > > width switch (mmc_compare_ext_csds()).
>> >> > > >
>> >> > > > I'm curious, do you know if there is a command that says if the=
 card
>> >> > > > is busy/ready?
>> >> > >
>> >> > > Yes, the CMD13.
>> >> > >
>> >> > > However, CMD13 is not allowed to be sent for some command sequenc=
es.
>> >> > > For example sending CMD6 to switch to HS200 mode, is one case whe=
re we
>> >> > > must avoid it.
>> >> > >
>> >> > > For these scenarios, either we rely on the host HW to detect when=
 the
>> >> > > card stop signals busy or we simply insert a delay (according to =
spec)
>> >> > > after sending the CMD6 command.
>> >> > >
>> >> > > >
>> >> > > > >
>> >> > > > > > If you want to see any another logs fell free to ask.
>> >> > > > >
>> >> > > > > Would you mind trying one thing, in a way to narrow down the =
problem?
>> >> > > > >
>> >> > > > > Add a delay (msleep() or usleep_range() with some different v=
alues up
>> >> > > > > to 50 ms) somewhere after mmc_compare_ext_csds() has been exe=
cuted,
>> >> > > > > but also before having mmc_select_bus_width() to return the e=
rror
>> >> > > > > code?
>> >> > > >
>> >> > > > I've added msleep just before exit point of mmc_select_bus_widt=
h() and
>> >> > > > observation is following
>> >> > > > * 1ms or 2 ms - failing (time to time it was successfully initi=
alized)
>> >> > > > * 5 ms - success in all attempts
>> >> > >
>> >> > > Very good!
>> >> > >
>> >> > > Let me post a debug patch in short while, that can try to verify =
if
>> >> > > the card is busy during this period.
>> >> >
>> >> > Here it is, please give it a try and see what happens.
>> >> >
>> >> > You may also want to run a second test, changing the second paramet=
er
>> >> > to false when calling poll_for_busy(), as that switches from CMD13 =
to
>> >> > use of the host driver's ->card_busy() callback, when checking for
>> >> > busy.
>> >>
>> >> I've applied the patch and test poll_for_busy() with different
>> >> send_status parameter as you recommend (true/false).
>> >> The outputs are the same
>> >> [    1.526554] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
>> >> [    1.682886] mmc0: mmc_select_hs200 failed, error -84
>> >> [    1.693081] mmc0: error -84 whilst initialising MMC card
>> >
>> > Alright, my guess that the card was busy was solely incorrect.
>> >
>> >>
>> >> >
>> >> > Kind regards
>> >> > Uffe
>> >> >
>> >> > From: Ulf Hansson <ulf.hansson@linaro.org>
>> >> > Date: Thu, 29 Aug 2019 09:42:11 +0200
>> >> > Subject: [PATCH] mmc: core: DEBUG for mmc_select_bus_width()
>> >> >
>> >> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> > ---
>> >> >  drivers/mmc/core/mmc.c | 47 ++++++++++++++++++++++++++++++++++++++=
++++
>> >> >  1 file changed, 47 insertions(+)
>> >> >
>> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> >> > index c8804895595f..ff3a4c166f20 100644
>> >> > --- a/drivers/mmc/core/mmc.c
>> >> > +++ b/drivers/mmc/core/mmc.c
>> >> > @@ -975,6 +975,52 @@ static void mmc_set_bus_speed(struct mmc_card =
*card)
>> >> >         mmc_set_clock(card->host, max_dtr);
>> >> >  }
>> >> >
>> >> > +static void poll_for_busy(struct mmc_card *card, bool send_status)
>> >> > +{
>> >> > +       struct mmc_host *host =3D card->host;
>> >> > +       int err;
>> >> > +       unsigned long timeout;
>> >> > +       unsigned int timeout_ms =3D 5000;
>> >> > +       u32 status =3D 0;
>> >> > +       bool expired =3D false;
>> >> > +       bool busy =3D false;
>> >> > +
>> >> > +       if (!send_status && !host->ops->card_busy) {
>> >> > +               mmc_delay(timeout_ms);
>> >>
>> >> fyi this code hasn't been executed.
>> >
>> > Yeah, thanks, expected.
>> >
>> >>
>> >> > +               return;
>> >> > +       }
>> >> > +
>> >> > +       timeout =3D jiffies + msecs_to_jiffies(timeout_ms) + 1;
>> >> > +       do {
>> >> > +               expired =3D time_after(jiffies, timeout);
>> >> > +               if (send_status) {
>> >> > +                       err =3D __mmc_send_status(card, &status, 0);
>> >>
>> >> I've added some print here as well to see whats the value of the stat=
us
>> >>
>> >> +                       printk("%s: %s status=3D0x%x
>> >> R1_CURRENT_STATE(status)=3D0x%x \n",
>> >> +                               mmc_hostname(host),__func__, status,
>> >> R1_CURRENT_STATE(status));
>> >
>> > Great!
>> >
>> >>
>> >> [    1.676970] mmc0: poll_for_busy status=3D0x900 R1_CURRENT_STATE(st=
atus)=3D0x4
>> >
>> > This means the card reports that it's "READY_FOR_DATA" and the current
>> > state is the transfer state.
>> >
>> > Nothing weird is going on at card side, it seems.
>> >
>> >> [    1.685821] mmc0: mmc_select_hs200 failed, error -84
>> >> [    1.698029] mmc0: error -84 whilst initialising MMC card
>> >
>> > I am out of ideas. :-(
>> >
>> > Perhaps the meson developers can think of something? Could it be that
>> > the driver isn't behaving as it should when switching bus width? Maybe
>> > something happens on pinctrl level?
>>
>> I have not seen this particular issue myself. Since the last round of
>> updates we did a few month ago, things have been quite stable
>>
>> We get our information only from the datasheet and vendor code. These
>> are publicly available and it has proved quite insufficient judging by
>> the number of issue we had in the past years.
>>
>> IOW, we would love to know more about this controller too ;)
>
> Amlogic A113D, Avast Omni - I think you are familiar with this
> particular device :]

The board yes, however I have not seen this error on the samples I have

The controller embedded in the SoC is something else. As mentionned
above, we have the datasheet and the vendor code, That does not tell
us everything, unfortunately.

Most of the time, the SoC erratas, if any, have to be found "the hard
way" ...


>
>>
>> So, to answer your question, AFAIK, there is nothing special regarding
>> bus width switch ...
>>
>> Regarding pinctrl, I think there a bias-pull-up on data line set in DT.
>> Maybe it's worth trying to disable that a see how it goes ?
>
> It did not help.

Not really surprised. Thanks for trying anyway.

>
> Best regards,
> Jan
>
>>
>> OTOH, it this was the problem, I wonder how it could have got this far
>> and why a delay would help ?
>>
>> >
>> > Anyway, if no progress is made the next few days, let's do the revert.
>> > And thanks a lot for helping out with the tests, etc!
>> >
>> > Kind regards
>> > Uffe
