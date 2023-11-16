Return-Path: <linux-mmc+bounces-102-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E627EE213
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Nov 2023 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC081C20A9A
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Nov 2023 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1530FBE;
	Thu, 16 Nov 2023 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lnN9EgIQ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880B135
	for <linux-mmc@vger.kernel.org>; Thu, 16 Nov 2023 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VjTK
	hEJKFxBOzIOPUeGVw1mOj5EUaqPgAJjVG/989Z8=; b=lnN9EgIQxAYtsn1nfDPH
	txlpAQyOe7ElBMIWn/NLfVPy+GtGnpobwBRw2xTKRM7hLAmVyossxbLY4cun2n/p
	OxLMZQp2r7gRa4i/am6ZFgrIWOwDecDsglC+bJ3Fg97XstNXilY4vSVJ1V9tKJhs
	6cG0I/vChvK9/t8UxsH9OIXX4Stxsui5ofaq0yeGponGRBemPhxUsngZBnZAHl7e
	x5nq/LcJLgxM3fp2HUwAHgJFHNDmmkO6bSVHV5yvmtxxk9mMtHhFMISxwJZQnJR+
	V8Bl8l3DizfP+ra9DCn3N8k8/XHbgEw0QoLFgyFinU4bkrRh51CGFB3CFelv1qZZ
	QQ==
Received: (qmail 539594 invoked from network); 16 Nov 2023 15:01:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2023 15:01:00 +0100
X-UD-Smtp-Session: l3s3148p1@n8kMc0UK7NcMur4C
Date: Thu, 16 Nov 2023 09:00:58 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Message-ID: <ZVYgmtxZP7/jGWAt@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96E3kriXuufB2vQk"
Content-Disposition: inline
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--96E3kriXuufB2vQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 08:32:54PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--96E3kriXuufB2vQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVWIJUACgkQFA3kzBSg
KbYKkw/+M0CdqOrnWjDnKX35jk3CPokP12hBzNNr/dLgwqHhAW2ztEH6Z58+oEWQ
OesI9IPl5HU+2Y+lEUNAzGuTwDolMa0zCNa0T8yoSO1gTuxizKZWmBo5F6HQdu6g
qY7jg+z8hJ57bamkXazo8U0jHu6UIGD/jvgYESBI3pKiYkDhwqTf93ZtNuJbh1Y0
Tz67UpwElEfbEneiVz6JFYMTiQAquu9DAW0Ye27P4TbnjYXYKH38hHvPEtI5VhYE
2RGSUooksiXlzR46/3/4OhqvCvzbrDflRaipixrA/YprrD9dAs+6xJWis2OHu1mS
QeS11uuDpp+EhLZHzhYWn7aJcjw0KJdoO4iNpJUKndJBHH6WyFswAkl0/XU1G5s5
43i6fKsOsg9sqDNjEzkbCKHzf/UgA//mGgSzp8WgoJ2mznm/fRy6ngEr/+bJ5xZ3
7Gf1SCTYR9qnisxyn//v7TA7BzPFHtz7A7/Cwio7qUGKe6aC6O9a2pMs8onoHPCZ
TjDM0HQ+HSVsCzNcPYg3nl2ApUnlivKixS23u+hGhJ/2afG2O8rT6ciAzd80crTb
ezbSmSszLItj4zMfwLA4r5NqtpINk7IQnWjr2DiIIli889U/clpX+08nLryOYfsh
XDwnL+hdhLyWD3jOG1DB73xGYOUUgb/hk3KLv6kBdoARshYESaY=
=0kzE
-----END PGP SIGNATURE-----

--96E3kriXuufB2vQk--

