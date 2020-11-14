Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686A72B29BF
	for <lists+linux-mmc@lfdr.de>; Sat, 14 Nov 2020 01:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKNAQL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Nov 2020 19:16:11 -0500
Received: from www.zeus03.de ([194.117.254.33]:34382 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKNAQK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Nov 2020 19:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Iiq5xVb+KTY5Rlig0NqYvGStDGd5
        LJI9aP5VJcVbL9Q=; b=ET7A49Xjrzo/29T7P/U69v2dMXCi4of87IfeJwmCqTdk
        YPi5ZcQd8Dt/zxs58OQUp4bNPT9crgroZMNXEg73ocAFlskJLN1I/zHPwF5fXPqb
        aTzaI5zlDcSXRpXgldglv+kHiHZSlqxQKbT9zVGY+fzj0G9jv35iPP//kyamx24=
Received: (qmail 3309119 invoked from network); 14 Nov 2020 01:16:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Nov 2020 01:16:06 +0100
X-UD-Smtp-Session: l3s3148p1@EdMlDQa0CN8gAwDPXwoHAD06PZurl1DU
Date:   Sat, 14 Nov 2020 01:15:55 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
Message-ID: <20201114001555.GA7137@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
References: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
 <20201113163846.GF1408970@ulmo>
 <728ad4ee-c5a2-65a6-c037-689bc77acbdf@nvidia.com>
 <20201113195757.GB1416567@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20201113195757.GB1416567@ulmo>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Great, thanks!
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> And perhaps also:
>=20
> Fixes: 5e958e4aacf4 ("sdhci: tegra: Implement Tegra specific set_timeout =
callback")

Thanks! I will check a build report I got (privately) and resend this as
a proper patch.


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+vIbcACgkQFA3kzBSg
KbYGFw//QvBZpJCsMxFj3YMi4p7s0/FybI5noVeuWDpnbPtpChageuDHJ6FcD2Ka
VBWKyZwxzTnI9yZsYpmpOEDshoEV9E2KdrpZo2XfsA5PefhBLcJ+nAsfgcABlwsd
OGRZ0lBzen0VCC5M0jC5QIX5Mvc517XCm/rj+rFxzCppFIKxbwXGMqoEIIMAyPaT
jHrDs1+7w3faiBUm7gRVGkfkteYqk9PQv55Z4e3DfY5al1PdhfPEAPICZwW53PfT
UJBfnVnmJrPgMvS9rS1c03hvWKUnilZfG1ADrVND/OjaFKxB20EFpksgfHJWn9Xg
tT1ehdJBatdVksqcZ6ploLwinbGSFwcrDJsW3W5n7XXG+dY6JYsqO963P0oCBZfW
rTI/WTv86S77Kb2OnIjNAyg1R9MUcgmzOusuK8Z+OXOUnQYKhGthWD5qaqqftaPT
y+who+T3I/VCanHNkLnya6wO1v3oLVagWUPNiy2FLWE2Qo58PEmVCg3n9dp95KdP
+V0vxNq+nzQYc5gG3gOUlLyXFWTONxfrq5ok2GWLS0SZhK9hBLh72JgpeEhgfYdW
udJGucu38olOHXWBGPVQn/xP2zRj+9IA0jpK80A86mwaPh70j602GkXxuIxabpdC
IMmaYbOHNdwMOac9J0cU95JOIXbZqN35YrPspJkUpL5MI8ygE+g=
=baf/
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
