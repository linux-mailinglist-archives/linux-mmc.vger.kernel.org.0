Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86A9E8DB
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfH0NO0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 09:14:26 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32791 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfH0NO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 09:14:26 -0400
Received: by mail-vk1-f196.google.com with SMTP id j5so4773223vkc.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b90cA+zGSsdlBYuDxmOyNB0r6NI76QWu2/gmdYiRtJc=;
        b=UBZ7rE/KoKJPWYu+PopvJ7XSDNEQ88xmSeFSKyypVqS0vXC/n5iBNi7sSDRlup/PIk
         JNuC8/DyuWyB4i4UL2eXvGD6pFmCg0B/kjs9MKsjYGfl3dXVFOYG4bSFlQZx+AFyf9mI
         g2wvYmpFP1vcrq1uQ0sn45g+yT5xvqpV/qazxwKZuat2rjYNfWzL1oPUopHkshZDKcxZ
         N92dL2uK0O1N9aYXU9g548zYCIfJMoOnWnw4RX+BG7U1XysfRFOx8rR26zHQTGgkK3g9
         C2sN6UglMn8gW7yTXQpG4KF95j6gh8mpj/6hmizmkmM/0NX8dsYtMseLB7q4EOr6Lmz3
         x2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b90cA+zGSsdlBYuDxmOyNB0r6NI76QWu2/gmdYiRtJc=;
        b=dz+BY872CV2dYmrGj95YbL0sFpD/ShJT8Bt8/fLozAFGt6l5PY1CH+YGv3Kv51397D
         cqJvpyb2IH1hGEN2/A6AFIRs7W0dqw9JwifqHHUR4Yl3PjpJImaEgvWFmcyGMjZB1YCV
         qZzgvg3tSO9luwTTrehvQjpZdn137/dhnrYJF+NoGvqc8N/zQbo/nrVerWLZR1AwkK0M
         4SUbuIvDApotABdFbxSQDBL7TgP89H8tRAHEbEiB3lKn28yuyBsXECSq6QhrH9tTo6L+
         cX7Z4mCedQ4Ts9vMy9EKb9rMfWUCjoPRJiFIhce82AqA7ksBk9q6th5wadws+Uf17O/6
         zxxQ==
X-Gm-Message-State: APjAAAWTAYPxQUTJDDTfDvZo5TN9e6Maa7BBfKBtOJZ68DXLoFTRjfYF
        75BYO0hAT4GJ4J46kbL2mcMkXizMzUNfkbjXxb9Qxw==
X-Google-Smtp-Source: APXvYqz2RmU7rizd5Byjqj/p6Vy1RSGyX+bjyEx11wM5XdDE+9F13ickTpnFpLa4aRNRhxCk9iA6XlR04uZsUCBpnGI=
X-Received: by 2002:ac5:c4f7:: with SMTP id b23mr773696vkl.17.1566911664891;
 Tue, 27 Aug 2019 06:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
 <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com> <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
In-Reply-To: <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:13:48 +0200
Message-ID: <CAPDyKFoZkU5VKCc2uCawizTM_iB=rU=OFpSWRBnzPQKN813-Kw@mail.gmail.com>
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

On Fri, 23 Aug 2019 at 11:36, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
>
> =C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.hansson@lina=
ro.org> napsal:
> >
> > + some meson driver folkz
> >
> > On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrot=
e:
> > >
> > > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@linar=
o.org> napsal:
> > > >
> > > > + Chaotian Jing
> > > >
> > > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> > > > >
> > > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > > >
> > > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> > > > >
> > > > > Turns out the patch breaks initialization of Toshiba THGBMNG5.
> > > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > > [    1.648988] mmc0: error -84 whilst initialising MMC card
> > > >
> > > > For exactly this reason, when getting CRC errors on the first attem=
pt,
> > > > doing a retry makes little sense.
> > > >
> > > > I have looped in Chaotian who has some more details about the probl=
em.
> > > >
> > > > In any case, Jan, what HW and mmc controller are you using?
> > >
> > > It's a custom board based on Amlogic A113D. The compatibility in dts
> > > is set to "alogic,meson-axg-mmc".
> >
> > Good. I have looped in some of the relevant developers/maintainers.
> >
> > >
> > > In the different revision of HW we are using Kingston EMMC04G. The
> > > card has no such problem and is working fine without this patch.
> > > We observed it only on mention Toshiba card.
> >
> > I see. Of course it would also be interesting to see what CMD6 command
> > that is that fails. Would you mind adding some debug/trace to find out
> > what command it is that fails?
>
> Providing a log with following debug option  `dyndbg=3D"func mmc_mrq_pr_d=
ebug +p`

Thanks!

>
> # dmesg | grep mmc0
> [    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
> [    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
> [    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
> [    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> [    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> [    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
> [    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
> [    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
> [    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
> [    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
> [    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
> [    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
> [    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
> [    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms nsa=
c 0
> [    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
> [    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
> [    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
> [    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
> [    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> [    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
> [    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
> [    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms nsa=
c 0
> [    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
> [    1.864421] mmc0: mmc_select_hs200 failed, error -84
> [    1.868892] mmc0: error -84 whilst initialising MMC card

Alright, so the CMD6 command that tries to switch the card into HS200
mode is the one that fails.

>
> I cannot provide more verbose logs. When I enable more it (f.e. file
> core.c) the initialization of card was successful.

That's an interesting observation!

Perhaps the card is still in some kind of busy state, after the CMD8
has been sent to read the EXT_CSD, when verifying the earlier bus
width switch (mmc_compare_ext_csds()).

> If you want to see any another logs fell free to ask.

Would you mind trying one thing, in a way to narrow down the problem?

Add a delay (msleep() or usleep_range() with some different values up
to 50 ms) somewhere after mmc_compare_ext_csds() has been executed,
but also before having mmc_select_bus_width() to return the error
code?

Kind regards
Uffe
