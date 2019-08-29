Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4CA18F4
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH2Lhw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 07:37:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41135 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfH2Lhw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 07:37:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id m62so2163225vsc.8
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=steHU9JTMpLHW7sybl9YQfRLR82mnhptlWwdqUe7Zcg=;
        b=fYlC8+bWZqR6XAfZhhKThI98qPivkoDILLJEWVCGUmMcEVDNau268nO678oYz2Haq6
         bmMtC4uuUu3KJg6bIbm5+boLwf+l8EkdFDEQDvPVjopj0wqLRln09CPb2ryMq76qUEjk
         JZkDX9bIbdu1BwxXgbD/qS8oHYFHEAEgRhmzN8sr/2fnePykHkgDXvor4Gj3bzeixJGZ
         /J5QdyYN1k9gZ83TBf1D2dDUqsjB0C7nWqGs/1GulojlUH4Z/N9Zg1T2OW4XVRrM+kRs
         BBBRW0dxsRpNuV+fNa6bWBpNGxJaiZOH8Yr29ngIVQQugS2pmpPIaUUsxUDI5stbThRr
         SUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=steHU9JTMpLHW7sybl9YQfRLR82mnhptlWwdqUe7Zcg=;
        b=MUWkTSGPdt5Ax224/uVsrrwom8lpRSmpAsIgvfV5wP4+/ydKib3CXX0GhXcMYPYv0x
         67XdJ2ZQ1tv3njJP+fBSxCHgExonJOmHF2KGx96RKY+yuF/QrbkyWu8Ly0p4qa7LWlsE
         pWyxG0Bvmq1V408XHQZ4kU3oGRIA2ItMvJ+iaWasZUA2bW5Fk5XCLlDc11EZFMYU/9Le
         I7ZqPH7Uer+ROq9r3x+GaO36Emrpf9jFIh7KQAcdAb5irBuJBz0Viw8MN3thyCQQ25iL
         suosX423OymDhJ38MeEkuQm1CWci/Qs+p01WFi+5oMU36B1hvprWC0ffGppnlEfFk1l2
         1UOg==
X-Gm-Message-State: APjAAAUpKpeSmez8LS7+8XQl4JkAdJq18Gu6tUnGMUyB4IdbOBa1XWVO
        INCfmO5DDJUDyoxRpbTRjZvY27magUaTsHku0gvsAg==
X-Google-Smtp-Source: APXvYqwNRXIaneirGcWLGuYXd/YuixR4X36HnLqF4jth7rfkzeHfTgzi9mMgWpVzP8+sp931Sn93UV23G6KlVGudVsg=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr5337390vsr.34.1567078671028;
 Thu, 29 Aug 2019 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com> <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
In-Reply-To: <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 13:37:14 +0200
Message-ID: <CAPDyKFp420OaeoedkR=KuX1EMNwOvCkCfJHZPRDXhVz-w8J0mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
To:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 12:52, Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:
>
> El 27/8/19 a las 15:24, Ulf Hansson escribi=C3=B3:> Assuming this should =
go stable as well? Perhaps you can find a
> > relevant commit that we can put as a fixes tag as well?
> >
> > Kind regards
> > Uffe
>
> The most relevant commit I've found that is related to enabling DDR speed=
s
> on H6 boards is this one: https://github.com/torvalds/linux/commit/07bafc=
1e3536a4e3c422dbd13341688b54f159bb .
> But it doesn't address the H6 SoC specifically, so I doubted whether it w=
ould
> be appropiate to mark this patch as fixing it, and opted to not do it. I =
don't
> mind adding that tag if it's appropiate, though :-)

Hard to say what makes sense here, but how about picking this below instead=
?

Fixes: 0a23f1ad88fc ("dt-binding: mmc: sunxi: add H6 compatible (with
A64 fallback)")

>
> On the other hand, I'm not sure that I understood correctly what do you m=
ean by
> this patch going stable, but I might say the changes themselves are stabl=
e and work.
> The only downside I can think of to them is that they are a kind of worka=
round that
> reduces performance on H6 boards and/or eMMC not affected by this problem=
 (are there
> any?), unless device trees are changed.

Adding a stable tag and a fixes tag for the commit, makes maintainers
of stable kernels to try to backport this commit and fix the problem
for "older" kernels.

Kind regards
Uffe
