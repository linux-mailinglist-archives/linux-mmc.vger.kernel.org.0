Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272A498DAB
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfHVI16 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 04:27:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38336 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfHVI16 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 04:27:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so6751974edo.5
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dq0F7n0wyJQT8jTu6m+/MooNZlXjFoe/RCOUDpPheqI=;
        b=V5zOU4wfK/4ZG548Cdk/WLnUw1oDTD7X0od/o0ozo81oUNSlkxCDIswq1Z+RRJUDWz
         HNf7QU3dafASISFUQjCHPBiWXR6dLtqR3iL/qrJA2YmpjKkREtpyaMQjjtYt0ATICef6
         6Mdye3ZpmM8ZnrSQlgWsDqF6uIjwAude1WRYMz6OnC5rGHPZUWbJU5xZcixyA4DJWjUc
         ncKFwvl87kshb8SR7wfsGLEi6t7oQF8VL/fdqmyXZ8o2sh+gWQuiaLHYVQiOrf/R5ETD
         EyJMypD6AryMzam7QuxCmu6IYa4pezdSujoHosYC0nQ//ypxh/hYZttryyxezNIUAnfd
         taqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dq0F7n0wyJQT8jTu6m+/MooNZlXjFoe/RCOUDpPheqI=;
        b=mH9AqQpi3cLaggq6JrzmjbY4EyxKHC+oTAqFINrduHvGOoevkOHa2mtJevpq7/60+4
         AUstKUOh73y9OqRoN2yg1hwJuCbzz4XHvrQdr695r06dhE9Rp+fk0F6orCpcbaeIw55D
         Ba4PZrZupGTpSju/+GUQPHJF+NS6JBBQLfP23M5wr52Vyeu/6O4cBVpOvc3a8Fuohum1
         OrU5XCJN6SGBkDCkc/gRZnClY+nHiyh8f16pG2WV7vvFX+xTyro3ySvXTBAIYS6GsKAN
         IMtIlcJGF7tUAmGTT8XwFwA2IXrAe9QQQSirtxh95DYa8H4Rf8w6qfU4YbCGUckhbsTE
         qY9g==
X-Gm-Message-State: APjAAAXugVCHdCHfDTv2MfczY7rjmnBi35/huVdfgaroe4eXlR1sYlAX
        4RsKzVb94DvD1gKvAK/JMSxzAy2fK3rEAwtA8GYFjZ31
X-Google-Smtp-Source: APXvYqxAwPQKKAUGUVtbknT/1OgT0wio9hG2R1waE2F9HwT8bZuv6zRjsqbZw0m8QvvOGh7Aibl+v1Ohsh20Pi2E9w4=
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr19119815ejb.164.1566462476797;
 Thu, 22 Aug 2019 01:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
In-Reply-To: <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
From:   Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Thu, 22 Aug 2019 10:27:45 +0200
Message-ID: <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@linaro.org>=
 napsal:
>
> + Chaotian Jing
>
> On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> >
> > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> >
> > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> >
> > Turns out the patch breaks initialization of Toshiba THGBMNG5.
> > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > [    1.648988] mmc0: error -84 whilst initialising MMC card
>
> For exactly this reason, when getting CRC errors on the first attempt,
> doing a retry makes little sense.
>
> I have looped in Chaotian who has some more details about the problem.
>
> In any case, Jan, what HW and mmc controller are you using?

It's a custom board based on Amlogic A113D. The compatibility in dts
is set to "alogic,meson-axg-mmc".

In the different revision of HW we are using Kingston EMMC04G. The
card has no such problem and is working fine without this patch.
We observed it only on mention Toshiba card.

Best regards,
Jan

>
> >
> > Signed-off-by: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > ---
> >  drivers/mmc/core/mmc_ops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index 74e4364bc9fb..09113b9ad679 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -564,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 =
index, u8 value,
> >         if (index =3D=3D EXT_CSD_SANITIZE_START)
> >                 cmd.sanitize_busy =3D true;
> >
> > -       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +       err =3D mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> >         if (err)
> >                 goto out;
> >
> > --
> > 2.20.1
> >
>
> Kind regards
> Uffe
