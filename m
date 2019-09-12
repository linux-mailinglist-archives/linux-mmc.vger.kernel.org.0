Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C543B1440
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfILSFu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 14:05:50 -0400
Received: from sauhun.de ([88.99.104.3]:52768 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfILSFu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Sep 2019 14:05:50 -0400
Received: from localhost (234.77.63.94.rev.vodafone.pt [94.63.77.234])
        by pokefinder.org (Postfix) with ESMTPSA id 26A9D2C4EFE;
        Thu, 12 Sep 2019 20:05:48 +0200 (CEST)
Date:   Thu, 12 Sep 2019 19:05:47 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio: Fixup runtime PM management during probe and
 remove
Message-ID: <20190912180547.GD919@kunai>
References: <20190909104649.4960-1-ulf.hansson@linaro.org>
 <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set=
 the
> > status to RPM_ACTIVE for the device, when its been enabled for runtime =
PM.
> >
> > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() inst=
ead.
> > To avoid the device from being runtime suspended during the probe phase,
> > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > Consequentially, each tmio variant driver can decide themselves when to
> > call pm_runtime_put(), to allow the device to become runtime suspended.
> >
> > Additionally, if the tmio variant driver decided to call pm_runtime_put=
()
> > during probe, it's is expected that it also calls pm_runtime_get_sync()=
 to
> > restore the usage count, before it calls tmio_mmc_host_remove().
> >
> > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driv=
er implementations")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> So I decided to apply this for my fixes branch, as to get it tested
> for a few days.
>=20
> If you have any objections, please tell.

Sadly, I can't test until next week because I am still on the road. Yet,
I recall Niklas said at LPC that the patch looks good to him, at least.


--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl16iPsACgkQFA3kzBSg
KbYmqw//ZFp+SyRWkkDgTFKq5Bsfg01se/JlqOz5e1i8tcLTrcrYntWemvnYTQqQ
N7XSrhphtUA1xpn4Yv6W16Q0KnB+3QiJxns2ZUHs1SgLS8I0kRs6Mx8LpVpQ2Bk5
EHdDngQREwnbeBP8G6acQdfhVfNSqIeZ+p646qHZ/83KEPG2Y7ociaI2/8t0Vn5n
HZoekUMMI1hgLICLZuKzG5t7J4sAZ1Aav60+31OhxkIGHrKts2h+jonE8qhWso81
/zh9QG6CeSxfDFGW0HT0v+tyJbfKOiNS1JTIWR5h+Kdenxt3CCzQF2sYJ3Q919Cz
yZNFGEX0qYtwus8Gy6XcjsH/mbfi4SkXSJ7FS4ZOxOcW45W3jjtwMfhXRfKT361w
4keAorXfftaxL/blSNRmxIAX2myG7yfsY8aKn5/avJpYcqecF3r7t8CQ+Xy4tToY
JXwRuRH8/3SzaYNv64NzJQcMN8GKsbsN/BYED1HXQsvi974T0tS9Z6HdMfrw0uLT
1RQx5xO56tWOqEBJqIFlWe3up2jqXh9MWi5r4+/0whgbJsqRUjq8c4U51GSSU/2e
hohFGGF6LxIGT4QGwBavPzFJ8xYpBMhApErvCGPd85DafCKjXvoPoZeoXM1QUq6j
meX4I9L4ZpAxcy6DYTXZydXzdYk5L2eCa+vhDgXY7exmUA7h3u8=
=EIB/
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
