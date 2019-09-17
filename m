Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EAAB54E8
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfIQSIT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 14:08:19 -0400
Received: from sauhun.de ([88.99.104.3]:55498 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfIQSIS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 14:08:18 -0400
Received: from localhost (p54B331E4.dip0.t-ipconnect.de [84.179.49.228])
        by pokefinder.org (Postfix) with ESMTPSA id CD1592C0489;
        Tue, 17 Sep 2019 20:08:15 +0200 (CEST)
Date:   Tue, 17 Sep 2019 20:08:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] Revert "mmc: tmio: move runtime PM enablement to the
 driver implementations"
Message-ID: <20190917180805.GA28182@ninjato>
References: <20190913094053.20753-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190913094053.20753-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 11:40:53AM +0200, Ulf Hansson wrote:
> This reverts commit 7ff213193310ef8d0ee5f04f79d791210787ac2c.
>=20
> It turns out that the above commit introduces other problems. For example,
> calling pm_runtime_set_active() must not be done prior calling
> pm_runtime_enable() as that makes it fail. This leads to additional
> problems, such as clock enables being wrongly balanced.
>=20
> Rather than fixing the problem on top, let's start over by doing a revert.
>=20
> Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver=
 implementations")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

For the record, for all three patches:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

eMMC and both SD card slots operate normally on Renesas R-Car H3 ES2.0
and M3-N. clk_summary looks normal, too, but I just glimpsed that
because Geert already provided details.


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2BIQEACgkQFA3kzBSg
KbbJsg//cTMGU+Nol8FhlNc2YrXDdPggNa8MpyBoVqET+aD24UgrPnHd+CAjvDuv
uc7zqpj5vAPB9LbBVTK02umj5yk33fyzfPSUQWnGZ6PKRGmBj7+0NVy9fgfGOZDr
l9sgdYPv2GcssgNo2MWNWFSVtSIoFoTui5au/NVRZl0mgVAvED42FlI3pSwozlch
ZRtDfb6eytudUsmpm3vLDQojKumh//BjEEfvE6q69JVYQBgWPF0zcKmE4ZwhaCqr
bLtko/NAFX1KBlWhJwCzUU4ZQE3Z/8yJ6g3wQGvdG7P7gAswzApwagnqDXe/D6da
ovqEotmYrPozdynklBiS3hoaNkJASPq0BHdua/vSt5XvgSGANm5baiqTvF+IiRqs
8mX2LqZI4CreZDmNrJ+0yXHM8A+7l5rl479NzQ79/K46HHfYMMv/tRXxqExkabio
ucy4whSy2mQCxF1NEQ0+vbHNg00vL39tEib+pSPp6V3QGPU/wwB6Btso/vYznoQP
z57DGakmieA1aHLeaZD/fyHeUehVTrwPhVeYvWi5uwC45RM/L/VRbf/gxy05zWr+
9VPazePFsL80rRn6DDDRynX3sp4VagQlvq9qb36mb84iIu5+UIeWbmq9Fhd8dCNV
NFqGyopDm/7HfkuDzwzzPYgGqH9sQbsB/OM/fOlrtkrCmWO5wcc=
=UZj7
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
