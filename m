Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A7E264D8
	for <lists+linux-mmc@lfdr.de>; Wed, 22 May 2019 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfEVNhO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 22 May 2019 09:37:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34860 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfEVNhN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 May 2019 09:37:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so2269469wmj.0;
        Wed, 22 May 2019 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8QAw2c8POPcw9M+FmO7v1o4TuJoS6Dguovex4Yvqdw=;
        b=u/hVQXEv8h6KIqQIaBU3qhTZxpkwI6LnpME2Xl2UxM+ttnwlQDYAtE1uAlH5PlRE7E
         4ZvkE3v8hFsLj/4m543A6S+ytUsNqMmTU4nKe9MUa2VLMh5O/Nfa/GRbKWjYzrRFRctz
         L/hO+HautxLwwft+gnrbfUz56INcYToiikYMbzCnFAHschAZQ0L34A/3NfWsMCH8Jzot
         cIz7EAQoDP9tu7TzfMw/YBr9h5+y5cfQ9IY5zD7KtVrN/WDgRuCv9d15nloOUgErUnA9
         agSfz49x2t1GlRHs/5zRelhUKMosxD3sHtjiBk+NXktgp+fy5ZHZ07lgaAz5e+s1CiFI
         P8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8QAw2c8POPcw9M+FmO7v1o4TuJoS6Dguovex4Yvqdw=;
        b=Y3WQl6GX97I9XuDpUi3/YfSqTJd0F7EEnwPxYUmD5McPn34dl6vngA7gLMFTLv2Ylt
         4nou0IkpXGBIaubJL3v5j50R5VmUfN1HxJQ19akvSInt+sGNLpkvL3Hjc4GBUEYNzueP
         Qe1Mu4Z+HxKLrF0ncQEEYZn8pAS6zt81iG7ES0OplzTv6VtqCcasxMaI9POA7NUzFpsY
         mU0bh8Mdvk7UeQdqXTCjiX+SIb+Anq6rkcv6uFnw32I9/RkaOzOeIIbt5fDyDeMHjrPU
         xX62npoOQs5WrC8G/aqVZn5At8NifbvryiwFoyqfvzBRy4jcETdYc1v/D4ecxnLWR5ho
         8SfQ==
X-Gm-Message-State: APjAAAUeLBoCtsdm/U9GAz1d4F4FXL6+AvAdoLkFWRBtE7qIStdQYrvV
        4wCuP1MlGF1hFsEzGx/K95o=
X-Google-Smtp-Source: APXvYqyXlhyhv2eKEaHJe63vzXwThaEdnBRJf2May122A2aR5lOo+HkxUi47wkxoy8VE+Mz9ztwnJw==
X-Received: by 2002:a7b:c8d1:: with SMTP id f17mr7954380wml.45.1558532231380;
        Wed, 22 May 2019 06:37:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id 91sm38111925wrs.43.2019.05.22.06.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:37:10 -0700 (PDT)
Date:   Wed, 22 May 2019 15:37:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: tegra: Fix a warning message
Message-ID: <20190522133709.GP30938@ulmo>
References: <20190515093512.GD3409@mwanda>
 <CAPDyKFpm9dB55aCUQkDHgyfcJdniNG9jCbdQ4ezYgQ=L8Rxfhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fjEAjMKpll6GDq3U"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpm9dB55aCUQkDHgyfcJdniNG9jCbdQ4ezYgQ=L8Rxfhw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--fjEAjMKpll6GDq3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 01:46:40PM +0200, Ulf Hansson wrote:
> On Wed, 15 May 2019 at 11:35, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
> >
> > The WARN_ON() macro takes a condition, not a warning message.  I've
> > changed this to use WARN(1, "msg...
> >
> > Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
> > index f608417ae967..10d7aaf68bab 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -865,7 +865,7 @@ static void tegra_sdhci_tap_correction(struct sdhci=
_host *host, u8 thd_up,
> >         }
> >
> >         if (!first_fail) {
> > -               WARN_ON("no edge detected, continue with hw tuned delay=
=2E\n");
> > +               WARN(1, "no edge detected, continue with hw tuned delay=
=2E\n");
>=20
> Not sure why this is a WARN*() in the first place.
>=20
> Seems like a dev_warn() or possibly a dev_warn_once() should be used inst=
ead.

I think this was on purpose in order to increase the likelihood of this
getting reported. Sowjanya knows the details much better, but I think
this is supposed to be very rare and really a problem with the tap
settings in device tree, which is something that we want to know and
fix.

Let's see if Sowjanya can shed some light on this.

Thierry

>=20
> >         } else if (first_pass) {
> >                 /* set tap location at fixed tap relative to the first =
edge */
> >                 edge1 =3D first_fail_tap + (first_pass_tap - first_fail=
_tap) / 2;
> > --
> > 2.20.1
> >
>=20
> Kind regards
> Uffe

--fjEAjMKpll6GDq3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlUIUACgkQ3SOs138+
s6F0QBAAksTLDfO6VjZcZqb180eRJWMpz5Zg5LuPq79lhM3L/YixfAft1l9u9EYt
aej5HRvxbsp0ZrpwO6FFjHZr10rw3WXPY/Z4p4SlavggxlQ0kq47XQoanSEs9gfC
A3Ev5r7M7dsOMc4vd/N7f+DC5CHjJPRkAmi7njT/dg0fH2h97W0NW8B9N4KQZTqW
+Wtsl3HK2Vjv32Tx9X0fZ0GfWqjx47dSfpk4jb6LkhAM2LSK/ip5fg9WT5ozXglR
vftiC+qx3Jjteq2+jZHfTNNeimNfhmlAcSketbeT2eCMWhV/oSuAKJgsy7NOUymK
LowtGaMghq20BdtFLgL74xLfsv+o82EKC5+6PBciordFByXvke/oCxhxvFjiUFgM
REc9bprAT7xyX21txizEXvLu7s6RLpu9U3tHQG6l4vGm2I34w+uSjTt3D40qc36u
hoJhdWiIaiSPrCTUd3kbUxZu3RVL99Q+XMYivWp+n1p2H/NjVnB9CCUrRO1XD7CR
4u/54xfY7PlwoYtLdwlwreBFKqZIM3OV4oePV0L5C7yJOPd3x/o2nrKAXbiIDzO0
Z+YxyTKsL4s8FuUxD87yeLtOPGrLrJUoDPzfH3VfCsHPNGB1fyvOt5FVkpu4D4eq
Y2eTDAVS3Nfd0Lt1aTGIkSMA8mv9IRwW3xHXV+vzFNJs2huUc64=
=moWN
-----END PGP SIGNATURE-----

--fjEAjMKpll6GDq3U--
