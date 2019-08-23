Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDA9AB76
	for <lists+linux-mmc@lfdr.de>; Fri, 23 Aug 2019 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfHWJgl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 23 Aug 2019 05:36:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32841 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfHWJgl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2019 05:36:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id s15so12563072edx.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2019 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lJohKxt7HKeqbj8j8u5AtSNA+WhFifixJ3L1Mshg4do=;
        b=kQ6PdbD87959nuxSftScU9BIh8wAk+282ap4hVCwPHymX9NinvpMcf/w+Zhlorm49w
         6sheT1MT4L3bhgxu8DKGz//v8rJDwXNlQHZijTYvE/hWy4Z/srrdTibF8zLMqGe4mGer
         IP4aFgGrp6Mr3YqgLi/7zF9SO6f69uX6NDFKugZpl1MiEWvWHOP9x7tbL1JJTLa32SYY
         NaHf1SGUNkZkeGQcpefTzP5Fp/EhSvpydYpIIpcjapJYFEsfgyZNxKhkpOeIdrFqsUHf
         A0Le2NVIoAZRSRjUnhPTbqGuFtU6hCs9gAEQ5j8o0Xbpbl5WkyIE+vHxuQOl5W1aiF4q
         4yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lJohKxt7HKeqbj8j8u5AtSNA+WhFifixJ3L1Mshg4do=;
        b=Ye2jDEgDJKvEoDEaJ+ZUQ/arJNEU9QyfGuJ3DhxSkCfcwrKMDV1ebvsxw3aiOTcduI
         Pyc4iefWc98F697htMCeB717beTtdS5B3BJpjOmMsu4NQFZT1PfPI6hmUqpCiNdmQUhn
         RYlkKYNutgbWd3Zc+dg8cS3ZtPCrcGXQ2y5LLb+LqrCy8URCgW7E82X+9yecuHRM6VUf
         4T98TqjSeQy8EZiWZZcuLFMXiru2PE9GbkAM4ivpCheoIIOvL0kXZ3uw27L6oo7cjvo/
         cPShAPmlmayFnjT/r5tx5nDzIW6gaj46U6w0uaNM1Pw4TNMGfibEmRG+TCgVRMAH1IdL
         Ds8Q==
X-Gm-Message-State: APjAAAVup69bF75xTrc32IBxzj4O86xyMASNL2m07fkmkcyAbvJrH6ig
        iRQK7jIY0rkN5w1qvNtWz2TZ9qn9KFJiJqiBJYo=
X-Google-Smtp-Source: APXvYqyC0aXA7w6V/6OXAWEQQrqqx7KhCgf1auZ9SmWWRa8poI84B7suWHZwelABoO+26uyn98R2NMfjf5dFsxUCGDg=
X-Received: by 2002:a17:906:358e:: with SMTP id o14mr3236184ejb.73.1566552999041;
 Fri, 23 Aug 2019 02:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com> <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
In-Reply-To: <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
From:   Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Fri, 23 Aug 2019 11:36:27 +0200
Message-ID: <CAPnxhu4DwaxL-eXbwHnes7AJFA2G+zNUHsOvrfsPPVqdW0MV_g@mail.gmail.com>
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

=C4=8Dt 22. 8. 2019 v 15:59 odes=C3=ADlatel Ulf Hansson <ulf.hansson@linaro=
.org> napsal:
>
> + some meson driver folkz
>
> On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
> >
> > st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@linaro.=
org> napsal:
> > >
> > > + Chaotian Jing
> > >
> > > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> > > >
> > > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > > >
> > > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> > > >
> > > > Turns out the patch breaks initialization of Toshiba THGBMNG5.
> > > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > > [    1.648988] mmc0: error -84 whilst initialising MMC card
> > >
> > > For exactly this reason, when getting CRC errors on the first attempt=
,
> > > doing a retry makes little sense.
> > >
> > > I have looped in Chaotian who has some more details about the problem=
.
> > >
> > > In any case, Jan, what HW and mmc controller are you using?
> >
> > It's a custom board based on Amlogic A113D. The compatibility in dts
> > is set to "alogic,meson-axg-mmc".
>
> Good. I have looped in some of the relevant developers/maintainers.
>
> >
> > In the different revision of HW we are using Kingston EMMC04G. The
> > card has no such problem and is working fine without this patch.
> > We observed it only on mention Toshiba card.
>
> I see. Of course it would also be interesting to see what CMD6 command
> that is that fails. Would you mind adding some debug/trace to find out
> what command it is that fails?

Providing a log with following debug option  `dyndbg=3D"func mmc_mrq_pr_deb=
ug +p`

# dmesg | grep mmc0
[    1.557984] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    1.563989] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    1.575219] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    1.593142] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    1.604439] mmc0: starting CMD5 arg 00000000 flags 000002e1
[    1.623875] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    1.631024] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    1.640221] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    1.646802] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    1.652397] mmc0: starting CMD1 arg 00000000 flags 000000e1
[    1.669894] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
[    1.682925] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
[    1.697073] mmc0: starting CMD1 arg 40ff8080 flags 000000e1
[    1.704327] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    1.722251] mmc0: starting CMD1 arg 40200000 flags 000000e1
[    1.745317] mmc0: starting CMD1 arg 40200000 flags 000000e1
[    1.752813] mmc0: starting CMD2 arg 00000000 flags 00000007
[    1.771731] mmc0: starting CMD3 arg 00010000 flags 00000015
[    1.784771] mmc0: starting CMD9 arg 00010000 flags 00000007
[    1.790433] mmc0: starting CMD7 arg 00010000 flags 00000015
[    1.795691] mmc0: starting CMD8 arg 00000000 flags 000000b5
[    1.800800] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms nsac =
0
[    1.818402] mmc0: starting CMD6 arg 03af0101 flags 0000049d
[    1.818845] mmc0: starting CMD13 arg 00010000 flags 00000195
[    1.824349] mmc0: starting CMD6 arg 03220101 flags 0000049d
[    1.829992] mmc0: starting CMD13 arg 00010000 flags 00000195
[    1.835493] mmc0: starting CMD6 arg 03b70201 flags 0000049d
[    1.841119] mmc0: starting CMD13 arg 00010000 flags 00000195
[    1.846628] mmc0: starting CMD8 arg 00000000 flags 000000b5
[    1.851719] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 50 ms nsac =
0
[    1.860347] mmc0: starting CMD6 arg 03b90201 flags 0000049d
[    1.864421] mmc0: mmc_select_hs200 failed, error -84
[    1.868892] mmc0: error -84 whilst initialising MMC card

I cannot provide more verbose logs. When I enable more it (f.e. file
core.c) the initialization of card was successful.
If you want to see any another logs fell free to ask.

Best regards,
Jan

>
> [...]
>
> Kind regards
> Uffe
