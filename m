Return-Path: <linux-mmc+bounces-5990-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6FEA75F31
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Mar 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A64F167F27
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Mar 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738DD1ADC90;
	Mon, 31 Mar 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SMqo/lfR"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255ED1A072A
	for <linux-mmc@vger.kernel.org>; Mon, 31 Mar 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404742; cv=none; b=AmJkaw5pwAkk7aYh727RwivfrIibJr+9pFTBbGNw7HfNKNZ5U1EnnxS1cCTVexIw+ZBNFqtTdkckFnhSZQyCM2/WKcv7swe3ykymizXlXsK83jiWow20qAiwR3Nlh+FfgWU1RTaOAF++hQlEp6vXNDY9XQlkhA0+Z1EOEZ7ipH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404742; c=relaxed/simple;
	bh=tNR4Q8cdhO0cDwTQ89Rpe0pYrXsa1HjTyroTZsF11e0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EprmgR/HESl7/6Tlw+2etGqev/mmZXKg57IXqIhFFi+kjV6iek0DMHZdu3ZH9chQuFbhhijhQa/Uj/SxZknRB4auS5qgfEJL+UBm/og2OedZCfiiW/xCYvelvuzxFF1VrNkTEYh89OzNR1cgF2wy3mr7CkuDH0vlmnkTAPl8VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SMqo/lfR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=tNR4
	Q8cdhO0cDwTQ89Rpe0pYrXsa1HjTyroTZsF11e0=; b=SMqo/lfRRmbI+RT6asN3
	n1jza5mkl02RL2n+ARuU7sgLnZYb5Gf+VfTzN+sKU5Nrs+6Ju2+IQ3DzGsl0VaN5
	QytmYKMNwOevrGaUjbow8qMXGXKO5z+IBuBpnDzG+oKU6ZuMjLjgi0Hb2whip0PN
	51+jQ5/1exhdJjem7SFPGEw7fqaAo2YpiW2dxHlzyU2QnV6GiI82YB4wYPtvF/jA
	qn+DQrKAN4QGBJoKbUuh+FQgMsPh3ptOo9ubKAXUtReTiHoGWagqI9M3k0CAgUiV
	ysFzQiPR2RVu23FRoHC2HDnqMSYOph5DgHNlPZn0pSmnAk7T5KrZro1UYhD9Rcic
	aA==
Received: (qmail 1129435 invoked from network); 31 Mar 2025 09:05:37 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Mar 2025 09:05:37 +0200
X-UD-Smtp-Session: l3s3148p1@oXQJDJ4xBrBQ8qei
Date: Mon, 31 Mar 2025 09:05:36 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>, ulf.hansson@linaro.org,
	salauyou.ihar@gmail.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix error handling in
 renesas_sdhi_probe
Message-ID: <Z-o-wDYdfdKig5_p@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>,
	ulf.hansson@linaro.org, salauyou.ihar@gmail.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250326220638.460083-1-ruslan.piasetskyi@gmail.com>
 <Z-nAtQ-CZ8zMUWiK@shikoro>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hb6I+YkcuGQRP6Yz"
Content-Disposition: inline
In-Reply-To: <Z-nAtQ-CZ8zMUWiK@shikoro>


--Hb6I+YkcuGQRP6Yz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:07:49AM +0200, Wolfram Sang wrote:
> On Wed, Mar 26, 2025 at 11:06:38PM +0100, Ruslan Piasetskyi wrote:
> > After moving tmio_mmc_host_probe down, error handling has to be
> > adjusted.
> >=20
> > Fixes: 74f45de394d9 ("mmc: renesas_sdhi: register irqs before registeri=
ng controller")
> > Reviewed-by: Ihar Salauyou <salauyou.ihar@gmail.com>
> > Signed-off-by: Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Also:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Hb6I+YkcuGQRP6Yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfqPrwACgkQFA3kzBSg
KbaHghAAtnGmYUaSEALZT2+umgQanfx6c5PsESPug+KB7UeNK64IrTJ1GkDENfcO
qmJdHWp30ymBO1wACwinZvU5+P/OFNe144cG3MhkkxGn46PP6dHDo71HQCVoqafK
tFwr433kvd/3+o3rUYASkcrrdkg4YRIpwiyhTedIpETDTBj9FVuqeTYsw4jbBmj4
oG6v9IOSxKsmAjvwb025Pf9ISrbH1gEz6jiP4eyj7tpgvkAI+9XL1N9smdLe9GAt
OV1xS9nmiYk9W+HhGFTDY5VSoKWlFQRKwjS3y1febnrttczrAhnSzJEONMNVLRvy
hOm/Y9kVHV4ptZoy9oU7gnYfMuHf4bth43oi7TWKUu8Apn54lGWnMK4IjFIlb0nO
QGEfTRc3ab6E76nG3OhG76yZgH1gq0EGv6hX81E3f2juejws+v/zKotUw55gJoax
xxc2ADmy4xJkmPtTzITqJn6tQuUGPDxE5RGIdrQ6Wv1JX4ozHfhjlcl/QTSAKvbB
BI+DRTRHQXhgk4t8Ud+r69mFFO4GTzIu1TRg8btFAg+K/CwVxWvcH+nHtfOPUhtc
E90AQWTCJTVrtb/RiqBZDJVQQUKHc5Yh2R8lJSHsl7qSoW3JdfsOg8v+3iPY5cC3
C595plUaTiY9e4mIh5A/4eEyNjzvFtn16s2oviSxaZfY9fha3yE=
=PNaQ
-----END PGP SIGNATURE-----

--Hb6I+YkcuGQRP6Yz--

