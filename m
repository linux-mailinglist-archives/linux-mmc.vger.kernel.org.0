Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D158F8B2F
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLI7O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 03:59:14 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:42621 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLI7O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 03:59:14 -0500
Received: by mail-ua1-f47.google.com with SMTP id 31so4464525uas.9
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tf2mudZCYNcbKijnx7l8kTR9ghpKz810SOwwndyzloo=;
        b=cBi1XhD0izth7qoDufpZuhLyMbzgjKIertes3s+oTmfIQUcjyLC8nW7YvKMwUZ/Al9
         UuIzrbTfcLHfhcS1agSm4E5e9xzV4StaELnCTzrZmFgfAUu9xlkw6reZZ6QDIR21pmkz
         2TCmzM/P3XZfnY6UuHhqasT074EnDsb/CuuEobGXrsW1IZ1fF8KVfToYsOnG4K6dmuuC
         THbZYKW5WoYK29Lm1OtsYJWZFCM+TzHFu9SoQQ4W/BSff3vARAm6NMYoBRME8PINAAe8
         /BW6SN00vqrBxU3PCxxhw5KTWeIZ+Bi+hg/ePhibVioqHu6mYwP0GFedmy79HOB3a48i
         MXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tf2mudZCYNcbKijnx7l8kTR9ghpKz810SOwwndyzloo=;
        b=WV5kTsN1qKB3BFcNcwGTBb1poPylqrmJB4U6pTdA6pL5VXH85iDCtZhPw8dajUmBIc
         IoNy2tQoRTvlEH04R8kp7W46yyecRftKLi5hNRkeDCCk/AO3cwLupeO/22AafdHb6CCb
         dZgqWAmHmw0omB6UO3eMqji8JVcGCEgFe8ngP0+lqGFNNzTPV+3CTC5/8a9mgvgbeIwJ
         Jm/vC7Lg0bNR21B8ZUyZqPamRWjHJgnmsgPOCaP3G1VfPimLD4e3xe6e6sfV4hhPQcVr
         h6MtXEHByqWN97m/PxRg/LO8To90YwXMBE9UIq1wC7FJOF9GP0hlEiOGc4EpeTTPk7pH
         SkyQ==
X-Gm-Message-State: APjAAAUny/M+cKSL/PsH9LDTm2trWNm777Sr0gKkYCeaJFgJRIhsaqdR
        AvZdYWfx04gIXthfvoQDgWSFrJtj2dF5DcZT8HPJFA==
X-Google-Smtp-Source: APXvYqxFPhWgc8iHkpTuygj7MTTUYu4BcQnzbVKGkW6JXLBaDAutQSmw9xt4FZ9zvOyXuQCGXHtYTV2Sub2XRMdS+zw=
X-Received: by 2002:ab0:648d:: with SMTP id p13mr113924uam.129.1573549153321;
 Tue, 12 Nov 2019 00:59:13 -0800 (PST)
MIME-Version: 1.0
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
 <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com> <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
In-Reply-To: <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 09:58:37 +0100
Message-ID: <CAPDyKFrsQNMhDb3yh4M1EPGtftFrVmHY-pmpR7AbfrXW=xzyyg@mail.gmail.com>
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Nov 2019 at 20:32, Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> Hi Ulf,
>
> Am 11.11.19 um 18:27 schrieb Ulf Hansson:
> > On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wr=
ote:
> >>
> >> Add SDR104 capability and regulators to SD card node.
> >> While at it, fix a typo in lcd pinctrl and remove two
> >> undocumented bindings from pmic.
> >>
> >> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> ---
> >>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++---=
-
> >>  1 file changed, 25 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> index 33df95e384b4..e86a6db54499 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> @@ -135,6 +135,20 @@
> >>                 vin-supply =3D <&vcc_1v8>;
> >>         };
> >>
> >> +       vcc3v0_sd: vcc3v0-sd {
> >> +               compatible =3D "regulator-fixed";
> >> +               enable-active-high;
> >> +               gpio =3D <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> >> +               pinctrl-names =3D "default";
> >> +               pinctrl-0 =3D <&vcc3v0_sd_en>;
> >> +               regulator-name =3D "vcc3v0_sd";
> >> +               regulator-always-on;
> >
> > This looks odd. A GPIO regulator being always on?
>
> This is a standard micro SD card socket that can also be used for
> booting the board. I wanted to be cautious and start
> working with it and several SD cards and explore the capabilities.
>
> On this board nearly all regulators are still continously
> switched on. I plan to remove the always-on properties step
> by step from the regulators when the board runs stable with it's
> components all enbled.
>
> >
> >> +               regulator-boot-on;
> >> +               regulator-min-microvolt =3D <3000000>;
> >> +               regulator-max-microvolt =3D <3000000>;
> >> +               vin-supply =3D <&vcc3v3_sys>;
> >> +       };
> >
> > Assumes this powers an SDIO embedded card. Often those have a specific
> > power sequence, just wanted to make sure the above are really
> > sufficient? No delays or external clock needed?
>
> It's not embedded, just a standard =C2=B5SD plug. It is already enabled
> by mainline U-Boot and ejecting and inserting the card works fine.

Ah, thanks for confirming.

Kind regards
Uffe
